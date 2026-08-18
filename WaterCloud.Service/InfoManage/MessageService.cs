using System;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;
using WaterCloud.Code;
using Chloe;
using WaterCloud.Domain.InfoManage;
using Microsoft.AspNetCore.SignalR;
using WaterCloud.Domain.SystemOrganize;
using WaterCloud.Service.DingTalkManage;
using WaterCloud.DingTalk;
using WaterCloud.Domain.DingTalkManage;
using WaterCloud.Service.SystemManage;
using System.Text;
using System.Net.Http;
using WaterCloud.Domain.SystemManage;

namespace WaterCloud.Service.InfoManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2020-07-29 16:41
    /// 描 述：通知管理服务类
    /// </summary>
    public class MessageService : DataFilterService<MessageEntity>, IDenpendency
    {
        private string cacheHubKey = "watercloud_hubuserinfo_";

        private readonly IHubContext<MessageHub> _messageHub;
        private ItemsDataService itemsApp;
        private IHttpClientFactory _httpClientFactory;
        private DingTalkConfigService _dingService;
        public MessageService(IDbContext context, IHttpClientFactory httpClientFactory, IHubContext<MessageHub> messageHub = null) : base(context)
        {
            itemsApp = new ItemsDataService(context);
            _dingService = new DingTalkConfigService(context);
            _messageHub = messageHub;
            _httpClientFactory = httpClientFactory;
        }
        #region 获取数据
        public async Task<List<MessageEntity>> GetList(string keyword = "")
        {
            var cachedata = repository.IQueryable();
            if (!string.IsNullOrEmpty(keyword))
            {
                //此处需修改
                cachedata = cachedata.Where(t => t.F_MessageInfo.Contains(keyword) || t.F_CreatorUserName.Contains(keyword));
            }
            return cachedata.Where(a => a.F_EnabledMark == true).OrderByDesc(t => t.F_CreatorTime).ToList();
        }

        public async Task<List<MessageEntity>> GetLookList(string keyword = "")
        {
            var query = repository.IQueryable().Where(a => a.F_EnabledMark == true);
            if (!string.IsNullOrEmpty(keyword))
            {
                //此处需修改
                query = query.Where(t => t.F_MessageInfo.Contains(keyword) || t.F_CreatorUserName.Contains(keyword));
            }
            query = GetDataPrivilege("u", "", query);
            return query.OrderByDesc(t => t.F_CreatorTime).ToList();
        }

        public async Task<List<MessageEntity>> GetUnReadListJson()
        {
            var hisquery = uniwork.IQueryable<MessageHistoryEntity>(a => a.F_CreatorUserId == currentuser.UserId).Select(a => a.F_MessageId).ToList();
            var tempList= repository.IQueryable(a => a.F_MessageType == 2).InnerJoin<MessageHistoryEntity>((a, b) => a.F_Id == b.F_MessageId).Select((a, b) => a.F_Id).ToList();
            hisquery.AddRange(tempList);
            var query = repository.IQueryable(a => (a.F_ToUserId.Contains(currentuser.UserId) || a.F_ToUserId == "") && a.F_EnabledMark == true).Where(a => !hisquery.Contains(a.F_Id));
            return GetFieldsFilterDataNew("a",query.OrderByDesc(t => t.F_CreatorTime)).ToList();
        }

        public async Task<List<MessageEntity>> GetLookList(SoulPage<MessageEntity> pagination, string keyword = "")
        {
            //反格式化显示只能用"等于"，其他不支持
            Dictionary<string, Dictionary<string, string>> dic = new Dictionary<string, Dictionary<string, string>>();
            var setList = await itemsApp.GetItemList("MessageType");
            Dictionary<string, string> messageTypeTemp = new Dictionary<string, string>();
            foreach (var item in setList)
            {
                messageTypeTemp.Add(item.F_ItemName, item.F_ItemCode);
            }
            dic.Add("F_MessageType", messageTypeTemp);
            pagination = ChangeSoulData(dic, pagination);
            var query = repository.IQueryable().Where(a => a.F_EnabledMark == true);
            if (!string.IsNullOrEmpty(keyword))
            {
                //此处需修改
                query = query.Where(t => t.F_MessageInfo.Contains(keyword) || t.F_CreatorUserName.Contains(keyword));
            }
            query = GetDataPrivilege("u", "", query);
            return await repository.OrderList(query, pagination);
        }

        public async Task<MessageEntity> GetForm(long keyValue)
        {
            var cachedata = await repository.FindEntity(keyValue);
            return cachedata;
        }
        #endregion

        public async Task<MessageEntity> GetLookForm(long keyValue)
        {
            var cachedata = await repository.FindEntity(keyValue);
            return GetFieldsFilterData(cachedata);
        }

        #region 提交数据
        public async System.Threading.Tasks.Task SubmitForm(MessageEntity entity,bool isWork=false,bool isSendDing=true)
        {
            entity.F_Id=0;
            entity.F_EnabledMark = true;
            entity.F_CreatorUserId=currentuser.UserId;
            entity.F_CreatorTime=DateTime.Now;
            entity.F_CreatorUserName= currentuser.UserName;
            MessageEntity messageEntity = new MessageEntity();
            List<string> list = new List<string>();
            if (string.IsNullOrEmpty(entity.F_ToUserId))
            {
                entity.F_ToUserName = "所有人";
                entity.F_ToUserId = "";
                messageEntity = await repository.Insert(entity);
                //钉钉信息
                list = uniwork.IQueryable<DingUserEntity>().Select(a => a.F_UserId).ToList();
            }
            else
            {
                var users = entity.F_ToUserId.Split(",").ToList();
                entity.F_ToUserName = string.Join(",", uniwork.IQueryable<UserEntity>(a => users.Contains(a.F_Id)).Select(a => a.F_RealName).ToList());
                messageEntity = await repository.Insert(entity);
                //钉钉信息
                list = uniwork.IQueryable<DingUserEntity>().Where(a => users.Contains(a.F_SysUserId)).Select(a => a.F_UserId).ToList();

            }
            //发送钉钉信息
            var dingconfig = await _dingService.GetAppletForm(isWork);
            var dingdingtoken = await CacheHelper.Get<string>(dingconfig.F_AgentId);
            if (string.IsNullOrEmpty(dingdingtoken))
            {

                string appKey = dingconfig.F_AppKey;
                string appSecret = dingconfig.F_AppSecret;
                dingdingtoken = DingTalkHelper.GetAccessToken2(appKey, appSecret);
                await CacheHelper.Set(dingconfig.F_AgentId, dingdingtoken,2,false);
            }
			if (isWork)
			{
                list = uniwork.IQueryable<DingUserEntity>(a => a.F_IsWork == true && list.Contains(a.F_UserId)).Select(a => a.F_UserId).ToList();
			}
			if (isSendDing)
			{
                await WorkMessageApi.SendDingMsg(dingdingtoken, dingconfig.F_AgentId, list, messageEntity.F_MessageInfo, "您有一条新消息", dingconfig.F_Url);
            }
            //通过http发送即时消息
            messageEntity.companyId = currentuser.CompanyId;
            var mouduleName = ReflectionHelper.GetModuleName(1);
            var module = uniwork.IQueryable<ModuleEntity>(a => a.F_EnCode == mouduleName).FirstOrDefault();
			await SendWebSocketMsg(messageEntity);
		}

        public async System.Threading.Tasks.Task SubmitFormAutoSend(MessageEntity entity, bool isWork = false, bool isSendDing = true)
        {
            entity.F_Id = 0;
            entity.F_EnabledMark = true;
            entity.F_CreatorUserId = currentuser.UserId;
            entity.F_CreatorTime = DateTime.Now;
            entity.F_CreatorUserName = currentuser.UserName;
            MessageEntity messageEntity = new MessageEntity();
            List<string> list = new List<string>();
            if (string.IsNullOrEmpty(entity.F_ToUserId))
            {
                entity.F_ToUserName = "所有人";
                entity.F_ToUserId = "";
                messageEntity = await repository.Insert(entity);
                //钉钉信息
                list = uniwork.IQueryable<DingUserEntity>().Select(a => a.F_UserId).ToList();
            }
            else
            {
                var users = entity.F_ToUserId.Split(",").ToList();
                entity.F_ToUserName = string.Join(",", uniwork.IQueryable<UserEntity>(a => users.Contains(a.F_Id)).Select(a => a.F_RealName).ToList());
                messageEntity = await repository.Insert(entity);
                //钉钉信息
                list = uniwork.IQueryable<DingUserEntity>().Where(a => users.Contains(a.F_SysUserId)).Select(a => a.F_UserId).ToList();

            }
            //发送钉钉信息
            var dingconfig = await _dingService.GetAppletForm(isWork);
            var dingdingtoken = await CacheHelper.Get<string>(dingconfig.F_AgentId);
            if (string.IsNullOrEmpty(dingdingtoken))
            {

                string appKey = dingconfig.F_AppKey;
                string appSecret = dingconfig.F_AppSecret;
                dingdingtoken = DingTalkHelper.GetAccessToken2(appKey, appSecret);
                await CacheHelper.Set(dingconfig.F_AgentId, dingdingtoken, 2, false);
            }
            if (isWork)
            {
                list = uniwork.IQueryable<DingUserEntity>(a => a.F_IsWork == true && list.Contains(a.F_UserId)).Select(a => a.F_UserId).ToList();
            }
            if (isSendDing)
            {
                await WorkMessageApi.SendDingMsgAutoSend(dingdingtoken, dingconfig.F_AgentId, list, messageEntity.F_MessageInfo, "您有一条新消息", dingconfig.F_Url);
            }
            //通过http发送即时消息
            messageEntity.companyId = currentuser.CompanyId;
            var mouduleName = ReflectionHelper.GetModuleName(1);
            var module = uniwork.IQueryable<ModuleEntity>(a => a.F_EnCode == mouduleName).FirstOrDefault();
            await SendWebSocketMsg(messageEntity);
        }

        public async System.Threading.Tasks.Task SendWebSocketMsg(MessageEntity messageEntity)
		{
            //未注入SignalR Hub时跳过实时推送（消息已入库）
            if (_messageHub == null)
            {
                return;
            }
            if (!string.IsNullOrEmpty(messageEntity.companyId) && messageEntity.F_ToUserId.Length==0)
			{
                await _messageHub.Clients.Group(messageEntity.companyId).SendAsync("ReceiveMessage", messageEntity.ToJson());
            }
            else
			{
                var users = messageEntity.F_ToUserId.Split(',');
                foreach (var item in users)
                {
                    //存在就私信
                    var connectionIDs = await CacheHelper.Get<List<string>>(cacheHubKey + item);
                    if (connectionIDs == null)
                    {
                        continue;
                    }
                    foreach (var connectionID in connectionIDs)
                    {
                        await _messageHub.Clients.Client(connectionID).SendAsync("ReceiveMessage", messageEntity.ToJson());
                    }
                }
            }
        }
        public async System.Threading.Tasks.Task ReadAllMsgForm(int type)
        {
            var unList=await GetUnReadListJson();
            var strList = unList.Where(a => a.F_MessageType == type&&a.F_ClickRead==true).Select(a=>a.F_Id).ToList();
            uniwork.BeginTrans();
            foreach (var item in strList)
            {
               await ReadMsgForm(item);
            }
            uniwork.Commit();
        }

        public async System.Threading.Tasks.Task ReadMsgForm(long keyValue)
        {            
            MessageHistoryEntity msghis = new MessageHistoryEntity();
            msghis.F_Id = 0;
            msghis.F_CreatorUserId = currentuser.UserId;
            msghis.F_CreatorTime = DateTime.Now;
            msghis.F_CreatorUserName = currentuser.UserName;
            msghis.F_MessageId = keyValue;
            await uniwork.Insert(msghis);
        }

        public async Task<bool> CheckMsg(long keyValue)
        {
            var msg = await repository.FindEntity(keyValue);
            if (msg==null)
            {
                return true;
            }
            if (msg.F_ClickRead==false)
            {
                return true;
            }
            if (uniwork.IQueryable<MessageHistoryEntity>(a => a.F_MessageId == keyValue && a.F_CreatorUserId == currentuser.UserId).Count() > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public async System.Threading.Tasks.Task DeleteForm(string keyValue)
        {
            var ids = keyValue.Split(',');
            await repository.Update(t => ids.Contains(t.F_Id.ToString()), t=>new MessageEntity { 
                F_EnabledMark=false         
            });
        }

        public async System.Threading.Tasks.Task SendDingTextMsgByIds(List<string> DingUserIdList,string content)
        {
            //发送钉钉信息
            var dingconfig = await _dingService.GetAppletForm(true);
            var dingdingtoken = await CacheHelper.Get<string>(dingconfig.F_AgentId);
            if (string.IsNullOrEmpty(dingdingtoken))
            {

                string appKey = dingconfig.F_AppKey;
                string appSecret = dingconfig.F_AppSecret;
                dingdingtoken = DingTalkHelper.GetAccessToken2(appKey, appSecret);
                await CacheHelper.Set(dingconfig.F_AgentId, dingdingtoken, 2, false);
            }
            WorkMessageApi.SendMessagebyText(dingdingtoken, long.Parse(dingconfig.F_AgentId), EnumClass.RecvType.UseridList, DingUserIdList, content);

        }

        public async System.Threading.Tasks.Task<SendWorkMessageResult> SendDingTextMsgByIdsExtend(List<string> DingUserIdList, string content)
        {
            //发送钉钉信息
            var dingconfig = await _dingService.GetAppletForm(true);
            var dingdingtoken = await CacheHelper.Get<string>(dingconfig.F_AgentId);
            if (string.IsNullOrEmpty(dingdingtoken))
            {

                string appKey = dingconfig.F_AppKey;
                string appSecret = dingconfig.F_AppSecret;
                dingdingtoken = DingTalkHelper.GetAccessToken2(appKey, appSecret);
                await CacheHelper.Set(dingconfig.F_AgentId, dingdingtoken, 2, false);
            }
            return WorkMessageApi.SendMessagebyText(dingdingtoken, long.Parse(dingconfig.F_AgentId), EnumClass.RecvType.UseridList, DingUserIdList, content);

        }


        public async System.Threading.Tasks.Task SendDingCardMsgByIds(List<string> DingUserIdList, string title,string markdown,string single_title,string single_url)
        {
            //发送钉钉信息
            var dingconfig = await _dingService.GetAppletForm(true);
            var dingdingtoken = await CacheHelper.Get<string>(dingconfig.F_AgentId);
            if (string.IsNullOrEmpty(dingdingtoken))
            {

                string appKey = dingconfig.F_AppKey;
                string appSecret = dingconfig.F_AppSecret;
                dingdingtoken = DingTalkHelper.GetAccessToken2(appKey, appSecret);
                await CacheHelper.Set(dingconfig.F_AgentId, dingdingtoken, 2, false);
            }
            WorkMessageApi.SendMessagebyEntireActionCard(dingdingtoken, long.Parse(dingconfig.F_AgentId), EnumClass.RecvType.UseridList, DingUserIdList,title,markdown,single_title,single_url);

        }

        #endregion

    }
}
