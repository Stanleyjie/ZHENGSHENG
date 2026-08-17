using System;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;
using WaterCloud.Code;
using Chloe;
using WaterCloud.Domain.MaterialManage;
using WaterCloud.DataBase;
using WaterCloud.Domain.EquipmentManage;
using WaterCloud.Domain.ProcessManage;
using WaterCloud.Domain.ClassTask;
using WaterCloud.Service.ClassTask;
using System.Net.Http;
using WaterCloud.Domain.QualityManage;
using WaterCloud.Domain.SystemOrganize;
using WaterCloud.Service.SystemManage;
using WaterCloud.Service.SystemSecurity;
using static Serenity.Web.PropertyItemsScript;

namespace WaterCloud.Service.MaterialManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2020-12-01 14:31
    /// 描 述：物料管理服务类
    /// </summary>
    public class WorkRunService : IDenpendency
    {
        // 用户信息
        public OperatorModel currentuser;
        // 用于其他表操作
        protected IRepositoryBase uniwork;
        private TransferBoxService transferApp;
        private LocationService locationApp;
        private StorageService _storageApp;
        private ControlJobService _jobApp;
        private ItemsDataService itemsApp;
        private BusinessLogService _logApp;

		public WorkRunService(IDbContext context, IHttpClientFactory httpClientFactory)
        {
            currentuser = OperatorProvider.Provider.GetCurrent();
            uniwork = new RepositoryBase(context);
            transferApp = new TransferBoxService(context);
            locationApp = new LocationService(context);
			itemsApp = new ItemsDataService(context);
			_storageApp = new StorageService(context, httpClientFactory);
            _jobApp = new ControlJobService(context, httpClientFactory);
            _logApp = new BusinessLogService(context);
            if (currentuser == null)
            {
                currentuser = new OperatorModel();
            }
        }

        #region 获取数据
        public async Task<LocationEntity> GetLocationReturn(string transferCode)
        {
            return await locationApp.GetLocationReturn(transferCode);
        }
        public async Task<List<OutPutInfoEntity>> GetOutputMaterialBandingList(string keyword)
        {
            var query = uniwork.IQueryable<OutPutInfoEntity>(a=>a.F_IsTemp == true);
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(a => a.F_TransferBoxCode.Contains(keyword) || a.F_MaterialCode.Contains(keyword)
                 || a.F_MaterialName.Contains(keyword) || a.F_MaterialBatch.Contains(keyword) || a.F_EqpName.Contains(keyword));
            }
            var data = query.OrderBy(a => a.F_CreatorTime).ToList();
            foreach (var item in data)
            {
                item.F_Num -= uniwork.IQueryable<NeedCheckEntity>(a => a.F_TransferBoxCode == item.F_TransferBoxCode && a.F_CheckType == 2 && a.F_SourceId == item.F_Id.ToString()).InnerJoin<ScapMaterialEntity>((a, b) => a.F_Id == b.F_CheckId).Select((a, b) => b).Sum(a => a.F_Num) ?? 0;
            }
            return data;
        }
        public async Task<List<EqpMaterialUseEntity>> GetConsumeMaterialList(string keyword)
        {
            var query = uniwork.IQueryable<EqpMaterialUseEntity>(a => a.F_DoneNum != a.F_Num);
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(a => a.F_TransferBoxCode.Contains(keyword) || a.F_MaterialCode.Contains(keyword)
                 || a.F_MaterialName.Contains(keyword) || a.F_MaterialBatch.Contains(keyword) || a.F_EqpName.Contains(keyword));
            }
            return query.OrderBy(a => a.F_CreatorTime).ToList();
        }

        public async Task<EqpMaterialUseEntity> GetConsumeMaterialByCode(string eqpName, string code)
        {
            var data = uniwork.IQueryable<EqpMaterialUseEntity>(a => a.F_DoneNum != a.F_Num && a.F_EqpName == eqpName && a.F_TransferBoxCode==code).FirstOrDefault();
            return data;
        }
		public async Task<string> GetBatch()
		{
			var classNums = await itemsApp.GetItemList("Mes_ClassNumber");
			var classStartTime = TimeSpan.Parse(classNums.FirstOrDefault().F_Description.Split("-")[0]);
			var tempStartTime = classStartTime.TotalMinutes;
			var tempEndTime = tempStartTime;
			var currentTime = DateTime.Now.TimeOfDay;
			var currentdate = DateTime.Now.Date;
            if (classNums.Count() == 1)
            {
				return $"{currentdate.ToString("yyyyMMdd")}-{classNums.FirstOrDefault().F_ItemCode}";
			}
			if (TimeSpan.Compare(currentTime, classStartTime) < 0)
			{
				currentdate = currentdate.AddDays(-1);
			}
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
                if (currentdate.AddMinutes(tempStartTime) <DateTime.Now && currentdate.AddMinutes(tempEndTime) >= DateTime.Now)
                {
                    return $"{currentdate.ToString("yyyyMMdd")}-{classNums[i].F_ItemCode}";
                }
                tempStartTime = tempEndTime;

			}
            return "";
        }
		public async Task<object> GetBoardDataJson()
        {
            SortedDictionary<int, float> planDic = new SortedDictionary<int, float>();
            SortedDictionary<int, float> realDic = new SortedDictionary<int, float>();
            SortedDictionary<int, double> passRateDic = new SortedDictionary<int, double>();
            SortedDictionary<string, float> outProductDic = new SortedDictionary<string, float>();
            DateTime startTime = new DateTime(DateTime.Now.Year, 1, 1); ;
            var works = uniwork.IQueryable<WorkOrderDetailEntity>().Where(a => a.F_RealEndTime >= startTime && a.F_WorkOrderState > 1).ToList();
            var hotList = uniwork.IQueryable<EquipmentEntity>().Where(a => a.F_ParentId == "0" && a.F_EqpUse == 10 && a.F_EnabledMark == true && a.F_DeleteMark == false).Select(a => a.F_Id).ToList();
            var weldList = uniwork.IQueryable<EquipmentEntity>().Where(a => a.F_ParentId == "0" && a.F_EqpUse == 15 && a.F_EnabledMark == true && a.F_DeleteMark == false).Select(a => a.F_Id).ToList();
            var laserList = uniwork.IQueryable<EquipmentEntity>().Where(a => a.F_ParentId == "0" && a.F_EqpUse == 6 && a.F_EnabledMark == true && a.F_DeleteMark == false).Select(a => a.F_Id).ToList();
            for (int i = 1; i <= DateTime.Now.Month; i++)
            {
                float plannum = works.Where(a => a.F_RealEndTime >= startTime.AddMonths(i - 1) && a.F_RealEndTime < startTime.AddMonths(i)).Sum(a => a.F_PlanNum) ?? 0;
                float realnum = works.Where(a => a.F_RealEndTime >= startTime.AddMonths(i - 1) && a.F_RealEndTime < startTime.AddMonths(i)).Sum(a => a.F_DoneNum) ?? 0;
                float badnum = works.Where(a => a.F_RealEndTime >= startTime.AddMonths(i - 1) && a.F_RealEndTime < startTime.AddMonths(i)).Sum(a => a.F_BadNum) ?? 0;
                planDic.Add(i, plannum);
                realDic.Add(i, realnum);
                if (realnum == 0)
                {
                    passRateDic.Add(i, 0);
                }
                else
                {
                    passRateDic.Add(i, Math.Round((realnum - badnum) / realnum, 4) * 100);
                }
            }
            foreach (var item in works.GroupBy(a => a.F_MaterialId).Select(a => new { a.Key, num = a.Sum(a => a.F_DoneNum) }))
            {
                var material = await uniwork.FindEntity<MaterialEntity>(item.Key);
                outProductDic.Add(material.F_MaterialName, item.num ?? 0);
            }
            if (outProductDic.Count == 0)
            {
                outProductDic.Add("无数据", 0);
            }
            var hotworks = uniwork.IQueryable<WorkOrderDetailEntity>().Where(a => a.F_RealEndTime >= startTime && a.F_WorkOrderState > 1)
                .InnerJoin<WorkOrderDetailEqpBandingEntity>((a, b) => a.F_Id == b.F_WorkOrderDetailId && b.F_IsMaster == true && hotList.Contains(b.F_EqpId))
                .Select((a, b) => a);
            float hotPlanNum = hotworks.Sum(a => a.F_PlanNum) ?? 0;
            float hotRealNum = hotworks.Sum(a => a.F_DoneNum) ?? 0;
            float hotbadNum = hotworks.Sum(a => a.F_BadNum) ?? 0;
            var hotPassRate = (hotRealNum == 0 ? 0 : Math.Round((hotRealNum - hotbadNum) / hotRealNum, 4) * 100).ToString("f2");
            var hotFinishRate = (hotPlanNum == 0 ? 0 : Math.Round(hotRealNum / hotPlanNum, 4) * 100).ToString("f2");

            var weldworks = uniwork.IQueryable<WorkOrderDetailEntity>().Where(a => a.F_RealEndTime >= startTime && a.F_WorkOrderState > 1)
                .InnerJoin<WorkOrderDetailEqpBandingEntity>((a, b) => a.F_Id == b.F_WorkOrderDetailId && b.F_IsMaster == true && weldList.Contains(b.F_EqpId))
                .Select((a, b) => a);
            float weldPlanNum = weldworks.Sum(a => a.F_PlanNum) ?? 0;
            float weldRealNum = weldworks.Sum(a => a.F_DoneNum) ?? 0;
            float weldbadNum = weldworks.Sum(a => a.F_BadNum) ?? 0;
            var weldPassRate = (weldRealNum == 0 ? 0 : Math.Round((weldRealNum - weldbadNum) / weldRealNum, 4) * 100).ToString("f2");
            var weldFinishRate = (weldPlanNum == 0 ? 0 : Math.Round(weldRealNum / weldPlanNum, 4) * 100).ToString("f2");
            var laserworks = uniwork.IQueryable<WorkOrderDetailEntity>().Where(a => a.F_RealEndTime >= startTime && a.F_WorkOrderState > 1)
                .InnerJoin<WorkOrderDetailEqpBandingEntity>((a, b) => a.F_Id == b.F_WorkOrderDetailId && b.F_IsMaster == true && laserList.Contains(b.F_EqpId))
                .Select((a, b) => a);
            float laserPlanNum = laserworks.Sum(a => a.F_PlanNum) ?? 0;
            float laserRealNum = laserworks.Sum(a => a.F_DoneNum) ?? 0;
            float laserbadNum = laserworks.Sum(a => a.F_BadNum) ?? 0;
            var laserPassRate = (laserRealNum == 0 ? 0 : Math.Round((laserRealNum - laserbadNum) / laserRealNum, 4)*100).ToString("f2");
            var laserFinishRate = (laserPlanNum == 0 ? 0 : Math.Round(laserRealNum / laserPlanNum, 4) * 100).ToString("f2");
            var data = new
            {
                plans = planDic,
                reals = realDic,
                passRates = passRateDic,
                outProducts = outProductDic,
                hot = new { hotPlanNum, hotRealNum, hotbadNum, hotPassRate, hotFinishRate },
                weld = new { weldPlanNum, weldRealNum, weldbadNum, weldPassRate, weldFinishRate },
                laser = new { laserPlanNum, laserRealNum, laserbadNum, laserPassRate, laserFinishRate },
            };
            return data;
        }
        #endregion

        #region 提交数据
        public async Task ConsumeMaterial(EqpMaterialUseEntity entity, string newTransferCode)
        {
            //判断物料是否设备需要
            var storage = uniwork.IQueryable<StorageEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode).FirstOrDefault();
            if (storage == null)
            {
                throw new Exception("库存不存在，请检查");
            }
            if (storage.F_IsCheckout != true)
            {
                throw new Exception($"流转箱{entity.F_TransferBoxCode}库存没有经过检验");
            }
            if (uniwork.IQueryable<NeedCheckEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_IsCheck == false).Count() > 0)
            {
                throw new Exception("物料正在检验，无法使用");
            }
            if (entity.F_Num > storage.F_Num)
            {
                throw new Exception("库存不足，请修改数量");
            }
            entity.F_MaterialId = storage.F_MaterialId;
            uniwork.BeginTrans();
            var eqp = await uniwork.FindEntity<EquipmentEntity>(a => a.F_EqpName == entity.F_EqpName);
            entity.F_EqpId = eqp.F_Id;
            //根据设备获取工单,需要的物料
            var work = uniwork.IQueryable<WorkOrderDetailEqpBandingEntity>(a => a.F_EqpId == entity.F_EqpId)
                .InnerJoin<WorkOrderDetailEntity>((a, b) => a.F_WorkOrderDetailId == b.F_Id && b.F_WorkOrderState == 1)
                .InnerJoin<BomFormEntity>((a, b, c) => b.F_MaterialId == c.F_MaterialId && c.F_BomType == 1 && c.F_SonMaterialId == storage.F_MaterialId)
                .InnerJoin<ProcessFlowEntity>((a, b, c, d) => c.F_ProcessId == d.F_Id)
                .InnerJoin<WorkOrderEntity>((a, b, c, d, e) => b.F_WorkOrderId == e.F_Id)
                .Select((a, b, c, d, e) => new WorkOrderDetailEntity
                {
                    F_BadNum = b.F_BadNum,
                    F_CreatorTime = b.F_CreatorTime,
                    F_CreatorUserId = b.F_CreatorUserId,
                    F_DeleteMark = b.F_DeleteMark,
                    F_Description = b.F_Description,
                    F_DoneNum = b.F_DoneNum,
                    F_EnabledMark = b.F_EnabledMark,
                    F_Id = b.F_Id,
                    F_MaterialId = b.F_MaterialId,
                    F_PlanEndTime = b.F_PlanEndTime,
                    F_PlanNum = b.F_PlanNum,
                    F_PlanStartTime = b.F_PlanStartTime,
                    F_RunSort = b.F_RunSort,
                    F_SonMaterialId = c.F_SonMaterialId,
                    F_SonNum = b.F_PlanNum * c.F_Num,
                    F_WorkOrderId = b.F_WorkOrderId,
                    F_WorkOrderState = b.F_WorkOrderState,
                    F_ProcessId = c.F_ProcessId,
                    F_ProcessName = d.F_ProcessFlowName,
                    F_WorkOrderCode = e.F_WorkOrderCode
                })
                .InnerJoin<WorkOrderDetailProcessBandingEntity>((a, b) => a.F_Id == b.F_WorkOrderDetailId&&b.F_ProcessId==a.F_ProcessId)
                .Select((a,b)=>a)
                .FirstOrDefault();
            if (work == null)
            {
                throw new Exception("该设备不需要此物料");
            }
            var first = uniwork.IQueryable<StorageEntity>(a => a.F_MaterialId == storage.F_MaterialId && a.F_IsCheckout == true).OrderBy(a => a.F_MaterialBatch.Substring(4)).FirstOrDefault();
            var firstTime = ((DateTime)first.F_CreatorTime).Date;
            var realStorages= uniwork.IQueryable<StorageEntity>(a => a.F_MaterialId == storage.F_MaterialId && a.F_IsCheckout == true&&a.F_CreatorTime>=firstTime&&a.F_CreatorTime<firstTime.AddDays(1)).OrderBy(a => a.F_MaterialBatch.Substring(4)).Select(a => a.F_Id).ToList();
            //是否多工序作业
            if (work.F_RunSort != 1)
            {
                first = uniwork.IQueryable<OutPutInfoEntity>(a => a.F_WorkOrderId == work.F_WorkOrderId && a.F_MaterialId == storage.F_MaterialId && a.F_IsTemp != true)
                    .InnerJoin<StorageEntity>((a, b) => b.F_IsCheckout == true && a.F_MaterialId == b.F_MaterialId
                    && a.F_MaterialBatch == b.F_MaterialBatch).Select((a, b) => b).OrderBy(a => a.F_MaterialBatch.Substring(4)).FirstOrDefault();
                firstTime = ((DateTime)first.F_CreatorTime).Date;
                realStorages = uniwork.IQueryable<OutPutInfoEntity>(a => a.F_WorkOrderId == work.F_WorkOrderId && a.F_MaterialId == storage.F_MaterialId && a.F_IsTemp != true)
                    .InnerJoin<StorageEntity>((a, b) =>  b.F_IsCheckout == true && a.F_MaterialId == b.F_MaterialId
                    && a.F_MaterialBatch == b.F_MaterialBatch && b.F_CreatorTime >= firstTime && b.F_CreatorTime<firstTime).Select((a, b) => b).Select(a => a.F_Id).ToList();
            }
            //允许违反先出规则
            var area = uniwork.IQueryable<LocationEntity>(a => a.F_LocationCode == storage.F_LocationCode)
                .InnerJoin<AreaEntity>((a, b) => a.F_AreaId == b.F_Id).Select((a, b) => b).FirstOrDefault();
            if (!realStorages.Contains(storage.F_Id) && area.F_NeedRule == true)
            {
                throw new Exception("请遵循先进先出原则");
            }
            if (storage.F_Num != entity.F_Num)
            {
                if (string.IsNullOrEmpty(newTransferCode))
                {
                    throw new Exception("拆分领用，请输入目标流转箱");
                }
                //判断流转箱类型和物料、数量是否对应
                if (!transferApp.IsTransferType(newTransferCode, entity.F_MaterialId, entity.F_Num ?? 0))
                {
                    throw new Exception("流转箱不可用");
                }
                StorageChangeInfoEntity change = new StorageChangeInfoEntity();
                change.F_TransferBoxCode = entity.F_TransferBoxCode;
                change.F_Num = entity.F_Num;
                change.F_NewTransferBoxCode = newTransferCode;
                change.F_NewLocationCode = (await locationApp.GetLocationListByLocation(storage.F_LocationCode, storage.F_MaterialCode)).Where(a => a.F_LocationState == false).FirstOrDefault().F_LocationCode;
                change.F_Description = entity.F_Description;
                change.F_ChangeType = 0;
                await _storageApp.StorageChange(change, false, false);
                storage = uniwork.IQueryable<StorageEntity>(a => a.F_TransferBoxCode == newTransferCode && a.F_IsCheckout == true).FirstOrDefault();
                entity.F_TransferBoxCode = storage.F_TransferBoxCode;
                entity.F_LocationCode = storage.F_LocationCode;
            }
            if (storage == null)
            {
                throw new Exception("库存不存在，请检查");
            }
            float num = storage.F_Num ?? 0;
            //添加物料使用信息
            EqpMaterialUseEntity temp = new EqpMaterialUseEntity();
            temp.F_Id = 0;
            temp.F_CreatorTime = DateTime.Now;
            temp.F_CreatorUserId = currentuser.UserId;
            temp.F_Description = entity.F_Description;
            temp.F_Num = num;
            temp.F_DoneNum = 0;
            temp.F_EnabledMark = true;
            temp.F_EqpId = entity.F_EqpId;
            temp.F_CreatorUserName = currentuser.UserName;
            temp.F_EqpName = entity.F_EqpName;
            temp.F_TransferBoxCode = entity.F_TransferBoxCode;
            temp.F_MaterialId = storage.F_MaterialId;
            temp.F_MaterialBatch = storage.F_MaterialBatch;
            temp.F_MaterialCode = storage.F_MaterialCode;
            temp.F_MaterialName = storage.F_MaterialName;
            temp.F_MaterialUnit = storage.F_MaterialUnit;
            temp.F_MaterialType = storage.F_MaterialType;
            temp.F_WorkOrderId = work.F_WorkOrderId;
            temp.F_WorkOrderCode = work.F_WorkOrderCode;
            temp.F_WorkOrderRunSort = work.F_RunSort;
            temp.F_ProcessId = work.F_ProcessId;
            temp.F_ProcessName = work.F_ProcessName;
            temp.F_LocationCode = storage.F_LocationCode;
            await uniwork.Insert(temp);
            //扣除库存信息
            int result = await uniwork.Update<StorageEntity>(a => a.F_Id == storage.F_Id && a.F_Num >= storage.F_Num, a => new StorageEntity
            {
                F_Num = a.F_Num - storage.F_Num
            });
            if (result == 0)
            {
                throw new Exception("领用数量超出库存数量，请核对数量");
            }
            //删除0的库存
            await uniwork.Delete<StorageEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_Num == 0);
            //更新库位状态
            await uniwork.Update<LocationEntity>(a => a.F_LocationCode == storage.F_LocationCode && a.F_LocationState == true, a => new LocationEntity
            {
                F_LocationState = false
            });
            //完成任务
            var job = uniwork.IQueryable<ControlJobEntity>(a => a.F_NeedEqpId == entity.F_EqpId && a.F_NeedId == temp.F_MaterialId && a.F_JobType == 0 && a.F_JobState < 2).FirstOrDefault();
            if (job == null)
            {
                throw new Exception("没有任务调度，请检查");
            }
            else
            {
                var usesnum = uniwork.IQueryable<EqpMaterialUseEntity>(a => a.F_EqpId == entity.F_EqpId && a.F_MaterialId == temp.F_MaterialId && a.F_CreatorTime >= job.F_CreatorTime).Sum(a => a.F_Num);
                if (usesnum >= job.F_NeedNum)
                {
                    await _jobApp.FinishJob(job.F_Id);
                }
            }
            //更新流转箱状态
            await uniwork.Update<TransferBoxEntity>(a => a.F_TransferCode == storage.F_TransferBoxCode && a.F_TransferState == 2, a => new TransferBoxEntity
            {
                F_TransferState = 3,
                F_LocationCode = null,
            });
            uniwork.Commit();
            await _logApp.WriteLog(0, "领料:设备" + entity.F_EqpName + "领用物料" + storage.F_MaterialName + "数量" + (entity.F_Num ?? 0), entity.F_EqpName, work.F_WorkOrderCode, storage.F_MaterialName, storage.F_TransferBoxCode, entity.F_Num);
        }
        public async Task ConsumeMaterial(string keyValue, string transferBoxCode)
        {
            //判断物料是否设备需要
            var storage = uniwork.IQueryable<StorageEntity>(a => a.F_TransferBoxCode == transferBoxCode).FirstOrDefault();
            if (storage == null)
            {
                throw new Exception("库存不存在，请检查");
            }
            if (storage.F_IsCheckout != true)
            {
                throw new Exception($"流转箱{transferBoxCode}库存没有经过检验");
            }
            if (uniwork.IQueryable<NeedCheckEntity>(a => a.F_TransferBoxCode == transferBoxCode && a.F_IsCheck == false).Count() > 0)
            {
                throw new Exception("物料正在检验，无法使用");
            }
            uniwork.BeginTrans();
            var eqp = await uniwork.FindEntity<EquipmentEntity>(keyValue);
            //根据设备获取工单,需要的物料
            var work = uniwork.IQueryable<WorkOrderDetailEqpBandingEntity>(a => a.F_EqpId == keyValue)
                .InnerJoin<WorkOrderDetailEntity>((a, b) => a.F_WorkOrderDetailId == b.F_Id && b.F_WorkOrderState == 1)
                .InnerJoin<BomFormEntity>((a, b, c) => b.F_MaterialId == c.F_MaterialId && c.F_BomType == 1 && c.F_SonMaterialId == storage.F_MaterialId)
                .InnerJoin<ProcessFlowEntity>((a, b, c, d) => c.F_ProcessId == d.F_Id)
                .InnerJoin<WorkOrderEntity>((a, b, c, d, e) => b.F_WorkOrderId == e.F_Id)
                .Select((a, b, c, d, e) => new WorkOrderDetailEntity
                {
                    F_BadNum = b.F_BadNum,
                    F_CreatorTime = b.F_CreatorTime,
                    F_CreatorUserId = b.F_CreatorUserId,
                    F_DeleteMark = b.F_DeleteMark,
                    F_Description = b.F_Description,
                    F_DoneNum = b.F_DoneNum,
                    F_EnabledMark = b.F_EnabledMark,
                    F_Id = b.F_Id,
                    F_MaterialId = b.F_MaterialId,
                    F_PlanEndTime = b.F_PlanEndTime,
                    F_PlanNum = b.F_PlanNum,
                    F_PlanStartTime = b.F_PlanStartTime,
                    F_RunSort = b.F_RunSort,
                    F_SonMaterialId = c.F_SonMaterialId,
                    F_SonNum = b.F_PlanNum * c.F_Num,
                    F_WorkOrderId = b.F_WorkOrderId,
                    F_WorkOrderState = b.F_WorkOrderState,
                    F_ProcessId = c.F_ProcessId,
                    F_ProcessName = d.F_ProcessFlowName,
                    F_WorkOrderCode = e.F_WorkOrderCode
                })
                .InnerJoin<WorkOrderDetailProcessBandingEntity>((a, b) => a.F_Id == b.F_WorkOrderDetailId && b.F_ProcessId == a.F_ProcessId)
                .Select((a, b) => a)
                .FirstOrDefault();
            if (work == null)
            {
                throw new Exception("该设备不需要此物料");
            }
            var first = uniwork.IQueryable<StorageEntity>(a => a.F_MaterialId == storage.F_MaterialId && a.F_IsCheckout == true).OrderBy(a => a.F_MaterialBatch.Substring(4)).FirstOrDefault();
            var firstTime = ((DateTime)first.F_CreatorTime).Date;
            var realStorages = uniwork.IQueryable<StorageEntity>(a => a.F_MaterialId == storage.F_MaterialId && a.F_IsCheckout == true && a.F_CreatorTime >= firstTime && a.F_CreatorTime < firstTime.AddDays(1)).OrderBy(a => a.F_MaterialBatch.Substring(4)).Select(a => a.F_Id).ToList();
            //是否多工序作业
            if (work.F_RunSort != 1)
            {
                first = uniwork.IQueryable<OutPutInfoEntity>(a => a.F_WorkOrderId == work.F_WorkOrderId && a.F_MaterialId == storage.F_MaterialId && a.F_IsTemp != true)
                    .InnerJoin<StorageEntity>((a, b) => b.F_IsCheckout == true && a.F_MaterialId == b.F_MaterialId
                    && a.F_MaterialBatch == b.F_MaterialBatch).Select((a, b) => b).OrderBy(a => a.F_MaterialBatch.Substring(4)).FirstOrDefault();
                firstTime = ((DateTime)first.F_CreatorTime).Date;
                realStorages = uniwork.IQueryable<OutPutInfoEntity>(a => a.F_WorkOrderId == work.F_WorkOrderId && a.F_MaterialId == storage.F_MaterialId && a.F_IsTemp != true)
                    .InnerJoin<StorageEntity>((a, b) => b.F_IsCheckout == true && a.F_MaterialId == b.F_MaterialId
                    && a.F_MaterialBatch == b.F_MaterialBatch && b.F_CreatorTime >= firstTime && b.F_CreatorTime < firstTime).Select((a, b) => b).Select(a => a.F_Id).ToList();
            }
            //允许违反先出规则
            var area = uniwork.IQueryable<LocationEntity>(a => a.F_LocationCode == storage.F_LocationCode)
                .InnerJoin<AreaEntity>((a, b) => a.F_AreaId == b.F_Id).Select((a, b) => b).FirstOrDefault();
            if (!realStorages.Contains(storage.F_Id) && area.F_NeedRule == true)
            {
                throw new Exception("请遵循先进先出原则");
            }
            if (storage == null)
            {
                throw new Exception("库存不存在，请检查");
            }
            float num = storage.F_Num ?? 0;
            //添加物料使用信息
            EqpMaterialUseEntity temp = new EqpMaterialUseEntity();
            temp.F_Id = 0;
            temp.F_CreatorTime = DateTime.Now;
            temp.F_CreatorUserId = currentuser.UserId;
            temp.F_Num = num;
            temp.F_DoneNum = 0;
            temp.F_EnabledMark = true;
            temp.F_EqpId = keyValue;
            temp.F_CreatorUserName = currentuser.UserName;
            if (string.IsNullOrEmpty(temp.F_CreatorUserId))
            {
                temp.F_CreatorUserId = WebHelper.GetCookie("boardlogin_uerId");
                if (string.IsNullOrEmpty(temp.F_CreatorUserId))
                {
                    throw new Exception("请使用钉钉扫码登录！");
                }
                else
                {
                    var user =await uniwork.FindEntity<UserEntity>(temp.F_CreatorUserId);
                    temp.F_CreatorUserName = user.F_RealName;
                }
            }
            temp.F_EqpName = eqp.F_EqpName;
            temp.F_TransferBoxCode = transferBoxCode;
            temp.F_MaterialId = storage.F_MaterialId;
            temp.F_MaterialBatch = storage.F_MaterialBatch;
            temp.F_MaterialCode = storage.F_MaterialCode;
            temp.F_MaterialName = storage.F_MaterialName;
            temp.F_MaterialUnit = storage.F_MaterialUnit;
            temp.F_MaterialType = storage.F_MaterialType;
            temp.F_WorkOrderId = work.F_WorkOrderId;
            temp.F_WorkOrderCode = work.F_WorkOrderCode;
            temp.F_WorkOrderRunSort = work.F_RunSort;
            temp.F_ProcessId = work.F_ProcessId;
            temp.F_ProcessName = work.F_ProcessName;
            temp.F_LocationCode = storage.F_LocationCode;
            await uniwork.Insert(temp);
            //扣除库存信息
            int result = await uniwork.Update<StorageEntity>(a => a.F_Id == storage.F_Id && a.F_Num >= storage.F_Num, a => new StorageEntity
            {
                F_Num = a.F_Num - storage.F_Num
            });
            if (result == 0)
            {
                throw new Exception("领用数量超出库存数量，请核对数量");
            }
            //删除0的库存
            await uniwork.Delete<StorageEntity>(a => a.F_TransferBoxCode == transferBoxCode && a.F_Num == 0);
            //更新库位状态
            await uniwork.Update<LocationEntity>(a => a.F_LocationCode == storage.F_LocationCode && a.F_LocationState == true, a => new LocationEntity
            {
                F_LocationState = false
            });
            //完成任务
            var job = uniwork.IQueryable<ControlJobEntity>(a => a.F_NeedEqpId == keyValue && a.F_NeedId == temp.F_MaterialId && a.F_JobType == 0 && a.F_JobState < 2).FirstOrDefault();
            if (job == null)
            {
                throw new Exception("没有任务调度，请检查");
            }
            else
            {
                var usesnum = uniwork.IQueryable<EqpMaterialUseEntity>(a => a.F_EqpId == keyValue && a.F_MaterialId == temp.F_MaterialId && a.F_CreatorTime >= job.F_CreatorTime).Sum(a => a.F_Num);
                if (usesnum >= job.F_NeedNum)
                {
                    await _jobApp.FinishJob(job.F_Id);
                }
            }
            //更新流转箱状态
            await uniwork.Update<TransferBoxEntity>(a => a.F_TransferCode == storage.F_TransferBoxCode && a.F_TransferState == 2, a => new TransferBoxEntity
            {
                F_TransferState = 3,
                F_LocationCode = null,
            });
            uniwork.Commit();
        }
        public async Task ReturnMaterial(ReturnMaterialEntity entity, string newTransferCode)
        {
            if (!string.IsNullOrEmpty(newTransferCode))
            {
                //判断流转箱类型和物料、数量是否对应
                if (!transferApp.IsTransferType(newTransferCode, entity.F_MaterialId, entity.F_Num ?? 0))
                {
                    throw new Exception("流转箱不可用");
                }
            }
            var location = await GetLocationReturn(entity.F_TransferBoxCode);
            if (location == null || location.F_LocationCode != entity.F_LocationCode)
            {
                throw new Exception("库位不可用");
            }
            if (uniwork.IQueryable<NeedCheckEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_IsCheck == false).Count() > 0)
            {
                throw new Exception("物料正在检验，无法操作");
            }
            //根据设备 流转箱编号获取物料使用信息
            var useMaterial = uniwork.IQueryable<EqpMaterialUseEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_Num != a.F_DoneNum).FirstOrDefault();
            if (useMaterial == null)
            {
                throw new Exception("物料使用信息不存在");
            }
            var material = await uniwork.FindEntity<MaterialEntity>(useMaterial.F_MaterialId);
            ReturnMaterialEntity temp = new ReturnMaterialEntity();
            temp.F_Id = 0;
            temp.F_CreatorTime = DateTime.Now;
            temp.F_CreatorUserId = currentuser.UserId;
            temp.F_CreatorUserName = currentuser.UserName;
            temp.F_Description = entity.F_Description;
            temp.F_Num = useMaterial.F_Num - useMaterial.F_DoneNum;
            temp.F_EnabledMark = true;
            temp.F_EqpId = useMaterial.F_EqpId;
            temp.F_EqpName = useMaterial.F_EqpName;
            temp.F_LocationCode = entity.F_LocationCode;
            temp.F_MaterialBatch = useMaterial.F_MaterialBatch;
            temp.F_MaterialCode = useMaterial.F_MaterialCode;
            temp.F_MaterialId = useMaterial.F_MaterialId;
            temp.F_MaterialName = useMaterial.F_MaterialName;
            temp.F_MaterialType = useMaterial.F_MaterialType;
            temp.F_MaterialUnit = useMaterial.F_MaterialUnit;
            temp.F_ProcessId = useMaterial.F_ProcessId;
            temp.F_ProcessName = useMaterial.F_ProcessName;
            temp.F_WorkOrderId = useMaterial.F_WorkOrderId;
            temp.F_WorkOrderCode = useMaterial.F_WorkOrderCode;
            temp.F_WorkOrderRunSort = useMaterial.F_WorkOrderRunSort;
            temp.F_TransferBoxCode = useMaterial.F_TransferBoxCode;
            StorageEntity storage = new StorageEntity();
            storage.Create();
            var firststorage = uniwork.IQueryable<StorageEntity>(a => a.F_MaterialId == temp.F_MaterialId).OrderByDesc(a => a.F_CreatorTime).Select(a => a.F_CreatorTime).FirstOrDefault();
            storage.F_CreatorTime = firststorage == null?DateTime.Now : firststorage;
            storage.F_Description = entity.F_Description;
            storage.F_EnabledMark = true;
            storage.F_LocationCode = entity.F_LocationCode;
            storage.F_MaterialBatch = useMaterial.F_MaterialBatch;
            storage.F_MaterialCode = useMaterial.F_MaterialCode;
            storage.F_MaterialId = useMaterial.F_MaterialId;
            storage.F_MaterialName = useMaterial.F_MaterialName;
            storage.F_MaterialType = useMaterial.F_MaterialType;
            storage.F_MaterialUnit = useMaterial.F_MaterialUnit;
            storage.F_Num = temp.F_Num;
            storage.F_TransferBoxCode = entity.F_TransferBoxCode;
            storage.F_IsCheckout = true;
            //更新物料使用信息
            uniwork.BeginTrans();
            var result = await uniwork.Update<EqpMaterialUseEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_Num != a.F_DoneNum, a => new EqpMaterialUseEntity
            {
                F_Num = a.F_DoneNum,
            });
            if (result == 0)
            {
                throw new Exception("物料使用信息不存在");
            }
            //删除0的使用记录
            await uniwork.Delete<EqpMaterialUseEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_Num == 0);
            //完成任务
            var job = uniwork.IQueryable<ControlJobEntity>(a => a.F_NeedId == temp.F_TransferBoxCode && a.F_NeedEqpId == temp.F_EqpId && a.F_JobType == 7 && a.F_JobState < 2).FirstOrDefault();
            if (job == null)
            {
                throw new Exception("没有任务调度，请检查");
            }
            else
            {
                await _jobApp.FinishJob(job.F_Id);
            }
			//增加库存信息
			if (uniwork.IQueryable<StorageEntity>(a=>a.F_TransferBoxCode==storage.F_TransferBoxCode&&a.F_MaterialBatch==storage.F_MaterialBatch&&a.F_MaterialId==storage.F_MaterialId).Count()>0)
			{
                await uniwork.Update<StorageEntity>(a => a.F_TransferBoxCode == storage.F_TransferBoxCode && a.F_MaterialBatch == storage.F_MaterialBatch && a.F_MaterialId == storage.F_MaterialId, a => new StorageEntity
                {
                    F_Num = a.F_Num + storage.F_Num
                });
			}
			else
			{
                await uniwork.Insert(storage);
            }
            //添加退回记录
            await uniwork.Insert(temp);
            //退回移托
            if (!string.IsNullOrEmpty(newTransferCode))
            {
                StorageChangeInfoEntity change = new StorageChangeInfoEntity();
                change.F_TransferBoxCode = entity.F_TransferBoxCode;
                change.F_Num = entity.F_Num;
                change.F_NewTransferBoxCode = newTransferCode;
                change.F_Description = "领用退回移托";
                change.F_ChangeType = 0;
                await _storageApp.StorageChange(change,false, false);
            }
            //更新库位状态
            result = await uniwork.Update<LocationEntity>(a => a.F_LocationCode == entity.F_LocationCode && a.F_LocationState == false, a => new LocationEntity
            {
                F_LocationState = true
            });
            if (result == 0)
            {
                throw new Exception("库位不可用");
            }
            //更新流转箱状态
            await uniwork.Update<TransferBoxEntity>(a => a.F_TransferCode == storage.F_TransferBoxCode && a.F_TransferState == 3, a => new TransferBoxEntity
            {
                F_TransferState = 2,
                F_LocationCode = entity.F_LocationCode
            });
            uniwork.Commit();
        }
        public async Task OutputMaterial(OutPutInfoEntity entity)
        {
            //一个设备同时允许一个工单作业
            var material = await uniwork.FindEntity<MaterialEntity>(a => a.F_MaterialCode == entity.F_MaterialCode);
            if (material == null)
                throw new Exception($"物料{entity.F_MaterialCode}不存在，请重试");
            var eqp = await uniwork.FindEntity<EquipmentEntity>(a => a.F_EqpName == entity.F_EqpName);
            if (eqp == null)
                throw new Exception($"设备{entity.F_EqpName}不存在，请重试");

            entity.F_EqpId = eqp.F_Id;
            entity.F_MaterialId = material.F_Id;
            var order = uniwork.IQueryable<EquipmentEntity>(a => a.F_EqpName == entity.F_EqpName).InnerJoin<WorkOrderDetailEqpBandingEntity>((a, b) => b.F_EqpId == a.F_Id)
                .InnerJoin<WorkOrderDetailEntity>((a, b, c) => b.F_WorkOrderDetailId == c.F_Id && c.F_WorkOrderState == 1 && c.F_MaterialId == entity.F_MaterialId).Select((a, b, c) => c).FirstOrDefault();
            var workorder = await uniwork.FindEntity<WorkOrderEntity>(order.F_WorkOrderId);
            if (order == null)
            {
                throw new Exception($"物料{entity.F_MaterialCode}不存在，请重试");
            }
            var scanpreturns = uniwork.IQueryable<ScapMaterialReturnEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_IsProduce == true && a.F_MaterialId == entity.F_MaterialId).Sum(a => a.F_Num) ?? 0;
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
                        //流转箱判断
                        var readyboxes = uniwork.IQueryable<ReadyTransferBoxEntity>(a => a.F_EqpId == entity.F_EqpId).Select(a => a.F_TransferBoxCode).ToList();
                        if (readyboxes.Count > 0 && readyboxes.Contains(entity.F_TransferBoxCode))
                        {
                            throw new Exception($"预绑定流转箱不存在{entity.F_TransferBoxCode}，请检查");
                        }
                    }
                    else if (transfer.F_TransferState == 1)
                    {
                        var temps = uniwork.IQueryable<OutPutInfoEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_MaterialId == entity.F_MaterialId && a.F_IsTemp == true).ToList();
                        if (temps.Count == 0)
                        {
                            if (uniwork.IQueryable<ReadyTransferBoxEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_EqpId == entity.F_EqpId).Count() == 0 && scanpreturns == 0)
                            {
                                throw new Exception($"流转箱{entity.F_TransferBoxCode}不可用");
                            }
                            if (transfer.F_TransferMaxNum < entity.F_Num + scanpreturns)
                            {
                                throw new Exception($"流转箱{entity.F_TransferBoxCode}可存放数量超出");
                            }
                        }
                        else
                        {
                            if (transfer.F_TransferMaxNum < entity.F_Num + temps.Sum(a => a.F_Num))
                            {
                                throw new Exception($"流转箱{entity.F_TransferBoxCode}可存放数量超出");
                            }
                            entity.F_MaterialBatch = temps[0].F_MaterialBatch;
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
            //根据设备获取工单使用物料
            var work = uniwork.IQueryable<BomFormEntity>(a => a.F_MaterialId == order.F_MaterialId && a.F_BomType == 1)
                .InnerJoin<WorkOrderDetailProcessBandingEntity>((a,b)=>b.F_WorkOrderDetailId==order.F_Id&&a.F_ProcessId==b.F_ProcessId)
                .Select((a,b) => new WorkOrderDetailEntity
                {
                    F_MaterialId = order.F_MaterialId,
                    F_SonMaterialId = a.F_SonMaterialId,
                    F_SonNum = a.F_Num,
                }).Distinct().ToList();
            var sonMaterials = work.Select(a => a.F_SonMaterialId).Distinct().ToList();
            var useList = uniwork.IQueryable<EqpMaterialUseEntity>(a => a.F_EqpId == entity.F_EqpId && a.F_Num != a.F_DoneNum && sonMaterials.Contains(a.F_MaterialId)).OrderBy(a => a.F_CreatorTime).ToList();
            //增加物料使用数量
            //添加物料损耗记录
            //添加物料产出绑定记录
            uniwork.BeginTrans();
            //删除绑定记录
            await uniwork.Delete<ReadyTransferBoxEntity>(a => a.F_EqpId == eqp.F_Id && a.F_TransferBoxCode == entity.F_TransferBoxCode);
            DateTime dt = DateTime.Now;
            int result = 0;
            List<ConsumeInfoEntity> consumeList = new List<ConsumeInfoEntity>();
            OutPutInfoEntity outputTemp = new OutPutInfoEntity();
            outputTemp.F_Id = 0;
            outputTemp.F_BandingUserId = currentuser.UserId;
            outputTemp.F_BandingUserName = currentuser.UserName;
            outputTemp.F_BandingTime = dt;
            outputTemp.F_TransferBoxCode = entity.F_TransferBoxCode;
            outputTemp.F_Description = entity.F_Description;
            outputTemp.F_EnabledMark = true;
            outputTemp.F_EqpId = entity.F_EqpId;
            outputTemp.F_EqpName = entity.F_EqpName;
            outputTemp.F_MaterialBatch = entity.F_MaterialBatch;
            outputTemp.F_MaterialCode = material.F_MaterialCode;
            outputTemp.F_MaterialId = order.F_MaterialId;
            outputTemp.F_Num = entity.F_Num;
            outputTemp.F_MaterialName = material.F_MaterialName;
            outputTemp.F_MaterialType = material.F_MaterialType;
            outputTemp.F_MaterialUnit = material.F_MaterialUnit;
            outputTemp.F_WorkOrderId = order.F_WorkOrderId;
            outputTemp.F_WorkOrderDetailId = order.F_Id;
            outputTemp.F_WorkOrderRunSort = order.F_RunSort;
            outputTemp.F_WorkOrderCode = workorder.F_WorkOrderCode;
            outputTemp.F_IsTemp = true;
            foreach (var item in work)
            {
                float num = entity.F_Num ?? 0;
                var trans = uniwork.IQueryable<NeedCheckEntity>(a => a.F_IsCheck == false).Select(a => a.F_TransferBoxCode).ToList();
                var temps = useList.Where(a => a.F_MaterialId == item.F_SonMaterialId && !trans.Contains(a.F_TransferBoxCode)).ToList();
                if (temps.Sum(a=>a.F_Num-a.F_DoneNum) < num * item.F_SonNum)
                {
                    throw new Exception($"领用物料不足，无法生产");
                }
                foreach (var temp in temps)
                {
                    outputTemp.F_ProcessId = temp.F_ProcessId;
                    outputTemp.F_ProcessName = temp.F_ProcessName;
                    if (num == 0)
                    {
                        break;
                    }
                    if (num >= (temp.F_Num ?? 0) - (temp.F_DoneNum ?? 0))
                    {
                        result = await uniwork.Update<EqpMaterialUseEntity>(a => a.F_Id == temp.F_Id & a.F_Num - a.F_DoneNum <= num * item.F_SonNum, a => new EqpMaterialUseEntity
                        {
                            F_DoneNum = a.F_Num
                        });
                        if (result > 0)
                        {
                            num = num - (temp.F_Num ?? 0) + (temp.F_DoneNum ?? 0);
                            ConsumeInfoEntity consume = new ConsumeInfoEntity();
                            consume.F_Id = 0;
                            consume.F_CreatorTime = DateTime.Now;
                            consume.F_CreatorUserId = outputTemp.F_BandingUserId;
                            consume.F_CreatorUserName = outputTemp.F_BandingUserName;
                            consume.F_CreatorTime = dt;
                            consume.F_OutPutId = outputTemp.F_Id;
                            consume.F_TransferBoxCode = temp.F_TransferBoxCode;
                            consume.F_Description = entity.F_Description;
                            consume.F_EnabledMark = true;
                            consume.F_EqpId = entity.F_EqpId;
                            consume.F_EqpName = entity.F_EqpName;
                            consume.F_MaterialBatch = temp.F_MaterialBatch;
                            consume.F_MaterialCode = temp.F_MaterialCode;
                            consume.F_MaterialId = temp.F_MaterialId;
                            consume.F_MaterialName = temp.F_MaterialName;
                            consume.F_MaterialType = temp.F_MaterialType;
                            consume.F_MaterialUnit = temp.F_MaterialUnit;
                            consume.F_Num = ((temp.F_Num??0) - (temp.F_DoneNum??0)) * item.F_SonNum;
                            consume.F_ProcessId = outputTemp.F_ProcessId;
                            consume.F_ProcessName = outputTemp.F_ProcessName;
                            consume.F_WorkOrderCode = outputTemp.F_WorkOrderCode;
                            consume.F_WorkOrderId = outputTemp.F_WorkOrderId;
                            consume.F_WorkOrderRunSort = outputTemp.F_WorkOrderRunSort;
                            consume.F_WorkOrderDetailId = outputTemp.F_WorkOrderDetailId;
                            consumeList.Add(consume);
                        }
                        else
                        {
                            throw new Exception("使用数量已变更，请重试");
                        }
                    }
                    else
                    {
                        result = await uniwork.Update<EqpMaterialUseEntity>(a => a.F_Id == temp.F_Id & a.F_Num - a.F_DoneNum > num * item.F_SonNum, a => new EqpMaterialUseEntity
                        {
                            F_DoneNum = a.F_DoneNum + num * item.F_SonNum
                        });
                        if (result > 0)
                        {
                            ConsumeInfoEntity consume = new ConsumeInfoEntity();
                            consume.F_Id = 0;
                            consume.F_CreatorTime = DateTime.Now;
                            consume.F_CreatorUserId = outputTemp.F_BandingUserId;
                            consume.F_CreatorUserName = outputTemp.F_BandingUserName;
                            consume.F_CreatorTime = dt;
                            consume.F_OutPutId = outputTemp.F_Id;
                            consume.F_TransferBoxCode = temp.F_TransferBoxCode;
                            consume.F_Description = entity.F_Description;
                            consume.F_EnabledMark = true;
                            consume.F_EqpId = entity.F_EqpId;
                            consume.F_EqpName = entity.F_EqpName;
                            consume.F_MaterialBatch = temp.F_MaterialBatch;
                            consume.F_MaterialCode = temp.F_MaterialCode;
                            consume.F_MaterialId = temp.F_MaterialId;
                            consume.F_MaterialName = temp.F_MaterialName;
                            consume.F_MaterialType = temp.F_MaterialType;
                            consume.F_MaterialUnit = temp.F_MaterialUnit;
                            consume.F_Num = num * item.F_SonNum;
                            consume.F_ProcessId = outputTemp.F_ProcessId;
                            consume.F_ProcessName = outputTemp.F_ProcessName;
                            consume.F_WorkOrderCode = outputTemp.F_WorkOrderCode;
                            consume.F_WorkOrderId = outputTemp.F_WorkOrderId;
                            consume.F_WorkOrderRunSort = outputTemp.F_WorkOrderRunSort;
                            consume.F_WorkOrderDetailId = outputTemp.F_WorkOrderDetailId;
                            consumeList.Add(consume);
                            num = 0;
                        }
                        else
                        {
                            throw new Exception("使用数量已变更，请重试");
                        }
                    }
                    //流转箱状态变更
                    //流转箱状态变更
                    var useEntity = await uniwork.FindEntity<EqpMaterialUseEntity>(a => a.F_TransferBoxCode == temp.F_TransferBoxCode && a.F_DoneNum != a.F_Num);
                    if (useEntity == null)
                    {
                        result = await uniwork.Update<TransferBoxEntity>(a => a.F_TransferCode == temp.F_TransferBoxCode && a.F_TransferState == 3, a => new TransferBoxEntity
                        {
                            F_TransferState = 0,
                        });
                    }
                }
            }
            outputTemp = await uniwork.Insert(outputTemp);
            foreach (var item in consumeList)
            {
                item.F_OutPutId = outputTemp.F_Id;
            }
            await uniwork.Insert(consumeList);
            await uniwork.Delete<ReadyTransferBoxEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_EqpId == entity.F_EqpId);
			if (material.F_NeedCheckout==true)
			{
                var check = uniwork.IQueryable<NeedCheckEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_CheckType == 3 && a.F_IsCheck == false).FirstOrDefault();
                if (check != null)
                {
                    throw new Exception($"流转箱编号{entity.F_TransferBoxCode},已有产出检验任务");
                }
                else
                {
                    //创建检验单，创建调度任务
                    check = new NeedCheckEntity();
                    check.F_Id = 0;
                    check.F_SourceId = outputTemp.F_Id.ToString();
                    check.F_CreatorTime = DateTime.Now;
                    check.F_CheckType = 2;
                    check.F_IsCheck = false;
                    check.F_IsNeedTwoCheck = false;
                    check.F_IsTwoCheck = false;
                    check.F_MaterialBatch = outputTemp.F_MaterialBatch;
                    check.F_MaterialCode = outputTemp.F_MaterialCode;
                    check.F_MaterialId = outputTemp.F_MaterialId;
                    check.F_MaterialName = outputTemp.F_MaterialName;
                    check.F_MaterialType = outputTemp.F_MaterialType;
                    check.F_MaterialUnit = outputTemp.F_MaterialUnit;
                    check.F_EqpId = eqp.F_Id;
                    check.F_EqpName = eqp.F_EqpName;
                    check.F_Num = entity.F_Num;
                    check.F_TransferBoxCode = outputTemp.F_TransferBoxCode;
                    ControlJobEntity jobEntity = new ControlJobEntity();
                    jobEntity.F_JobType = 8;
                    jobEntity.F_NeedId = check.F_TransferBoxCode;
                    jobEntity.F_NeedEqpId = outputTemp.F_EqpId;
                    jobEntity.F_Priority = 1;
                    jobEntity.F_NeedNum = entity.F_Num;
                    jobEntity.F_JobCode = "CJ_" + DateTime.Now.ToString("yyyyMMddHHmmss") + 0;
                    jobEntity.F_JobInfo = "常规检验-产出检验," + "流转箱编号为" + check.F_TransferBoxCode + ",物料编号为" + material.F_MaterialCode + ",名称为" + material.F_MaterialName + "的物料进行检验。";
                    jobEntity.F_JobInfo += "数量为" + entity.F_Num;
                    await _jobApp.SubmitForm(jobEntity);
                    await uniwork.Insert(check);
                }
            }
			else
			{
                var job = uniwork.IQueryable<ControlJobEntity>(a => a.F_NeedId == outputTemp.F_TransferBoxCode && a.F_NeedEqpId == outputTemp.F_EqpId && a.F_JobType == 3 && a.F_JobState < 2).FirstOrDefault();
                if (job == null)
                {
                    ControlJobEntity jobEntity = new ControlJobEntity();
                    jobEntity.F_JobType = 3;
                    jobEntity.F_NeedId = entity.F_TransferBoxCode;
                    jobEntity.F_NeedEqpId = outputTemp.F_EqpId;
                    jobEntity.F_NeedNum = outputTemp.F_Num+scanpreturns;
                    jobEntity.F_Priority = 99;
                    jobEntity.F_JobCode = "CJ_" + DateTime.Now.ToString("yyyyMMddHHmmss") + 0;
                    jobEntity.F_JobInfo = "产出上架,设备为" + outputTemp.F_EqpName + ",流转箱为" + entity.F_TransferBoxCode + "的产出物料进行上架。";
                    jobEntity.F_JobInfo += "数量为" + (outputTemp.F_Num+ scanpreturns);
                    await _jobApp.SubmitForm(jobEntity);
                }
                else
                {
                    job.F_JobInfo = "产出上架,设备为" + outputTemp.F_EqpName + ",流转箱为" + entity.F_TransferBoxCode + "的产出物料进行上架。";
                    job.F_JobInfo += "数量为" + (job.F_NeedNum + outputTemp.F_Num+ scanpreturns);
                    var needtime = await uniwork.FindEntity<ControlJobMustTimeEntity>(a => a.F_JobType == 0);
                    if (needtime != null)
                    {
                        var needTime = DateTime.Now.AddMinutes(needtime.F_NeedTime ?? 0);
                        await uniwork.Update<ControlJobEntity>(a => a.F_Id == job.F_Id, a => new ControlJobEntity
                        {
                            F_JobInfo = job.F_JobInfo,
                            F_NeedNum = a.F_NeedNum + outputTemp.F_Num+ scanpreturns,
                            F_FinishTime = null,
                            F_NeedTime= needTime,
                        });
                    }
                    else
                    {
                        await uniwork.Update<ControlJobEntity>(a => a.F_Id == job.F_Id, a => new ControlJobEntity
                        {
                            F_JobInfo = job.F_JobInfo,
                            F_NeedNum = a.F_NeedNum + outputTemp.F_Num+ scanpreturns,
                            F_FinishTime = null
                        });
                    }
                }
            }
            //增加工单作业数量
            await uniwork.Update<WorkOrderDetailEntity>(a => a.F_Id == order.F_Id, a => new WorkOrderDetailEntity
            {
                F_DoneNum = a.F_DoneNum + entity.F_Num
            });
            var workinote = await uniwork.FindEntity<WorkOrderEntity>(order.F_WorkOrderId);
            //更新工单数量
            if (workinote.F_MaterialId == order.F_MaterialId)
            {
                await uniwork.Update<WorkOrderEntity>(a => a.F_Id == workinote.F_Id, a => new WorkOrderEntity
                {
                    F_DoneNum = a.F_DoneNum + entity.F_Num
                });
				if (!string.IsNullOrEmpty(workinote.F_WorkPlanId))
				{
                    await uniwork.Update<WorkPlanEntity>(a => a.F_Id == workinote.F_WorkPlanId, a => new WorkPlanEntity
                    {
                        F_DoneNum = a.F_DoneNum + entity.F_Num
                    });
                }
            }
            if (uniwork.IQueryable<OutPutInfoEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_IsTemp == true).Select(a => new { a.F_MaterialId, a.F_MaterialBatch }).Distinct().Count() > 1)
            {
                throw new Exception("流转箱不能绑定多种物料,请检查");
            }
            var tempsNum = uniwork.IQueryable<OutPutInfoEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_IsTemp == true).Sum(a => a.F_Num)??0;
            //更新流转箱状态
            var resultId = await uniwork.Update<TransferBoxEntity>(a => a.F_TransferCode == entity.F_TransferBoxCode && a.F_TransferState <= 1 && tempsNum <= a.F_TransferMaxNum, a => new TransferBoxEntity
            {
                F_TransferState = 1
            });
            if (scanpreturns>0)
            {
                await uniwork.Update<ScapMaterialReturnEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_IsProduce == true, a => new ScapMaterialReturnEntity
                {
                    F_BackMaterialBatch = entity.F_MaterialBatch,
                });
            }
            if (resultId == 0)
            {
                throw new Exception("流转箱产出数量超出限制,请检查");
            }
            uniwork.Commit();
            await _logApp.WriteLog(1, "产出:设备" + entity.F_EqpName + "产出物料" + entity.F_MaterialName + "数量" + (entity.F_Num ?? 0), entity.F_EqpName, entity.F_WorkOrderCode, entity.F_MaterialName, entity.F_TransferBoxCode, entity.F_Num);
        }

        public async Task OutputMaterial(string keyValue, string materialId, string transferBoxCode, int outnum, string materialBatch)
        {
            OutPutInfoEntity entity = new OutPutInfoEntity();
            entity.F_EqpId = keyValue;
            entity.F_MaterialId = materialId;
            entity.F_TransferBoxCode = transferBoxCode;
            entity.F_Num = outnum;
            entity.F_MaterialBatch = materialBatch;
            //一个设备同时允许一个工单作业
            var material = await uniwork.FindEntity<MaterialEntity>(entity.F_MaterialId);
            if (material == null)
                throw new Exception($"物料{entity.F_MaterialId}不存在，请重试");
            var eqp = await uniwork.FindEntity<EquipmentEntity>(keyValue);
            if (eqp == null)
                throw new Exception($"设备{keyValue}不存在，请重试");

            entity.F_EqpId = eqp.F_Id;
            entity.F_MaterialCode = material.F_MaterialCode;
            entity.F_EqpName = eqp.F_EqpName;
            entity.F_MaterialId = material.F_Id;
            var order = uniwork.IQueryable<EquipmentEntity>(a => a.F_Id == keyValue).InnerJoin<WorkOrderDetailEqpBandingEntity>((a, b) => b.F_EqpId == a.F_Id)
                .InnerJoin<WorkOrderDetailEntity>((a, b, c) => b.F_WorkOrderDetailId == c.F_Id && c.F_WorkOrderState == 1 && c.F_MaterialId == entity.F_MaterialId).Select((a, b, c) => c).FirstOrDefault();
            var workorder = await uniwork.FindEntity<WorkOrderEntity>(order.F_WorkOrderId);
            if (order == null)
            {
                throw new Exception($"物料{entity.F_MaterialCode}不存在，请重试");
            }
            var scanpreturns = uniwork.IQueryable<ScapMaterialReturnEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_IsProduce == true && a.F_MaterialId == entity.F_MaterialId).Sum(a => a.F_Num) ?? 0;
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
                        //流转箱判断
                        var readyboxes = uniwork.IQueryable<ReadyTransferBoxEntity>(a => a.F_EqpId == entity.F_EqpId).Select(a => a.F_TransferBoxCode).ToList();
                        if (readyboxes.Count > 0 && readyboxes.Contains(entity.F_TransferBoxCode))
                        {
                            throw new Exception($"预绑定流转箱不存在{entity.F_TransferBoxCode}，请检查");
                        }
                    }
                    else if (transfer.F_TransferState == 1)
                    {
                        var temps = uniwork.IQueryable<OutPutInfoEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_MaterialId == entity.F_MaterialId && a.F_IsTemp == true).ToList();
                        if (temps.Count == 0)
                        {
                            if (uniwork.IQueryable<ReadyTransferBoxEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_EqpId == entity.F_EqpId).Count() == 0 && scanpreturns == 0)
                            {
                                throw new Exception($"流转箱{entity.F_TransferBoxCode}不可用");
                            }
                            if (transfer.F_TransferMaxNum < entity.F_Num + scanpreturns)
                            {
                                throw new Exception($"流转箱{entity.F_TransferBoxCode}可存放数量超出");
                            }
                        }
                        else
                        {
                            if (transfer.F_TransferMaxNum < entity.F_Num + temps.Sum(a => a.F_Num))
                            {
                                throw new Exception($"流转箱{entity.F_TransferBoxCode}可存放数量超出");
                            }
                            entity.F_MaterialBatch = temps[0].F_MaterialBatch;
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
            //根据设备获取工单使用物料
            var work = uniwork.IQueryable<BomFormEntity>(a => a.F_MaterialId == order.F_MaterialId && a.F_BomType == 1)
                                .InnerJoin<WorkOrderDetailProcessBandingEntity>((a, b) => b.F_WorkOrderDetailId == order.F_Id && a.F_ProcessId == b.F_ProcessId)
                .Select((a,b) => new WorkOrderDetailEntity
                {
                    F_MaterialId = order.F_MaterialId,
                    F_SonMaterialId = a.F_SonMaterialId,
                    F_SonNum = a.F_Num,
                }).Distinct().ToList();
            var sonMaterials = work.Select(a => a.F_SonMaterialId).Distinct().ToList();
            var useList = uniwork.IQueryable<EqpMaterialUseEntity>(a => a.F_EqpId == entity.F_EqpId && a.F_Num != a.F_DoneNum && sonMaterials.Contains(a.F_MaterialId)).OrderBy(a => a.F_CreatorTime).ToList();
            //增加物料使用数量
            //添加物料损耗记录
            //添加物料产出绑定记录
            uniwork.BeginTrans();
            //删除绑定记录
            await uniwork.Delete<ReadyTransferBoxEntity>(a => a.F_EqpId == eqp.F_Id && a.F_TransferBoxCode == entity.F_TransferBoxCode);
            DateTime dt = DateTime.Now;
            int result = 0;
            List<ConsumeInfoEntity> consumeList = new List<ConsumeInfoEntity>();
            OutPutInfoEntity outputTemp = new OutPutInfoEntity();
            outputTemp.F_Id = 0;
            outputTemp.F_BandingUserId = currentuser.UserId;
            outputTemp.F_BandingUserName = currentuser.UserName;
            outputTemp.F_BandingTime = dt;
            outputTemp.F_TransferBoxCode = entity.F_TransferBoxCode;
            outputTemp.F_Description = entity.F_Description;
            outputTemp.F_EnabledMark = true;
            outputTemp.F_EqpId = entity.F_EqpId;
            outputTemp.F_EqpName = entity.F_EqpName;
            outputTemp.F_MaterialBatch = entity.F_MaterialBatch;
            outputTemp.F_MaterialCode = material.F_MaterialCode;
            outputTemp.F_MaterialId = order.F_MaterialId;
            outputTemp.F_Num = entity.F_Num;
            outputTemp.F_MaterialName = material.F_MaterialName;
            outputTemp.F_MaterialType = material.F_MaterialType;
            outputTemp.F_MaterialUnit = material.F_MaterialUnit;
            outputTemp.F_WorkOrderId = order.F_WorkOrderId;
            outputTemp.F_WorkOrderDetailId = order.F_Id;
            outputTemp.F_WorkOrderRunSort = order.F_RunSort;
            outputTemp.F_WorkOrderCode = workorder.F_WorkOrderCode;
            outputTemp.F_IsTemp = true;
            if (string.IsNullOrEmpty(outputTemp.F_CreatorUserId))
            {
                outputTemp.F_CreatorUserId = WebHelper.GetCookie("boardlogin_uerId");
                if (string.IsNullOrEmpty(outputTemp.F_CreatorUserId))
                {
                    throw new Exception("请使用钉钉扫码登录！");
                }
                else
                {
                    var user = await uniwork.FindEntity<UserEntity>(outputTemp.F_CreatorUserId);
                    outputTemp.F_CreatorUserName = user.F_RealName;

                    if(string.IsNullOrEmpty(outputTemp.F_BandingUserId))
                    {
                        outputTemp.F_BandingUserId = outputTemp.F_CreatorUserId;
                        outputTemp.F_BandingUserName = outputTemp.F_CreatorUserName;
                    }

                }
            }
            foreach (var item in work)
            {
                float num = entity.F_Num ?? 0;
                var trans = uniwork.IQueryable<NeedCheckEntity>(a => a.F_IsCheck == false).Select(a => a.F_TransferBoxCode).ToList();
                var temps = useList.Where(a => a.F_MaterialId == item.F_SonMaterialId && !trans.Contains(a.F_TransferBoxCode)).ToList();
                if (temps.Sum(a => a.F_Num - a.F_DoneNum) < num * item.F_SonNum)
                {
                    throw new Exception($"领用物料不足，无法生产");
                }
                foreach (var temp in temps)
                {
                    outputTemp.F_ProcessId = temp.F_ProcessId;
                    outputTemp.F_ProcessName = temp.F_ProcessName;
                    if (num == 0)
                    {
                        break;
                    }
                    if (num >= (temp.F_Num ?? 0) - (temp.F_DoneNum ?? 0))
                    {
                        result = await uniwork.Update<EqpMaterialUseEntity>(a => a.F_Id == temp.F_Id & a.F_Num - a.F_DoneNum <= num * item.F_SonNum, a => new EqpMaterialUseEntity
                        {
                            F_DoneNum = a.F_Num
                        });
                        if (result > 0)
                        {
                            num = num - (temp.F_Num ?? 0) + (temp.F_DoneNum ?? 0);
                            ConsumeInfoEntity consume = new ConsumeInfoEntity();
                            consume.F_Id = 0;
                            consume.F_CreatorTime = DateTime.Now;
                            consume.F_CreatorUserId = outputTemp.F_BandingUserId;
                            consume.F_CreatorUserName = outputTemp.F_BandingUserName;
                            consume.F_CreatorTime = dt;
                            consume.F_OutPutId = outputTemp.F_Id;
                            consume.F_TransferBoxCode = temp.F_TransferBoxCode;
                            consume.F_Description = entity.F_Description;
                            consume.F_EnabledMark = true;
                            consume.F_EqpId = entity.F_EqpId;
                            consume.F_EqpName = entity.F_EqpName;
                            consume.F_MaterialBatch = temp.F_MaterialBatch;
                            consume.F_MaterialCode = temp.F_MaterialCode;
                            consume.F_MaterialId = temp.F_MaterialId;
                            consume.F_MaterialName = temp.F_MaterialName;
                            consume.F_MaterialType = temp.F_MaterialType;
                            consume.F_MaterialUnit = temp.F_MaterialUnit;
                            consume.F_Num = ((temp.F_Num??0) - (temp.F_DoneNum??0)) * item.F_SonNum;
                            consume.F_ProcessId = outputTemp.F_ProcessId;
                            consume.F_ProcessName = outputTemp.F_ProcessName;
                            consume.F_WorkOrderCode = outputTemp.F_WorkOrderCode;
                            consume.F_WorkOrderId = outputTemp.F_WorkOrderId;
                            consume.F_WorkOrderRunSort = outputTemp.F_WorkOrderRunSort;
                            consume.F_WorkOrderDetailId = outputTemp.F_WorkOrderDetailId;
                            consumeList.Add(consume);
                        }
                        else
                        {
                            throw new Exception("使用数量已变更，请重试");
                        }
                    }
                    else
                    {
                        result = await uniwork.Update<EqpMaterialUseEntity>(a => a.F_Id == temp.F_Id & a.F_Num - a.F_DoneNum > num * item.F_SonNum, a => new EqpMaterialUseEntity
                        {
                            F_DoneNum = a.F_DoneNum + num * item.F_SonNum
                        });
                        if (result > 0)
                        {
                            ConsumeInfoEntity consume = new ConsumeInfoEntity();
                            consume.F_Id = 0;
                            consume.F_CreatorTime = DateTime.Now;
                            consume.F_CreatorUserId = outputTemp.F_BandingUserId;
                            consume.F_CreatorUserName = outputTemp.F_BandingUserName;
                            consume.F_CreatorTime = dt;
                            consume.F_OutPutId = outputTemp.F_Id;
                            consume.F_TransferBoxCode = temp.F_TransferBoxCode;
                            consume.F_Description = entity.F_Description;
                            consume.F_EnabledMark = true;
                            consume.F_EqpId = entity.F_EqpId;
                            consume.F_EqpName = entity.F_EqpName;
                            consume.F_MaterialBatch = temp.F_MaterialBatch;
                            consume.F_MaterialCode = temp.F_MaterialCode;
                            consume.F_MaterialId = temp.F_MaterialId;
                            consume.F_MaterialName = temp.F_MaterialName;
                            consume.F_MaterialType = temp.F_MaterialType;
                            consume.F_MaterialUnit = temp.F_MaterialUnit;
                            consume.F_Num = num * item.F_SonNum;
                            consume.F_ProcessId = outputTemp.F_ProcessId;
                            consume.F_ProcessName = outputTemp.F_ProcessName;
                            consume.F_WorkOrderCode = outputTemp.F_WorkOrderCode;
                            consume.F_WorkOrderId = outputTemp.F_WorkOrderId;
                            consume.F_WorkOrderRunSort = outputTemp.F_WorkOrderRunSort;
                            consume.F_WorkOrderDetailId = outputTemp.F_WorkOrderDetailId;
                            consumeList.Add(consume);
                            num = 0;
                        }
                        else
                        {
                            throw new Exception("使用数量已变更，请重试");
                        }
                    }
                    //流转箱状态变更
                    var useEntity = await uniwork.FindEntity<EqpMaterialUseEntity>(a => a.F_TransferBoxCode == temp.F_TransferBoxCode && a.F_DoneNum != a.F_Num);
                    if (useEntity == null)
                    {
                        result = await uniwork.Update<TransferBoxEntity>(a => a.F_TransferCode == temp.F_TransferBoxCode && a.F_TransferState == 3, a => new TransferBoxEntity
                        {
                            F_TransferState = 0,
                        });
                    }
                }
            }
            outputTemp = await uniwork.Insert(outputTemp);
            foreach (var item in consumeList)
            {
                item.F_OutPutId = outputTemp.F_Id;
            }
            await uniwork.Insert(consumeList);
            await uniwork.Delete<ReadyTransferBoxEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_EqpId == entity.F_EqpId);
            if (material.F_NeedCheckout == true)
            {
                var check = uniwork.IQueryable<NeedCheckEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_CheckType == 3 && a.F_IsCheck == false).FirstOrDefault();
                if (check != null)
                {
                    throw new Exception($"流转箱编号{entity.F_TransferBoxCode},已有产出检验任务");
                }
                else
                {
                    //创建检验单，创建调度任务
                    check = new NeedCheckEntity();
                    check.F_Id = 0;
                    check.F_SourceId = outputTemp.F_Id.ToString();
                    check.F_CreatorTime = DateTime.Now;
                    check.F_CheckType = 2;
                    check.F_IsCheck = false;
                    check.F_IsNeedTwoCheck = false;
                    check.F_IsTwoCheck = false;
                    check.F_MaterialBatch = outputTemp.F_MaterialBatch;
                    check.F_MaterialCode = outputTemp.F_MaterialCode;
                    check.F_MaterialId = outputTemp.F_MaterialId;
                    check.F_MaterialName = outputTemp.F_MaterialName;
                    check.F_MaterialType = outputTemp.F_MaterialType;
                    check.F_MaterialUnit = outputTemp.F_MaterialUnit;
                    check.F_EqpId = eqp.F_Id;
                    check.F_EqpName = eqp.F_EqpName;
                    check.F_Num = entity.F_Num;
                    check.F_TransferBoxCode = outputTemp.F_TransferBoxCode;
                    ControlJobEntity jobEntity = new ControlJobEntity();
                    jobEntity.F_JobType = 8;
                    jobEntity.F_NeedId = check.F_TransferBoxCode;
                    jobEntity.F_NeedEqpId = outputTemp.F_EqpId;
                    jobEntity.F_Priority = 1;
                    jobEntity.F_NeedNum = entity.F_Num;
                    jobEntity.F_JobCode = "CJ_" + DateTime.Now.ToString("yyyyMMddHHmmss") + 0;
                    jobEntity.F_JobInfo = "常规检验-产出检验," + "流转箱编号为" + check.F_TransferBoxCode + ",物料编号为" + material.F_MaterialCode + ",名称为" + material.F_MaterialName + "的物料进行检验。";
                    jobEntity.F_JobInfo += "数量为" + entity.F_Num;
                    await _jobApp.SubmitForm(jobEntity);
                    await uniwork.Insert(check);
                }
            }
            else
            {
                var job = uniwork.IQueryable<ControlJobEntity>(a => a.F_NeedId == outputTemp.F_TransferBoxCode && a.F_NeedEqpId == outputTemp.F_EqpId && a.F_JobType == 3 && a.F_JobState < 2).FirstOrDefault();
                if (job == null)
                {
                    ControlJobEntity jobEntity = new ControlJobEntity();
                    jobEntity.F_JobType = 3;
                    jobEntity.F_NeedId = entity.F_TransferBoxCode;
                    jobEntity.F_NeedEqpId = outputTemp.F_EqpId;
                    jobEntity.F_NeedNum = outputTemp.F_Num+ scanpreturns;
                    jobEntity.F_Priority = 99;
                    jobEntity.F_JobCode = "CJ_" + DateTime.Now.ToString("yyyyMMddHHmmss") + 0;
                    jobEntity.F_JobInfo = "产出上架,设备为" + outputTemp.F_EqpName + ",流转箱为" + entity.F_TransferBoxCode + "的产出物料进行上架。";
                    jobEntity.F_JobInfo += "数量为" + (outputTemp.F_Num+ scanpreturns);
                    await _jobApp.SubmitForm(jobEntity);
                }
                else
                {
                    job.F_JobInfo = "产出上架,设备为" + outputTemp.F_EqpName + ",流转箱为" + entity.F_TransferBoxCode + "的产出物料进行上架。";
                    job.F_JobInfo += "数量为" + (job.F_NeedNum + outputTemp.F_Num+ scanpreturns);
                    var needtime = await uniwork.FindEntity<ControlJobMustTimeEntity>(a => a.F_JobType == 0);
                    if (needtime != null)
                    {
                        var needTime = DateTime.Now.AddMinutes(needtime.F_NeedTime ?? 0);
                        await uniwork.Update<ControlJobEntity>(a => a.F_Id == job.F_Id, a => new ControlJobEntity
                        {
                            F_JobInfo = job.F_JobInfo,
                            F_NeedNum = a.F_NeedNum + outputTemp.F_Num+ scanpreturns,
                            F_FinishTime = null,
                            F_NeedTime = needTime,
                        });
                    }
                    else
                    {
                        await uniwork.Update<ControlJobEntity>(a => a.F_Id == job.F_Id, a => new ControlJobEntity
                        {
                            F_JobInfo = job.F_JobInfo,
                            F_NeedNum = a.F_NeedNum + outputTemp.F_Num+ scanpreturns,
                            F_FinishTime = null
                        });
                    }
                }
            }
            //增加工单作业数量
            await uniwork.Update<WorkOrderDetailEntity>(a => a.F_Id == order.F_Id, a => new WorkOrderDetailEntity
            {
                F_DoneNum = a.F_DoneNum + entity.F_Num
            });
            var workinote = await uniwork.FindEntity<WorkOrderEntity>(order.F_WorkOrderId);
            //更新工单数量
            if (workinote.F_MaterialId == order.F_MaterialId)
            {
                await uniwork.Update<WorkOrderEntity>(a => a.F_Id == workinote.F_Id, a => new WorkOrderEntity
                {
                    F_DoneNum = a.F_DoneNum + entity.F_Num
                });
                if (!string.IsNullOrEmpty(workinote.F_WorkPlanId))
                {
                    await uniwork.Update<WorkPlanEntity>(a => a.F_Id == workinote.F_WorkPlanId, a => new WorkPlanEntity
                    {
                        F_DoneNum = a.F_DoneNum + entity.F_Num
                    });
                }
            }
            if (uniwork.IQueryable<OutPutInfoEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_IsTemp == true).Select(a => new { a.F_MaterialId, a.F_MaterialBatch }).Distinct().Count() > 1)
            {
                throw new Exception("流转箱不能绑定多种物料,请检查");
            }
            var tempsNum = uniwork.IQueryable<OutPutInfoEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_IsTemp == true).Sum(a => a.F_Num);
            //更新流转箱状态
            var resultId = await uniwork.Update<TransferBoxEntity>(a => a.F_TransferCode == entity.F_TransferBoxCode && a.F_TransferState <= 1&& tempsNum <= a.F_TransferMaxNum, a => new TransferBoxEntity
            {
                F_TransferState = 1
            });
            if (resultId == 0)
            {
                throw new Exception("流转箱产出数量超出限制,请检查");
            }
            if (scanpreturns > 0)
            {
                await uniwork.Update<ScapMaterialReturnEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_MaterialId == entity.F_MaterialId && a.F_IsProduce == true, a => new ScapMaterialReturnEntity
                {
                    F_BackMaterialBatch = entity.F_MaterialBatch,
                });
            }
            uniwork.Commit();
        }
        public async Task OutputMaterialCancle(string code)
        {
            var temps = uniwork.IQueryable<OutPutInfoEntity>(a => a.F_TransferBoxCode == code && a.F_IsTemp==true).ToList();

            if (temps == null||temps.Count()==0)
                throw new Exception($"流转箱编号{code}不存在");
            var material = await uniwork.FindEntity<MaterialEntity>(a => a.F_Id == temps[0].F_MaterialId);
            if (material == null)
                throw new Exception($"物料{temps[0].F_MaterialCode}不存在，请重试");
            int resultId = 0;
            float tempNum = temps.Sum(a => a.F_Num)??0;
            List<long> tempids = temps.Select(a => a.F_Id).ToList();
            var scanpreturns = uniwork.IQueryable<ScapMaterialReturnEntity>(a => a.F_TransferBoxCode == code && a.F_IsProduce == true && a.F_MaterialId == material.F_Id).Sum(a => a.F_Num) ?? 0;
            uniwork.BeginTrans();
            //回退工单作业数量
            var order = uniwork.IQueryable<WorkOrderDetailEntity>(a => a.F_Id == temps[0].F_WorkOrderDetailId).FirstOrDefault();
            resultId = await uniwork.Update<WorkOrderDetailEntity>(a => a.F_Id == temps[0].F_WorkOrderDetailId && a.F_DoneNum - tempNum >= 0, a => new WorkOrderDetailEntity
            {
                F_DoneNum = a.F_DoneNum - tempNum,
            });
            if (resultId <= 0)
            {
                throw new Exception("数量异常，请重新提交");
            }
            var workinote = await uniwork.FindEntity<WorkOrderEntity>(order.F_WorkOrderId);
            //更新工单数量
            if (workinote.F_MaterialId == order.F_MaterialId)
            {
                await uniwork.Update<WorkOrderEntity>(a => a.F_Id == workinote.F_Id, a => new WorkOrderEntity
                {
                    F_DoneNum = a.F_DoneNum - tempNum
                });
                if (!string.IsNullOrEmpty(workinote.F_WorkPlanId))
                {
                    await uniwork.Update<WorkPlanEntity>(a => a.F_Id == workinote.F_WorkPlanId, a => new WorkPlanEntity
                    {
                        F_DoneNum = a.F_DoneNum - tempNum
                    });
                }
            }
            //更新使用记录
            var consumes = uniwork.IQueryable<ConsumeInfoEntity>(a => tempids.Contains(a.F_OutPutId??0)).ToList();
            foreach (var item in consumes)
            {
                var consumenum = item.F_Num;
                var uses = uniwork.IQueryable<EqpMaterialUseEntity>(a => a.F_EqpId == item.F_EqpId && a.F_MaterialId == item.F_MaterialId && a.F_MaterialBatch == item.F_MaterialBatch && a.F_TransferBoxCode == item.F_TransferBoxCode).OrderByDesc(a => a.F_CreatorTime).ToList();
                foreach (var eqpmaterialuse in uses)
                {
                    if (eqpmaterialuse.F_DoneNum >= consumenum)
                    {
                        resultId = await uniwork.Update<EqpMaterialUseEntity>(a => a.F_Id == eqpmaterialuse.F_Id && a.F_DoneNum >= consumenum, a => new EqpMaterialUseEntity
                        {
                            F_DoneNum = a.F_DoneNum - consumenum
                        });
                        if (resultId == 0)
                        {
                            throw new Exception("使用数量已变更，请重试");
                        }
                        consumenum = 0;
                        break;
                    }
                    else
                    {
                        resultId = await uniwork.Update<EqpMaterialUseEntity>(a => a.F_Id == eqpmaterialuse.F_Id && a.F_DoneNum == eqpmaterialuse.F_DoneNum, a => new EqpMaterialUseEntity
                        {
                            F_DoneNum = 0
                        });
                        if (resultId == 0)
                        {
                            throw new Exception("使用数量已变更，请重试");
                        }
                        consumenum = consumenum - eqpmaterialuse.F_DoneNum;
                    }
                }
                if (consumenum != 0)
                {
                    throw new Exception("领用数量不足消耗，请检查");
                }
                await uniwork.Update<TransferBoxEntity>(a => a.F_TransferCode == item.F_TransferBoxCode, a => new TransferBoxEntity
                {
                    F_TransferState = 3,
                });
            }
            //删除消耗记录
            resultId = await uniwork.Delete<ConsumeInfoEntity>(a => tempids.Contains(a.F_OutPutId ?? 0));
            if (resultId != consumes.Count())
            {
                throw new Exception("数量异常，请重试");
            }
            //删除产出记录
            resultId = await uniwork.Delete<OutPutInfoEntity>(a => tempids.Contains(a.F_Id) && a.F_IsTemp == true);
            if (resultId != tempids.Count)
            {
                throw new Exception("数量异常，请重试");
            }
            //删除检验单
            var checks = await uniwork.FindEntity<NeedCheckEntity>(a => a.F_TransferBoxCode == code && a.F_CheckType == 2 && a.F_MaterialBatch == temps[0].F_MaterialBatch && a.F_EqpId == temps[0].F_EqpId);
            if (checks != null)
            {
                var badnum = uniwork.IQueryable<ScapMaterialEntity>(a => a.F_CheckId == checks.F_Id && a.F_IsCheck == true).Sum(a=>a.F_ScapNum)??0;
                await uniwork.Delete<ScapMaterialEntity>(a => a.F_CheckId == checks.F_Id);
                await uniwork.Delete<NeedCheckEntity>(a => a.F_Id == checks.F_Id);
                // 回退工单作业数量
                if (badnum > 0)
                {
                    resultId = await uniwork.Update<WorkOrderDetailEntity>(a => a.F_Id == temps[0].F_WorkOrderDetailId && a.F_BadNum >= badnum, a => new WorkOrderDetailEntity
                    {
                        F_BadNum = a.F_BadNum - badnum,
                    });
                    if (resultId <= 0)
                    {
                        throw new Exception("数量异常，请重新提交");
                    }
                    //更新工单数量
                    if (workinote.F_MaterialId == order.F_MaterialId)
                    {
                        await uniwork.Update<WorkOrderEntity>(a => a.F_Id == workinote.F_Id, a => new WorkOrderEntity
                        {
                            F_BadNum = a.F_BadNum - badnum
                        });
                    }
                }
            }
            //关闭调度任务
            var job = await uniwork.FindEntity<ControlJobEntity>(a => a.F_NeedId == code && a.F_NeedEqpId== temps[0].F_EqpId && (a.F_JobType == 3 || a.F_JobType == 8) && a.F_JobState < 2);
            if (job != null)
            {
                await _jobApp.CloseJob(job.F_Id);
            }
            //更新流转箱状态
            if (scanpreturns == 0)
            {
                resultId = await uniwork.Update<TransferBoxEntity>(a => a.F_TransferCode == code && a.F_TransferState == 1, a => new TransferBoxEntity
                {
                    F_TransferState = 0,
                });
                if (resultId <= 0)
                {
                    throw new Exception("流转箱异常，请重新提交");
                }
            }
            uniwork.Commit();
        }
        public async Task OutputMaterialLocation(OutPutInfoEntity entity)
        {
            //获取物料产出绑定记录
            var outTemps = uniwork.IQueryable<OutPutInfoEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_IsTemp == true).ToList();
            float tempsNum = outTemps.Sum(a => a.F_Num) ?? 0;
            var tempids = outTemps.Select(a => a.F_Id).ToList();
            if (outTemps == null||outTemps.Count()==0)
                throw new Exception($"流转箱{entity.F_TransferBoxCode}绑定物料产出记录不存在！");
            if (outTemps == null)
            {
                throw new Exception($"流转箱{entity.F_TransferBoxCode}没有记录");
            }
            if (uniwork.IQueryable<NeedCheckEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_IsCheck == false).Count() > 0)
            {
                throw new Exception("物料正在检验，无法使用");
            }
            var material = await uniwork.FindEntity<MaterialEntity>(outTemps[0].F_MaterialId);
            var dt = DateTime.Now;
            var scanpreturns = uniwork.IQueryable<ScapMaterialReturnEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_IsProduce == true && a.F_MaterialId == material.F_Id).Sum(a => a.F_Num) ?? 0;
            List<OutPutInfoEntity> entitys = new List<OutPutInfoEntity>();
            //判断流转箱类型和物料、数量是否对应
            if (!locationApp.IsUseLocation(entity.F_LocationCode, material.F_MaterialCode))
            {
                throw new Exception($"库位{entity.F_LocationCode}不可用");
            }
            foreach (var item in outTemps)
			{
                tempsNum -= uniwork.IQueryable<NeedCheckEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_CheckType == 2 && a.F_SourceId == item.F_Id.ToString()).InnerJoin<ScapMaterialEntity>((a, b) => a.F_Id == b.F_CheckId).Select((a, b) => b).Sum(a => a.F_Num) ?? 0;
            }
            tempsNum += scanpreturns;
            //添加物料产出上架记录
            uniwork.BeginTrans();
            await uniwork.Update<OutPutInfoEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_IsTemp == true, a => new OutPutInfoEntity
            {
                F_IsTemp = false,
                F_LocationCode = entity.F_LocationCode,
                F_CreatorTime = dt,
                F_CreatorUserId = currentuser.UserId,
                F_CreatorUserName=currentuser.UserName
            });
            //删除该消耗信息的临时托盘
            var ids = outTemps.Select(a => a.F_Id).ToList();
            var boxlist = uniwork.IQueryable<ConsumeInfoEntity>(a => ids.Contains(a.F_OutPutId??0)).Select(a => a.F_TransferBoxCode).Distinct().ToList();
            await uniwork.Delete<TransferBoxEntity>(a => boxlist.Contains(a.F_TransferCode) && a.F_TransferState == 0 && a.F_IsTemp == true);
            //添加库存信息
            StorageEntity storage = new StorageEntity();
            storage.Create();
            storage.F_EnabledMark = true;
            storage.F_MaterialBatch = outTemps[0].F_MaterialBatch;
            storage.F_MaterialCode = outTemps[0].F_MaterialCode;
            storage.F_MaterialName = outTemps[0].F_MaterialName;
            storage.F_MaterialType = outTemps[0].F_MaterialType;
            storage.F_MaterialUnit = outTemps[0].F_MaterialUnit;
            storage.F_MaterialId = outTemps[0].F_MaterialId;
            storage.F_CreatorTime = outTemps[0].F_BandingTime;
            storage.F_Num = tempsNum;
            storage.F_TransferBoxCode = entity.F_TransferBoxCode;
            storage.F_LocationCode = entity.F_LocationCode;
            storage.F_IsCheckout = true;
            await uniwork.Insert(storage);
            var eqpIds = outTemps.GroupBy(a => a.F_EqpId).Select(a => a.Key).ToList();
			//完成任务
			foreach (var item in eqpIds)
			{
                var job = uniwork.IQueryable<ControlJobEntity>(a => a.F_NeedId == outTemps[0].F_TransferBoxCode && a.F_NeedEqpId == item && a.F_JobType == 3 && a.F_JobState < 2).FirstOrDefault();
                if (job != null)
                {
                    await _jobApp.FinishJob(job.F_Id);
                }
            }
            //更新库位状态
            int resultId = await uniwork.Update<LocationEntity>(a => a.F_LocationCode == entity.F_LocationCode && a.F_LocationState == false, a => new LocationEntity
            {
                F_LocationState = true,
            });
            if (resultId <= 0)
            {
                throw new Exception("库位异常，请重新提交");
            }
            resultId = await uniwork.Update<TransferBoxEntity>(a => a.F_TransferCode == entity.F_TransferBoxCode && a.F_TransferState == 1 && a.F_TransferMaxNum >= tempsNum, a => new TransferBoxEntity
            {
                F_TransferState = 2,
                F_LocationCode = entity.F_LocationCode,
            });
            if (resultId <= 0)
            {
                throw new Exception("流转箱产出数量不正常，请退回后重新操作");
            }
            if (scanpreturns>0)
            {
                await uniwork.Update<ScapMaterialReturnEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_MaterialId == material.F_Id && a.F_IsProduce == true, a => new ScapMaterialReturnEntity
                {
                    F_IsProduce = false
                });
            }
            uniwork.Commit();
        }
        public async Task NeedMaterialJob(string eqpName, string materialCode, float num)
        {
            var eqp = await uniwork.FindEntity<EquipmentEntity>(a => a.F_EqpName == eqpName);
            if (eqp == null)
                throw new Exception($"设备：{eqpName} 不存在！");
            var material = await uniwork.FindEntity<MaterialEntity>(a => a.F_MaterialCode == materialCode);
            if (material == null)
                throw new Exception($"物料编号：{materialCode} 不存在！");
            if (uniwork.IQueryable<ProcessEqpBandingEntity>(a=>a.F_EqpId==eqp.F_Id).InnerJoin<BomFormEntity>((a,b)=>a.F_ProcessId==b.F_ProcessId&&b.F_SonMaterialId==material.F_Id).Select((a,b)=>a).Count() == 0)
			{
                throw new Exception($"物料编号：{materialCode} 不是设备：{eqpName}所需要的物料！");
            }
            uniwork.BeginTrans();
            var usesnum = uniwork.IQueryable<EqpMaterialUseEntity>(a => a.F_EqpId == eqp.F_Id && material.F_Id == a.F_MaterialId && a.F_DoneNum != a.F_Num).Sum(a => a.F_Num - a.F_DoneNum);
            if (uniwork.IQueryable<ControlJobEntity>(a => a.F_NeedEqpId == eqp.F_Id && a.F_NeedId == material.F_Id && a.F_JobState < 2 && a.F_JobType == 0).Count() > 0)
            {
                ControlJobEntity jobEntity = uniwork.IQueryable<ControlJobEntity>(a => a.F_NeedEqpId == eqp.F_Id && a.F_NeedId == material.F_Id && a.F_JobState < 2 && a.F_JobType == 0).FirstOrDefault();
                if (jobEntity.F_NeedNum + num + (usesnum ?? 0) > material.F_ContainerNum * material.F_ReceiveNum)
                    throw new Exception($"任务已下达，请不要重复下达");
                jobEntity.F_JobInfo = "设备领料,设备为" + eqp.F_EqpName + ",物料编号为" + material.F_MaterialCode + ",名称为" + material.F_MaterialName + "的物料进行领料。";
                jobEntity.F_JobInfo += "数量为" + (jobEntity.F_NeedNum+num);
                var resultId= await uniwork.Update<ControlJobEntity>(a => a.F_NeedEqpId == eqp.F_Id && a.F_NeedId == material.F_Id && a.F_JobState < 2 && a.F_JobType == 0&& a.F_NeedNum + num <= material.F_ContainerNum * material.F_ReceiveNum, a => new ControlJobEntity
				{
                    F_JobInfo=jobEntity.F_JobInfo,
                    F_NeedNum = a.F_NeedNum + num,
					F_FinishTime = null,
                    F_CreatorTime = DateTime.Now
				});
                if (resultId==0)
                {
                    throw new Exception($"任务已下达，请不要重复下达");
                }
				//throw new Exception("设备为" + eqp.F_EqpName + ",物料编号为" + material.F_MaterialCode + "的领料任务已存在！");
            }
            else
            {
				if (num + usesnum > material.F_ContainerNum * material.F_ReceiveNum)
					throw new Exception($"领用数量未使用，请不要下达任务");
				//创建任务
				ControlJobEntity jobEntity = new ControlJobEntity();
                jobEntity.F_JobType = 0;
                jobEntity.F_NeedId = material.F_Id;
                jobEntity.F_NeedEqpId = eqp.F_Id;
                jobEntity.F_Priority = 99;
                jobEntity.F_NeedNum = num;
                jobEntity.F_JobCode = "CJ_" + DateTime.Now.ToString("yyyyMMddHHmmss") + 0;
                jobEntity.F_JobInfo = "设备领料,设备为" + eqp.F_EqpName + ",物料编号为" + material.F_MaterialCode + ",名称为" + material.F_MaterialName + "的物料进行领料。";
                jobEntity.F_JobInfo += "数量为" + num;
                await _jobApp.SubmitForm(jobEntity);
            }
            uniwork.Commit();
        }
        public async Task NeedMaterialJob(string eqpId, string materialId)
        {
            var eqp = await uniwork.FindEntity<EquipmentEntity>(eqpId);
            if (eqp == null)
                throw new Exception($"设备：{eqpId} 不存在！");
            var material = await uniwork.FindEntity<MaterialEntity>(materialId);
            if (material == null)
                throw new Exception($"物料编号：{materialId} 不存在！");
            var num = material.F_ContainerNum;
            if (uniwork.IQueryable<ProcessEqpBandingEntity>(a => a.F_EqpId == eqp.F_Id).InnerJoin<BomFormEntity>((a, b) => a.F_ProcessId == b.F_ProcessId && b.F_SonMaterialId == material.F_Id).Select((a, b) => a).Count() == 0)
            {
                throw new Exception($"物料编号：{material.F_MaterialCode} 不是设备：{eqp.F_EqpName}所需要的物料！");
            }
            uniwork.BeginTrans();
            var usesnum = uniwork.IQueryable<EqpMaterialUseEntity>(a => a.F_EqpId == eqp.F_Id && material.F_Id == a.F_MaterialId && a.F_DoneNum != a.F_Num).Sum(a => a.F_Num - a.F_DoneNum);
            if (uniwork.IQueryable<ControlJobEntity>(a => a.F_NeedEqpId == eqp.F_Id && a.F_NeedId == material.F_Id && a.F_JobState < 2 && a.F_JobType == 0).Count() > 0)
            {
                ControlJobEntity jobEntity = uniwork.IQueryable<ControlJobEntity>(a => a.F_NeedEqpId == eqp.F_Id && a.F_NeedId == material.F_Id && a.F_JobState < 2 && a.F_JobType == 0).FirstOrDefault();
                if (jobEntity.F_NeedNum + num + (usesnum ?? 0) > material.F_ContainerNum * material.F_ReceiveNum)
                    throw new Exception($"任务已下达，请不要重复下达");
                jobEntity.F_JobInfo = "设备领料,设备为" + eqp.F_EqpName + ",物料编号为" + material.F_MaterialCode + ",名称为" + material.F_MaterialName + "的物料进行领料。";
                jobEntity.F_JobInfo += "数量为" + (jobEntity.F_NeedNum + num);
                var resultId = await uniwork.Update<ControlJobEntity>(a => a.F_NeedEqpId == eqp.F_Id && a.F_NeedId == material.F_Id && a.F_JobState < 2 && a.F_JobType == 0 && a.F_NeedNum + num <= material.F_ContainerNum * material.F_ReceiveNum, a => new ControlJobEntity
                {
                    F_JobInfo = jobEntity.F_JobInfo,
                    F_NeedNum = a.F_NeedNum + num,
                    F_FinishTime = null,
                    F_CreatorTime = DateTime.Now
                });
                if (resultId == 0)
                {
                    throw new Exception($"任务已下达，请不要重复下达");
                }
                //throw new Exception("设备为" + eqp.F_EqpName + ",物料编号为" + material.F_MaterialCode + "的领料任务已存在！");
            }
            else
            {
                if (num + usesnum > material.F_ContainerNum * material.F_ReceiveNum)
                    throw new Exception($"领用数量未使用，请不要下达任务");
                //创建任务
                ControlJobEntity jobEntity = new ControlJobEntity();
                jobEntity.F_JobType = 0;
                jobEntity.F_NeedId = material.F_Id;
                jobEntity.F_NeedEqpId = eqp.F_Id;
                jobEntity.F_Priority = 99;
                jobEntity.F_NeedNum = num;
                jobEntity.F_JobCode = "CJ_" + DateTime.Now.ToString("yyyyMMddHHmmss") + 0;
                jobEntity.F_JobInfo = "设备领料,设备为" + eqp.F_EqpName + ",物料编号为" + material.F_MaterialCode + ",名称为" + material.F_MaterialName + "的物料进行领料。";
                jobEntity.F_JobInfo += "数量为" + num;
                await _jobApp.SubmitForm(jobEntity);
            }
            uniwork.Commit();
        }

        public async Task NeedMaterialJobAutoSend(string eqpName, string materialCode, float num)
        {
            var eqp = await uniwork.FindEntity<EquipmentEntity>(a => a.F_EqpName == eqpName);
            if (eqp == null)
                throw new Exception($"设备：{eqpName} 不存在！");
            var material = await uniwork.FindEntity<MaterialEntity>(a => a.F_MaterialCode == materialCode);
            if (material == null)
                throw new Exception($"物料编号：{materialCode} 不存在！");
            if (uniwork.IQueryable<ProcessEqpBandingEntity>(a => a.F_EqpId == eqp.F_Id).InnerJoin<BomFormEntity>((a, b) => a.F_ProcessId == b.F_ProcessId && b.F_SonMaterialId == material.F_Id).Select((a, b) => a).Count() == 0)
            {
                throw new Exception($"物料编号：{materialCode} 不是设备：{eqpName}所需要的物料！");
            }
            uniwork.BeginTrans();
            var usesnum = uniwork.IQueryable<EqpMaterialUseEntity>(a => a.F_EqpId == eqp.F_Id && material.F_Id == a.F_MaterialId && a.F_DoneNum != a.F_Num).Sum(a => a.F_Num - a.F_DoneNum);
            if (uniwork.IQueryable<ControlJobEntity>(a => a.F_NeedEqpId == eqp.F_Id && a.F_NeedId == material.F_Id && a.F_JobState < 2 && a.F_JobType == 0).Count() > 0)
            {
                ControlJobEntity jobEntity = uniwork.IQueryable<ControlJobEntity>(a => a.F_NeedEqpId == eqp.F_Id && a.F_NeedId == material.F_Id && a.F_JobState < 2 && a.F_JobType == 0).FirstOrDefault();
                if (jobEntity.F_NeedNum + num + (usesnum ?? 0) > material.F_ContainerNum * material.F_ReceiveNum)
                    throw new Exception($"任务已下达，请不要重复下达");
                jobEntity.F_JobInfo = "设备领料,设备为" + eqp.F_EqpName + ",物料编号为" + material.F_MaterialCode + ",名称为" + material.F_MaterialName + "的物料进行领料。";
                jobEntity.F_JobInfo += "数量为" + (jobEntity.F_NeedNum + num);
                var resultId = await uniwork.Update<ControlJobEntity>(a => a.F_NeedEqpId == eqp.F_Id && a.F_NeedId == material.F_Id && a.F_JobState < 2 && a.F_JobType == 0 && a.F_NeedNum + num <= material.F_ContainerNum * material.F_ReceiveNum, a => new ControlJobEntity
                {
                    F_JobInfo = jobEntity.F_JobInfo,
                    F_NeedNum = a.F_NeedNum + num,
                    F_FinishTime = null,
                    F_CreatorTime = DateTime.Now
                });
                if (resultId == 0)
                {
                    throw new Exception($"任务已下达，请不要重复下达");
                }
                //throw new Exception("设备为" + eqp.F_EqpName + ",物料编号为" + material.F_MaterialCode + "的领料任务已存在！");
            }
            else
            {
                if (num + usesnum > material.F_ContainerNum * material.F_ReceiveNum)
                    throw new Exception($"领用数量未使用，请不要下达任务");
                //创建任务
                ControlJobEntity jobEntity = new ControlJobEntity();
                jobEntity.F_JobType = 0;
                jobEntity.F_NeedId = material.F_Id;
                jobEntity.F_NeedEqpId = eqp.F_Id;
                jobEntity.F_Priority = 99;
                jobEntity.F_NeedNum = num;
                jobEntity.F_JobCode = "CJ_" + DateTime.Now.ToString("yyyyMMddHHmmss") + 0;
                jobEntity.F_JobInfo = "设备领料,设备为" + eqp.F_EqpName + ",物料编号为" + material.F_MaterialCode + ",名称为" + material.F_MaterialName + "的物料进行领料。";
                jobEntity.F_JobInfo += "数量为" + num;
                await _jobApp.SubmitFormAutoSend(jobEntity);
            }
            uniwork.Commit();
        }

        public async Task FinishWorkOrderJob(string eqpName)
        {
            var eqp = await uniwork.FindEntity<EquipmentEntity>(a => a.F_EqpName == eqpName);
            if (eqp == null)
                throw new Exception($"设备{eqpName}不存在，请检查！");

            var details = uniwork.IQueryable<WorkOrderDetailEqpBandingEntity>(a => a.F_EqpId == eqp.F_Id && a.F_IsMaster == true)
                .InnerJoin<WorkOrderDetailEntity>((a, b) => a.F_WorkOrderDetailId == b.F_Id && b.F_WorkOrderState == 1).Select((a, b) => b).ToList();
            var work = await uniwork.FindEntity<WorkOrderEntity>(details[0].F_WorkOrderId);
            int count = 0;
            uniwork.BeginTrans();
            foreach (var item in details)
            {
                var process = uniwork.IQueryable<BomFormEntity>(a => a.F_MaterialId == item.F_MaterialId && a.F_BomType == 1)
                    .InnerJoin<ProcessFlowEntity>((a, b) => a.F_ProcessId == b.F_Id).Select((a, b) => b)
                    .InnerJoin<WorkOrderDetailProcessBandingEntity>((a,b)=>b.F_WorkOrderDetailId==item.F_Id&&a.F_Id==b.F_ProcessId).Select((a,b)=>a)
                    .FirstOrDefault();
                var material = await uniwork.FindEntity<MaterialEntity>(item.F_MaterialId);
                if (uniwork.IQueryable<ControlJobEntity>(a => a.F_NeedId == item.F_Id && a.F_NeedEqpId == eqp.F_Id && a.F_JobState < 2 && a.F_JobType == 6).Count() > 0)
                {
                    throw new Exception("任务已经存在，请确认");
                }
                //创建任务
                ControlJobEntity jobEntity = new ControlJobEntity();
                jobEntity.F_JobType = 6;
                jobEntity.F_NeedId = item.F_Id;
                jobEntity.F_NeedEqpId = eqp.F_Id;
                jobEntity.F_Priority = 1;
                jobEntity.F_JobCode = "CJ_" + DateTime.Now.ToString("yyyyMMddHHmmss") + count;
                count++;
                jobEntity.F_JobInfo = "工单结束,工单号为" + work.F_WorkOrderCode + ",第" + item.F_RunSort + "工序为" + process.F_ProcessFlowName + "物料为" + material.F_MaterialName + "的工单结束作业。";
                await _jobApp.SubmitForm(jobEntity);
            }
            uniwork.Commit();
        }

        public async Task ReturnMaterialJob(string transferCode, string eqpName)
        {
            var use = uniwork.IQueryable<EqpMaterialUseEntity>(a => a.F_TransferBoxCode == transferCode && a.F_EqpName == eqpName).FirstOrDefault();
            if (use == null)
            {
                throw new Exception("设备与工单不符，请确认");
            }
            if (uniwork.IQueryable<ControlJobEntity>(a => a.F_NeedId == transferCode && a.F_NeedEqpId == use.F_EqpId && a.F_JobState < 2 && a.F_JobType == 7).Count() > 0)
            {
                throw new Exception("任务已经存在，请确认");
            }
            //创建任务
            ControlJobEntity jobEntity = new ControlJobEntity();
            jobEntity.F_JobType = 7;
            jobEntity.F_NeedId = transferCode;
            jobEntity.F_NeedEqpId = use.F_EqpId;
            jobEntity.F_Priority = 99;
            jobEntity.F_NeedNum = use.F_Num;
            jobEntity.F_JobCode = "CJ_" + DateTime.Now.ToString("yyyyMMddHHmmss");
            jobEntity.F_JobInfo = "物料退回,设备为" + use.F_EqpName + ",物料编号为" + use.F_MaterialCode + ",名称为" + use.F_MaterialName + "的物料进行退料。";
            jobEntity.F_JobInfo += "数量为" + use.F_Num;
            await _jobApp.SubmitForm(jobEntity,true);
        }
        #endregion

    }
}
