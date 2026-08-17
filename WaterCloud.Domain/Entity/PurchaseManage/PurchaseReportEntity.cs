using System;
using System.ComponentModel.DataAnnotations;
using Chloe.Annotations;

namespace WaterCloud.Domain.PurchaseManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2026-08-15
    /// 描 述：采购统计报表实体类（只读统计视图）
    /// </summary>
    [TableAttribute("mes_PurchaseOrder")]
    public class PurchaseReportEntity : IEntity<PurchaseReportEntity>
    {
        [Column("F_Id", IsPrimaryKey = true)]
        public string F_Id { get; set; }
        /// <summary>
        /// 采购订单编号
        /// </summary>
        public string F_PurchaseOrderCode { get; set; }
        /// <summary>
        /// 供应商
        /// </summary>
        public string F_Supplier { get; set; }
        /// <summary>
        /// 下单时间
        /// </summary>
        public DateTime? F_CreatorTime { get; set; }
        /// <summary>
        /// 计划开始时间
        /// </summary>
        public DateTime? F_PlanStartTime { get; set; }
        /// <summary>
        /// 计划结束时间
        /// </summary>
        public DateTime? F_PlanEndTime { get; set; }
        /// <summary>
        /// 采购数量
        /// </summary>
        public float? F_OrderNum { get; set; }
        /// <summary>
        /// 已收货数量
        /// </summary>
        public float? F_ReceiveNum { get; set; }
        /// <summary>
        /// 订单金额
        /// </summary>
        public float? F_OrderMoney { get; set; }
        /// <summary>
        /// 已付金额
        /// </summary>
        public float? F_PaidMoney { get; set; }
        /// <summary>
        /// 未付金额
        /// </summary>
        public float? F_UnpaidMoney { get; set; }
        /// <summary>
        /// 是否完成
        /// </summary>
        public bool? F_IsFinish { get; set; }
    }
}
