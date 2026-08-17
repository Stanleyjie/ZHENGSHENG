using System;
using System.ComponentModel.DataAnnotations;
using Chloe.Annotations;

namespace WaterCloud.Domain.PurchaseManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2026-08-15
    /// 描 述：采购付款实体类
    /// </summary>
    [TableAttribute("mes_PurchasePayment")]
    public class PurchasePaymentEntity : IEntity<PurchasePaymentEntity>, ICreationAudited, IModificationAudited, IDeleteAudited
    {
        [Column("F_Id", IsPrimaryKey = true)]
        public string F_Id { get; set; }
        /// <summary>
        /// 付款单编号
        /// </summary>
        public string F_PaymentCode { get; set; }
        /// <summary>
        /// 关联采购订单Id
        /// </summary>
        public string F_PurchaseOrderId { get; set; }
        /// <summary>
        /// 供应商
        /// </summary>
        public string F_Supplier { get; set; }
        /// <summary>
        /// 付款日期
        /// </summary>
        public DateTime? F_PaymentDate { get; set; }
        /// <summary>
        /// 付款金额
        /// </summary>
        public float? F_Amount { get; set; }
        /// <summary>
        /// 付款方式
        /// </summary>
        public string F_PayType { get; set; }
        public bool? F_DeleteMark { get; set; }
        public bool? F_EnabledMark { get; set; }
        public string F_Description { get; set; }
        public DateTime? F_CreatorTime { get; set; }
        public string F_CreatorUserId { get; set; }
        public DateTime? F_LastModifyTime { get; set; }
        public string F_LastModifyUserId { get; set; }
        public DateTime? F_DeleteTime { get; set; }
        public string F_DeleteUserId { get; set; }
        [NotMapped]
        public string F_PurchaseOrderCode { get; set; }
    }
}
