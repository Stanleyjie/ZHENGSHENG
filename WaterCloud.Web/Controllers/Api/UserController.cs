using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WaterCloud.Code;
using WaterCloud.Domain.SystemManage;
using WaterCloud.Domain.SystemOrganize;
using WaterCloud.Domain.SystemSecurity;
using WaterCloud.Service;
using WaterCloud.Service.SystemOrganize;
using WaterCloud.Service.SystemSecurity;

namespace WaterCloud.Web.Controllers
{
    /// <summary>
    /// 用户接口
    /// </summary>
    // 移动端(钉钉小程序)功能已屏蔽,以下路由特性已注释,接口不再对外开放
    //[Route("api/[controller]/[action]")]
    //[ApiController]
    public class UserController : ControllerBase
	{
        //自动注入服务
        public FilterIPService _filterIPService { get; set; }
        public UserService _userService { get; set; }
        public RoleAuthorizeService _roleAuthorizeService { get; set; }
        public LogService _logService { get; set; }
        public SystemSetService _setService { get; set; }

        #region 提交数据
        /// <summary>
        /// 用户登录
        /// </summary>
        /// <param name="request">登录请求对象</param>
        /// <returns></returns>
        [HttpPost]
        public async Task<AlwaysResult> Login([FromBody] LoginRequest request)
        {
            var apitoken = Utils.GuId();
            if (!string.IsNullOrEmpty(OperatorProvider.Provider.GetToken()))
            {
                apitoken = OperatorProvider.Provider.GetToken();
            }

            LogEntity logEntity = new LogEntity();
            logEntity.F_ModuleName = "用户Api";
            logEntity.F_Type = DbLogType.Login.ToString();
            try
            {
                if (!await CheckIP())
                {
                    throw new Exception("IP受限");
                }
                UserEntity userEntity = await _userService.CheckLogin(request.userName, Md5.md5(request.password, 32).ToLower(), request.localurl);
                OperatorModel operatorModel = new OperatorModel();
                operatorModel.UserId = userEntity.F_Id;
                operatorModel.UserCode = userEntity.F_Account;
                operatorModel.UserName = userEntity.F_RealName;
                operatorModel.CompanyId = userEntity.F_OrganizeId;
                operatorModel.DepartmentId = userEntity.F_DepartmentId;
                operatorModel.RoleId = userEntity.F_RoleId;
                operatorModel.LoginIPAddress = WebHelper.Ip;
                if (GlobalContext.SystemConfig.LocalLAN != false)
                {
                    operatorModel.LoginIPAddressName = "本地局域网";
                }
                else
                {
                    operatorModel.LoginIPAddressName = WebHelper.GetIpLocation(operatorModel.LoginIPAddress);
                }
                operatorModel.LoginTime = DateTime.Now;
                operatorModel.DdUserId = userEntity.F_DingTalkOpenId;
                operatorModel.WxOpenId = userEntity.F_WxOpenId;
                operatorModel.IsAdmin = userEntity.F_IsAdmin.Value;
                operatorModel.IsBoss = userEntity.F_IsBoss.Value;
                operatorModel.IsLeaderInDepts = userEntity.F_IsLeaderInDepts.Value;
                operatorModel.IsSenior = userEntity.F_IsSenior.Value;
                operatorModel.IsPlanMan = userEntity.F_IsPlanMan.Value;
                SystemSetEntity setEntity = await _setService.GetForm(userEntity.F_OrganizeId);
                operatorModel.DbString = setEntity.F_DbString;
                operatorModel.DBProvider = setEntity.F_DBProvider;
                if (userEntity.F_Account == GlobalContext.SystemConfig.SysemUserCode)
                {
                    operatorModel.IsSystem = true;
                }
                else
                {
                    operatorModel.IsSystem = false;
                }
                await OperatorProvider.Provider.AddLoginUser(operatorModel, apitoken, "api_");
                logEntity.F_Account = userEntity.F_Account;
                logEntity.F_NickName = userEntity.F_RealName;
                logEntity.F_Result = true;
                logEntity.F_Description = "登录成功";
                await _logService.WriteDbLog(logEntity);
                return new AlwaysResult<string> { state = ResultType.success.ToString(), message = "登录成功。",data= apitoken };
            }
            catch (Exception ex)
            {
                logEntity.F_Account = request.userName;
                logEntity.F_NickName = request.userName;
                logEntity.F_Result = false;
                logEntity.F_Description = "登录失败，" + ex.Message;
                await _logService.WriteDbLog(logEntity);
                return new AlwaysResult<string> { state = ResultType.error.ToString(), message = ex.Message,data= apitoken };
            }
        }
        /// <summary>
        /// 钉钉用户登录
        /// </summary>
        /// <param name="code">授权码</param>
        /// <returns></returns>
        [HttpPost]
        public async Task<AlwaysResult> DingLogin([Required,FromQuery] string code)
        {
            var apitoken = OperatorProvider.Provider.GetToken();
            if (!string.IsNullOrEmpty(apitoken))
            {
                bool flag = await _userService.CheckApiTokenExist(apitoken);
                if (flag)
                    return new AlwaysResult { state = ResultType.info.ToString(), message = "已登入" }; ;
            }
            apitoken = Utils.GuId();
            if (!string.IsNullOrEmpty(OperatorProvider.Provider.GetToken()))
            {
                apitoken = OperatorProvider.Provider.GetToken();
            }

            LogEntity logEntity = new LogEntity();
            logEntity.F_ModuleName = "用户Api";
            logEntity.F_Type = DbLogType.Login.ToString();
            try
            {
                if (!await CheckIP())
                {
                    throw new Exception("IP受限");
                }
                UserEntity userEntity = await _userService.CheckDingLoginApp(code);
                if (userEntity.F_Id == null)
                {
                    return new ResultEx { state = ResultType.error.ToString(), code=1000, message = "您未绑定钉钉账号，请先进行绑定！" };
                }
                OperatorModel operatorModel = new OperatorModel();
                operatorModel.UserId = userEntity.F_Id;
                operatorModel.UserCode = userEntity.F_Account;
                operatorModel.UserName = userEntity.F_RealName;
                operatorModel.CompanyId = userEntity.F_OrganizeId;
                operatorModel.DepartmentId = userEntity.F_DepartmentId;
                operatorModel.RoleId = userEntity.F_RoleId;
                operatorModel.LoginIPAddress = WebHelper.Ip;
                if (GlobalContext.SystemConfig.LocalLAN != false)
                {
                    operatorModel.LoginIPAddressName = "本地局域网";
                }
                else
                {
                    operatorModel.LoginIPAddressName = WebHelper.GetIpLocation(operatorModel.LoginIPAddress);
                }
                operatorModel.LoginTime = DateTime.Now;
                operatorModel.DdUserId = userEntity.F_DingTalkOpenId;
                operatorModel.WxOpenId = userEntity.F_WxOpenId;
                operatorModel.IsAdmin = userEntity.F_IsAdmin.Value;
                operatorModel.IsBoss = userEntity.F_IsBoss.Value;
                operatorModel.IsLeaderInDepts = userEntity.F_IsLeaderInDepts.Value;
                operatorModel.IsSenior = userEntity.F_IsSenior.Value;
                operatorModel.IsPlanMan = userEntity.F_IsPlanMan.Value;
                SystemSetEntity setEntity = await _setService.GetForm(userEntity.F_OrganizeId);
                operatorModel.DbString = setEntity.F_DbString;
                operatorModel.DBProvider = setEntity.F_DBProvider;
                if (userEntity.F_Account == GlobalContext.SystemConfig.SysemUserCode)
                {
                    operatorModel.IsSystem = true;
                }
                else
                {
                    operatorModel.IsSystem = false;
                }
                await OperatorProvider.Provider.AddLoginUser(operatorModel, apitoken, "api_");
                logEntity.F_Account = userEntity.F_Account;
                logEntity.F_NickName = userEntity.F_RealName;
                logEntity.F_Result = true;
                logEntity.F_Description = "登录成功";
                await _logService.WriteDbLog(logEntity);
                DingLoginResponse responseData = new DingLoginResponse();
                responseData.apitoken = apitoken;
                responseData.userid = userEntity.F_DingTalkUnionId;
                responseData.username = userEntity.F_DingTalkNick;
                return new AlwaysResult<DingLoginResponse> { state = ResultType.success.ToString(), message = "登录成功。", data = responseData };
            }
            catch (Exception ex)
            {
                logEntity.F_Account = "钉钉登录";
                logEntity.F_NickName = "钉钉登录";
                logEntity.F_Result = false;
                logEntity.F_Description = "登录失败，" + ex.Message;
                await _logService.WriteDbLog(logEntity);
                return new AlwaysResult<string> { state = ResultType.error.ToString(), message = ex.Message, data = apitoken };
            }
        }
        /// <summary>
        /// 钉钉用户登录
        /// </summary>
        /// <param name="request">钉钉登录请求对象</param>
        /// <returns></returns>
        [HttpPost]
        public async Task<AlwaysResult> DingBandingUser([FromBody] DingLoginRequest request)
        {
            var apitoken = Utils.GuId();
            if (!string.IsNullOrEmpty(OperatorProvider.Provider.GetToken()))
            {
                apitoken = OperatorProvider.Provider.GetToken();
            }
            //根据域名判断租户
            LogEntity logEntity = new LogEntity();
            logEntity.F_ModuleName = "绑定钉钉";
            logEntity.F_Type = DbLogType.Login.ToString();
            if (GlobalContext.SystemConfig.Debug)
            {
                request.localurl = "";
            }
            if (GlobalContext.SystemConfig.SysemUserCode == request.userName)
            {
                throw new Exception("禁止使用超管账号");
            }
            try
            {
                if (!await CheckIP())
                {
                    throw new Exception("IP受限");
                }
                UserEntity userEntity = await _userService.CheckLogin(request.userName, request.password, request.localurl);
                var info=await _userService.DingBandingUser(userEntity, request.code);
                OperatorModel operatorModel = new OperatorModel();
                operatorModel.UserId = userEntity.F_Id;
                operatorModel.UserCode = userEntity.F_Account;
                operatorModel.UserName = userEntity.F_RealName;
                operatorModel.CompanyId = userEntity.F_OrganizeId;
                operatorModel.DepartmentId = userEntity.F_DepartmentId;
                operatorModel.RoleId = userEntity.F_RoleId;
                operatorModel.LoginIPAddress = WebHelper.Ip;
                if (GlobalContext.SystemConfig.LocalLAN != false)
                {
                    operatorModel.LoginIPAddressName = "本地局域网";
                }
                else
                {
                    operatorModel.LoginIPAddressName = WebHelper.GetIpLocation(operatorModel.LoginIPAddress);
                }
                operatorModel.LoginTime = DateTime.Now;
                operatorModel.DdUserId = userEntity.F_DingTalkOpenId;
                operatorModel.WxOpenId = userEntity.F_WxOpenId;
                //各租户的管理员也是当前数据库的全部权限
                operatorModel.IsSystem = userEntity.F_IsAdmin.Value;
                operatorModel.IsAdmin = userEntity.F_IsAdmin.Value;
                operatorModel.IsBoss = userEntity.F_IsBoss.Value;
                operatorModel.IsLeaderInDepts = userEntity.F_IsLeaderInDepts.Value;
                operatorModel.IsSenior = userEntity.F_IsSenior.Value;
                operatorModel.IsPlanMan = userEntity.F_IsPlanMan.Value;
                SystemSetEntity setEntity = await _setService.GetForm(userEntity.F_OrganizeId);
                operatorModel.DbString = setEntity.F_DbString;
                operatorModel.DBProvider = setEntity.F_DBProvider;
                if (userEntity.F_Account == GlobalContext.SystemConfig.SysemUserCode)
                {
                    operatorModel.IsSystem = true;
                }
                else
                {
                    operatorModel.IsSystem = false;
                }
                //缓存保存用户信息
                await OperatorProvider.Provider.AddLoginUser(operatorModel, apitoken, "api_");
                logEntity.F_Account = userEntity.F_Account;
                logEntity.F_NickName = userEntity.F_RealName;
                logEntity.F_Result = true;
                logEntity.F_Description = "绑定成功";
                await _logService.WriteDbLog(logEntity);
                DingLoginResponse responseData = new DingLoginResponse();
                responseData.apitoken = apitoken;
                responseData.userid = info.Unionid;
                responseData.username = info.UserName;
                return new AlwaysResult<DingLoginResponse> { state = ResultType.success.ToString(), message = "绑定成功。", data = responseData };
            }
            catch (Exception ex)
            {
                logEntity.F_Account = request.userName;
                logEntity.F_NickName = request.userName;
                logEntity.F_Result = false;
                logEntity.F_Description = "绑定失败，" + ex.Message;
                await _logService.WriteDbLog(logEntity);
                return new AlwaysResult<string> { state = ResultType.error.ToString(), message = ex.Message, data = apitoken };
            }
        }
        private async Task<bool> CheckIP()
        {
            string ip = Request.HttpContext.Connection.LocalIpAddress.MapToIPv4().ToString();
            return await _filterIPService.CheckIP(ip);
        }
        /// <summary>
        /// 用户权限获取
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [ServiceFilter(typeof(LoginFilterAttribute))]
        public async Task<AlwaysResult> GetMenuList()
        {
            var data = await GetMenuButtonListNew();
            return new AlwaysResult<Dictionary<string, Dictionary<string, string>>> { state = ResultType.success.ToString(), data = data,count=data.Count() };
        }
        /// <summary>
        /// 菜单按钮信息
        /// </summary>
        /// <returns></returns>
        private async Task<Dictionary<string, Dictionary<string, string>>> GetMenuButtonListNew()
        {
            var currentuser =await _userService.GetLookForm(_userService.currentuser.UserId);
            var roleId = currentuser.F_RoleId;
            if (roleId == null && _userService.currentuser.IsSystem)
            {
                roleId = "admin";
            }
            var rolelist = roleId.Split(',');
            var dictionarylist = new Dictionary<string, Dictionary<string, string>>();
            if (_userService.currentuser.UserId == null)
            {
                return dictionarylist;
            }
            foreach (var roles in rolelist)
            {
                var dictionarytemp = new Dictionary<string, Dictionary<string,string>>();
                var data = await _roleAuthorizeService.GetDingMenuList(roles);
                var dataModuleId = data.Where(a => a.F_ModuleId != null && a.F_ModuleId != "").Distinct(new ExtList<ModuleButtonEntity>("F_ModuleId"));
                foreach (ModuleButtonEntity item in dataModuleId)
                {
                    var buttonList = data.Where(t => t.F_ModuleId == item.F_ModuleId).Select(a=>a.F_EnCode).ToList();
                    var dic = new Dictionary<string, string>();
                    foreach (var button in buttonList)
					{
                        dic.Add(button, button);
                    }
                    dictionarytemp.Add(item.F_ModuleId, dic);
                    if (dictionarylist.ContainsKey(item.F_ModuleId))
                    {
						foreach (var key in dic)
						{
							if (!dictionarylist[item.F_ModuleId].ContainsKey(key.Key))
							{
                                dictionarylist[item.F_ModuleId].Add(key.Key,key.Value);
                            }
                        }
                    }
                    else
                    {
                        dictionarylist.Add(item.F_ModuleId, dic);
                    }
                }
            }
            return dictionarylist;
        }
        /// <summary>
        /// 用户退出登录
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        [ServiceFilter(typeof(LoginFilterAttribute))]
        public async Task<AlwaysResult> LoginOff()
        {
            await _logService.WriteDbLog(new LogEntity
            {
                F_ModuleName = "用户Api",
                F_Type = DbLogType.Exit.ToString(),
                F_Account = _userService.currentuser.UserCode,
                F_NickName = _userService.currentuser.UserName,
                F_Result = true,
                F_Description = "安全退出系统",
            });
            await OperatorProvider.Provider.EmptyCurrent("api_");
            return new AlwaysResult { state = ResultType.success.ToString() };
        }
        #endregion

