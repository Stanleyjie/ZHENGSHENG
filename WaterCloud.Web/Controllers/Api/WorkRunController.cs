using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using WaterCloud.Code;
using WaterCloud.Domain.EquipmentManage;
using WaterCloud.Domain.MaterialManage;
using WaterCloud.Domain.ProcessManage;
using WaterCloud.Service.MaterialManage;
using WaterCloud.Service.ProcessManage;
using WaterCloud.Service.QualityManage;
using WaterCloud.Service.SystemSecurity;

namespace WaterCloud.Web.Controllers
{
    /// <summary>
    /// 生产接口
    /// </summary>
    // 移动端(钉钉小程序)功能已屏蔽,以下路由特性已注释,接口不再对外开放
    //[Route("api/[controller]/[action]")]
    //[ApiController]
    //[ServiceFilter(typeof(LoginFilterAttribute))]
    public class WorkRunController : ControllerBase
	{
        //自动注入服务
        public LogService _logService { get; set; }
        public MaterialService _materialService { get; set; }
        public WorkOrderRunService _orderService { get; set; }
        public WorkRunService _service { get; set; }
        public NeedCheckService _checkService { get; set; }
        public ScapMaterialService _scapService { get; set; }
        #region 获取数据
        /// <summary>
        /// 获取设备列表
        /// </summary>
        /// <param name="keyword">关键字</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetUsingEqpList([FromQuery] string keyword)
        {
            var data = await _orderService.GetUsingEqpList(keyword);
            return new AlwaysResult<List<EquipmentEntity>> { state = ResultType.success.ToString(), data = data, count = data.Count() };
        }
        /// <summary>
        /// 获取设备列表
        /// </summary>
        /// <param name="keyword">关键字</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetHaveUseEqpList([FromQuery] string keyword)
        {
            var data = await _orderService.GetHaveUseEqpList(keyword);
            return new AlwaysResult<List<EquipmentEntity>> { state = ResultType.success.ToString(), data = data, count = data.Count() };
        }
        /// <summary>
        /// 获取设备列表
        /// </summary>
        /// <param name="keyword">关键字</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetHaveOutEqpList([FromQuery] string keyword)
        {
            var data = await _orderService.GetHaveOutEqpList(keyword);
            return new AlwaysResult<List<EquipmentEntity>> { state = ResultType.success.ToString(), data = data, count = data.Count() };
        }
        /// <summary>
        /// 获取设备使用物料列表
        /// </summary>
        /// <param name="eqpName">关键字</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetUseTransferList([FromQuery] string eqpName)
        {
            var data = await _orderService.GetUseTransferList(eqpName);
            return new AlwaysResult<List<EqpMaterialUseEntity>> { state = ResultType.success.ToString(), data = data, count = data.Count() };
        }
        /// <summary>
        /// 获取设备产出物料列表
        /// </summary>
        /// <param name="eqpName">关键字</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetOutTransferList([FromQuery] string eqpName)
        {
            var data = await _orderService.GetOutTransferList(eqpName);
            foreach (var item in data)
            {
                var scaps = await _checkService.GetCheckEntity(item.F_TransferBoxCode, item.F_Id.ToString(), 2);
                item.F_Num -= scaps == null ? 0 : scaps.F_ScapNum;
            }
            return new AlwaysResult<List<OutPutInfoEntity>> { state = ResultType.success.ToString(), data = data, count = data.Count() };
        }
        /// <summary>
        /// 获取设备工单
        /// </summary>
        /// <param name="eqpName">设备</param>
        /// <param name="keyword">关键字</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetWorkOrder([Required, FromQuery] string eqpName, [FromQuery] string keyword)
        {
            List<WorkOrderDetailExtend> data = await _orderService.GetWorkOrder(eqpName, keyword);
            return new AlwaysResult<List<WorkOrderDetailExtend>> { state = ResultType.success.ToString(), data = data, count = data.Count };
        }
        /// <summary>
        /// 获取设备需要物料列表
        /// </summary>
        /// <param name="eqpName">设备</param>
        /// <param name="keyword">关键字</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetUseMaterial([Required, FromQuery] string eqpName, [FromQuery] string keyword)
        {
            List<MaterialEntity> data = await _materialService.GetUseMaterialList(eqpName, keyword);
            return new AlwaysResult<List<MaterialEntity>> { state = ResultType.success.ToString(), data = data, count = data.Count };
        }
        /// <summary>
        /// 获取设备当前产出物料
        /// </summary>
        /// <param name="eqpName">设备</param>
        /// <param name="keyword">关键字</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetOutMaterial([Required, FromQuery] string eqpName, [FromQuery] string keyword)
        {
            List<MaterialEntity> data = await _materialService.GetOutMaterialList(eqpName, keyword);
            return new AlwaysResult<List<MaterialEntity>> { state = ResultType.success.ToString(), data = data,count=data.Count };
        }
        /// <summary>
        /// 获取产出绑定信息根据流转箱编号
        /// </summary>
        /// <param name="code">流转箱编号</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetOutputMaterialBandingByCode([FromQuery,Required] string code)
        {
            var data = await _service.GetOutputMaterialBandingList(code);
            var otherdata = await _scapService.GetReturnInfoByTransfer(code);
            data = data.Where(a => a.F_TransferBoxCode == code.ToUpper()).ToList();
            var entity = data.FirstOrDefault();
            if (entity!=null)
            {
                entity.F_Num = data.Sum(a => a.F_Num);
            }
            if (otherdata.Count>0)
            {
                entity.F_Num += otherdata.Sum(a => a.F_Num) ?? 0;
            }
            return new AlwaysResult<OutPutInfoEntity> { state = ResultType.success.ToString(), data = entity };
        }
        /// <summary>
        /// 获取在用物料根据设备流转箱
        /// </summary>
        /// <param name="eqpName">设备</param>
        /// <param name="code">流转箱编号</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetConsumeMaterialByCode([Required, FromQuery] string eqpName, [Required, FromQuery] string code)
        {
            var data = await _service.GetConsumeMaterialByCode(eqpName, code.ToUpper());
            return new AlwaysResult<EqpMaterialUseEntity> { state = ResultType.success.ToString(), data = data};
        }
        #endregion

