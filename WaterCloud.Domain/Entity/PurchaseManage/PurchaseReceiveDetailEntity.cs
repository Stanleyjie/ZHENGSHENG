using System;
using System.ComponentModel.DataAnnotations;
using Chloe.Annotations;

namespace WaterCloud.Domain.PurchaseManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2026-08-15
    /// 描 述：采购收货单明细实体类
    /// </summary>
    [TableAttribute("mes_PurchaseReceiveDetail")]
    public class PurchaseReceiveDetailEntity : IEntity<PurchaseReceiveDetailEntity>
    {
        [Column("F_Id", IsPrimaryKey = true)]
        public string F_Id { get; set; }
        public string F_ReceiveId { get; set; }
        public string F_MaterialId { get; set; }
        [NotMapped]
        public string F_MaterialCode { get; set; }
        [NotMapped]
        public string F_MaterialName { get; set; }
        [NotMapped]
        public string F_MaterialUnit { get; set; }
        [NotMapped]
        public int? F_MaterialType { get; set; }
        public float? F_NeedNum { get; set; }
        public float? F_Price { get; set; }
    }
}
