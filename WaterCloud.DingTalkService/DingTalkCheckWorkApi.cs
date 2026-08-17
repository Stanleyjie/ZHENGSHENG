using DingTalk.Api;
using DingTalk.Api.Request;
using DingTalk.Api.Response;
using System;
using System.Collections.Generic;
using System.Linq;

namespace WaterCloud.DingTalk
{
    /// <summary>
    /// 对钉钉用户（考勤）的业务操作
    /// 智创MES项目
    /// 相关API开发文档见：https://open-doc.dingtalk.com/microapp/serverapi2/ege851
    /// 需要结合钉钉API接口.Net版本动态库文件TopSdk，引用 DingTalk.Api
    /// 创建时间：2018-12-15
    /// </summary>
    public class DingTalkCheckWorkApi
    {
        /// <summary>
        /// 获取用户是否当值
        /// </summary>
        /// <param name="accessToken"></param>
        /// <param name="code"></param>
        /// <returns></returns>
        public static List<string> CheckWorkOn(string accessToken, string opUserId,string userIds)
        {
            try
            {
                IDingTalkClient client = new DefaultDingTalkClient("https://oapi.dingtalk.com/topapi/attendance/schedule/listbyusers");
                OapiAttendanceScheduleListbyusersRequest req = new OapiAttendanceScheduleListbyusersRequest();
                req.OpUserId= opUserId;
                req.Userids= userIds;
                var now = DateTime.Now;
                var starttime = DateTime.Now.Date.AddHours(8);
                var endtime = DateTime.Now.Date.AddHours(20);
                if (now.Hour <8)
				{
                    starttime = DateTime.Now.Date.AddDays(-1).AddHours(8);
                    endtime = DateTime.Now.Date.AddDays(-1).AddHours(20);
                }
                req.FromDateTime = DingTalkUtils.DateTimeToTimeStamp(starttime.ToUniversalTime());
                req.ToDateTime = DingTalkUtils.DateTimeToTimeStamp(endtime.ToUniversalTime());
                req.SetHttpMethod("POST");
                List<string> list = new List<string>();
                OapiAttendanceScheduleListbyusersResponse rsp = client.Execute(req, accessToken);
                if (rsp != null && rsp.Errcode == 0)
                {
                    if (rsp.Result.Count > 0)
                    {
						foreach (var item in rsp.Result.GroupBy(a => a.Userid).Select(a=>a.Key))
						{
                            var lists=rsp.Result.Where(a => a.Userid == item).ToList();
                            var start = lists.Where(a => a.CheckType == "OnDuty").FirstOrDefault();
                            var end = lists.Where(a => a.CheckType == "OffDuty").FirstOrDefault();
							if (start.IsRest == "Y")
							{
                                continue;
							}
                            if (end == null)
                            {
                                if (now >= DateTime.Parse(start.PlanCheckTime))
                                {
                                    list.Add(item);
                                }
                            }
                            else
                            {
                                if (now <= DateTime.Parse(end.PlanCheckTime) && now >= DateTime.Parse(start.PlanCheckTime))
                                {
                                    list.Add(item);
                                }
                            }
						}
                    }
                }
                return list;
            }
            catch (Exception)
            {
                return null;
            }
        }
    }
}
