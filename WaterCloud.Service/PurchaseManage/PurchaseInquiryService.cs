using System;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;
using WaterCloud.Code;
using Chloe;
using WaterCloud.Domain.PurchaseManage;
using WaterCloud.Domain.MaterialManage;
using System.Net.Http;
using WaterCloud.Service.SystemManage;

namespace WaterCloud.Service.PurchaseManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2026-08-15
    /// 描 述：采购询价单服务类
    /// </summary>
    public class PurchaseInquiryService : DataFilterService<PurchaseInquiryEntity>, IDenpendency
    {
        private ItemsDataService itemsApp;
        public PurchaseInquiryService(IDbContext context, IHttpClientFactory httpClientFactory) : base(context)
        {
            itemsApp = new ItemsDataService(context);
        }
        #region 获取数据
        public async Task<List<MaterialEntity>> GetMaterialList(string keyword)
        {
            var list = uniwork.IQueryable<MaterialEntity>(a => a.F_DeleteMark == false && a.F_EnabledMark == true && a.F_MaterialType > 0);
            if (!string.IsNullOrEmpty(keyword))
            {
                list = list.Where(t => t.F_MaterialCode.Contains(keyword) || t.F_MaterialName.Contains(keyword));
            }
            return list.ToList();
        }

        public async Task<List<PurchaseInquiryEntity>> GetLookList(SoulPage<PurchaseInquiryEntity> pagination, string keyword = "")
        {
            //已审核流转到采购订单的询价单不再显示
            var query = IQueryable().Where(t => t.F_DeleteMark == false && (t.F_QuoteState == null || t.F_QuoteState != 1));
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(t => t.F_InquiryCode.Contains(keyword)
                || t.F_Supplier.Contains(keyword)
                || t.F_Description.Contains(keyword));
            }
            query = GetDataPrivilege("u", "", query);
            return await repository.OrderList(query, pagination);
        }

        private IQuery<PurchaseInquiryEntity> IQueryable()
        {
            var details = uniwork.IQueryable<PurchaseInquiryDetailEntity>().GroupBy(a => a.F_InquiryId).Select(a => new { a.F_InquiryId, F_NeedNum = Sql.Sum(a.F_NeedNum) });
            var query = repository.IQueryable().InnerJoin(details, (a, b) => a.F_Id == b.F_InquiryId)
                .Select((a, b) => new PurchaseInquiryEntity
                {
                    F_CreatorTime = a.F_CreatorTime,
                    F_CreatorUserId = a.F_CreatorUserId,
                    F_Supplier = a.F_Supplier,
                    F_DeleteMark = a.F_DeleteMark,
                    F_DeleteTime = a.F_DeleteTime,
                    F_DeleteUserId = a.F_DeleteUserId,
                    F_Description = a.F_Description,
                    F_EnabledMark = a.F_EnabledMark,
                    F_Id = a.F_Id,
                    F_LastModifyTime = a.F_LastModifyTime,
                    F_LastModifyUserId = a.F_LastModifyUserId,
                    F_NeedNum = b.F_NeedNum,
                    F_InquiryCode = a.F_InquiryCode,
                    F_InquiryDate = a.F_InquiryDate,
                    F_QuoteState = a.F_QuoteState,
                    F_PurchaseOrderId = a.F_PurchaseOrderId,
                    F_TotalMoney = a.F_TotalMoney
                });
            return query;
        }

        public async Task<PurchaseInquiryEntity> GetForm(string keyValue)
        {
            var data = IQueryable().Where(a => a.F_Id == keyValue).FirstOrDefault();
            data.list = uniwork.IQueryable<PurchaseInquiryDetailEntity>(a => a.F_InquiryId == keyValue)
                .InnerJoin<MaterialEntity>((a, b) => a.F_MaterialId == b.F_Id)
                .Select((a, b) => new PurchaseInquiryDetailEntity
                {
                    F_Id = a.F_Id,
                    F_MaterialCode = b.F_MaterialCode,
                    F_MaterialId = a.F_MaterialId,
                    F_MaterialName = b.F_MaterialName,
                    F_MaterialType = b.F_MaterialType,
                    F_MaterialUnit = b.F_MaterialUnit,
                    F_NeedNum = a.F_NeedNum,
                    F_Price = a.F_Price,
                    F_InquiryId = a.F_InquiryId
                }).ToList();
            return data;
        }

        public async Task<PurchaseInquiryEntity> GetLookForm(string keyValue)
        {
            var data = await GetForm(keyValue);
            return GetFieldsFilterData(data);
        }
        #endregion

        #region 提交数据
        public async Task SubmitForm(PurchaseInquiryEntity entity, string keyValue)
        {
            if (entity == null)
            {
                throw new Exception("提交数据为空，请联系管理员");
            }
            if (entity.list == null)
            {
                entity.list = new List<PurchaseInquiryDetailEntity>();
            }
            if (string.IsNullOrEmpty(keyValue))
            {
                if (string.IsNullOrEmpty(entity.F_InquiryCode))
                {
                    entity.F_InquiryCode = "QI-" + DateTime.Now.ToString("yyyyMMddHHmmss");
                }
                entity.F_DeleteMark = false;
                entity.F_EnabledMark = false;
                entity.Create();
                foreach (var item in entity.list)
                {
                    item.F_Id = Utils.GuId();
                    item.F_InquiryId = entity.F_Id;
                }
                uniwork.BeginTrans();
                await repository.Insert(entity);
                await uniwork.Insert(entity.list);
                uniwork.Commit();
            }
            else
            {
                entity.Modify(keyValue);
                foreach (var item in entity.list)
                {
                    item.F_Id = Utils.GuId();
                    item.F_InquiryId = entity.F_Id;
                }
                uniwork.BeginTrans();
                await repository.Update(entity);
                await uniwork.Delete<PurchaseInquiryDetailEntity>(a => a.F_InquiryId == entity.F_Id);
                await uniwork.Insert(entity.list);
                uniwork.Commit();
            }
        }

        public async Task DeleteForm(string keyValue)
        {
            uniwork.BeginTrans();
            await repository.Delete(a => keyValue == a.F_Id);
            await uniwork.Delete<PurchaseInquiryDetailEntity>(a => keyValue == a.F_InquiryId);
            uniwork.Commit();
        }
        /// <summary>
        /// 审核通过：根据采购询价单生成采购订单
        /// </summary>
        public async Task ApproveForm(string keyValue)
        {
            var inquiry = await repository.FindEntity(keyValue);
            if (inquiry == null)
            {
                throw new Exception("询价单不存在");
            }
            if (inquiry.F_QuoteState == 1)
            {
                throw new Exception("询价单已审核通过，不能重复审核");
            }
            if (!string.IsNullOrEmpty(inquiry.F_PurchaseOrderId))
            {
                throw new Exception("该询价单已生成采购订单，不能重复审核");
            }
            var details = uniwork.IQueryable<PurchaseInquiryDetailEntity>(a => a.F_InquiryId == keyValue).ToList();
            if (details.Count == 0)
            {
                throw new Exception("询价单没有明细，无法审核通过");
            }
            PurchaseOrderEntity order = new PurchaseOrderEntity();
            order.F_PurchaseOrderCode = "PO-" + DateTime.Now.ToString("yyyyMMddHHmmss");
            order.F_Supplier = inquiry.F_Supplier;
            order.F_PlanStartTime = inquiry.F_InquiryDate ?? DateTime.Now;
            order.F_PlanEndTime = (inquiry.F_InquiryDate ?? DateTime.Now).AddDays(30);
            order.F_DayNum = 6;
            order.F_TotalMoney = inquiry.F_TotalMoney;
            order.F_Description = "由询价单" + inquiry.F_InquiryCode + "审核生成";
            order.F_DeleteMark = false;
            order.F_EnabledMark = false;
            order.F_IsFinish = false;
            order.Create();
            List<PurchaseOrderDetailEntity> orderDetails = new List<PurchaseOrderDetailEntity>();
            foreach (var item in details)
            {
                orderDetails.Add(new PurchaseOrderDetailEntity
                {
                    F_Id = Utils.GuId(),
                    F_PurchaseOrderId = order.F_Id,
                    F_MaterialId = item.F_MaterialId,
                    F_NeedNum = item.F_NeedNum,
                    F_Price = item.F_Price
                });
            }
            uniwork.BeginTrans();
            await uniwork.Insert(order);
            await uniwork.Insert(orderDetails);
            await repository.Update(a => a.F_Id == keyValue, a => new PurchaseInquiryEntity
            {
                F_QuoteState = 1,
                F_PurchaseOrderId = order.F_Id
            });
            uniwork.Commit();
        }
        #endregion
    }
}
