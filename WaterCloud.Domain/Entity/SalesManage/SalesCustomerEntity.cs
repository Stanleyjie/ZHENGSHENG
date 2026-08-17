using System;
using System.ComponentModel.DataAnnotations;
using Chloe.Annotations;

namespace WaterCloud.Domain.SalesManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2026-08-15
    /// 描 述：客户管理实体类
    /// </summary>
    [TableAttribute("mes_SalesCustomer")]
    public class SalesCustomerEntity : IEntity<SalesCustomerEntity>, ICreationAudited, IModificationAudited, IDeleteAudited
    {
        [Column("F_Id", IsPrimaryKey = true)]
        public string F_Id { get; set; }
        /// <summary>
        /// 客户编号
        /// </summary>
        public string F_CustomerCode { get; set; }
        /// <summary>
        /// 客户名称
        /// </summary>
        public string F_CustomerName { get; set; }
        /// <summary>
        /// 联系人
        /// </summary>
        public string F_Contact { get; set; }
        /// <summary>
        /// 联系电话
        /// </summary>
        public string F_Phone { get; set; }
        /// <summary>
        /// 地址
        /// </summary>
        public string F_Address { get; set; }
        public bool? F_DeleteMark { get; set; }
        public bool? F_EnabledMark { get; set; }
        public string F_Description { get; set; }
        public DateTime? F_CreatorTime { get; set; }
        public string F_CreatorUserId { get; set; }
        public DateTime? F_LastModifyTime { get; set; }
        public string F_LastModifyUserId { get; set; }
        public DateTime? F_DeleteTime { get; set; }
        public string F_DeleteUserId { get; set; }
    }
}
