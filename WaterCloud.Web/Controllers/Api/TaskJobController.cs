using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using WaterCloud.Code;
using WaterCloud.Domain.ClassTask;
using WaterCloud.Domain.MaterialManage;
using WaterCloud.Service.ClassTask;
using WaterCloud.Service.MaterialManage;
using WaterCloud.Service.SystemSecurity;

namespace WaterCloud.Web.Controllers
{
	/// <summary>
	/// 调度任务接口
	/// </summary>
    // 移动端(钉钉小程序)功能已屏蔽,以下路由特性已注释,接口不再对外开放
	//[Route("api/[controller]/[action]")]
    //[ApiController]
    //[ServiceFilter(typeof(LoginFilterAttribute))]
    public class TaskJobController : ControllerBase
	{
        //自动注入服务
        public LogService _logService { get; set; }
        public StorageService _storageService { get; set; }
        public ControlJobService _service { get; set; }
        #region 获取数据
        /// <summary>
        /// 获取未完成任务列表
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetUnDoTaskJob()
        {
            var data = (await _service.GetList()).Where(a => a.F_JobState<2).OrderBy(a=>a.F_NeedTime).ToList();
            return new AlwaysResult<List<ControlJobEntity>> { state = ResultType.success.ToString(), data = data, count = data.Count };
        }
        /// <summary>
        /// 获取任务信息
        /// </summary>
        /// <param name="jobCode">任务编号</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetTaskJobForm(string jobCode)
        {
            var data = (await _service.GetTaskJobForm(jobCode));
            return new AlwaysResult<ControlJobExtend> { state = ResultType.success.ToString(), data = data };
        }
        #endregion

        #region 提交数据
        /// <summary>
        /// 获取
        /// </summary>
        /// <param name="jobCode">任务编号</param>
        /// <returns></returns>
        [HttpPost]
        public async Task<AlwaysResult> DoTaskJob([Required,FromBody] string jobCode)
        {
            try
            {
                await _service.DoTaskJob(jobCode);
                await _logService.WriteLog("操作成功", "调度任务接口-开始任务", "", Service.DbLogType.Submit);
                return new AlwaysResult { state = ResultType.success.ToString() };
            }
            catch (Exception ex)
            {
                await _logService.WriteLog(ex.Message, "调度任务接口-开始任务", "", Service.DbLogType.Submit, true);
                return new AlwaysResult { state = ResultType.error.ToString(), message = LogHelper.ExMsgFormat(ex.Message) };
            }
        }
        #endregion
    }
}
