using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Chloe.Annotations;

namespace WaterCloud.Domain.PurchaseManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2026-08-15
    /// 描 述：采购询价单实体类
    /// </summary>
    [TableAttribute("mes_PurchaseInquiry")]
    public class PurchaseInquiryEntity : IEntity<PurchaseInquiryEntity>, ICreationAudited, IModificationAudited, IDeleteAudited
    {
        [Column("F_Id", IsPrimaryKey = true)]
        public string F_Id { get; set; }
        /// <summary>
        /// 询价单编号
        /// </summary>
        public string F_InquiryCode { get; set; }
        /// <summary>
        /// 供应商
        /// </summary>
        public string F_Supplier { get; set; }
        /// <summary>
        /// 询价日期
        /// </summary>
        public DateTime? F_InquiryDate { get; set; }
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
        public List<PurchaseInquiryDetailEntity> list { get; set; }
    }
}
