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
using WaterCloud.Service.SystemSecurity;

namespace WaterCloud.Service.MaterialManage
{
	/// <summary>
	/// 创 建：超级管理员
	/// 日 期：2020-12-16 13:37
	/// 描 述：入库管理服务类
	/// </summary>
	public class InStorageService : DataFilterService<InStorageEntity>, IDenpendency
    {
        private ItemsDataService itemsApp;
        private TransferBoxService transferApp;
        private LocationService locationApp;
        private ControlJobService jobApp;
        private BusinessLogService _logApp;
        public InStorageService(IDbContext context, IHttpClientFactory httpClientFactory) : base(context)
        {
            itemsApp = new ItemsDataService(context);
            transferApp = new TransferBoxService(context);
            locationApp = new LocationService(context);
            jobApp = new ControlJobService(context, httpClientFactory);
            _logApp = new BusinessLogService(context);
        }

        #region 获取数据
        public async Task<List<InStorageEntity>> GetList(string keyword = "")
        {
            var data = repository.IQueryable();
            if (!string.IsNullOrEmpty(keyword))
            {
                data = data.Where(t => t.F_InStorageCode.Contains(keyword) || t.F_MaterialCode.Contains(keyword) || t.F_MaterialName.Contains(keyword));
            }
            return data.OrderByDesc(t => t.F_CreatorTime).ToList();
        }
        public async Task<List<InStorageEntity>> GetLookList(string keyword = "")
        {
            var query = repository.IQueryable();
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(t => t.F_InStorageCode.Contains(keyword) || t.F_MaterialCode.Contains(keyword) || t.F_MaterialName.Contains(keyword));
            }
            query = GetDataPrivilege("u", "", query);
            return query.OrderByDesc(t => t.F_CreatorTime).ToList();
        }
        public async Task<InStorageEntity> GetInStorageByCode(string keyword)
        {
            var data = repository.IQueryable().Where(a=>a.F_EnabledMark == true);
            if (!string.IsNullOrEmpty(keyword))
            {
                data = data.Where(t => t.F_InStorageCode.Contains(keyword) || t.F_MaterialCode.Contains(keyword) || t.F_MaterialName.Contains(keyword));
            }
            var entity = data.FirstOrDefault();
            if (entity == null)
            {
                return entity;
            }
            entity.F_StorageNum = uniwork.IQueryable<InStorageInfoEntity>(a => a.F_InStorageId == entity.F_Id).Sum(a => a.F_Num);
            entity.F_ContainerNum = uniwork.IQueryable<MaterialEntity>(a => a.F_Id == entity.F_MaterialId).FirstOrDefault().F_ContainerNum;
            return entity;
        }

        public async Task<List<InStorageEntity>> GetPlanList(int dayCount)
        {
            DateTime startTime = DateTime.Now.Date;
            DateTime endTime = startTime.AddDays(dayCount);
            var data = uniwork.IQueryable<InStorageEntity>(a => a.F_PlanTime != null && a.F_PlanTime > startTime && a.F_PlanTime <= endTime ).ToList();
            data = data.OrderBy(a => a.F_PlanTime).ToList();
            var list = new List<InStorageEntity>();
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

            return list;
        }

        public async Task<List<InStorageEntity>> GetLookList(SoulPage<InStorageEntity> pagination,string keyword = "",string id="")
        {
            //反格式化显示只能用"等于"，其他不支持
            Dictionary<string, Dictionary<string, string>> dic = new Dictionary<string, Dictionary<string, string>>();
            var setList = await itemsApp.GetItemList("Mes_WorkOrderState");
            Dictionary<string, string> stateTemp = new Dictionary<string, string>();
            foreach (var item in setList)
            {
                stateTemp.Add(item.F_ItemName, item.F_ItemCode);
            }
            dic.Add("F_InStorageState", stateTemp);
            pagination = ChangeSoulData(dic, pagination);
            //获取数据权限
            var query = repository.IQueryable().Where(a=>a.F_EnabledMark == true);
            if (!string.IsNullOrEmpty(keyword))
            {
                //此处需修改
                query = query.Where(t => t.F_InStorageCode.Contains(keyword) || t.F_MaterialCode.Contains(keyword) || t.F_MaterialName.Contains(keyword));
            }
            if (!string.IsNullOrEmpty(id))
            {
                query = query.Where(u => u.F_Id == id);
            }
            query = GetDataPrivilege("u", "", query);
            return await repository.OrderList(query, pagination);
        }

