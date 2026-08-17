using System;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;
using WaterCloud.Code;
using Chloe;
using WaterCloud.Domain.QualityManage;
using WaterCloud.Service.SystemManage;
using WaterCloud.Domain.MaterialManage;
using WaterCloud.Domain.ClassTask;
using WaterCloud.Service.ClassTask;
using System.Net.Http;
using WaterCloud.Domain.ProcessManage;
using WaterCloud.Service.SystemSecurity;

namespace WaterCloud.Service.QualityManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2021-05-21 13:50
    /// 描 述：质检单管理服务类
    /// </summary>
    public class NeedCheckService : DataFilterService<NeedCheckEntity>, IDenpendency
    {
        private ItemsDataService itemsApp;
        private ControlJobService jobApp;
        private BusinessLogService _logApp;
        public NeedCheckService(IDbContext context, IHttpClientFactory httpClientFactory) : base(context)
        {
            itemsApp = new ItemsDataService(context);
            jobApp = new ControlJobService(context, httpClientFactory);
            _logApp = new BusinessLogService(context);
        }
        #region 获取数据
        public async Task<List<NeedCheckEntity>> GetList(string keyword = "")
        {
            var data = repository.IQueryable();
            if (!string.IsNullOrEmpty(keyword))
            {
                data = data.Where(t => t.F_TransferBoxCode.Contains(keyword)
                || t.F_MaterialCode.Contains(keyword)
                || t.F_MaterialName.Contains(keyword));
            }
            return data.OrderByDesc(t => t.F_CreatorTime).ToList();
        }

        public async Task<List<NeedCheckEntity>> GetLookList(string keyword = "")
        {
            var query = repository.IQueryable();
            if (!string.IsNullOrEmpty(keyword))
            {
                //此处需修改
                query = query.Where(t => t.F_TransferBoxCode.Contains(keyword)
                || t.F_MaterialCode.Contains(keyword)
                || t.F_MaterialName.Contains(keyword));
            }
            //权限过滤
            query = GetDataPrivilege("u", "", query);
            return query.OrderByDesc(t => t.F_CreatorTime).ToList();
        }

        public async Task<List<NeedCheckEntity>> GetLookList(SoulPage<NeedCheckEntity> pagination, int timetype, string keyword = "", long id = 0)
        {
            //反格式化显示只能用"等于"，其他不支持
            Dictionary<string, Dictionary<string, string>> dic = new Dictionary<string, Dictionary<string, string>>();
            var setList = await itemsApp.GetItemList("Mes_MaterialType");
            Dictionary<string, string> stateTemp = new Dictionary<string, string>();
            foreach (var item in setList)
            {
                stateTemp.Add(item.F_ItemName, item.F_ItemCode);
            }
            dic.Add("F_MaterialType", stateTemp);
            Dictionary<string, string> typeTemp = new Dictionary<string, string>();
            var typeList = await itemsApp.GetItemList("Mes_CheckType");
            foreach (var item in typeList)
            {
                typeTemp.Add(item.F_ItemName, item.F_ItemCode);
            }
            dic.Add("F_CheckType", typeTemp);
            pagination = ChangeSoulData(dic, pagination);
            DateTime startTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate();
            DateTime endTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate().AddDays(1);
            switch (timetype)
            {
                case 1:
                    break;
                case 2:
                    startTime = startTime.AddDays(-7);
                    break;
                case 3:
                    startTime = startTime.AddMonths(-1);
                    break;
                case 4:
                    startTime = startTime.AddMonths(-2);
                    break;
                default:
                    break;
            }
            var query = IQueryable().Where(t => t.F_CreatorTime >= startTime && t.F_CreatorTime <= endTime);
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(t => t.F_TransferBoxCode.Contains(keyword)
                || t.F_MaterialCode.Contains(keyword)
                || t.F_MaterialName.Contains(keyword));
            }
            if (id != 0)
            {
                query = query.Where(u => u.F_Id == id);
            }
            //权限过滤
            query = GetDataPrivilege("u", "", query);
            return await repository.OrderList(query, pagination);
        }

        private IQuery<NeedCheckEntity> IQueryable()
        {
            var storage = uniwork.IQueryable<ScapMaterialEntity>().GroupBy(a => a.F_CheckId).Select(a => new { a.F_CheckId, F_ScapNum = Sql.Sum(a.F_ScapNum), F_ReturnNum = Sql.Sum(a.F_ReturnNum), F_OtherNum = Sql.Sum(a.F_Num - a.F_ScapNum - a.F_ReturnNum), F_Num = Sql.Sum(a.F_Num) });
            var query = repository.IQueryable().LeftJoin(storage, (a, b) => a.F_Id == b.F_CheckId)
                .Select((a, b) => new NeedCheckEntity
                {
                    F_CheckType = a.F_CheckType,
                    F_CreatorTime = a.F_CreatorTime,
                    F_Description = a.F_Description,
                    F_EqpId = a.F_EqpId,
                    F_EqpName = a.F_EqpName,
                    F_FinishTime = a.F_FinishTime,
                    F_Id = a.F_Id,
                    F_IsCheck = a.F_IsCheck,
                    F_IsNeedTwoCheck = a.F_IsNeedTwoCheck,
                    F_IsTwoCheck = a.F_IsTwoCheck,
                    F_LocationCode = a.F_LocationCode,
                    F_MaterialBatch = a.F_MaterialBatch,
                    F_MaterialCode = a.F_MaterialCode,
                    F_MaterialId = a.F_MaterialId,
                    F_MaterialName = a.F_MaterialName,
                    F_MaterialType = a.F_MaterialType,
                    F_MaterialUnit = a.F_MaterialUnit,
                    F_Num = a.F_Num,
                    F_OtherNum = b.F_CheckId == null ? 0 : b.F_OtherNum,
                    F_ReturnNum = b.F_CheckId == null ? 0 : b.F_ReturnNum,
                    F_ScapNum = b.F_CheckId == null ? 0 : b.F_ScapNum,
                    F_SourceId = a.F_SourceId,
                    F_TransferBoxCode = a.F_TransferBoxCode,
                    F_TwoFinishTime = a.F_TwoFinishTime
                });
            return query;
        }

        public async Task<List<NeedCheckEntity>> GetUnCheckList()
        {
            var data = repository.IQueryable(a => a.F_IsCheck == false);
            return data.OrderBy(t => t.F_Id).ToList();
        }

        public async Task<NeedCheckEntity> GetForm(long keyValue)
        {
            var data = await repository.FindEntity(keyValue);
            return data;
        }
        public async Task<NeedCheckEntity> GetUnDoneForm(string code)
        {
            var data = await repository.FindEntity(a => a.F_TransferBoxCode == code && a.F_IsCheck == false);
            if (data != null)
            {
                data.F_ScapNum = uniwork.IQueryable<ScapMaterialEntity>(a => a.F_CheckId == data.F_Id).Sum(a => a.F_Num) ?? 0;
            }
            return data;
        }
        public async Task<NeedCheckEntity> GetInfoByCode(string code)
        {
            //判断物料是否设备需要
            var storage = uniwork.IQueryable<StorageEntity>(a => a.F_TransferBoxCode == code).FirstOrDefault();
            NeedCheckEntity entity = new NeedCheckEntity();
            //区分库存检验和入库绑定检验和产出绑定检验、物料领用检验
            if (storage != null)
            {
                entity.F_MaterialBatch = storage.F_MaterialBatch;
                entity.F_MaterialCode = storage.F_MaterialCode;
                entity.F_MaterialName = storage.F_MaterialName;
                entity.F_CheckType = 3;
                entity.F_Num = storage.F_Num;
                return entity;
            }
            var inbanding = uniwork.IQueryable<InStorageInfoEntity>(a => a.F_TransferBoxCode == code && a.F_IsTemp == true).ToList();
            if (inbanding != null && inbanding.Count() > 0)
            {
                entity = inbanding[0].MapTo<NeedCheckEntity>();
                entity.F_CheckType = 0;
                entity.F_Num = inbanding.Sum(a => a.F_Num);
                foreach (var item in inbanding)
                {
                    entity.F_Num -= uniwork.IQueryable<NeedCheckEntity>(a => a.F_TransferBoxCode == item.F_TransferBoxCode && a.F_CheckType == 0 && a.F_SourceId == item.F_Id.ToString()).InnerJoin<ScapMaterialEntity>((a, b) => a.F_Id == b.F_CheckId).Select((a, b) => b).Sum(a => a.F_Num) ?? 0;
                }
                return entity;
            }
            var outbanding = uniwork.IQueryable<OutPutInfoEntity>(a => a.F_TransferBoxCode == code && a.F_IsTemp == true).ToList();
            if (outbanding != null && outbanding.Count() > 0)
            {
                entity = outbanding[0].MapTo<NeedCheckEntity>();
                entity.F_CheckType = 2;
                entity.F_Num = outbanding.Sum(a => a.F_Num);
                foreach (var item in outbanding)
                {
                    entity.F_Num -= uniwork.IQueryable<NeedCheckEntity>(a => a.F_TransferBoxCode == item.F_TransferBoxCode && a.F_CheckType == 2 && a.F_SourceId == item.F_Id.ToString()).InnerJoin<ScapMaterialEntity>((a, b) => a.F_Id == b.F_CheckId).Select((a, b) => b).Sum(a => a.F_Num) ?? 0;
                }
                var otherdata = uniwork.IQueryable<ScapMaterialReturnEntity>(a => a.F_IsProduce == true && a.F_MaterialId == entity.F_MaterialId && a.F_TransferBoxCode == code).ToList();
                if (otherdata.Count > 0)
                {
                    entity.F_Num += otherdata.Sum(a => a.F_Num) ?? 0;
                }
                return entity;
            }
            var eqpUse = uniwork.IQueryable<EqpMaterialUseEntity>(a => a.F_TransferBoxCode == code && a.F_Num != a.F_DoneNum).FirstOrDefault();
            if (eqpUse != null)
            {
                entity = eqpUse.MapTo<NeedCheckEntity>();
                entity.F_CheckType = 1;
                entity.F_Num = eqpUse.F_Num - eqpUse.F_DoneNum;
                return entity;
            }
            throw new Exception($"流转箱{code}不存在物料，请检查");
        }
        #endregion

        public async Task<NeedCheckEntity> GetLookForm(long keyValue)
        {
            var data = await repository.FindEntity(keyValue);
            if (data != null)
            {
                data.list = uniwork.IQueryable<ScapMaterialEntity>(a => a.F_CheckId == data.F_Id).ToList();
                data.F_ScapNum = data.list.Sum(a => a.F_Num);
            }
            return GetFieldsFilterData(data);
        }
        public async Task<NeedCheckEntity> GetCheckEntity(string code, string sourceId, int? type = null)
        {
            var data = repository.IQueryable(a => a.F_TransferBoxCode == code && a.F_SourceId == sourceId).ToList();
            if (type != null)
            {
                data = repository.IQueryable(a => a.F_TransferBoxCode == code && a.F_SourceId == sourceId && a.F_CheckType == type).ToList();
            }
            var entity = data.FirstOrDefault();
            if (data != null && data.Count() > 0)
            {
                var ids = data.Select(a => a.F_Id).ToList();
                entity.list = uniwork.IQueryable<ScapMaterialEntity>(a => ids.Contains(a.F_CheckId ?? 0)).ToList();
                entity.F_ScapNum = entity.list.Sum(a => a.F_Num);
            }
            return entity;
        }

        public async Task<List<MaterialEntity>> GetBadMaterialList(string keyword)
        {
            var storage = uniwork.IQueryable<ScapMaterialEntity>().GroupBy(a => a.F_MaterialId).Select(a => new { a.F_MaterialId, F_ScapNum = Sql.Sum(a.F_ScapNum), F_ReturnNum = Sql.Sum(a.F_ReturnNum), F_OtherNum = Sql.Sum(a.F_Num - a.F_ScapNum - a.F_ReturnNum), F_Num = Sql.Sum(a.F_Num) });
            var list = uniwork.IQueryable<MaterialEntity>(a => a.F_DeleteMark == false && a.F_EnabledMark == true).LeftJoin(storage, (a, b) => b.F_MaterialId == a.F_Id)
                .Select((a, b) => new MaterialEntity
                {
                    F_Id = a.F_Id,
                    F_Customer = a.F_Customer,
                    F_CreatorTime = a.F_CreatorTime,
                    F_MaterialBy = a.F_MaterialBy,
                    F_MaterialCode = a.F_MaterialCode,
                    F_MaterialDescription = a.F_MaterialDescription,
                    F_MaterialName = a.F_MaterialName,
                    F_MaterialPic = a.F_MaterialPic,
                    F_MaterialSize = a.F_MaterialSize,
                    F_MaterialType = a.F_MaterialType,
                    F_MaterialUnit = a.F_MaterialUnit,
                    F_ModelRefer = a.F_ModelRefer,
                    F_WarmNum = a.F_WarmNum,
                    F_Num = b.F_MaterialId == null ? 0 : b.F_Num,
                    F_StorageNum = b.F_MaterialId == null ? 0 : b.F_OtherNum,
                    F_DoneNum = b.F_MaterialId == null ? 0 : b.F_ScapNum,
                    F_ReturnNum = b.F_MaterialId == null ? 0 : b.F_ReturnNum
                });
            if (!string.IsNullOrEmpty(keyword))
            {
                list = list.Where(u => u.F_MaterialCode.Contains(keyword) || u.F_MaterialName.Contains(keyword));
            }
            return list.OrderBy("F_MaterialType desc,F_MaterialCode asc").ToList();
        }
        #region 提交数据
        public async Task SubmitForm(NeedCheckEntity entity, long keyValue)
        {
            if (keyValue == 0)
            {
                //初始值添加
                entity.F_Id = 0;
                entity.F_CreatorTime = DateTime.Now;
                await repository.Insert(entity);
            }
            else
            {
                //此处需修改
                entity.F_Id = keyValue;
                await repository.Update(entity);
            }
        }

        public async Task DeleteForm(string keyValue)
        {
            var ids = keyValue.Split(',');
            await repository.Delete(t => ids.Contains(t.F_Id.ToString()));
        }
        //检验申请
        public async Task NeedCheckJob(string transferBoxCode)
        {
            //区分入库检验、领用检验、产出检验、库存检验和出库检验
            NeedCheckEntity check = uniwork.IQueryable<NeedCheckEntity>(a => a.F_TransferBoxCode == transferBoxCode && a.F_IsCheck == false).FirstOrDefault();
            if (check != null)
            {
                throw new Exception($"流转箱编号{transferBoxCode},已有检验任务");
            }
            uniwork.BeginTrans();
            var inbanding = uniwork.IQueryable<InStorageInfoEntity>(a => a.F_TransferBoxCode == transferBoxCode && a.F_IsTemp == true).ToList();
            if (inbanding != null && inbanding.Count() > 0)
            {

                //创建入库检验单，创建调度任务
                check = new NeedCheckEntity();
                check.F_Id = 0;
                check.F_SourceId = inbanding[0].F_Id.ToString();
                check.F_CreatorTime = DateTime.Now;
                check.F_CheckType = 0;
                check.F_IsCheck = false;
                check.F_IsNeedTwoCheck = false;
                check.F_IsTwoCheck = false;
                check.F_MaterialBatch = inbanding[0].F_MaterialBatch;
                check.F_MaterialCode = inbanding[0].F_MaterialCode;
                check.F_MaterialId = inbanding[0].F_MaterialId;
                check.F_MaterialName = inbanding[0].F_MaterialName;
                check.F_MaterialType = inbanding[0].F_MaterialType;
                check.F_MaterialUnit = inbanding[0].F_MaterialUnit;
                check.F_TransferBoxCode = transferBoxCode;
                var scapenum = uniwork.IQueryable<NeedCheckEntity>(a => a.F_SourceId == check.F_SourceId && a.F_CheckType == 0 && a.F_TransferBoxCode == check.F_TransferBoxCode)
                    .InnerJoin<ScapMaterialEntity>((a, b) => a.F_Id == b.F_CheckId).Select((a, b) => b).Sum(a => a.F_Num) ?? 0;
                if (scapenum == inbanding.Sum(a => a.F_Num))
                {
                    throw new Exception($"流转箱编号{transferBoxCode}已没有料可以质检");
                }
                check.F_Num = (inbanding.Sum(a => a.F_Num) ?? 0) - scapenum;
                ControlJobEntity jobEntity = new ControlJobEntity();
                jobEntity.F_JobType = 8;
                jobEntity.F_NeedId = check.F_TransferBoxCode;
                jobEntity.F_Priority = 1;
                jobEntity.F_NeedNum = check.F_Num;
                jobEntity.F_JobCode = "CJ_" + DateTime.Now.ToString("yyyyMMddHHmmss") + 0;
                jobEntity.F_JobInfo = "常规检验-入库检验," + "流转箱编号为" + check.F_TransferBoxCode + ",物料编号为" + check.F_MaterialCode + ",名称为" + check.F_MaterialName + "的物料进行检验。";
                jobEntity.F_JobInfo += "数量为" + check.F_Num;
                await jobApp.SubmitForm(jobEntity);
                await uniwork.Insert(check);
                uniwork.Commit();
                return;
            }
            var eqpUse = uniwork.IQueryable<EqpMaterialUseEntity>(a => a.F_TransferBoxCode == transferBoxCode && a.F_Num != a.F_DoneNum).FirstOrDefault();
            if (eqpUse != null)
            {
                //创建领用检验单，创建调度任务
                check = new NeedCheckEntity();
                check.F_Id = 0;
                check.F_SourceId = eqpUse.F_Id.ToString();
                check.F_CreatorTime = DateTime.Now;
                check.F_CheckType = 1;
                check.F_IsCheck = false;
                check.F_IsNeedTwoCheck = false;
                check.F_IsTwoCheck = false;
                check.F_EqpId = eqpUse.F_EqpId;
                check.F_EqpName = eqpUse.F_EqpName;
                check.F_MaterialBatch = eqpUse.F_MaterialBatch;
                check.F_MaterialCode = eqpUse.F_MaterialCode;
                check.F_MaterialId = eqpUse.F_MaterialId;
                check.F_MaterialName = eqpUse.F_MaterialName;
                check.F_MaterialType = eqpUse.F_MaterialType;
                check.F_MaterialUnit = eqpUse.F_MaterialUnit;
                check.F_Num = eqpUse.F_Num - eqpUse.F_DoneNum;
                check.F_TransferBoxCode = transferBoxCode;
                ControlJobEntity jobEntity = new ControlJobEntity();
                jobEntity.F_JobType = 8;
                jobEntity.F_NeedId = check.F_TransferBoxCode;
                jobEntity.F_NeedEqpId = check.F_EqpId;
                jobEntity.F_Priority = 1;
                jobEntity.F_NeedNum = check.F_Num;
                jobEntity.F_JobCode = "CJ_" + DateTime.Now.ToString("yyyyMMddHHmmss") + 0;
                jobEntity.F_JobInfo = "常规检验-领用检验," + "设备名称为" + check.F_EqpName + ",流转箱编号为" + check.F_TransferBoxCode + ",物料编号为" + check.F_MaterialCode + ",名称为" + check.F_MaterialName + "的物料进行检验。";
                jobEntity.F_JobInfo += "数量为" + check.F_Num;
                await jobApp.SubmitForm(jobEntity);
                await uniwork.Insert(check);
                uniwork.Commit();
                return;
            }
            var outbanding = uniwork.IQueryable<OutPutInfoEntity>(a => a.F_TransferBoxCode == transferBoxCode && a.F_IsTemp == true).ToList();
            if (outbanding != null && outbanding.Count() > 0)
            {
                //关闭上架任务
                var job = uniwork.IQueryable<ControlJobEntity>(a => a.F_NeedId == transferBoxCode && a.F_NeedEqpId == outbanding[0].F_EqpId && a.F_JobType == 3 && a.F_JobState < 2).FirstOrDefault();
                if (job != null)
                {
                    await jobApp.CloseJob(job.F_Id);
                }
                //创建产出检验单，创建调度任务
                check = new NeedCheckEntity();
                check.F_Id = 0;
                check.F_SourceId = outbanding[0].F_Id.ToString();
                check.F_CreatorTime = DateTime.Now;
                check.F_CheckType = 2;
                check.F_IsCheck = false;
                check.F_IsNeedTwoCheck = false;
                check.F_IsTwoCheck = false;
                check.F_EqpId = outbanding[0].F_EqpId;
                check.F_EqpName = outbanding[0].F_EqpName;
                check.F_MaterialBatch = outbanding[0].F_MaterialBatch;
                check.F_MaterialCode = outbanding[0].F_MaterialCode;
                check.F_MaterialId = outbanding[0].F_MaterialId;
                check.F_MaterialName = outbanding[0].F_MaterialName;
                check.F_MaterialType = outbanding[0].F_MaterialType;
                check.F_MaterialUnit = outbanding[0].F_MaterialUnit;
                check.F_TransferBoxCode = transferBoxCode;
                var scapenum = uniwork.IQueryable<NeedCheckEntity>(a => a.F_SourceId == check.F_SourceId && a.F_CheckType == 2 && a.F_TransferBoxCode == check.F_TransferBoxCode)
                     .InnerJoin<ScapMaterialEntity>((a, b) => a.F_Id == b.F_CheckId).Select((a, b) => b).Sum(a => a.F_Num) ?? 0;
                if (scapenum == outbanding.Sum(a => a.F_Num))
                {
                    throw new Exception($"流转箱编号{transferBoxCode}已没有料可以质检");
                }
                check.F_Num = outbanding.Sum(a => a.F_Num) ?? 0;
                ControlJobEntity jobEntity = new ControlJobEntity();
                jobEntity.F_JobType = 8;
                jobEntity.F_NeedId = check.F_TransferBoxCode;
                jobEntity.F_NeedEqpId = check.F_EqpId;
                jobEntity.F_Priority = 1;
                jobEntity.F_NeedNum = check.F_Num;
                jobEntity.F_JobCode = "CJ_" + DateTime.Now.ToString("yyyyMMddHHmmss") + 0;
                jobEntity.F_JobInfo = "常规检验-产出检验," + "设备名称为" + check.F_EqpName + ",流转箱编号为" + check.F_TransferBoxCode + ",物料编号为" + check.F_MaterialCode + ",名称为" + check.F_MaterialName + "的物料进行检验。";
                jobEntity.F_JobInfo += "数量为" + check.F_Num;
                await jobApp.SubmitForm(jobEntity);
                await uniwork.Insert(check);
                uniwork.Commit();
                return;
            }
            var outstorage = uniwork.IQueryable<OutStorageInfoEntity>(a => a.F_TransferBoxCode == transferBoxCode && a.F_IsTemp == true).ToList();
            if (outstorage != null && outstorage.Count() > 0)
            {
                //关闭装箱任务
                var job = await uniwork.FindEntity<ControlJobEntity>(a => a.F_NeedId == transferBoxCode && a.F_JobType == 11 && a.F_JobState < 2);
                if (job != null)
                {
                    await jobApp.CloseJob(job.F_Id);
                }
                //创建产出检验单，创建调度任务
                check = new NeedCheckEntity();
                check.F_Id = 0;
                check.F_SourceId = outbanding[0].F_Id.ToString();
                check.F_CreatorTime = DateTime.Now;
                check.F_CheckType = 4;
                check.F_IsCheck = false;
                check.F_IsNeedTwoCheck = false;
                check.F_IsTwoCheck = false;
                check.F_MaterialBatch = outstorage[0].F_MaterialBatch;
                check.F_MaterialCode = outstorage[0].F_MaterialCode;
                check.F_MaterialId = outstorage[0].F_MaterialId;
                check.F_MaterialName = outstorage[0].F_MaterialName;
                check.F_MaterialType = outstorage[0].F_MaterialType;
                check.F_MaterialUnit = outstorage[0].F_MaterialUnit;
                check.F_Num = outstorage.Sum(a => a.F_Num) ?? 0;
                check.F_TransferBoxCode = transferBoxCode;
                ControlJobEntity jobEntity = new ControlJobEntity();
                jobEntity.F_JobType = 8;
                jobEntity.F_NeedId = check.F_TransferBoxCode;
                jobEntity.F_NeedEqpId = check.F_EqpId;
                jobEntity.F_Priority = 1;
                jobEntity.F_NeedNum = check.F_Num;
                jobEntity.F_JobCode = "CJ_" + DateTime.Now.ToString("yyyyMMddHHmmss") + 0;
                jobEntity.F_JobInfo = "常规检验-出库检验," + "设备名称为" + check.F_EqpName + ",流转箱编号为" + check.F_TransferBoxCode + ",物料编号为" + check.F_MaterialCode + ",名称为" + check.F_MaterialName + "的物料进行检验。";
                jobEntity.F_JobInfo += "数量为" + check.F_Num;
                await jobApp.SubmitForm(jobEntity);
                await uniwork.Insert(check);
                uniwork.Commit();
                return;
            }
            var storage = uniwork.IQueryable<StorageEntity>(a => a.F_TransferBoxCode == transferBoxCode).FirstOrDefault();
            if (storage != null)
            {
                //创建库存检验单，创建调度任务
                check = new NeedCheckEntity();
                check.F_Id = 0;
                check.F_SourceId = storage.F_Id.ToString();
                check.F_CreatorTime = DateTime.Now;
                check.F_CheckType = 3;
                check.F_IsCheck = false;
                check.F_IsNeedTwoCheck = false;
                check.F_IsTwoCheck = false;
                check.F_MaterialBatch = storage.F_MaterialBatch;
                check.F_MaterialCode = storage.F_MaterialCode;
                check.F_MaterialId = storage.F_MaterialId;
                check.F_MaterialName = storage.F_MaterialName;
                check.F_MaterialType = storage.F_MaterialType;
                check.F_MaterialUnit = storage.F_MaterialUnit;
                check.F_Num = storage.F_Num;
                check.F_TransferBoxCode = transferBoxCode;
                ControlJobEntity jobEntity = new ControlJobEntity();
                jobEntity.F_JobType = 8;
                jobEntity.F_NeedId = check.F_TransferBoxCode;
                jobEntity.F_Priority = 1;
                jobEntity.F_NeedNum = check.F_Num;
                jobEntity.F_JobCode = "CJ_" + DateTime.Now.ToString("yyyyMMddHHmmss") + 0;
                jobEntity.F_JobInfo = "常规检验-库存检验," + "流转箱编号为" + check.F_TransferBoxCode + ",物料编号为" + check.F_MaterialCode + ",名称为" + check.F_MaterialName + "的物料进行检验。";
                jobEntity.F_JobInfo += "数量为" + check.F_Num;
                await jobApp.SubmitForm(jobEntity);
                await uniwork.Insert(check);
                await uniwork.Update<StorageEntity>(a => a.F_Id == storage.F_Id, a => new StorageEntity
                {
                    F_IsCheckout = false
                });
                uniwork.Commit();
                return;
            }
            uniwork.Rollback();
            throw new Exception($"流转箱{transferBoxCode}不存在物料，请检查");
        }
        //检验提交
        public async Task CheckoutForm(string transferBoxCode, bool isCommit = true)
        {
            var check = await repository.FindEntity(a => a.F_TransferBoxCode == transferBoxCode && a.F_IsCheck == false);
            check.F_IsCheck = true;
            check.F_FinishTime = DateTime.Now;
            var scaps = uniwork.IQueryable<ScapMaterialEntity>(a => a.F_CheckId == check.F_Id).ToList();
            uniwork.BeginTrans();
            int numcount = 0;
            var count = scaps.Sum(a => a.F_Num);
            check.F_IsNeedTwoCheck = true;
            if (count > check.F_Num)
            {
                throw new Exception($"可疑数量不准确，请检查");
            }
            switch (check.F_CheckType)
            {
                case 0:
                    if (count != check.F_Num)
                    {
                        var job0 = uniwork.IQueryable<ControlJobEntity>(a => a.F_NeedId == check.F_TransferBoxCode && a.F_JobType == 10 && a.F_JobState < 2).FirstOrDefault();
                        if (job0 != null)
                        {
                            await uniwork.Update<ControlJobEntity>(a => a.F_NeedId == check.F_TransferBoxCode && a.F_JobType == 10 && a.F_JobState < 2, a => new ControlJobEntity
                            {
                                F_NeedNum = check.F_Num - count,
                            });
                        }
                        else
                        {
                            ControlJobEntity jobEntity = new ControlJobEntity();
                            jobEntity.F_JobType = 10;
                            jobEntity.F_NeedId = check.F_TransferBoxCode;
                            jobEntity.F_Priority = 1;
                            jobEntity.F_NeedNum = check.F_Num - count;
                            jobEntity.F_JobCode = "CJ_" + DateTime.Now.ToString("yyyyMMddHHmmss") + numcount;
                            jobEntity.F_JobInfo = "入库上架," + "流转箱编号为" + check.F_TransferBoxCode + ",物料编号为" + check.F_MaterialCode + ",名称为" + check.F_MaterialName + "的物料进行上架。";
                            jobEntity.F_JobInfo += "数量为" + jobEntity.F_NeedNum;
                            await jobApp.SubmitForm(jobEntity);
                            numcount++;
                        }
                    }
                    else
                    {
                        await uniwork.Update<InStorageInfoEntity>(a => a.F_TransferBoxCode == check.F_TransferBoxCode && a.F_IsTemp == true, a => new InStorageInfoEntity
                        {
                            F_IsTemp = false,
                            F_LocationCode = null,
                            F_CreatorTime = DateTime.Now,
                            F_CreatorUserId = currentuser.UserId,
                            F_CreatorUserName = currentuser.UserName
                        });
                        //更新容器
                        await uniwork.Update<TransferBoxEntity>(a => a.F_TransferCode == check.F_TransferBoxCode && a.F_TransferState == 1, a => new TransferBoxEntity
                        {
                            F_TransferState = 0

                        });
                        //删除临时容器
                        await uniwork.Delete<TransferBoxEntity>(a => a.F_TransferCode == check.F_TransferBoxCode && a.F_TransferState == 0 && a.F_IsTemp == true);
                    }
                    break;
                case 1:
                    await uniwork.Update<EqpMaterialUseEntity>(a => a.F_Id.ToString() == check.F_SourceId && a.F_Num >= a.F_DoneNum + count, a => new EqpMaterialUseEntity
                    {
                        F_DoneNum = a.F_DoneNum + count
                    });
                    if (count == check.F_Num)
                    {
                        //更新容器
                        await uniwork.Update<TransferBoxEntity>(a => a.F_TransferCode == check.F_TransferBoxCode && a.F_TransferState == 3, a => new TransferBoxEntity
                        {
                            F_TransferState = 0

                        });
                        //删除临时容器
                        await uniwork.Delete<TransferBoxEntity>(a => a.F_TransferCode == check.F_TransferBoxCode && a.F_TransferState == 0 && a.F_IsTemp == true);
                    }
                    break;
                case 2:
                    if (count != check.F_Num)
                    {
                        var job0 = uniwork.IQueryable<ControlJobEntity>(a => a.F_NeedId == check.F_TransferBoxCode && a.F_JobType == 3 && a.F_JobState < 2).FirstOrDefault();
                        if (job0 != null)
                        {
                            await uniwork.Update<ControlJobEntity>(a => a.F_NeedId == check.F_TransferBoxCode && a.F_JobType == 3 && a.F_JobState < 2, a => new ControlJobEntity
                            {
                                F_NeedNum = check.F_Num - count,
                            });
                        }
                        else
                        {
                            ControlJobEntity jobEntity = new ControlJobEntity();
                            jobEntity.F_JobType = 3;
                            jobEntity.F_NeedId = check.F_TransferBoxCode;
                            jobEntity.F_NeedEqpId = check.F_EqpId;
                            jobEntity.F_Priority = 1;
                            jobEntity.F_NeedNum = check.F_Num - count;
                            jobEntity.F_JobCode = "CJ_" + DateTime.Now.ToString("yyyyMMddHHmmss") + numcount;
                            jobEntity.F_JobInfo = "产出上架,设备为" + check.F_EqpName + ",流转箱为" + check.F_TransferBoxCode + "的产出物料进行上架。";
                            jobEntity.F_JobInfo += "数量为" + jobEntity.F_NeedNum;
                            await jobApp.SubmitForm(jobEntity);
                            numcount++;
                            //更新绑定时间，防止被自动退回
                            await uniwork.Update<OutPutInfoEntity>(a => a.F_TransferBoxCode == check.F_TransferBoxCode && a.F_IsTemp == true, a => new OutPutInfoEntity
                            {
                                F_CreatorTime = DateTime.Now
                            });
                        }
                    }
                    else
                    {
                        await uniwork.Update<OutPutInfoEntity>(a => a.F_TransferBoxCode == check.F_TransferBoxCode && a.F_IsTemp == true, a => new OutPutInfoEntity
                        {
                            F_IsTemp = false,
                            F_LocationCode = null,
                            F_CreatorTime = DateTime.Now,
                            F_CreatorUserId = currentuser.UserId,
                            F_CreatorUserName = currentuser.UserName
                        });
                        //更新容器
                        await uniwork.Update<TransferBoxEntity>(a => a.F_TransferCode == check.F_TransferBoxCode && a.F_TransferState == 1, a => new TransferBoxEntity
                        {
                            F_TransferState = 0

                        });
                        //删除临时容器
                        await uniwork.Delete<TransferBoxEntity>(a => a.F_TransferCode == check.F_TransferBoxCode && a.F_TransferState == 0 && a.F_IsTemp == true);
                    }
                    break;
                case 3:
                    //减少库存
                    await uniwork.Update<StorageEntity>(a => a.F_TransferBoxCode == check.F_TransferBoxCode && a.F_Num >= count, a => new StorageEntity
                    {
                        F_Num = a.F_Num - count,
                        F_IsCheckout = true
                    });
                    if (uniwork.IQueryable<StorageEntity>(a => a.F_TransferBoxCode == check.F_TransferBoxCode && a.F_Num == 0).Count() > 0)
                    {
                        await uniwork.Delete<StorageEntity>(a => a.F_TransferBoxCode == check.F_TransferBoxCode);
                        var transfer = await uniwork.FindEntity<TransferBoxEntity>(a => a.F_TransferCode == check.F_TransferBoxCode);
                        //更新容器
                        await uniwork.Update<TransferBoxEntity>(a => a.F_TransferCode == check.F_TransferBoxCode && a.F_TransferState == 1, a => new TransferBoxEntity
                        {
                            F_TransferState = 0,
                            F_LocationCode = null
                        });
                        await uniwork.Update<LocationEntity>(a => a.F_LocationCode == transfer.F_LocationCode, a => new LocationEntity
                        {
                            F_LocationState = false

                        });
                        //删除临时容器
                        await uniwork.Delete<TransferBoxEntity>(a => a.F_TransferCode == check.F_TransferBoxCode && a.F_TransferState == 0 && a.F_IsTemp == true);
                    }
                    break;
                case 4:
                    //减少库存
                    await uniwork.Update<StorageEntity>(a => a.F_TransferBoxCode == check.F_TransferBoxCode && a.F_Num >= count, a => new StorageEntity
                    {
                        F_Num = a.F_Num - count,
                        F_IsCheckout = true
                    });
                    //扣减下架数量
                    var outlog = await uniwork.FindEntity<OutStorageInfoEntity>(a => a.F_TransferBoxCode == check.F_TransferBoxCode && a.F_IsTemp == true);
                    await uniwork.Update<OutStorageInfoEntity>(a => a.F_Id == outlog.F_Id && a.F_IsTemp == true && a.F_Num >= count, a => new OutStorageInfoEntity
                    {
                        F_Num = a.F_Num - count,
                    });

                    await uniwork.Update<OutStorageEntity>(a => a.F_Id == outlog.F_OutStorageId && a.F_DoneNum >= count, a => new OutStorageEntity
                    {
                        F_OutStorageState = 1,
                        F_DoneNum = a.F_DoneNum - count,
                    });
                    //创建装箱任务
                    if (count != check.F_Num)
                    {
                        var job0 = uniwork.IQueryable<ControlJobEntity>(a => a.F_NeedId == check.F_TransferBoxCode && a.F_JobType == 11 && a.F_JobState < 2).FirstOrDefault();
                        if (job0 != null)
                        {
                            await uniwork.Update<ControlJobEntity>(a => a.F_NeedId == check.F_TransferBoxCode && a.F_JobType == 11 && a.F_JobState < 2, a => new ControlJobEntity
                            {
                                F_NeedNum = check.F_Num - count,
                            });
                        }
                        else
                        {
                            ControlJobEntity jobEntity = new ControlJobEntity();
                            jobEntity.F_JobType = 11;
                            jobEntity.F_NeedId = check.F_TransferBoxCode;
                            jobEntity.F_Priority = 1;
                            jobEntity.F_NeedNum = check.F_Num - count;
                            jobEntity.F_JobCode = "CJ_" + DateTime.Now.ToString("yyyyMMddHHmmss") + numcount;
                            jobEntity.F_JobInfo = "出库装箱," + "流转箱编号为" + check.F_TransferBoxCode + ",物料编号为" + check.F_MaterialCode + ",名称为" + check.F_MaterialName + "的物料进行出库。";
                            jobEntity.F_JobInfo += "数量为" + jobEntity.F_NeedNum;
                            await jobApp.SubmitForm(jobEntity);
                            numcount++;
                        }
                    }
                    else
                    {
                        await uniwork.Delete<OutStorageInfoEntity>(a => a.F_Id == outlog.F_Id && a.F_IsTemp == true && a.F_Num == 0);
                        await uniwork.Delete<StorageEntity>(a => a.F_TransferBoxCode == check.F_TransferBoxCode);
                        var transfer = await uniwork.FindEntity<TransferBoxEntity>(a => a.F_TransferCode == check.F_TransferBoxCode);
                        //更新容器
                        await uniwork.Update<TransferBoxEntity>(a => a.F_TransferCode == check.F_TransferBoxCode && a.F_TransferState == 1, a => new TransferBoxEntity
                        {
                            F_TransferState = 0,
                            F_LocationCode = null
                        });
                        await uniwork.Update<LocationEntity>(a => a.F_LocationCode == transfer.F_LocationCode, a => new LocationEntity
                        {
                            F_LocationState = false
                        });
                        //删除临时容器
                        await uniwork.Delete<TransferBoxEntity>(a => a.F_TransferCode == check.F_TransferBoxCode && a.F_TransferState == 0 && a.F_IsTemp == true);
                    }
                    break;
            }
            await repository.Update(check);
            await uniwork.Update<ScapMaterialEntity>(a => a.F_CheckId == check.F_Id, a => new ScapMaterialEntity
            {
                F_IsTemp = false
            });
            foreach (var item in scaps)
            {
                //创建调度任务
                ControlJobEntity jobEntity = new ControlJobEntity();
                jobEntity.F_JobType = 9;
                jobEntity.F_NeedId = item.F_BatchCode;
                jobEntity.F_Priority = 1;
                jobEntity.F_NeedNum = 1;
                jobEntity.F_JobCode = "CJ_" + DateTime.Now.ToString("yyyyMMddHHmmss") + numcount;
                jobEntity.F_JobInfo = "二次检验," + "条码编号为" + item.F_BatchCode + ",物料编号为" + item.F_MaterialCode + ",名称为" + item.F_MaterialName + "的可疑物料进行检验。";
                await jobApp.SubmitForm(jobEntity);
                numcount++;
            }
            //关闭调度任务
            var job = await uniwork.FindEntity<ControlJobEntity>(a => a.F_NeedId == check.F_TransferBoxCode && a.F_JobType == 8 && a.F_JobState < 2);
            if (job != null)
            {
                await jobApp.FinishJob(job.F_Id);
            }
            if (isCommit)
            {
                uniwork.Commit();
                await _logApp.WriteLog(4, "质检:物料" + check.F_MaterialName + "检验数量" + (check.F_Num ?? 0), check.F_EqpName, "", check.F_MaterialName, check.F_TransferBoxCode, check.F_Num);
            }
        }
        //二次质检提交
        public async Task TwoCheckoutForm(string batchCode, float? num = 0, int isBack = 0)
        {
            var scap = await uniwork.FindEntity<ScapMaterialEntity>(a => a.F_BatchCode == batchCode);
            if (scap.F_IsCheck == true)
            {
                throw new Exception("可疑物料已经质检完成");
            }
            if (num <= 0)
            {
                throw new Exception("数量不能小于0,请检查");
            }
            if (scap.F_Num < scap.F_ReturnNum + scap.F_ScapNum + num)
            {
                throw new Exception("没有足够数量,请检查");
            }
            var check = await repository.FindEntity(scap.F_CheckId);
            uniwork.BeginTrans();
            if (isBack == 1)
            {
                await uniwork.Update<ScapMaterialEntity>(a => a.F_Id == scap.F_Id && a.F_Num >= a.F_ReturnNum + a.F_ScapNum + num, a => new ScapMaterialEntity
                {
                    F_ScapNum = a.F_ScapNum + num,
                });
            }
            else if (isBack == 2)
            {
                await uniwork.Update<ScapMaterialEntity>(a => a.F_Id == scap.F_Id && a.F_Num >= a.F_ReturnNum + a.F_ScapNum + num, a => new ScapMaterialEntity
                {
                    F_ReturnNum = a.F_ReturnNum + num,
                });
            }
            if (scap.F_Num == scap.F_ReturnNum + scap.F_ScapNum + num)
            {
                await uniwork.Update<ScapMaterialEntity>(a => a.F_Id == scap.F_Id && a.F_Num == a.F_ReturnNum + a.F_ScapNum, a => new ScapMaterialEntity
                {
                    F_IsCheck = true,
                });
                //关闭调度任务
                var job = await uniwork.FindEntity<ControlJobEntity>(a => a.F_NeedId == batchCode && a.F_JobType == 9 && a.F_JobState < 2);
                if (job != null)
                {
                    await jobApp.FinishJob(job.F_Id);
                }
            }
            var list = uniwork.IQueryable<ScapMaterialEntity>(a => a.F_CheckId == check.F_Id).ToList();
            if (list.Count() == list.Where(a => a.F_IsCheck == true).Count())
            {
                check.F_IsTwoCheck = true;
                check.F_TwoFinishTime = DateTime.Now;
            }
            //报废增加不良数量
            if (isBack == 1)
            {
                if (check.F_CheckType == 0)
                {
                    var inid = uniwork.IQueryable<InStorageInfoEntity>(a => a.F_Id.ToString() == check.F_SourceId).Select(a => a.F_InStorageId).FirstOrDefault();
                    await uniwork.Update<InStorageEntity>(a => a.F_Id == inid && a.F_Num > a.F_BadNum + num, a => new InStorageEntity
                    {
                        F_BadNum = a.F_BadNum + num
                    });
                }
                if (check.F_CheckType == 2)
                {
                    var output = uniwork.IQueryable<OutPutInfoEntity>(a => a.F_Id.ToString() == check.F_SourceId).FirstOrDefault();
                    await uniwork.Update<WorkOrderDetailEntity>(a => a.F_Id == output.F_WorkOrderDetailId && a.F_DoneNum >= a.F_BadNum + num, a => new WorkOrderDetailEntity
                    {
                        F_BadNum = a.F_BadNum + num
                    });
                    var detail = await uniwork.FindEntity<WorkOrderDetailEntity>(a => a.F_Id == output.F_WorkOrderDetailId);
                    var note = await uniwork.FindEntity<WorkOrderEntity>(a => a.F_Id == output.F_WorkOrderId);
                    if (detail.F_MaterialId == note.F_MaterialId)
                    {
                        await uniwork.Update<WorkOrderEntity>(a => a.F_Id == output.F_WorkOrderId && a.F_DoneNum >= a.F_BadNum + num, a => new WorkOrderEntity
                        {
                            F_BadNum = a.F_BadNum + num
                        });
                    }
                }
                else
                {
                    var output = GetOuputByStorage(check.F_TransferBoxCode, check.F_MaterialId, check.F_MaterialBatch);
                    if (output != null)
                    {
                        await uniwork.Update<WorkOrderDetailEntity>(a => a.F_Id == output.F_WorkOrderDetailId && a.F_DoneNum >= a.F_BadNum + num, a => new WorkOrderDetailEntity
                        {
                            F_BadNum = a.F_BadNum + num
                        });
                        var detail = await uniwork.FindEntity<WorkOrderDetailEntity>(a => a.F_Id == output.F_WorkOrderDetailId);
                        var note = await uniwork.FindEntity<WorkOrderEntity>(a => a.F_Id == output.F_WorkOrderId);
                        if (detail.F_MaterialId == note.F_MaterialId)
                        {
                            await uniwork.Update<WorkOrderEntity>(a => a.F_Id == output.F_WorkOrderId && a.F_DoneNum >= a.F_BadNum + num, a => new WorkOrderEntity
                            {
                                F_BadNum = a.F_BadNum + num
                            });
                        }
                    }
                    else
                    {
                        var inid = GetInStorageByStorage(check.F_TransferBoxCode, check.F_MaterialId, check.F_MaterialBatch);
                        if (inid != null)
                        {
                            await uniwork.Update<InStorageEntity>(a => a.F_Id == inid.F_InStorageId && a.F_DoneNum >= a.F_BadNum + num, a => new InStorageEntity
                            {
                                F_BadNum = a.F_BadNum + num
                            });
                        }
                    }
                }
            }
            await uniwork.Update(check);
            uniwork.Commit();
        }
        //可疑变动状态
        public async Task ChangeScapState(string batchCode, float? num = 0, int isBack = 0)
        {
            var scap = await uniwork.FindEntity<ScapMaterialEntity>(a => a.F_BatchCode == batchCode);
            if (scap.F_IsCheck == false)
            {
                throw new Exception("可疑物料未质检，无法操作");
            }
            if (scap.F_Num < scap.F_ReturnNum + scap.F_ScapNum + num)
            {
                throw new Exception("没有足够数量,请检查");
            }
            var check = await repository.FindEntity(scap.F_CheckId);
            uniwork.BeginTrans();
            if (isBack == 1)
            {
                await uniwork.Update<ScapMaterialEntity>(a => a.F_Id == scap.F_Id && a.F_Num >= a.F_ReturnNum + a.F_ScapNum + num, a => new ScapMaterialEntity
                {
                    F_ScapNum = a.F_ScapNum + num,
                });
            }
            else if (isBack == 2)
            {
                await uniwork.Update<ScapMaterialEntity>(a => a.F_Id == scap.F_Id && a.F_Num >= a.F_ReturnNum + a.F_ScapNum + num, a => new ScapMaterialEntity
                {
                    F_ReturnNum = a.F_ScapNum + num,
                });
            }
            //报废增加不良数量
            if (isBack == 1)
            {
                if (check.F_CheckType == 0)
                {
                    var inid = uniwork.IQueryable<InStorageInfoEntity>(a => a.F_Id.ToString() == check.F_SourceId).Select(a => a.F_InStorageId).FirstOrDefault();
                    await uniwork.Update<InStorageEntity>(a => a.F_Id == inid && a.F_Num > a.F_BadNum + num, a => new InStorageEntity
                    {
                        F_BadNum = a.F_BadNum + num
                    });
                }
                if (check.F_CheckType == 2)
                {
                    var output = uniwork.IQueryable<OutPutInfoEntity>(a => a.F_Id.ToString() == check.F_SourceId).FirstOrDefault();
                    await uniwork.Update<WorkOrderDetailEntity>(a => a.F_Id == output.F_WorkOrderDetailId && a.F_DoneNum >= a.F_BadNum + num, a => new WorkOrderDetailEntity
                    {
                        F_BadNum = a.F_BadNum + num
                    });
                    var detail = await uniwork.FindEntity<WorkOrderDetailEntity>(a => a.F_Id == output.F_WorkOrderDetailId);
                    var note = await uniwork.FindEntity<WorkOrderEntity>(a => a.F_Id == output.F_WorkOrderId);
                    if (detail.F_MaterialId == note.F_MaterialId)
                    {
                        await uniwork.Update<WorkOrderEntity>(a => a.F_Id == output.F_WorkOrderId && a.F_DoneNum >= a.F_BadNum + num, a => new WorkOrderEntity
                        {
                            F_BadNum = a.F_BadNum + num
                        });
                    }
                }
                else
                {
                    var output = GetOuputByStorage(check.F_TransferBoxCode, check.F_MaterialId, check.F_MaterialBatch);
                    if (output != null)
                    {
                        await uniwork.Update<WorkOrderDetailEntity>(a => a.F_Id == output.F_WorkOrderDetailId && a.F_DoneNum >= a.F_BadNum + num, a => new WorkOrderDetailEntity
                        {
                            F_BadNum = a.F_BadNum + num
                        });
                        var detail = await uniwork.FindEntity<WorkOrderDetailEntity>(a => a.F_Id == output.F_WorkOrderDetailId);
                        var note = await uniwork.FindEntity<WorkOrderEntity>(a => a.F_Id == output.F_WorkOrderId);
                        if (detail.F_MaterialId == note.F_MaterialId)
                        {
                            await uniwork.Update<WorkOrderEntity>(a => a.F_Id == output.F_WorkOrderId && a.F_DoneNum >= a.F_BadNum + num, a => new WorkOrderEntity
                            {
                                F_BadNum = a.F_BadNum + num
                            });
                        }
                    }
                    else
                    {
                        var inid = GetInStorageByStorage(check.F_TransferBoxCode, check.F_MaterialId, check.F_MaterialBatch);
                        if (inid != null)
                        {
                            await uniwork.Update<InStorageEntity>(a => a.F_Id == inid.F_InStorageId && a.F_DoneNum >= a.F_BadNum + num, a => new InStorageEntity
                            {
                                F_BadNum = a.F_BadNum + num
                            });
                        }
                    }
                }
            }
            uniwork.Commit();
        }
        private OutPutInfoEntity GetOuputByStorage(string transferBoxCode, string materialId, string materialBatch, string F_WorkOrderDetailId = "")
        {
            var output = uniwork.IQueryable<OutPutInfoEntity>(a => a.F_TransferBoxCode == transferBoxCode && a.F_MaterialId == materialId && a.F_MaterialBatch == materialBatch && a.F_IsTemp != true).FirstOrDefault();
            if (!string.IsNullOrEmpty(F_WorkOrderDetailId))
            {
                output = uniwork.IQueryable<OutPutInfoEntity>(a => a.F_MaterialId == materialId && a.F_MaterialBatch == materialBatch && a.F_IsTemp != true).FirstOrDefault();
            }
            if (output == null)
            {
                var temps = uniwork.IQueryable<StorageChangeInfoEntity>(a => a.F_NewTransferBoxCode == transferBoxCode).ToList();
                foreach (var item in temps)
                {
                    output = GetOuputByStorage(item.F_TransferBoxCode, item.F_MaterialId, item.F_MaterialBatch);
                    if (output != null)
                    {
                        return output;
                    }
                }
                if (output == null)
                {
                    var returnscaps = uniwork.IQueryable<ScapMaterialReturnEntity>(a => a.F_TransferBoxCode == transferBoxCode && a.F_BackMaterialBatch == materialBatch).Select(a => a.F_ScapMaterialId).Distinct().ToList();
                    var checks = uniwork.IQueryable<ScapMaterialEntity>(a => returnscaps.Contains(a.F_Id)).ToList();
                    foreach (var item in checks)
                    {
                        var check = uniwork.IQueryable<NeedCheckEntity>(a => a.F_Id == item.F_CheckId).FirstOrDefault();
                        output = GetOuputByStorage(check.F_TransferBoxCode, item.F_MaterialId, item.F_MaterialBatch);
                        if (output != null)
                        {
                            return output;
                        }
                    }
                }
            }
            return output;
        }
        private InStorageInfoEntity GetInStorageByStorage(string transferBoxCode, string materialId, string materialBatch)
        {
            var output = uniwork.IQueryable<InStorageInfoEntity>(a => a.F_TransferBoxCode == transferBoxCode && a.F_MaterialId == materialId && a.F_MaterialBatch == materialBatch && a.F_IsTemp != true).FirstOrDefault();
            if (output == null)
            {
                var temps = uniwork.IQueryable<StorageChangeInfoEntity>(a => a.F_NewTransferBoxCode == transferBoxCode).ToList();
                foreach (var item in temps)
                {
                    output = GetInStorageByStorage(item.F_TransferBoxCode, item.F_MaterialId, item.F_MaterialBatch);
                    if (output != null)
                    {
                        return output;
                    }
                }
                if (output == null)
                {
                    var returnscaps = uniwork.IQueryable<ScapMaterialReturnEntity>(a => a.F_TransferBoxCode == transferBoxCode && a.F_BackMaterialBatch == materialBatch).Select(a => a.F_ScapMaterialId).Distinct().ToList();
                    var checks = uniwork.IQueryable<ScapMaterialEntity>(a => returnscaps.Contains(a.F_Id)).ToList();
                    foreach (var item in checks)
                    {
                        var check = uniwork.IQueryable<NeedCheckEntity>(a => a.F_Id == item.F_CheckId).FirstOrDefault();
                        output = GetInStorageByStorage(check.F_TransferBoxCode, item.F_MaterialId, item.F_MaterialBatch);
                        if (output != null)
                        {
                            return output;
                        }
                    }
                }
            }
            return output;
        }

        public async Task EnabledForm(string keyValue)
        {
            var ids = keyValue.Split(',');
            if (repository.IQueryable(a => ids.Contains(a.F_Id.ToString()) && a.F_IsCheck == true).Count() > 0)
            {
                throw new Exception("已经质检完成，请不用重复操作");
            }
            if (uniwork.IQueryable<ScapMaterialEntity>(a => ids.Contains(a.F_CheckId.ToString())).Count() > 0)
            {
                throw new Exception("存在可疑物料，无法直接完成");
            }
            uniwork.BeginTrans();
            //逐个完成检验
            foreach (var item in ids)
            {
                var temp = await repository.FindEntity(long.Parse(item));
                await CheckoutForm(temp.F_TransferBoxCode, false);
            }
            uniwork.Commit();
        }
        #endregion

    }
}
