using System;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;
using WaterCloud.Code;
using Chloe;
using WaterCloud.Domain.SalesManage;
using WaterCloud.Domain.MaterialManage;
using System.Net.Http;
using WaterCloud.Service.SystemManage;

namespace WaterCloud.Service.SalesManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2026-08-15
    /// 描 述：销售报价单服务类
    /// </summary>
    public class SalesQuoteService : DataFilterService<SalesQuoteEntity>, IDenpendency
    {
        private ItemsDataService itemsApp;
        public SalesQuoteService(IDbContext context, IHttpClientFactory httpClientFactory) : base(context)
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

        public async Task<List<SalesQuoteEntity>> GetLookList(SoulPage<SalesQuoteEntity> pagination, string keyword = "")
        {
            //已审核流转到销售订单的报价单不再显示
            var query = IQueryable().Where(t => t.F_DeleteMark == false && (t.F_QuoteState == null || t.F_QuoteState != 1));
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(t => t.F_QuoteCode.Contains(keyword)
                || t.F_Customer.Contains(keyword)
                || t.F_Description.Contains(keyword));
            }
            query = GetDataPrivilege("u", "", query);
            return await repository.OrderList(query, pagination);
        }

        private IQuery<SalesQuoteEntity> IQueryable()
        {
            var details = uniwork.IQueryable<SalesQuoteDetailEntity>().GroupBy(a => a.F_QuoteId).Select(a => new { a.F_QuoteId, F_NeedNum = Sql.Sum(a.F_NeedNum) });
            var query = repository.IQueryable().InnerJoin(details, (a, b) => a.F_Id == b.F_QuoteId)
                .Select((a, b) => new SalesQuoteEntity
                {
                    F_CreatorTime = a.F_CreatorTime,
                    F_CreatorUserId = a.F_CreatorUserId,
                    F_Customer = a.F_Customer,
                    F_DeleteMark = a.F_DeleteMark,
                    F_DeleteTime = a.F_DeleteTime,
                    F_DeleteUserId = a.F_DeleteUserId,
                    F_Description = a.F_Description,
                    F_EnabledMark = a.F_EnabledMark,
                    F_Id = a.F_Id,
                    F_LastModifyTime = a.F_LastModifyTime,
                    F_LastModifyUserId = a.F_LastModifyUserId,
                    F_NeedNum = b.F_NeedNum,
                    F_QuoteCode = a.F_QuoteCode,
                    F_QuoteDate = a.F_QuoteDate,
                    F_QuoteState = a.F_QuoteState,
                    F_SalesOrderId = a.F_SalesOrderId,
                    F_TotalMoney = a.F_TotalMoney
                });
            return query;
        }

        public async Task<SalesQuoteEntity> GetForm(string keyValue)
        {
            var data = IQueryable().Where(a => a.F_Id == keyValue).FirstOrDefault();
            data.list = uniwork.IQueryable<SalesQuoteDetailEntity>(a => a.F_QuoteId == keyValue)
                .InnerJoin<MaterialEntity>((a, b) => a.F_MaterialId == b.F_Id)
                .Select((a, b) => new SalesQuoteDetailEntity
                {
                    F_Id = a.F_Id,
                    F_MaterialCode = b.F_MaterialCode,
                    F_MaterialId = a.F_MaterialId,
                    F_MaterialName = b.F_MaterialName,
                    F_MaterialType = b.F_MaterialType,
                    F_MaterialUnit = b.F_MaterialUnit,
                    F_NeedNum = a.F_NeedNum,
                    F_Price = a.F_Price,
                    F_QuoteId = a.F_QuoteId
                }).ToList();
            return data;
        }

        public async Task<SalesQuoteEntity> GetLookForm(string keyValue)
        {
            var data = await GetForm(keyValue);
            return GetFieldsFilterData(data);
        }
        #endregion

        #region 提交数据
        public async Task SubmitForm(SalesQuoteEntity entity, string keyValue)
        {
            if (entity == null)
            {
                throw new Exception("提交数据为空，请联系管理员");
            }
            if (entity.list == null)
            {
                entity.list = new List<SalesQuoteDetailEntity>();
            }
            if (string.IsNullOrEmpty(keyValue))
            {
                if (string.IsNullOrEmpty(entity.F_QuoteCode))
                {
                    entity.F_QuoteCode = "QT-" + DateTime.Now.ToString("yyyyMMddHHmmss");
                }
                entity.F_DeleteMark = false;
                entity.F_EnabledMark = false;
                entity.Create();
                foreach (var item in entity.list)
                {
                    item.F_Id = Utils.GuId();
                    item.F_QuoteId = entity.F_Id;
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
                    item.F_QuoteId = entity.F_Id;
                }
                uniwork.BeginTrans();
                await repository.Update(entity);
                await uniwork.Delete<SalesQuoteDetailEntity>(a => a.F_QuoteId == entity.F_Id);
                await uniwork.Insert(entity.list);
                uniwork.Commit();
            }
        }

        public async Task DeleteForm(string keyValue)
        {
            uniwork.BeginTrans();
            await repository.Delete(a => keyValue == a.F_Id);
            await uniwork.Delete<SalesQuoteDetailEntity>(a => keyValue == a.F_QuoteId);
            uniwork.Commit();
        }
        /// <summary>
        /// 审核通过：根据报价单生成销售订单
        /// </summary>
        public async Task ApproveForm(string keyValue)
        {
            var quote = await repository.FindEntity(keyValue);
            if (quote == null)
            {
                throw new Exception("报价单不存在");
            }
            if (quote.F_QuoteState == 1)
            {
                throw new Exception("报价单已审核通过，不能重复审核");
            }
            if (!string.IsNullOrEmpty(quote.F_SalesOrderId))
            {
                throw new Exception("该报价单已生成销售订单，不能重复审核");
            }
            var details = uniwork.IQueryable<SalesQuoteDetailEntity>(a => a.F_QuoteId == keyValue).ToList();
            if (details.Count == 0)
            {
                throw new Exception("报价单没有明细，无法审核通过");
            }
            //生成销售订单
            SalesOrderEntity order = new SalesOrderEntity();
            order.F_SalesOrderCode = "SO-" + DateTime.Now.ToString("yyyyMMddHHmmss");
            order.F_Customer = quote.F_Customer;
            order.F_PlanStartTime = quote.F_QuoteDate ?? DateTime.Now;
            order.F_PlanEndTime = (quote.F_QuoteDate ?? DateTime.Now).AddDays(30);
            order.F_DayNum = 6;
            order.F_TotalMoney = quote.F_TotalMoney;
            order.F_Description = "由报价单" + quote.F_QuoteCode + "审核生成";
            order.F_DeleteMark = false;
            order.F_EnabledMark = false;
            order.F_IsFinish = false;
            order.Create();
            List<SalesOrderDetailEntity> orderDetails = new List<SalesOrderDetailEntity>();
            foreach (var item in details)
            {
                orderDetails.Add(new SalesOrderDetailEntity
                {
                    F_Id = Utils.GuId(),
                    F_SalesOrderId = order.F_Id,
                    F_MaterialId = item.F_MaterialId,
                    F_NeedNum = item.F_NeedNum,
                    F_Price = item.F_Price
                });
            }
            uniwork.BeginTrans();
            await uniwork.Insert(order);
            await uniwork.Insert(orderDetails);
            await repository.Update(a => a.F_Id == keyValue, a => new SalesQuoteEntity
            {
                F_QuoteState = 1,
                F_SalesOrderId = order.F_Id
            });
            uniwork.Commit();
        }
        #endregion
    }
}
