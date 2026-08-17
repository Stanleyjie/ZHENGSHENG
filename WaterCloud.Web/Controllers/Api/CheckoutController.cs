using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using WaterCloud.Code;
using WaterCloud.Domain.MaterialManage;
using WaterCloud.Domain.QualityManage;
using WaterCloud.Service.MaterialManage;
using WaterCloud.Service.QualityManage;
using WaterCloud.Service.SystemManage;
using WaterCloud.Service.SystemSecurity;

namespace WaterCloud.Web.Controllers
{
	/// <summary>
	/// 质检接口
	/// </summary>
    // 移动端(钉钉小程序)功能已屏蔽,以下路由特性已注释,接口不再对外开放
	//[Route("api/[controller]/[action]")]
    //[ApiController]
    //[ServiceFilter(typeof(LoginFilterAttribute))]
    public class CheckoutController : ControllerBase
	{
        //自动注入服务
        public LogService _logService { get; set; }
        public StorageService _storageService { get; set; }
        public NeedCheckService _checkoutService { get; set; }
        public ScapMaterialService _scapService { get; set; }
        public CheckoutDescriptionService _descService { get; set; }
        public ItemsDataService _itemService { get; set; }
        #region 获取数据
        /// <summary>
        /// 获取缺陷信息 
        /// </summary>
        /// <param name="code">编号</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetDescriptionInfo()
        {
            var data = await _descService.GetAllList();
            List<CheckoutDescriptionExtend> list = new List<CheckoutDescriptionExtend>();
            var first = data.Where(a => a.F_Layers == 1).ToList();
            foreach (var item in first)
            {
                CheckoutDescriptionExtend temp = new CheckoutDescriptionExtend();
                temp.Description = item.F_Description;
                temp.list = getdescList(data, new List<CheckoutDescriptionEntity>(),item.F_Id, temp.Description);
                list.Add(temp);
            }
            return new AlwaysResult<List<CheckoutDescriptionExtend>> { state = ResultType.success.ToString(), data = list, count = list.Count };
        }
        /// <summary>
        /// 递归获取
        /// </summary>
        /// <param name="data"></param>
        /// <param name="list"></param>
        /// <param name="parentId"></param>
        /// <param name="Description"></param>
        /// <returns></returns>
        private List<CheckoutDescriptionEntity> getdescList(List<CheckoutDescriptionEntity> data, List<CheckoutDescriptionEntity> list,string parentId, string Description)
		{
			//递归树结构，如果有下级就不添加进去
			foreach (var item in data.Where(a=>a.F_ParentId == parentId))
			{
                var  Descriptiontemp = Description+ "/" + item.F_Description;
				if (data.Where(a=>a.F_ParentId==item.F_Id).Count()==0)
				{
                    item.F_Description = Descriptiontemp.Replace("\n","");
                    list.Add(item);
                }
				else
				{
                    getdescList(data, list,item.F_Id, Descriptiontemp);
                }
            }
            return list.OrderByDescending(a=>a.F_ClickNum).ToList();
        }
        /// <summary>
        /// 获取待检验信息 
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetAllInfo()
        {
            var data = await _checkoutService.GetUnCheckList();
            List<NeedCheckExtend> list = new List<NeedCheckExtend>();
            var items = await _itemService.GetItemList("Mes_CheckType");
            foreach (var item in data)
            {
                string CheckType = items.Where(a => a.F_ItemCode == item.F_CheckType.ToString()).FirstOrDefault().F_ItemName;
                var temp = list.Where(a=>a.CheckType== CheckType).FirstOrDefault();
                if (temp != null)
                {
                    temp.list.Add(item);
                }
                else
                {
                    NeedCheckExtend ex = new NeedCheckExtend();
                    ex.CheckType = CheckType;
                    ex.list = new List<NeedCheckEntity>();
                    ex.list.Add(item);
                    list.Add(ex);
                }
            }
            return new AlwaysResult<List<NeedCheckExtend>> { state = ResultType.success.ToString(), data = list, count = list.Count };
        }
        /// <summary>
        /// 获取二次待检验信息 
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetTwoAllInfo()
        {
            var data = await _scapService.GetUnDoList();
            List<ScapMaterialExtend> list = new List<ScapMaterialExtend>();
            data = data.Where(a => a.F_IsCheck == false).ToList();
            var items = await _itemService.GetItemList("Mes_CheckType");
            foreach (var item in data)
            {
                string CheckType = items.Where(a => a.F_ItemCode == item.F_CheckType.ToString()).FirstOrDefault().F_ItemName;
                var temp = list.Where(a => a.CheckType == CheckType).FirstOrDefault();
                if (temp != null)
                {
                    temp.list.Add(item);
                }
                else
                {
                    ScapMaterialExtend ex = new ScapMaterialExtend();
                    ex.CheckType = CheckType;
                    ex.list = new List<ScapMaterialEntity>();
                    ex.list.Add(item);
                    list.Add(ex);
                }
            }
            return new AlwaysResult<List<ScapMaterialExtend>> { state = ResultType.success.ToString(), data = list, count = list.Count };
        }
        /// <summary>
        /// 获取返回正常物料信息 
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetReturnInfo()
        {
            var data = await _scapService.GetReturnInfoList();
            List<ScapMaterialExtend> list = new List<ScapMaterialExtend>();
            var items = data.GroupBy(a=>a.F_MaterialName).Select(a=>a.Key);
            foreach (var item in data.OrderBy(a=>a.F_MaterialCode))
            {
                string MaterialName = items.Where(a => a == item.F_MaterialName.ToString()).FirstOrDefault();
                var temp = list.Where(a => a.CheckType == MaterialName).FirstOrDefault();
                if (temp != null)
                {
                    temp.list.Add(item);
                }
                else
                {
                    ScapMaterialExtend ex = new ScapMaterialExtend();
                    ex.CheckType = MaterialName;
                    ex.list = new List<ScapMaterialEntity>();
                    ex.list.Add(item);
                    list.Add(ex);
                }
            }
            return new AlwaysResult<List<ScapMaterialExtend>> { state = ResultType.success.ToString(), data = list, count = list.Count };
        }
        /// <summary>
        /// 获取流转箱信息根据流转箱编号 
        /// </summary>
        /// <param name="code">编号</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetInfoByCode([Required,FromQuery]string code)
        {
            var data = await _checkoutService.GetInfoByCode(code.ToUpper());
            return new AlwaysResult<NeedCheckEntity> { state = ResultType.success.ToString(), data = data };
        }
        /// <summary>
        /// 获取待检验信息根据流转箱编号 
        /// </summary>
        /// <param name="code">编号</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetWaitCheckoutInfoByCode([Required, FromQuery] string code)
        {
            var data = await _checkoutService.GetUnDoneForm(code.ToUpper());
            return new AlwaysResult<NeedCheckEntity> { state = ResultType.success.ToString(), data = data };
        }
        /// <summary>
        /// 获取不良信息根据条码编号 
        /// </summary>
        /// <param name="code">编号</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetScapMaterialInfoByCode([Required, FromQuery] string code, [FromQuery] bool? itTemp)
        {
            var data = await _scapService.GetScapMaterialInfoByCode(code.ToUpper(), itTemp);
            return new AlwaysResult<ScapMaterialEntity> { state = ResultType.success.ToString(), data = data };
        }
        /// <summary>
        /// 获取不良信息根据条码编号 
        /// </summary>
        /// <param name="code">编号</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetReturnScapMaterialInfoByCode([Required, FromQuery] string code)
        {
            var data = await _scapService.GetReturnScapMaterialInfoByCode(code.ToUpper());
            return new AlwaysResult<ScapMaterialEntity> { state = ResultType.success.ToString(), data = data };
        }
        /// <summary>
        /// 获取不良品物料列表
        /// </summary>
        /// <param name="keyword">关键词</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetBadMaterialList([FromQuery] string keyword)
        {
            var data = await _checkoutService.GetBadMaterialList(keyword);
            return new AlwaysResult<List<MaterialEntity>> { state = ResultType.success.ToString(), data = data };
        }
        #endregion

