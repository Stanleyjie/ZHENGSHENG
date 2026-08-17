using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using WaterCloud.Code;
using WaterCloud.Domain.MaterialManage;
using WaterCloud.Service.MaterialManage;
using WaterCloud.Service.QualityManage;
using WaterCloud.Service.SystemSecurity;

namespace WaterCloud.Web.Controllers
{
    /// <summary>
    /// 入库接口
    /// </summary>
    // 移动端(钉钉小程序)功能已屏蔽,以下路由特性已注释,接口不再对外开放
    //[Route("api/[controller]/[action]")]
    //[ApiController]
    //[ServiceFilter(typeof(LoginFilterAttribute))]
    public class InStorageController : ControllerBase
	{
        //自动注入服务
        public LogService _logService { get; set; }
        public InStorageService _service { get; set; }
        public NeedCheckService _checkService { get; set; }
        #region 获取数据
        /// <summary>
        /// 获取入库单信息根据关键字
        /// </summary>
        /// <param name="keyword">关键字</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetInStorageByCode([FromQuery] string keyword)
        {
            var data = await _service.GetInStorageByCode(keyword);
            return new AlwaysResult<InStorageEntity> { state = ResultType.success.ToString(), data = data };
        }
        /// <summary>
        /// 获取作业入库单列表
        /// </summary>
        /// <param name="keyword">关键字</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetInStorageList([FromQuery] string keyword)
        {
            var data = await _service.GetList(keyword);
            data = data.Where(a => a.F_EnabledMark == true && a.F_InStorageState == 1 && a.F_Num != a.F_DoneNum).ToList();
            return new AlwaysResult<List<InStorageEntity>> { state = ResultType.success.ToString(), data = data, count = data.Count };
        }
        /// <summary>
        /// 获取作业中入库单信息根据关键字
        /// </summary>
        /// <param name="keyword">关键字</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetUnInStorageByCode([FromQuery] string keyword)
        {
            var data = await _service.GetInStorageByCode(keyword);
            if (data != null && data.F_InStorageState != 1)
            {
                data = null;
            }
            return new AlwaysResult<InStorageEntity> { state = ResultType.success.ToString(), data = data };
        }
        /// <summary>
        /// 获取入库绑定信息根据流转箱编号
        /// </summary>
        /// <param name="code">编号</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetInStorageBandingByCode([FromQuery,Required] string code)
        {
            var data = await _service.GetInStorageBandingList(code);
            data = data.Where(a => a.F_TransferBoxCode == code.ToUpper()).ToList();
			foreach (var item in data)
			{
                var scaps = await _checkService.GetCheckEntity(item.F_TransferBoxCode, item.F_Id.ToString(), 0);
                item.F_Num -= scaps == null ? 0 : scaps.F_ScapNum;
            }
            var temp = data.FirstOrDefault();
            if (temp!=null)
            {
                temp.F_Num = data.Sum(a => a.F_Num);
                temp.F_MaterialBatch = string.Join(',', data.Select(a => a.F_MaterialBatch));
            }

            return new AlwaysResult<InStorageInfoEntity> { state = ResultType.success.ToString(), data = temp };
        }
        #endregion

        #region 提交数据
        /// <summary>
        /// 入库绑定
        /// </summary>
        /// <param name="request">入库绑定请求对象</param>
        /// <returns></returns>
        [HttpPost]
        [Lock]
        public async Task<AlwaysResult> InStorageBanding([FromBody] InStorageBandingRequest request)
        {
            try
            {
                InStorageInfoEntity entity = new InStorageInfoEntity();
                entity.F_TransferBoxCode = request.transferCode.ToUpper();
                entity.F_Num = request.num;
                entity.F_MaterialBatch = request.materialBatch;
                entity.F_Description = request.description;
                entity.F_InStorageCode = request.inStorageCode;
                await _service.InStorage(entity);
                await _logService.WriteLog("操作成功", "入库接口-入库绑定", "", Service.DbLogType.Submit);
                return new AlwaysResult { state = ResultType.success.ToString() };
            }
            catch (Exception ex)
            {
                await _logService.WriteLog(ex.Message, "入库接口-入库绑定", "", Service.DbLogType.Submit, true);
                return new AlwaysResult { state = ResultType.error.ToString(), message = LogHelper.ExMsgFormat(ex.Message) };
            }
        }
        /// <summary>
        /// 入库取消绑定
        /// </summary>
        /// <param name="code">流转箱编号</param>
        /// <returns></returns>
        [HttpPost]
        [Lock]
        public async Task<AlwaysResult> InStorageCancleBanding([Required(ErrorMessage ="流转箱编号不能为空")] string code)
        {
            try
            {
                await _service.InStorageCancleBanding(code.ToUpper());
                await _logService.WriteLog("操作成功", "入库接口-取消入库绑定", "", Service.DbLogType.Submit);
                return new AlwaysResult { state = ResultType.success.ToString() };
            }
            catch (Exception ex)
            {
                await _logService.WriteLog(ex.Message, "入库接口-取消入库绑定", "", Service.DbLogType.Submit, true);
                return new AlwaysResult { state = ResultType.error.ToString(), message = LogHelper.ExMsgFormat(ex.Message) };
            }
        }
        /// <summary>
        /// 入库上架
        /// </summary>
        /// <param name="request">入库上架请求对象</param>
        /// <returns></returns>
        [HttpPost]
        [Lock]
        public async Task<AlwaysResult> InStorageLocation([FromBody] InStorageLocationRequest request)
        {
            try
            {
                InStorageInfoEntity entity = new InStorageInfoEntity();
                entity.F_TransferBoxCode = request.transferCode.ToUpper();
                entity.F_LocationCode = request.locationCode;
                await _service.InStorageLocation(entity);
                await _logService.WriteLog("操作成功", "入库接口-入库上架", "", Service.DbLogType.Submit);
                return new AlwaysResult { state = ResultType.success.ToString() };
            }
            catch (Exception ex)
            {
                await _logService.WriteLog(ex.Message, "入库接口-入库上架", "", Service.DbLogType.Submit, true);
                return new AlwaysResult { state = ResultType.error.ToString(), message = LogHelper.ExMsgFormat(ex.Message) };
            }
        }
        #endregion

        #region 请求对象
        /// <summary>
        /// 入库绑定请求对象
        /// </summary>
        public class InStorageBandingRequest
        {
            /// <summary>
            /// 流转箱编号
            /// </summary>
            [Required(ErrorMessage = "流转箱编号不能为空")]
            public string transferCode { get; set; }
            /// <summary>
            /// 变动数量
            /// </summary>
            /// <returns></returns>
            [Required(ErrorMessage = "数量不能为空")]
            public float? num { get; set; }
            /// <summary>
            /// 批号
            /// </summary>
            /// <returns></returns>
            [Required(ErrorMessage = "批号不能为空")]
            public string materialBatch { get; set; }
            /// <summary>
            /// 描述
            /// </summary>
            /// <returns></returns>
            public string description { get; set; }
            /// <summary>
            /// 入库单号
            /// </summary>
            [Required(ErrorMessage = "入库单号不能为空")]
            public string inStorageCode { get; set; }
            
        }
        /// <summary>
        /// 入库上架请求对象
        /// </summary>
        public class InStorageLocationRequest
        {
            /// <summary>
            /// 流转箱编号
            /// </summary>
            [Required(ErrorMessage = "流转箱编号不能为空")]
            public string transferCode { get; set; }
            /// <summary>
            /// 库位号
            /// </summary>
            [Required(ErrorMessage = "库位号不能为空")]
            public string locationCode { get; set; }

        }
        #endregion
    }
}
