using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WaterCloud.Code;
using WaterCloud.Domain.ProcessManage;
using WaterCloud.Service;
using WaterCloud.Service.ProcessManage;

namespace WaterCloud.Web.Areas.ProcessManage.Controllers
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2020-12-07 12:14
    /// 描 述：工单执行控制器类
    /// </summary>
    [Area("ProcessManage")]
    public class WorkOrderRunController :  BaseController
    {
        public WorkOrderRunService _service {get;set;}


        [HttpGet]
        public virtual ActionResult AddForm()
        {
            return View();
        }
        [HttpGet]
        public virtual ActionResult AddUserForm()
        {
            return View();
        }
        #region 获取数据
        [HandlerAjaxOnly]
        [IgnoreAntiforgeryToken]
        public async Task<ActionResult> GetGridJson(SoulPage<WorkOrderDetailExtend> pagination, string keyword)
        {
            if (string.IsNullOrEmpty(pagination.field))
            {
                pagination.field = "F_WorkOrderState,F_PlanStartTime,F_WorkOrderCode,F_RunSort";
                pagination.order = "";
            }
            var data = await _service.GetLookList(pagination,keyword);
            return Content(pagination.setData(data).ToJson());
        }
        [HttpGet]
        [HandlerAjaxOnly]
        public async Task<ActionResult> GetAddListJson(string keyValue, string materialId, string ids)
        {
            var data = await _service.GetAddList(keyValue, materialId, ids);
            data = data.Where(a => a.F_EnabledMark == true && a.F_DeleteMark == false && a.F_EqpState == 0).ToList();
            return Success(data.Count, data);
        }
        [HttpGet]
        [HandlerAjaxOnly]
        public async Task<ActionResult> GetWorkUser(string eqpId,string ids="")
        {
            var data = await _service.GetWorkUser(eqpId,ids);
            return Content(data.ToJson());
        }
        [HttpGet]
        [HandlerAjaxOnly]
        public async Task<ActionResult> GetFormJson(string keyValue)
        {
            var data = await _service.GetLookForm(keyValue);
            return Content(data.ToJson());
        }
        #endregion

        #region 提交数据
        [HttpPost]
        [HandlerAjaxOnly]
        public async Task<ActionResult> SubmitForm(string keyValue, string listData, string userTimeList, int F_MouldNum=0)
        {
            try
            {
                await _service.SubmitForm(keyValue, listData, userTimeList, F_MouldNum);
                return await Success("操作成功。", "", keyValue);
            }
            catch (Exception ex)
            {
                LogHelper.WriteWithTime(ex);
                return await Error(ex.Message, "", keyValue);
            }
        }
        [HttpPost]
        [HandlerAjaxOnly]
        [ServiceFilter(typeof(HandlerAuthorizeAttribute))]
        public async Task<ActionResult> OverForm(string keyValue)
        {
            try
            {
                await _service.OverForm(keyValue);
                return await Success("操作成功。", "", keyValue,DbLogType.Submit);
            }
            catch (Exception ex)
            {
                return await Error(ex.Message, "", keyValue, DbLogType.Submit);
            }
        }

        #endregion
    }
}