        #region 提交数据
        /// <summary>
        /// 设备补料申请
        /// </summary>
        /// <param name="request">设备补料申请请求对象</param>
        /// <returns></returns>
        [HttpPost]
        [Lock]
        public async Task<AlwaysResult> NeedMaterialJob([FromBody] NeedMaterialJobRequest request)
        {
            try
            {
                await _service.NeedMaterialJob(request.eqpName, request.materialCode, request.num??0);
                await _logService.WriteLog("操作成功", "生产接口-设备补料申请", "", Service.DbLogType.Submit);
                return new AlwaysResult { state = ResultType.success.ToString() };
            }
            catch (Exception ex)
            {
                await _logService.WriteLog(ex.Message, "生产接口-设备补料申请", "", Service.DbLogType.Submit, true);
                return new AlwaysResult { state = ResultType.error.ToString(), message = LogHelper.ExMsgFormat(ex.Message) };
            }
        }
        /// <summary>
        /// 设备使用物料
        /// </summary>
        /// <param name="request">请求对象</param>
        /// <returns></returns>
        [HttpPost]
        [Lock]
        public async Task<AlwaysResult> ConsumeMaterial([FromBody] ConsumeMaterialRequest request)
        {
            try
            {
                EqpMaterialUseEntity entity = new EqpMaterialUseEntity();
                entity.F_TransferBoxCode = request.transferCode.ToUpper();
                entity.F_EqpName = request.eqpName;
                entity.F_Num = request.num;
                entity.F_Description = request.description;
                request.TargetTransferCode = string.IsNullOrEmpty(request.TargetTransferCode) ? null : request.TargetTransferCode.ToUpper();
                await _service.ConsumeMaterial(entity, request.TargetTransferCode);
                await _logService.WriteLog("操作成功", "物流接口-设备使用物料", "", Service.DbLogType.Submit);
                return new AlwaysResult { state = ResultType.success.ToString() };
            }
            catch (Exception ex)
            {
                await _logService.WriteLog(ex.Message, "物流接口-设备使用物料", "", Service.DbLogType.Submit, true);
                return new AlwaysResult { state = ResultType.error.ToString(),message= LogHelper.ExMsgFormat(ex.Message) };
            }
        }
        /// <summary>
        /// 设备退回物料
        /// </summary>
        /// <param name="request">请求对象</param>
        /// <returns></returns>
        [HttpPost]
        [Lock]
        public async Task<AlwaysResult> ReturnMaterial([FromBody] ReturnMaterialRequest request)
        {
            try
            {
                ReturnMaterialEntity entity = new ReturnMaterialEntity();
                entity.F_TransferBoxCode = request.transferCode.ToUpper();
                entity.F_LocationCode = request.locationCode.ToUpper();
                entity.F_Description = request.description;
                entity.F_EqpName = request.eqpName;
                request.newTransferCode = string.IsNullOrEmpty(request.newTransferCode) ? null : request.newTransferCode.ToUpper();
                await _service.ReturnMaterial(entity, request.newTransferCode);
                await _logService.WriteLog("操作成功", "物流接口-设备退回物料", "", Service.DbLogType.Submit);
                return new AlwaysResult { state = ResultType.success.ToString() };
            }
            catch (Exception ex)
            {
                await _logService.WriteLog(ex.Message, "物流接口-设备退回物料", "", Service.DbLogType.Submit, true);
                return new AlwaysResult { state = ResultType.error.ToString(), message = LogHelper.ExMsgFormat(ex.Message) };
            }
        }
        /// <summary>
        /// 退回物料申请
        /// </summary>
        /// <param name="request">请求对象</param>
        /// <returns></returns>
        [HttpPost]
        [Lock]
        public async Task<AlwaysResult> ReturnMaterialJob([FromBody] ReturnMaterialJobRequest request)
        {
            try
            {
                await _service.ReturnMaterialJob(request.transferCode.ToUpper(), request.eqpName);
                await _logService.WriteLog("操作成功", "生产接口-退回物料申请", "", Service.DbLogType.Submit);
                return new AlwaysResult { state = ResultType.success.ToString() };
            }
            catch (Exception ex)
            {
                await _logService.WriteLog(ex.Message, "生产接口-退回物料申请", "", Service.DbLogType.Submit, true);
                return new AlwaysResult { state = ResultType.error.ToString(), message = LogHelper.ExMsgFormat(ex.Message) };
            }
        }
        /// <summary>
        /// 设备产出物料
        /// </summary>
        /// <param name="request">请求对象</param>
        /// <returns></returns>
        [HttpPost]
        [Lock]
        public async Task<AlwaysResult> OutputMaterial([FromBody] OutputMaterialRequest request)
        {
            try
            {
                OutPutInfoEntity entity = new OutPutInfoEntity();
                entity.F_TransferBoxCode = request.transferCode.ToUpper();
                entity.F_MaterialCode = request.materialCode;
                entity.F_Num = request.num;
                entity.F_MaterialBatch = request.materialBatch;
                entity.F_Description = request.description;
                entity.F_EqpName = request.eqpName;
                await _service.OutputMaterial(entity);
                await _logService.WriteLog("操作成功", "生产接口-设备产出物料", "", Service.DbLogType.Submit);
                return new AlwaysResult { state = ResultType.success.ToString() };
            }
            catch (Exception ex)
            {
                await _logService.WriteLog(ex.Message, "生产接口-设备产出物料", "", Service.DbLogType.Submit,true);
                return new AlwaysResult { state = ResultType.error.ToString(), message = LogHelper.ExMsgFormat(ex.Message) };
            }
        }
        /// <summary>
        /// 设备产出物料取消
        /// </summary>
        /// <param name="code">流转箱编号</param>
        /// <returns></returns>
        [HttpPost]
        [Lock]
        public async Task<AlwaysResult> OutputMaterialCancle([Required(ErrorMessage ="流转箱编号不能为空")] string code)
        {
            try
            {
                await _service.OutputMaterialCancle(code.ToUpper());
                await _logService.WriteLog("操作成功", "生产接口-设备产出物料取消", "", Service.DbLogType.Submit);
                return new AlwaysResult { state = ResultType.success.ToString() };
            }
            catch (Exception ex)
            {
                await _logService.WriteLog(ex.Message, "生产接口-设备产出物料取消", "", Service.DbLogType.Submit, true);
                return new AlwaysResult { state = ResultType.error.ToString(), message = LogHelper.ExMsgFormat(ex.Message) };
            }
        }
        /// <summary>
        /// 产出上架
        /// </summary>
        /// <param name="request">请求对象</param>
        /// <returns></returns>
        [HttpPost]
        [Lock]
        public async Task<AlwaysResult> OutputMaterialLocation([FromBody] OutputMaterialLocationRequest request)
        {
            try
            {
                OutPutInfoEntity entity = new OutPutInfoEntity();
                entity.F_TransferBoxCode = request.transferCode.ToUpper();
                entity.F_LocationCode = request.locationCode.ToUpper();
                await _service.OutputMaterialLocation(entity);
                await _logService.WriteLog("操作成功", "物流接口-产出上架", "", Service.DbLogType.Submit);
                return new AlwaysResult { state = ResultType.success.ToString() };
            }
            catch (Exception ex)
            {
                await _logService.WriteLog(ex.Message, "物流接口-产出上架", "", Service.DbLogType.Submit, true);
                return new AlwaysResult { state = ResultType.error.ToString(), message = LogHelper.ExMsgFormat(ex.Message) };
            }
        }
        /// <summary>
        /// 工单结束申请
        /// </summary>
        /// <param name="eqpName">设备</param>
        /// <returns></returns>
        [HttpPost]
        [Lock]
        public async Task<AlwaysResult> FinishWorkOrderJob([Required(ErrorMessage ="设备不能为空")] string eqpName)
        {
            try
            {
                await _service.FinishWorkOrderJob(eqpName);
                await _logService.WriteLog("操作成功", "生产接口-工单结束申请", "", Service.DbLogType.Submit);
                return new AlwaysResult { state = ResultType.success.ToString() };
            }
            catch (Exception ex)
            {
                await _logService.WriteLog(ex.Message, "生产接口-工单结束申请", "", Service.DbLogType.Submit, true);
                return new AlwaysResult { state = ResultType.error.ToString(), message = LogHelper.ExMsgFormat(ex.Message) };
            }
        }
        #endregion

