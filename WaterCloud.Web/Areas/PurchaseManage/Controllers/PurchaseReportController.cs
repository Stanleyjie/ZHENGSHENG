using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WaterCloud.Code;
using WaterCloud.Domain.PurchaseManage;
using WaterCloud.Service.PurchaseManage;

namespace WaterCloud.Web.Areas.PurchaseManage.Controllers
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2026-08-15
    /// 描 述：采购统计报表控制器类
    /// </summary>
    [Area("PurchaseManage")]
    public class PurchaseReportController : BaseController
    {
        public PurchaseReportService _service { get; set; }
        #region 获取数据
        [HandlerAjaxOnly]
        [IgnoreAntiforgeryToken]
        public async Task<ActionResult> GetGridJson(SoulPage<PurchaseReportEntity> pagination, string keyword, DateTime? startTime, DateTime? endTime)
        {
            var data = await _service.GetReportList(keyword, startTime, endTime);
            pagination.count = data.Count;
            return Content(pagination.setData(data).ToJson());
        }
        #endregion
    }
}