        #region 请求对象
        /// <summary>
        /// 登录请求对象
        /// </summary>
        public class LoginRequest
        {
            /// <summary>
            /// 用户名
            /// </summary>
            [Required(ErrorMessage = "用户名不能为空")]
            public string userName { get; set; }
            /// <summary>
            /// 密码
            /// </summary>
            [Required(ErrorMessage = "密码不能为空")]
            public string password { get; set; }
            /// <summary>
            /// 域名
            /// </summary>
            public string localurl { get; set; }

        }
        /// <summary>
        /// 登录请求对象
        /// </summary>
        public class DingLoginRequest
        {
            /// <summary>
            /// 用户名
            /// </summary>
            [Required(ErrorMessage = "用户名不能为空")]
            public string userName { get; set; }
            /// <summary>
            /// 密码
            /// </summary>
            [Required(ErrorMessage = "密码不能为空")]
            public string password { get; set; }
            /// <summary>
            /// 授权码
            /// </summary>
            [Required(ErrorMessage = "授权码不能为空")]
            public string code { get; set; }
            /// <summary>
            /// 域名
            /// </summary>
            public string localurl { get; set; }

        }

        public class DingLoginResponse
        { 
            public string apitoken { get; set; }
            public string userid { get; set; }
            public string username { get; set; }
            public string mainurl { get; set; }
        }

        #endregion
    }
}
