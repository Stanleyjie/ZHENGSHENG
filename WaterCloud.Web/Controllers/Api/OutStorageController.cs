using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using WaterCloud.Code;
using WaterCloud.Domain.MaterialManage;
using WaterCloud.Service.MaterialManage;
using WaterCloud.Service.SystemSecurity;

namespace WaterCloud.Web.Controllers
{
    /// <summary>
    /// 出库接口
    /// </summary>
    // 移动端(钉钉小程序)功能已屏蔽,以下路由特性已注释,接口不再对外开放
    //[Route("api/[controller]/[action]")]
    //[ApiController]
    //[ServiceFilter(typeof(LoginFilterAttribute))]
    public class OutStorageController : ControllerBase
	{
        //自动注入服务
        public LogService _logService { get; set; }
        public OutStorageService _service { get; set; }
        #region 获取数据        
        /// <summary>
        /// 获取作业出库单列表
        /// </summary>
        /// <param name="keyword">关键字</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetOutStorageList([FromQuery] string keyword)
        {
            var data = await _service.GetList(keyword);
            data = data.Where(a => a.F_EnabledMark == true && a.F_OutStorageState < 3 && a.F_OutStorageState > 0 && a.F_Num != a.F_DoneNum).ToList();
            return new AlwaysResult<List<OutStorageEntity>> { state = ResultType.success.ToString(), data = data, count = data.Count };
        }
        /// <summary>
        /// 获取装箱出库单列表
        /// </summary>
        /// <param name="keyword">关键字</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetOutStorageBandingList([FromQuery] string keyword)
        {
            var data = await _service.GetList(keyword);
            data = data.Where(a => a.F_EnabledMark == true && a.F_OutStorageState < 3 && a.F_OutStorageState > 0 && a.F_DoneNum>0).ToList();
            return new AlwaysResult<List<OutStorageEntity>> { state = ResultType.success.ToString(), data = data, count = data.Count };
        }
        /// <summary>
        /// 获取出库单根据关键字
        /// </summary>
        /// <param name="keyword">关键字</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetOutStorageByCode([FromQuery] string keyword)
        {
            var data = await _service.GetOutStorageByCode(keyword);
            return new AlwaysResult<OutStorageEntity> { state = ResultType.success.ToString(), data = data};
        }
        /// <summary>
        /// 获取作业中出库单根据关键字
        /// </summary>
        /// <param name="keyword">关键字</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetUnOutStorageByCode([FromQuery] string keyword)
        {
            var data = await _service.GetOutStorageByCode(keyword);
            if (data != null && data.F_OutStorageState != 1)
            {
                data = null;
            }
            return new AlwaysResult<OutStorageEntity> { state = ResultType.success.ToString(), data = data };
        }
        /// <summary>
        /// 获取未绑定信息根据出库单
        /// </summary>
        /// <param name="code">出库单号</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetUnBandingInfoByCode([FromQuery, Required] string code)
        {
            var data = await _service.GetUnBandingInfoByCode(code.ToUpper());
            return new AlwaysResult<List<OutStorageInfoEntity>> { state = ResultType.success.ToString(), data = data };
        }
        #endregion

