using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Chloe.Annotations;

namespace WaterCloud.Domain.SalesManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2026-08-14
    /// 描 述：销售订单实体类
    /// </summary>
    [TableAttribute("mes_SalesOrder")]
    public class SalesOrderEntity : IEntity<SalesOrderEntity>, ICreationAudited, IModificationAudited, IDeleteAudited
    {
        /// <summary>
        /// id
        /// </summary>
        [Column("F_Id", IsPrimaryKey = true)]
        public string F_Id { get; set; }
        /// <summary>
        /// 销售订单编号
        /// </summary>
        public string F_SalesOrderCode { get; set; }
        /// <summary>
        /// 客户
        /// </summary>
        public string F_Customer { get; set; }
        /// <summary>
        /// 计划开始时间
        /// </summary>
        public DateTime? F_PlanStartTime { get; set; }
        /// <summary>
        /// 计划结束时间
        /// </summary>
        public DateTime? F_PlanEndTime { get; set; }
        /// <summary>
        /// 天数
        /// </summary>
        public int? F_DayNum { get; set; }
        /// <summary>
        /// 总金额
        /// </summary>
        public float? F_TotalMoney { get; set; }
        /// <summary>
        /// 删除标识
        /// </summary>
        public bool? F_DeleteMark { get; set; }
        /// <summary>
        /// 有效标识
        /// </summary>
        public bool? F_EnabledMark { get; set; }
        /// <summary>
        /// 备注
        /// </summary>
        public string F_Description { get; set; }
        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime? F_CreatorTime { get; set; }
        /// <summary>
        /// 创建人
        /// </summary>
        public string F_CreatorUserId { get; set; }
        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? F_LastModifyTime { get; set; }
        /// <summary>
        /// 修改人
        /// </summary>
        public string F_LastModifyUserId { get; set; }
        /// <summary>
        /// 删除时间
        /// </summary>
        public DateTime? F_DeleteTime { get; set; }
        /// <summary>
        /// 删除人
        /// </summary>
        public string F_DeleteUserId { get; set; }
        /// <summary>
        /// 需求数量
        /// </summary>
        [NotMapped]
        public float? F_NeedNum { get; set; }
        /// <summary>
        /// 明细列表
        /// </summary>
        [NotMapped]
        public List<SalesOrderDetailEntity> list { get; set; }
        /// <summary>
        /// 是否结案
        /// </summary>
        public bool? F_IsFinish { get; set; }
        /// <summary>
        /// 预期完成时间
        /// </summary>
        public DateTime? F_PredictOverTime { get; set; }
        /// <summary>
        /// 实际完成时间
        /// </summary>
        public DateTime? F_ActualOverTime { get; set; }
    }
}
