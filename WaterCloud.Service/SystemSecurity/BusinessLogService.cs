/*******************************************************************************
 * Copyright © 2020 WaterCloud.Framework 版权所有
 * Author: WaterCloud
 * Description: 业务操作日志服务类
 *********************************************************************************/
using WaterCloud.Code;
using WaterCloud.Domain.SystemSecurity;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Linq;
using Chloe;

namespace WaterCloud.Service.SystemSecurity
{
    /// <summary>
    /// 业务操作日志服务类
    /// </summary>
    public class BusinessLogService : DataFilterService<BusinessLogEntity>, IDenpendency
    {
        public BusinessLogService(IDbContext context) : base(context)
        {
        }

        /// <summary>
        /// 记录业务操作日志
        /// </summary>
        /// <param name="logType">日志类型(0领料,1产出,2入库,3出库,4质检,5设备维修,6调度任务,7工单,9其他)</param>
        /// <param name="content">操作内容</param>
        /// <param name="eqpName">设备名称</param>
        /// <param name="workOrderCode">工单编号</param>
        /// <param name="materialName">物料名称</param>
        /// <param name="transferBoxCode">流转箱编号</param>
        /// <param name="num">数量</param>
        public async Task WriteLog(int logType, string content, string eqpName = "", string workOrderCode = "", string materialName = "", string transferBoxCode = "", float? num = null)
        {
            try
            {
                BusinessLogEntity entity = new BusinessLogEntity();
                entity.F_Id = Utils.GuId();
                entity.F_LogType = logType;
                entity.F_LogTypeName = GetLogTypeName(logType);
                entity.F_Content = content;
                entity.F_EqpName = eqpName;
                entity.F_WorkOrderCode = workOrderCode;
                entity.F_MaterialName = materialName;
                entity.F_TransferBoxCode = transferBoxCode;
                entity.F_Num = num;
                try
                {
                    var currentuser = OperatorProvider.Provider.GetCurrent();
                    if (currentuser != null)
                    {
                        entity.F_OperationUser = currentuser.UserName;
                        entity.F_CreatorUserId = currentuser.UserId;
                    }
                    else
                    {
                        entity.F_OperationUser = "系统";
                        entity.F_CreatorUserId = "";
                    }
                }
                catch (Exception)
                {
                    entity.F_OperationUser = "系统";
                    entity.F_CreatorUserId = "";
                }
                entity.F_CreatorTime = DateTime.Now;
                await repository.Insert(entity);
            }
            catch (Exception)
            {
                //日志写入失败不影响主流程
            }
        }

        /// <summary>
        /// 获取日志类型名称
        /// </summary>
        public static string GetLogTypeName(int logType)
        {
            switch (logType)
            {
                case 0: return "领料";
                case 1: return "产出";
                case 2: return "入库";
                case 3: return "出库";
                case 4: return "质检";
                case 5: return "设备维修";
                case 6: return "调度任务";
                case 7: return "工单";
                case 8: return "库位调整";
                default: return "其他";
            }
        }

        /// <summary>
        /// 获取日志详情
        /// </summary>
        public async Task<BusinessLogEntity> GetForm(string keyValue)
        {
            return await repository.FindEntity(keyValue);
        }

        /// <summary>
        /// 分页查询业务日志
        /// </summary>
        public async Task<List<BusinessLogEntity>> GetList(Pagination pagination, int timetype, int logType, string keyword = "")
        {
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
            var query = repository.IQueryable();
            query = query.Where(t => t.F_CreatorTime >= startTime && t.F_CreatorTime <= endTime);
            if (logType >= 0)
            {
                query = query.Where(t => t.F_LogType == logType);
            }
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(u => u.F_OperationUser.Contains(keyword) || u.F_Content.Contains(keyword)
                || u.F_EqpName.Contains(keyword) || u.F_WorkOrderCode.Contains(keyword)
                || u.F_MaterialName.Contains(keyword) || u.F_TransferBoxCode.Contains(keyword));
            }
            query = GetDataPrivilege("u", "", query);
            return await repository.OrderList(query, pagination);
        }
    }
}
