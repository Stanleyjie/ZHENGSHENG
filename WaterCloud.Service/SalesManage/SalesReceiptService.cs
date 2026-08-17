using System;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;
using WaterCloud.Code;
using Chloe;
using WaterCloud.Domain.SalesManage;
using System.Net.Http;

namespace WaterCloud.Service.SalesManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2026-08-15
    /// 描 述：销售收款服务类
    /// </summary>
    public class SalesReceiptService : DataFilterService<SalesReceiptEntity>, IDenpendency
    {
        public SalesReceiptService(IDbContext context, IHttpClientFactory httpClientFactory) : base(context)
        {
        }
        #region 获取数据
        public async Task<List<SalesOrderEntity>> GetOrderList(string keyword = "")
        {
            var list = uniwork.IQueryable<SalesOrderEntity>(a => a.F_DeleteMark == false && a.F_EnabledMark == true);
            if (!string.IsNullOrEmpty(keyword))
            {
                list = list.Where(t => t.F_SalesOrderCode.Contains(keyword) || t.F_Customer.Contains(keyword));
            }
            return list.OrderByDesc(t => t.F_CreatorTime).ToList();
        }

        public async Task<List<SalesReceiptEntity>> GetLookList(SoulPage<SalesReceiptEntity> pagination, string keyword = "")
        {
            var query = repository.IQueryable().Where(t => t.F_DeleteMark == false);
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(t => t.F_ReceiptCode.Contains(keyword)
                || t.F_Customer.Contains(keyword)
                || t.F_Description.Contains(keyword));
            }
            query = GetDataPrivilege("u", "", query);
            return await repository.OrderList(query, pagination);
        }

        public async Task<SalesReceiptEntity> GetForm(string keyValue)
        {
            var data = await repository.FindEntity(keyValue);
            if (data != null && !string.IsNullOrEmpty(data.F_SalesOrderId))
            {
                data.F_SalesOrderCode = uniwork.IQueryable<SalesOrderEntity>(a => a.F_Id == data.F_SalesOrderId).Select(a => a.F_SalesOrderCode).FirstOrDefault();
            }
            return data;
        }

        public async Task<SalesReceiptEntity> GetLookForm(string keyValue)
        {
            var data = await GetForm(keyValue);
            return GetFieldsFilterData(data);
        }
        #endregion

        #region 提交数据
        public async Task SubmitForm(SalesReceiptEntity entity, string keyValue)
        {
            if (string.IsNullOrEmpty(keyValue))
            {
                entity.F_DeleteMark = false;
                entity.F_EnabledMark = false;
                entity.Create();
                await repository.Insert(entity);
            }
            else
            {
                entity.Modify(keyValue);
                await repository.Update(entity);
            }
        }

        public async Task DeleteForm(string keyValue)
        {
            await repository.Delete(t => t.F_Id == keyValue);
        }
        #endregion
    }
}
