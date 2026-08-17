using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WaterCloud.Code;
using WaterCloud.Domain.SalesManage;
using WaterCloud.Service.SalesManage;

namespace WaterCloud.Web.Areas.SalesManage.Controllers
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2026-08-15
    /// 描 述：销售统计报表控制器类
    /// </summary>
    [Area("SalesManage")]
    public class SalesReportController : BaseController
    {
        public SalesReportService _service { get; set; }
        #region 获取数据
        [HandlerAjaxOnly]
        [IgnoreAntiforgeryToken]
        public async Task<ActionResult> GetGridJson(SoulPage<SalesReportEntity> pagination, string keyword, DateTime? startTime, DateTime? endTime)
        {
            var data = await _service.GetReportList(keyword, startTime, endTime);
            pagination.count = data.Count;
            return Content(pagination.setData(data).ToJson());
        }
        #endregion
    }
}
