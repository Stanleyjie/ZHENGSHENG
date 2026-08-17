using System;
using System.ComponentModel.DataAnnotations;
using Chloe.Annotations;

namespace WaterCloud.Domain.PurchaseManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2026-08-14
    /// 描 述：采购订单明细实体类
    /// </summary>
    [TableAttribute("mes_PurchaseOrderDetail")]
    public class PurchaseOrderDetailEntity : IEntity<PurchaseOrderDetailEntity>
    {
        /// <summary>
        /// id
        /// </summary>
        [Column("F_Id", IsPrimaryKey = true)]
        public string F_Id { get; set; }
        /// <summary>
        /// 采购订单Id
        /// </summary>
        public string F_PurchaseOrderId { get; set; }
        /// <summary>
        /// 料号Id
        /// </summary>
        public string F_MaterialId { get; set; }
        /// <summary>
        /// 料号编码
        /// </summary>
        [NotMapped]
        public string F_MaterialCode { get; set; }
        /// <summary>
        /// 料号名称
        /// </summary>
        [NotMapped]
        public string F_MaterialName { get; set; }
        /// <summary>
        /// 料号单位
        /// </summary>
        [NotMapped]
        public string F_MaterialUnit { get; set; }
        /// <summary>
        /// 料号分类
        /// </summary>
        [NotMapped]
        public int? F_MaterialType { get; set; }
        /// <summary>
        /// 需求数量
        /// </summary>
        public float? F_NeedNum { get; set; }
        /// <summary>
        /// 单价
        /// </summary>
        public float? F_Price { get; set; }
        /// <summary>
        /// 已完成数量
        /// </summary>
        [NotMapped]
        public float? F_DoneNum { get; set; }
    }
}
