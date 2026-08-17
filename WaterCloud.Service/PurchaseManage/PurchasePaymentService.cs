using System;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;
using WaterCloud.Code;
using Chloe;
using WaterCloud.Domain.PurchaseManage;
using System.Net.Http;

namespace WaterCloud.Service.PurchaseManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2026-08-15
    /// 描 述：采购付款服务类
    /// </summary>
    public class PurchasePaymentService : DataFilterService<PurchasePaymentEntity>, IDenpendency
    {
        public PurchasePaymentService(IDbContext context, IHttpClientFactory httpClientFactory) : base(context)
        {
        }
        #region 获取数据
        public async Task<List<PurchaseOrderEntity>> GetOrderList(string keyword = "")
        {
            var list = uniwork.IQueryable<PurchaseOrderEntity>(a => a.F_DeleteMark == false && a.F_EnabledMark == true);
            if (!string.IsNullOrEmpty(keyword))
            {
                list = list.Where(t => t.F_PurchaseOrderCode.Contains(keyword) || t.F_Supplier.Contains(keyword));
            }
            return list.OrderByDesc(t => t.F_CreatorTime).ToList();
        }

        public async Task<List<PurchasePaymentEntity>> GetLookList(SoulPage<PurchasePaymentEntity> pagination, string keyword = "")
        {
            var query = repository.IQueryable().Where(t => t.F_DeleteMark == false);
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(t => t.F_PaymentCode.Contains(keyword)
                || t.F_Supplier.Contains(keyword)
                || t.F_Description.Contains(keyword));
            }
            query = GetDataPrivilege("u", "", query);
            return await repository.OrderList(query, pagination);
        }

        public async Task<PurchasePaymentEntity> GetForm(string keyValue)
        {
            var data = await repository.FindEntity(keyValue);
            if (data != null && !string.IsNullOrEmpty(data.F_PurchaseOrderId))
            {
                data.F_PurchaseOrderCode = uniwork.IQueryable<PurchaseOrderEntity>(a => a.F_Id == data.F_PurchaseOrderId).Select(a => a.F_PurchaseOrderCode).FirstOrDefault();
            }
            return data;
        }

        public async Task<PurchasePaymentEntity> GetLookForm(string keyValue)
        {
            var data = await GetForm(keyValue);
            return GetFieldsFilterData(data);
        }
        #endregion

        #region 提交数据
        public async Task SubmitForm(PurchasePaymentEntity entity, string keyValue)
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
