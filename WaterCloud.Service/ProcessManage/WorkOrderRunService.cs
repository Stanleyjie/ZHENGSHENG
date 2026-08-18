using System;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;
using WaterCloud.Code;
using Chloe;
using WaterCloud.Domain.ProcessManage;
using WaterCloud.Domain.MaterialManage;
using WaterCloud.Domain.SystemOrganize;
using WaterCloud.Domain.EquipmentManage;
using WaterCloud.Service.SystemManage;
using WaterCloud.Domain.ClassTask;
using WaterCloud.Service.ClassTask;
using System.Net.Http;
using WaterCloud.Domain.QualityManage;

namespace WaterCloud.Service.ProcessManage
{
	/// <summary>
	/// 创 建：超级管理员
	/// 日 期：2020-12-07 12:14
	/// 描 述：工单作业服务类
	/// </summary>
	public class WorkOrderRunService : DataFilterService<WorkOrderDetailEntity>, IDenpendency
    {
        private ItemsDataService itemsApp;
        private ControlJobService jobApp;
        
        public WorkOrderRunService(IDbContext context, IHttpClientFactory httpClientFactory) : base(context)
        {
            itemsApp = new ItemsDataService(context);
            jobApp = new ControlJobService(context, httpClientFactory); 
        }
        #region 获取数据

        public async Task<List<WorkOrderDetailExtend>> GetLookList(SoulPage<WorkOrderDetailExtend> pagination, string keyword = "", string id = "")
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
            var query = GetQuery();
            if (!string.IsNullOrEmpty(keyword))
            {
                //此处需修改
                query = query.Where(u => u.F_WorkOrderCode.Contains(keyword) 
                || u.F_MaterialCode.Contains(keyword) || u.F_MaterialName.Contains(keyword) || u.F_WorkOrderCode.Contains(keyword));
            }
            if(!string.IsNullOrEmpty(id))
            {
                query= query.Where(u=>u.F_Id==id);
            }
            query = GetDataPrivilege("u", "", query);
            return await repository.OrderList(query, pagination);
        }

		public async Task<List<UserEntity>> GetWorkUser(string eqpId,string ids)
		{
            var query = uniwork.IQueryable<ControlJobUserBandingEntity>(a => (a.F_EqpId == eqpId || a.F_EqpId == null || a.F_EqpId == "") && a.F_JobType == 5)
                .InnerJoin<UserEntity>((a, b) => a.F_UserId == b.F_Id && b.F_DeleteMark == false && b.F_EnabledMark == true)
                .Select((a, b) => b);
            if (!string.IsNullOrEmpty(ids))
			{
                var temps = ids.Split(',');
                query = query.Where(a => !temps.Contains(a.F_Id));
			}
            return query.OrderBy(a => a.F_CreatorTime).ToList();
		}

		public async Task<List<EqpMaterialUseEntity>> GetUseTransferList(string eqpName)
		{
            var data = uniwork.IQueryable<EqpMaterialUseEntity>(a => a.F_EqpName==eqpName&&a.F_DoneNum!=a.F_Num).OrderBy(a => a.F_TransferBoxCode).ToList();
            return data;
        }
		public async Task<List<EquipmentEntity>> GetHaveUseEqpList(string keyword)
		{
            var eqps = uniwork.IQueryable<EqpMaterialUseEntity>(a => a.F_DoneNum != a.F_Num).GroupBy(a => a.F_EqpId).Select(a => a.F_EqpId)
                .Distinct().ToList();
            var data= uniwork.IQueryable<EquipmentEntity>(a => eqps.Contains(a.F_Id)).OrderBy(a => a.F_EqpName).ToList();
            return data;
        }

