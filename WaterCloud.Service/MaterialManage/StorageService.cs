using System;
using System.Threading.Tasks;
using System.Collections.Generic;
using WaterCloud.Code;
using Chloe;
using WaterCloud.Domain.MaterialManage;
using WaterCloud.Domain.ProcessManage;
using WaterCloud.Domain.ClassTask;
using WaterCloud.Service.ClassTask;
using WaterCloud.Domain.EquipmentManage;
using System.Net.Http;
using WaterCloud.Domain.QualityManage;
using System.Linq;
using System.IO;
using WaterCloud.Domain.PlanManage;
using WaterCloud.Service.SystemManage;
using WaterCloud.Service.SystemSecurity;
using NPOI.SS.Formula.Functions;

namespace WaterCloud.Service.MaterialManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2020-12-16 13:38
    /// 描 述：出库管理服务类
    /// </summary>
    public class StorageService : DataFilterService<StorageEntity>, IDenpendency
    {
        private ControlJobService jobApp;
        private LocationService locationApp;
        private ItemsDataService itemsApp;
        private BusinessLogService _logApp;
		public StorageService(IDbContext context, IHttpClientFactory httpClientFactory) : base(context)
        {
            jobApp = new ControlJobService(context, httpClientFactory);
            locationApp = new LocationService(context);
			itemsApp = new ItemsDataService(context);
            _logApp = new BusinessLogService(context);
		}
        #region 获取数据
        public async Task<List<StorageEntity>> GetList(string keyword = "")
        {
            var data = repository.IQueryable();
            if (!string.IsNullOrEmpty(keyword))
            {
                data = data.Where(t => t.F_LocationCode.Contains(keyword) || t.F_TransferBoxCode.Contains(keyword) || t.F_MaterialName.Contains(keyword) || t.F_MaterialCode.Contains(keyword) || t.F_MaterialBatch.Contains(keyword));
            }
            return data.OrderByDesc(t => t.F_CreatorTime).ToList();
        }

        public async Task<List<StorageEntity>> GetLookList(string keyword = "")
        {
            var query = repository.IQueryable().Where(a => a.F_IsCheckout == true);
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(t => t.F_LocationCode.Contains(keyword) || t.F_TransferBoxCode.Contains(keyword) || t.F_MaterialName.Contains(keyword) || t.F_MaterialCode.Contains(keyword) || t.F_MaterialBatch.Contains(keyword));
            }
            query = GetDataPrivilege("u", "", query);
            return query.OrderByDesc(t => t.F_CreatorTime).ToList();
        }

        public async Task<object> GetEqpScanJson(string keyValue)
        {
            //获取领料申请前3条
            var eqpUseJob = uniwork.IQueryable<ControlJobEntity>(a => a.F_NeedEqpId == keyValue && a.F_JobType == 0 && a.F_JobState < 3).OrderByDesc(a => a.F_CreatorTime).Take(3).ToList();
            foreach (var item in eqpUseJob)
            {
                var material = await uniwork.FindEntity<MaterialEntity>(item.F_NeedId);
                item.F_MaterialName = material.F_MaterialName;
            }
            //设备名称、值班人、产出物料、产量、当前班次
            var eqp = await uniwork.FindEntity<EquipmentEntity>(keyValue);
            var workorders = uniwork.IQueryable<WorkOrderDetailEqpBandingEntity>(a => a.F_EqpId == keyValue).InnerJoin<WorkOrderDetailEntity>((a, b) => a.F_WorkOrderDetailId == b.F_Id && b.F_WorkOrderState == 1)
                                .InnerJoin<MaterialEntity>((a, b, c) => b.F_MaterialId == c.F_Id)
                                .Select((a, b, c) => new
                                {
                                    F_Id = b.F_Id,
                                    F_PlanNum = b.F_PlanNum,
                                    F_DoneNum = b.F_DoneNum,
                                    F_MaterialName = c.F_MaterialName,
                                }).ToList();
            var details = workorders.Select(a => a.F_Id).ToList();
            var materials = workorders.Select(a => a.F_MaterialName).ToList();
            var workusers = uniwork.IQueryable<WorkDetailTimeBandingEntity>(a => details.Contains(a.F_WorkOrderDetailId)).InnerJoin<EqpWorkTimeEntity>((a, b) => a.F_EqpWorkTimeId == b.F_Id).Select((a, b) => b.F_UserName).Distinct().ToList();
            //当前领用物料名称，数量
            var eqpUse = uniwork.IQueryable<EqpMaterialUseEntity>(a => a.F_EqpId == keyValue && a.F_Num != a.F_DoneNum).GroupBy(a => a.F_MaterialName).Select(a => new { a.F_MaterialName, Num = Sql.Sum(a.F_Num - a.F_DoneNum) }).ToList();
            string dateClass = "";
			var classNums = await itemsApp.GetItemList("Mes_ClassNumber");
			var classStartTime = TimeSpan.Parse(classNums.FirstOrDefault().F_Description.Split("-")[0]);
			var tempStartTime = classStartTime.TotalMinutes;
			var tempEndTime = TimeSpan.Parse(classNums[0].F_Description.Split("-")[1]).TotalMinutes;
			var currentTime = DateTime.Now.TimeOfDay;
			var checkdate = DateTime.Now.Date;
			if (classNums.Count == 0)
            {
				dateClass = checkdate.ToString("yyyyMMdd") + classNums[0].F_ItemName;
			}
            else
            {
				if (TimeSpan.Compare(currentTime, classStartTime) < 0)
				{
					checkdate = checkdate.AddDays(-1);
				}
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
					if (checkdate.AddMinutes(tempStartTime) < DateTime.Now && checkdate.AddMinutes(tempEndTime) >= DateTime.Now)
					{
						dateClass = checkdate.ToString("yyyyMMdd") + classNums[i].F_ItemName;
					}
					tempStartTime = tempEndTime;
				}
			}
            var transferbox = uniwork.IQueryable<ReadyTransferBoxEntity>(a => a.F_EqpId == eqp.F_Id).OrderBy(a => a.F_CreatorTime).FirstOrDefault();
            var data = new
            {
                F_EqpName = eqp.F_EqpName,
                eqpUseJob,
                workusers = string.Join(',', workusers),
                eqpUse,
                workorders,
                dateClass,
                transferbox
            };
            //容器产出计数
            return data;
        }

        public async Task<List<StorageOutExtend>> getStorageOutBoard()
        {
            List<StorageOutExtend> list = new List<StorageOutExtend>();
            var materials = uniwork.IQueryable<MaterialEntity>(a => a.F_MaterialType == 2 && a.F_EnabledMark == true && a.F_DeleteMark == false).ToList();
            var cuurentdate = DateTime.Now.Date;
            foreach (var item in materials)
            {
                StorageOutExtend entity = new StorageOutExtend();
                entity.F_MaterialCode = item.F_MaterialCode;
                entity.F_MaterialName = item.F_MaterialName;
                var storage = uniwork.IQueryable<StorageEntity>(a => a.F_MaterialId == item.F_Id).Sum(a => a.F_Num)??0;
                entity.F_Num = storage;
                var outplan0 = uniwork.IQueryable<OutStorageEntity>(a => a.F_MaterialId == item.F_Id && a.F_OutStorageState < 2&&a.F_PlanTime== cuurentdate).Sum(a => a.F_Num - a.F_DoneNum) ?? 0;
                entity.field0 = outplan0;
                var outplan1= uniwork.IQueryable<OutStorageEntity>(a => a.F_MaterialId == item.F_Id && a.F_OutStorageState < 2 && a.F_PlanTime == cuurentdate.AddDays(1) && a.F_IsUserEdit == true).Sum(a => a.F_Num - a.F_DoneNum) ?? 0;
                entity.field1 = outplan1;
                var outplan2 = uniwork.IQueryable<OutStorageEntity>(a => a.F_MaterialId == item.F_Id && a.F_OutStorageState < 2 && a.F_PlanTime == cuurentdate.AddDays(2) && a.F_IsUserEdit == true).Sum(a => a.F_Num - a.F_DoneNum) ?? 0;
                entity.field2 = outplan2;
                var outplan3 = uniwork.IQueryable<OutStorageEntity>(a => a.F_MaterialId == item.F_Id && a.F_OutStorageState < 2 && a.F_PlanTime == cuurentdate.AddDays(3) && a.F_IsUserEdit == true).Sum(a => a.F_Num - a.F_DoneNum) ?? 0;
                entity.field3 = outplan3;
                var outplan4 = uniwork.IQueryable<OutStorageEntity>(a => a.F_MaterialId == item.F_Id && a.F_OutStorageState < 2 && a.F_PlanTime == cuurentdate.AddDays(4) && a.F_IsUserEdit == true).Sum(a => a.F_Num - a.F_DoneNum) ?? 0;
                entity.field4 = outplan4;
                var outplan5 = uniwork.IQueryable<OutStorageEntity>(a => a.F_MaterialId == item.F_Id && a.F_OutStorageState < 2 && a.F_PlanTime == cuurentdate.AddDays(5) && a.F_IsUserEdit == true).Sum(a => a.F_Num - a.F_DoneNum) ?? 0;
                entity.field5 = outplan5;
                var outplan6 = uniwork.IQueryable<OutStorageEntity>(a => a.F_MaterialId == item.F_Id && a.F_OutStorageState < 2 && a.F_PlanTime == cuurentdate.AddDays(6) && a.F_IsUserEdit == true).Sum(a => a.F_Num - a.F_DoneNum) ?? 0;
                entity.field6 = outplan6;
                var outplan7 = uniwork.IQueryable<OutStorageEntity>(a => a.F_MaterialId == item.F_Id && a.F_OutStorageState < 2 && a.F_PlanTime == cuurentdate.AddDays(7) && a.F_IsUserEdit == true).Sum(a => a.F_Num - a.F_DoneNum) ?? 0;
                entity.field7 = outplan7;
                list.Add(entity);
            }
            return list.OrderBy(a => a.F_MaterialCode).ToList() ;
        }

        public async Task<List<StorageEntity>> GetLookList(SoulPage<StorageEntity> pagination, string keyword = "", string id = "")
        {
            //获取数据权限
            var query = repository.IQueryable();
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(t => t.F_LocationCode.Contains(keyword) || t.F_TransferBoxCode.Contains(keyword) || t.F_MaterialName.Contains(keyword) || t.F_MaterialCode.Contains(keyword) || t.F_MaterialBatch.Contains(keyword));
            }
            if (!string.IsNullOrEmpty(id))
            {
                query = query.Where(u => u.F_Id == id);
            }
            query = GetDataPrivilege("u", "", query);
            return await repository.OrderList(query, pagination);
        }

        public async Task<StorageEntity> GetTransferInfo(string transferBoxCode)
        {
            var data = repository.IQueryable(a => a.F_TransferBoxCode == transferBoxCode && a.F_IsCheckout == true && a.F_EnabledMark == true && a.F_Num > 0).FirstOrDefault();
            return data;
        }

        public async Task<StorageEntity> GetStorageByOutStorage(string keyValue)
        {
            var outNote = await uniwork.FindEntity<OutStorageEntity>(a => a.F_OutStorageCode == keyValue);
            var data = repository.IQueryable(a => a.F_MaterialId == outNote.F_MaterialId && a.F_IsCheckout == true && a.F_EnabledMark == true && a.F_Num > 0).OrderBy(a => a.F_CreatorTime).FirstOrDefault();
            return data;
        }

        public async Task<StorageEntity> GetForm(string keyValue)
        {
            var data = await repository.FindEntity(keyValue);
            return data;
        }
        public async Task<List<StorageEntity>> GetStorageByMaterial(string code, string eqpName, bool isAll = false)
        {
            var outinfos = uniwork.IQueryable<OutStorageInfoEntity>(a => a.F_IsTemp == true).Select(a => a.F_TransferBoxCode).ToList();
            var realStorage = uniwork.IQueryable<StorageEntity>(a => a.F_MaterialCode == code && a.F_IsCheckout == true && !outinfos.Contains(a.F_TransferBoxCode)).OrderBy(a => a.F_MaterialBatch.Substring(4)).ToList();
            if (realStorage == null || realStorage.Count() == 0)
            {
                return realStorage;
            }
            var id = realStorage.OrderBy(a => a.F_CreatorTime).ToList()[0].F_MaterialId;
            var creatorTime = ((DateTime)realStorage[0].F_CreatorTime).Date;
            if (string.IsNullOrEmpty(eqpName))
            {
                return realStorage;
            }
            realStorage = realStorage.Where(a => a.F_CreatorTime >= creatorTime && a.F_CreatorTime < creatorTime.AddDays(1)).OrderBy(a => a.F_LocationCode).ToList();
            //根据设备获取工单,需要的物料
            var eqp = await uniwork.FindEntity<EquipmentEntity>(a => a.F_EqpName == eqpName);
            //是否不需要先出
            var area = uniwork.IQueryable<LocationEntity>(a => a.F_LocationCode == realStorage[0].F_LocationCode).InnerJoin<AreaEntity>((a, b) => a.F_AreaCode == b.F_AreaCode).Select((a, b) => b).FirstOrDefault();
            if ((area != null && area.F_NeedRule == false) || isAll)
            {
                realStorage = uniwork.IQueryable<StorageEntity>(a => a.F_MaterialCode == code && a.F_IsCheckout == true).OrderBy(a => a.F_LocationCode).ToList();
            }
            var work1 = uniwork.IQueryable<WorkOrderDetailEqpBandingEntity>(a => a.F_EqpId == eqp.F_Id)
                .InnerJoin<WorkOrderDetailEntity>((a, b) => a.F_WorkOrderDetailId == b.F_Id && b.F_WorkOrderState == 1).Select((a,b)=>b);
                
            var work=work1.InnerJoin<WorkOrderDetailProcessBandingEntity>((a, b) => a.F_Id == b.F_WorkOrderDetailId)
                .InnerJoin<BomFormEntity>((a, b, c) => a.F_MaterialId == c.F_MaterialId&&c.F_ProcessId==b.F_ProcessId && c.F_BomType == 1 && c.F_SonMaterialId == id)
                .InnerJoin<ProcessFlowEntity>((a, b, c, d) => c.F_ProcessId == d.F_Id)
                .InnerJoin<WorkOrderEntity>((a, b, c, d, e) => a.F_WorkOrderId == e.F_Id)
                .Select((a, b, c, d, e) => new WorkOrderDetailEntity
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
                    F_PlanNum = a.F_PlanNum,
                    F_PlanStartTime = a.F_PlanStartTime,
                    F_RunSort = a.F_RunSort,
                    F_SonMaterialId = c.F_SonMaterialId,
                    F_SonNum = a.F_PlanNum * c.F_Num,
                    F_WorkOrderId = a.F_WorkOrderId,
                    F_WorkOrderState = a.F_WorkOrderState,
                    F_ProcessId = c.F_ProcessId,
                    F_ProcessName = d.F_ProcessFlowName,
                    F_WorkOrderCode = e.F_WorkOrderCode
                }).FirstOrDefault();
            if (work == null)
            {
                throw new Exception("该设备不需要此物料");
            }
            //是否多工序作业
            if (work.F_RunSort != 1)
            {
                if (uniwork.IQueryable<OutPutInfoEntity>(a => a.F_WorkOrderId == work.F_WorkOrderId && a.F_MaterialId == id && a.F_IsTemp != true).Count() > 0)
                {
                    realStorage = uniwork.IQueryable<OutPutInfoEntity>(a => a.F_WorkOrderId == work.F_WorkOrderId && a.F_MaterialId == id && a.F_IsTemp != true)
                        .InnerJoin<StorageEntity>((a, b) => a.F_MaterialId == b.F_MaterialId
                        && a.F_MaterialBatch == b.F_MaterialBatch).Select((a, b) => b).OrderBy(a => a.F_LocationCode).ToList();
                    //按规则只取最先批次
                    if (area == null || area.F_NeedRule == true || isAll == false)
                    {
                        var first = realStorage.FirstOrDefault();
                        var firstTime = ((DateTime)first.F_CreatorTime).Date;
                        realStorage = realStorage.Where(a => creatorTime >= firstTime && creatorTime < firstTime.AddDays(1)).OrderBy(a => a.F_LocationCode).ToList();
                    }
                }
            }
            foreach (var item in realStorage)
            {
                item.F_AreaCode = area.F_AreaCode;
            }
            return realStorage;
        }

        public async Task<StorageEntity> GetLookForm(object keyValue)
        {
            var data = await repository.FindEntity(keyValue);
            return GetFieldsFilterData(data);
        }

        public async Task<List<MaterialEntity>> GetCurrentClassNumStorage()
        {
            DateTime checkdate = DateTime.Now.Date;
            DateTime starttime = DateTime.Now.Date;
            DateTime endtime = DateTime.Now.Date;
            string classNum = "";
			var classNums = await itemsApp.GetItemList("Mes_ClassNumber");
			var classStartTime = TimeSpan.Parse(classNums.FirstOrDefault().F_Description.Split("-")[0]);
			var classEndTime = TimeSpan.Parse(classNums.FirstOrDefault().F_Description.Split("-")[1]);
			var tempStartTime = classStartTime.TotalMinutes;
			var tempEndTime = classEndTime.TotalMinutes;
			var currentTime = DateTime.Now.TimeOfDay;
            if (classNums.Count() == 1)
            {
				classNum = classNums[0].F_ItemCode;
				starttime = checkdate.AddMinutes(tempStartTime);
				endtime = checkdate.AddMinutes(tempEndTime);
			}
            else
            {
				if (TimeSpan.Compare(currentTime, classStartTime) < 0)
				{
					checkdate = DateTime.Now.Date.AddDays(-1);
				}
				tempEndTime = tempStartTime;
				for (int j = 0; j < classNums.Count(); j++)
				{
					var startTime = TimeSpan.Parse(classNums[j].F_Description.Split("-")[0]).TotalMinutes;
					var endTime = TimeSpan.Parse(classNums[j].F_Description.Split("-")[1]).TotalMinutes;
					if (endTime > startTime)
					{
						tempEndTime += endTime - startTime;
					}
					else
					{
						tempEndTime += endTime + 24 * 60 - startTime;
					}
					if (DateTime.Now > checkdate.AddMinutes(tempStartTime) && DateTime.Now <= checkdate.AddMinutes(tempEndTime))
					{
						classNum = classNums[j].F_ItemCode;
						starttime = checkdate.AddMinutes(tempStartTime);
						endtime = checkdate.AddMinutes(tempEndTime);
						break;
					}
					tempStartTime = tempEndTime;
				}
			}
			var materials = uniwork.GetDbContext().Query<MaterialEntity>(a => a.F_EnabledMark == true && a.F_DeleteMark == false).OrderByDesc(a => a.F_MaterialType).ToList();
            foreach (var item in materials)
            {
                var CurrentNum = uniwork.IQueryable<StorageEntity>(a => a.F_MaterialId == item.F_Id && a.F_IsCheckout != false).Sum(a => a.F_Num) ?? 0;
                var instoragenote = uniwork.IQueryable<InStorageEntity>(a => a.F_MaterialId == item.F_Id && a.F_PlanTime == checkdate && a.F_InStorageState <= 2).ToList();
                var innoteids = instoragenote.Select(a => a.F_Id).ToList();
                var tempinstorage = uniwork.IQueryable<InStorageInfoEntity>(a => a.F_IsTemp == true && a.F_MaterialId == item.F_Id && !innoteids.Contains(a.F_InStorageId)).Sum(a => a.F_Num) ?? 0;
                var outstoragenote = uniwork.IQueryable<OutStorageEntity>(a => a.F_MaterialId == item.F_Id && a.F_PlanTime == checkdate && a.F_OutStorageState <= 2).ToList();
                var tempoutput = uniwork.IQueryable<OutPutInfoEntity>(a => a.F_IsTemp == true && a.F_MaterialId == item.F_Id).Sum(a => a.F_Num) ?? 0;
                item.F_Num = CurrentNum + tempinstorage + tempoutput;
                item.F_StorageNum = CurrentNum + tempinstorage + tempoutput;
                item.F_ReturnNum = 0;
                item.F_DoneNum = 0;
            }
            return materials;
        }

        #endregion
        public async Task DoChange()
        {
            var datetime = DateTime.Now.Date.AddDays(-1);
            datetime = datetime.AddHours(8);
            var storages = uniwork.IQueryable<StorageEntity>(a => a.F_MaterialCode == "B01000004" && a.F_CreatorTime<= datetime).ToList();
            foreach (var item in storages)
            {
                StorageChangeInfoEntity entity = new StorageChangeInfoEntity();
                entity.F_TransferBoxCode = item.F_TransferBoxCode;
                entity.F_Num = item.F_Num;
                entity.F_ChangeType = 2;
                await StorageChange(entity, false);
            }
        }

        #region 提交数据
        public async Task StorageChange(StorageChangeInfoEntity entity, bool isAttr = true, bool IsCommit = true)
        {
            var storage = uniwork.IQueryable<StorageEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode).FirstOrDefault();
            if (storage == null)
            {
                throw new Exception($"流转箱{entity.F_TransferBoxCode}没有库存");
            }
            if (entity.F_ChangeType == 0 && entity.F_NewTransferBoxCode == entity.F_TransferBoxCode)
            {
                throw new Exception("流转箱不能相同数量");
            }
            if (entity.F_ChangeType == 1 && entity.F_NewLocationCode == storage.F_LocationCode)
            {
                throw new Exception("转移前后库位号不能相同");
            }
            if (uniwork.IQueryable<NeedCheckEntity>(a => a.F_TransferBoxCode == entity.F_TransferBoxCode && a.F_IsCheck == false).Count() > 0)
            {
                throw new Exception("物料正在检验，无法使用");
            }
            if (entity.F_ChangeType == 2)
            {
                entity.F_NewLocationCode = null;
                entity.F_NewTransferBoxCode = null;
            }
            entity.F_Id = 0;
            entity.F_StorageId = storage.F_Id;
            entity.F_CreatorUserId = currentuser.UserCode;
            entity.F_CreatorUserName = currentuser.UserName;
            entity.F_CreatorTime = DateTime.Now;
            entity.F_EnabledMark = true;
            entity.F_MaterialCode = storage.F_MaterialCode;
            entity.F_MaterialName = storage.F_MaterialName;
            entity.F_MaterialType = storage.F_MaterialType;
            entity.F_MaterialUnit = storage.F_MaterialUnit;
            entity.F_MaterialBatch = storage.F_MaterialBatch;
            entity.F_MaterialId = storage.F_MaterialId;
            entity.F_LocationCode = storage.F_LocationCode;
            entity.F_TransferBoxCode = storage.F_TransferBoxCode;
            if (entity.F_Num > storage.F_Num)
            {
                throw new Exception("转移数量超出库存数量，请核对数量");
            }
            //流转箱判断
            bool isMerge = false;
            var newstorage = new StorageEntity();
            if (!string.IsNullOrEmpty(entity.F_NewTransferBoxCode))
            {
                var transfer = uniwork.IQueryable<TransferBoxEntity>(a => a.F_TransferCode == entity.F_NewTransferBoxCode && a.F_EnabledMark == true && a.F_DeleteMark == false).FirstOrDefault();
                if (transfer != null)
                {
                    if (transfer.F_TransferType != "0" && uniwork.IQueryable<TransferTypeMaterialBandingEntity>(a => a.F_TransferType == transfer.F_TransferType && a.F_MaterialId == storage.F_MaterialId).Count() == 0)
                    {
                        throw new Exception($"流转箱{entity.F_NewTransferBoxCode}不可用");
                    }
                    if (transfer.F_TransferState == 0)
                    {
                        if (transfer.F_TransferMaxNum < entity.F_Num)
                        {
                            throw new Exception($"流转箱{entity.F_NewTransferBoxCode}不可用");
                        }
                    }
                    else if (transfer.F_TransferState == 2)
                    {
                        newstorage = await uniwork.FindEntity<StorageEntity>(a => a.F_TransferBoxCode == entity.F_NewTransferBoxCode && a.F_MaterialId == storage.F_MaterialId && a.F_MaterialBatch == storage.F_MaterialBatch && a.F_IsCheckout == storage.F_IsCheckout);
                        if (newstorage == null)
                        {
                            throw new Exception($"流转箱{entity.F_NewTransferBoxCode}不可用");
                        }
                        if (transfer.F_TransferMaxNum < entity.F_Num + newstorage.F_Num)
                        {
                            throw new Exception($"流转箱{entity.F_NewTransferBoxCode}可存放数量超出");
                        }
                        isMerge = true;
                    }
                    else
                    {
                        throw new Exception($"流转箱{entity.F_NewTransferBoxCode}不可用");
                    }
                }

            }
            if (isAttr)
            {
                if (!string.IsNullOrEmpty(entity.F_NewLocationCode) && entity.F_NewLocationCode != entity.F_LocationCode && !IsUseLocation(entity.F_NewLocationCode, entity.F_MaterialCode))
                {
                    throw new Exception($"库位{entity.F_NewLocationCode}不可用");
                }
            }
            else
            {
                if (!string.IsNullOrEmpty(entity.F_NewLocationCode) && entity.F_NewLocationCode != entity.F_LocationCode && uniwork.IQueryable<LocationEntity>(a => a.F_LocationCode == entity.F_NewLocationCode && a.F_LocationState == true).Count() > 0)
                {
                    throw new Exception($"库位{entity.F_NewLocationCode}不可用");
                }
            }
            if (!isMerge)
            {
                newstorage.Create();
                newstorage.F_CreatorTime = storage.F_CreatorTime;
                newstorage.F_Num = entity.F_Num;
                newstorage.F_MaterialCode = storage.F_MaterialCode;
                newstorage.F_MaterialName = storage.F_MaterialName;
                newstorage.F_MaterialType = storage.F_MaterialType;
                newstorage.F_MaterialUnit = storage.F_MaterialUnit;
                newstorage.F_MaterialBatch = storage.F_MaterialBatch;
                newstorage.F_MaterialId = storage.F_MaterialId;
                newstorage.F_EnabledMark = true;
                newstorage.F_IsCheckout = storage.F_IsCheckout;
                newstorage.F_TransferBoxCode = string.IsNullOrEmpty(entity.F_NewTransferBoxCode) ? entity.F_TransferBoxCode : entity.F_NewTransferBoxCode;
            }
            else
            {
                newstorage.F_Num += entity.F_Num;
            }
            newstorage.F_LocationCode = string.IsNullOrEmpty(entity.F_NewLocationCode) ? entity.F_LocationCode : entity.F_NewLocationCode;
            uniwork.BeginTrans();
            //更新库存
            int resultId = await uniwork.Update<StorageEntity>(a => a.F_Id == storage.F_Id && a.F_Num >= entity.F_Num, a => new StorageEntity
            {
                F_Num = a.F_Num - entity.F_Num
            });
            if (resultId == 0)
            {
                throw new Exception("库存更新失败");
            }
            //删除0的库存
            resultId = await uniwork.Delete<StorageEntity>(a => a.F_Id == storage.F_Id && a.F_Num == 0);
            //更新库位状态
            //更新流转箱状态
            if (resultId == 0)
            {
                if (!string.IsNullOrEmpty(entity.F_NewTransferBoxCode))
                {
                    await uniwork.Update<TransferBoxEntity>(a => a.F_TransferCode == entity.F_NewTransferBoxCode, a => new TransferBoxEntity
                    {
                        F_TransferState = 2,
                        F_LocationCode = string.IsNullOrEmpty(entity.F_NewLocationCode) ? entity.F_LocationCode : entity.F_NewLocationCode
                    });
                }
                if (!string.IsNullOrEmpty(entity.F_NewLocationCode))
                {
                    await uniwork.Update<LocationEntity>(a => a.F_LocationCode == entity.F_NewLocationCode, a => new LocationEntity
                    {
                        F_LocationState = true
                    });
                }
            }
            else
            {
                //修改流转箱状态
                await uniwork.Update<TransferBoxEntity>(a => a.F_TransferCode == entity.F_TransferBoxCode, a => new TransferBoxEntity
                {
                    F_TransferState = 0,
                    F_LocationCode = null
                });
                //如果临时容器转移，删除临时托盘
                if (newstorage.F_TransferBoxCode != storage.F_TransferBoxCode)
                {
                    await uniwork.Delete<TransferBoxEntity>(a => a.F_TransferCode == entity.F_TransferBoxCode && a.F_TransferState == 0 && a.F_IsTemp == true);
                }
                await uniwork.Update<LocationEntity>(a => a.F_LocationCode == entity.F_LocationCode, a => new LocationEntity
                {
                    F_LocationState = false
                });
                if (storage.F_LocationCode != newstorage.F_LocationCode || storage.F_TransferBoxCode != newstorage.F_TransferBoxCode)
                {
                    await uniwork.Update<TransferBoxEntity>(a => a.F_TransferCode == newstorage.F_TransferBoxCode, a => new TransferBoxEntity
                    {
                        F_TransferState = 2,
                        F_LocationCode = newstorage.F_LocationCode
                    });
                    await uniwork.Update<LocationEntity>(a => a.F_LocationCode == newstorage.F_LocationCode, a => new LocationEntity
                    {
                        F_LocationState = true
                    });
                }
            }
            //增加变动信息
            await uniwork.Insert(entity);
            if (storage.F_LocationCode != newstorage.F_LocationCode || storage.F_TransferBoxCode != newstorage.F_TransferBoxCode)
            {
                //增加库存信息
                if (!isMerge)
                {
                    await uniwork.Insert(newstorage);
                }
                else
                {
                    await uniwork.Update<StorageEntity>(a => a.F_Id == newstorage.F_Id, a => new StorageEntity
                    {
                        F_Num = a.F_Num + entity.F_Num,
                        F_LocationCode = newstorage.F_LocationCode
                    });
                }
            }
            //更新任务
            var job = uniwork.IQueryable<ControlJobEntity>(a => a.F_NeedId == storage.F_Id && a.F_JobType == 4 && a.F_FinishTime == null).FirstOrDefault();
            if (job != null)
            {
                await jobApp.FinishJob(job.F_Id);

            }
            if (IsCommit)
            {
                uniwork.Commit();
                await _logApp.WriteLog(8, "库位调整:物料" + storage.F_MaterialName + "从库位" + entity.F_LocationCode + "转移数量" + (entity.F_Num ?? 0), "", "", storage.F_MaterialName, storage.F_TransferBoxCode, entity.F_Num);
            }
        }

        /// <summary>
        /// 判断库位是否可用
        /// </summary>
        /// <param name="locationCode"></param>
        /// <returns></returns>
        public bool IsUseLocation(string locationCode, string materialCode)
        {
            bool result = false;
            if (!string.IsNullOrEmpty(locationCode))
            {
                var location = uniwork.IQueryable<LocationEntity>(a => a.F_LocationCode == locationCode && a.F_EnabledMark == true && a.F_DeleteMark == false && a.F_LocationState == false).FirstOrDefault();
                if (location != null)
                {
                    var area = uniwork.IQueryable<AreaEntity>(a => a.F_Id == location.F_AreaId).FirstOrDefault();
                    //先用绑定库位，然后使用非绑定库位
                    if (area.F_StackType != true)
                    {
                        var last = uniwork.IQueryable<LocationMaterialBandingEntity>(a => a.F_MaterialCode == materialCode).InnerJoin<LocationEntity>((a, b) => b.F_AreaId == area.F_Id && b.F_EnabledMark == true && b.F_DeleteMark == false && b.F_LocationState == false && a.F_LocationId == b.F_Id).Select((a, b) => b).OrderBy(a => a.F_SortCode).FirstOrDefault();
                        var list = new List<string>();
                        if (last != null)
                        {
                            list = uniwork.IQueryable<LocationMaterialBandingEntity>(a => a.F_MaterialCode == materialCode).InnerJoin<LocationEntity>((a, b) => b.F_AreaId == area.F_Id && b.F_EnabledMark == true && b.F_DeleteMark == false && b.F_LocationState == false && a.F_LocationId == b.F_Id && b.F_SortCode == last.F_SortCode).Select((a, b) => b).Select(a => a.F_LocationCode).ToList();
                        }
                        else
                        {
                            last = uniwork.IQueryable<LocationEntity>(a => a.F_AreaId == area.F_Id && a.F_EnabledMark == true && a.F_DeleteMark == false && a.F_LocationState == false && (a.F_MaterialName == null || a.F_MaterialName == "")).OrderBy(a => a.F_SortCode).FirstOrDefault();
                            list = uniwork.IQueryable<LocationEntity>(a => a.F_AreaId == area.F_Id && a.F_EnabledMark == true && a.F_DeleteMark == false && a.F_LocationState == false && (a.F_MaterialName == null || a.F_MaterialName == "") && a.F_SortCode == last.F_SortCode).OrderBy(a => a.F_SortCode).Select(a => a.F_LocationCode).ToList();
                        }
                        if (list.Contains(locationCode))
                        {
                            result = true;
                        }
                    }
                    else
                    {
                        var list = uniwork.IQueryable<LocationEntity>(a => a.F_AreaId == area.F_Id && a.F_EnabledMark == true && a.F_DeleteMark == false && a.F_LocationState == false).InnerJoin<LocationMaterialBandingEntity>((a, b) => a.F_Id == b.F_LocationId && b.F_MaterialCode == materialCode).Select((a, b) => a.F_LocationCode).ToList();
                        if (list != null && list.Count() > 0)
                        {
                            if (list.Contains(locationCode))
                            {
                                result = true;
                            }
                        }
                        else
                        {
                            list = uniwork.IQueryable<LocationEntity>(a => a.F_AreaId == area.F_Id && a.F_EnabledMark == true && a.F_DeleteMark == false && a.F_LocationState == false && (a.F_MaterialName == null || a.F_MaterialName == "")).Select(a => a.F_LocationCode).ToList();
                            if (list.Contains(locationCode))
                            {
                                result = true;
                            }
                        }
                    }
                }
            }
            return result;
        }
        public async Task<List<StorageEntity>> CheckFile(string fileFullName)
        {
            if (!FileHelper.IsExcel(fileFullName))
            {
                throw new Exception("文件不是有效的Excel文件!");
            }
            //文件解析
            var list = new ExcelHelper<StorageEntity>().ImportFromExcel(fileFullName);
            //删除文件
            File.Delete(fileFullName);
            foreach (var item in list)
            {
                item.Create();
                item.F_EnabledMark = true;
                List<string> str = new List<string>();
                if (string.IsNullOrEmpty(item.F_TransferBoxCode))
                {
                    item.F_EnabledMark = false;
                    item.ErrorMsg = "流转箱编号不存在";
                    continue;
                }
                else if (repository.IQueryable(a => a.F_TransferBoxCode == item.F_TransferBoxCode).Count() > 0 || list.Where(a => a.F_TransferBoxCode == item.F_TransferBoxCode).Count() > 1)
                {
                    str.Add("编号重复");
                    item.F_EnabledMark = false;
                }
                if (string.IsNullOrEmpty(item.F_MaterialCode))
                {
                    item.F_EnabledMark = false;
                    str.Add("物料编号不存在");
                    continue;
                }
                if (item.F_Num == null)
                {
                    item.F_EnabledMark = false;
                    str.Add("数量不存在");
                    continue;
                }
                if (item.F_EnabledMark == false)
                {
                    item.ErrorMsg = string.Join(',', str.ToArray());
                }
            }
            return list;
        }

        public async Task ImportForm(List<StorageEntity> filterList)
        {
            uniwork.BeginTrans();
            int count = 1;
            var now = DateTime.Now.ToString("yyyyMMddHHmmss");
            now = "TMP-" + now.Substring(2, now.Length - 2);
            foreach (var item in filterList)
            {
                //创建对象
                item.Create();
                var transfer = uniwork.IQueryable<TransferBoxEntity>(a => a.F_TransferCode == item.F_TransferBoxCode).FirstOrDefault();
                if (transfer == null)
                {
                    transfer = new TransferBoxEntity();
                    transfer.Create();
                    transfer.F_TransferCode = item.F_TransferBoxCode;
                    transfer.F_TransferMaxNum = item.F_Num;
                    transfer.F_IsTemp = true;
                    transfer.F_TransferState = 0;
                    transfer.F_TransferType = "0";
                    transfer.F_DeleteMark = false;
                    transfer.F_EnabledMark = true;
                    await uniwork.Insert(transfer);
                }
                if (transfer.F_TransferState != 0)
                {
                    throw new Exception($"流转箱{item.F_TransferBoxCode}已被使用");
                }
                var material = uniwork.IQueryable<MaterialEntity>(a => a.F_MaterialCode == item.F_MaterialCode).FirstOrDefault();
                if (material == null)
                {
                    throw new Exception($"物料编号{item.F_MaterialCode}不存在物料");
                }
                if (count > 99)
                {
                    item.F_MaterialBatch = now + count;
                }
                else if (count > 9)
                {
                    item.F_MaterialBatch = now + "0" + count;
                }
                else
                {
                    item.F_MaterialBatch = now + "00" + count;
                }
                count++;
                item.F_MaterialCode = material.F_MaterialCode;
                item.F_MaterialId = material.F_Id;
                item.F_MaterialName = material.F_MaterialName;
                item.F_MaterialType = material.F_MaterialType;
                item.F_MaterialUnit = material.F_MaterialUnit;
                item.F_IsCheckout = true;
                if (string.IsNullOrEmpty(item.F_LocationCode))
                {
                    var areaCode = "";
                    if (item.F_MaterialType == 0)
                    {
                        areaCode = uniwork.IQueryable<AreaEntity>(a => a.F_AreaType == 0).FirstOrDefault().F_AreaCode;
                    }
                    else
                    {
                        areaCode = uniwork.IQueryable<BomFormEntity>(a => a.F_MaterialId == item.F_MaterialId)
                                   .InnerJoin<ProcessEqpBandingEntity>((a, b) => a.F_ProcessId == b.F_ProcessId)
                                   .InnerJoin<EqpAreaBandingEntity>((a, b, c) => b.F_EqpId == c.F_EqpId)
                                   .InnerJoin<AreaEntity>((a, b, c, d) => c.F_AreaId == d.F_Id).Select((a, b, c, d) => d.F_AreaCode).FirstOrDefault();
                    }
                    var locations = await locationApp.GetLocationList("", areaCode, material.F_MaterialCode);
                    var location = locations.Where(a => a.F_LocationState == false).FirstOrDefault();
                    item.F_LocationCode = location.F_LocationCode;
                }
                //创建入库记录
                InStorageInfoEntity info = new InStorageInfoEntity();
                info.F_Id = 0;
                info.F_CreatorTime = DateTime.Now;
                info.F_BandingTime = DateTime.Now;
                info.F_CreatorUserId = currentuser.UserId;
                info.F_BandingUserId = currentuser.UserId;
                info.F_BandingUserName = currentuser.UserName;
                info.F_CreatorUserName = currentuser.UserName;
                info.F_Num = item.F_Num;
                info.F_LocationCode = item.F_LocationCode;
                info.F_IsTemp = false;
                info.F_MaterialBatch = item.F_MaterialBatch;
                info.F_MaterialCode = item.F_MaterialCode;
                info.F_MaterialId = item.F_MaterialId;
                info.F_MaterialName = item.F_MaterialName;
                info.F_MaterialType = item.F_MaterialType;
                info.F_MaterialUnit = item.F_MaterialUnit;
                info.F_TransferBoxCode = item.F_TransferBoxCode;
                info.F_EnabledMark = true;
                info.F_OriginalBatch = item.F_MaterialBatch;
                await uniwork.Insert(info);
                await uniwork.Insert(item);
                await uniwork.Update<TransferBoxEntity>(a => a.F_TransferCode == item.F_TransferBoxCode, a => new TransferBoxEntity
                {
                    F_TransferState = 2,
                    F_LocationCode = item.F_LocationCode,
                });
                var result = await uniwork.Update<LocationEntity>(a => a.F_LocationCode == item.F_LocationCode && a.F_LocationState == false, a => new LocationEntity
                {
                    F_LocationState = true,
                });
                if (result == 0)
                {
                    throw new Exception("库位已被使用，请检查");
                }
            }
            uniwork.Commit();
        }
        #endregion

    }
}
