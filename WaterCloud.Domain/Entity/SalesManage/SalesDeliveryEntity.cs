using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Chloe.Annotations;

namespace WaterCloud.Domain.SalesManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2026-08-15
    /// 描 述：销售发货单实体类
    /// </summary>
    [TableAttribute("mes_SalesDelivery")]
    public class SalesDeliveryEntity : IEntity<SalesDeliveryEntity>, ICreationAudited, IModificationAudited, IDeleteAudited
    {
        [Column("F_Id", IsPrimaryKey = true)]
        public string F_Id { get; set; }
        /// <summary>
        /// 发货单编号
        /// </summary>
        public string F_DeliveryCode { get; set; }
        /// <summary>
        /// 关联销售订单Id
        /// </summary>
        public string F_SalesOrderId { get; set; }
        /// <summary>
        /// 客户
        /// </summary>
        public string F_Customer { get; set; }
        /// <summary>
        /// 发货日期
        /// </summary>
        public DateTime? F_DeliveryDate { get; set; }
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
        public string F_SalesOrderCode { get; set; }
        [NotMapped]
        public List<SalesDeliveryDetailEntity> list { get; set; }
    }
}