        public async Task<List<EquipmentEntity>> GetHaveOutEqpList(string keyword)
        {
            var eqps = uniwork.IQueryable<OutPutInfoEntity>(a => a.F_IsTemp == true).GroupBy(a => a.F_EqpId).Select(a => a.F_EqpId)
                .Distinct().ToList();
            var data = uniwork.IQueryable<EquipmentEntity>(a => eqps.Contains(a.F_Id)).OrderBy(a => a.F_EqpName).ToList();
            return data;
        }
        public async Task<List<OutPutInfoEntity>> GetOutTransferList(string eqpName)
        {
            var checkids = uniwork.IQueryable<NeedCheckEntity>(a => a.F_IsCheck == false && a.F_CheckType == 2).Select(a => a.F_SourceId).ToList();
            var data = uniwork.IQueryable<OutPutInfoEntity>(a => a.F_EqpName == eqpName && a.F_IsTemp == true).Where(a=>!checkids.Contains(a.F_Id.ToString())).OrderBy(a => a.F_BandingTime).ToList();
            var list = new List<OutPutInfoEntity>();
            foreach (var item in data)
            {
                var temp = list.Where(a => a.F_TransferBoxCode == item.F_TransferBoxCode).FirstOrDefault();
                if (temp == null)
                {
                    list.Add(item);
                }
                else
                {
                    temp.F_Num += item.F_Num;
                }
            }
            return list;
        }

        public async Task<List<EquipmentEntity>> GetUsingEqpList(string keyword)
		{
            var query = uniwork.IQueryable<WorkOrderDetailEntity>(a=>a.F_WorkOrderState == 1)
                .InnerJoin<WorkOrderDetailEqpBandingEntity>((a, b) => a.F_Id == b.F_WorkOrderDetailId && b.F_IsMaster == true)
                .InnerJoin<EquipmentEntity>((a,b,c)=>b.F_EqpId == c.F_Id).Select((a,b,c)=>c);
            return query.Distinct().OrderBy(a => a.F_EqpName).ToList();
        }

		public async Task<List<WorkOrderDetailExtend>> GetListByOrder(string keyValue)
        {

            var query = GetQuery().Where(a => a.F_WorkOrderId == keyValue);
            return query.OrderBy(a=>a.F_RunSort).ToList();
        }
        public async Task<List<EquipmentEntity>> GetAddList(string keyValue, string materialId, string ids)
        {
            if (!string.IsNullOrEmpty(materialId))
            {

                var query = uniwork.IQueryable<MaterialEqpBandingEntity>(a => a.F_MaterialId == materialId).InnerJoin<EquipmentEntity>((a, b) => a.F_EqpId == b.F_Id && b.F_EqpState < 2).Select((a, b) => b);
                if (!string.IsNullOrEmpty(ids))
                {
                    var temps = ids.Split(',');
                    query = query.Where(a => temps.Contains(a.F_Id));
                }
                return query.OrderBy(a=>a.F_EqpName).ToList();
            }
            else
            {
                var query = uniwork.IQueryable<ProcessEqpBandingEntity>(a => a.F_ProcessId == keyValue).InnerJoin<EquipmentEntity>((a, b) => a.F_EqpId == b.F_Id && b.F_EqpState < 2).Select((a, b) => b);
                return query.OrderBy(a => a.F_EqpName).ToList();
            }
        }

