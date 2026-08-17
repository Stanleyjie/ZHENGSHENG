using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WaterCloud.Code;
using WaterCloud.Domain.DingTalkManage;
using WaterCloud.Service;
using WaterCloud.Service.DingTalkManage;

namespace WaterCloud.Web.Areas.DingTalkManage.Controllers
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2020-11-21 09:52
    /// 描 述：应用配置控制器类
    /// </summary>
    // 移动端(钉钉)功能已屏蔽,以下控制器不再对外开放
    //[Area("DingTalkManage")]
    //public class DingTalkConfigController :  BaseController
    //{
    //    public DingTalkConfigService _service {get;set;}

    //    #region 获取数据
    //    [HttpGet]
    //    [HandlerAjaxOnly]
    //    public async Task<ActionResult> GetGridJson(SoulPage<DingTalkConfigEntity> pagination, string keyword)
    //    {
    //        if (string.IsNullOrEmpty(pagination.field))
    //        {
    //            pagination.field = "F_CreatorTime";
    //            pagination.order = "desc";
    //        }
    //        var data = await _service.GetLookList(pagination,keyword);
    //        return Content(pagination.setData(data).ToJson());
    //    }

    //    [HttpGet]
    //    [HandlerAjaxOnly]
    //    public async Task<ActionResult> GetListJson(string keyword)
    //    {
    //        var data = await _service.GetList(keyword);
    //        return Content(data.ToJson());
    //    }

    //    [HttpGet]
    //    [HandlerAjaxOnly]
    //    public async Task<ActionResult> GetFormJson(string keyValue)
    //    {
    //        var data = await _service.GetLookForm(keyValue);
    //        return Content(data.ToJson());
    //    }
    //    #endregion

    //    #region 提交数据
    //    [HttpPost]
    //    [HandlerAjaxOnly]
    //    public async Task<ActionResult> SubmitForm(DingTalkConfigEntity entity, string keyValue)
    //    {
    //        try
    //        {
    //            await _service.SubmitForm(entity, keyValue);
    //            return await Success("操作成功。", "", keyValue);
    //        }
    //        catch (Exception ex)
    //        {
    //            return await Error(ex.Message, "", keyValue);
    //        }
    //    }

    //    [HttpPost]
    //    [HandlerAjaxOnly]
    //    [ServiceFilter(typeof(HandlerAuthorizeAttribute))]
    //    public async Task<ActionResult> DeleteForm(string keyValue)
    //    {
    //        try
    //        {
    //            await _service.DeleteForm(keyValue);
    //            return await Success("操作成功。", "", keyValue, DbLogType.Delete);
    //        }
    //        catch (Exception ex)
    //        {
    //            return await Error(ex.Message, "", keyValue, DbLogType.Delete);
    //        }
    //    }
    //    #endregion
    //}
}
