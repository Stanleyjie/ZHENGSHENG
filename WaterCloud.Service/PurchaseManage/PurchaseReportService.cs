using System;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;
using WaterCloud.Code;
using Chloe;
using WaterCloud.Domain.PurchaseManage;
using System.Net.Http;

namespace WaterCloud.Service.PurchaseManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2026-08-15
    /// 描 述：采购统计报表服务类
    /// </summary>
    public class PurchaseReportService : DataFilterService<PurchaseReportEntity>, IDenpendency
    {
        public PurchaseReportService(IDbContext context, IHttpClientFactory httpClientFactory) : base(context)
        {
        }
        public async Task<List<PurchaseReportEntity>> GetReportList(string keyword = "", DateTime? startTime = null, DateTime? endTime = null)
        {
            var orders = uniwork.IQueryable<PurchaseOrderEntity>(a => a.F_DeleteMark == false).ToList();
            if (!string.IsNullOrEmpty(keyword))
            {
                orders = orders.Where(a => a.F_PurchaseOrderCode.Contains(keyword) || a.F_Supplier.Contains(keyword)).ToList();
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
            var orderDetails = uniwork.IQueryable<PurchaseOrderDetailEntity>(a => orderIds.Contains(a.F_PurchaseOrderId))
                .GroupBy(a => a.F_PurchaseOrderId).Select(a => new { a.F_PurchaseOrderId, num = Sql.Sum(a.F_NeedNum) }).ToList();
            //收货数量：先按收货单汇总，再归属到订单
            var receives = uniwork.IQueryable<PurchaseReceiveEntity>(a => orderIds.Contains(a.F_PurchaseOrderId)).Select(a => new { a.F_Id, a.F_PurchaseOrderId }).ToList();
            var receiveIds = receives.Select(a => a.F_Id).ToList();
            var receiveDetailNums = uniwork.IQueryable<PurchaseReceiveDetailEntity>(a => receiveIds.Contains(a.F_ReceiveId))
                .GroupBy(a => a.F_ReceiveId).Select(a => new { a.F_ReceiveId, num = Sql.Sum(a.F_NeedNum) }).ToList();
            Dictionary<string, float> receiveNums = new Dictionary<string, float>();
            foreach (var item in receives)
            {
                float sum = receiveDetailNums.Where(a => a.F_ReceiveId == item.F_Id).Sum(a => a.num ?? 0);
                if (receiveNums.ContainsKey(item.F_PurchaseOrderId)) { receiveNums[item.F_PurchaseOrderId] += sum; }
                else { receiveNums[item.F_PurchaseOrderId] = sum; }
            }
            //付款金额
            var payments = uniwork.IQueryable<PurchasePaymentEntity>(a => orderIds.Contains(a.F_PurchaseOrderId))
                .GroupBy(a => a.F_PurchaseOrderId).Select(a => new { a.F_PurchaseOrderId, num = Sql.Sum(a.F_Amount) }).ToList();

            List<PurchaseReportEntity> list = new List<PurchaseReportEntity>();
            foreach (var item in orders)
            {
                var detail = orderDetails.Where(a => a.F_PurchaseOrderId == item.F_Id).FirstOrDefault();
                var payment = payments.Where(a => a.F_PurchaseOrderId == item.F_Id).FirstOrDefault();
                PurchaseReportEntity temp = new PurchaseReportEntity();
                temp.F_Id = item.F_Id;
                temp.F_PurchaseOrderCode = item.F_PurchaseOrderCode;
                temp.F_Supplier = item.F_Supplier;
                temp.F_CreatorTime = item.F_CreatorTime;
                temp.F_PlanStartTime = item.F_PlanStartTime;
                temp.F_PlanEndTime = item.F_PlanEndTime;
                temp.F_OrderNum = detail == null ? 0 : detail.num;
                temp.F_ReceiveNum = receiveNums.ContainsKey(item.F_Id) ? receiveNums[item.F_Id] : 0;
                temp.F_OrderMoney = item.F_TotalMoney ?? 0;
                temp.F_PaidMoney = payment == null ? 0 : payment.num;
                temp.F_UnpaidMoney = (item.F_TotalMoney ?? 0) - temp.F_PaidMoney;
                temp.F_IsFinish = item.F_IsFinish;
                list.Add(temp);
            }
            return list.OrderByDescending(a => a.F_CreatorTime).ToList();
        }
    }
}
