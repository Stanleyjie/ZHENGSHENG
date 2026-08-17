using System;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;
using WaterCloud.Code;
using Chloe;
using WaterCloud.Domain.ClassTask;
using WaterCloud.Domain.EquipmentManage;
using WaterCloud.Domain.InfoManage;
using WaterCloud.Domain.SystemManage;
using WaterCloud.Domain.SystemOrganize;
using WaterCloud.Service.InfoManage;
using WaterCloud.Domain.MaterialManage;
using WaterCloud.Domain.ProcessManage;
using WaterCloud.Service.SystemManage;
using WaterCloud.Service.MaterialManage;
using System.Net.Http;
using WaterCloud.Domain.QualityManage;
using WaterCloud.Service.QualityManage;
using WaterCloud.Domain.DingTalkManage;

namespace WaterCloud.Service.ClassTask
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2021-01-15 14:18
    /// 描 述：待执行任务服务类
    /// </summary>
    public class ControlJobService : DataFilterService<ControlJobEntity>, IDenpendency
    {
        private MessageService messageApp;
        private ItemsDataService itemsApp;
        private LocationService locationApp;
        public NeedCheckService _checkoutService { get; set; }

        public ControlJobService(IDbContext context, IHttpClientFactory httpClientFactory) : base(context)
        {
            messageApp = new MessageService(context, httpClientFactory);
            itemsApp = new ItemsDataService(context);
            locationApp = new LocationService(context);
        }
        #region 获取数据
        public async Task<List<ControlJobEntity>> GetList(string keyword = "")
        {
            var data = IQueryable();
            if (currentuser == null || string.IsNullOrEmpty(currentuser.UserId))
            {
                return null;
            }
            var user = await uniwork.FindEntity<UserEntity>(currentuser.UserId);
            if (user.F_IsPlanMan != true && !currentuser.IsSystem)
            {
                data = uniwork.IQueryable<ControlJobUserBandingEntity>(a => a.F_UserId == currentuser.UserId)
                    .InnerJoin<ControlJobEntity>((a, b) => a.F_JobType == b.F_JobType && ((a.F_EqpId == b.F_NeedEqpId && a.F_EqpId != null) || a.F_EqpId == null)).Select((a, b) => b).Distinct();
            }
            if (!string.IsNullOrEmpty(keyword))
            {
                //此处需修改
                data = data.Where(t => t.F_JobCode.Contains(keyword) || t.F_JobInfo.Contains(keyword));
            }
            return data.Where(t => t.F_DeleteMark == false).OrderByDesc(t => t.F_CreatorTime).ToList();
        }

        public async Task<List<ControlJobExtend>> GetListByUserId(string keyValue)
        {
            var userJobQuery = IQueryable();
            int?[] jobtypes = new int?[] { 0, 3, 4, 7, 10, 11 };
            //获取任务前3条，按需求排序
            var user = await uniwork.FindEntity<UserEntity>(keyValue);
            if (user != null && user.F_IsAdmin != true && user.F_IsPlanMan != true)
            {
                userJobQuery = uniwork.IQueryable<ControlJobUserBandingEntity>(a => a.F_UserId == keyValue)
         .InnerJoin<ControlJobEntity>((a, b) => a.F_JobType == b.F_JobType && ((a.F_EqpId == b.F_NeedEqpId && a.F_EqpId != null) || a.F_EqpId == null)).Select((a, b) => b).Distinct();

            }

            var userJob = userJobQuery.Where(a => a.F_JobState < 2 && jobtypes.Contains(a.F_JobType)).OrderBy(a => a.F_NeedTime).Take(6).ToList();

            List<ControlJobExtend> list = new List<ControlJobExtend>();

            //var userJob = uniwork.IQueryable<ControlJobEntity>(t => t.F_Id == "08d956dc-3daa-4cf6-8446-a2fdcb6f7518" || t.F_Id == "08d956dd-2535-4b6d-80b4-c8329e5100f3" || t.F_Id == "08d95588-f605-40aa-8870-98d93f41c584" || t.F_Id == "08d95683-efec-4912-8392-3017687c5c8f").ToList();



            foreach (var item in userJob)
            {
                list.Add(await GetLookForm(item.F_Id));
            }
            return list;
        }

        public async Task<List<overtimejobEntity>> GetOverTimeJob(string F_EqpId, int? F_JobType)
        {
            int hour = DateTime.Now.Hour;
            DateTime startTime = DateTime.Now;
            DateTime prestartTime = DateTime.Now;
            //string prestartTimeStr = string.Empty;
            DateTime newstarttime = DateTime.Now.AddHours(-24);

            if (hour >= 8 && hour < 20)
            {
                startTime = DateTime.Now.Date.AddHours(8);
                prestartTime = DateTime.Now.AddDays(-1).Date.AddHours(20);

            }
            else
            {
                if (hour >= 20)
                {
                    startTime = DateTime.Now.Date.AddHours(20);
                    prestartTime = DateTime.Now.Date.AddHours(8);
                }
                else
                {
                    startTime = DateTime.Now.AddDays(-1).AddHours(20);
                    prestartTime = DateTime.Now.AddDays(-1).AddHours(8);
                }

            }
            //所有任务
            List<jobEntity> list = new List<jobEntity>();
            int?[] jobtypes = new int?[] { 0, 1, 3, 4, 7, 10, 11 };
            var alljobs = repository.IQueryable().Where(a => (a.F_CreatorTime >= newstarttime && a.F_JobState < 2) && a.F_EnabledMark == true && a.F_DeleteMark == false).Where(t => jobtypes.Contains(t.F_JobType));

            //var leftjobDivOvertime = new List<overtimejobEntity>();

            if (string.IsNullOrEmpty(F_EqpId) && F_JobType != null)
            {
                alljobs = alljobs.Where(t => t.F_JobType == F_JobType).Where(a => a.F_JobState < 2 && Sql.DiffSeconds(a.F_NeedTime, DateTime.Now) > 0);

            }
            else
            {
                alljobs = alljobs.Where(t => t.F_NeedEqpId == F_EqpId && (t.F_JobType == 0 || t.F_JobType == 3)).Where(a => a.F_JobState < 2 && Sql.DiffSeconds(a.F_NeedTime, DateTime.Now) > 0);
            }

            var leftjobDivOvertime = alljobs.Select(t => new overtimejobEntity
            {
                F_JobCode = t.F_JobCode,
                F_CreatorTime = t.F_CreatorTime,
                F_NeedTime = t.F_NeedTime,
                F_JobInfo = t.F_JobInfo,
                F_JobState = t.F_JobState,
                F_JobType = t.F_JobType,

                overTime = Sql.DiffMinutes(t.F_NeedTime, DateTime.Now)
            }).OrderByDesc(t => t.overTime).ToList();
            return leftjobDivOvertime;
        }

        public async Task<ControlJobExtend> GetTaskJobForm(string jobCode)
        {
            var job = IQueryable().Where(a => a.F_JobCode == jobCode).First();
            return await GetLookForm(job.F_Id);
        }

        public async Task<List<ControlJobEntity>> GetLookList(string keyword = "")
        {
            var query = IQueryable().Where(t => t.F_DeleteMark == false);
            if (!string.IsNullOrEmpty(keyword))
            {
                //此处需修改
                query = query.Where(t => t.F_JobCode.Contains(keyword) || t.F_JobInfo.Contains(keyword));
            }
            //权限过滤
            query = GetDataPrivilege("u", "", query);
            return query.OrderByDesc(t => t.F_CreatorTime).ToList();
        }

        public async Task<List<ControlJobEntity>> GetLookList(SoulPage<ControlJobEntity> pagination, string keyword = "", int type = 0)
        {
            //反格式化显示只能用"等于"，其他不支持
            Dictionary<string, Dictionary<string, string>> dic = new Dictionary<string, Dictionary<string, string>>();
            var typeList = await itemsApp.GetItemList("Mes_ControlJobType");
            Dictionary<string, string> typeTemp = new Dictionary<string, string>();
            foreach (var item in typeList)
            {
                typeTemp.Add(item.F_ItemName, item.F_ItemCode);
            }
            dic.Add("F_JobType", typeTemp);
            var setList = await itemsApp.GetItemList("Mes_WorkOrderState");
            Dictionary<string, string> stateTemp = new Dictionary<string, string>();
            foreach (var item in setList)
            {
                stateTemp.Add(item.F_ItemName, item.F_ItemCode);
            }
            dic.Add("F_JobState", stateTemp);
            Dictionary<string, string> enabledTemp = new Dictionary<string, string>();
            enabledTemp.Add("是", "1");
            enabledTemp.Add("否", "0");
            dic.Add("F_IsOutTime", enabledTemp);
            pagination = ChangeSoulData(dic, pagination);
            var query = IQueryable().Where(u => u.F_DeleteMark == false);
            var user = await uniwork.FindEntity<UserEntity>(currentuser.UserId);
            if (user.F_IsPlanMan != true && !currentuser.IsSystem)
            {
                query = uniwork.IQueryable<ControlJobUserBandingEntity>(a => a.F_UserId == currentuser.UserId)
                    .InnerJoin<ControlJobEntity>((a, b) => a.F_JobType == b.F_JobType && ((a.F_EqpId == b.F_NeedEqpId && a.F_EqpId != null) || a.F_EqpId == null)).Select((a, b) => b).Distinct();
            }
            if (!string.IsNullOrEmpty(keyword))
            {
                //此处需修改
                query = query.Where(t => t.F_JobCode.Contains(keyword) || t.F_JobInfo.Contains(keyword));
            }
            switch (type)
            {
                case 0:
                    query = query.Where(a => a.F_JobState <= 1);
                    break;
                case 1:
                    query = query.Where(a => a.F_JobState == 1);
                    break;
                case 2:
                    query = query.Where(a => a.F_JobState > 1);
                    break;
            }
            //权限过滤
            query = GetDataPrivilege("u", "", query);
            return await repository.OrderList(query, pagination);
        }

        private IQuery<ControlJobEntity> IQueryable()
        {
            var now = DateTime.Now;
            var query = repository.IQueryable().Select(a => new ControlJobEntity
            {
                F_CreatorTime = a.F_CreatorTime,
                F_CreatorUserId = a.F_CreatorUserId,
                F_DeleteMark = a.F_DeleteMark,
                F_DeleteTime = a.F_DeleteTime,
                F_DeleteUserId = a.F_DeleteUserId,
                F_Description = a.F_Description,
                F_DoneTime = a.F_DoneTime,
                F_EnabledMark = a.F_EnabledMark,
                F_FinishTime = a.F_FinishTime,
                F_Id = a.F_Id,
                F_IsNotice = a.F_IsNotice,
                F_IsOutTime = a.F_FinishTime == null ? now > a.F_NeedTime : a.F_FinishTime > a.F_NeedTime,
                F_IsToPlanMan = a.F_IsToPlanMan,
                F_JobCode = a.F_JobCode,
                F_JobInfo = a.F_JobInfo,
                F_JobState = a.F_JobState,
                F_JobType = a.F_JobType,
                F_LastModifyTime = a.F_LastModifyTime,
                F_LastModifyUserId = a.F_LastModifyUserId,
                F_NeedEqpId = a.F_NeedEqpId,
                F_NeedId = a.F_NeedId,
                F_NeedNum = a.F_NeedNum,
                F_NeedTime = a.F_NeedTime,
                F_Priority = a.F_Priority
            });
            return query;
        }

        public async Task<object> GetLocationJson(int type, string locationCode, string areaCode, int areaType)
        {
            string area = "";
            string location = locationCode;
            areaType = areaType == -1 ? 0 : areaType;
            if (type == 0)
            {
                var areaEntity = new AreaEntity();
                areaEntity = await uniwork.FindEntity<AreaEntity>(a => a.F_AreaType == areaType);
                if (!string.IsNullOrEmpty(areaCode))
                {
                    areaEntity = await uniwork.FindEntity<AreaEntity>(a => a.F_AreaCode == areaCode);
                }
                var entity = uniwork.IQueryable<LocationEntity>(a => a.F_AreaId == areaEntity.F_Id).OrderBy(a => a.F_SortCode).FirstOrDefault();
                area = entity.F_AreaCode;
                location = entity.F_LocationCode;
            }
            else
            {
                var entity = await uniwork.FindEntity<LocationEntity>(a => a.F_LocationCode == locationCode);
                var areaEntity = await uniwork.FindEntity<AreaEntity>(a => a.F_Id == entity.F_AreaId);
                area = entity.F_AreaCode;
                areaType = areaEntity.F_AreaType ?? 0;
            }
            return new { area, location, areaType };
        }
        #endregion
        public async Task<ControlJobExtend> GetLookForm(object keyValue)
        {
            var data = (await repository.FindEntity(keyValue)).MapTo<ControlJobExtend>();
            if (data.F_NeedEqpId != null)
            {
                data.F_NeedEqpName = (await uniwork.FindEntity<EquipmentEntity>(data.F_NeedEqpId)).F_EqpName;
            }
            switch (data.F_JobType)
            {
                case 0:
                    var temp0 = await uniwork.FindEntity<MaterialEntity>(data.F_NeedId);
                    if (temp0 != null)
                    {
                        data.F_MaterialCode = temp0.F_MaterialCode;
                        data.F_MaterialName = temp0.F_MaterialName;
                        data.F_MaterialUnit = temp0.F_MaterialUnit;
                        if (data.F_FinishTime == null)
                        {
                            data.uses = uniwork.IQueryable<EqpMaterialUseEntity>(a => a.F_MaterialId == temp0.F_Id && a.F_EqpId == data.F_NeedEqpId && a.F_CreatorTime > data.F_DoneTime).ToList();
                        }
                        else
                        {
                            data.uses = uniwork.IQueryable<EqpMaterialUseEntity>(a => a.F_MaterialId == temp0.F_Id && a.F_EqpId == data.F_NeedEqpId && a.F_CreatorTime >= data.F_CreatorTime && a.F_CreatorTime <= data.F_FinishTime).ToList();
                        }
                        data.F_FinishNum = data.uses.Sum(a => a.F_Num);
                        data.F_NeedDoNum = (data.F_NeedNum ?? 0) - (data.F_FinishNum ?? 0);
                        if (data.F_NeedDoNum == 0)
                        {
                            break;
                        }
                        data.storages = uniwork.IQueryable<StorageEntity>(a => a.F_MaterialId == temp0.F_Id).OrderBy(a => a.F_CreatorTime).ToList();
                        var work = uniwork.IQueryable<WorkOrderDetailEqpBandingEntity>(a => a.F_EqpId == data.F_NeedEqpId)
                                .InnerJoin<WorkOrderDetailEntity>((a, b) => a.F_WorkOrderDetailId == b.F_Id && b.F_WorkOrderState == 1)
                                .InnerJoin<WorkOrderDetailProcessBandingEntity>((a,b,c)=>b.F_Id==c.F_WorkOrderDetailId)
                                .InnerJoin<BomFormEntity>((a, b, c,d) => b.F_MaterialId == d.F_MaterialId&&c.F_ProcessId==d.F_ProcessId && d.F_BomType == 1 && d.F_SonMaterialId == temp0.F_Id)
                                .Select((a, b, c,d) => b).FirstOrDefault();
                        //是否多工序作业
                        if (work != null && work.F_RunSort != 1)
                        {
                            data.storages = uniwork.IQueryable<OutPutInfoEntity>(a => a.F_WorkOrderId == work.F_WorkOrderId && a.F_MaterialId == temp0.F_Id && a.F_IsTemp != true)
                                .InnerJoin<StorageEntity>((a, b) => a.F_TransferBoxCode == b.F_TransferBoxCode && a.F_LocationCode == b.F_LocationCode && a.F_MaterialId == b.F_MaterialId
                                && a.F_MaterialBatch == b.F_MaterialBatch).Select((a, b) => b).OrderBy(a => a.F_CreatorTime).ToList();
                        }
                    }
                    break;
                case 1:
                    var innote = await uniwork.FindEntity<InStorageEntity>(data.F_NeedId);
                    var temp1 = await uniwork.FindEntity<MaterialEntity>(innote.F_MaterialId);
                    data.F_MaterialCode = temp1.F_MaterialCode;
                    data.F_MaterialName = temp1.F_MaterialName;
                    data.F_MaterialUnit = temp1.F_MaterialUnit;
                    data.F_InStorageCode = innote.F_InStorageCode;
                    data.instorages = uniwork.IQueryable<InStorageInfoEntity>(a => a.F_InStorageId == data.F_NeedId && a.F_IsTemp != true).ToList();
                    data.instorageTemps = uniwork.IQueryable<InStorageInfoEntity>(a => a.F_InStorageId == data.F_NeedId && a.F_IsTemp == true).ToList();
                    data.F_BandingNum = (data.instorageTemps.Sum(a => a.F_Num) ?? 0) + (data.instorages.Sum(a => a.F_Num) ?? 0);
                    data.F_NeedBandingNum = (data.F_NeedNum ?? 0) - (data.F_BandingNum ?? 0);
                    data.F_FinishNum = data.instorages.Sum(a => a.F_Num);
                    data.F_NeedDoNum = (data.F_NeedNum ?? 0) - (data.F_FinishNum ?? 0);
                    data.F_Num = data.F_NeedNum;
                    break;
                case 2:
                    var outnote = await uniwork.FindEntity<OutStorageEntity>(data.F_NeedId);
                    var temp2 = await uniwork.FindEntity<MaterialEntity>(outnote.F_MaterialId);
                    data.F_OutStorageCode = outnote.F_OutStorageCode;
                    data.F_MaterialCode = temp2.F_MaterialCode;
                    data.F_MaterialName = temp2.F_MaterialName;
                    data.F_MaterialUnit = temp2.F_MaterialUnit;
                    data.outstorages = uniwork.IQueryable<OutStorageInfoEntity>(a => a.F_OutStorageId == data.F_NeedId && a.F_IsTemp == true).ToList();
                    data.F_FinishNum = data.outstorages.Sum(a => a.F_Num);
                    data.F_NeedDoNum = (data.F_NeedNum ?? 0) - (data.F_FinishNum ?? 0);
                    if (data.F_NeedDoNum == 0)
                    {
                        break;
                    }
                    data.storages = uniwork.IQueryable<StorageEntity>(a => a.F_MaterialId == temp2.F_Id).OrderBy(a => a.F_CreatorTime).ToList();
                    break;
                case 3:
                    if (data.F_JobState > 1)
                    {
                        var output = await uniwork.FindEntity<OutPutInfoEntity>(a => a.F_TransferBoxCode == data.F_NeedId && a.F_EqpId == data.F_NeedEqpId && a.F_CreatorTime >= data.F_CreatorTime && a.F_CreatorTime <= data.F_FinishTime && a.F_IsTemp != true);
                        if (output != null)
                        {
                            data.F_MaterialCode = output.F_MaterialCode;
                            data.F_MaterialName = output.F_MaterialName;
                            data.F_MaterialUnit = output.F_MaterialUnit;
                            data.F_FinishNum = data.F_NeedNum;
                        }
                    }
                    else
                    {
                        var outputtemp = await uniwork.FindEntity<OutPutInfoEntity>(a => a.F_TransferBoxCode == data.F_NeedId && a.F_EqpId == data.F_NeedEqpId && a.F_IsTemp == true);
                        data.F_MaterialCode = outputtemp.F_MaterialCode;
                        data.F_MaterialName = outputtemp.F_MaterialName;
                        data.F_MaterialUnit = outputtemp.F_MaterialUnit;
                        data.F_FinishNum = 0;
                        var eqp = await uniwork.FindEntity<EquipmentEntity>(data.F_NeedEqpId);
                        data.locations = await locationApp.GetLocationList(eqp.F_EqpName, "");
                    }
                    data.F_TransferBoxCode = data.F_NeedId;
                    data.F_NeedDoNum = (data.F_NeedNum ?? 0) - (data.F_FinishNum ?? 0);

                    break;
                case 4:
                    if (data.F_JobState > 1)
                    {
                        var storageChange = await uniwork.FindEntity<StorageChangeInfoEntity>(a => a.F_StorageId == data.F_NeedId);
                        data.F_MaterialCode = storageChange.F_MaterialCode;
                        data.F_MaterialName = storageChange.F_MaterialName;
                        data.F_MaterialUnit = storageChange.F_MaterialUnit;
                        data.F_FinishNum = data.F_NeedNum;
                        data.F_LocationCode = storageChange.F_LocationCode;
                        data.F_TransferBoxCode = storageChange.F_TransferBoxCode;
                    }
                    else
                    {
                        var storage = await uniwork.FindEntity<StorageEntity>(data.F_NeedId);
                        data.F_MaterialCode = storage.F_MaterialCode;
                        data.F_MaterialName = storage.F_MaterialName;
                        data.F_MaterialUnit = storage.F_MaterialUnit;
                        data.F_LocationCode = storage.F_LocationCode;
                        data.F_TransferBoxCode = storage.F_TransferBoxCode;
                        data.F_FinishNum = 0;
                        data.locations = await locationApp.GetLocationList();
                    }
                    break;
                case 7:
                    if (data.F_JobState > 1)
                    {
                        var returnuse = await uniwork.FindEntity<ReturnMaterialEntity>(a => a.F_TransferBoxCode == data.F_NeedId && a.F_EqpId == data.F_NeedEqpId);
                        data.F_MaterialCode = returnuse.F_MaterialCode;
                        data.F_MaterialName = returnuse.F_MaterialName;
                        data.F_MaterialUnit = returnuse.F_MaterialUnit;
                        data.F_FinishNum = data.F_NeedNum;
                        data.F_TransferBoxCode = data.F_NeedId;
                    }
                    else
                    {
                        var use = await uniwork.FindEntity<EqpMaterialUseEntity>(a => a.F_TransferBoxCode == data.F_NeedId && a.F_EqpId == data.F_NeedEqpId && a.F_DoneNum != a.F_Num);
                        data.F_MaterialCode = use.F_MaterialCode;
                        data.F_MaterialName = use.F_MaterialName;
                        data.F_MaterialUnit = use.F_MaterialUnit;
                        data.F_TransferBoxCode = data.F_NeedId;
                        data.F_FinishNum = 0;
                        data.locations = new List<LocationEntity>();
                        data.locations.Add(await locationApp.GetLocationReturn(use.F_TransferBoxCode));
                    }
                    break;
                case 10:
                    var info = await _checkoutService.GetInfoByCode(data.F_NeedId.ToUpper());
                    if (info != null)
                    {
                        data.F_MaterialCode = info.F_MaterialCode;
                        data.F_MaterialName = info.F_MaterialName;

                    }
                    break;
                default:
                    break;
            }

            return GetFieldsFilterData(data);
        }

        #region 提交数据
        public async Task SubmitForm(ControlJobEntity entity, bool IsCommit = false)
        {
            entity.F_DeleteMark = false;
            entity.F_EnabledMark = true;
            entity.F_JobState = 0;
            entity.F_IsToPlanMan = false;
            entity.F_IsNotice = true;
            //创建任务
            entity.Create();
            if (string.IsNullOrEmpty(entity.F_CreatorUserId))
            {
                entity.F_CreatorUserId = WebHelper.GetCookie("boardlogin_uerId");
            }
            List<string> userlist = new List<string>();
            if (!string.IsNullOrEmpty(entity.F_NeedEqpId))
            {
                userlist = uniwork.IQueryable<ControlJobUserBandingEntity>(a => a.F_EqpId == entity.F_NeedEqpId && a.F_JobType == entity.F_JobType).Select(a => a.F_UserId).ToList();
            }
            userlist.AddRange(uniwork.IQueryable<ControlJobUserBandingEntity>(a => (a.F_EqpId == null || a.F_EqpId == "") && a.F_JobType == entity.F_JobType).Select(a => a.F_UserId).ToList());
            userlist = userlist.Distinct().ToList();
            //创建信息
            MessageEntity msg = new MessageEntity();
            msg.F_MessageType = 2;
            msg.F_MessageInfo = entity.F_JobInfo + "--任务待处理";
            var mouduleName = ReflectionHelper.GetModuleName(1);
            if (entity.F_JobType == 6)
            {
                mouduleName = "WorkOrderRun";
            }
            var module = uniwork.IQueryable<ModuleEntity>(a => a.F_EnCode == mouduleName).FirstOrDefault();
            msg.F_Href = module.F_UrlAddress;
            msg.F_HrefTarget = module.F_Target;
            msg.F_ClickRead = false;
            msg.F_KeyValue = entity.F_Id;
            if (entity.F_IsToPlanMan == true)
            {
                userlist = uniwork.IQueryable<UserEntity>(a => a.F_IsPlanMan == true && a.F_EnabledMark == true && a.F_DeleteMark == false).Select(a => a.F_Id).Distinct().ToList();
            }
            var usernames = uniwork.IQueryable<UserEntity>(a => userlist.Contains(a.F_Id)).Select(a => a.F_RealName).ToList();
            msg.F_ToUserId = string.Join(",", userlist);
            msg.F_ToUserName = string.Join(",", usernames);
            //发送消息
            uniwork.BeginTrans();
            var needtime = await uniwork.FindEntity<ControlJobMustTimeEntity>(a => a.F_JobType == entity.F_JobType);
            if (needtime != null)
            {
                entity.F_NeedTime = ((DateTime)entity.F_CreatorTime).AddMinutes(needtime.F_NeedTime ?? 0);
            }
            await repository.Insert(entity);
            if (entity.F_IsNotice == true)
            {
                await messageApp.SubmitForm(msg, true);
            }
            if (IsCommit)
            {
                uniwork.Commit();
            }
        }

        public async Task SubmitFormAutoSend(ControlJobEntity entity, bool IsCommit = false)
        {
            entity.F_DeleteMark = false;
            entity.F_EnabledMark = true;
            entity.F_JobState = 0;
            entity.F_IsToPlanMan = false;
            entity.F_IsNotice = true;
            //创建任务
            entity.Create();
            if (string.IsNullOrEmpty(entity.F_CreatorUserId))
            {
                entity.F_CreatorUserId = WebHelper.GetCookie("boardlogin_uerId");
            }
            List<string> userlist = new List<string>();
            if (!string.IsNullOrEmpty(entity.F_NeedEqpId))
            {
                userlist = uniwork.IQueryable<ControlJobUserBandingEntity>(a => a.F_EqpId == entity.F_NeedEqpId && a.F_JobType == entity.F_JobType).Select(a => a.F_UserId).ToList();
            }
            userlist.AddRange(uniwork.IQueryable<ControlJobUserBandingEntity>(a => (a.F_EqpId == null || a.F_EqpId == "") && a.F_JobType == entity.F_JobType).Select(a => a.F_UserId).ToList());
            userlist = userlist.Distinct().ToList();
            //创建信息
            MessageEntity msg = new MessageEntity();
            msg.F_MessageType = 2;
            msg.F_MessageInfo = entity.F_JobInfo + "--任务待处理";
            var mouduleName = ReflectionHelper.GetModuleName(1);
            if (entity.F_JobType == 6)
            {
                mouduleName = "WorkOrderRun";
            }
            var module = uniwork.IQueryable<ModuleEntity>(a => a.F_EnCode == mouduleName).FirstOrDefault();
            msg.F_Href = module.F_UrlAddress;
            msg.F_HrefTarget = module.F_Target;
            msg.F_ClickRead = false;
            msg.F_KeyValue = entity.F_Id;
            if (entity.F_IsToPlanMan == true)
            {
                userlist = uniwork.IQueryable<UserEntity>(a => a.F_IsPlanMan == true && a.F_EnabledMark == true && a.F_DeleteMark == false).Select(a => a.F_Id).Distinct().ToList();
            }
            var usernames = uniwork.IQueryable<UserEntity>(a => userlist.Contains(a.F_Id)).Select(a => a.F_RealName).ToList();
            msg.F_ToUserId = string.Join(",", userlist);
            msg.F_ToUserName = string.Join(",", usernames);
            //发送消息
            uniwork.BeginTrans();
            var needtime = await uniwork.FindEntity<ControlJobMustTimeEntity>(a => a.F_JobType == entity.F_JobType);
            if (needtime != null)
            {
                entity.F_NeedTime = ((DateTime)entity.F_CreatorTime).AddMinutes(needtime.F_NeedTime ?? 0);
            }
            await repository.Insert(entity);
            if (entity.F_IsNotice == true)
            {
                await messageApp.SubmitFormAutoSend(msg, true);
            }
            if (IsCommit)
            {
                uniwork.Commit();
            }
        }

        public async Task DeleteForm(string keyValue, bool IsCommit = false)
        {
            var ids = keyValue.Split(',');
            uniwork.BeginTrans();
            foreach (var item in ids)
            {
                await CloseJob(item);
            }
            if (IsCommit)
            {
                uniwork.Commit();
            }
        }

        public async Task RunForm(string keyValue)
        {
            var entity = await repository.FindEntity(keyValue);
            await repository.Update(a => a.F_Id == keyValue && a.F_DoneTime == null && a.F_JobState == 0, a => new ControlJobEntity
            {
                F_DoneTime = DateTime.Now,
                F_JobState = 1
            });
        }

        public async Task FinishJob(string keyValue, bool IsCommit = false)
        {
            uniwork.BeginTrans();
            var dt = DateTime.Now;
            await uniwork.Update<ControlJobEntity>(a => a.F_Id == keyValue && a.F_FinishTime == null && a.F_JobState < 2, a => new ControlJobEntity
            {
                F_JobState = 2,
                F_FinishTime = dt,
                F_DoneTime = a.F_DoneTime == null ? dt : a.F_DoneTime,
            });
            var entity = await repository.FindEntity(keyValue);
            var msg = uniwork.IQueryable<MessageEntity>(a => a.F_KeyValue == keyValue).FirstOrDefault();
            if (msg != null)
            {
                await messageApp.ReadMsgForm(msg.F_Id);
                //创建完成信息
                MessageEntity remsg = new MessageEntity();
                remsg.F_MessageType = 2;
                remsg.F_MessageInfo = entity.F_JobInfo + "--任务已完成";
                var module = uniwork.IQueryable<ModuleEntity>(a => a.F_EnCode == "DoneControlJob").FirstOrDefault();
                remsg.F_Href = module.F_UrlAddress;
                remsg.F_HrefTarget = module.F_Target;
                remsg.F_ClickRead = true;
                var userlist = uniwork.IQueryable<UserEntity>(a => a.F_IsPlanMan == true && a.F_EnabledMark == true && a.F_DeleteMark == false).ToList();
                remsg.F_ToUserId = string.Join(',', userlist.Select(a => a.F_Id).ToList());
                remsg.F_ToUserName = string.Join(',', userlist.Select(a => a.F_RealName).ToList());
                await messageApp.SubmitForm(remsg, true, false);
            }
            if (IsCommit)
            {
                uniwork.Commit();
            }
        }
        public async Task CloseJob(string keyValue, bool IsCommit = false)
        {
            uniwork.BeginTrans();
            await uniwork.Update<ControlJobEntity>(a => a.F_Id == keyValue && a.F_FinishTime == null && a.F_JobState < 2, a => new ControlJobEntity
            {
                F_JobState = 3,
                F_FinishTime = DateTime.Now,
            });
            var entity = await repository.FindEntity(keyValue);
            var msg = uniwork.IQueryable<MessageEntity>(a => a.F_KeyValue == keyValue).FirstOrDefault();
            if (msg != null)
            {
                await messageApp.ReadMsgForm(msg.F_Id);
                //创建完成信息
                MessageEntity remsg = new MessageEntity();
                remsg.F_MessageType = 0;
                remsg.F_MessageInfo = entity.F_JobInfo + "--任务已关闭";
                var module = uniwork.IQueryable<ModuleEntity>(a => a.F_EnCode == "DoneControlJob").FirstOrDefault();
                remsg.F_Href = module.F_UrlAddress;
                remsg.F_HrefTarget = module.F_Target;
                remsg.F_ClickRead = true;
                remsg.F_ToUserId = msg.F_ToUserId;
                remsg.F_ToUserName = msg.F_ToUserName;
                await messageApp.SubmitForm(remsg, true);
            }
            if (IsCommit)
            {
                uniwork.Commit();
            }
        }

        public async Task DoTaskJob(string jobCode)
        {
            var entity = await repository.FindEntity(a => a.F_JobCode == jobCode);
            await repository.Update(a => a.F_Id == entity.F_Id && a.F_DoneTime == null && a.F_JobState == 0, a => new ControlJobEntity
            {
                F_DoneTime = DateTime.Now,
                F_JobState = 1
            });
        }
        #endregion

    }

    public class jobEntity
    {
        public string jobname { get; set; }
        public string jobcode { get; set; }
        public List<jobstateEntity> jobstateEntities { get; set; } = new List<jobstateEntity>();
    }

    public class jobstateEntity
    {
        public int statecode { get; set; }
        public string statename { get; set; }
        public int statenum { get; set; }
    }

    public class overtimejobEntity
    {
        public string F_JobCode { get; set; }
        public DateTime? F_CreatorTime { get; set; }
        public DateTime? F_NeedTime { get; set; }
        public string F_JobInfo { get; set; }
        public int? F_JobState { get; set; }
        public int? F_JobType { get; set; }

        public int? overTime { get; set; }
    }

}