        #region 提交数据
        /// <summary>
        /// 质检申请
        /// </summary>
        /// <param name="code">流转箱编号</param>
        /// <returns></returns>
        [HttpPost]
        [Lock]
        public async Task<AlwaysResult> NeedCheckJob([Required, FromQuery] string code)
        {
            try
            {
                await _checkoutService.NeedCheckJob(code.ToUpper());
                await _logService.WriteLog("操作成功", "质检接口-质检申请", "", Service.DbLogType.Submit);
                return new AlwaysResult { state = ResultType.success.ToString() };
            }
            catch (Exception ex)
            {
                await _logService.WriteLog(ex.Message, "质检接口-质检申请", "", Service.DbLogType.Submit, true);
                return new AlwaysResult { state = ResultType.error.ToString(), message = LogHelper.ExMsgFormat(ex.Message) };
            }
        }
        /// <summary>
        /// 取消可疑
        /// </summary>
        /// <param name="batchCode">条码编号</param>
        /// <returns></returns>
        [HttpPost]
        [Lock]
        public async Task<AlwaysResult> CheckoutCancle([Required, FromQuery] string code)
        {
            try
            {
                await _scapService.CancleForm(code.ToUpper());
                await _logService.WriteLog("操作成功", "质检接口-取消可疑", "", Service.DbLogType.Submit);
                return new AlwaysResult { state = ResultType.success.ToString() };
            }
            catch (Exception ex)
            {
                await _logService.WriteLog(ex.Message, "质检接口-取消可疑", "", Service.DbLogType.Submit, true);
                return new AlwaysResult { state = ResultType.error.ToString(), message = LogHelper.ExMsgFormat(ex.Message) };
            }
        }
        /// <summary>
        /// 质检返库
        /// </summary>
        /// <param name="request">质检返库请求对象</param>
        /// <returns></returns>
        [HttpPost]
        [Lock]
        public async Task<AlwaysResult> ReturnCheckout([Required, FromBody] ReturnCheckoutRequest request)
        {
            try
            {
                await _scapService.ReturnForm(request.batchCode.ToUpper(), request.transferCode.ToUpper(), request.num,request.isProduce);
                await _logService.WriteLog("操作成功", "质检接口-质检返库", "", Service.DbLogType.Submit);
                return new AlwaysResult { state = ResultType.success.ToString() };
            }
            catch (Exception ex)
            {
                await _logService.WriteLog(ex.Message, "质检接口-质检返库", "", Service.DbLogType.Submit, true);
                return new AlwaysResult { state = ResultType.error.ToString(), message = LogHelper.ExMsgFormat(ex.Message) };
            }
        }
        /// <summary>
        /// 状态变动
        /// </summary>
        /// <param name="request">状态变动请求对象</param>
        /// <returns></returns>
        [HttpPost]
        [Lock]
        public async Task<AlwaysResult> ChangeScapState([Required, FromBody] ChangeScapStateRequest request)
        {
            try
            {
                if (request.isBack>0 && request.num>0)
                {
                    await _checkoutService.ChangeScapState(request.batchCode.ToUpper(), request.num, request.isBack);
                }
                else
                {
                    throw new Exception("无变动，请检查数据");
                }
                await _logService.WriteLog("操作成功", "质检接口-状态变动", "", Service.DbLogType.Submit);
                return new AlwaysResult { state = ResultType.success.ToString() };
            }
            catch (Exception ex)
            {
                await _logService.WriteLog(ex.Message, "质检接口-状态变动", "", Service.DbLogType.Submit, true);
                return new AlwaysResult { state = ResultType.error.ToString(), message = LogHelper.ExMsgFormat(ex.Message) };
            }
        }
        /// <summary>
        /// 二次质检
        /// </summary>
        /// <param name="request">二次质检请求对象</param>
        /// <returns></returns>
        [HttpPost]
        [Lock]
        public async Task<AlwaysResult> TwoCheckoutForm([Required, FromBody] ChangeScapStateRequest request)
        {
            try
            {
                await _checkoutService.TwoCheckoutForm(request.batchCode.ToUpper(), request.num, request.isBack);
                await _logService.WriteLog("操作成功", "质检接口-二次质检", "", Service.DbLogType.Submit);
                return new AlwaysResult { state = ResultType.success.ToString() };
            }
            catch (Exception ex)
            {
                await _logService.WriteLog(ex.Message, "质检接口-二次质检", "", Service.DbLogType.Submit, true);
                return new AlwaysResult { state = ResultType.error.ToString(), message = LogHelper.ExMsgFormat(ex.Message) };
            }
        }
        /// <summary>
        /// 常规质检
        /// </summary>
        /// <param name="request">常规质检请求对象</param>
        /// <returns></returns>
        [HttpPost]
        [Lock]
        public async Task<AlwaysResult> CheckoutForm([Required, FromBody] CheckoutRequest request)
        {
            try
            {
				if (string.IsNullOrEmpty(request.batchCode))
				{
                    await _checkoutService.CheckoutForm(request.transferBoxCode.ToUpper());
                }
				else
				{
                    if (request.propList==null||request .propList.Count() == 0)
                    {
                        throw new Exception("请录入缺陷");
                    }
                    ScapMaterialEntity entity = new ScapMaterialEntity();
                    var check = await _checkoutService.GetUnDoneForm(request.transferBoxCode);
                    entity.F_CheckId = check.F_Id;
                    entity.F_BatchCode = request.batchCode.ToUpper();
                    entity.list = request.propList;
                    entity.F_Num = request.num;
                    await _scapService.SubmitForm(entity);
                }
                await _logService.WriteLog("操作成功", "质检接口-常规质检", "", Service.DbLogType.Submit);
                return new AlwaysResult { state = ResultType.success.ToString() };
            }
            catch (Exception ex)
            {
                await _logService.WriteLog(ex.Message, "质检接口-常规质检", "", Service.DbLogType.Submit, true);
                return new AlwaysResult { state = ResultType.error.ToString(), message = LogHelper.ExMsgFormat(ex.Message) };
            }
        }
        /// <summary>
        /// 缺陷图片转存至服务器
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public async Task<dynamic> PhotoSaveIndex()
        {
			try
			{
				var cd = DateTime.Now;
				var BasePath = GlobalContext.HostingEnvironment.ContentRootPath;
				var SavePath = Path.Combine("upload", "Quality");
				string fullPath = Path.Combine(BasePath, SavePath);
				if (!Directory.Exists(fullPath))
					Directory.CreateDirectory(fullPath);
				var formfiles = Request.Form.Files;
				List<string> files = new List<string>();
				foreach (var formfile in formfiles)
				{
					var fullFileName = formfile.FileName;
					var fileExtension = Path.GetExtension(fullFileName);
					var filename = DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + new Random().Next(100000, 999999) + fileExtension;
					using (var fs = System.IO.File.Create(Path.Combine(fullPath, filename)))
					{
						await formfile.CopyToAsync(fs);
						fs.Flush();
					}
					files.Add($@"/upload/Quality/" + filename);
					try
					{
						System.Drawing.Image img = System.Drawing.Image.FromFile(Path.Combine(fullPath, filename));
					}
					catch (Exception ex)
					{
						FileHelper.DeleteFile(Path.Combine(fullPath, filename));
						throw new Exception("文件非法，请检查！");
					}
				}
				dynamic result = new { error = 0, files = files.First() };

				return result;
			}
			catch (Exception ex)
			{
				return new AlwaysResultEx { error = (int)errorCodeType.error, message = LogHelper.ExMsgFormat(ex.Message) };
			}
		}
        #endregion

