using System;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;
using WaterCloud.Code;
using Chloe;
using WaterCloud.Domain.MaterialManage;
using WaterCloud.Service.SystemManage;
using WaterCloud.Domain.ClassTask;
using WaterCloud.Service.ClassTask;
using System.Net.Http;
using WaterCloud.Domain.QualityManage;
using WaterCloud.Domain.ProcessManage;
using WaterCloud.Domain.PlanManage;
using WaterCloud.Service.SystemSecurity;

namespace WaterCloud.Service.MaterialManage
{
	/// <summary>
	/// 创 建：超级管理员
	/// 日 期：2020-12-16 13:38
	/// 描 述：出库管理服务类
	/// </summary>
	public class OutStorageService : DataFilterService<OutStorageEntity>, IDenpendency
    {
        private ItemsDataService itemsApp;
        private ControlJobService jobApp;
        private LocationService locationApp;
        private StorageService _storageApp;
        private BusinessLogService _logApp;
        public OutStorageService(IDbContext context, IHttpClientFactory httpClientFactory) : base(context)
        {
            itemsApp = new ItemsDataService(context);
            jobApp = new ControlJobService(context, httpClientFactory);
            locationApp = new LocationService(context);
            _storageApp = new StorageService(context, httpClientFactory);
            _logApp = new BusinessLogService(context);
        }
        #region 获取数据
        public async Task<List<OutStorageEntity>> GetList(string keyword = "")
        {
            var data = repository.IQueryable();
            if (!string.IsNullOrEmpty(keyword))
            {
                data = data.Where(t => t.F_OutStorageCode.Contains(keyword) || t.F_MaterialCode.Contains(keyword) || t.F_MaterialName.Contains(keyword));
            }
            return data.OrderByDesc(t => t.F_CreatorTime).ToList();
        }
        public async Task<List<OutStorageInfoEntity>> GetOutInfoList(string outStorageCode)
        {
            var outstorage = uniwork.IQueryable<OutStorageEntity>(a=>a.F_OutStorageCode == outStorageCode).FirstOrDefault();
			if (outstorage == null)
			{
                return new List<OutStorageInfoEntity>();
			}
            var data = uniwork.IQueryable<OutStorageInfoEntity>().Where(a=>a.F_OutStorageId == outstorage.F_Id);
            return data.OrderByDesc(t => t.F_CreatorTime).ToList();
        }

        public async Task<List<OutStorageEntity>> GetPlanList(int dayCount)
		{
            DateTime startTime = DateTime.Now.Date;
            DateTime endTime = startTime.AddDays(dayCount);
            var data = uniwork.IQueryable<OutStorageEntity>(a => a.F_PlanTime != null && a.F_PlanTime <= endTime&&a.F_OutStorageState<2).ToList();
            data = data.OrderBy(a => a.F_PlanTime).ToList();
            var list = new List<OutStorageEntity>();
			foreach (var item in data)
            {
                if (list.Where(a => a.F_PlanTime == item.F_PlanTime && a.F_MaterialCode == item.F_MaterialCode).Count() > 0)
                {
                    list.Find(a => a.F_PlanTime == item.F_PlanTime && a.F_MaterialCode == item.F_MaterialCode).F_Num += item.F_Num;
                    list.Find(a => a.F_PlanTime == item.F_PlanTime && a.F_MaterialCode == item.F_MaterialCode).F_DoneNum += item.F_DoneNum;
                }
				else
				{
                    list.Add(item);
				}
            }
            //计算当前库存
            //安全库存值
            var currentStorages = await _storageApp.GetCurrentClassNumStorage();
            currentStorages = currentStorages.Where(a => a.F_MaterialType == 2).ToList();
            //获取当前天
            DateTime currentdate = DateTime.Now.Date;
            var classNums = await itemsApp.GetItemList("Mes_ClassNumber");
            var classStartTime = TimeSpan.Parse(classNums.FirstOrDefault().F_Description.Split("-")[0]);
			var currentTime = DateTime.Now.TimeOfDay;
            if (TimeSpan.Compare(currentTime,classStartTime) < 0)
            {
                currentdate = currentdate.AddDays(-1);
            }
            //获取生产计划
            var producePlans = uniwork.IQueryable<WorkPlanEntity>(a => a.F_Date >= currentdate).ToList();
            //今天的计划加进计划库存中
            var tempoutplan = list.Where(a => a.F_PlanTime < currentdate.AddDays(1) && a.F_OutStorageState <= 2).ToList();
			if (TimeSpan.Compare(currentTime, classStartTime) < 0)
			{
                tempoutplan = list.Where(a => a.F_PlanTime < currentdate.AddDays(2) && a.F_OutStorageState <= 2).ToList();
            }
			var tempproduceplan = producePlans.Where(a => a.F_Date >= currentdate && a.F_Date < currentdate.AddDays(1)).ToList();
			for (int i = 0; i < classNums.Count(); i++)
            {
				var tempStartTime = TimeSpan.Parse(classNums[i].F_Description.Split("-")[0]);
				var tempEndTime = TimeSpan.Parse(classNums[i].F_Description.Split("-")[1]);
                if (TimeSpan.Compare(currentTime, tempStartTime) > 0 && TimeSpan.Compare(tempEndTime, currentTime) > 0)
                {
                    for (int j = 0; j < i; j++)
                    {
                        tempproduceplan = tempproduceplan.Where(a => a.F_ClassNum != classNums[j].F_ItemCode).ToList();
					}
                }
			}
            foreach (var item in tempoutplan)
            {
                var temp = currentStorages.Where(a => a.F_Id == item.F_MaterialId).FirstOrDefault();
                temp.F_Num -= item.F_Num - item.F_DoneNum;
            }
            foreach (var item in tempproduceplan)
            {
                var temp = currentStorages.Where(a => a.F_Id == item.F_MaterialId).FirstOrDefault();
                if (temp != null)
                {
                    temp.F_Num += item.F_PlanNum - item.F_DoneNum;
                }
            }
            DateTime lasterDate = currentdate.AddDays(1);
            var todayPlan = list.Where(a => a.F_PlanTime == currentdate).ToList();
            //预期库存
            SortedDictionary<DateTime, List<MaterialEntity>> planStorage = new SortedDictionary<DateTime, List<MaterialEntity>>();
            planStorage.Add(currentdate, currentStorages);
            for (int i = 0; i < 7; i++)
            {
                var thisoutPlan = list.Where(a => a.F_PlanTime == lasterDate.AddDays(i)).ToList();
                foreach (var item in thisoutPlan)
                {
                    var thisproducePlan = producePlans.Where(a => a.F_Date == lasterDate.AddDays(i) && a.F_MaterialId == item.F_MaterialId).ToList();
                    var tempstorage = currentStorages.Where(a => a.F_Id == item.F_MaterialId).FirstOrDefault();
                    item.F_StorageNum = tempstorage.F_Num;
                    tempstorage.F_Num -= item.F_Num - item.F_DoneNum;
                    if (tempstorage.F_Num < 0)
                    {
                        item.F_IsOk = false;
                    }
                    else
                    {
                        item.F_IsOk = true;
                    }
                    tempstorage.F_Num += (thisproducePlan.Sum(a => a.F_PlanNum) ?? 0) - (thisproducePlan.Sum(a => a.F_DoneNum) ?? 0);
                }
            }
            return list.Where(a=>a.F_PlanTime>currentdate).ToList();
        }