        public async Task<WorkOrderDetailExtend> GetLookForm(object keyValue)
        {
            var query = GetQuery().Where(a => a.F_Id == keyValue.ToString());
            var data = GetFieldsFilterData(query.FirstOrDefault());
            data.listData = repository.IQueryable(a => a.F_Id == data.F_Id).InnerJoin<WorkOrderDetailEqpBandingEntity>((a, b) => a.F_Id == b.F_WorkOrderDetailId)
                .InnerJoin<EquipmentEntity>((a, b, c) => b.F_EqpId == c.F_Id).Select((a, b, c) => new EquipmentEntity { 
                F_Id=c.F_Id,
                F_EqpName=c.F_EqpName,
                F_EqpState=c.F_EqpState,
                F_EqpType=c.F_EqpType,
                F_EqpUse=c.F_EqpUse,
                F_MoldingNum=c.F_MoldingNum,
                F_IsMaster=b.F_IsMaster,
                F_MouldType=c.F_MouldType,
                F_MouldNum=b.F_MouldNum,
                F_IsOtherEqp=c.F_IsOtherEqp,
                F_Description=c.F_Description
                }).OrderByDesc(a=>a.F_IsMaster).ToList().ToJson();
            data.list = uniwork.IQueryable<OutPutInfoEntity>(a => a.F_WorkOrderDetailId == keyValue.ToString()).ToList();
            data.list = data.list.OrderBy(a => a.F_LocationCode).ToList();
            var bands = uniwork.IQueryable<WorkDetailTimeBandingEntity>(a => a.F_WorkOrderDetailId == data.F_Id).Select(a => a.F_EqpWorkTimeId).ToList();
			if (bands!=null&& bands.Count>0)
			{
                data.userTimeList = uniwork.IQueryable<EqpWorkTimeEntity>(a =>bands.Contains(a.F_Id)).ToList();
            }
            return data;
        }
        private IQuery<WorkOrderDetailExtend> GetQuery()
        {
            //获取数据权限
            var query = repository.IQueryable(a => a.F_DeleteMark == false).LeftJoin<MaterialEntity>((a, b) => a.F_MaterialId == b.F_Id)
                .LeftJoin<UserEntity>((a,b,c)=>a.F_CreatorUserId==c.F_Id)
                .LeftJoin<WorkOrderEntity>((a,b,c,d)=>a.F_WorkOrderId==d.F_Id)
                .LeftJoin<WorkOrderDetailEqpBandingEntity>((a,b,c,d,e)=>a.F_Id==e.F_WorkOrderDetailId&&e.F_IsMaster==true)
                .Select((a, b,c,d,e) => new WorkOrderDetailExtend
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
                    F_WorkOrderCode = d.F_WorkOrderCode,
                    F_WorkOrderState = a.F_WorkOrderState,
                    F_Id = a.F_Id,
                    F_CreatorUserName = c.F_RealName,
                    F_MaterialCode = b.F_MaterialCode,
                    F_MaterialName = b.F_MaterialName,
                    F_MaterialType = b.F_MaterialType,
                    F_MaterialUnit = b.F_MaterialUnit,
                    F_EqpId=e.F_EqpId,
                    F_RunSort = a.F_RunSort,
                    F_WorkOrderId=a.F_WorkOrderId,
                });
            //var bomQuery = uniwork.IQueryable<BomFormEntity>().Where(a=> a.F_BomType == 1).GroupBy(a => a.F_MaterialId).AndBy(a => a.F_ProcessId).Select(a => new { a.F_MaterialId, a.F_ProcessId });
            var bomQuery = uniwork.IQueryable<WorkOrderDetailProcessBandingEntity>();
            //query=query.LeftJoin(bomQuery,(a, b) => a.F_MaterialId == b.F_MaterialId)
            query = query.LeftJoin(bomQuery, (a, b) => a.F_Id == b.F_WorkOrderDetailId)
                .LeftJoin<ProcessFlowEntity>((a, b, c) => b.F_ProcessId == c.F_Id)
                .LeftJoin<EquipmentEntity>((a, b, c, d) => a.F_EqpId == d.F_Id && d.F_EqpType == 0)
                .Select((a, b, c, d) => new WorkOrderDetailExtend {
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
                    F_CreatorUserName = a.F_CreatorUserName,
                    F_MaterialCode = a.F_MaterialCode,
                    F_MaterialName = a.F_MaterialName,
                    F_MaterialType = a.F_MaterialType,
                    F_MaterialUnit = a.F_MaterialUnit,
                    F_RunSort=a.F_RunSort,
                    F_EqpId = a.F_EqpId,
                    F_EqpName=d.F_EqpName,
                    F_ProcessId=b.F_ProcessId,
                    F_ProcessName=c.F_ProcessFlowName,
                    F_WorkOrderId=a.F_WorkOrderId,
                });
            return query;
        }

        public async Task<List<WorkOrderDetailExtend>> GetWorkOrder(string eqpName, string keyword)
        {
            var query = GetQuery().Where(a => a.F_EqpName == eqpName && a.F_WorkOrderState == 1 && a.F_EnabledMark == true && a.F_DeleteMark == false);
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(a => a.F_EqpName.Contains(keyword) || a.F_MaterialCode.Contains(keyword) || a.F_MaterialName.Contains(keyword));
            }
            return query.OrderBy(a => a.F_CreatorTime).ToList();
        }
        #endregion


        #region 提交数据

        public async Task SubmitForm(string keyValue, string listData, string userTimeList, int F_MouldNum = 0)
        {
            var workdetail = await repository.FindEntity(keyValue);
            var eqpList = listData.ToList<EquipmentEntity>();
            var ids = eqpList.Select(a => a.F_Id).ToList();
            var useList = userTimeList.ToList<EqpWorkTimeEntity>();
            var temps = eqpList.Select(a => a.F_Id).ToList();
            var items = await itemsApp.GetItemList("Mes_MoveEqpSetting");
            var moulditems = items.FirstOrDefault(a => a.F_ItemCode == "2").F_Description.Split(",");
            var fixtureitems = items.FirstOrDefault(a => a.F_ItemCode == "1").F_Description.Split(",");
			var mould = eqpList.Where(a => moulditems.Contains(a.F_EqpUse.ToString())).FirstOrDefault();
			var fixture = eqpList.Where(a => fixtureitems.Contains(a.F_EqpUse.ToString())).FirstOrDefault();
			var master = eqpList.Where(a => a.F_IsMaster == true).FirstOrDefault();
            int mouldCount = 0;
            //检测设备有没有问题
            if (eqpList.Count() != uniwork.IQueryable<EquipmentEntity>(a => ids.Contains(a.F_Id) && a.F_EqpState < 2).Count())
            {
                throw new Exception("设备状态不正常,无法创建工单");
            }
            if (mould != null)
            {
                var mouldEqp = await uniwork.FindEntity<EquipmentEntity>(mould.F_Id);
                mouldCount = uniwork.IQueryable<WorkOrderDetailEqpBandingEntity>(a => mould.F_Id == a.F_EqpId)
                 .InnerJoin<WorkOrderDetailEntity>((a, b) => a.F_WorkOrderDetailId == b.F_Id && b.F_WorkOrderState == 1)
                .Select((a, b) => a.F_MouldNum).ToList().Sum()??0;
                if (mouldEqp.F_MoldingNum < mouldCount + F_MouldNum)
                {
                    throw new Exception("设备正在作业中,无法创建工单");
                }
                if (mouldEqp.F_MoldingNum == 1)
                {
                    mould = null;
                }
            }
            int count = uniwork.IQueryable<WorkOrderDetailEqpBandingEntity>(a => temps.Contains(a.F_EqpId))
             .InnerJoin<WorkOrderDetailEntity>((a, b) => a.F_WorkOrderDetailId == b.F_Id && b.F_WorkOrderState == 1)
            .Select((a, b) => b).Count();
            if (mould == null && fixture==null && count>0)
            {
                throw new Exception("设备正在作业中,无法创建工单");
            }
            //根据设备获取工单,需要的物料
            var detail = uniwork.IQueryable<WorkOrderDetailEntity>(a => a.F_Id == keyValue)
                .InnerJoin<WorkOrderDetailProcessBandingEntity>((a, b) => a.F_Id == b.F_WorkOrderDetailId)
                .InnerJoin<ProcessFlowEntity>((a, b, c) => b.F_ProcessId == c.F_Id)
                .InnerJoin<WorkOrderEntity>((a, b, c, d) => a.F_WorkOrderId == d.F_Id)
                .Select((a, b, c, d) => new WorkOrderDetailEntity
                {
                    F_BadNum = a.F_BadNum,
                    F_CreatorTime = a.F_CreatorTime,
                    F_CreatorUserId = a.F_CreatorUserId,
                    F_DeleteMark = a.F_DeleteMark,
                    F_Description = a.F_Description,
                    F_DoneNum = a.F_DoneNum,
                    F_EnabledMark = a.F_EnabledMark,
                    F_Id = a.F_Id,
                    F_MaterialId = a.F_MaterialId,
                    F_PlanEndTime = a.F_PlanEndTime,
                    F_PlanNum =a.F_PlanNum,
                    F_PlanStartTime = a.F_PlanStartTime,
                    F_RunSort = a.F_RunSort,
                    F_WorkOrderId = a.F_WorkOrderId,
                    F_WorkOrderState = a.F_WorkOrderState,
                    F_ProcessId = b.F_ProcessId,
                    F_ProcessName = c.F_ProcessFlowName,
                    F_WorkOrderCode = d.F_WorkOrderCode
                })
                .FirstOrDefault();
            if (detail == null)
            {
                throw new Exception("工单明细未绑定工序，无法作业");
            }
            if (detail.F_DoneNum > 0 && workdetail.F_WorkOrderState != 2)
            {
                throw new Exception("工单已经开始执行，无法更改");
            }
            var temptime = ((DateTime)detail.F_PlanStartTime).AddHours(-1);
            var now = DateTime.Now;
            if (!(now>=temptime && now <=detail.F_PlanEndTime))
            {
                throw new Exception("工单请按照计划时间作业，请检查");
            }
            now = workdetail.F_RealStartTime != null? (DateTime)workdetail.F_RealStartTime : DateTime.Now;
            List<WorkOrderDetailEqpBandingEntity> list = new List<WorkOrderDetailEqpBandingEntity>();
            foreach (var item in eqpList)
            {
                var entity = new WorkOrderDetailEqpBandingEntity();
                entity.F_Id = Utils.GuId();
                entity.F_WorkOrderDetailId = keyValue;
                entity.F_EqpType = item.F_EqpType;
                entity.F_EqpId = item.F_Id;
                entity.F_EqpUse = item.F_EqpUse;
                entity.F_MouldNum = 0;
                entity.F_IsMaster = item.F_IsMaster;
                if (moulditems.Contains(item.F_EqpUse.ToString()))
                {
                    var cout = uniwork.IQueryable<WorkOrderDetailEntity>(a => a.F_WorkOrderState == 1 && a.F_Id != keyValue).InnerJoin<WorkOrderDetailEqpBandingEntity>((a, b) => a.F_Id == b.F_WorkOrderDetailId && b.F_EqpUse == 7 && b.F_EqpId == item.F_Id)
                        .Select((a, b) => b.F_MouldNum).ToList().Sum() ?? 0;
                    if (F_MouldNum + cout > item.F_MoldingNum)
                    {
                        throw new Exception("使用数大于模块数，无法作业");
                    }
                    entity.F_MouldNum = F_MouldNum;
                }
                list.Add(entity);
            }
            var masterEqp = eqpList.Where(a => a.F_IsMaster == true).FirstOrDefault();
            var useMaterial = uniwork.IQueryable<EqpMaterialUseEntity>(a => a.F_EqpId == masterEqp.F_Id && a.F_Num != a.F_DoneNum).ToList();
            var sonMaterial = uniwork.IQueryable<BomFormEntity>(a => a.F_MaterialId == detail.F_MaterialId && a.F_BomType == 1&&a.F_ProcessId==detail.F_ProcessId)
                .Select(a => a.F_SonMaterialId).Distinct().ToList();
            //判断有没有不相关的物料退回  模块使用中就无需转换物料
            if (fixture == null && mould == null && useMaterial.Count != useMaterial.Where(a => sonMaterial.Contains(a.F_MaterialId)).Count())
            {
                throw new Exception("设备上有其他物料没有退回");
            }
            uniwork.BeginTrans();
            if (mould == null && fixture == null)
            {
                List<EqpMaterialUseEntity> tempList = new List<EqpMaterialUseEntity>();
                foreach (var material in useMaterial)
                {
                    EqpMaterialUseEntity temp = new EqpMaterialUseEntity();
                    temp.F_Id = 0;
                    temp.F_CreatorTime = material.F_CreatorTime;
                    temp.F_CreatorUserId = material.F_CreatorUserId;
                    temp.F_CreatorUserName = material.F_CreatorUserName;
                    temp.F_Description = material.F_Description;
                    temp.F_Num = material.F_Num - material.F_DoneNum;
                    temp.F_DoneNum = 0;
                    temp.F_EnabledMark = true;
                    temp.F_EqpId = material.F_EqpId;
                    var eqp = await uniwork.FindEntity<EquipmentEntity>(temp.F_EqpId);
                    if (eqp != null)
                    {
                        temp.F_EqpName = eqp.F_EqpName;
                    }
                    temp.F_TransferBoxCode = material.F_TransferBoxCode;
                    temp.F_MaterialId = material.F_MaterialId;
                    temp.F_MaterialBatch = material.F_MaterialBatch;
                    temp.F_MaterialCode = material.F_MaterialCode;
                    temp.F_MaterialName = material.F_MaterialName;
                    temp.F_MaterialUnit = material.F_MaterialUnit;
                    temp.F_MaterialType = material.F_MaterialType;
                    temp.F_WorkOrderId = detail.F_WorkOrderId;
                    temp.F_WorkOrderCode = detail.F_WorkOrderCode;
                    temp.F_WorkOrderRunSort = detail.F_RunSort;
                    temp.F_ProcessId = detail.F_ProcessId;
                    temp.F_ProcessName = detail.F_ProcessName;
                    temp.F_LocationCode = material.F_LocationCode;
                    tempList.Add(temp);
                }
                //批量更新使用记录
                await uniwork.Update<EqpMaterialUseEntity>(a => a.F_EqpId == masterEqp.F_Id && a.F_Num != a.F_DoneNum, a => new EqpMaterialUseEntity
                {
                    F_Num = a.F_DoneNum,
                });
                await uniwork.Delete<EqpMaterialUseEntity>(a => a.F_Num == a.F_DoneNum && a.F_Num == 0);
                await uniwork.Insert(tempList);
            }
            else
            {
                List<EqpMaterialUseEntity> tempList = new List<EqpMaterialUseEntity>();
                foreach (var material in useMaterial.Where(a => sonMaterial.Contains(a.F_MaterialId)))
                {
                    EqpMaterialUseEntity temp = new EqpMaterialUseEntity();
                    temp.F_Id = 0;
                    temp.F_CreatorTime = material.F_CreatorTime;
                    temp.F_CreatorUserId = material.F_CreatorUserId;
                    temp.F_CreatorUserName = material.F_CreatorUserName;
                    temp.F_Description = material.F_Description;
                    temp.F_Num = material.F_Num - material.F_DoneNum;
                    temp.F_DoneNum = 0;
                    temp.F_EnabledMark = true;
                    temp.F_EqpId = material.F_EqpId;
                    var eqp = await uniwork.FindEntity<EquipmentEntity>(temp.F_EqpId);
                    if (eqp != null)
                    {
                        temp.F_EqpName = eqp.F_EqpName;
                    }
                    temp.F_TransferBoxCode = material.F_TransferBoxCode;
                    temp.F_MaterialId = material.F_MaterialId;
                    temp.F_MaterialBatch = material.F_MaterialBatch;
                    temp.F_MaterialCode = material.F_MaterialCode;
                    temp.F_MaterialName = material.F_MaterialName;
                    temp.F_MaterialUnit = material.F_MaterialUnit;
                    temp.F_MaterialType = material.F_MaterialType;
                    temp.F_WorkOrderId = detail.F_WorkOrderId;
                    temp.F_WorkOrderCode = detail.F_WorkOrderCode;
                    temp.F_WorkOrderRunSort = detail.F_RunSort;
                    temp.F_ProcessId = detail.F_ProcessId;
                    temp.F_ProcessName = detail.F_ProcessName;
                    temp.F_LocationCode = material.F_LocationCode;
                    tempList.Add(temp);
                }
                //批量更新使用记录
                await uniwork.Update<EqpMaterialUseEntity>(a => a.F_EqpId == masterEqp.F_Id && a.F_Num != a.F_DoneNum && sonMaterial.Contains(a.F_MaterialId), a => new EqpMaterialUseEntity
                {
                    F_Num = a.F_DoneNum,
                });
                await uniwork.Delete<EqpMaterialUseEntity>(a => a.F_Num == a.F_DoneNum && a.F_Num == 0);
                await uniwork.Insert(tempList);
            }
            await uniwork.Delete<WorkOrderDetailEqpBandingEntity>(a => a.F_WorkOrderDetailId == keyValue);
            await uniwork.Insert(list);
            //新增值班时间
            foreach (var item in useList)
            {
                var timeEntity = uniwork.IQueryable<EqpWorkTimeEntity>().Where(a => a.F_StartTime >= item.F_StartTime && item.F_StartTime <= item.F_EndTime && a.F_UserId == item.F_UserId).FirstOrDefault();
                if (timeEntity == null)
                {
                    item.F_Id = 0;
                    timeEntity = await uniwork.Insert(item);
                }
                var band = new WorkDetailTimeBandingEntity();
                band.F_Id = 0;
                band.F_WorkOrderDetailId = keyValue;
                band.F_EqpWorkTimeId = timeEntity.F_Id;
                await uniwork.Insert(band);
            }
            if (workdetail.F_WorkOrderState != 2)
            {
                //创建任务
                ControlJobEntity jobEntity = new ControlJobEntity();
                jobEntity.F_JobType = 5;
                jobEntity.F_NeedId = keyValue;
                jobEntity.F_Priority = 1;
                jobEntity.F_NeedEqpId = masterEqp.F_Id;
                jobEntity.F_NeedNum = detail.F_PlanNum;
                jobEntity.F_JobCode = "CJ_" + DateTime.Now.ToString("yyyyMMddHHmmss") + 0;
                jobEntity.F_JobInfo = "工单作业,工单号为" + detail.F_WorkOrderCode + ",第" + detail.F_RunSort + "工序为" + detail.F_ProcessName + "的工单开始作业。";
                await jobApp.SubmitForm(jobEntity);
            }
            await uniwork.Update<WorkOrderDetailEntity>(a => a.F_Id == keyValue, a => new WorkOrderDetailEntity
            {
                F_RealStartTime = now,
                F_WorkOrderState = 1
            });
            await uniwork.Update<WorkOrderEntity>(a => a.F_Id == detail.F_WorkOrderId && a.F_RealStartTime == null, a => new WorkOrderEntity
            {
                F_WorkOrderState = 1,
                F_RealStartTime = now
            });
            //更新设备状态
            await uniwork.Update<EquipmentEntity>(a => ids.Contains(a.F_Id) &&a.F_EqpState == 0, a => new EquipmentEntity
            {
                F_EqpState=1
            });
            uniwork.Commit();
        }
        public async Task OverForm(string keyValue)
        {
            var detail = await repository.FindEntity(keyValue);
            uniwork.BeginTrans();
            await repository.Update(a => a.F_Id == keyValue&&a.F_WorkOrderState<=1, a => new WorkOrderDetailEntity
            {
                F_WorkOrderState = 2,
                F_LastModifyUserId =currentuser.UserId,
                F_LastModifyTime =DateTime.Now,
                F_RealEndTime=DateTime.Now
            });
            var query= uniwork.IQueryable<WorkOrderDetailEntity>(a => a.F_WorkOrderId == detail.F_WorkOrderId&&a.F_EnabledMark==true&&a.F_DeleteMark==false);
            var eqp = uniwork.IQueryable<WorkOrderDetailEqpBandingEntity>(a=> a.F_WorkOrderDetailId == keyValue && a.F_IsMaster == true).Select(a => a.F_EqpId).FirstOrDefault();
            if (query.Count() == query.Where(a=>a.F_WorkOrderState==2).Count())
            {
                await uniwork.Update<WorkOrderEntity>(a => a.F_Id == detail.F_WorkOrderId && a.F_WorkOrderState <= 1, a => new WorkOrderEntity
                {
                    F_WorkOrderState = 2,
                    F_LastModifyUserId = currentuser.UserId,
                    F_LastModifyTime = DateTime.Now,
                    F_RealEndTime = DateTime.Now,
                });
            }
            //更新设备状态 排除在用设备
            var ids = uniwork.IQueryable<WorkOrderDetailEqpBandingEntity>(a => a.F_WorkOrderDetailId == keyValue).Select(a => a.F_EqpId).ToList();
            var eqps = uniwork.IQueryable<WorkOrderDetailEntity>(a => a.F_WorkOrderState == 1).InnerJoin<WorkOrderDetailEqpBandingEntity>((a, b) => a.F_Id == b.F_WorkOrderDetailId).Select((a, b) => b.F_EqpId).ToList();
            await uniwork.Update<EquipmentEntity>(a => ids.Contains(a.F_Id) && !eqps.Contains(a.F_Id) && a.F_EqpState == 1, a => new EquipmentEntity
            {
                F_EqpState = 0
            });
            var jobstart= await uniwork.FindEntity<ControlJobEntity>(a => a.F_NeedId == detail.F_Id && a.F_JobType == 5 && a.F_JobState < 2);
            if (jobstart != null)
            {
                await jobApp.FinishJob(jobstart.F_Id);
            }
            var job = await uniwork.FindEntity<ControlJobEntity>(a => a.F_NeedId == detail.F_Id && a.F_JobType == 6 && a.F_JobState < 2);
            if (job != null)
            {
                await jobApp.FinishJob(job.F_Id);
            }
            var jobs = uniwork.IQueryable<ControlJobEntity>(a => a.F_NeedEqpId == eqp && (a.F_JobType == 0 || a.F_JobType == 7) && a.F_JobState < 2).Select(a => a.F_Id).ToList();
			foreach (var item in jobs)
			{
                await jobApp.FinishJob(item);
            }
            uniwork.Commit();
        }

        #endregion

    }
}
