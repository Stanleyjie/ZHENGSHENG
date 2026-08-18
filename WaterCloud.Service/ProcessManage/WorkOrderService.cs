using System;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;
using WaterCloud.Code;
using Chloe;
using WaterCloud.Domain.ProcessManage;
using WaterCloud.Domain.MaterialManage;
using WaterCloud.Domain.SystemOrganize;
using WaterCloud.Service.SystemManage;
using System.Net.Http;
using static Serenity.Web.PropertyItemsScript;

namespace WaterCloud.Service.ProcessManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2020-12-07 12:14
    /// 描 述：工单管理服务类
    /// </summary>
    public class WorkOrderService : DataFilterService<WorkOrderEntity>, IDenpendency
    {
        private ItemsDataService itemsApp;
        private WorkOrderRunService orderApp { get; set; }
        public WorkOrderService(IDbContext context, IHttpClientFactory httpClientFactory) : base(context)
        {
            orderApp = new WorkOrderRunService(context, httpClientFactory);
            itemsApp = new ItemsDataService(context);
        }
        #region 获取数据
        public async Task<List<WorkOrderEntity>> GetList(string keyword = "")
        {
            var cachedata = repository.IQueryable();
            if (!string.IsNullOrEmpty(keyword))
            {
                //此处需修改
                cachedata = cachedata.Where(t => t.F_WorkOrderCode.Contains(keyword) || t.F_Description.Contains(keyword));
            }
            return cachedata.Where(t => t.F_DeleteMark == false).OrderByDesc(t => t.F_CreatorTime).ToList();
        }

        public async Task<List<WorkOrderEntity>> GetLookList(string keyword = "")
        {
            var query =repository.IQueryable().Where(t => t.F_DeleteMark == false);
            if (!string.IsNullOrEmpty(keyword))
            {
                //此处需修改
                query = query.Where(u => u.F_WorkOrderCode.Contains(keyword) || u.F_Description.Contains(keyword));
            }
            query = GetDataPrivilege("u","",query);
            return query.OrderByDesc(t => t.F_CreatorTime).ToList();
        }


        public async Task<List<WorkOrderExtend>> GetLookList(SoulPage<WorkOrderExtend> pagination, string keyword = "", string id = "")
        {
            //反格式化显示只能用"等于"，其他不支持
            Dictionary<string, Dictionary<string, string>> dic = new Dictionary<string, Dictionary<string, string>>();
            var setList = await itemsApp.GetItemList("Mes_WorkOrderState");
            Dictionary<string, string> stateTemp = new Dictionary<string, string>();
            foreach (var item in setList)
            {
                stateTemp.Add(item.F_ItemName, item.F_ItemCode);
            }
            dic.Add("F_WorkOrderState", stateTemp);
            pagination = ChangeSoulData(dic, pagination);
            var query = GetQuery().Where(t => t.F_DeleteMark == false);
            if (!string.IsNullOrEmpty(keyword))
            {
                //此处需修改
                query = query.Where(u => u.F_WorkOrderCode.Contains(keyword) 
                || u.F_MaterialCode.Contains(keyword) || u.F_MaterialName.Contains(keyword));
            }
            if(!string.IsNullOrEmpty(id))
            {
                query= query.Where(u=>u.F_Id==id);
            }
            query = GetDataPrivilege("u", "", query);
            return await repository.OrderList(query, pagination);
        }

        public async Task<List<WorkOrderDetailExtend>> GetSplitListJson(string keyValue, float num, int type)
        {
            WorkOrderDetailEntity detail = new WorkOrderDetailEntity();
            detail.F_MaterialId = keyValue;
            detail.Create();
            detail.F_BadNum = 0;
            detail.F_PlanNum = num;
            detail.F_DoneNum = 0;
            detail.F_DeleteMark = false;
            detail.F_EnabledMark = true;
            detail.F_RunSort = 0;
            detail.F_WorkOrderState = 0;
            List<WorkOrderDetailEntity> list = new List<WorkOrderDetailEntity>();
            list.Add(detail);
            if (type==1)
            {
                GetDetailByBom(detail, list);
            }
            int? cout = list.Select(a => a.F_RunSort).ToList().Min();
            //构造扩展类
            List<WorkOrderDetailExtend> results = new List<WorkOrderDetailExtend>();
            foreach (var item in list)
            {
                item.F_RunSort -= cout - 1;
                var temp = item.MapTo<WorkOrderDetailExtend>();
                var material =await  uniwork.FindEntity<MaterialEntity>(temp.F_MaterialId);
                temp.F_MaterialCode = material.F_MaterialCode;
                temp.F_MaterialType = material.F_MaterialType;
                temp.F_MaterialName = material.F_MaterialName;
                temp.F_MaterialUnit = material.F_MaterialUnit;
                var process = uniwork.IQueryable<BomFormEntity>(a => a.F_BomType == 1 && a.F_MaterialId == temp.F_MaterialId)
                    .InnerJoin<ProcessFlowEntity>((a, b) => a.F_ProcessId == b.F_Id).Select((a, b) => b).FirstOrDefault();
                if (process!=null)
                {
                    temp.F_ProcessId = process.F_Id;
                    temp.F_ProcessName = process.F_ProcessFlowName;
                }
                else
                {
                    return null;
                }
                results.Add(temp);
            }
            return results.OrderBy(a=>a.F_RunSort).ToList();
        }
        public async Task<WorkOrderEntity> GetForm(string keyValue)
        {
            var cachedata = await repository.FindEntity(keyValue);
            return cachedata;
        }

        public async Task<WorkOrderExtend> GetLookForm(string keyValue)
        {
            var query = GetQuery().Where(a => a.F_Id == keyValue.ToString());
            var data = GetFieldsFilterData(query.FirstOrDefault());
            data.details =await orderApp.GetListByOrder(keyValue);
            data.planDate = ((DateTime)data.F_PlanStartTime).Date;
			var classNums = await itemsApp.GetItemList("Mes_ClassNumber");
			var tempStartTime = TimeSpan.Parse(classNums[0].F_Description.Split("-")[0]).TotalMinutes;
			var tempEndTime = TimeSpan.Parse(classNums[0].F_Description.Split("-")[1]).TotalMinutes;
            if (classNums.Count() == 1)
            {
				data.classNum = classNums[0].F_ItemCode;
			}
            else
            {
				tempEndTime = tempStartTime;
				for (int i = 0; i < classNums.Count(); i++)
				{
					var startTime = TimeSpan.Parse(classNums[i].F_Description.Split("-")[0]).TotalMinutes;
					var endTime = TimeSpan.Parse(classNums[i].F_Description.Split("-")[1]).TotalMinutes;
					if (endTime > startTime)
					{
						tempEndTime += endTime - startTime;
					}
					else
					{
						tempEndTime += endTime + 24 * 60 - startTime;
					}
					if (((DateTime)data.planDate).AddMinutes(tempStartTime) == data.F_PlanStartTime && ((DateTime)data.planDate).AddMinutes(tempEndTime) == data.F_PlanEndTime)
					{
						data.classNum = classNums[i].F_ItemCode;
						break;
					}
					tempStartTime = tempEndTime;
				}
			}
			return data;
        }
        private IQuery<WorkOrderExtend> GetQuery()
        {
            //获取数据权限
            var cout =  uniwork.IQueryable<WorkOrderDetailEntity>().GroupBy(a => a.F_WorkOrderId).Select(a => new { a.F_WorkOrderId, F_OrderNum = Sql.Count() });
            var query = repository.IQueryable(a => a.F_DeleteMark == false).LeftJoin<MaterialEntity>((a, b) => a.F_MaterialId == b.F_Id)
                .LeftJoin<UserEntity>((a,b,c)=>a.F_CreatorUserId==c.F_Id)
                .LeftJoin(cout,(a, b, c,d)=> a.F_Id == d.F_WorkOrderId)
                .Select((a, b,c,d) => new WorkOrderExtend
                {
                    F_BadNum = a.F_BadNum,
                    F_CreatorTime = a.F_CreatorTime,
                    F_CreatorUserId = a.F_CreatorUserId,
                    F_DeleteMark = a.F_DeleteMark,
                    F_Description = a.F_Description,
                    F_DoneNum = a.F_DoneNum,
                    F_EnabledMark = a.F_EnabledMark,
                    F_MaterialId = a.F_MaterialId,
                    F_PlanEndTime = a.F_PlanEndTime,
                    F_PlanStartTime = a.F_PlanStartTime,
                    F_PlanNum = a.F_PlanNum,
                    F_RealEndTime = a.F_RealEndTime,
                    F_RealStartTime = a.F_RealStartTime,
                    F_WorkOrderCode = a.F_WorkOrderCode,
                    F_WorkOrderState = a.F_WorkOrderState,
                    F_Id = a.F_Id,
                    F_OrderNum=d.F_OrderNum,
                    F_CreatorUserName = c.F_RealName,
                    F_MaterialCode = b.F_MaterialCode,
                    F_MaterialDescription = b.F_MaterialDescription,
                    F_MaterialName = b.F_MaterialName,
                    F_MaterialSize = b.F_MaterialSize,
                    F_MaterialUnit = b.F_MaterialUnit,
                    F_SplitType=a.F_SplitType,
                    F_SalesOrderCode=a.F_SalesOrderCode,
                    F_SalesOrderId=a.F_SalesOrderId,
                    F_SalesOrderDetailId=a.F_SalesOrderDetailId
                });
            return query;
        }
        public async Task<Flow> GetFlow(string keyValue)
        {
            Flow flow = new Flow();
            flow.initNum = 2;
            flow.title = "工序步骤";
            var details = await orderApp.GetListByOrder(keyValue);
            int max = details.Max(a => a.F_RunSort)??0;
            int min = details.Min(a => a.F_RunSort)??0;
            flow.nodes = new List<FlowNode>();
            float allnum = details.GroupBy(a => a.F_RunSort).Select(a=>new {a.Key,num=a.Count() }).Max(a=>a.num);
            int alllength = (int)(150 * (allnum+1));
            for (int i = min; i <= max; i++)
            {
                var temp = details.Where(a => a.F_RunSort == i).ToList();
                int tempnum = temp.Count();
                int count = 1;
                foreach (var item in temp)
                {
                    FlowNode node = new FlowNode();
					if (i==min)
					{
                        node.type = "start  round";
                        node.width = 120;
                        //node.left -= 60;
                    }
					else if (i == max)
					{
                        node.type = "end  round";
                        node.width = 120;
                        //node.left -= 60;
                    }
					else
					{
                        node.type = "node";
                        //node.left -= 60;
                    }

                    node.alt = true;
                    node.id = item.F_Id;
                    node.name = item.F_ProcessName;
                    node.left = alllength * count / (tempnum + 1);

                    node.top = 100 + (i - 1) * 100;
                    node.setInfo = new Setinfo();
                    node.setInfo.Taged = item.F_WorkOrderState;
                    node.setInfo.UserName = item.F_EqpName;
                    node.setInfo.UserId = item.F_EqpId;
                    node.setInfo.TagedTime = item.F_RealEndTime == null ? "" : ((DateTime)item.F_RealEndTime).ToString("yyyy-MM-dd  HH:ss");
                    node.setInfo.Description = "物料编号：" + item.F_MaterialCode + "\r\n" + "物料名称：" + item.F_MaterialName + "\r\n" + "计划数量：" + item.F_PlanNum
                        + "\r\n" + "完成数量：" + item.F_DoneNum + "\r\n" + "不良数量：" + item.F_BadNum;
                    flow.nodes.Add(node);
                    count++;
                    flow.initNum++;
                }
            }
            flow.lines = new List<FlowLine>();
            foreach (var item in details.OrderBy(a=>a.F_RunSort))
            {
                var detail = details.Where(a => a.F_RunSort > item.F_RunSort).OrderBy(a => a.F_RunSort).FirstOrDefault();
                if (detail==null)
                {
                    continue;
                }
                var minRunSort = detail.F_RunSort;
                var temps = details.Where(a => a.F_RunSort == minRunSort).ToList();
                foreach (var temp in temps)
                {
                    //查找bom表，没有关系就不连接
                    var bom = uniwork.FindEntity<BomFormEntity>(a => a.F_MaterialId == temp.F_MaterialId && a.F_SonMaterialId == item.F_MaterialId&&a.F_BomType==1);
                    if (bom!=null&& flow.lines.Where(a=>a.from==item.F_MaterialId&&a.to==temp.F_MaterialId).Count()==0)
                    {
                        FlowLine line = new FlowLine();
                        line.id = Utils.CreateNo();
                        line.type = "sl";
                        line.name = "";
                        line.M = 0;
                        line.dash = false;
                        line.alt = true;
                        line.from = item.F_Id;
                        line.to = temp.F_Id;
                        flow.lines.Add(line);
                        flow.initNum++;
                    }
                }
            }
            flow.areas = new List<FlowArea>();
            return flow;
        }
        #endregion

        //统一从生产计划创建工单，不可从工单管理创建工单，因为工单管理里面工序选择功能未添加
        #region 提交数据
        public async Task SubmitForm(WorkOrderExtend entity, string keyValue)
        {
            List<WorkOrderDetailEntity> list = new List<WorkOrderDetailEntity>();
			var classNums = await itemsApp.GetItemList("Mes_ClassNumber");
			var tempStartTime = TimeSpan.Parse(classNums[0].F_Description.Split("-")[0]).TotalMinutes;
			var tempEndTime = TimeSpan.Parse(classNums[0].F_Description.Split("-")[1]).TotalMinutes;
            if (classNums.Count() == 1)
            {
				entity.F_PlanStartTime = ((DateTime)entity.planDate).AddMinutes(tempStartTime);
				entity.F_PlanEndTime = ((DateTime)entity.planDate).AddMinutes(tempEndTime);
			}
            else
            {
                tempEndTime = tempStartTime;
                for (int i = 0; i < classNums.Count(); i++)
                {
                    var startTime = TimeSpan.Parse(classNums[i].F_Description.Split("-")[0]).TotalMinutes;
                    var endTime = TimeSpan.Parse(classNums[i].F_Description.Split("-")[1]).TotalMinutes;
                    if (endTime > startTime)
                    {
                        tempEndTime += endTime - startTime;
                    }
                    else
                    {
                        tempEndTime += endTime + 24 * 60 - startTime;
                    }
                    if (classNums[i].F_ItemCode == entity.classNum)
                    {
                        entity.F_PlanStartTime = ((DateTime)entity.planDate).AddMinutes(tempStartTime);
                        entity.F_PlanEndTime = ((DateTime)entity.planDate).AddMinutes(tempEndTime);
                    }
                    tempStartTime = tempEndTime;
                }
            }
			uniwork.BeginTrans();
            if (string.IsNullOrEmpty(keyValue))
            {
                entity.F_DeleteMark = false;
                entity.F_EnabledMark = true;
                entity.F_WorkOrderState = 0;//添写初始化参数;
                entity.F_OrderNum = entity.details.Count;
                entity.F_DoneNum = 0;
                entity.F_BadNum = 0;
                entity.Create();
                //uniwork.BeginTrans();
                await repository.Insert(entity);
                if (entity.details != null && entity.details.Count > 0)
                {
                    foreach (var item in entity.details)
                    {
                        var temp = item.MapTo<WorkOrderDetailEntity>();
                        temp.Create();
                        temp.F_CreatorUserId = entity.F_CreatorUserId;
                        temp.F_BadNum = 0;
                        temp.F_DeleteMark = false;
                        temp.F_EnabledMark = true;
                        temp.F_PlanStartTime = entity.F_PlanStartTime;
                        temp.F_PlanEndTime = entity.F_PlanEndTime;
                        temp.F_WorkOrderId = entity.F_Id;
                        temp.F_WorkOrderState = 0;
                        list.Add(temp);
                    }
                    await uniwork.Insert(list);
                }
            }
            else
            {
                var order = await repository.FindEntity(keyValue);
                //等待状态工单可进行拆分等修改操作
                if (order.F_WorkOrderState == 0)
                {
                    if (order.F_WorkOrderState > 0)
                    {
                        throw new Exception("工单已开始作业，无法修改");
                    }
                    if (uniwork.IQueryable<WorkOrderDetailEntity>(a => a.F_WorkOrderId == keyValue && a.F_WorkOrderState > 0).Count() > 0)
                    {
                        throw new Exception("工单已开始作业，无法修改");
                    }
                    entity.Modify(keyValue);
                    entity.F_OrderNum = entity.details.Count;
                    if (entity.details != null && entity.details.Count > 0)
                    {
                        foreach (var item in entity.details)
                        {
                            var temp = item.MapTo<WorkOrderDetailEntity>();
                            temp.Create();
                            temp.F_CreatorUserId = entity.F_CreatorUserId;
                            temp.F_BadNum = 0;
                            temp.F_DeleteMark = false;
                            temp.F_EnabledMark = true;
                            temp.F_PlanStartTime = entity.F_PlanStartTime;
                            temp.F_PlanEndTime = entity.F_PlanEndTime;
                            temp.F_WorkOrderId = entity.F_Id;
                            temp.F_WorkOrderState = 0;
                            list.Add(temp);
                        }
                    }
                    await repository.Update(entity);
                    await uniwork.Delete<WorkOrderDetailEntity>(a => a.F_WorkOrderId == keyValue);
                    await uniwork.Insert(list);
                }
                //工单作业后只能修改计划数量
                else if(order.F_WorkOrderState>0)
                {
                    entity.Modify(keyValue);
                    await repository.Update(t =>t.F_Id==entity.F_Id,t=> new WorkOrderEntity {
                        F_PlanNum=entity.F_PlanNum,
                        F_LastModifyTime=entity.F_LastModifyTime,
                        F_LastModifyUserId=entity.F_LastModifyUserId
                    });
                    if (entity.details != null && entity.details.Count > 0)
                    {
                        foreach (var item in entity.details)
                        {
                            await uniwork.Update<WorkOrderDetailEntity>(t => t.F_Id == item.F_Id, t => new WorkOrderDetailEntity
                            {
                                F_PlanNum = item.F_PlanNum,
                                F_LastModifyTime = entity.F_LastModifyTime,
                                F_LastModifyUserId = entity.F_LastModifyUserId
                            });
                        }
                    }
                }
                //更新工单对应生产计划的计划数量
                await uniwork.Update<WorkPlanEntity>(t => t.F_Id == order.F_WorkPlanId, t => new WorkPlanEntity
                {
                    F_PlanNum = entity.F_PlanNum,
                    F_LastModifyTime = entity.F_LastModifyTime,
                    F_LastModifyUserId = entity.F_LastModifyUserId
                });
            }
            uniwork.Commit();
        }

        public async Task DeleteForm(string keyValue)
        {
            var ids = keyValue.Split(',');
            if (repository.IQueryable().Where(t => ids.Contains(t.F_Id.ToString()) && t.F_WorkOrderState > 0).Count() > 0)
            {
                throw new Exception("工单已开始作业");
            }
            var plans = repository.IQueryable(t => ids.Contains(t.F_Id.ToString())).Select(a => a.F_WorkPlanId).ToList();
            uniwork.BeginTrans();
            await uniwork.Delete<WorkPlanEntity>(t => plans.Contains(t.F_Id.ToString()));
            await repository.Delete(t => ids.Contains(t.F_Id.ToString()));
            await uniwork.Delete<WorkOrderDetailEntity>(t => ids.Contains(t.F_WorkOrderId.ToString()));
            uniwork.Commit();
        }

        public async Task SplitForm(string keyValue)
        {
            //判断工单状态
            var order =await repository.FindEntity(keyValue);
            if (order.F_WorkOrderState>0)
            {
                throw new Exception("工单已开始作业");
            }
            WorkOrderDetailEntity detail = new WorkOrderDetailEntity();
            detail.F_MaterialId = order.F_MaterialId;
            detail.Create();
            detail.F_BadNum = 0;
            detail.F_PlanNum = order.F_PlanNum;
            detail.F_DoneNum = order.F_DoneNum;
            detail.F_DeleteMark = false;
            detail.F_EnabledMark = order.F_EnabledMark;
            detail.F_PlanEndTime = order.F_PlanEndTime;
            detail.F_PlanStartTime = order.F_PlanStartTime;
            detail.F_Description = order.F_Description;
            detail.F_WorkOrderId = order.F_Id;
            detail.F_RunSort =0;
            detail.F_WorkOrderState = 0;
            List<WorkOrderDetailEntity> list = new List<WorkOrderDetailEntity>();
            list.Add(detail);
            GetDetailByBom(detail, list);
            list= list.OrderBy(a=>a.F_RunSort).ToList();
            //合并工单（无序）
            List<WorkOrderDetailEntity> detailList = new List<WorkOrderDetailEntity>();
            int count = 1;
            foreach (var item in list)
			{
				if (detailList.Where(a=>a.F_MaterialId==item.F_MaterialId).Count()>0)
				{
                    detailList.Find(a => a.F_MaterialId == item.F_MaterialId).F_PlanNum += item.F_PlanNum;
                }
				else
				{
                    item.F_RunSort = count;
                    detailList.Add(item);
                    count++;
                }
			}
            if (detailList.Count>0)
            {
                uniwork.BeginTrans();
                await uniwork.Delete<WorkOrderDetailEntity>(a => a.F_WorkOrderId == keyValue);
                await uniwork.Insert(detailList);
                uniwork.Commit();
            }
            ////不合并工单（有序）
            //int? cout = list.Select(a => a.F_RunSort).ToList().Min();
            //foreach (var item in list)
            //{
            //    item.F_RunSort -= cout - 1;
            //}
            //if (list.Count > 0)
            //{
            //    uniwork.BeginTrans();
            //    await uniwork.Delete<WorkOrderDetailEntity>(a => a.F_WorkOrderId == keyValue);
            //    await uniwork.Insert(list);
            //    uniwork.Commit();
            //}
        }
        //递归获取bom组成
        private void GetDetailByBom(WorkOrderDetailEntity parent, List<WorkOrderDetailEntity> list, HashSet<string> visited = null)
        {
            if (visited == null)
            {
                visited = new HashSet<string>();
            }
            var bomList = uniwork.IQueryable<BomFormEntity>(a => a.F_MaterialId == parent.F_MaterialId && a.F_BomType == 1).ToList();
            if (bomList.Count != 0)
            {
                foreach (var item in bomList)
                {
                    //循环BOM保护
                    if (visited.Contains(item.F_SonMaterialId))
                    {
                        continue;
                    }
                    visited.Add(item.F_SonMaterialId);
                    WorkOrderDetailEntity detail = new WorkOrderDetailEntity();
                    detail.F_MaterialId = item.F_SonMaterialId;
                    detail.Create();
                    detail.F_BadNum = 0;
                    detail.F_PlanNum = parent.F_PlanNum* item.F_Num;
                    detail.F_DoneNum = 0;
                    detail.F_DeleteMark = false;
                    detail.F_EnabledMark = parent.F_EnabledMark;
                    detail.F_PlanEndTime = parent.F_PlanEndTime;
                    detail.F_PlanStartTime = parent.F_PlanStartTime;
                    detail.F_Description = parent.F_Description;
                    detail.F_WorkOrderId = parent.F_WorkOrderId;
                    detail.F_RunSort =parent.F_RunSort-1;
                    detail.F_WorkOrderState = 0;
                    list.Add(detail);
                    GetDetailByBom(detail, list, visited);
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