        public async Task<InStorageEntity> GetForm(string keyValue)
        {
            var data = await repository.FindEntity(keyValue);
            return data;
        }
        public async Task<List<InStorageInfoEntity>> GetInStorageBandingList(string keyword)
        {
            var checkids = uniwork.IQueryable<NeedCheckEntity>(a => a.F_IsCheck == false && a.F_CheckType == 0).Select(a => a.F_SourceId).ToList();
            var query = uniwork.IQueryable<InStorageInfoEntity>(a=>a.F_IsTemp == true).InnerJoin<InStorageEntity>((a,b)=>a.F_InStorageId==b.F_Id)
                .Select((a,b)=>new InStorageInfoEntity
                { 
                F_Id=a.F_Id,
                F_BandingTime=a.F_BandingTime,
                F_BandingUserId=a.F_BandingUserId,
                F_BandingUserName= a.F_BandingUserName,
                F_CreatorTime=a.F_CreatorTime,
                F_CreatorUserId=a.F_CreatorUserId,
                F_CreatorUserName=a.F_CreatorUserName,
                F_Description=a.F_Description,
                F_EnabledMark=a.F_EnabledMark,
                F_InStorageCode=b.F_InStorageCode,
                F_InStorageId=a.F_InStorageId,
                F_MaterialCode=a.F_MaterialCode,
                F_MaterialBatch=a.F_MaterialBatch,
                F_MaterialId=a.F_MaterialId,
                F_MaterialName=a.F_MaterialName,
                F_MaterialType=a.F_MaterialType,
                F_MaterialUnit=a.F_MaterialUnit,
                F_Num=a.F_Num,
                F_TransferBoxCode=a.F_TransferBoxCode,
                });
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(a => a.F_TransferBoxCode.Contains(keyword) || a.F_MaterialCode.Contains(keyword)
                 || a.F_MaterialName.Contains(keyword) || a.F_MaterialBatch.Contains(keyword));
            }
            return query.Where(a => !checkids.Contains(a.F_Id.ToString())).OrderBy(a => a.F_CreatorTime).ToList();
        }
        #endregion

        public async Task<InStorageEntity> GetLookForm(object keyValue)
        {
            var data = await repository.FindEntity(keyValue);
            data = GetFieldsFilterData(data);
            data.list = uniwork.IQueryable<InStorageInfoEntity>(a => a.F_InStorageId == keyValue.ToString()).ToList();
            data.F_StorageNum = data.list.Where(a => a.F_IsTemp != true).Sum(a => a.F_Num);
            data.list = data.list.OrderBy(a => a.F_LocationCode).ToList();
            return data;
        }

        #region 提交数据
        public async Task SubmitForm(InStorageEntity entity, string keyValue)
        {
			if (entity.list != null && entity.list.Count > 0 && entity.F_Num!= entity.list.Sum(a=>a.F_Num))
			{
                throw new Exception("批号数量与入库单数量不符");
			}
            if (string.IsNullOrEmpty(keyValue))
            {
                entity.Create();
                var material = await uniwork.FindEntity<MaterialEntity>(entity.F_MaterialId);
                entity.F_MaterialCode = material.F_MaterialCode;
                entity.F_MaterialName = material.F_MaterialName;
                entity.F_MaterialType = material.F_MaterialType;
                entity.F_MaterialUnit = material.F_MaterialUnit;
                entity.F_DoneNum = 0;
                entity.F_BadNum = 0;
                entity.F_InStorageState = 0;
                entity.F_IsUserEdit = true;
                if (entity.list!=null&&entity.list.Count>0)
                {
                    foreach (var item in entity.list)
                    {
                        item.F_MaterialName = entity.F_MaterialName;
                    }
                    entity.F_BatchJson = entity.list.ToJson();
                }
                if (entity.F_PlanTime == null)
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
                if (old.F_InStorageState>0 && old.F_DoneNum>0)
                {
                    throw new Exception("入库单已开始作业无法修改");
                }
                var material = await uniwork.FindEntity<MaterialEntity>(entity.F_MaterialId);
                entity.F_MaterialCode = material.F_MaterialCode;
                entity.F_MaterialName = material.F_MaterialName;
                entity.F_MaterialType = material.F_MaterialType;
                entity.F_MaterialUnit = material.F_MaterialUnit;
                if (entity.list != null && entity.list.Count > 0)
                {
                    foreach (var item in entity.list)
                    {
                        item.F_MaterialName = entity.F_MaterialName;
                    }
                    entity.F_BatchJson = entity.list.ToJson();
                }
                await repository.Update(a=>a.F_Id==entity.F_Id,a=>new InStorageEntity { 
                    F_MaterialId=entity.F_MaterialId,
                    F_BatchJson=entity.F_BatchJson,
                    F_Description=entity.F_Description,
                    F_EnabledMark=entity.F_EnabledMark,
                    F_InStorageCode=entity.F_InStorageCode,
                    F_MaterialCode=entity.F_MaterialCode,
                    F_MaterialName=entity.F_MaterialName,
                    F_MaterialType=entity.F_MaterialType,
                    F_Num=entity.F_Num, 
                    F_IsUserEdit=true
                });
            }
        }

        public async Task DisabledForm(string keyValue)
        {
            var inNote = await repository.FindEntity(keyValue);
            uniwork.BeginTrans();
            if (inNote!=null && inNote.F_InStorageState == 1)
            {
                await repository.Update(a => a.F_Id == keyValue && a.F_InStorageState == 1, a => new InStorageEntity
                {
                    F_InStorageState = 3
                });
            }
            else
            {
                throw new Exception("入库单无需终止");
            }
            var job = await uniwork.FindEntity<ControlJobEntity>(a => a.F_NeedId == inNote.F_Id && a.F_JobType == 1 && a.F_JobState < 2);
            if (job != null)
            {
                await jobApp.CloseJob(job.F_Id);
            }
            uniwork.Commit();
        }

        public async Task EnabledForm(string keyValue)
        {
            var inNote = await repository.FindEntity(keyValue);
            uniwork.BeginTrans();
            if (inNote == null || inNote.F_InStorageState > 0)
            {
                throw new Exception("入库单已开始作业无需启动");
            }
            if (inNote.F_PlanTime != null&&((DateTime)inNote.F_PlanTime).Date != DateTime.Now.Date)
            {
                throw new Exception("入库单计划时间不是今天的，请检查");
            }
            if (!string.IsNullOrEmpty(inNote.F_BatchJson))
            {
                await repository.Update(a => a.F_Id == keyValue && a.F_InStorageState == 0 && a.F_DoneNum == 0, a => new InStorageEntity
                {
                    F_InStorageState = 2,
                    F_DoneNum = a.F_Num
                });
                var list = inNote.F_BatchJson.ToObject<List<InStorageInfoEntity>>();
                List<TransferBoxEntity> transfers = new List<TransferBoxEntity>();
                List<InStorageInfoEntity> temps = new List<InStorageInfoEntity>();
                //批量增加临时容器
                //批量绑定
                DateTime dt = DateTime.Now;
                foreach (var item in list)
                {
                    TransferBoxEntity transfer = new TransferBoxEntity();
                    InStorageInfoEntity temp = new InStorageInfoEntity();
                    transfer.Create();
                    transfer.F_CreatorTime = dt;
                    transfer.F_TransferCode = item.F_MaterialBatch;
                    transfer.F_EnabledMark = true;
                    transfer.F_IsTemp = true;
                    transfer.F_TransferState = 1;
                    transfer.F_TransferMaxNum = 125;
                    transfer.F_TransferType = "0";
                    transfer.F_DeleteMark = false;
                    transfers.Add(transfer);
                    temp.F_Id = 0;
                    //获取物料信息
                    var material = await uniwork.FindEntity<MaterialEntity>(a => a.F_Id == inNote.F_MaterialId);
                    if (material == null)
                    {
                        throw new Exception($"物料编号:{material.F_MaterialCode}不存在");
                    }
                    temp.F_IsTemp = true;
                    temp.F_MaterialId = material.F_Id;
                    temp.F_MaterialCode = material.F_MaterialCode;
                    temp.F_MaterialName = material.F_MaterialName;
                    temp.F_MaterialType = material.F_MaterialType;
                    temp.F_MaterialUnit = material.F_MaterialUnit;
                    temp.F_EnabledMark = true;
                    temp.F_MaterialBatch = item.F_MaterialBatch;
                    temp.F_InStorageId = inNote.F_Id;
                    temp.F_InStorageCode = inNote.F_InStorageCode;
                    temp.F_Num = item.F_Num;
                    temp.F_TransferBoxCode = transfer.F_TransferCode;
                    temp.F_CreatorUserId = currentuser.UserId;
                    temp.F_BandingUserId = temp.F_CreatorUserId;
                    temp.F_BandingUserName = currentuser.UserName;
                    temp.F_BandingTime = dt;
                    temps.Add(temp);
                }
                await uniwork.Insert(transfers);
                await uniwork.Insert(temps);
            }
            else
            {
                await repository.Update(a => a.F_Id == keyValue && a.F_InStorageState == 0 && a.F_DoneNum == 0, a => new InStorageEntity
                {
                    F_InStorageState = 1
                });
            }
            //创建任务
            ControlJobEntity jobEntity = new ControlJobEntity();
            jobEntity.F_JobType = 1;
            jobEntity.F_NeedId = keyValue;
            jobEntity.F_NeedNum = inNote.F_Num;
            jobEntity.F_Priority = 1;
            jobEntity.F_JobCode = "CJ_" + DateTime.Now.ToString("yyyyMMddHHmmss") + 0; ;
            jobEntity.F_JobInfo = "来料入库,入库号为" + inNote.F_InStorageCode + ",物料编号为" + inNote.F_MaterialCode + ",名称为" + inNote.F_MaterialName + "的物料需要入库。";
            jobEntity.F_JobInfo += "数量为" + inNote.F_Num;
            await jobApp.SubmitForm(jobEntity);
            uniwork.Commit();
        }

        public async Task DeleteForm(string keyValue)
        {
            var ids = keyValue.Split(',');
            if (repository.IQueryable(a => ids.Contains(a.F_Id) && a.F_DoneNum > 0).Count() > 0)
            {
                throw new Exception("入库单已开始作业无法删除");
            }
            if (uniwork.IQueryable<ControlJobEntity>(a => ids.Contains(a.F_NeedId) && a.F_JobType == 1 && a.F_JobState > 0).Count() > 0)
            {
                throw new Exception("入库单已开始作业无法删除");
            }
            uniwork.BeginTrans();
            await repository.Delete(t => ids.Contains(t.F_Id.ToString()));
            await uniwork.Delete<ControlJobEntity>(t => ids.Contains(t.F_NeedId) && t.F_JobType == 1);
            uniwork.Commit();
        }
        public async Task InStorage(InStorageInfoEntity entity)
        {
            //获取入库单
            InStorageEntity inNote = await uniwork.FindEntity<InStorageEntity>(a => a.F_InStorageCode == entity.F_InStorageCode && a.F_InStorageState == 1);
            if (inNote == null)
            {
                throw new Exception($"入库单:{entity.F_InStorageCode}不存在");
            }
            else
            {
                entity.F_InStorageId = inNote.F_Id;
            }
            //获取物料信息
            var material = await uniwork.FindEntity<MaterialEntity>(a => a.F_Id == inNote.F_MaterialId);
            if (material == null)
            {
                throw new Exception($"物料编号:{entity.F_MaterialCode}不存在");
            }
            entity.F_MaterialId = material.F_Id;
            entity.F_MaterialCode = material.F_MaterialCode;
            entity.F_MaterialName = material.F_MaterialName;
            entity.F_MaterialType = material.F_MaterialType;
            entity.F_MaterialUnit = material.F_MaterialUnit;
            entity.F_EnabledMark = true;
            entity.F_IsTemp = true;
            //流转箱判断
            if (!string.IsNullOrEmpty(entity.F_TransferBoxCode))
            {
                var transfer = uniwork.IQueryable<TransferBoxEntity>(a => a.F_TransferCode == entity.F_TransferBoxCode && a.F_EnabledMark == true && a.F_DeleteMark == false).FirstOrDefault();
                if (transfer != null)
                {
                    if (transfer.F_TransferType != "0" && uniwork.IQueryable<TransferTypeMaterialBandingEntity>(a => a.F_TransferType == transfer.F_TransferType && a.F_MaterialId == entity.F_MaterialId).Count() == 0)
                    {
                        throw new Exception($"流转箱{entity.F_TransferBoxCode}不可用");
                    }
                    if (transfer.F_TransferState == 0)
                    {
                        if (transfer.F_TransferMaxNum < entity.F_Num)
                        {
                            throw new Exception($"流转箱{entity.F_TransferBoxCode}不可用");
                        }
                    }
                    else if (transfer.F_TransferState == 1)
                    {
                        var temps = uniwork.IQueryable<InStorageInfoEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_MaterialId == entity.F_MaterialId && a.F_IsTemp==true).ToList() ;
                        if (temps.Count == 0)
                        {
                            throw new Exception($"流转箱{entity.F_TransferBoxCode}不可用");
                        }
                        if (transfer.F_TransferMaxNum < entity.F_Num + temps.Sum(a=>a.F_Num))
                        {
                            throw new Exception($"流转箱{entity.F_TransferBoxCode}可存放数量超出");
                        }
                    }
                    else
                    {
                        throw new Exception($"流转箱{entity.F_TransferBoxCode}不可用");
                    }
                }
                else
                {
                    throw new Exception($"流转箱{entity.F_TransferBoxCode}不可用");
                }

            }
            //获取入库单
            if (string.IsNullOrEmpty(entity.F_InStorageCode))
            {
                throw new Exception($"入库单:{entity.F_InStorageCode}不存在");
            }
            uniwork.BeginTrans();
            //扣除入库单作业数量,添加入库绑定记录
            float num = entity.F_Num ?? 0;
            int resultId = 0;
            entity.F_CreatorUserId = currentuser.UserId;
            entity.F_BandingUserId = entity.F_CreatorUserId;
            entity.F_BandingUserName = currentuser.UserName;
            entity.F_BandingTime = DateTime.Now;
            resultId = await uniwork.Update<InStorageEntity>(a => a.F_Id == inNote.F_Id && a.F_InStorageState == 1 && a.F_Num >= a.F_DoneNum + num, a => new InStorageEntity
            {
                F_DoneNum = a.F_DoneNum + num,
            });
            if (resultId <= 0)
            {
                throw new Exception("数量异常，请重新提交");
            }
            await uniwork.Update<InStorageEntity>(a => a.F_Id == inNote.F_Id && a.F_InStorageState == 1 && a.F_Num == a.F_DoneNum, a => new InStorageEntity
            {
                F_InStorageState = 2
            });
            entity= await uniwork.Insert(entity);
            //更新流转箱状态
            resultId = await uniwork.Update<TransferBoxEntity>(a => a.F_TransferCode == entity.F_TransferBoxCode && a.F_TransferState <= 1, a => new TransferBoxEntity
            {
                F_TransferState = 1,
            });
            if (resultId <= 0)
            {
                throw new Exception("流转箱异常，请重新提交");
            }
			if (material.F_NeedCheckout==true)
			{
                var check = uniwork.IQueryable<NeedCheckEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_CheckType==0 && a.F_IsCheck==false).FirstOrDefault();
				if (check!=null)
				{
                    await uniwork.Update<NeedCheckEntity>(a => a.F_Id == check.F_Id, a => new NeedCheckEntity { 
                        F_Num=a.F_Num+entity.F_Num,
                        F_IsCheck=false
                    });
                    await uniwork.Update<ControlJobEntity>(a => a.F_NeedId == entity.F_TransferBoxCode && a.F_JobType == 8 && a.F_JobState < 2, a => new ControlJobEntity
                    {
                        F_NeedNum = a.F_NeedNum + entity.F_Num,
                    });
                }
				else
				{
                    //创建检验单，创建调度任务
                    check = new NeedCheckEntity();
                    check.F_Id = 0;
                    check.F_SourceId = entity.F_Id.ToString();
                    check.F_CreatorTime = DateTime.Now;
                    check.F_CheckType = 0;
                    check.F_IsCheck = false;
                    check.F_IsNeedTwoCheck = false;
                    check.F_IsTwoCheck = false;
                    check.F_MaterialBatch = entity.F_MaterialBatch;
                    check.F_MaterialCode = entity.F_MaterialCode;
                    check.F_MaterialId = entity.F_MaterialId;
                    check.F_MaterialName = entity.F_MaterialName;
                    check.F_MaterialType = entity.F_MaterialType;
                    check.F_MaterialUnit = entity.F_MaterialUnit;
                    check.F_Num = entity.F_Num;
                    check.F_TransferBoxCode = entity.F_TransferBoxCode;
                    ControlJobEntity jobEntity = new ControlJobEntity();
                    jobEntity.F_JobType = 8;
                    jobEntity.F_NeedId = check.F_TransferBoxCode;
                    jobEntity.F_Priority = 1;
                    jobEntity.F_NeedNum = num;
                    jobEntity.F_JobCode = "CJ_" + DateTime.Now.ToString("yyyyMMddHHmmss") + 0;
                    jobEntity.F_JobInfo = "常规检验-入库检验," + "流转箱编号为" + check.F_TransferBoxCode + ",物料编号为" + material.F_MaterialCode + ",名称为" + material.F_MaterialName + "的物料进行检验。";
                    jobEntity.F_JobInfo += "数量为" + num;
                    await jobApp.SubmitForm(jobEntity);
                    await uniwork.Insert(check);
                }
            }
			else
			{
                var job = uniwork.IQueryable<ControlJobEntity>(a => a.F_NeedId == entity.F_TransferBoxCode &&  a.F_JobType == 10 && a.F_JobState < 2).FirstOrDefault();
                if (job != null)
                {
                    await uniwork.Update<ControlJobEntity>(a => a.F_NeedId == entity.F_TransferBoxCode && a.F_JobType == 10 && a.F_JobState < 2, a => new ControlJobEntity
                    {
                        F_NeedNum = a.F_NeedNum + entity.F_Num,
                    });
                }
                else
                {
                    ControlJobEntity jobEntity = new ControlJobEntity();
                    jobEntity.F_JobType = 10;
                    jobEntity.F_NeedId = entity.F_TransferBoxCode;
                    jobEntity.F_Priority = 1;
                    jobEntity.F_NeedNum = entity.F_Num;
                    jobEntity.F_JobCode = "CJ_" + DateTime.Now.ToString("yyyyMMddHHmmss") + 0;
                    jobEntity.F_JobInfo = "入库上架," + "流转箱编号为" + entity.F_TransferBoxCode + ",物料编号为" + material.F_MaterialCode + ",名称为" + material.F_MaterialName + "的物料进行上架。";
                    jobEntity.F_JobInfo += "数量为" + entity.F_Num;
                    await jobApp.SubmitForm(jobEntity);
                }
            }
            uniwork.Commit();
            await _logApp.WriteLog(2, "入库:物料" + material.F_MaterialName + "入库数量" + (entity.F_Num ?? 0), "", "", material.F_MaterialName, entity.F_TransferBoxCode, entity.F_Num);
        }
        public async Task InStorageCancleBanding(string code)
        {
            var temps = uniwork.IQueryable<InStorageInfoEntity>(a => a.F_TransferBoxCode == code && a.F_IsTemp == true).ToList();
            int resultId = 0;
            //获取物料信息
            var material = await uniwork.FindEntity<MaterialEntity>(a => a.F_Id == temps[0].F_MaterialId);
            uniwork.BeginTrans();
            //回退入库单作业数量
            foreach (var item in temps)
            {
                resultId = await uniwork.Update<InStorageEntity>(a => a.F_Id == item.F_InStorageId && a.F_InStorageState >= 1 && a.F_DoneNum - item.F_Num >= 0, a => new InStorageEntity
                {
                    F_DoneNum = a.F_DoneNum - item.F_Num,
                });
                if (resultId <= 0)
                {
                    throw new Exception("数量异常，请重新提交");
                }
                await uniwork.Update<InStorageEntity>(a => a.F_Id == item.F_InStorageId && a.F_DoneNum !=a.F_Num, a => new InStorageEntity
                {
                    F_InStorageState = 1
                });
            }

            await uniwork.Delete<InStorageInfoEntity>(a => a.F_TransferBoxCode == code && a.F_IsTemp == true);
            //更新流转箱状态
            resultId = await uniwork.Update<TransferBoxEntity>(a => a.F_TransferCode == code && a.F_TransferState == 1, a => new TransferBoxEntity
            {
                F_TransferState = 0,
            });
            if (resultId != temps.Count())
            {
                throw new Exception("流转箱异常，请重新提交");
            }
            //删除检验单
            var checks = await uniwork.FindEntity<NeedCheckEntity>(a => a.F_TransferBoxCode == code && a.F_MaterialBatch == temps[0].F_MaterialBatch);
            if (checks != null)
            {
                var count = uniwork.IQueryable<ScapMaterialEntity>(a => a.F_CheckId == checks.F_Id && a.F_IsCheck == true).Sum(a=>a.F_ScapNum);
                if (count > 0)
                {
                    await uniwork.Update<InStorageEntity>(a => a.F_Id == temps[0].F_InStorageId && a.F_BadNum >= count, a => new InStorageEntity
                    {
                        F_BadNum = a.F_BadNum - count
                    });
                }
                await uniwork.Delete<ScapMaterialEntity>(a => a.F_CheckId == checks.F_Id);
                await uniwork.Delete<NeedCheckEntity>(a => a.F_Id == checks.F_Id);
            }
            //关闭调度任务
            var job = await uniwork.FindEntity<ControlJobEntity>(a => a.F_NeedId == code && (a.F_JobType == 10 || a.F_JobType == 8) && a.F_JobState < 2);
            if (job != null)
            {
                await jobApp.CloseJob(job.F_Id);
            }
            uniwork.Commit();
        }
        public async Task InStorageLocation(InStorageInfoEntity entity)
        {
            //获取库位信息
            var location = uniwork.IQueryable<LocationEntity>(a => a.F_LocationCode == entity.F_LocationCode).FirstOrDefault();
            //获取入库绑定记录
            var banding = uniwork.IQueryable<InStorageInfoEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_IsTemp == true).ToList();
            if (banding == null|| banding.Count == 0)
            {
                throw new Exception("绑定记录不存在");
            }
            if (uniwork.IQueryable<NeedCheckEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_IsCheck == false).Count() > 0)
            {
                throw new Exception("物料正在检验，无法使用");
            }
            var inNote =await uniwork.FindEntity<InStorageEntity>(banding[0].F_InStorageId);
            var material=await uniwork.FindEntity<MaterialEntity>(banding[0].F_MaterialId);
            //判断流转箱类型和物料、数量是否对应
            if (!locationApp.IsUseLocation(entity.F_LocationCode, material.F_MaterialCode))
            {
                throw new Exception($"库位:{entity.F_LocationCode}不可用");
            }
            entity.F_Num = 0;

            foreach (var item in banding)
			{
                entity.F_Num += item.F_Num;
                entity.F_Num -= uniwork.IQueryable<NeedCheckEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_CheckType == 0 && a.F_SourceId == item.F_Id.ToString()).InnerJoin<ScapMaterialEntity>((a, b) => a.F_Id == b.F_CheckId).Select((a, b) => b).Sum(a=>a.F_Num)??0;
            }
            //添加库存信息
            StorageEntity storage = new StorageEntity();
            storage.Create();
            storage.F_EnabledMark = true;
            storage.F_IsCheckout = true;
            storage.F_MaterialBatch = "YCL-" + DateTime.Now.ToString("yyyyMMddHHmmss").Substring(2);
            storage.F_MaterialCode = banding[0].F_MaterialCode;
            storage.F_MaterialName = banding[0].F_MaterialName;
            storage.F_MaterialType = banding[0].F_MaterialType;
            storage.F_MaterialUnit = banding[0].F_MaterialUnit;
            storage.F_MaterialId = banding[0].F_MaterialId;
            storage.F_CreatorTime = banding[0].F_BandingTime;
            storage.F_Num = entity.F_Num;
            storage.F_TransferBoxCode = banding[0].F_TransferBoxCode;
            storage.F_LocationCode = entity.F_LocationCode;
            uniwork.BeginTrans();
            var ids = banding.Select(a => a.F_Id).ToList();
            //更新入库记录表
            int resultId = await uniwork.Update<InStorageInfoEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_IsTemp==true,a=>new InStorageInfoEntity { 
                F_IsTemp=false,
                F_LocationCode=entity.F_LocationCode,
                F_CreatorTime=storage.F_CreatorTime,
                F_CreatorUserName = currentuser.UserName,
                F_CreatorUserId =storage.F_CreatorUserId,
                F_OriginalBatch = a.F_MaterialBatch,
                F_MaterialBatch=storage.F_MaterialBatch,
            });
            if (resultId <= 0)
            {
                throw new Exception("入库绑定异常，请重新提交");
            }
            //上架全部完成更新完成任务
            if (uniwork.IQueryable <InStorageInfoEntity>(a=>a.F_InStorageId== inNote.F_Id && a.F_IsTemp == false).Sum(a=>a.F_Num) == inNote.F_Num)
            {
                await uniwork.Update<InStorageEntity>(a => a.F_Id == inNote.F_Id, a => new InStorageEntity
                {
                    F_InStorageState = 4,
                });
                var notejob = await uniwork.FindEntity<ControlJobEntity>(a => a.F_NeedId == inNote.F_Id && a.F_JobType == 1 && a.F_JobState < 2);
                if (notejob != null)
                {
                    await jobApp.FinishJob(notejob.F_Id);
                }
            }
            await uniwork.Insert(storage);
            //更新库位状态
            resultId = await uniwork.Update<LocationEntity>(a => a.F_LocationCode == entity.F_LocationCode && a.F_LocationState == false, a => new LocationEntity
            {
                F_LocationState = true,
            });
            if (resultId <= 0)
            {
                throw new Exception("库位异常，请重新提交");
            }
            resultId = await uniwork.Update<TransferBoxEntity>(a => a.F_TransferCode == entity.F_TransferBoxCode && a.F_TransferState == 1, a => new TransferBoxEntity
            {
                F_TransferState = 2,
                F_LocationCode = entity.F_LocationCode,
            });
            if (resultId <= 0)
            {
                throw new Exception("流转箱异常，请重新提交");
            }
            //完成调度任务
            var job = await uniwork.FindEntity<ControlJobEntity>(a => a.F_NeedId == entity.F_TransferBoxCode && a.F_JobType == 10 && a.F_JobState < 2);
			if (job!=null)
			{
                await jobApp.FinishJob(job.F_Id);
            }	
            uniwork.Commit();
        }
        #endregion

    }
}
