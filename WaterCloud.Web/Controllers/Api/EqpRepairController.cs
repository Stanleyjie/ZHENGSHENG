using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using WaterCloud.Code;
using WaterCloud.Domain.EquipmentManage;
using WaterCloud.Domain.SystemOrganize;
using WaterCloud.Service.EquipmentManage;
using WaterCloud.Service.ProductionReport;
using WaterCloud.Service.SystemOrganize;
using WaterCloud.Service.SystemSecurity;

namespace WaterCloud.Web.Controllers
{
    // 移动端(钉钉小程序)功能已屏蔽,以下路由特性已注释,接口不再对外开放
    //[Route("api/[controller]/[action]")]
    //[ApiController]
    //[ServiceFilter(typeof(LoginFilterAttribute))]
    public class EqpRepairController: ControllerBase
	{
        public EqpRepairService eqpRepairService { get; set; }
        public LogService _logService { get; set; }
        public HelpClassService helpClassService { get; set; }
        public EquipmentService equipmentService { get; set; }

        public UserService userService { get; set; }

        /// <summary>
        /// 获取设备
        /// </summary>
        /// <param name="EqpUse"></param>
        /// <returns></returns>
        [HttpGet]
        [ServiceFilter(typeof(LoginFilterAttribute))]
        public async Task<AlwaysResult> getEqplist()
        {
            var data = await equipmentService.GetList();
            data = data.Where(t => t.F_EqpType == 0 && t.F_ParentId == "0").OrderBy(t => t.F_EqpName).ToList();
            return new AlwaysResult<List<EquipmentEntity>> { state = ResultType.success.ToString(), data = data };
        }

        /// <summary>
        /// 获取人员
        /// </summary>
        /// 
        /// <returns></returns>
        [HttpGet]
        [ServiceFilter(typeof(LoginFilterAttribute))]
        public async Task<AlwaysResult> getManList()
        {
            var data = await userService.GetManList();
            return new AlwaysResult<object> { state = ResultType.success.ToString(), data = data };
        }

        /// <summary>
        /// 根据用户unionId获取工单管理
        /// </summary>
        /// <param name="ddUserId"></param>
        /// <returns></returns>
        [HttpGet]
        [ServiceFilter(typeof(LoginFilterAttribute))]
        public async Task<AlwaysResult> getRepairInfoByDDUserId([Required]string ddUserId)
        {
            var userId = await helpClassService.getsysUserIdByUnionId(ddUserId);
            var IsAdminRole = await helpClassService.IsAdminRole(ddUserId);
            var data=await eqpRepairService.getRepairInfoByUserId(userId, IsAdminRole);


            return new AlwaysResult<object> { state = ResultType.success.ToString(), data = data };
        }

        /// <summary>
        /// 获取所有维修单
        /// </summary>
        /// <param name="ddUserId"></param>
        /// <param name="currentpage"></param>
        /// <param name="pagesize"></param>
        /// <returns></returns>
        [HttpGet]
        [ServiceFilter(typeof(LoginFilterAttribute))]
        public async Task<AlwaysResult> getAllRepairInfo(string ddUserId,int currentPage,int pageSize,string keyValue)
        {
            //var userId = await helpClassService.getsysUserIdByUnionId(ddUserId);
            //var IsAdminRole = await helpClassService.IsAdminRole(ddUserId);
            var data = await eqpRepairService.getAllRepairInfo(currentPage,pageSize,keyValue);


            return new AlwaysResult<object> { state = ResultType.success.ToString(), data = data };
        }

        /// <summary>
        /// 获取维修单流程明细
        /// </summary>
        /// <param name="repairId"></param>
        /// <returns></returns>
        [HttpGet]
        [ServiceFilter(typeof(LoginFilterAttribute))]
        public async Task<AlwaysResult> getRepairFlowByRepairId([Required]string repairId)
        {

            var data = await eqpRepairService.getRepairFlowByRepairId(repairId);


            return new AlwaysResult<object> { state = ResultType.success.ToString(), data = data };
        }

        /// <summary>
        /// 根据主键获取工单详细信息
        /// </summary>
        /// <param name="Repairid"></param>
        /// <returns></returns>
        [HttpGet]
        [ServiceFilter(typeof(LoginFilterAttribute))]
        public async Task<AlwaysResult> getRepairInfoByRepairId([Required] string Repairid)
        {
            //var userId = await helpClassService.getsysUserIdByUnionId(ddUserId);
            //var IsAdminRole = await helpClassService.IsAdminRole(ddUserId);
            var data = await eqpRepairService.getRepairInfoByRepairId(Repairid);


            return new AlwaysResult<EqpRepairEntity> { state = ResultType.success.ToString(), data = data };
        }


