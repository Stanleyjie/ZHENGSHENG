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
    /// 描 述：销售退货单服务类
    /// </summary>
    public class SalesReturnService : DataFilterService<SalesReturnEntity>, IDenpendency
    {
        private ItemsDataService itemsApp;
        public SalesReturnService(IDbContext context, IHttpClientFactory httpClientFactory) : base(context)
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

        public async Task<List<SalesOrderEntity>> GetOrderList(string keyword = "")
        {
            var list = uniwork.IQueryable<SalesOrderEntity>(a => a.F_DeleteMark == false && a.F_EnabledMark == true);
            if (!string.IsNullOrEmpty(keyword))
            {
                list = list.Where(t => t.F_SalesOrderCode.Contains(keyword) || t.F_Customer.Contains(keyword));
            }
            return list.OrderByDesc(t => t.F_CreatorTime).ToList();
        }

        public async Task<List<SalesReturnEntity>> GetLookList(SoulPage<SalesReturnEntity> pagination, string keyword = "")
        {
            var query = IQueryable().Where(t => t.F_DeleteMark == false);
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(t => t.F_ReturnCode.Contains(keyword)
                || t.F_Customer.Contains(keyword)
                || t.F_Description.Contains(keyword));
            }
            query = GetDataPrivilege("u", "", query);
            return await repository.OrderList(query, pagination);
        }

        private IQuery<SalesReturnEntity> IQueryable()
        {
            var details = uniwork.IQueryable<SalesReturnDetailEntity>().GroupBy(a => a.F_ReturnId).Select(a => new { a.F_ReturnId, F_NeedNum = Sql.Sum(a.F_NeedNum) });
            var query = repository.IQueryable().InnerJoin(details, (a, b) => a.F_Id == b.F_ReturnId)
                .Select((a, b) => new SalesReturnEntity
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
                    F_ReturnCode = a.F_ReturnCode,
                    F_ReturnDate = a.F_ReturnDate,
                    F_SalesOrderId = a.F_SalesOrderId,
                    F_TotalMoney = a.F_TotalMoney
                });
            return query;
        }

        public async Task<SalesReturnEntity> GetForm(string keyValue)
        {
            var data = IQueryable().Where(a => a.F_Id == keyValue).FirstOrDefault();
            if (data != null && !string.IsNullOrEmpty(data.F_SalesOrderId))
            {
                data.F_SalesOrderCode = uniwork.IQueryable<SalesOrderEntity>(a => a.F_Id == data.F_SalesOrderId).Select(a => a.F_SalesOrderCode).FirstOrDefault();
            }
            data.list = uniwork.IQueryable<SalesReturnDetailEntity>(a => a.F_ReturnId == keyValue)
                .InnerJoin<MaterialEntity>((a, b) => a.F_MaterialId == b.F_Id)
                .Select((a, b) => new SalesReturnDetailEntity
                {
                    F_Id = a.F_Id,
                    F_MaterialCode = b.F_MaterialCode,
                    F_MaterialId = a.F_MaterialId,
                    F_MaterialName = b.F_MaterialName,
                    F_MaterialType = b.F_MaterialType,
                    F_MaterialUnit = b.F_MaterialUnit,
                    F_NeedNum = a.F_NeedNum,
                    F_Price = a.F_Price,
                    F_ReturnId = a.F_ReturnId
                }).ToList();
            return data;
        }

        public async Task<SalesReturnEntity> GetLookForm(string keyValue)
        {
            var data = await GetForm(keyValue);
            return GetFieldsFilterData(data);
        }
        #endregion

        #region 提交数据
        public async Task SubmitForm(SalesReturnEntity entity, string keyValue)
        {
            if (entity == null)
            {
                throw new Exception("提交数据为空，请联系管理员");
            }
            if (entity.list == null)
            {
                entity.list = new List<SalesReturnDetailEntity>();
            }
            if (string.IsNullOrEmpty(keyValue))
            {
                entity.F_DeleteMark = false;
                entity.F_EnabledMark = false;
                entity.Create();
                foreach (var item in entity.list)
                {
                    item.F_Id = Utils.GuId();
                    item.F_ReturnId = entity.F_Id;
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
                    item.F_ReturnId = entity.F_Id;
                }
                uniwork.BeginTrans();
                await repository.Update(entity);
                await uniwork.Delete<SalesReturnDetailEntity>(a => a.F_ReturnId == entity.F_Id);
                await uniwork.Insert(entity.list);
                uniwork.Commit();
            }
        }

        public async Task DeleteForm(string keyValue)
        {
            uniwork.BeginTrans();
            await repository.Delete(a => keyValue == a.F_Id);
            await uniwork.Delete<SalesReturnDetailEntity>(a => keyValue == a.F_ReturnId);
            uniwork.Commit();
        }
        #endregion
    }
}
