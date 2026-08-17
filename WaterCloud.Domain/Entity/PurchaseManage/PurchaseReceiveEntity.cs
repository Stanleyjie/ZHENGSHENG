using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Chloe.Annotations;

namespace WaterCloud.Domain.PurchaseManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2026-08-15
    /// 描 述：采购收货单实体类
    /// </summary>
    [TableAttribute("mes_PurchaseReceive")]
    public class PurchaseReceiveEntity : IEntity<PurchaseReceiveEntity>, ICreationAudited, IModificationAudited, IDeleteAudited
    {
        [Column("F_Id", IsPrimaryKey = true)]
        public string F_Id { get; set; }
        /// <summary>
        /// 收货单编号
        /// </summary>
        public string F_ReceiveCode { get; set; }
        /// <summary>
        /// 关联采购订单Id
        /// </summary>
        public string F_PurchaseOrderId { get; set; }
        /// <summary>
        /// 供应商
        /// </summary>
        public string F_Supplier { get; set; }
        /// <summary>
        /// 收货日期
        /// </summary>
        public DateTime? F_ReceiveDate { get; set; }
        /// <summary>
        /// 总金额
        /// </summary>
        public float? F_TotalMoney { get; set; }
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
        public float? F_NeedNum { get; set; }
        [NotMapped]
        public string F_PurchaseOrderCode { get; set; }
        [NotMapped]
        public List<PurchaseReceiveDetailEntity> list { get; set; }
    }
}
