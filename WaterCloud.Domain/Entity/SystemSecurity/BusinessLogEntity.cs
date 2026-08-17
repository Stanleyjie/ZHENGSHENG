/*******************************************************************************
 * Copyright © 2020 WaterCloud.Framework 版权所有
 * Author: WaterCloud
 * Description: 业务操作日志
 *********************************************************************************/
using Chloe.Annotations;
using System;

namespace WaterCloud.Domain.SystemSecurity
{
    [TableAttribute("mes_BusinessLog")]
    public class BusinessLogEntity : IEntity<BusinessLogEntity>, ICreationAudited
    {
        [ColumnAttribute("F_Id", IsPrimaryKey = true)]
        public string F_Id { get; set; }
        /// <summary>
        /// 日志类型(0领料,1产出,2入库,3出库,4质检,5设备维修,6调度任务,7工单,9其他)
        /// </summary>
        public int? F_LogType { get; set; }
        /// <summary>
        /// 日志类型名称
        /// </summary>
        public string F_LogTypeName { get; set; }
        /// <summary>
        /// 操作内容
        /// </summary>
        public string F_Content { get; set; }
        /// <summary>
        /// 操作人
        /// </summary>
        public string F_OperationUser { get; set; }
        /// <summary>
        /// 设备名称
        /// </summary>
        public string F_EqpName { get; set; }
        /// <summary>
        /// 工单编号
        /// </summary>
        public string F_WorkOrderCode { get; set; }
        /// <summary>
        /// 物料名称
        /// </summary>
        public string F_MaterialName { get; set; }
        /// <summary>
        /// 流转箱编号
        /// </summary>
        public string F_TransferBoxCode { get; set; }
        /// <summary>
        /// 数量
        /// </summary>
        public float? F_Num { get; set; }
        public DateTime? F_CreatorTime { get; set; }
        public string F_CreatorUserId { get; set; }
    }
}
