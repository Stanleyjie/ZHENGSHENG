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
    /// 描 述：采购退货单服务类
    /// </summary>
    public class PurchaseReturnService : DataFilterService<PurchaseReturnEntity>, IDenpendency
    {
        private ItemsDataService itemsApp;
        public PurchaseReturnService(IDbContext context, IHttpClientFactory httpClientFactory) : base(context)
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
            var list = uniwork.IQueryable<PurchaseOrderEntity>(a => a.F_DeleteMark == false && a.F_EnabledMark == true);
            if (!string.IsNullOrEmpty(keyword))
            {
                list = list.Where(t => t.F_PurchaseOrderCode.Contains(keyword) || t.F_Supplier.Contains(keyword));
            }
            return list.OrderByDesc(t => t.F_CreatorTime).ToList();
        }

        public async Task<List<PurchaseReturnEntity>> GetLookList(SoulPage<PurchaseReturnEntity> pagination, string keyword = "")
        {
            var query = IQueryable().Where(t => t.F_DeleteMark == false);
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(t => t.F_ReturnCode.Contains(keyword)
                || t.F_Supplier.Contains(keyword)
                || t.F_Description.Contains(keyword));
            }
            query = GetDataPrivilege("u", "", query);
            return await repository.OrderList(query, pagination);
        }

        private IQuery<PurchaseReturnEntity> IQueryable()
        {
            var details = uniwork.IQueryable<PurchaseReturnDetailEntity>().GroupBy(a => a.F_ReturnId).Select(a => new { a.F_ReturnId, F_NeedNum = Sql.Sum(a.F_NeedNum) });
            var query = repository.IQueryable().InnerJoin(details, (a, b) => a.F_Id == b.F_ReturnId)
                .Select((a, b) => new PurchaseReturnEntity
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
                    F_ReturnCode = a.F_ReturnCode,
                    F_ReturnDate = a.F_ReturnDate,
                    F_TotalMoney = a.F_TotalMoney
                });
            return query;
        }

        public async Task<PurchaseReturnEntity> GetForm(string keyValue)
        {
            var data = IQueryable().Where(a => a.F_Id == keyValue).FirstOrDefault();
            if (data != null && !string.IsNullOrEmpty(data.F_PurchaseOrderId))
            {
                data.F_PurchaseOrderCode = uniwork.IQueryable<PurchaseOrderEntity>(a => a.F_Id == data.F_PurchaseOrderId).Select(a => a.F_PurchaseOrderCode).FirstOrDefault();
            }
            data.list = uniwork.IQueryable<PurchaseReturnDetailEntity>(a => a.F_ReturnId == keyValue)
                .InnerJoin<MaterialEntity>((a, b) => a.F_MaterialId == b.F_Id)
                .Select((a, b) => new PurchaseReturnDetailEntity
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

        public async Task<PurchaseReturnEntity> GetLookForm(string keyValue)
        {
            var data = await GetForm(keyValue);
            return GetFieldsFilterData(data);
        }
        #endregion

        #region 提交数据
        public async Task SubmitForm(PurchaseReturnEntity entity, string keyValue)
        {
            if (entity == null)
            {
                throw new Exception("提交数据为空，请联系管理员");
            }
            if (entity.list == null)
            {
                entity.list = new List<PurchaseReturnDetailEntity>();
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
                await uniwork.Delete<PurchaseReturnDetailEntity>(a => a.F_ReturnId == entity.F_Id);
                await uniwork.Insert(entity.list);
                uniwork.Commit();
            }
        }

        public async Task DeleteForm(string keyValue)
        {
            uniwork.BeginTrans();
            await repository.Delete(a => keyValue == a.F_Id);
            await uniwork.Delete<PurchaseReturnDetailEntity>(a => keyValue == a.F_ReturnId);
            uniwork.Commit();
        }
        #endregion
    }
}