        /// <summary>
        /// 设备报修
        /// </summary>
        /// <param name="request">请求对象</param>
        /// <returns></returns>
        [HttpPost]
        [Lock]
        public async Task<AlwaysResult> EqpCallRepair([FromBody] EqpCallRepairRequest request)
        {
            try
            {
                EqpRepairEntity entity = new EqpRepairEntity();
                entity.F_RepairNo = "appBx_" + DateTime.Now.ToString("yyyyMMddHHmmss");
                entity.F_EqpId = request.F_EqpId;
                entity.F_EqpName = request.F_EqpName;
                entity.F_ProblemType = request.F_ProblemType;
                entity.F_ProblemClass = request.F_ProblemClass;
                entity.F_ProblemDesc = request.F_ProblemDesc;
                entity.F_PhotoPath = request.F_PhotoPath;
                entity.F_CallRepairMan =await helpClassService.getsysUserIdByUnionId(request.F_CallRepairMan);
                entity.F_CallRepairManName = request.F_CallRepairManName;
                entity.F_CallRepairTime = DateTime.Now;
                entity.F_Status = "1";

                await eqpRepairService.SubmitForm(entity, "");
                await _logService.WriteLog("操作成功", "维修接口-设备报修", "", Service.DbLogType.Submit);
                return new AlwaysResult { state = ResultType.success.ToString() };
            }
            catch (Exception ex)
            {
                await _logService.WriteLog(ex.Message, "维修接口-设备报修", "", Service.DbLogType.Submit, true);
                return new AlwaysResult { state = ResultType.error.ToString(), message = LogHelper.ExMsgFormat(ex.Message) };
            }
        }

        /// <summary>
        /// 更新维修单状态
        /// </summary>
        /// <param name="request">请求对象</param>
        /// <returns></returns>
        [HttpPost]
        [Lock]
        public async Task<AlwaysResult> UpdateEqpRepairInfo([FromBody] UpdateEqpRepairInfoRequest request)
        {
            try
            {
                string userId = await helpClassService.getsysUserIdByUnionId(request.currentMan);
                await eqpRepairService.UpdateEqpRepairInfo(request.repairId, request.type, userId, request.currentManName, request.repairManList,request.repairResult);

                await _logService.WriteLog("操作成功", "维修单更新接口-设备报修", "", Service.DbLogType.Submit);
                return new AlwaysResult { state = ResultType.success.ToString() };
            }
            catch (Exception ex)
            {
                await _logService.WriteLog(ex.Message, "维修单更新接口-设备报修", "", Service.DbLogType.Submit, true);
                return new AlwaysResult { state = ResultType.error.ToString(), message = LogHelper.ExMsgFormat(ex.Message) };
            }
        }

    }

    /// <summary>
    /// 设备报修请求参数
    /// 。。
    /// </summary>
    public class EqpCallRepairRequest
    {
        /// <summary>
        /// 
        /// </summary>
        [Required(ErrorMessage = "设备不能为空")]
        public string F_EqpId { get; set; }

        public string F_EqpName { get; set; }
        /// <summary>
        /// 
        /// </summary>
        [Required(ErrorMessage = "报修人不能为空")]
        public string F_CallRepairMan { get; set; }

        public string F_CallRepairManName { get; set; }

        [Required(ErrorMessage = "故障描述不能为空")]
        public string F_ProblemDesc { get; set; }

        public int F_ProblemType { get; set; }
        public string F_ProblemClass { get; set; }
        public string F_PhotoPath { get; set; }


    }

    public class UpdateEqpRepairInfoRequest
    { 
        [Required(ErrorMessage ="维修单主键不能为空")]
        public string repairId { get; set; }
        [Required(ErrorMessage ="操作类型不能为空")]
        public string type { get; set; }
        [Required(ErrorMessage ="当前用户不能为空")]
        public string currentMan { get; set; }

        public string currentManName { get; set; }

        public string repairResult { get; set; }

        public List<EqpRepairManRecordEntity> repairManList { get; set; }
    }

    //public class RepairManRequest
    //{ 
    //    [Required(ErrorMessage ="维修人不能为空")]
    //    public string F_RepairMan { get; set; }
    //    public string F_RepairManName { get; set; }
    //}


}