		public async Task<OutStorageEntity> GetOutStorageByCode(string keyword,bool isUn=false)
        {
            var data = repository.IQueryable().Where(a =>a.F_EnabledMark == true);
            if (!string.IsNullOrEmpty(keyword))
            {
                data = data.Where(t => t.F_OutStorageCode.Contains(keyword) || t.F_MaterialCode.Contains(keyword) || t.F_MaterialName.Contains(keyword));
            }
            var entity = data.FirstOrDefault();
            if (entity == null)
            {
                return entity;
            }
            entity.F_StorageNum = uniwork.IQueryable<OutStorageInfoEntity>(a => a.F_OutStorageId == entity.F_Id && a.F_IsTemp == true).Sum(a => a.F_Num);
            return entity;
        }

        public async Task<List<OutStorageEntity>> GetLookList(string keyword = "")
        {
            var query = repository.IQueryable();
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(t => t.F_OutStorageCode.Contains(keyword) || t.F_MaterialCode.Contains(keyword) || t.F_MaterialName.Contains(keyword));
            }
            query = GetDataPrivilege("u", "", query);
            return query.OrderByDesc(t => t.F_CreatorTime).ToList();
        }

        public async Task<OutStorageInfoEntity> GetOutStorageInfoByCode(string outStorageCode, string transferCode)
        {
            var outstorage = uniwork.IQueryable<OutStorageEntity>(a => a.F_OutStorageCode == outStorageCode).FirstOrDefault();
            if (outstorage == null)
            {
                return null;
            }
            var data = uniwork.IQueryable<OutStorageInfoEntity>().Where(a => a.F_OutStorageId == outstorage.F_Id&&a.F_TransferBoxCode == transferCode).ToList();
            var ids = data.Select(a => a.F_Id).ToList();
            var entity = data.FirstOrDefault();
            if (entity == null)
            {
                return null;
            }
            var donenum = data.Where(a=>a.F_IsTemp!=true).Sum(a=>a.F_Num);
            entity.F_Num = data.Where(a => a.F_IsTemp == true).Sum(a => a.F_Num);
            return entity;
        }

        public async Task<List<OutStorageInfoEntity>> GetUnBandingInfoByCode(string code)
        {
            var checkids = uniwork.IQueryable<NeedCheckEntity>(a => a.F_IsCheck == false && a.F_CheckType == 4).Select(a => a.F_SourceId).ToList();
            var list = new List<OutStorageInfoEntity>();
            var data = uniwork.IQueryable<OutStorageInfoEntity>().InnerJoin<OutStorageEntity>((a, b) => a.F_OutStorageId == b.F_Id && b.F_OutStorageCode == code).Select((a, b) => a).ToList();
            data = data.Where(a => !checkids.Contains(a.F_Id.ToString())).ToList();
            if (data == null)
            {
                return null;
            }
            foreach (var item in data.GroupBy(a=>a.F_TransferBoxCode).Select(a=>a.Key))
            {
                var temps = data.Where(a => a.F_TransferBoxCode == item);
                var entity = temps.FirstOrDefault();
                entity.F_Num = temps.Where(a => a.F_IsTemp == true).Sum(a => a.F_Num);
                var bandingNum = data.Where(a => a.F_IsTemp != true).Sum(a => a.F_Num);
                if (entity.F_Num>0)
                {
                    list.Add(entity);
                }
            }

            return list;
        }
        public async Task<List<OutStorageInfoEntity>> GetBandingInfoByCode(string code)
        {
            var list = new List<OutStorageInfoEntity>();
            var data = uniwork.IQueryable<OutStorageInfoEntity>(a=>a.F_IsTemp!=true).InnerJoin<OutStorageEntity>((a, b) => a.F_OutStorageId == b.F_Id && b.F_OutStorageCode == code).Select((a, b) => a).ToList();
            if (data == null)
            {
                return null;
            }
            foreach (var item in data.GroupBy(a => a.F_TransferBoxCode).Select(a => a.Key))
            {
                var temps = data.Where(a => a.F_TransferBoxCode == item);
                var entity = temps.FirstOrDefault();
                entity.F_Num = temps.Sum(a => a.F_Num);
                if (entity.F_Num > 0)
                {
                    list.Add(entity);
                }
            }

            return list;
        }
        public async Task<OutStorageInfoEntity> GetOutStorageBandingByCode(string outStorageCode, string transferCode)
        {
            var data = uniwork.IQueryable<OutStorageInfoEntity>(a=>a.F_IsTemp!=true).InnerJoin<OutStorageEntity>((a,b)=>a.F_OutStorageId==b.F_Id&& b.F_OutStorageCode == outStorageCode).Select((a,b)=>a).ToList();
            if (data == null)
            {
                return null;
            }
            var entity = data.FirstOrDefault();
            entity.F_Num = data.Sum(a => a.F_Num);
            return entity;
        }

