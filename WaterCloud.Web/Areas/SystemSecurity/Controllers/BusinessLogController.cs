/*******************************************************************************
 * Copyright © 2020 WaterCloud.Framework 版权所有
 * Author: WaterCloud
 * Description: 业务操作日志控制器类
 *********************************************************************************/
using WaterCloud.Code;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using WaterCloud.Service.SystemSecurity;

namespace WaterCloud.Web.Areas.SystemSecurity.Controllers
{
    [Area("SystemSecurity")]
    public class BusinessLogController : BaseController
    {
        public BusinessLogService _businessLogService { get; set; }

        [HttpGet]
        [HandlerAjaxOnly]
        public async Task<ActionResult> GetGridJson(Pagination pagination, int timetype = 2, int logType = -1, string keyword = "")
        {
            pagination.order = "desc";
            pagination.sort = "F_CreatorTime desc";
            //导出全部页使用
            if (pagination.rows == 0 && pagination.page == 0)
            {
                pagination.rows = 99999999;
                pagination.page = 1;
            }
            var data = await _businessLogService.GetList(pagination, timetype, logType, keyword);
            return Success(pagination.records, data);
        }
        [HttpGet]
        [HandlerAjaxOnly]
        public async Task<ActionResult> GetFormJson(string keyValue)
        {
            var data = await _businessLogService.GetForm(keyValue);
            return Content(data.ToJson());
        }
    }
}
