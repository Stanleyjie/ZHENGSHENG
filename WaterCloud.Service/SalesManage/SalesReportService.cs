using System;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;
using WaterCloud.Code;
using Chloe;
using WaterCloud.Domain.SalesManage;
using System.Net.Http;

namespace WaterCloud.Service.SalesManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2026-08-15
    /// 描 述：销售统计报表服务类
    /// </summary>
    public class SalesReportService : DataFilterService<SalesReportEntity>, IDenpendency
    {
        public SalesReportService(IDbContext context, IHttpClientFactory httpClientFactory) : base(context)
        {
        }
        public async Task<List<SalesReportEntity>> GetReportList(string keyword = "", DateTime? startTime = null, DateTime? endTime = null)
        {
            var orders = uniwork.IQueryable<SalesOrderEntity>(a => a.F_DeleteMark == false).ToList();
            if (!string.IsNullOrEmpty(keyword))
            {
                orders = orders.Where(a => a.F_SalesOrderCode.Contains(keyword) || a.F_Customer.Contains(keyword)).ToList();
            }
            if (startTime != null)
            {
                orders = orders.Where(a => a.F_PlanStartTime >= startTime).ToList();
            }
            if (endTime != null)
            {
                orders = orders.Where(a => a.F_PlanEndTime <= endTime).ToList();
            }
            var orderIds = orders.Select(a => a.F_Id).ToList();
            //订单明细数量
            var orderDetails = uniwork.IQueryable<SalesOrderDetailEntity>(a => orderIds.Contains(a.F_SalesOrderId))
                .GroupBy(a => a.F_SalesOrderId).Select(a => new { a.F_SalesOrderId, num = Sql.Sum(a.F_NeedNum) }).ToList();
            //发货数量：先按发货单汇总，再归属到订单
            var deliveries = uniwork.IQueryable<SalesDeliveryEntity>(a => orderIds.Contains(a.F_SalesOrderId)).Select(a => new { a.F_Id, a.F_SalesOrderId }).ToList();
            var deliveryIds = deliveries.Select(a => a.F_Id).ToList();
            var deliveryDetailNums = uniwork.IQueryable<SalesDeliveryDetailEntity>(a => deliveryIds.Contains(a.F_DeliveryId))
                .GroupBy(a => a.F_DeliveryId).Select(a => new { a.F_DeliveryId, num = Sql.Sum(a.F_NeedNum) }).ToList();
            Dictionary<string, float> deliveryNums = new Dictionary<string, float>();
            foreach (var item in deliveries)
            {
                float sum = deliveryDetailNums.Where(a => a.F_DeliveryId == item.F_Id).Sum(a => a.num ?? 0);
                if (deliveryNums.ContainsKey(item.F_SalesOrderId)) { deliveryNums[item.F_SalesOrderId] += sum; }
                else { deliveryNums[item.F_SalesOrderId] = sum; }
            }
            //收款金额
            var receipts = uniwork.IQueryable<SalesReceiptEntity>(a => orderIds.Contains(a.F_SalesOrderId))
                .GroupBy(a => a.F_SalesOrderId).Select(a => new { a.F_SalesOrderId, num = Sql.Sum(a.F_Amount) }).ToList();

            List<SalesReportEntity> list = new List<SalesReportEntity>();
            foreach (var item in orders)
            {
                var detail = orderDetails.Where(a => a.F_SalesOrderId == item.F_Id).FirstOrDefault();
                var receipt = receipts.Where(a => a.F_SalesOrderId == item.F_Id).FirstOrDefault();
                SalesReportEntity temp = new SalesReportEntity();
                temp.F_Id = item.F_Id;
                temp.F_SalesOrderCode = item.F_SalesOrderCode;
                temp.F_Customer = item.F_Customer;
                temp.F_CreatorTime = item.F_CreatorTime;
                temp.F_PlanStartTime = item.F_PlanStartTime;
                temp.F_PlanEndTime = item.F_PlanEndTime;
                temp.F_OrderNum = detail == null ? 0 : detail.num;
                temp.F_DeliveryNum = deliveryNums.ContainsKey(item.F_Id) ? deliveryNums[item.F_Id] : 0;
                temp.F_OrderMoney = item.F_TotalMoney ?? 0;
                temp.F_ReceivedMoney = receipt == null ? 0 : receipt.num;
                temp.F_UnreceivedMoney = (item.F_TotalMoney ?? 0) - temp.F_ReceivedMoney;
                temp.F_IsFinish = item.F_IsFinish;
                list.Add(temp);
            }
            return list.OrderByDescending(a => a.F_CreatorTime).ToList();
        }
    }
}
