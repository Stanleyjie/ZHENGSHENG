using System;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;
using WaterCloud.Code;
using Chloe;
using WaterCloud.Domain.EquipmentManage;
using WaterCloud.Domain.DingTalkManage;
using WaterCloud.Service.InfoManage;
using WaterCloud.Service.SystemSecurity;

namespace WaterCloud.Service.EquipmentManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2021-06-15 12:37
    /// 描 述：设备维修记录表服务类
    /// </summary>
    public class EqpRepairService : DataFilterService<EqpRepairEntity>, IDenpendency
    {
        public MessageService messageService { get; set; }
        private BusinessLogService _logApp;

        public EqpRepairService(IDbContext context) : base(context)
        {
            _logApp = new BusinessLogService(context);
        }
        #region 获取数据
        public async Task<List<EqpRepairEntity>> GetList(string keyword = "")
        {
            var data = repository.IQueryable();
            if (!string.IsNullOrEmpty(keyword))
            {
                //data = data.Where(t => t.F_EnCode.Contains(keyword)
                //|| t.F_FullName.Contains(keyword));
            }
            return data.Where(t => t.F_DeleteMark == false).OrderByDesc(t => t.F_CreatorTime).ToList();
        }

        public async Task<List<EqpRepairEntity>> GetLookList(string keyword = "")
        {
            var query = repository.IQueryable().Where(t => t.F_DeleteMark == false);
            if (!string.IsNullOrEmpty(keyword))
            {
                //此处需修改
                //query = query.Where(t => t.F_EnCode.Contains(keyword)
                //|| t.F_FullName.Contains(keyword));
            }
            //权限过滤
            query = GetDataPrivilege("u", "", query);
            return query.OrderByDesc(t => t.F_CreatorTime).ToList();
        }

        public async Task<List<EqpRepairEntity>> GetLookList(SoulPage<EqpRepairEntity> pagination, string RepairNo, string EqpId, string StartTime, string EndTime, string Status)
        {
            var query = repository.IQueryable().Where(t => t.F_DeleteMark == false);

            if (!string.IsNullOrEmpty(RepairNo))
                query = query.Where(u => u.F_RepairNo == RepairNo);
            else
            {
                if (!string.IsNullOrEmpty(EqpId))
                    query = query.Where(u => u.F_EqpId == EqpId);
                if (!string.IsNullOrEmpty(Status))
                    query = query.Where(u => u.F_Status == Status);
                if (!string.IsNullOrEmpty(StartTime) && !string.IsNullOrEmpty(EndTime))
                    query = query.Where(u => Sql.DiffDays(StartTime.ToDate(), u.F_CallRepairTime) >= 0 && Sql.DiffDays(u.F_CallRepairTime, EndTime.ToDate()) >= 0);
                else if (!string.IsNullOrEmpty(StartTime) && string.IsNullOrEmpty(EndTime))
                    query = query.Where(u => Sql.DiffDays(StartTime.ToDate(), u.F_CallRepairTime) >= 0);
                else if (string.IsNullOrEmpty(StartTime) && !string.IsNullOrEmpty(EndTime))
                    query = query.Where(u => Sql.DiffDays(u.F_CallRepairTime, EndTime.ToDate()) >= 0);
            }
            //权限过滤
            query = GetDataPrivilege("u", "", query);
            return await repository.OrderList(query, pagination);
        }

        public async Task<List<EqpRepairManRecordEntity>> GetRepairManList(string RepairNo)
        {
            var repairId = repository.IQueryable(t => t.F_RepairNo == RepairNo).Select(t => t.F_Id).FirstOrDefault();
            var result = uniwork.IQueryable<EqpRepairManRecordEntity>(t => t.F_RepairId == repairId).ToList();
            return result;
        }


        public async Task<EqpRepairEntity> GetForm(string keyValue)
        {
            var data = await repository.FindEntity(keyValue);
            return data;
        }
        #endregion

        public async Task<EqpRepairEntity> GetLookForm(string keyValue)
        {
            var data = await repository.FindEntity(keyValue);
            return GetFieldsFilterData(data);
        }

        public async Task<EqpRepairManRecordEntity> GetManRecordLookForm(string keyValue)
        {
            var data = await uniwork.FindEntity<EqpRepairManRecordEntity>(keyValue);
            return GetFieldsFilterData(data);
        }

        #region 提交数据
        public async Task SubmitForm(EqpRepairEntity entity, string keyValue)
        {
            if (string.IsNullOrEmpty(keyValue))
            {

                entity.F_DeleteMark = false;
                entity.F_EnabledMark = true;
                entity.Create();
                await repository.Insert(entity);

                EqpRepairProcessEntity processEntity = new EqpRepairProcessEntity();
                processEntity.F_RepairId = entity.F_Id;
                processEntity.F_AddTime = DateTime.Now;
                processEntity.F_ActionDesc = $"【{entity.F_CallRepairManName}】已报修，等待管理员派工或维修人员接单";
                await uniwork.Insert<EqpRepairProcessEntity>(processEntity);

                await _logApp.WriteLog(5, "设备维修:设备" + entity.F_EqpName + "报修" + entity.F_ProblemDesc, entity.F_EqpName, "", "", "", null);

            }
            else
            {
                //此处需修改
                entity.Modify(keyValue);
                await repository.Update(entity);
            }
        }

        public async Task ManRecordSubmitForm(EqpRepairManRecordEntity entity, string keyValue)
        {
            if (string.IsNullOrEmpty(keyValue))
            {
                entity.F_DeleteMark = false;
                entity.F_EnabledMark = true;
                entity.Create();
                await uniwork.Insert<EqpRepairManRecordEntity>(entity);

                var query = repository.IQueryable(t => t.F_Id == entity.F_RepairId).FirstOrDefault();
                if (query != null && query.F_Status == "1")//报修转派工
                {
                    await repository.Update(t => t.F_Id == entity.F_RepairId, t => new EqpRepairEntity { F_Status = "2", F_DistributeTime = DateTime.Now });
                }

                EqpRepairProcessEntity processEntity = new EqpRepairProcessEntity();
                processEntity.F_RepairId = entity.F_RepairId;
                processEntity.F_AddTime = DateTime.Now;
                processEntity.F_ActionDesc = $"【管理员】已派工，等待维修人员【{entity.F_RepairManName}】接单";
                await uniwork.Insert<EqpRepairProcessEntity>(processEntity);

            }
            else
            {
                //此处需修改
                entity.Modify(keyValue);
                await uniwork.Update<EqpRepairManRecordEntity>(entity);
            }
        }

        public async Task DeleteForm(string keyValue)
        {
            var ids = keyValue.Split(',');
            await repository.Delete(t => ids.Contains(t.F_Id.ToString()));
        }

        public async Task ManRecordDeleteForm(string keyValue)
        {
            var ids = keyValue.Split(',');
            await uniwork.Delete<EqpRepairManRecordEntity>(t => ids.Contains(t.F_Id.ToString()));

        }

        #endregion

        /// <summary>
        /// 根据用户unionId获取工单管理
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="IsAdminRole"></param>
        /// <returns></returns>
        public async Task<dynamic> getRepairInfoByUserId(string userId, bool IsAdminRole)
        {
            var query = repository.IQueryable(t => Sql.DiffDays(t.F_CallRepairTime, DateTime.Now) <= 30);
            List<EqpRepairEntity> KPGquery = new List<EqpRepairEntity>();
            List<EqpRepairEntity> QRquery = new List<EqpRepairEntity>();
            if (IsAdminRole)
            {
                //可派工的维修单，角色未管理员的人可进行派工，其他人只能进行接单
                KPGquery = query.Where(t => t.F_Status != "4" && t.F_Status != "99").OrderBy(t=>t.F_Status).ThenByDesc(t =>t.F_CallRepairTime).ToList();
                //所有维修人维修提交后 管理员或报修人进行确认
                QRquery = query.Where(t => t.F_Status == "4").OrderByDesc(t => t.F_CallRepairTime).ToList();
            }
            else
            {
                QRquery = query.Where(t => t.F_Status == "4" && t.F_CallRepairMan == userId).OrderByDesc(t => t.F_CallRepairTime).ToList();
            }

            //报修的维修单，所有人可进行接单
            var BXquery = query.Where(t => t.F_Status == "1").OrderByDesc(t => t.F_CallRepairTime).ToList();

            //被派工的维修单，被派工人进行接单
            var JDquery = query.Where(t => t.F_Status == "2").LeftJoin<EqpRepairManRecordEntity>((a, b) => a.F_Id == b.F_RepairId)
                .Where((a, b) => b.F_RepairMan == userId).Select((a, b) => a).Distinct().OrderByDesc(t => t.F_CallRepairTime).ToList();

            //维修中的维修单
            var WXquery = query.Where(t => t.F_Status == "3").LeftJoin<EqpRepairManRecordEntity>((a, b) => a.F_Id == b.F_RepairId)
                .Where((a, b) => b.F_RepairMan == userId && b.F_Status == "2").Select((a, b) => a).Distinct().OrderByDesc(t => t.F_CallRepairTime).ToList();

            return new
            {
                KPGquery,
                BXquery,
                JDquery,
                WXquery,
                QRquery,
                IsAdminRole
            };


        }

        public async Task<dynamic> getAllRepairInfo(int currentpage,int pagesize,string keyValue)
        {
            var q = repository.IQueryable(t => Sql.DiffDays(t.F_CallRepairTime, DateTime.Now) <= 30);
            if (!string.IsNullOrEmpty(keyValue))
            {
                q = q.Where(t => t.F_RepairNo.Contains(keyValue) || t.F_CallRepairManName.Contains(keyValue));
            }
            var query = q.OrderByDesc(t=>t.F_CallRepairTime).ToList();
            query=query.Skip((currentpage - 1) * pagesize).Take(pagesize).ToList();
            return query;
        }

        public async Task<dynamic> getRepairFlowByRepairId(string repairId)
        {
            var query = uniwork.IQueryable<EqpRepairProcessEntity>(t => t.F_RepairId == repairId).OrderByDesc(t => t.F_AddTime).ToList();
            query.ForEach(t => t.addtime = t.F_AddTime.ToString("yyyy-MM-dd HH:mm"));
            return query;
        }


        /// <summary>
        /// 根据主键获取工单详细信息
        /// </summary>
        /// <param name="RepairId"></param>
        /// <returns></returns>
        public async Task<EqpRepairEntity> getRepairInfoByRepairId(string RepairId)
        {
            var query = repository.IQueryable(t => t.F_Id == RepairId).FirstOrDefault();
            var manquery = uniwork.IQueryable<EqpRepairManRecordEntity>(t => t.F_RepairId == RepairId).ToList();
            if (manquery != null && manquery.Count > 0)
            {
                foreach (var item in manquery)
                {
                    if (item.F_Status.ToInt() > 1 && item.F_StartRepairTime != null)
                    {
                        item.repairhour = Math.Round(((item.F_EndRepairTime ?? DateTime.Now) - item.F_StartRepairTime.ToDate()).TotalHours, 1);
                    }
                }
            }

            if (query != null)
            {
                query.repariManlist = manquery;
            }
            return query;

        }

        public async Task UpdateEqpRepairInfo(string repairId, string type, string currentMan, string currentManName, List<EqpRepairManRecordEntity> repairManList, string repairResult)
        {
            switch (type)
            {
                //派工
                case "PG":
                    foreach (var item in repairManList)
                    {
                        item.F_RepairId = repairId;
                        item.F_DistributeTime = DateTime.Now;
                        item.F_Status = "1";
                        item.F_Id = Utils.GuId();
                    }
                    await uniwork.Insert<EqpRepairManRecordEntity>(repairManList);

                    var query = repository.IQueryable(t => t.F_Id == repairId).FirstOrDefault();
                    if (query != null && query.F_Status == "1")//报修转派工
                    {
                        await repository.Update(t => t.F_Id == repairId, t => new EqpRepairEntity { F_Status = "2", F_DistributeTime = DateTime.Now });
                    }

                    var userName = string.Join(",", repairManList.Select(t => t.F_RepairManName).ToList());
                    EqpRepairProcessEntity processEntity = new EqpRepairProcessEntity();
                    processEntity.F_RepairId = repairId;
                    processEntity.F_AddTime = DateTime.Now;
                    processEntity.F_ActionDesc = $"【{currentManName}】已派工，等待维修人员【{userName}】接单";
                    await uniwork.Insert<EqpRepairProcessEntity>(processEntity);

                    //发送钉钉消息
                    try
                    {
                        var userIdList = repairManList.Select(t => t.F_RepairMan).ToList();
                        var dingUserIdList = uniwork.IQueryable<DingUserEntity>(t => userIdList.Contains(t.F_SysUserId)).Select(t => t.F_UserId).ToList();
                        string content = $"您有一条维修单派工消息,请及时接单并进行维修！ \n\n维修单号：{query.F_RepairNo} \n报修工位：{query.F_EqpName} \n故障描述：{this.StringTruncat(query.F_ProblemDesc, 10, "...")} \n派工人员：{currentManName}";
                        await messageService.SendDingTextMsgByIds(dingUserIdList, content);

                        //string title = "您有一条维修单派工消息,请及时接单并进行维修！";
                        //string markdown = $"维修单号：{query.F_RepairNo} \n报修工位：{query.F_EqpName} \n故障描述：{this.StringTruncat(query.F_ProblemDesc, 10, "...")} \n派工人员：{currentManName}";
                        //string single_title = "查看详情";
                        //string single_url = $"eapp://pages/EqpRepair/EqpRepairInfo/EqpRepairInfo?activeTab=1";
                        //await messageService.SendDingCardMsgByIds(dingUserIdList, title,markdown,single_title,single_url);

                    }
                    catch (Exception ex)
                    { 
                    }

                    break;
                //派工接单
                case "PGJD":
                    var detail = uniwork.IQueryable<EqpRepairManRecordEntity>(t => t.F_RepairId == repairId && t.F_RepairMan == currentMan).FirstOrDefault();
                    if (detail != null)
                    {
                        detail.F_StartRepairTime = DateTime.Now;
                        detail.F_Status = "2";
                        await uniwork.Update(detail);

                        var query1 = repository.IQueryable(t => t.F_Id == repairId).FirstOrDefault();
                        if (query1.F_StartRepairTime == null) query1.F_StartRepairTime = DateTime.Now;
                        query1.F_Status = "3";
                        await repository.Update(query1);

                        EqpRepairProcessEntity processEntityPG = new EqpRepairProcessEntity();
                        processEntityPG.F_RepairId = repairId;
                        processEntityPG.F_AddTime = DateTime.Now;
                        processEntityPG.F_ActionDesc = $"维修人员【{currentManName}】已接单，并将进行维修，请随时关注维修进展！";
                        await uniwork.Insert<EqpRepairProcessEntity>(processEntityPG);


                    }
                    break;
                //自主接单
                case "ZZJD":
                    EqpRepairManRecordEntity entity = new EqpRepairManRecordEntity();
                    entity.F_RepairId = repairId;
                    entity.F_RepairMan = currentMan;
                    entity.F_RepairManName = currentManName;
                    entity.F_DistributeTime = DateTime.Now;
                    entity.F_StartRepairTime = DateTime.Now;
                    entity.F_Status = "2";
                    entity.F_Id = Utils.GuId();
                    await uniwork.Insert<EqpRepairManRecordEntity>(entity);

                    await repository.Update(t => t.F_Id == repairId, t => new EqpRepairEntity { F_Status = "3", F_DistributeTime = DateTime.Now, F_StartRepairTime = DateTime.Now });

                    EqpRepairProcessEntity processEntityZZ = new EqpRepairProcessEntity();
                    processEntityZZ.F_RepairId = repairId;
                    processEntityZZ.F_AddTime = DateTime.Now;
                    processEntityZZ.F_ActionDesc = $"维修人员【{currentManName}】主动接单，并正在积极维修中，请随时关注维修进展！";
                    await uniwork.Insert<EqpRepairProcessEntity>(processEntityZZ);

                    break;
                //维修完成
                case "WX":
                    var detailWX = uniwork.IQueryable<EqpRepairManRecordEntity>(t => t.F_RepairId == repairId && t.F_RepairMan == currentMan).FirstOrDefault();
                    if (detailWX != null)
                    {
                        detailWX.F_Status = "99";
                        detailWX.F_RepairResult = repairResult;
                        detailWX.F_EndRepairTime = DateTime.Now;
                        await uniwork.Update<EqpRepairManRecordEntity>(detailWX);
                    }

                    var count = uniwork.IQueryable<EqpRepairManRecordEntity>(t => t.F_RepairId == repairId && t.F_Status != "99").Count();
                    var repairInfo = repository.IQueryable(t => t.F_Id == repairId).FirstOrDefault();
                    EqpRepairProcessEntity processEntityWX = new EqpRepairProcessEntity();
                    processEntityWX.F_AddTime = DateTime.Now;
                    processEntityWX.F_RepairId = repairId;
                    if (count == 0)
                    {
                        processEntityWX.F_ActionDesc = $"维修人员【{currentManName}】维修结束，等待报修人【{repairInfo.F_CallRepairManName}】确认维修结果！";

                    }
                    else
                    {
                        processEntityWX.F_ActionDesc = $"维修人员【{currentManName}】维修结束，等待其他维修人维修结束后送报修人确认！";
                    }
                    await uniwork.Insert<EqpRepairProcessEntity>(processEntityWX);

                    if (count == 0)//全部维修人维修完成，送报修人确认
                    {
                        await repository.Update(t => t.F_Id == repairId, t => new EqpRepairEntity { F_Status = "4", F_EndRepairTime = DateTime.Now });

                        try
                        {
                            var allrpManNameList= uniwork.IQueryable<EqpRepairManRecordEntity>(t => t.F_RepairId == repairId).Select(t => t.F_RepairManName).ToList();


                            var dingUserIdList = uniwork.IQueryable<DingUserEntity>(t => t.F_SysUserId==repairInfo.F_CallRepairMan).Select(t => t.F_UserId).ToList();
                            string content = $"您报修的设备已维修完成，请及时进行确认！ \n\n维修单号：{repairInfo.F_RepairNo} \n报修工位：{repairInfo.F_EqpName} \n故障描述：{this.StringTruncat(repairInfo.F_ProblemDesc, 10, "...")} \n维修人员：{string.Join(";",allrpManNameList)}";
                            await messageService.SendDingTextMsgByIds(dingUserIdList, content);
                        }
                        catch (Exception ex)
                        { 
                        }
                    }

                    break;

                case "QR":
                    await repository.Update(t => t.F_Id == repairId, t => new EqpRepairEntity { F_Status = "99", F_ConfirmTime = DateTime.Now, F_ConfirmMan = currentMan });

                    EqpRepairProcessEntity processEntityQR = new EqpRepairProcessEntity();
                    processEntityQR.F_RepairId = repairId;
                    processEntityQR.F_AddTime = DateTime.Now;
                    processEntityQR.F_ActionDesc = $"报修人【{currentManName}】已确认，设备维修结束！";
                    await uniwork.Insert<EqpRepairProcessEntity>(processEntityQR);

                    break;
                default:
                    break;
            }

        }

        ///
        /// 将指定字符串按指定长度进行剪切
        ///
        /// 需要剪切的的字符串
        /// 字符串的最大长度
        /// 超过长度的后缀
        /// 如果超过长度，返回截断后的新字符串加上后缀，否则，返回元字符串
        public  string StringTruncat(string oldStr, int marLength, string endWith)
        {
            if (string.IsNullOrEmpty(oldStr))
            {//throw new NullReferenceException("原字符串不能为空");
                return oldStr + endWith;
            }
            if (marLength < 1)
            {
                throw new Exception("返回的字符串长度必须大于[0]");
            }
            if (oldStr.Length > marLength)
            {
                string strTmp = oldStr.Substring(0, marLength);
                if (string.IsNullOrEmpty(endWith))
                {
                    return strTmp;
                }
                else
                {
                    return strTmp + endWith;
                }
            }
            return oldStr;
        }
    }
}
