using System;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;
using WaterCloud.Code;
using Chloe;
using WaterCloud.Domain.SalesManage;
using WaterCloud.Domain.MaterialManage;
using WaterCloud.Service.MaterialManage;
using System.Net.Http;
using WaterCloud.Service.SystemManage;

namespace WaterCloud.Service.SalesManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2026-08-14
    /// 描 述：销售订单服务类
    /// </summary>
    public class SalesOrderService : DataFilterService<SalesOrderEntity>, IDenpendency
    {
        private ItemsDataService itemsApp;
        public SalesOrderService(IDbContext context, IHttpClientFactory httpClientFactory) : base(context)
        {
            itemsApp = new ItemsDataService(context);
        }
        #region 获取数据
        public async Task<List<SalesOrderEntity>> GetList(string keyword = "")
        {
            var data = IQueryable();
            if (!string.IsNullOrEmpty(keyword))
            {
                data = data.Where(t => t.F_SalesOrderCode.Contains(keyword)
                || t.F_Customer.Contains(keyword)
                || t.F_Description.Contains(keyword));
            }
            return data.Where(t => t.F_DeleteMark == false).OrderByDesc(t => t.F_CreatorTime).ToList();
        }

        public async Task<List<SalesOrderEntity>> GetLookList(string keyword = "")
        {
            var query = IQueryable().Where(t => t.F_DeleteMark == false);
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(t => t.F_SalesOrderCode.Contains(keyword)
                || t.F_Customer.Contains(keyword)
                || t.F_Description.Contains(keyword));
            }
            //权限过滤
            query = GetDataPrivilege("u", "", query);
            return query.OrderByDesc(t => t.F_CreatorTime).ToList();
        }

        public async Task<List<MaterialEntity>> GetMaterialList(string keyword)
        {
            //获取数据权限
            var list = uniwork.IQueryable<MaterialEntity>(a => a.F_DeleteMark == false && a.F_EnabledMark == true && a.F_MaterialType > 0);
            if (!string.IsNullOrEmpty(keyword))
            {
                list = list.Where(t => t.F_MaterialCode.Contains(keyword) || t.F_MaterialName.Contains(keyword));
            }
            return list.ToList();
        }

        public async Task<List<SalesOrderEntity>> GetLookList(SoulPage<SalesOrderEntity> pagination, string keyword = "", string id = "")
        {
            var query = IQueryable().Where(t => t.F_DeleteMark == false);
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(t => t.F_SalesOrderCode.Contains(keyword)
                || t.F_Customer.Contains(keyword)
                || t.F_Description.Contains(keyword));
            }
            if (!string.IsNullOrEmpty(id))
            {
                query = query.Where(u => u.F_Id == id);
            }
            //权限过滤
            query = GetDataPrivilege("u", "", query);
            return await repository.OrderList(query, pagination);
        }

        private IQuery<SalesOrderEntity> IQueryable()
        {
            var details = uniwork.IQueryable<SalesOrderDetailEntity>().GroupBy(a => a.F_SalesOrderId).Select(a => new { a.F_SalesOrderId, F_NeedNum = Sql.Sum(a.F_NeedNum) });
            var query = repository.IQueryable().InnerJoin(details, (a, b) => a.F_Id == b.F_SalesOrderId)
                .Select((a, b) => new SalesOrderEntity
                {
                    F_CreatorTime = a.F_CreatorTime,
                    F_CreatorUserId = a.F_CreatorUserId,
                    F_Customer = a.F_Customer,
                    F_DayNum = a.F_DayNum,
                    F_DeleteMark = a.F_DeleteMark,
                    F_DeleteTime = a.F_DeleteTime,
                    F_DeleteUserId = a.F_DeleteUserId,
                    F_Description = a.F_Description,
                    F_EnabledMark = a.F_EnabledMark,
                    F_Id = a.F_Id,
                    F_LastModifyTime = a.F_LastModifyTime,
                    F_LastModifyUserId = a.F_LastModifyUserId,
                    F_NeedNum = b.F_NeedNum,
                    F_SalesOrderCode = a.F_SalesOrderCode,
                    F_TotalMoney = a.F_TotalMoney,
                    F_PlanEndTime = a.F_PlanEndTime,
                    F_PlanStartTime = a.F_PlanStartTime,
                    F_IsFinish = a.F_IsFinish,
                    F_PredictOverTime = a.F_PredictOverTime,
                    F_ActualOverTime = a.F_ActualOverTime,
                });
            return query;
        }

        public async Task<SalesOrderEntity> GetForm(string keyValue)
        {
            var data = IQueryable().Where(a => a.F_Id == keyValue).FirstOrDefault();
            data.list = uniwork.IQueryable<SalesOrderDetailEntity>(a => a.F_SalesOrderId == keyValue)
                .InnerJoin<MaterialEntity>((a, b) => a.F_MaterialId == b.F_Id)
                .Select((a, b) => new SalesOrderDetailEntity
                {
                    F_Id = a.F_Id,
                    F_MaterialCode = b.F_MaterialCode,
                    F_MaterialId = a.F_MaterialId,
                    F_MaterialName = b.F_MaterialName,
                    F_MaterialType = b.F_MaterialType,
                    F_MaterialUnit = b.F_MaterialUnit,
                    F_NeedNum = a.F_NeedNum,
                    F_Price = a.F_Price,
                    F_SalesOrderId = a.F_SalesOrderId,
                    F_DoneNum = 0
                }).ToList();
            return data;
        }

        public async Task<SalesOrderEntity> GetLookForm(string keyValue)
        {
            var data = await GetForm(keyValue);
            return GetFieldsFilterData(data);
        }
        #endregion

        #region 提交数据
        public async Task SubmitForm(SalesOrderEntity entity, string keyValue)
        {
            if (entity == null)
            {
                throw new Exception("提交数据为空，请联系管理员");
            }
            if (entity.list == null)
            {
                entity.list = new List<SalesOrderDetailEntity>();
            }
            if (string.IsNullOrEmpty(keyValue))
            {
                //初始值添加
                entity.F_DeleteMark = false;
                entity.F_EnabledMark = false;
                entity.F_IsFinish = false;
                entity.F_PredictOverTime = null;
                entity.Create();
                foreach (var item in entity.list)
                {
                    item.F_Id = Utils.GuId();
                    item.F_SalesOrderId = entity.F_Id;
                }
                uniwork.BeginTrans();
                await repository.Insert(entity);
                await uniwork.Insert(entity.list);
                uniwork.Commit();
            }
            else
            {
                //修改
                entity.Modify(keyValue);
                uniwork.BeginTrans();
                await repository.Update(entity);
                if (entity.F_EnabledMark == true)
                {
                    foreach (var item in entity.list)
                    {
                        await uniwork.Update<SalesOrderDetailEntity>(a => a.F_Id == item.F_Id, a => new SalesOrderDetailEntity
                        {
                            F_NeedNum = item.F_NeedNum,
                            F_Price = item.F_Price
                        });
                    }
                }
                else
                {
                    foreach (var item in entity.list)
                    {
                        item.F_Id = Utils.GuId();
                        item.F_SalesOrderId = entity.F_Id;
                    }
                    await uniwork.Delete<SalesOrderDetailEntity>(a => a.F_SalesOrderId == entity.F_Id);
                    await uniwork.Insert(entity.list);
                }
                uniwork.Commit();
            }
        }
        //删除订单
        public async Task DeleteForm(string keyValue)
        {
            if (repository.IQueryable(a => keyValue == a.F_Id && a.F_EnabledMark == true).Count() > 0)
            {
                throw new Exception("订单已启用，无法删除");
            }
            uniwork.BeginTrans();
            await repository.Delete(a => keyValue == a.F_Id);
            await uniwork.Delete<SalesOrderDetailEntity>(a => keyValue == a.F_SalesOrderId);
            uniwork.Commit();
        }
        //结案订单
        public async Task OverForm(string keyValue)
        {
            if (repository.IQueryable(a => keyValue == a.F_Id && a.F_EnabledMark == true && a.F_IsFinish == true).Count() > 0)
            {
                throw new Exception("订单已经结案，无法结案");
            }
            await repository.Update(a => keyValue == a.F_Id && a.F_EnabledMark == true && a.F_IsFinish == false, a => new SalesOrderEntity
            {
                F_IsFinish = true,
                F_ActualOverTime = DateTime.Now.Date
            });
        }
        //启用订单
        public async Task EnabledForm(string keyValue = "")
        {
            if (repository.IQueryable(a => keyValue == a.F_Id && a.F_IsFinish == true).Count() > 0)
            {
                throw new Exception("订单已经结案，无法启用");
            }
            await repository.Update(a => keyValue == a.F_Id && a.F_IsFinish == false, a => new SalesOrderEntity
            {
                F_EnabledMark = true
            });
        }
        #endregion
    }
}
