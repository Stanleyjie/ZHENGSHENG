using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Chloe.Annotations;

namespace WaterCloud.Domain.SalesManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2026-08-15
    /// 描 述：销售报价单实体类
    /// </summary>
    [TableAttribute("mes_SalesQuote")]
    public class SalesQuoteEntity : IEntity<SalesQuoteEntity>, ICreationAudited, IModificationAudited, IDeleteAudited
    {
        [Column("F_Id", IsPrimaryKey = true)]
        public string F_Id { get; set; }
        /// <summary>
        /// 报价单编号
        /// </summary>
        public string F_QuoteCode { get; set; }
        /// <summary>
        /// 客户
        /// </summary>
        public string F_Customer { get; set; }
        /// <summary>
        /// 报价日期
        /// </summary>
        public DateTime? F_QuoteDate { get; set; }
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
        public List<SalesQuoteDetailEntity> list { get; set; }
    }
}
