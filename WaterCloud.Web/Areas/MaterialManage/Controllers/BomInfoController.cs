using System;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using WaterCloud.Code;
using WaterCloud.Domain.MaterialManage;
using WaterCloud.Service;
using Microsoft.AspNetCore.Authorization;
using WaterCloud.Service.MaterialManage;

namespace WaterCloud.Web.Areas.MaterialManage.Controllers
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2020-12-03 13:55
    /// 描 述：Bom结构控制器类
    /// </summary>
    [Area("MaterialManage")]
    public class BomInfoController :  BaseController
    {
        public BomInfoService _service {get;set;}

        [HttpGet]
        public virtual ActionResult AddForm()
        {
            return View();
        }
        [HttpGet]
        public virtual ActionResult Tree()
        {
            return View();
        }
        #region 获取数据
        [HttpGet]
        [HandlerAjaxOnly]
        public async Task<ActionResult> GetGridJson(string itemId)
        {
            var data = await _service.GetLookList(itemId);
            return Success(data.Count, data);
        }

        [HttpGet]
        [HandlerAjaxOnly]
        public async Task<ActionResult> GetBomTree(string keyValue)
        {
            var data = await _service.GetBomTree(keyValue);
            return DTreeResult(data.TreeList());
        }

        [HttpGet]
        [HandlerAjaxOnly]
        public async Task<ActionResult> GetFormJson(string itemId)
        {
            var data = await _service.GetLookForm(itemId);
            return Content(data.ToJson());
        }

        #endregion

        #region 提交数据
        [HttpPost]
        [HandlerAjaxOnly]
        [ServiceFilter(typeof(HandlerAuthorizeAttribute))]
        public async Task<ActionResult> SubmitForm(BomFormEntity entity, string listData)
        {
            try
            {
                await _service.SubmitForm(entity, listData);
                return await Success("操作成功。", "", "");
            }
            catch (Exception ex)
            {
                return await Error(ex.Message, "", "");
            }
        }
        [HttpPost]
        [HandlerAjaxOnly]
        [ServiceFilter(typeof(HandlerAuthorizeAttribute))]
        public async Task<ActionResult> DeleteForm(string itemId, string keyValue)
        {
            try
            {
                //todo 加删除限制
                await _service.DeleteForm(itemId, keyValue);
                return await Success("操作成功。", "", itemId + "." + keyValue, DbLogType.Delete);
            }
            catch (Exception ex)
            {
                return await Error(ex.Message, "", itemId + "." + keyValue, DbLogType.Delete);
            }
        }
        #endregion
    }
}