        #region 提交数据
        /// <summary>
        /// 产品出库
        /// </summary>
        /// <param name="request">产品出库请求对象</param>
        /// <returns></returns>
        [HttpPost]
        [Lock]
        public async Task<AlwaysResult> OutStorage([FromBody] OutStorageRequest request)
        {
            try
            {
                OutStorageInfoEntity entity = new OutStorageInfoEntity();
                entity.F_TransferBoxCode = request.transferCode.ToUpper();
                entity.F_Num = request.num;
                entity.F_Description = request.description;
                entity.F_OutStorageCode = request.outStorageCode.ToUpper();
                entity.TargetTransferCode = string.IsNullOrEmpty(request.TargetTransferCode)?null: request.TargetTransferCode.ToUpper();
                await _service.OutStorage(entity);
                await _logService.WriteLog("操作成功", "出库接口-产品出库", "", Service.DbLogType.Submit);
                return new AlwaysResult { state = ResultType.success.ToString() };
            }
            catch (Exception ex)
            {
                await _logService.WriteLog(ex.Message, "出库接口-产品出库", "", Service.DbLogType.Submit, true);
                return new AlwaysResult { state = ResultType.error.ToString(), message = LogHelper.ExMsgFormat(ex.Message) };
            }
        }
        /// <summary>
        /// 出库装箱
        /// </summary>
        /// <param name="request">出库装箱请求对象</param>
        /// <returns></returns>
        [HttpPost]
        public async Task<AlwaysResult> OutStorageBanding([FromBody] OutStorageBandingRequest request)
        {
            try
            {
                OutStorageInfoEntity entity = new OutStorageInfoEntity();
                entity.F_OutStorageCode = request.outStorageCode.ToUpper();
                entity.F_TransferBoxCode = request.transferCode.ToUpper();
                entity.F_TargetTransferCode = string.IsNullOrEmpty(request.TargetTransferCode) ? null : request.TargetTransferCode.ToUpper();
                entity.F_Num = request.num;
                entity.F_Description = request.description;
                await _service.OutStorageBanding(entity);
                await _logService.WriteLog("操作成功", "出库接口-出库装箱", "", Service.DbLogType.Submit);
                return new AlwaysResult { state = ResultType.success.ToString() };
            }
            catch (Exception ex)
            {
                await _logService.WriteLog(ex.Message, "出库接口-出库装箱", "", Service.DbLogType.Submit, true);
                return new AlwaysResult { state = ResultType.error.ToString(), message = LogHelper.ExMsgFormat(ex.Message) };
            }
        }
        /// <summary>
        /// 取消产品下架
        /// </summary>
        /// <param name="request">取消产品下架请求对象</param>
        /// <returns></returns>
        [HttpPost]
        public async Task<AlwaysResult> OutStorageCancle([FromBody] OutStorageCancleRequest request)
        {
            try
            {
                OutStorageInfoEntity entity = new OutStorageInfoEntity();
                entity.F_TransferBoxCode = request.transferCode.ToUpper();
                entity.F_OutStorageCode = request.outStorageCode.ToUpper();
                entity.F_LocationCode = request.locationCode.ToUpper();
                await _service.OutStorageCancle(entity);
                await _logService.WriteLog("操作成功", "生产接口-取消产品下架", "", Service.DbLogType.Submit);
                return new AlwaysResult { state = ResultType.success.ToString() };
            }
            catch (Exception ex)
            {
                await _logService.WriteLog(ex.Message, "生产接口-取消产品下架", "", Service.DbLogType.Submit, true);
                return new AlwaysResult { state = ResultType.error.ToString(), message = LogHelper.ExMsgFormat(ex.Message) };
            }
        }
        #endregion

        #region 请求对象
        /// <summary>
        /// 产品出库请求对象
        /// </summary>
        public class OutStorageRequest
        {
            /// <summary>
            /// 流转箱编号
            /// </summary>
            [Required(ErrorMessage = "流转箱编号不能为空")]
            public string transferCode { get; set; }
            /// <summary>
            /// 下架数量
            /// </summary>
            /// <returns></returns>
            [Required(ErrorMessage = "数量不能为空")]
            public float? num { get; set; }
            /// <summary>
            /// 描述
            /// </summary>
            /// <returns></returns>
            public string description { get; set; }
            /// <summary>
            /// 出库单号
            /// </summary>
            [Required(ErrorMessage = "出库单号不能为空")]
            public string outStorageCode { get; set; }
            /// <summary>
            /// 目标流转箱
            /// </summary>
            public string TargetTransferCode { get; set; }

        }
        /// <summary>
        /// 产品出库请求对象
        /// </summary>
        public class OutStorageQueryRequest
        {
            /// <summary>
            /// 流转箱编号
            /// </summary>
            [Required(ErrorMessage = "流转箱编号不能为空")]
            public string transferCode { get; set; }
            /// <summary>
            /// 出库单号
            /// </summary>
            [Required(ErrorMessage = "出库单号不能为空")]
            public string outStorageCode { get; set; }

        }
        /// <summary>
        /// 出库装箱请求对象
        /// </summary>
        public class OutStorageBandingRequest
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
            /// 描述
            /// </summary>
            /// <returns></returns>
            public string description { get; set; }
            /// <summary>
            /// 出库单号
            /// </summary>
            [Required(ErrorMessage = "出库单号不能为空")]
            public string outStorageCode { get; set; }
            /// <summary>
            /// 目标流转箱
            /// </summary>
            [Required(ErrorMessage = "目标流转箱不能为空")]
            public string TargetTransferCode { get; set; }


        }
        /// <summary>
        /// 取消产品下架请求对象
        /// </summary>
        public class OutStorageCancleRequest
        {
            /// <summary>
            /// 流转箱编号
            /// </summary>
            [Required(ErrorMessage = "流转箱编号不能为空")]
            public string transferCode { get; set; }
            /// <summary>
            /// 出库单号
            /// </summary>
            [Required(ErrorMessage = "出库单号不能为空")]
            public string outStorageCode { get; set; }
            /// <summary>
            /// 目标库位
            /// </summary>
            [Required(ErrorMessage = "目标库位不能为空")]
            public string locationCode { get; set; }
        }
        #endregion
    }
}