        public async Task<List<MaterialEntity>> GetMaterialList(SoulPage<MaterialEntity> pagination, string keyword, string id)
        {
            //获取数据权限
            var list = uniwork.IQueryable<MaterialEntity>(a => a.F_DeleteMark == false);
            if (!string.IsNullOrEmpty(keyword))
            {
                list = list.Where(t => t.F_MaterialCode.Contains(keyword) || t.F_MaterialName.Contains(keyword));
            }
            if (!string.IsNullOrEmpty(id))
            {
                list = list.Where(u => u.F_Id == id);
            }
            return await repository.OrderList(list, pagination);
        }

        public async Task<List<OutStorageEntity>> GetLookList(SoulPage<OutStorageEntity> pagination,string keyword = "",string id="")
        {
            //反格式化显示只能用"等于"，其他不支持
            Dictionary<string, Dictionary<string, string>> dic = new Dictionary<string, Dictionary<string, string>>();
            var setList = await itemsApp.GetItemList("Mes_WorkOrderState");
            Dictionary<string, string> stateTemp = new Dictionary<string, string>();
            foreach (var item in setList)
            {
                stateTemp.Add(item.F_ItemName, item.F_ItemCode);
            }
            dic.Add("F_OutStorageState", stateTemp);
            pagination = ChangeSoulData(dic, pagination);
            //获取数据权限
            var query = IQueryable().Where(a=>a.F_EnabledMark == true);
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(t => t.F_OutStorageCode.Contains(keyword) || t.F_MaterialCode.Contains(keyword) || t.F_MaterialName.Contains(keyword));
            }
            if(!string.IsNullOrEmpty(id))
            {
                query= query.Where(u=>u.F_Id==id);
            }
            query = GetDataPrivilege("u","",query);
            return await repository.OrderList(query, pagination);
        }

        private IQuery<OutStorageEntity> IQueryable()
        {
            var query = repository.IQueryable()
                .LeftJoin<OrderEntity>((a, b) => a.F_OrderId == b.F_Id)
                .Select((a, b) => new OutStorageEntity
                {
                    F_CarNo=a.F_CarNo,
                    F_CreatorTime=a.F_CreatorTime,
                    F_CreatorUserId=a.F_CreatorUserId,
                    F_Description=a.F_Description,
                    F_DoneNum=a.F_DoneNum,
                    F_EnabledMark=a.F_EnabledMark,  
                    F_Id=a.F_Id,
                    F_OrderCode=b.F_OrderCode,
                    F_LastModifyTime=a.F_LastModifyTime,
                    F_LastModifyUserId=a.F_LastModifyUserId,
                    F_MaterialCode=a.F_MaterialCode,
                    F_MaterialId=a.F_MaterialId,
                    F_MaterialName=a.F_MaterialName,
                    F_MaterialType=a.F_MaterialType,
                    F_MaterialUnit=a.F_MaterialUnit,
                    F_Num=a.F_Num,
                    F_OrderId=a.F_OrderId,
                    F_OutStorageCode=a.F_OutStorageCode,
                    F_OutStorageState=a.F_OutStorageState,
                    F_PlanTime=a.F_PlanTime,

                });
            return query;
        }

        public async Task<OutStorageEntity> GetForm(string keyValue)
        {
            var data = IQueryable().Where(a=>a.F_Id==keyValue).FirstOrDefault();
            return data;
        }
        #endregion

        public async Task<OutStorageEntity> GetLookForm(object keyValue)
        {
            var data = IQueryable().Where(a => a.F_Id == keyValue).FirstOrDefault();
            data = GetFieldsFilterData(data);
            var list=  uniwork.IQueryable<OutStorageInfoEntity>(a => a.F_OutStorageId == keyValue.ToString());
            data.list = list.ToList();
            data.F_StorageNum = data.list.Where(a=>a.F_IsTemp!=true).Sum(a => a.F_Num);            
            data.list = data.list.OrderBy(a => a.F_LocationCode).ToList();
            return data;
        }

        #region 提交数据
        public async Task SubmitForm(OutStorageEntity entity, string keyValue)
        {
            if (uniwork.IQueryable<StorageEntity>(a=>a.F_MaterialId==entity.F_MaterialId && a.F_IsCheckout == true).Sum(a=>a.F_Num)<entity.F_Num)
            {
                throw new Exception("库存不足无法创建");
            }
            if (!string.IsNullOrEmpty(entity.F_OrderId))
            {
                var order = await uniwork.FindEntity<OrderEntity>(a => a.F_Id == entity.F_OrderId && a.F_IsFinish == false);
                if (order == null)
                {
                    throw new Exception("订单已结案，请换个订单");
                }
            }
            if (string.IsNullOrEmpty(keyValue))
            {
                entity.Create();
                entity.F_IsUserEdit = true;
                var material = await uniwork.FindEntity<MaterialEntity>(entity.F_MaterialId);
                entity.F_MaterialCode = material.F_MaterialCode;
                entity.F_MaterialName = material.F_MaterialName;
                entity.F_MaterialType = material.F_MaterialType;
                entity.F_MaterialUnit = material.F_MaterialUnit;
                entity.F_DoneNum = 0;
                entity.F_OutStorageState = 0;
				if (entity.F_PlanTime==null)
				{
                    entity.F_PlanTime = DateTime.Now.Date;
                }
                await repository.Insert(entity);
            }
            else
            {
                entity.Modify(keyValue);
                entity.F_IsUserEdit = true;
                var old = await repository.FindEntity(keyValue);
                if (old.F_DoneNum > 0)
                {
                    throw new Exception("出库单已开始作业无法修改");
                }
                var material = await uniwork.FindEntity<MaterialEntity>(entity.F_MaterialId);
                entity.F_MaterialCode = material.F_MaterialCode;
                entity.F_MaterialName = material.F_MaterialName;
                entity.F_MaterialType = material.F_MaterialType;
                entity.F_MaterialUnit = material.F_MaterialUnit;
                await repository.Update(entity);
            }
        }

        public async Task DisabledForm(string keyValue)
        {
            var inNote = await repository.FindEntity(keyValue);
            uniwork.BeginTrans();
            if (inNote != null && inNote.F_OutStorageState == 1)
            {
                await repository.Update(a => a.F_Id == keyValue && a.F_OutStorageState == 1, a => new OutStorageEntity
                {
                    F_OutStorageState = 3
                });
            }
            else
            {
                throw new Exception("出库单无需终止");
            }
            var job = await uniwork.FindEntity<ControlJobEntity>(a => a.F_NeedId == inNote.F_Id && a.F_JobType == 2 && a.F_JobState < 2);
            if (job != null)
            {
                await jobApp.CloseJob(job.F_Id);
            }
            uniwork.Commit();
        }

        public async Task EnabledForm(string keyValue)
        {
            var outNote = await repository.FindEntity(keyValue);
            if (uniwork.IQueryable<StorageEntity>(a => a.F_MaterialId == outNote.F_MaterialId && a.F_IsCheckout == true).Sum(a => a.F_Num) < outNote.F_Num)
            {
                throw new Exception("库存不足无法启动");
            }
            uniwork.BeginTrans();
            if (outNote == null || outNote.F_OutStorageState > 0)
            {
                throw new Exception("出库单已开始作业无需启动");
            }
            else
            {
                await repository.Update(a => a.F_Id == keyValue && a.F_OutStorageState == 0 && a.F_DoneNum == 0, a => new OutStorageEntity
                {
                    F_OutStorageState = 1
                });
            }
            if (outNote.F_PlanTime != null && ((DateTime)outNote.F_PlanTime).Date != DateTime.Now.Date)
            {
                throw new Exception("出库单计划时间不是今天的，请检查");
            }
            //创建任务
            ControlJobEntity jobEntity = new ControlJobEntity();
            jobEntity.F_JobType = 2;
            jobEntity.F_NeedId = keyValue;
            jobEntity.F_Priority = 1;
            jobEntity.F_NeedNum = outNote.F_Num;
            jobEntity.F_JobCode = "CJ_" + DateTime.Now.ToString("yyyyMMddHHmmss")+0;
            jobEntity.F_JobInfo = "产品出库,出库单号为" + outNote.F_OutStorageCode + ",物料编号为" + outNote.F_MaterialCode + ",名称为" + outNote.F_MaterialCode + "的物料需要出库。";
            jobEntity.F_JobInfo += "数量为" + outNote.F_Num;
            await jobApp.SubmitForm(jobEntity);
            uniwork.Commit();
        }

        public async Task DeleteForm(string keyValue)
        {
            var ids = keyValue.Split(',');
            if (repository.IQueryable(a => ids.Contains(a.F_Id) && a.F_DoneNum > 0).Count() > 0)
            {
                throw new Exception("出库单已开始作业无法删除");
            }
            if (uniwork.IQueryable<ControlJobEntity>(a => ids.Contains(a.F_NeedId) && a.F_JobType == 2 && a.F_JobState > 0).Count() > 0)
            {
                throw new Exception("出库单已开始作业无法删除");
            }
            uniwork.BeginTrans();
            await repository.Delete(t => ids.Contains(t.F_Id.ToString()));
            await uniwork.Delete<ControlJobEntity>(t => ids.Contains(t.F_NeedId) && t.F_JobType == 2);
            uniwork.Commit();
        }
        public async Task OutStorage(OutStorageInfoEntity entity)
        {
            //判断流转箱状态
            var transferBox = await uniwork.FindEntity<TransferBoxEntity>(a => a.F_TransferCode == entity.F_TransferBoxCode);
            if (transferBox == null || transferBox.F_TransferState != 2 || string.IsNullOrEmpty(transferBox.F_LocationCode))
            {
                throw new Exception($"流转箱{entity.F_TransferBoxCode}没有记录");
            }
            var storage = uniwork.IQueryable<StorageEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode).FirstOrDefault();
            if (storage==null)
            {
                throw new Exception($"流转箱{entity.F_TransferBoxCode}没有库存");
            }
            //获取物料信息
            var material = await uniwork.FindEntity<MaterialEntity>(a => a.F_Id == storage.F_MaterialId);
            if (material == null)
            {
                throw new Exception($"物料编号:{entity.F_MaterialCode}不存在");
            }
            if (uniwork.IQueryable<NeedCheckEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_IsCheck == false).Count() > 0)
            {
                throw new Exception("物料正在检验，无法使用");
            }
            if (storage.F_IsCheckout != true)
			{
                throw new Exception($"流转箱{entity.F_TransferBoxCode}库存没有经过检验");
            }
            if (entity.F_Num > storage.F_Num)
            {
                throw new Exception("库存不足，请修改数量");
            }
            var codelist = uniwork.IQueryable<OutStorageInfoEntity>(a => a.F_MaterialId == storage.F_MaterialId && a.F_IsTemp == true).Select(a=>a.F_TransferBoxCode).ToList();
            var first = uniwork.IQueryable<StorageEntity>(a => a.F_MaterialId == storage.F_MaterialId && a.F_IsCheckout == true && !codelist.Contains(a.F_TransferBoxCode)).OrderBy(a => a.F_MaterialBatch.Substring(4)).FirstOrDefault();
            var creatorTime = ((DateTime)first.F_CreatorTime).Date;
            var realStorages = uniwork.IQueryable<StorageEntity>(a => a.F_MaterialId == storage.F_MaterialId && a.F_IsCheckout == true && a.F_CreatorTime >= creatorTime && a.F_CreatorTime< creatorTime.AddDays(1) && !codelist.Contains(a.F_TransferBoxCode)).Select(a => a.F_Id).ToList();
            //允许违反先出规则
            var area = uniwork.IQueryable<LocationEntity>(a => a.F_LocationCode == storage.F_LocationCode)
                .InnerJoin<AreaEntity>((a, b) => a.F_AreaId == b.F_Id).Select((a, b) => b).FirstOrDefault();
            if (!realStorages.Contains(storage.F_Id) && area.F_NeedRule == true)
            {
                throw new Exception("请遵循先进先出原则");
            }
            //获取出库单
            List<OutStorageEntity> outNotes = new List<OutStorageEntity>();
            if (string.IsNullOrEmpty(entity.F_OutStorageCode))
            {
                outNotes = uniwork.IQueryable<OutStorageEntity>(a => a.F_MaterialId == storage.F_MaterialId && a.F_EnabledMark == true && a.F_OutStorageState == 1 && a.F_DoneNum != a.F_Num).OrderBy(a => a.F_CreatorTime).ToList();
            }
            else
            {
                var outNote = await uniwork.FindEntity<OutStorageEntity>(a=>a.F_OutStorageCode==entity.F_OutStorageCode);
                entity.F_OutStorageId = outNote.F_Id;
                if (outNote != null && outNote.F_OutStorageState == 1)
                {
                    outNotes.Add(outNote);
                }
            }
            if (entity.F_Num > outNotes.Sum(a=>a.F_Num-a.F_DoneNum))
            {
                throw new Exception("下架数量超过所需数量");
            }
            uniwork.BeginTrans();
            if (entity.F_Num != storage.F_Num)
            {
				if (string.IsNullOrEmpty(entity.TargetTransferCode))
				{
                    throw new Exception("拆分下架，请输入目标流转箱");
                }
                StorageChangeInfoEntity change = new StorageChangeInfoEntity();
                change.F_TransferBoxCode = entity.F_TransferBoxCode;
                change.F_Num = entity.F_Num;
                change.F_NewTransferBoxCode = entity.TargetTransferCode;
                change.F_NewLocationCode =(await locationApp.GetLocationListByLocation(storage.F_LocationCode, storage.F_MaterialCode)).Where(a=>a.F_LocationState==false).FirstOrDefault().F_LocationCode;
                change.F_Description = entity.F_Description;
                change.F_ChangeType = 0;
                await _storageApp.StorageChange(change, false, false);
                storage = uniwork.IQueryable<StorageEntity>(a => a.F_TransferBoxCode == entity.TargetTransferCode).FirstOrDefault();
                entity.F_TransferBoxCode = storage.F_TransferBoxCode;
                entity.F_LocationCode = storage.F_LocationCode;
            }
            await uniwork.Update<TransferBoxEntity>(a => a.F_TransferCode == storage.F_TransferBoxCode && a.F_TransferState == 2, a => new TransferBoxEntity
            {
                F_TransferState=5,
                F_LocationCode=null
            });
            await uniwork.Update<LocationEntity>(a => a.F_LocationCode == storage.F_LocationCode && a.F_LocationState == true, a => new LocationEntity
            {
                F_LocationState = false,
            });
            float num = entity.F_Num ?? 0;
            int resultId = 0;
            //扣除出库单作业数量
            //添加出库单记录
            foreach (var item in outNotes)
            {
                if (num == 0)
                {
                    break;
                }
                OutStorageInfoEntity temp = new OutStorageInfoEntity();
                temp.F_Id = 0;
                temp.F_CreatorUserId = currentuser.UserId;
                temp.F_CreatorTime = DateTime.Now;
                temp.F_CreatorUserName = currentuser.UserName;
                temp.F_OutStorageId = item.F_Id;
                temp.F_MaterialCode = storage.F_MaterialCode;
                temp.F_MaterialName = storage.F_MaterialName;
                temp.F_MaterialType = storage.F_MaterialType;
                temp.F_MaterialUnit = storage.F_MaterialUnit;
                temp.F_MaterialBatch = storage.F_MaterialBatch;
                temp.F_MaterialId = storage.F_MaterialId;
                temp.F_TransferBoxCode = entity.F_TransferBoxCode;
                temp.F_LocationCode = transferBox.F_LocationCode;
                temp.F_Description = entity.F_Description;
                temp.F_EnabledMark = true;
                temp.F_IsTemp = true;
                if (item.F_Num <= item.F_DoneNum + num)
                {
                    resultId = await uniwork.Update<OutStorageEntity>(a => a.F_Id == item.F_Id && a.F_OutStorageState == 1 && a.F_Num <= a.F_DoneNum + num, a => new OutStorageEntity
                    {
                        F_DoneNum = a.F_Num
                    });
                    if (resultId <= 0)
                    {
                        throw new Exception("数量异常，请重新提交");
                    }
                    await uniwork.Update<OutStorageEntity>(a => a.F_Id == item.F_Id && a.F_OutStorageState == 1 && a.F_Num == a.F_DoneNum, a => new OutStorageEntity
                    {
                        F_OutStorageState = 2
                    });
                    temp.F_Num = item.F_Num - item.F_DoneNum;
                    num = num - (item.F_Num ?? 0 - item.F_DoneNum ?? 0);
                }
                else
                {
                    resultId = await uniwork.Update<OutStorageEntity>(a => a.F_Id == item.F_Id && a.F_OutStorageState == 1 && a.F_Num > a.F_DoneNum + num, a => new OutStorageEntity
                    {
                        F_DoneNum = a.F_DoneNum + num
                    });
                    if (resultId <= 0)
                    {
                        throw new Exception("数量异常，请重新提交");
                    }
                    temp.F_Num = num;
                    num = 0;
                }
                await uniwork.Insert(temp);
            }
            if (material.F_NeedCheckout == true && GlobalContext.SystemConfig.OutStorageCheck == true)
            {
                var check = uniwork.IQueryable<NeedCheckEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_CheckType == 4 && a.F_IsCheck == false).FirstOrDefault();
                if (check != null)
                {
                    throw new Exception($"流转箱编号{entity.F_TransferBoxCode},已有出库检验任务");
                }
                else
                {
                    //创建检验单，创建调度任务
                    check = new NeedCheckEntity();
                    check.F_Id = 0;
                    check.F_SourceId = storage.F_Id;
                    check.F_CreatorTime = DateTime.Now;
                    check.F_CheckType = 4;
                    check.F_IsCheck = false;
                    check.F_IsNeedTwoCheck = false;
                    check.F_IsTwoCheck = false;
                    check.F_MaterialBatch = storage.F_MaterialBatch;
                    check.F_MaterialCode = storage.F_MaterialCode;
                    check.F_MaterialId = storage.F_MaterialId;
                    check.F_MaterialName = storage.F_MaterialName;
                    check.F_MaterialType = storage.F_MaterialType;
                    check.F_MaterialUnit = storage.F_MaterialUnit;
                    check.F_Num = entity.F_Num;
                    check.F_TransferBoxCode = storage.F_TransferBoxCode;
                    ControlJobEntity jobEntity = new ControlJobEntity();
                    jobEntity.F_JobType = 8;
                    jobEntity.F_NeedId = check.F_TransferBoxCode;
                    jobEntity.F_Priority = 1;
                    jobEntity.F_NeedNum = entity.F_Num;
                    jobEntity.F_JobCode = "CJ_" + DateTime.Now.ToString("yyyyMMddHHmmss") + 0;
                    jobEntity.F_JobInfo = "常规检验-出库检验," + "流转箱编号为" + check.F_TransferBoxCode + ",物料编号为" + material.F_MaterialCode + ",名称为" + material.F_MaterialName + "的物料进行检验。";
                    jobEntity.F_JobInfo += "数量为" + entity.F_Num;
                    await jobApp.SubmitForm(jobEntity);
                    await uniwork.Insert(check);
                    await uniwork.Update<StorageEntity>(a => a.F_Id == storage.F_Id, a => new StorageEntity
                    {
                        F_IsCheckout = true
                    });
                }
            }
            else
            {
                var job = await uniwork.FindEntity<ControlJobEntity>(a => a.F_NeedId == entity.F_TransferBoxCode && a.F_JobType == 11 && a.F_JobState < 2);
                if (job != null)
                {
                    throw new Exception($"流转箱编号{entity.F_TransferBoxCode},已有出库装箱任务");
                }
                else
                {
                    //创建调度任务
                    ControlJobEntity jobEntity = new ControlJobEntity();
                    jobEntity.F_JobType = 11;
                    jobEntity.F_NeedId = entity.F_TransferBoxCode;
                    jobEntity.F_Priority = 1;
                    jobEntity.F_NeedNum = entity.F_Num;
                    jobEntity.F_JobCode = "CJ_" + DateTime.Now.ToString("yyyyMMddHHmmss") + 0;
                    jobEntity.F_JobInfo = "出库装箱," + "流转箱编号为" + entity.F_TransferBoxCode + ",物料编号为" + material.F_MaterialCode + ",名称为" + material.F_MaterialName + "的物料进行出库。";
                    jobEntity.F_JobInfo += "数量为" + entity.F_Num;
                    await jobApp.SubmitForm(jobEntity);
                    //取消出库装箱，直接出库
                    if (GlobalContext.SystemConfig.OutStorageCheck != true)
                    {
                        OutStorageInfoEntity entity1 = new OutStorageInfoEntity();
                        entity1.F_OutStorageCode = entity.F_OutStorageCode;
                        entity1.F_TransferBoxCode = entity.F_TransferBoxCode;
                        entity1.F_TargetTransferCode = entity.F_TransferBoxCode;
                        entity1.F_Num = entity.F_Num;
                        entity1.F_Description = entity1.F_Description;
                        await OutStorageBanding(entity1);
                    }
                }
            }
            uniwork.Commit();
            await _logApp.WriteLog(3, "出库:物料" + material.F_MaterialName + "出库数量" + (entity.F_Num ?? 0), "", "", material.F_MaterialName, entity.F_TransferBoxCode, entity.F_Num);
        }
        public async Task OutStorageCancle(OutStorageInfoEntity entity)
        {
            //获取出库单信息
            var outstorage = await repository.FindEntity(a => a.F_OutStorageCode == entity.F_OutStorageCode);
            if (outstorage == null)
            {
                throw new Exception($"出库单编号{entity.F_OutStorageCode}不存在");
            }
            if (string.IsNullOrEmpty(entity.F_TransferBoxCode))
            {
                throw new Exception($"流转箱{entity.F_TransferBoxCode}不可用");
            }
            entity.F_OutStorageId = outstorage.F_Id;
            //获取物料信息
            var material = await uniwork.FindEntity<MaterialEntity>(a => a.F_Id == outstorage.F_MaterialId);
            if (material == null)
            {
                throw new Exception($"物料编号:{entity.F_MaterialCode}不存在");
            }
            uniwork.BeginTrans();
            var list= uniwork.IQueryable<OutStorageInfoEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_OutStorageId == entity.F_OutStorageId && a.F_IsTemp == true).ToList();
            var sum = list.Sum(a => a.F_Num)??0;
			if (sum==0)
			{
                throw new Exception($"流转箱{entity.F_TransferBoxCode}不存在下架数量");
            }
            //判断流转箱类型和物料、数量是否对应
            if (!locationApp.IsUseLocation(entity.F_LocationCode, material.F_MaterialCode))
            {
                throw new Exception($"库位:{entity.F_LocationCode}不可用");
            }
            //更新出库单
            await uniwork.Update<OutStorageEntity>(a => a.F_Id == outstorage.F_Id, a => new OutStorageEntity
            {
                F_OutStorageState = 1,
                F_DoneNum=a.F_DoneNum- sum
            });
            //删除绑定
            await uniwork.Delete<OutStorageInfoEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_OutStorageId == entity.F_OutStorageId && a.F_IsTemp == true);
            if (material.F_NeedCheckout == true)
            {
                //删除检验单
                var checks = await uniwork.FindEntity<NeedCheckEntity>(a => a.F_TransferBoxCode ==entity.F_TransferBoxCode && a.F_CheckType==4&&a.F_MaterialBatch==list[0].F_MaterialBatch&&a.F_IsCheck==false);
                if (checks != null)
                {
                    await uniwork.Delete<ScapMaterialEntity>(a => a.F_CheckId == checks.F_Id);
                    await uniwork.Delete<NeedCheckEntity>(a => a.F_Id == checks.F_Id);
                }
            }
            //更新库位状态
            var  resultId = await uniwork.Update<LocationEntity>(a => a.F_LocationCode == entity.F_LocationCode && a.F_LocationState == false, a => new LocationEntity
            {
                F_LocationState = true,
            });
            if (resultId <= 0)
            {
                throw new Exception("库位异常，请重新提交");
            }
            resultId = await uniwork.Update<StorageEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode, a => new StorageEntity
            {
                F_LocationCode = entity.F_LocationCode
            });
            if (resultId <= 0)
            {
                throw new Exception("库存异常，请重新提交");
            }
            resultId = await uniwork.Update<TransferBoxEntity>(a => a.F_TransferCode == entity.F_TransferBoxCode && a.F_TransferState == 5, a => new TransferBoxEntity
            {
                F_TransferState = 2,
                F_LocationCode = entity.F_LocationCode
            });
            if (resultId <= 0)
            {
                throw new Exception("流转箱异常，请重新提交");
            }
            //关闭调度任务
            var job = await uniwork.FindEntity<ControlJobEntity>(a => a.F_NeedId == entity.F_TransferBoxCode && (a.F_JobType == 11 || a.F_JobType == 8) && a.F_JobState < 2);
            if (job != null)
            {
                await jobApp.CloseJob(job.F_Id);
            }
            uniwork.Commit();
        }
        public async Task OutStorageBanding(OutStorageInfoEntity entity)
        {
            //获取出库单信息
            var outstorage =await repository.FindEntity(a => a.F_OutStorageCode == entity.F_OutStorageCode);
            if (outstorage == null)
            {
                throw new Exception($"出库单编号{entity.F_OutStorageCode}不存在");
            }
            if (string.IsNullOrEmpty(entity.F_TransferBoxCode))
            {
                throw new Exception($"流转箱{entity.F_TransferBoxCode}不可用");
            }
            if (uniwork.IQueryable<NeedCheckEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_IsCheck == false).Count() > 0)
            {
                throw new Exception("物料正在检验，无法使用");
            }
            entity.F_OutStorageId = outstorage.F_Id;
            var temps = new List<OutStorageInfoEntity>();
            //流转箱判断
            var transfer = uniwork.IQueryable<TransferBoxEntity>(a => a.F_TransferCode == entity.F_TargetTransferCode && a.F_EnabledMark == true && a.F_DeleteMark == false).FirstOrDefault();
            if (transfer != null)
            {
                if (transfer.F_TransferType != "0" && uniwork.IQueryable<TransferTypeMaterialBandingEntity>(a => a.F_TransferType == transfer.F_TransferType && a.F_MaterialId == entity.F_MaterialId).Count() == 0)
                {
                    throw new Exception($"目标流转箱{entity.F_TargetTransferCode}不可用");
                }
                if (transfer.F_TransferState == 0)
                {
                    if (transfer.F_TransferMaxNum < entity.F_Num)
                    {
                        throw new Exception($"目标流转箱{entity.F_TargetTransferCode}不可用");
                    }
                }
                else if (transfer.F_TransferState == 4)
                {
                    temps = uniwork.IQueryable<OutStorageInfoEntity>(a => a.F_TargetTransferCode == entity.F_TransferBoxCode && a.F_OutStorageId == entity.F_OutStorageId &&a.F_IsTemp!=true).ToList();
                    if (temps.Count == 0)
                    {
                        throw new Exception($"目标流转箱{entity.F_TargetTransferCode}不可用");
                    }
                    if (transfer.F_TransferMaxNum < entity.F_Num + temps.Sum(a => a.F_Num))
                    {
                        throw new Exception($"目标流转箱{entity.F_TargetTransferCode}可存放数量超出");
                    }
                }
                else if (transfer.F_TransferState == 5)
                {
                    temps = uniwork.IQueryable<OutStorageInfoEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_OutStorageId == entity.F_OutStorageId && a.F_IsTemp == true).ToList();
                    if (temps.Count == 0)
                    {
                        throw new Exception($"目标流转箱{entity.F_TargetTransferCode}不可用");
                    }
                    if (entity.F_Num!= temps.Sum(a=>a.F_Num))
                    {
                        throw new Exception($"目标流转箱{entity.F_TargetTransferCode}可存放数量超出");
                    }
                }
                else
                {
                    throw new Exception($"目标流转箱{entity.F_TargetTransferCode}不可用");
                }
            }
            var outsotrageInfos = uniwork.IQueryable<OutStorageInfoEntity>(a => a.F_OutStorageId == entity.F_OutStorageId && a.F_TransferBoxCode == entity.F_TransferBoxCode&&a.F_IsTemp==true).ToList();
            if (outsotrageInfos==null|| outsotrageInfos.Count==0)
            {
                throw new Exception($"出库单编号{entity.F_OutStorageCode},流转箱{entity.F_TransferBoxCode}出库记录不存在");
            }
            //添加可绑定信息数量
            var bandings = new List<OutStorageInfoEntity>();
            float countNum = entity.F_Num??0;
            DateTime dt = DateTime.Now;
            uniwork.BeginTrans();
            foreach (var item in outsotrageInfos)
            {
                if (item.F_Num == 0) continue;
                if (countNum == 0) break;
                OutStorageInfoEntity temp = new OutStorageInfoEntity();
                temp.F_BandingUserId = currentuser.UserId;
                temp.F_BandingUserName = currentuser.UserName;
                temp.F_BandingTime = dt;
                if (countNum >= item.F_Num)
                {
                    countNum -= item.F_Num??0;
                    await uniwork.Update<OutStorageInfoEntity>(a => a.F_Id == item.F_Id&&a.F_IsTemp==true, a => new OutStorageInfoEntity
                    {
                        F_IsTemp=false,
                        F_BandingUserId=temp.F_BandingUserId,
                        F_BandingUserName = temp.F_BandingUserName,
                        F_BandingTime = temp.F_BandingTime,
                        F_TargetTransferCode=entity.F_TargetTransferCode
                    });
                    //关闭调度任务
                    var job = await uniwork.FindEntity<ControlJobEntity>(a => a.F_NeedId == entity.F_TransferBoxCode && a.F_JobType == 11 && a.F_JobState < 2);
                    if (job != null)
                    {
                        await jobApp.FinishJob(job.F_Id);
                    }
                }
                else
                {
                    temp.F_Num = countNum;
                    countNum = 0;
                    await uniwork.Update<OutStorageInfoEntity>(a => a.F_Id == item.F_Id && a.F_IsTemp == true, a => new OutStorageInfoEntity
                    {
                        F_IsTemp = false,
                        F_BandingUserId = temp.F_BandingUserId,
                        F_BandingUserName = temp.F_BandingUserName,
                        F_BandingTime = temp.F_BandingTime,
                        F_Num= temp.F_Num,
                        F_TargetTransferCode = entity.F_TargetTransferCode
                    });
                    item.F_Id = 0;
                    item.F_Num -= temp.F_Num;
                    await uniwork.Insert(item);
                }
            }
            if (countNum!=0)
            {
                throw new Exception($"可绑定数量不足");
            }
            var storage = await uniwork.FindEntity<StorageEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_Num >= entity.F_Num);
            if (storage == null)
            {
                throw new Exception($"流转箱{entity.F_TransferBoxCode}库存不存在");
            }
            //扣除库存信息
            var resultId = await uniwork.Update<StorageEntity>(a => a.F_Id == storage.F_Id && a.F_Num >= entity.F_Num, a => new StorageEntity
            {
                F_Num = a.F_Num - entity.F_Num
            });
            if (resultId == 0)
            {
                throw new Exception("出库数量超出库存数量，请核对数量");
            }
            //删除0的库存
            resultId = await uniwork.Delete<StorageEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_Num == 0);
            await uniwork.Update<TransferBoxEntity>(a => a.F_TransferCode == entity.F_TargetTransferCode, a => new TransferBoxEntity
            {
                F_TransferState = 4
            });
            await uniwork.Delete<TransferBoxEntity>(a => a.F_TransferCode == entity.F_TargetTransferCode && a.F_IsTemp == true);
            if (resultId > 0 && entity.TargetTransferCode != entity.F_TransferBoxCode)
            {
                //更新流转箱状态
                await uniwork.Update<TransferBoxEntity>(a => a.F_TransferCode == entity.F_TransferBoxCode && a.F_TransferState == 5, a => new TransferBoxEntity
                {
                    F_TransferState = 0,
                    F_LocationCode = null
                });
                await uniwork.Delete<TransferBoxEntity>(a => a.F_TransferCode == entity.F_TransferBoxCode && a.F_IsTemp == true);
                if (resultId == 0)
                {
                    throw new Exception("流转箱没有记录");
                }
            }
            if (outstorage.F_Num == uniwork .IQueryable <OutStorageInfoEntity>(a=>a.F_OutStorageId==outstorage.F_Id&&a.F_IsTemp!=true).Sum(a=>a.F_Num))
            {
                await uniwork.Update<OutStorageEntity>(a => a.F_Id == outstorage.F_Id, a => new OutStorageEntity { 
                    F_OutStorageState=4
                });
                //绑定信息全部完成更新完成任务
                var job = await uniwork.FindEntity<ControlJobEntity>(a => a.F_NeedId == outstorage.F_Id && a.F_JobType == 2 && a.F_JobState < 2);
                if (job != null)
                {
                    await jobApp.FinishJob(job.F_Id);
                }
                var orderdetails = uniwork.IQueryable<OrderDetailEntity>(a=>a.F_OrderId == outstorage.F_OrderId).ToList();
                var dones = uniwork.IQueryable<OutStorageEntity>(a => a.F_OrderId == outstorage.F_OrderId).GroupBy(a => a.F_MaterialId).Select(a => new { a.F_MaterialId, F_Num = Sql.Sum(a.F_DoneNum) });
                bool isFinish = true;
                foreach (var item in orderdetails)
                {
                    if (dones.Where(a => a.F_MaterialId == item.F_MaterialId && a.F_Num >= item.F_NeedNum).Count() == 0)
                    {
                        isFinish=false;
                    }
                }
                if (isFinish)
                {
                    await uniwork.Update<OrderEntity>(a => a.F_Id == outstorage.F_OrderId, a => new OrderEntity
                    {
                        F_IsFinish=true,
                        F_ActualOverTime=DateTime.Now.Date
                    });
                }
            }
            uniwork.Commit();
        }

        #endregion

    }
}
