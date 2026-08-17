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
    /// 描 述：供应商管理服务类
    /// </summary>
    public class PurchaseSupplierService : DataFilterService<PurchaseSupplierEntity>, IDenpendency
    {
        public PurchaseSupplierService(IDbContext context, IHttpClientFactory httpClientFactory) : base(context)
        {
        }
        #region 获取数据
        public async Task<List<PurchaseSupplierEntity>> GetList(string keyword = "")
        {
            var query = repository.IQueryable().Where(t => t.F_DeleteMark == false);
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(t => t.F_SupplierCode.Contains(keyword)
                || t.F_SupplierName.Contains(keyword)
                || t.F_Contact.Contains(keyword));
            }
            return query.OrderByDesc(t => t.F_CreatorTime).ToList();
        }

        public async Task<List<PurchaseSupplierEntity>> GetLookList(string keyword = "")
        {
            var query = repository.IQueryable().Where(t => t.F_DeleteMark == false);
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(t => t.F_SupplierCode.Contains(keyword)
                || t.F_SupplierName.Contains(keyword)
                || t.F_Contact.Contains(keyword));
            }
            query = GetDataPrivilege("u", "", query);
            return query.OrderByDesc(t => t.F_CreatorTime).ToList();
        }

        public async Task<List<PurchaseSupplierEntity>> GetLookList(SoulPage<PurchaseSupplierEntity> pagination, string keyword = "")
        {
            var query = repository.IQueryable().Where(t => t.F_DeleteMark == false);
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(t => t.F_SupplierCode.Contains(keyword)
                || t.F_SupplierName.Contains(keyword)
                || t.F_Contact.Contains(keyword));
            }
            query = GetDataPrivilege("u", "", query);
            return await repository.OrderList(query, pagination);
        }

        public async Task<PurchaseSupplierEntity> GetForm(string keyValue)
        {
            var data = await repository.FindEntity(keyValue);
            return data;
        }

        public async Task<PurchaseSupplierEntity> GetLookForm(string keyValue)
        {
            var data = await repository.FindEntity(keyValue);
            return GetFieldsFilterData(data);
        }
        #endregion

        #region 提交数据
        public async Task SubmitForm(PurchaseSupplierEntity entity, string keyValue)
        {
            if (string.IsNullOrEmpty(keyValue))
            {
                entity.F_DeleteMark = false;
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
