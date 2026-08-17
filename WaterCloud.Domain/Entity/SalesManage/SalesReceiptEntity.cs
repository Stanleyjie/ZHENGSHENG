using System;
using System.ComponentModel.DataAnnotations;
using Chloe.Annotations;

namespace WaterCloud.Domain.SalesManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2026-08-15
    /// 描 述：销售收款实体类
    /// </summary>
    [TableAttribute("mes_SalesReceipt")]
    public class SalesReceiptEntity : IEntity<SalesReceiptEntity>, ICreationAudited, IModificationAudited, IDeleteAudited
    {
        [Column("F_Id", IsPrimaryKey = true)]
        public string F_Id { get; set; }
        /// <summary>
        /// 收款单编号
        /// </summary>
        public string F_ReceiptCode { get; set; }
        /// <summary>
        /// 关联销售订单Id
        /// </summary>
        public string F_SalesOrderId { get; set; }
        /// <summary>
        /// 客户
        /// </summary>
        public string F_Customer { get; set; }
        /// <summary>
        /// 收款日期
        /// </summary>
        public DateTime? F_ReceiptDate { get; set; }
        /// <summary>
        /// 收款金额
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
        public string F_SalesOrderCode { get; set; }
    }
}
