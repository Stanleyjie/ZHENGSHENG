using System;
using System.ComponentModel.DataAnnotations;
using Chloe.Annotations;

namespace WaterCloud.Domain.SalesManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2026-08-15
    /// 描 述：销售报价单明细实体类
    /// </summary>
    [TableAttribute("mes_SalesQuoteDetail")]
    public class SalesQuoteDetailEntity : IEntity<SalesQuoteDetailEntity>
    {
        [Column("F_Id", IsPrimaryKey = true)]
        public string F_Id { get; set; }
        public string F_QuoteId { get; set; }
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
