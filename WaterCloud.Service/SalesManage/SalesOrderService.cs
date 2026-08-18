using System;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;
using WaterCloud.Code;
using Chloe;
using WaterCloud.Domain.SalesManage;
using WaterCloud.Domain.MaterialManage;
using WaterCloud.Domain.ProcessManage;
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
            //已流转到销售发货单的订单不再显示
            var query = IQueryable().Where(t => t.F_DeleteMark == false && (t.F_IsFinish == null || t.F_IsFinish == false));
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
                if (string.IsNullOrEmpty(entity.F_SalesOrderCode))
                {
                    entity.F_SalesOrderCode = "SO-" + DateTime.Now.ToString("yyyyMMddHHmmss");
                }
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
        /// <summary>
        /// 从销售订单生成生产工单（按BOM展开明细）
        /// </summary>
        public async Task CreateWorkOrder(string keyValue)
        {
            var order = await repository.FindEntity(keyValue);
            if (order == null)
            {
                throw new Exception("销售订单不存在");
            }
            if (order.F_EnabledMark != true)
            {
                throw new Exception("请先启用销售订单，再生成工单");
            }
            if (order.F_IsFinish == true)
            {
                throw new Exception("销售订单已结案，不能生成工单");
            }
            var details = uniwork.IQueryable<SalesOrderDetailEntity>(a => a.F_SalesOrderId == keyValue).ToList();
            if (details.Count == 0)
            {
                throw new Exception("销售订单没有明细，无法生成工单");
            }
            //已经生成过工单的明细，跳过（防止重复生成）
            var generated = uniwork.IQueryable<WorkOrderEntity>(a => a.F_SalesOrderId == keyValue)
                .Select(a => a.F_SalesOrderDetailId).ToList().Where(a => a != null).ToList();
            uniwork.BeginTrans();
            int count = 1;
            foreach (var detail in details)
            {
                if (generated.Contains(detail.F_Id))
                {
                    continue;
                }
                WorkOrderEntity work = new WorkOrderEntity();
                work.F_WorkOrderCode = "WO-" + DateTime.Now.ToString("yyyyMMddHHmmss") + count;
                work.F_MaterialId = detail.F_MaterialId;
                work.F_PlanNum = detail.F_NeedNum;
                work.F_PlanStartTime = order.F_PlanStartTime;
                work.F_PlanEndTime = order.F_PlanEndTime;
                work.F_WorkOrderState = 0;
                work.F_SplitType = 0;
                work.F_SalesOrderId = order.F_Id;
                work.F_SalesOrderCode = order.F_SalesOrderCode;
                work.F_SalesOrderDetailId = detail.F_Id;
                work.F_Description = "销售订单:" + order.F_SalesOrderCode + " 客户:" + order.F_Customer;
                work.F_DeleteMark = false;
                work.F_EnabledMark = true;
                work.F_DoneNum = 0;
                work.F_BadNum = 0;
                work.Create();
                await uniwork.Insert(work);
                //BOM展开工单明细
                WorkOrderDetailEntity parent = new WorkOrderDetailEntity();
                parent.F_MaterialId = detail.F_MaterialId;
                parent.Create();
                parent.F_BadNum = 0;
                parent.F_PlanNum = detail.F_NeedNum;
                parent.F_DoneNum = 0;
                parent.F_DeleteMark = false;
                parent.F_EnabledMark = true;
                parent.F_PlanEndTime = work.F_PlanEndTime;
                parent.F_PlanStartTime = work.F_PlanStartTime;
                parent.F_Description = work.F_Description;
                parent.F_WorkOrderId = work.F_Id;
                parent.F_RunSort = 0;
                parent.F_WorkOrderState = 0;
                List<WorkOrderDetailEntity> list = new List<WorkOrderDetailEntity>();
                list.Add(parent);
                GetBomDetail(parent, list, new List<string> { detail.F_MaterialId });
                //合并相同物料，重排执行顺序
                List<WorkOrderDetailEntity> detailList = new List<WorkOrderDetailEntity>();
                int sort = 1;
                foreach (var item in list.OrderBy(a => a.F_RunSort).ToList())
                {
                    var find = detailList.Where(a => a.F_MaterialId == item.F_MaterialId).FirstOrDefault();
                    if (find != null)
                    {
                        find.F_PlanNum += item.F_PlanNum;
                    }
                    else
                    {
                        item.F_RunSort = sort;
                        detailList.Add(item);
                        sort++;
                    }
                }
                if (detailList.Count > 0)
                {
                    await uniwork.Insert(detailList);
                }
                count++;
            }
            uniwork.Commit();
        }
        /// <summary>
        /// 完成订单：根据销售订单生成销售发货单，并标记订单完成
        /// </summary>
        public async Task FinishForm(string keyValue)
        {
            var order = await repository.FindEntity(keyValue);
            if (order == null)
            {
                throw new Exception("销售订单不存在");
            }
            if (order.F_EnabledMark != true)
            {
                throw new Exception("请先启用销售订单，再生成发货单");
            }
            if (order.F_IsFinish == true)
            {
                throw new Exception("销售订单已完成，不能重复生成发货单");
            }
            if (uniwork.IQueryable<SalesDeliveryEntity>(a => a.F_SalesOrderId == keyValue && a.F_DeleteMark == false).Any())
            {
                throw new Exception("该销售订单已生成过发货单");
            }
            var details = uniwork.IQueryable<SalesOrderDetailEntity>(a => a.F_SalesOrderId == keyValue).ToList();
            if (details.Count == 0)
            {
                throw new Exception("销售订单没有明细，无法生成发货单");
            }
            SalesDeliveryEntity delivery = new SalesDeliveryEntity();
            delivery.F_DeliveryCode = "SD-" + DateTime.Now.ToString("yyyyMMddHHmmss");
            delivery.F_SalesOrderId = order.F_Id;
            delivery.F_Customer = order.F_Customer;
            delivery.F_DeliveryDate = DateTime.Now;
            delivery.F_TotalMoney = order.F_TotalMoney;
            delivery.F_Description = "由销售订单" + order.F_SalesOrderCode + "完成生成";
            delivery.F_DeleteMark = false;
            delivery.F_EnabledMark = false;
            delivery.Create();
            List<SalesDeliveryDetailEntity> deliveryDetails = new List<SalesDeliveryDetailEntity>();
            foreach (var item in details)
            {
                deliveryDetails.Add(new SalesDeliveryDetailEntity
                {
                    F_Id = Utils.GuId(),
                    F_DeliveryId = delivery.F_Id,
                    F_MaterialId = item.F_MaterialId,
                    F_NeedNum = item.F_NeedNum,
                    F_Price = item.F_Price
                });
            }
            uniwork.BeginTrans();
            await uniwork.Insert(delivery);
            await uniwork.Insert(deliveryDetails);
            await repository.Update(a => a.F_Id == keyValue, a => new SalesOrderEntity
            {
                F_IsFinish = true,
                F_ActualOverTime = DateTime.Now
            });
            uniwork.Commit();
        }
        /// <summary>
        /// 递归展开BOM生成工单明细（带循环保护）
        /// </summary>
        private void GetBomDetail(WorkOrderDetailEntity parent, List<WorkOrderDetailEntity> list, List<string> visited)
        {
            var bomList = uniwork.IQueryable<BomFormEntity>(a => a.F_MaterialId == parent.F_MaterialId && a.F_BomType == 1).ToList();
            if (bomList.Count != 0)
            {
                foreach (var item in bomList)
                {
                    if (visited.Contains(item.F_SonMaterialId))
                    {
                        continue;
                    }
                    WorkOrderDetailEntity detail = new WorkOrderDetailEntity();
                    detail.F_MaterialId = item.F_SonMaterialId;
                    detail.Create();
                    detail.F_BadNum = 0;
                    detail.F_PlanNum = parent.F_PlanNum * item.F_Num;
                    detail.F_DoneNum = 0;
                    detail.F_DeleteMark = false;
                    detail.F_EnabledMark = parent.F_EnabledMark;
                    detail.F_PlanEndTime = parent.F_PlanEndTime;
                    detail.F_PlanStartTime = parent.F_PlanStartTime;
                    detail.F_Description = parent.F_Description;
                    detail.F_WorkOrderId = parent.F_WorkOrderId;
                    detail.F_RunSort = parent.F_RunSort - 1;
                    detail.F_WorkOrderState = 0;
                    list.Add(detail);
                    var childVisited = new List<string>(visited);
                    childVisited.Add(item.F_SonMaterialId);
                    GetBomDetail(detail, list, childVisited);
                }
            }
            else
            {
                list.Remove(parent);
            }
        }
        #endregion
    }
}
