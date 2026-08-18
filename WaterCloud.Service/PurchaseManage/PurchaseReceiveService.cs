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
    /// 描 述：采购收货单服务类
    /// </summary>
    public class PurchaseReceiveService : DataFilterService<PurchaseReceiveEntity>, IDenpendency
    {
        private ItemsDataService itemsApp;
        public PurchaseReceiveService(IDbContext context, IHttpClientFactory httpClientFactory) : base(context)
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

        public async Task<List<PurchaseOrderEntity>> GetOrderList(string keyword = "")
        {
            var list = uniwork.IQueryable<PurchaseOrderEntity>(a => a.F_DeleteMark == false && a.F_EnabledMark == true && a.F_IsFinish == false);
            if (!string.IsNullOrEmpty(keyword))
            {
                list = list.Where(t => t.F_PurchaseOrderCode.Contains(keyword) || t.F_Supplier.Contains(keyword));
            }
            return list.OrderByDesc(t => t.F_CreatorTime).ToList();
        }

        public async Task<List<PurchaseReceiveEntity>> GetLookList(SoulPage<PurchaseReceiveEntity> pagination, string keyword = "")
        {
            //已流转到采购退货单的收货单不再显示
            var returnedIds = uniwork.IQueryable<PurchaseReturnEntity>(a => a.F_DeleteMark == false && a.F_ReceiveId != null).Select(a => a.F_ReceiveId).Distinct().ToList();
            var query = IQueryable().Where(t => t.F_DeleteMark == false && !returnedIds.Contains(t.F_Id));
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(t => t.F_ReceiveCode.Contains(keyword)
                || t.F_Supplier.Contains(keyword)
                || t.F_Description.Contains(keyword));
            }
            query = GetDataPrivilege("u", "", query);
            return await repository.OrderList(query, pagination);
        }

        private IQuery<PurchaseReceiveEntity> IQueryable()
        {
            var details = uniwork.IQueryable<PurchaseReceiveDetailEntity>().GroupBy(a => a.F_ReceiveId).Select(a => new { a.F_ReceiveId, F_NeedNum = Sql.Sum(a.F_NeedNum) });
            var query = repository.IQueryable().InnerJoin(details, (a, b) => a.F_Id == b.F_ReceiveId)
                .Select((a, b) => new PurchaseReceiveEntity
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
                    F_PurchaseOrderId = a.F_PurchaseOrderId,
                    F_ReceiveCode = a.F_ReceiveCode,
                    F_ReceiveDate = a.F_ReceiveDate,
                    F_TotalMoney = a.F_TotalMoney
                });
            return query;
        }

        public async Task<PurchaseReceiveEntity> GetForm(string keyValue)
        {
            var data = IQueryable().Where(a => a.F_Id == keyValue).FirstOrDefault();
            if (data != null && !string.IsNullOrEmpty(data.F_PurchaseOrderId))
            {
                data.F_PurchaseOrderCode = uniwork.IQueryable<PurchaseOrderEntity>(a => a.F_Id == data.F_PurchaseOrderId).Select(a => a.F_PurchaseOrderCode).FirstOrDefault();
            }
            data.list = uniwork.IQueryable<PurchaseReceiveDetailEntity>(a => a.F_ReceiveId == keyValue)
                .InnerJoin<MaterialEntity>((a, b) => a.F_MaterialId == b.F_Id)
                .Select((a, b) => new PurchaseReceiveDetailEntity
                {
                    F_Id = a.F_Id,
                    F_MaterialCode = b.F_MaterialCode,
                    F_MaterialId = a.F_MaterialId,
                    F_MaterialName = b.F_MaterialName,
                    F_MaterialType = b.F_MaterialType,
                    F_MaterialUnit = b.F_MaterialUnit,
                    F_NeedNum = a.F_NeedNum,
                    F_Price = a.F_Price,
                    F_ReceiveId = a.F_ReceiveId
                }).ToList();
            return data;
        }

        public async Task<PurchaseReceiveEntity> GetLookForm(string keyValue)
        {
            var data = await GetForm(keyValue);
            return GetFieldsFilterData(data);
        }
        #endregion

        #region 提交数据
        public async Task SubmitForm(PurchaseReceiveEntity entity, string keyValue)
        {
            if (entity == null)
            {
                throw new Exception("提交数据为空，请联系管理员");
            }
            if (entity.list == null)
            {
                entity.list = new List<PurchaseReceiveDetailEntity>();
            }
            if (string.IsNullOrEmpty(keyValue))
            {
                entity.F_DeleteMark = false;
                entity.F_EnabledMark = false;
                entity.Create();
                foreach (var item in entity.list)
                {
                    item.F_Id = Utils.GuId();
                    item.F_ReceiveId = entity.F_Id;
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
                    item.F_ReceiveId = entity.F_Id;
                }
                uniwork.BeginTrans();
                await repository.Update(entity);
                await uniwork.Delete<PurchaseReceiveDetailEntity>(a => a.F_ReceiveId == entity.F_Id);
                await uniwork.Insert(entity.list);
                uniwork.Commit();
            }
        }

        public async Task DeleteForm(string keyValue)
        {
            uniwork.BeginTrans();
            await repository.Delete(a => keyValue == a.F_Id);
            await uniwork.Delete<PurchaseReceiveDetailEntity>(a => keyValue == a.F_ReceiveId);
            uniwork.Commit();
        }
        /// <summary>
        /// 退货：根据采购收货单生成采购退货单
        /// </summary>
        public async Task ReturnForm(string keyValue)
        {
            var receive = await repository.FindEntity(keyValue);
            if (receive == null)
            {
                throw new Exception("收货单不存在");
            }
            if (uniwork.IQueryable<PurchaseReturnEntity>(a => a.F_ReceiveId == keyValue && a.F_DeleteMark == false).Any())
            {
                throw new Exception("该收货单已生成过退货单");
            }
            var details = uniwork.IQueryable<PurchaseReceiveDetailEntity>(a => a.F_ReceiveId == keyValue).ToList();
            if (details.Count == 0)
            {
                throw new Exception("收货单没有明细，无法退货");
            }
            PurchaseReturnEntity returnEntity = new PurchaseReturnEntity();
            returnEntity.F_ReturnCode = "PU-" + DateTime.Now.ToString("yyyyMMddHHmmss");
            returnEntity.F_PurchaseOrderId = receive.F_PurchaseOrderId;
            returnEntity.F_ReceiveId = receive.F_Id;
            returnEntity.F_Supplier = receive.F_Supplier;
            returnEntity.F_ReturnDate = DateTime.Now;
            returnEntity.F_TotalMoney = receive.F_TotalMoney;
            returnEntity.F_Description = "由收货单" + receive.F_ReceiveCode + "退货生成";
            returnEntity.F_DeleteMark = false;
            returnEntity.F_EnabledMark = false;
            returnEntity.Create();
            List<PurchaseReturnDetailEntity> returnDetails = new List<PurchaseReturnDetailEntity>();
            foreach (var item in details)
            {
                returnDetails.Add(new PurchaseReturnDetailEntity
                {
                    F_Id = Utils.GuId(),
                    F_ReturnId = returnEntity.F_Id,
                    F_MaterialId = item.F_MaterialId,
                    F_NeedNum = item.F_NeedNum,
                    F_Price = item.F_Price
                });
            }
            uniwork.BeginTrans();
            await uniwork.Insert(returnEntity);
            await uniwork.Insert(returnDetails);
            uniwork.Commit();
        }
        #endregion
    }
}