        #region 请求对象
        /// <summary>
        /// 补料申请请求对象
        /// </summary>
        public class NeedMaterialJobRequest
        {
            /// <summary>
            /// 设备名
            /// </summary>
            [Required(ErrorMessage = "设备名不能为空")]
            public string eqpName { get; set; }
            /// <summary>
            /// 物料编号
            /// </summary>
            [Required(ErrorMessage = "物料编号不能为空")]
            public string materialCode { get; set; }
            /// <summary>
            /// 数量
            /// </summary>
            [Required(ErrorMessage = "数量不能为空")]
            public float? num { get; set; }

        }
        /// <summary>
        /// 设备使用物料
        /// </summary>
        public class ConsumeMaterialRequest
        {
            /// <summary>
            /// 设备名
            /// </summary>
            [Required(ErrorMessage = "设备名不能为空")]
            public string eqpName { get; set; }
            /// <summary>
            /// 流转箱编号
            /// </summary>
            [Required(ErrorMessage = "流转箱编号不能为空")]
            public string transferCode { get; set; }
            /// <summary>
            /// 数量
            /// </summary>
            [Required(ErrorMessage = "数量不能为空")]
            public float? num { get; set; }
            /// <summary>
            /// 新流转箱
            /// </summary>
            public string TargetTransferCode { get; set; }
            /// <summary>
            /// 备注
            /// </summary>
            public string description { get; set; }

        }
        /// <summary>
        /// 设备退回物料请求对象
        /// </summary>
        public class ReturnMaterialRequest
        {
            /// <summary>
            /// 设备名称
            /// </summary>
            [Required(ErrorMessage = "设备名称不能为空")]
            public string eqpName { get; set; }
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

            /// <summary>
            /// 新流转箱编号
            /// </summary>
            public string newTransferCode { get; set; }
            /// <summary>
            /// 备注
            /// </summary>
            public string description { get; set; }

        }
        /// <summary>
        /// 设备退回物料申请请求对象
        /// </summary>
        public class ReturnMaterialJobRequest
        {
            /// <summary>
            /// 流转箱编号
            /// </summary>
            [Required(ErrorMessage = "流转箱编号不能为空")]
            public string transferCode { get; set; }
            /// <summary>
            /// 设备名称
            /// </summary>
            [Required(ErrorMessage = "设备名称不能为空")]
            public string eqpName { get; set; }

        }
        /// <summary>
        /// 产出上架请求对象
        /// 。。
        /// </summary>
        public class OutputMaterialLocationRequest
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
        /// <summary>
        /// 产出物料请求对象
        /// </summary>
        public class OutputMaterialRequest
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
            /// 物料编号
            /// </summary>
            [Required(ErrorMessage = "物料编号不能为空")]
            public string materialCode { get; set; }
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
            /// 设备名称
            /// </summary>
            [Required(ErrorMessage = "设备名称不能为空")]
            public string eqpName { get; set; }

        }
        #endregion
    }
}