        #region 请求对象
        /// <summary>
        /// 质检返库请求对象
        /// </summary>
        public class ReturnCheckoutRequest
        {
            /// <summary>
            /// 变动类型
            /// </summary>
            [Required(ErrorMessage = "条码编号不能为空")]
            public string batchCode { get; set; }
            /// <summary>
            /// 流转箱编号
            /// </summary>
            [Required(ErrorMessage = "流转箱编号不能为空")]
            public string transferCode { get; set; }
            [Required(ErrorMessage = "数量不能为空")]
            public float? num { get; set; }
            public bool isProduce { get; set; } = false;
        }
        /// <summary>
        /// 状态变动请求对象
        /// </summary>
        public class ChangeScapStateRequest
        {
            /// <summary>
            /// 条码编号
            /// </summary>
            [Required(ErrorMessage = "条码编号不能为空")]
            public string batchCode { get; set; }
            /// <summary>
            /// 变动状态
            /// </summary>
            [Required(ErrorMessage = "变动状态不能为空")]
            public int isBack { get; set; }
            [Required(ErrorMessage = "数量不能为空")]
            public float? num { get; set; }
        }
        /// <summary>
        /// 常规质检请求对象
        /// </summary>
        public class CheckoutRequest
        {
            /// <summary>
            /// 流转箱编号
            /// </summary>
            [Required(ErrorMessage = "流转箱编号不能为空")]
            public string transferBoxCode { get; set; }
            /// <summary>
            /// 条码编号
            /// </summary>
            public string batchCode { get; set; }
            /// <summary>
            /// 缺陷列表
            /// </summary>
            public List<ScapImageEntity> propList { get; set; }
            /// <summary>
            /// 数量
            /// </summary>
            public float? num { get; set; }
        }
        #endregion
    }
}
