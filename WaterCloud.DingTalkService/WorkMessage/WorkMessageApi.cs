using DingTalk.Api;
using DingTalk.Api.Request;
using DingTalk.Api.Response;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace WaterCloud.DingTalk
{
    /// <summary>
    /// 钉钉通知消息发送业务操作
    /// 智创MES项目
    /// 相关API开发文档见：https://open-doc.dingtalk.com/microapp/serverapi2/pgoxpy
    /// 需要结合钉钉API接口.Net版本动态库文件TopSdk，引用 DingTalk.Api
    /// 创建时间：2018-12-15
    /// </summary>
    public class WorkMessageApi
    {
        /// <summary>
        /// 通知消息发送基础方法
        /// </summary>
        /// <param name="accessToken"></param>
        /// <param name="agentId"></param>
        /// <param name="sendtoType"></param>
        /// <param name="userList"></param>
        /// <param name="_msg"></param>
        /// <returns></returns>
        private static SendWorkMessageResult SendMessage(string accessToken, long agentId, EnumClass.RecvType sendtoType, List<string> userList, OapiMessageCorpconversationAsyncsendV2Request.MsgDomain _msg)
        {
            SendWorkMessageResult result= new SendWorkMessageResult();
            try
            {
                IDingTalkClient client = new DefaultDingTalkClient("https://oapi.dingtalk.com/topapi/message/corpconversation/asyncsend_v2");
                OapiMessageCorpconversationAsyncsendV2Request request = new OapiMessageCorpconversationAsyncsendV2Request();
                request.AgentId = agentId;

                StringBuilder listStr = new StringBuilder();
                foreach (string value in userList)
                {
                    if (!string.IsNullOrEmpty(value))
                    {
                        listStr.Append(value + ",");
                    }
                }
                listStr.Remove(listStr.Length - 1, 1);
                switch (sendtoType)
                {
                    case EnumClass.RecvType.UseridList:
                        request.UseridList = listStr.ToString();
                        request.ToAllUser = false;
                        break;
                    case EnumClass.RecvType.DeptList:
                        request.DeptIdList = listStr.ToString();
                        request.ToAllUser = false;
                        break;
                    case EnumClass.RecvType.AllUser:

                        request.ToAllUser = true;
                        break;
                }

                request.Msg_ = _msg;
                OapiMessageCorpconversationAsyncsendV2Response response = client.Execute(request, accessToken);
                if (response.Errcode==0)
                {
                    result = SendWorkMessageResult.CreateSuccessResult(response.Errcode,
                    response.Errmsg,
                    response.TaskId
                    );
                }else
                {
                    result = SendWorkMessageResult.CreateFailResult(response.Errcode,
                    response.Errmsg
                    );
                }
                return result;
               
            }
            catch(Exception ex)
            {
                return  SendWorkMessageResult.CreateFailResult(ex.Message);
            }
        }

        /// <summary>
        /// 发送文本消息
        /// </summary>
        /// <param name="accessToken"></param>
        /// <param name="agentId">微应用agentId</param>
        /// <param name="sendtoType">接收者类型</param>
        /// <param name="userList">接收者的用户userid列表，最大列表长度：20</param>
        /// <param name="textmsg">文本消息</param>
        /// <returns></returns>
        public static SendWorkMessageResult SendMessagebyText(string accessToken,long agentId,EnumClass.RecvType sendtoType, List<string> userList, string textmsg)
        {
            
            OapiMessageCorpconversationAsyncsendV2Request.MsgDomain msg = new OapiMessageCorpconversationAsyncsendV2Request.MsgDomain();
            msg.Msgtype="text";
            msg.Text=new OapiMessageCorpconversationAsyncsendV2Request.TextDomain();
            msg.Text.Content= textmsg;
            return SendMessage(accessToken, agentId, sendtoType, userList, msg);
        }

        /// <summary>
        /// 发送图片消息
        /// </summary>
        /// <param name="accessToken"></param>
        /// <param name="agentId">微应用agentId</param>
        /// <param name="sendtoType">接收者类型</param>
        /// <param name="userList">接收者的用户userid列表，最大列表长度：20</param>
        /// <param name="media_id">媒体文件id，可以通过媒体文件接口上传图片获取。建议宽600像素 x 400像素，宽高比3 : 2</param>
        /// <returns></returns>
        public static SendWorkMessageResult SendMessagebyImage(string accessToken, long agentId, EnumClass.RecvType sendtoType, List<string> userList, string media_id)
        {
            
            OapiMessageCorpconversationAsyncsendV2Request.MsgDomain msg = new OapiMessageCorpconversationAsyncsendV2Request.MsgDomain();
            msg.Msgtype = "image";
            msg.Image = new OapiMessageCorpconversationAsyncsendV2Request.ImageDomain();
            msg.Image.MediaId = media_id;
            return SendMessage(accessToken, agentId, sendtoType, userList, msg);
        }

        /// <summary>
        /// 语言消息
        /// </summary>
        /// <param name="accessToken"></param>
        /// <param name="agentId">微应用agentId</param>
        /// <param name="sendtoType">接收者类型</param>
        /// <param name="userList">接收者的用户userid列表，最大列表长度：20</param>
        /// <param name="media_id">媒体文件id。2MB，播放长度不超过60s，AMR格式</param>
        /// <returns></returns>
        public static SendWorkMessageResult SendMessagebyVoice(string accessToken, long agentId, EnumClass.RecvType sendtoType, List<string> userList, string media_id)
        {
           
            OapiMessageCorpconversationAsyncsendV2Request.MsgDomain msg = new OapiMessageCorpconversationAsyncsendV2Request.MsgDomain();
            msg.Msgtype = "voice";
            msg.Voice = new OapiMessageCorpconversationAsyncsendV2Request.VoiceDomain();
            msg.Voice.MediaId = media_id;
            return SendMessage(accessToken, agentId, sendtoType, userList, msg);
        }

        /// <summary>
        /// 发送文件消息
        /// </summary>
        /// <param name="accessToken"></param>
        /// <param name="agentId">微应用agentId</param>
        /// <param name="sendtoType">接收者类型</param>
        /// <param name="userList">接收者的用户userid列表，最大列表长度：20</param>
        /// <param name="media_id">媒体文件id。最大10MB</param>
        /// <returns></returns>
        public static SendWorkMessageResult SendMessagebyFile(string accessToken, long agentId, EnumClass.RecvType sendtoType, List<string> userList, string media_id)
        {
           
            OapiMessageCorpconversationAsyncsendV2Request.MsgDomain msg = new OapiMessageCorpconversationAsyncsendV2Request.MsgDomain();
            msg.Msgtype = "file";
            msg.File = new OapiMessageCorpconversationAsyncsendV2Request.FileDomain();
            msg.File.MediaId = media_id;
            return SendMessage(accessToken, agentId, sendtoType, userList, msg);
        }

        /// <summary>
        /// 发送链接消息
        /// </summary>
        /// <param name="accessToken"></param>
        /// <param name="agentId">微应用agentId</param>
        /// <param name="sendtoType">接收者类型</param>
        /// <param name="userList">接收者的用户userid列表，最大列表长度：20</param>
        /// <param name="title">标题</param>
        /// <param name="text">描述文本</param>
        /// <param name="picUrl">图片地址</param>
        /// <param name="linkUrl">链接地址</param>
        /// <returns></returns>
        public static SendWorkMessageResult SendMessagebyLink(string accessToken, long agentId, EnumClass.RecvType sendtoType, List<string> userList, string title,string text,string picUrl,string linkUrl)
        {
            
            OapiMessageCorpconversationAsyncsendV2Request.MsgDomain msg = new OapiMessageCorpconversationAsyncsendV2Request.MsgDomain();
            msg.Msgtype = "link";
            msg.Link = new OapiMessageCorpconversationAsyncsendV2Request.LinkDomain();
            msg.Link.Title = title;
            msg.Link.Text = text;
            msg.Link.PicUrl = picUrl;
            msg.Link.MessageUrl = linkUrl;
            return SendMessage(accessToken, agentId, sendtoType, userList, msg);
        }

        /// <summary>
        /// OA消息，未完善
        /// </summary>
        /// <param name="accessToken"></param>
        /// <param name="agentId">微应用agentId</param>
        /// <param name="sendtoType">接收者类型</param>
        /// <param name="userList">接收者的用户userid列表，最大列表长度：20</param>
        /// <returns></returns>
        public static SendWorkMessageResult SendMessagebyOa(string accessToken, long agentId, EnumClass.RecvType sendtoType, List<string> userList)
        {
           
            OapiMessageCorpconversationAsyncsendV2Request.MsgDomain msg = new OapiMessageCorpconversationAsyncsendV2Request.MsgDomain();
            msg.Msgtype = "text";
            msg.Text = new OapiMessageCorpconversationAsyncsendV2Request.TextDomain();
            msg.Text.Content = "test123";
            return SendMessage(accessToken, agentId, sendtoType, userList, msg);
        }


        /// <summary>
        /// 发送卡片消息ActionCard
        /// </summary>
        /// <param name="accessToken"></param>
        /// <param name="agentId">微应用agentId</param>
        /// <param name="sendtoType">接收者类型</param>
        /// <param name="userList">接收者的用户userid列表，最大列表长度：20
        /// <param name="title">标题</param>
        /// <param name="text">markdown格式的消息</param>
        /// <param name="linkTitle">链接标题</param>
        /// <param name="linkUrl">连接地址</param>
        /// <returns></returns>
        public static SendWorkMessageResult SendMessagebyActionCard(string accessToken, long agentId, EnumClass.RecvType sendtoType, List<string> userList, string title, string text, string linkTitle, string linkUrl)
        {
            OapiMessageCorpconversationAsyncsendV2Request.MsgDomain msg = new OapiMessageCorpconversationAsyncsendV2Request.MsgDomain();
            msg.Msgtype = "action_card";
            msg.ActionCard =new OapiMessageCorpconversationAsyncsendV2Request.ActionCardDomain();
            msg.ActionCard.Title= title;
            msg.ActionCard.Markdown = text;
            if (!string.IsNullOrEmpty(linkTitle) && !string.IsNullOrEmpty(linkUrl))
            {
                msg.ActionCard.BtnOrientation = "1";
                List<OapiMessageCorpconversationAsyncsendV2Request.BtnJsonListDomain> list = new List<OapiMessageCorpconversationAsyncsendV2Request.BtnJsonListDomain>();
                var temp= new OapiMessageCorpconversationAsyncsendV2Request.BtnJsonListDomain();
                temp.Title = linkTitle;
                temp.ActionUrl = linkUrl;
                list.Add(temp);
                msg.ActionCard.BtnJsonList = list;
            }
            return SendMessage(accessToken, agentId, sendtoType, userList, msg);
        }

        /// <summary>
        /// 发送Markdown富文本消息
        /// </summary>
        /// <param name="accessToken"></param>
        /// <param name="title">首屏会话透出的展示内容</param>
        /// <param name="text">markdown格式的富文本消息</param>
        /// <returns></returns>
        public static SendWorkMessageResult SendMessagebyMarkdown(string accessToken, long agentId, EnumClass.RecvType sendtoType, List<string> userList, string title, string text)
        {
          
            OapiMessageCorpconversationAsyncsendV2Request.MsgDomain msg = new OapiMessageCorpconversationAsyncsendV2Request.MsgDomain();
            msg.Msgtype = "markdown";
            msg.Markdown = new OapiMessageCorpconversationAsyncsendV2Request.MarkdownDomain();
            msg.Markdown.Title = title;
            msg.Markdown.Text = text;
            return SendMessage(accessToken, agentId, sendtoType, userList, msg);
        }
        public async static Task<SendWorkMessageResult> SendDingMsg(string token,string agentId, List<string> list, string msg, string title = "",string url="")
        {
            //发送钉钉信息
            string message = "Mes系统信息     \n" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "  \n\n";
            message += msg;
            //执勤通知
			if (list != null && list.Count > 0)
			{
                if (!string.IsNullOrEmpty(title) && !string.IsNullOrEmpty(url))
                {
                    return SendMessagebyActionCard(token, long.Parse(agentId), EnumClass.RecvType.UseridList, list, title, message, "查看详情", url);
                }
                return SendMessagebyText(token, long.Parse(agentId), EnumClass.RecvType.UseridList, list, message);
            }
            return null;
        }

        public async static Task<SendWorkMessageResult> SendDingMsgAutoSend(string token, string agentId, List<string> list, string msg, string title = "", string url = "")
        {
            //发送钉钉信息
            string message = "Mes系统指令(自动)     \n" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "  \n\n";
            message += msg;
            //执勤通知
            if (list != null && list.Count > 0)
            {
                if (!string.IsNullOrEmpty(title) && !string.IsNullOrEmpty(url))
                {
                    return SendMessagebyActionCard(token, long.Parse(agentId), EnumClass.RecvType.UseridList, list, title, message, "查看详情", url);
                }
                return SendMessagebyText(token, long.Parse(agentId), EnumClass.RecvType.UseridList, list, message);
            }
            return null;
        }

        /// <summary>
        /// 发送整体卡片消息ActionCard
        /// </summary>
        /// <param name="accessToken"></param>
        /// <param name="agentId">微应用agentId</param>
        /// <param name="sendtoType">接收者类型</param>
        /// <param name="userList">接收者的用户userid列表，最大列表长度：20
        /// <param name="title">标题</param>
        /// <param name="text">markdown格式的消息</param>
        /// <param name="linkTitle">链接标题</param>
        /// <param name="linkUrl">连接地址</param>
        /// <returns></returns>
        public static SendWorkMessageResult SendMessagebyEntireActionCard(string accessToken, long agentId, EnumClass.RecvType sendtoType, List<string> userList, string title, string text, string linkTitle, string linkUrl)
        {
            OapiMessageCorpconversationAsyncsendV2Request.MsgDomain msg = new OapiMessageCorpconversationAsyncsendV2Request.MsgDomain();
            msg.Msgtype = "action_card";
            msg.ActionCard = new OapiMessageCorpconversationAsyncsendV2Request.ActionCardDomain();
            msg.ActionCard.Title = title;
            msg.ActionCard.Markdown = text;
            msg.ActionCard.SingleTitle = linkTitle;
            msg.ActionCard.SingleUrl = linkUrl;

            //if (!string.IsNullOrEmpty(linkTitle) && !string.IsNullOrEmpty(linkUrl))
            //{
            //    msg.ActionCard.BtnOrientation = "1";
            //    List<OapiMessageCorpconversationAsyncsendV2Request.BtnJsonListDomain> list = new List<OapiMessageCorpconversationAsyncsendV2Request.BtnJsonListDomain>();
            //    var temp = new OapiMessageCorpconversationAsyncsendV2Request.BtnJsonListDomain();
            //    temp.Title = linkTitle;
            //    temp.ActionUrl = linkUrl;
            //    list.Add(temp);
            //    msg.ActionCard.BtnJsonList = list;
            //}
            return SendMessage(accessToken, agentId, sendtoType, userList, msg);
        }

    }

    /// <summary>
    /// 通知消息返回结果状态
    /// </summary>
    public class SendWorkMessageResult : DingTalkJsonResult
    {
        public SendWorkMessageResult() { }
        public long TaskId { get; set; }
        public static SendWorkMessageResult CreateSuccessResult(long errorCode, string errMsg, long task_id)
        {
            return new SendWorkMessageResult()
            {
                IsSuccess = true,
                Errcode = errorCode,
                Errmsg = errMsg,
                TaskId = task_id
            };
        }
        public static new SendWorkMessageResult CreateFailResult(string errMsg)
        {
            return new SendWorkMessageResult()
            {
                IsSuccess = false,
                Errcode = -1,
                Errmsg = errMsg
            };
        }

        public static new SendWorkMessageResult CreateFailResult(long errorCode, string errMsg)
        {
            return new SendWorkMessageResult()
            {
                IsSuccess = false,
                Errcode = errorCode,
                Errmsg = errMsg
            };
        }
    }
}
