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
    /// 描 述：客户管理服务类
    /// </summary>
    public class SalesCustomerService : DataFilterService<SalesCustomerEntity>, IDenpendency
    {
        public SalesCustomerService(IDbContext context, IHttpClientFactory httpClientFactory) : base(context)
        {
        }
        #region 获取数据
        public async Task<List<SalesCustomerEntity>> GetList(string keyword = "")
        {
            var query = repository.IQueryable().Where(t => t.F_DeleteMark == false);
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(t => t.F_CustomerCode.Contains(keyword)
                || t.F_CustomerName.Contains(keyword)
                || t.F_Contact.Contains(keyword));
            }
            return query.OrderByDesc(t => t.F_CreatorTime).ToList();
        }

        public async Task<List<SalesCustomerEntity>> GetLookList(string keyword = "")
        {
            var query = repository.IQueryable().Where(t => t.F_DeleteMark == false);
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(t => t.F_CustomerCode.Contains(keyword)
                || t.F_CustomerName.Contains(keyword)
                || t.F_Contact.Contains(keyword));
            }
            query = GetDataPrivilege("u", "", query);
            return query.OrderByDesc(t => t.F_CreatorTime).ToList();
        }

        public async Task<List<SalesCustomerEntity>> GetLookList(SoulPage<SalesCustomerEntity> pagination, string keyword = "")
        {
            var query = repository.IQueryable().Where(t => t.F_DeleteMark == false);
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(t => t.F_CustomerCode.Contains(keyword)
                || t.F_CustomerName.Contains(keyword)
                || t.F_Contact.Contains(keyword));
            }
            query = GetDataPrivilege("u", "", query);
            return await repository.OrderList(query, pagination);
        }

        public async Task<SalesCustomerEntity> GetForm(string keyValue)
        {
            var data = await repository.FindEntity(keyValue);
            return data;
        }

        public async Task<SalesCustomerEntity> GetLookForm(string keyValue)
        {
            var data = await repository.FindEntity(keyValue);
            return GetFieldsFilterData(data);
        }
        #endregion

        #region 提交数据
        public async Task SubmitForm(SalesCustomerEntity entity, string keyValue)
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
