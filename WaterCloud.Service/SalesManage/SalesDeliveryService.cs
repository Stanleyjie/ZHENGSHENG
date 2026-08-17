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
    /// 描 述：销售发货单服务类
    /// </summary>
    public class SalesDeliveryService : DataFilterService<SalesDeliveryEntity>, IDenpendency
    {
        private ItemsDataService itemsApp;
        public SalesDeliveryService(IDbContext context, IHttpClientFactory httpClientFactory) : base(context)
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
            var list = uniwork.IQueryable<SalesOrderEntity>(a => a.F_DeleteMark == false && a.F_EnabledMark == true && a.F_IsFinish == false);
            if (!string.IsNullOrEmpty(keyword))
            {
                list = list.Where(t => t.F_SalesOrderCode.Contains(keyword) || t.F_Customer.Contains(keyword));
            }
            return list.OrderByDesc(t => t.F_CreatorTime).ToList();
        }

        public async Task<List<SalesDeliveryEntity>> GetLookList(SoulPage<SalesDeliveryEntity> pagination, string keyword = "")
        {
            var query = IQueryable().Where(t => t.F_DeleteMark == false);
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(t => t.F_DeliveryCode.Contains(keyword)
                || t.F_Customer.Contains(keyword)
                || t.F_Description.Contains(keyword));
            }
            query = GetDataPrivilege("u", "", query);
            return await repository.OrderList(query, pagination);
        }

        private IQuery<SalesDeliveryEntity> IQueryable()
        {
            var details = uniwork.IQueryable<SalesDeliveryDetailEntity>().GroupBy(a => a.F_DeliveryId).Select(a => new { a.F_DeliveryId, F_NeedNum = Sql.Sum(a.F_NeedNum) });
            var query = repository.IQueryable().InnerJoin(details, (a, b) => a.F_Id == b.F_DeliveryId)
                .Select((a, b) => new SalesDeliveryEntity
                {
                    F_CreatorTime = a.F_CreatorTime,
                    F_CreatorUserId = a.F_CreatorUserId,
                    F_Customer = a.F_Customer,
                    F_DeleteMark = a.F_DeleteMark,
                    F_DeleteTime = a.F_DeleteTime,
                    F_DeleteUserId = a.F_DeleteUserId,
                    F_DeliveryCode = a.F_DeliveryCode,
                    F_DeliveryDate = a.F_DeliveryDate,
                    F_Description = a.F_Description,
                    F_EnabledMark = a.F_EnabledMark,
                    F_Id = a.F_Id,
                    F_LastModifyTime = a.F_LastModifyTime,
                    F_LastModifyUserId = a.F_LastModifyUserId,
                    F_NeedNum = b.F_NeedNum,
                    F_SalesOrderId = a.F_SalesOrderId,
                    F_TotalMoney = a.F_TotalMoney
                });
            return query;
        }

        public async Task<SalesDeliveryEntity> GetForm(string keyValue)
        {
            var data = IQueryable().Where(a => a.F_Id == keyValue).FirstOrDefault();
            if (data != null && !string.IsNullOrEmpty(data.F_SalesOrderId))
            {
                data.F_SalesOrderCode = uniwork.IQueryable<SalesOrderEntity>(a => a.F_Id == data.F_SalesOrderId).Select(a => a.F_SalesOrderCode).FirstOrDefault();
            }
            data.list = uniwork.IQueryable<SalesDeliveryDetailEntity>(a => a.F_DeliveryId == keyValue)
                .InnerJoin<MaterialEntity>((a, b) => a.F_MaterialId == b.F_Id)
                .Select((a, b) => new SalesDeliveryDetailEntity
                {
                    F_Id = a.F_Id,
                    F_MaterialCode = b.F_MaterialCode,
                    F_MaterialId = a.F_MaterialId,
                    F_MaterialName = b.F_MaterialName,
                    F_MaterialType = b.F_MaterialType,
                    F_MaterialUnit = b.F_MaterialUnit,
                    F_NeedNum = a.F_NeedNum,
                    F_Price = a.F_Price,
                    F_DeliveryId = a.F_DeliveryId
                }).ToList();
            return data;
        }

        public async Task<SalesDeliveryEntity> GetLookForm(string keyValue)
        {
            var data = await GetForm(keyValue);
            return GetFieldsFilterData(data);
        }
        #endregion

        #region 提交数据
        public async Task SubmitForm(SalesDeliveryEntity entity, string keyValue)
        {
            if (entity == null)
            {
                throw new Exception("提交数据为空，请联系管理员");
            }
            if (entity.list == null)
            {
                entity.list = new List<SalesDeliveryDetailEntity>();
            }
            if (string.IsNullOrEmpty(keyValue))
            {
                entity.F_DeleteMark = false;
                entity.F_EnabledMark = false;
                entity.Create();
                foreach (var item in entity.list)
                {
                    item.F_Id = Utils.GuId();
                    item.F_DeliveryId = entity.F_Id;
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
                    item.F_DeliveryId = entity.F_Id;
                }
                uniwork.BeginTrans();
                await repository.Update(entity);
                await uniwork.Delete<SalesDeliveryDetailEntity>(a => a.F_DeliveryId == entity.F_Id);
                await uniwork.Insert(entity.list);
                uniwork.Commit();
            }
        }

        public async Task DeleteForm(string keyValue)
        {
            uniwork.BeginTrans();
            await repository.Delete(a => keyValue == a.F_Id);
            await uniwork.Delete<SalesDeliveryDetailEntity>(a => keyValue == a.F_DeliveryId);
            uniwork.Commit();
        }
        #endregion
    }
}
