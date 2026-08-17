using System;
using System.Threading.Tasks;
using System.Collections.Generic;
using WaterCloud.Code;
using Chloe;
using WaterCloud.Domain.MaterialManage;
using WaterCloud.Service.ClassTask;
using System.Net.Http;
using WaterCloud.Domain.QualityManage;
using WaterCloud.Domain.ReportRecord;
using System.Linq;
using WaterCloud.Service.SystemManage;

namespace WaterCloud.Service.ReportRecord
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2020-12-16 13:38
    /// 描 述：出库管理服务类
    /// </summary>
    public class ReportRecordService : DataFilterService<InStorageInfoEntity>, IDenpendency
    {
        private ControlJobService jobApp;
        private ItemsDataService itemsApp;
        public ReportRecordService(IDbContext context, IHttpClientFactory httpClientFactory) : base(context)
        {
            jobApp = new ControlJobService(context, httpClientFactory);
            itemsApp = new ItemsDataService(context);
        }
        #region 获取数据
        public async Task<Flow> GetMaterialFlow(string materialCode, string materialBatch)
        {
            Flow flow = new Flow();
            flow.lines = new List<FlowLine>();
            flow.nodes = new List<FlowNode>();
            flow.initNum = 2;
            flow.title = "物料追溯";
            List<MaterialReportInfo> list = new List<MaterialReportInfo>();
            MaterialReportInfo temp = new MaterialReportInfo();
            //定位数量（入库、入库绑定、产出、库存变动+）
            var inLogs = uniwork.IQueryable<InStorageInfoEntity>(a => a.F_MaterialCode == materialCode && a.F_OriginalBatch == materialBatch && a.F_IsTemp != true);
            if (inLogs.Sum(a=>a.F_Num)>0)
            {
                foreach (var item in inLogs.ToList())
                {
                    if (temp.num>0)
                    {
                        temp.num += item.F_Num;
                    }
                    else
                    {
                        temp.id = Utils.GetGuid();
                        temp.num = item.F_Num;
                        temp.materialBatch = item.F_OriginalBatch;
                        temp.materialCode = item.F_MaterialCode;
                        temp.materialName = item.F_MaterialName;
                        temp.sortCode = 0;                       
                    }
                }
            }
            var inbandingLogs = uniwork.IQueryable<InStorageInfoEntity>(a => a.F_MaterialCode == materialCode && a.F_MaterialBatch == materialBatch && a.F_IsTemp != true);
            if (inbandingLogs.Sum(a => a.F_Num) > 0)
            {
                foreach (var item in inbandingLogs.ToList())
                {
                    if (temp.num > 0)
                    {
                        temp.num += item.F_Num;
                    }
                    else
                    {
                        temp.id = Utils.GetGuid();
                        temp.num = item.F_Num;
                        temp.materialBatch = item.F_MaterialBatch;
                        temp.materialCode = item.F_MaterialCode;
                        temp.materialName = item.F_MaterialName;
                        temp.sortCode = 0;

                        //增加入库
                    }
                }
            }
            var outputLogs = uniwork.IQueryable<OutPutInfoEntity>(a => a.F_MaterialCode == materialCode && a.F_MaterialBatch== materialBatch && a.F_IsTemp != true);
            if (outputLogs.Sum(a => a.F_Num) > 0)
            {
                foreach (var item in outputLogs.ToList())
                {
                    if (temp.num > 0)
                    {
                        temp.num += item.F_Num;
                    }
                    else
                    {
                        temp.id = Utils.GetGuid();
                        temp.num = item.F_Num;
                        temp.materialBatch = item.F_MaterialBatch;
                        temp.materialCode = item.F_MaterialCode;
                        temp.materialName = item.F_MaterialName;
                        temp.sortCode = 0;
                    }
                }
            }
            var addchangeLogs = uniwork.IQueryable<StorageChangeInfoEntity>(a => a.F_MaterialCode == materialCode && a.F_MaterialBatch == materialBatch && a.F_Num < 0);
            if (addchangeLogs.Sum(a => a.F_Num) < 0)
            {
                foreach (var item in addchangeLogs.ToList())
                {
                    if (temp.num > 0)
                    {
                        temp.num -= item.F_Num;
                    }
                    else
                    {
                        temp.id = Utils.GetGuid();
                        temp.num =0 - item.F_Num;
                        temp.materialBatch = item.F_MaterialBatch;
                        temp.materialCode = item.F_MaterialCode;
                        temp.materialName = item.F_MaterialName;
                        temp.sortCode = 0;
                    }
                }
            }
            if (!string.IsNullOrEmpty(temp.id))
            {
                temp.logType = -1;
                list.Add(temp);
                BackMaterial(temp, flow.lines, list);
                NextMaterial(temp, flow.lines, list,true);
            }
            flow.areas = new List<FlowArea>();
            if (list.Count == 0)
            {
                return flow;
            }
            float allnum = list.GroupBy(a => a.sortCode).Select(a => new { a.Key, num = a.Count() }).Max(a => a.num);
            int max = list.Max(a => a.sortCode) ?? 0;
            int min = list.Min(a => a.sortCode) ?? 0;
            int alllength = (int)(150 * (allnum + 1));
            for (int i = min; i <= max; i++)
            {
                var reports = list.Where(a => a.sortCode == i).ToList();
                int tempnum = reports.Count();
                int count = 1;
                foreach (var item in reports)
                {
                    FlowNode node = new FlowNode();
                    if (i == min)
                    {
                        node.type = "start  round";
                        node.width = 120;
                        //node.left -= 60;
                    }
                    else if (i == max)
                    {
                        node.type = "end  round";
                        node.width = 120;
                        //node.left -= 60;
                    }
                    else
                    {
                        node.type = "node";
                        //node.left -= 60;
                    }

                    node.alt = true;
                    node.id = item.id;
                    node.name = item.logType>=0?(string.IsNullOrEmpty(item.eqpName)? item.num.ToString() : item.eqpName + "," + item.processName + ",消耗" + item.num) :item.materialName;
                    node.left = alllength * count / (tempnum + 1);

                    node.top = 100 + (i- min - 1) * 100;
                    node.setInfo = new Setinfo();
                    node.setInfo.Taged = item.logType==-1?1:0;
                    node.setInfo.UserName = item.materialCode;
                    node.setInfo.UserId = "";
                    node.setInfo.TagedTime = item.materialBatch;
                    node.setInfo.Description = "物料编号:" + item.materialCode + "," + "物料名称:" + item.materialName+ "," + "物料批号:" + item.materialBatch + "," + "数量:" + item.num
                        + (item.logType <0 || item.logType == null || string.IsNullOrEmpty(item.eqpName)? "":",设备名称:" +item.eqpName + ",工序名称:" + item.processName);
                    flow.nodes.Add(node);
                    count++;
                }
            }
            flow.initNum += flow.nodes.Count() + flow.lines.Count();
            return flow;
        }
        public async Task<List<MaterialEntity>> GetAllBadStorageInfoList(SoulPage<MaterialEntity> pagination, string keyword)
        {
            //反格式化显示只能用"等于"，其他不支持
            Dictionary<string, Dictionary<string, string>> dic = new Dictionary<string, Dictionary<string, string>>();
            var setList = await itemsApp.GetItemList("Mes_MaterialType");
            Dictionary<string, string> stateTemp = new Dictionary<string, string>();
            foreach (var item in setList)
            {
                stateTemp.Add(item.F_ItemName, item.F_ItemCode);
            }
            dic.Add("F_MaterialType", stateTemp);
            pagination = ChangeSoulData(dic, pagination);
            var result = new List<MaterialEntity>();
            var storage = uniwork.IQueryable<ScapMaterialEntity>().GroupBy(a => a.F_MaterialId).Select(a => new { a.F_MaterialId, F_ScapNum = Sql.Sum(a.F_ScapNum), F_ReturnNum = Sql.Sum(a.F_ReturnNum), F_OtherNum = Sql.Sum(a.F_Num - a.F_ScapNum - a.F_ReturnNum), F_Num = Sql.Sum(a.F_Num) });
            var list = uniwork.IQueryable<MaterialEntity>(a => a.F_DeleteMark == false && a.F_EnabledMark == true).LeftJoin(storage, (a, b) => b.F_MaterialId == a.F_Id)
                .Select((a, b) => new MaterialEntity
                {
                    F_Id = a.F_Id,
                    F_Customer = a.F_Customer,
                    F_CreatorTime = a.F_CreatorTime,
                    F_MaterialBy = a.F_MaterialBy,
                    F_MaterialCode = a.F_MaterialCode,
                    F_MaterialDescription = a.F_MaterialDescription,
                    F_MaterialName = a.F_MaterialName,
                    F_MaterialPic = a.F_MaterialPic,
                    F_MaterialSize = a.F_MaterialSize,
                    F_MaterialType = a.F_MaterialType,
                    F_MaterialUnit = a.F_MaterialUnit,
                    F_ModelRefer = a.F_ModelRefer,
                    F_WarmNum = a.F_WarmNum,
                    F_Num = b.F_MaterialId == null ? 0 : b.F_Num,
                    F_StorageNum = b.F_MaterialId == null ? 0 : b.F_OtherNum,
                    F_DoneNum = b.F_MaterialId == null ? 0 : b.F_ScapNum,
                    F_ReturnNum = b.F_MaterialId == null ? 0 : b.F_ReturnNum
                });
            if (!string.IsNullOrEmpty(keyword))
            {
                list = list.Where(u => u.F_MaterialCode.Contains(keyword) || u.F_MaterialName.Contains(keyword));
            }
            list = GetDataPrivilege("u", "AllBadStorageReport", list);
            result = await repository.OrderList(list, pagination);
            return result;
        }
        public async Task<List<MaterialEntity>> GetAllStorageInfoList(SoulPage<MaterialEntity> pagination, string keyword)
        {
            //反格式化显示只能用"等于"，其他不支持
            Dictionary<string, Dictionary<string, string>> dic = new Dictionary<string, Dictionary<string, string>>();
            var setList = await itemsApp.GetItemList("Mes_MaterialType");
            Dictionary<string, string> stateTemp = new Dictionary<string, string>();
            foreach (var item in setList)
            {
                stateTemp.Add(item.F_ItemName, item.F_ItemCode);
            }
            dic.Add("F_MaterialType", stateTemp);
            pagination = ChangeSoulData(dic, pagination);
            var result = new List<MaterialEntity>();
            var useNum=uniwork.IQueryable <EqpMaterialUseEntity>(a=>a.F_DoneNum!=a.F_Num).GroupBy(a => a.F_MaterialId).Select(a => new { a.F_MaterialId, num = Sql.Sum(a.F_Num)-Sql.Sum(a.F_DoneNum) });
            var storage = uniwork.IQueryable<StorageEntity>().GroupBy(a => a.F_MaterialId).Select(a => new { a.F_MaterialId, num = Sql.Sum(a.F_Num) });

            var InStoragebandingNum = uniwork.IQueryable<InStorageInfoEntity>(a => a.F_IsTemp == true).GroupBy(a => a.F_MaterialId).Select(a => new { a.F_MaterialId, num = Sql.Sum(a.F_Num) });
            var OutputInfobandingNum = uniwork.IQueryable<OutPutInfoEntity>(a => a.F_IsTemp == true&&1!=1).GroupBy(a => a.F_MaterialId).Select(a => new { a.F_MaterialId, num = Sql.Sum(a.F_Num) });


            var list = uniwork.IQueryable<MaterialEntity>(a => a.F_DeleteMark == false && a.F_EnabledMark == true)
                .LeftJoin(storage, (a, b) => b.F_MaterialId == a.F_Id)
                .LeftJoin(useNum, (a, b, c) => a.F_Id == c.F_MaterialId)
                .LeftJoin(InStoragebandingNum, (a, b, c, d) => a.F_Id == d.F_MaterialId)
                .LeftJoin(OutputInfobandingNum, (a, b, c, d, e) => a.F_Id == e.F_MaterialId)
                .Select((a, b, c,d,e) => new MaterialEntity
                {
                    F_Id = a.F_Id,
                    F_Customer = a.F_Customer,
                    F_CreatorTime = a.F_CreatorTime,
                    F_MaterialBy = a.F_MaterialBy,
                    F_MaterialCode = a.F_MaterialCode,
                    F_MaterialDescription = a.F_MaterialDescription,
                    F_MaterialName = a.F_MaterialName,
                    F_MaterialPic = a.F_MaterialPic,
                    F_MaterialSize = a.F_MaterialSize,
                    F_MaterialType = a.F_MaterialType,
                    F_MaterialUnit = a.F_MaterialUnit,
                    F_ModelRefer = a.F_ModelRefer,
                    F_WarmNum = a.F_WarmNum,
                    F_Num = (b.num ?? 0) + (c.num ?? 0)+(d.num ?? 0) + (e.num ?? 0),
                    F_StorageNum = b.num ?? 0,
                    F_DoneNum = c.num ?? 0,
                    F_BandingNum = (d.num ?? 0) + (e.num ?? 0)
                }) ;
            if (!string.IsNullOrEmpty(keyword))
            {
                list = list.Where(u => u.F_MaterialCode.Contains(keyword) || u.F_MaterialName.Contains(keyword));
            }
            list = GetDataPrivilege("u", "AllStorageReport", list);
            result = await repository.OrderList(list, pagination);
            return result;
        }
        public async Task<List<MaterialEntity>> GetAllStorageInfoList(string keyword)
        {
            var result = new List<MaterialEntity>();
            var useNum = uniwork.IQueryable<EqpMaterialUseEntity>(a => a.F_DoneNum != a.F_Num).GroupBy(a => a.F_MaterialId).Select(a => new { a.F_MaterialId, num = Sql.Sum(a.F_Num) - Sql.Sum(a.F_DoneNum) });
            var storage = uniwork.IQueryable<StorageEntity>().GroupBy(a => a.F_MaterialId).Select(a => new { a.F_MaterialId, num = Sql.Sum(a.F_Num) });

            var InStoragebandingNum = uniwork.IQueryable<InStorageInfoEntity>(a => a.F_IsTemp == true).GroupBy(a => a.F_MaterialId).Select(a => new { a.F_MaterialId, num = Sql.Sum(a.F_Num) });
           //1<>1半成品和成品产出 的 绑定暂不统计
            var OutputInfobandingNum = uniwork.IQueryable<OutPutInfoEntity>(a => a.F_IsTemp == true && 1 != 1).GroupBy(a => a.F_MaterialId).Select(a => new { a.F_MaterialId, num = Sql.Sum(a.F_Num) });

            var list = uniwork.IQueryable<MaterialEntity>(a => a.F_DeleteMark == false && a.F_EnabledMark == true).LeftJoin(storage, (a, b) => b.F_MaterialId == a.F_Id)
                .LeftJoin(useNum, (a, b, c) => a.F_Id == c.F_MaterialId)
                .LeftJoin(InStoragebandingNum, (a, b, c, d) => a.F_Id == d.F_MaterialId)
                .LeftJoin(OutputInfobandingNum, (a, b, c, d, e) => a.F_Id == e.F_MaterialId)
                .Select((a, b, c,d,e) => new MaterialEntity
                {
                    F_Id = a.F_Id,
                    F_Customer = a.F_Customer,
                    F_CreatorTime = a.F_CreatorTime,
                    F_MaterialBy = a.F_MaterialBy,
                    F_MaterialCode = a.F_MaterialCode,
                    F_MaterialDescription = a.F_MaterialDescription,
                    F_MaterialName = a.F_MaterialName,
                    F_MaterialPic = a.F_MaterialPic,
                    F_MaterialSize = a.F_MaterialSize,
                    F_MaterialType = a.F_MaterialType,
                    F_MaterialUnit = a.F_MaterialUnit,
                    F_ModelRefer = a.F_ModelRefer,
                    F_WarmNum = a.F_WarmNum,
                    F_Num = (b.num ?? 0) + (c.num ?? 0) + (d.num ?? 0) + (e.num ?? 0),
                    F_StorageNum = b.num ?? 0,
                    F_DoneNum = c.num ?? 0,
                    F_BandingNum = (d.num ?? 0) + (e.num ?? 0)
                });
            if (!string.IsNullOrEmpty(keyword))
            {
                list = list.Where(u => u.F_MaterialCode.Contains(keyword) || u.F_MaterialName.Contains(keyword));
            }
            return list.OrderBy("F_MaterialType desc,F_MaterialCode asc").ToList();
        }
        private void BackMaterial(MaterialReportInfo entity, List<FlowLine> lines, List<MaterialReportInfo> list)
        {
            switch (entity.logType)
            {
                case 0:
                    var inbandingLogs1 = uniwork.IQueryable<InStorageInfoEntity>(a => a.F_MaterialCode == entity.materialCode && a.F_MaterialBatch == entity.materialBatch && a.F_IsTemp != true);
                    if (inbandingLogs1.Sum(a => a.F_Num) > 0)
                    {
                        foreach (var item in inbandingLogs1.ToList())
                        {
                            MaterialReportInfo temp = list.Where(a => a.materialCode == entity.materialCode && a.materialBatch == item.F_OriginalBatch && a.logType == -4 && a.sortCode == entity.sortCode - 1).FirstOrDefault();
                            if (temp != null)
                            {
                                temp.num += item.F_Num;
                            }
                            else
                            {
                                temp = new MaterialReportInfo();
                                temp.id = Utils.GetGuid();
                                temp.logType = -4;
                                temp.num = item.F_Num;
                                temp.materialBatch = item.F_OriginalBatch;
                                temp.materialCode = item.F_MaterialCode;
                                temp.materialName = item.F_MaterialName;
                                temp.sortCode = entity.sortCode - 1;
                                list.Add(temp);
                                FlowLine line = new FlowLine();
                                line.id = Utils.CreateNo();
                                line.type = "sl";
                                line.name = "入库";
                                line.M = 0;
                                line.dash = false;
                                line.alt = true;
                                line.from = temp.id;
                                line.to = entity.id;
                                lines.Add(line);
                            }
                        }
                    }
                    break;
                case 2:
                    var comsumeLogs = uniwork.IQueryable<ConsumeInfoEntity>().InnerJoin<OutPutInfoEntity>((a, b) => a.F_OutPutId == b.F_Id && b.F_MaterialCode == entity.materialCode && b.F_MaterialBatch == entity.materialBatch && a.F_EqpName == entity.eqpName && b.F_IsTemp != true)
                        .Select((a, b) => a).ToList();
                    if (comsumeLogs.Sum(a => a.F_Num) > 0)
                    {
                        foreach (var item in comsumeLogs.ToList())
                        {
                            MaterialReportInfo temp = list.Where(a => a.materialCode == item.F_MaterialCode && a.materialBatch == item.F_MaterialBatch && a.sortCode == entity.sortCode - 1 && a.eqpName == entity.eqpName).FirstOrDefault();
                            if (temp != null)
                            {
                                temp.num += item.F_Num;
                            }
                            else
                            {
                                temp = new MaterialReportInfo();
                                temp.id = Utils.GetGuid();
                                temp.num = item.F_Num;
                                temp.materialBatch = item.F_MaterialBatch;
                                temp.materialCode = item.F_MaterialCode;
                                temp.materialName = item.F_MaterialName;
                                temp.sortCode = entity.sortCode - 1;
                                temp.eqpName = item.F_EqpName;
                                temp.processName = item.F_ProcessName;
                                temp.logType = -2;
                                list.Add(temp);
                                FlowLine line = new FlowLine();
                                line.id = Utils.CreateNo();
                                line.type = "sl";
                                line.name = "产出";
                                line.M = 0;
                                line.dash = false;
                                line.alt = true;
                                line.from = temp.id;
                                line.to = entity.id;
                                lines.Add(line);
                                if (list.Where(a => (a.logType < 0 || a.logType == null) && a.materialBatch == temp.materialBatch && a.materialCode == temp.materialCode).Count() < 2)
                                {
                                    BackMaterial(temp, lines, list);
                                }
								else
								{
                                    var othertemp = list.Where(a => (a.logType < 0 || a.logType == null) && a.materialBatch == temp.materialBatch && a.materialCode == temp.materialCode && a.id != temp.id).FirstOrDefault();
                                    var fromline= lines.Where(a => a.to == othertemp.id).FirstOrDefault();
                                    FlowLine line1 = new FlowLine();
                                    line1.id = Utils.CreateNo();
                                    line1.type = "sl";
                                    line1.name = "产出";
                                    line1.M = 0;
                                    line1.dash = false;
                                    line1.alt = true;
                                    line1.from = fromline.from;
                                    line1.to = temp.id;
                                    lines.Add(line1);
                                }
                            }
                        }
                    }
                    break;
                default:
                    var inLogs = uniwork.IQueryable<InStorageInfoEntity>(a => a.F_MaterialCode == entity.materialCode && a.F_MaterialBatch == entity.materialBatch && a.F_IsTemp != true);
                    if (inLogs.Sum(a => a.F_Num) > 0)
                    {
                        foreach (var item in inLogs.ToList())
                        {
                            MaterialReportInfo temp = list.Where(a => a.materialCode == entity.materialCode && a.materialBatch == entity.materialBatch && a.logType == 0 && a.sortCode == entity.sortCode - 1).FirstOrDefault();
                            if (temp != null)
                            {
                                temp.num += item.F_Num;
                            }
                            else
                            {
                                temp = new MaterialReportInfo();
                                temp.id = Utils.GetGuid();
                                temp.logType = 0;
                                temp.num = item.F_Num;
                                temp.materialBatch = item.F_MaterialBatch;
                                temp.materialCode = item.F_MaterialCode;
                                temp.materialName = item.F_MaterialName;
                                temp.sortCode = entity.sortCode - 1;
                                list.Add(temp);
                                FlowLine line = new FlowLine();
                                line.id = Utils.CreateNo();
                                line.type = "sl";
                                line.name = "上架";
                                line.M = 0;
                                line.dash = false;
                                line.alt = true;
                                line.from = temp.id;
                                line.to = entity.id;
                                lines.Add(line);
                                BackMaterial(temp, lines, list);
                            }
                        }
                    }
                    var inbandingLogs = uniwork.IQueryable<InStorageInfoEntity>(a => a.F_MaterialCode == entity.materialCode && a.F_OriginalBatch == entity.materialBatch && a.F_IsTemp != true);
                    if (inbandingLogs.Sum(a => a.F_Num) > 0)
                    {
                        foreach (var item in inbandingLogs.ToList())
                        {
                            MaterialReportInfo temp = list.Where(a => a.materialCode == entity.materialCode && a.materialBatch == entity.materialBatch && a.logType == 1 && a.sortCode == entity.sortCode - 1).FirstOrDefault();
                            if (temp != null)
                            {
                                temp.num += item.F_Num;
                            }
                            else
                            {
                                temp = new MaterialReportInfo();
                                temp.id = Utils.GetGuid();
                                temp.logType = 1;
                                temp.num = item.F_Num;
                                temp.materialBatch = item.F_OriginalBatch;
                                temp.materialCode = item.F_MaterialCode;
                                temp.materialName = item.F_MaterialName;
                                temp.sortCode = entity.sortCode - 1;
                                list.Add(temp);
                                FlowLine line = new FlowLine();
                                line.id = Utils.CreateNo();
                                line.type = "sl";
                                line.name = "入库";
                                line.M = 0;
                                line.dash = false;
                                line.alt = true;
                                line.from = temp.id;
                                line.to = entity.id;
                                lines.Add(line);
                            }
                        }
                    }
                    var outputLogs = uniwork.IQueryable<OutPutInfoEntity>(a => a.F_MaterialCode == entity.materialCode && a.F_MaterialBatch == entity.materialBatch && a.F_IsTemp != true);
                    if (outputLogs.Sum(a => a.F_Num) > 0)
                    {
                        foreach (var item in outputLogs.ToList())
                        {
                            MaterialReportInfo temp = list.Where(a => a.materialCode == entity.materialCode && a.materialBatch == entity.materialBatch && a.logType == 2 && a.sortCode == entity.sortCode - 1 && a.eqpName == item.F_EqpName).FirstOrDefault();
                            if (temp != null)
                            {
                                temp.num += item.F_Num;
                            }
                            else
                            {
                                temp = new MaterialReportInfo();
                                temp.id = Utils.GetGuid();
                                temp.logType = 2;
                                temp.num = item.F_Num;
                                temp.materialBatch = item.F_MaterialBatch;
                                temp.materialCode = item.F_MaterialCode;
                                temp.materialName = item.F_MaterialName;
                                temp.sortCode = entity.sortCode - 1;
                                temp.eqpName = item.F_EqpName;
                                temp.processName = item.F_ProcessName;
                                list.Add(temp);
                                FlowLine line = new FlowLine();
                                line.id = Utils.CreateNo();
                                line.type = "sl";
                                line.name = "产出";
                                line.M = 0;
                                line.dash = false;
                                line.alt = true;
                                line.from = temp.id;
                                line.to = entity.id;
                                lines.Add(line);
                                if (list.Where(a => (a.logType < 0 || a.logType == null) && a.materialBatch == temp.materialBatch && a.materialCode == temp.materialCode).Count() < 2)
                                {
                                    BackMaterial(temp, lines, list);
                                }
                                else
                                {
                                    var othertemp = list.Where(a => (a.logType < 0 || a.logType == null) && a.materialBatch == temp.materialBatch && a.materialCode == temp.materialCode && a.id != temp.id).FirstOrDefault();
                                    var fromline = lines.Where(a => a.to == othertemp.id).FirstOrDefault();
                                    FlowLine line1 = new FlowLine();
                                    line1.id = Utils.CreateNo();
                                    line1.type = "sl";
                                    line1.name = "产出";
                                    line1.M = 0;
                                    line1.dash = false;
                                    line1.alt = true;
                                    line1.from = fromline.from;
                                    line1.to = temp.id;
                                    lines.Add(line);
                                }
                            }
                        }
                    }
                    var addchangeLogs = uniwork.IQueryable<StorageChangeInfoEntity>(a => a.F_MaterialCode == entity.materialCode && a.F_MaterialBatch == entity.materialBatch && a.F_Num < 0);
                    if (addchangeLogs.Sum(a => a.F_Num) < 0)
                    {
                        foreach (var item in addchangeLogs.ToList())
                        {
                            MaterialReportInfo temp = list.Where(a => a.materialCode == entity.materialCode && a.materialBatch == entity.materialBatch && a.logType == 3 && a.sortCode == entity.sortCode - 1).FirstOrDefault();
                            if (temp != null)
                            {
                                temp.num -= item.F_Num;
                            }
                            else
                            {
                                temp = new MaterialReportInfo();
                                temp.id = Utils.GetGuid();
                                temp.logType = 3;
                                temp.num = 0 - item.F_Num;
                                temp.materialBatch = item.F_MaterialBatch;
                                temp.materialCode = item.F_MaterialCode;
                                temp.materialName = item.F_MaterialName;
                                temp.sortCode = entity.sortCode - 1;
                                list.Add(temp);
                                FlowLine line = new FlowLine();
                                line.id = Utils.CreateNo();
                                line.type = "sl";
                                line.name = "增加";
                                line.M = 0;
                                line.dash = false;
                                line.alt = true;
                                line.from = temp.id;
                                line.to = entity.id;
                                lines.Add(line);
                            }
                        }
                    }
                    break;
            }
        }
        private async void NextMaterial(MaterialReportInfo entity, List<FlowLine> lines, List<MaterialReportInfo> list,bool isbanding = false)
        {
            switch (entity.logType)
            {
                case 5:
                    var outputLogs = uniwork.IQueryable<ConsumeInfoEntity>().InnerJoin<OutPutInfoEntity>((a, b) => a.F_OutPutId == b.F_Id && a.F_MaterialCode == entity.materialCode && a.F_MaterialBatch == entity.materialBatch && a.F_EqpName == entity.eqpName && b.F_IsTemp == false).Select((a, b) => b);
                    if (outputLogs.Sum(a => a.F_Num) > 0)
                    {
                        foreach (var item in outputLogs.ToList())
                        {
                            MaterialReportInfo temp = list.Where(a => a.materialCode == item.F_MaterialCode && a.materialBatch == item.F_MaterialBatch && a.sortCode == entity.sortCode + 1).FirstOrDefault();
                            if (temp != null)
                            {
                                temp.num += item.F_Num;
								if (temp.eqpName!=entity.eqpName)
								{
                                    FlowLine line = new FlowLine();
                                    line.id = Utils.CreateNo();
                                    line.type = "sl";
                                    line.name = "产出";
                                    line.M = 0;
                                    line.dash = false;
                                    line.alt = true;
                                    line.from = entity.id;
                                    line.to = temp.id;
                                    lines.Add(line);
                                }
                            }
                            else
                            {
                                temp = new MaterialReportInfo();
                                temp.id = Utils.GetGuid();
                                temp.num = item.F_Num;
                                temp.materialBatch = item.F_MaterialBatch;
                                temp.materialCode = item.F_MaterialCode;
                                temp.materialName = item.F_MaterialName;
                                temp.sortCode = entity.sortCode + 1;
                                list.Add(temp);
                                FlowLine line = new FlowLine();
                                line.id = Utils.CreateNo();
                                line.type = "sl";
                                line.name = "产出";
                                line.M = 0;
                                line.dash = false;
                                line.alt = true;
                                line.from = entity.id;
                                line.to = temp.id;
                                lines.Add(line);
                                //增加同级消耗
                                var comsumeLogtemps = uniwork.IQueryable<ConsumeInfoEntity>(a => a.F_OutPutId == item.F_Id).Where(a => a.F_MaterialCode != entity.materialCode && a.F_EqpName == entity.eqpName);
                                foreach (var cstemp in comsumeLogtemps.ToList())
                                {
                                    var tempOther = list.Where(a => a.materialCode == cstemp.F_MaterialCode && a.materialBatch == cstemp.F_MaterialBatch && a.sortCode == entity.sortCode && a.eqpName == item.F_EqpName).FirstOrDefault();
                                    if (tempOther == null)
                                    {
                                        tempOther = new MaterialReportInfo();
                                        tempOther.id = Utils.GetGuid();
                                        tempOther.num = cstemp.F_Num;
                                        tempOther.materialBatch = cstemp.F_MaterialBatch;
                                        tempOther.materialCode = cstemp.F_MaterialCode;
                                        tempOther.materialName = cstemp.F_MaterialName;
                                        tempOther.eqpName = item.F_EqpName;
                                        tempOther.processName = item.F_ProcessName;
                                        tempOther.sortCode = entity.sortCode;
                                        list.Add(tempOther);
                                        FlowLine lineOther = new FlowLine();
                                        lineOther.id = Utils.CreateNo();
                                        lineOther.type = "sl";
                                        lineOther.name = "产出";
                                        lineOther.M = 0;
                                        lineOther.dash = false;
                                        lineOther.alt = true;
                                        lineOther.from = tempOther.id;
                                        lineOther.to = temp.id;
                                        lines.Add(lineOther);
                                    }
                                    else
                                    {
                                        tempOther.num += cstemp.F_Num;
                                    }
                                }
                                //增加库存增加
                                var addchangeLogs = uniwork.IQueryable<StorageChangeInfoEntity>(a => a.F_MaterialCode == item.F_MaterialCode && a.F_MaterialBatch == item.F_MaterialBatch && a.F_Num < 0);
                                if (addchangeLogs.Sum(a => a.F_Num) < 0)
                                {
                                    foreach (var change in addchangeLogs.ToList())
                                    {
                                        MaterialReportInfo temp1 = list.Where(a => a.materialCode == item.F_MaterialCode && a.materialBatch == item.F_MaterialBatch && a.logType == 3 && a.sortCode == entity.sortCode).FirstOrDefault();
                                        if (temp1 != null)
                                        {
                                            temp1.num -= change.F_Num;
                                        }
                                        else
                                        {
                                            temp1 = new MaterialReportInfo();
                                            temp1.id = Utils.GetGuid();
                                            temp1.logType = 3;
                                            temp1.num = 0 - change.F_Num;
                                            temp1.materialBatch = change.F_MaterialBatch;
                                            temp1.materialCode = change.F_MaterialCode;
                                            temp1.materialName = change.F_MaterialName;
                                            temp1.sortCode = entity.sortCode;
                                            list.Add(temp1);
                                            FlowLine line1 = new FlowLine();
                                            line1.id = Utils.CreateNo();
                                            line1.type = "sl";
                                            line1.name = "增加";
                                            line1.M = 0;
                                            line1.dash = false;
                                            line1.alt = true;
                                            line1.from = temp1.id;
                                            line1.to = temp.id;
                                            lines.Add(line1);
                                        }
                                        temp.num -= change.F_Num;
                                    }
                                }
                                NextMaterial(temp, lines, list);
                            }
                        }
                    }
                    break;
                default:
                    if (isbanding)
                    {
                        var inbandingLogs = uniwork.IQueryable<InStorageInfoEntity>(a => a.F_MaterialCode == entity.materialCode && a.F_OriginalBatch == entity.materialBatch && a.F_IsTemp != true);
                        if (inbandingLogs.Sum(a => a.F_Num) > 0)
                        {
                            foreach (var item in inbandingLogs.ToList())
                            {
                                MaterialReportInfo temp = list.Where(a => a.materialCode == entity.materialCode && a.materialBatch == item.F_MaterialBatch && a.logType == -3 && a.sortCode == entity.sortCode + 1).FirstOrDefault();
                                if (temp != null)
                                {
                                    temp.num += item.F_Num;
                                }
                                else
                                {
                                    temp = new MaterialReportInfo();
                                    temp.id = Utils.GetGuid();
                                    temp.logType = -3;
                                    temp.num = item.F_Num;
                                    temp.materialBatch = item.F_MaterialBatch;
                                    temp.materialCode = item.F_MaterialCode;
                                    temp.materialName = item.F_MaterialName;
                                    temp.sortCode = entity.sortCode + 1;
                                    list.Add(temp);
                                    FlowLine line = new FlowLine();
                                    line.id = Utils.CreateNo();
                                    line.type = "sl";
                                    line.name = "上架";
                                    line.M = 0;
                                    line.dash = false;
                                    line.alt = true;
                                    line.from = temp.id;
                                    line.to = entity.id;
                                    lines.Add(line);
                                    NextMaterial(temp, lines, list);
                                    var addchangeLogs = uniwork.IQueryable<StorageChangeInfoEntity>(a => a.F_MaterialCode == entity.materialCode && a.F_MaterialBatch == item.F_MaterialBatch && a.F_Num < 0);
                                    if (addchangeLogs.Sum(a => a.F_Num) < 0)
                                    {
                                        foreach (var change in addchangeLogs.ToList())
                                        {
                                            MaterialReportInfo temp1 = list.Where(a => a.materialCode == entity.materialCode && a.materialBatch == item.F_MaterialBatch && a.logType == 3 && a.sortCode == entity.sortCode).FirstOrDefault();
                                            if (temp1 != null)
                                            {
                                                temp1.num -= change.F_Num;
                                            }
                                            else
                                            {
                                                temp1 = new MaterialReportInfo();
                                                temp1.id = Utils.GetGuid();
                                                temp1.logType = 3;
                                                temp1.num = 0 - change.F_Num;
                                                temp1.materialBatch = change.F_MaterialBatch;
                                                temp1.materialCode = change.F_MaterialCode;
                                                temp1.materialName = change.F_MaterialName;
                                                temp1.sortCode = entity.sortCode ;
                                                list.Add(temp1);
                                                FlowLine line1 = new FlowLine();
                                                line1.id = Utils.CreateNo();
                                                line1.type = "sl";
                                                line1.name = "增加";
                                                line1.M = 0;
                                                line1.dash = false;
                                                line1.alt = true;
                                                line1.from = temp1.id;
                                                line1.to = temp.id;
                                                lines.Add(line1);
                                            }
                                            temp.num -= change.F_Num;
                                        }
                                    }
                                }
                            }
                        }
                    }
                    var outLogs = uniwork.IQueryable<OutStorageInfoEntity>(a => a.F_MaterialCode == entity.materialCode && a.F_MaterialBatch == entity.materialBatch && a.F_IsTemp != true);
                    if (outLogs.Sum(a => a.F_Num) > 0)
                    {
                        foreach (var item in outLogs.ToList())
                        {
                            MaterialReportInfo temp = list.Where(a => a.materialCode == entity.materialCode && a.materialBatch == entity.materialBatch && a.logType == 4 && a.sortCode == entity.sortCode + 1).FirstOrDefault();
                            if (temp != null)
                            {
                                temp.num += item.F_Num;
                            }
                            else
                            {
                                temp = new MaterialReportInfo();
                                temp.id = Utils.GetGuid();
                                temp.logType = 4;
                                temp.num = item.F_Num;
                                temp.materialBatch = item.F_MaterialBatch;
                                temp.materialCode = item.F_MaterialCode;
                                temp.materialName = item.F_MaterialName;
                                temp.sortCode = entity.sortCode + 1;
                                list.Add(temp);
                                FlowLine line = new FlowLine();
                                line.id = Utils.CreateNo();
                                line.type = "sl";
                                line.name = "出库";
                                line.M = 0;
                                line.dash = false;
                                line.alt = true;
                                line.from = entity.id;
                                line.to = temp.id;
                                lines.Add(line);
                            }
                        }
                    }
                    var comsumeLogs = uniwork.IQueryable<ConsumeInfoEntity>(a => a.F_MaterialCode == entity.materialCode && a.F_MaterialBatch == entity.materialBatch);
                    if (comsumeLogs.Sum(a => a.F_Num) > 0)
                    {
                        foreach (var item in comsumeLogs.ToList())
                        {
                            MaterialReportInfo temp = list.Where(a => a.materialCode == entity.materialCode && a.materialBatch == entity.materialBatch && a.logType == 5 && a.sortCode == entity.sortCode +1 && a.eqpName == item.F_EqpName).FirstOrDefault();
                            if (temp != null)
                            {
                                temp.num += item.F_Num;
                            }
                            else
                            {
                                temp = new MaterialReportInfo();
                                temp.id = Utils.GetGuid();
                                temp.logType = 5;
                                temp.num = item.F_Num;
                                temp.materialBatch = item.F_MaterialBatch;
                                temp.materialCode = item.F_MaterialCode;
                                temp.materialName = item.F_MaterialName;
                                temp.sortCode = entity.sortCode + 1;
                                temp.eqpName = item.F_EqpName;
                                temp.processName = item.F_ProcessName;
                                list.Add(temp);
                                FlowLine line = new FlowLine();
                                line.id = Utils.CreateNo();
                                line.type = "sl";
                                line.name = "消耗";
                                line.M = 0;
                                line.dash = false;
                                line.alt = true;
                                line.from = entity.id;
                                line.to = temp.id;
                                lines.Add(line);
                                if (list.Where(a => (a.logType == 5 || a.logType == null) && a.materialBatch == temp.materialBatch && a.materialCode == temp.materialCode && a.eqpName == temp.eqpName).Count() < 2)
                                {
                                    NextMaterial(temp, lines, list);
                                }
                            }
                        }
                    }
                    var downchangeLogs = uniwork.IQueryable<StorageChangeInfoEntity>(a => a.F_MaterialCode == entity.materialCode && a.F_MaterialBatch == entity.materialBatch && a.F_Num > 0 && a.F_NewTransferBoxCode == null);
                    if (downchangeLogs.Sum(a => a.F_Num) > 0)
                    {
                        foreach (var item in downchangeLogs.ToList())
                        {
                            MaterialReportInfo temp = list.Where(a => a.materialCode == entity.materialCode && a.materialBatch == entity.materialBatch && a.logType == 6 && a.sortCode == entity.sortCode + 1).FirstOrDefault();
                            if (temp != null)
                            {
                                temp.num += item.F_Num;
                            }
                            else
                            {
                                temp = new MaterialReportInfo();
                                temp.id = Utils.GetGuid();
                                temp.logType = 6;
                                temp.num = item.F_Num;
                                temp.materialBatch = item.F_MaterialBatch;
                                temp.materialCode = item.F_MaterialCode;
                                temp.materialName = item.F_MaterialName;
                                temp.sortCode = entity.sortCode + 1;
                                list.Add(temp);
                                FlowLine line = new FlowLine();
                                line.id = Utils.CreateNo();
                                line.type = "sl";
                                line.name = "减少";
                                line.M = 0;
                                line.dash = false;
                                line.alt = true;
                                line.from = entity.id;
                                line.to = temp.id;
                                lines.Add(line);
                            }
                        }
                    }
                    var badmaterialLogs = uniwork.IQueryable<ScapMaterialEntity>(a => a.F_MaterialCode == entity.materialCode && a.F_MaterialBatch == entity.materialBatch && a.F_IsTemp==false);
                    if (badmaterialLogs.Count() > 0)
                    {
                        foreach (var item in badmaterialLogs.ToList())
                        {
                            MaterialReportInfo temp = list.Where(a => a.materialCode == entity.materialCode && a.materialBatch == entity.materialBatch && a.logType == 7 && a.sortCode == entity.sortCode + 1).FirstOrDefault();
                            if (temp != null)
                            {
                                temp.num += 1;
                            }
                            else
                            {
                                temp = new MaterialReportInfo();
                                temp.id = Utils.GetGuid();
                                temp.logType = 7;
                                temp.num = 1;
                                temp.materialBatch = item.F_MaterialBatch;
                                temp.materialCode = item.F_MaterialCode;
                                temp.materialName = item.F_MaterialName;
                                temp.sortCode = entity.sortCode + 1;
                                list.Add(temp);
                                FlowLine line = new FlowLine();
                                line.id = Utils.CreateNo();
                                line.type = "sl";
                                line.name = "不良";
                                line.M = 0;
                                line.dash = false;
                                line.alt = true;
                                line.from = entity.id;
                                line.to = temp.id;
                                lines.Add(line);
                            }
                        }
                    }
                    break;
            }
        }
        public async Task<List<InStorageInfoEntity>> GetInStorageInfoList(SoulPage<InStorageInfoEntity> pagination, int timetype, string keyword)
        {
            //反格式化显示只能用"等于"，其他不支持
            Dictionary<string, Dictionary<string, string>> dic = new Dictionary<string, Dictionary<string, string>>();
            var setList = await itemsApp.GetItemList("Mes_MaterialType");
            Dictionary<string, string> stateTemp = new Dictionary<string, string>();
            foreach (var item in setList)
            {
                stateTemp.Add(item.F_ItemName, item.F_ItemCode);
            }
            dic.Add("F_MaterialType", stateTemp);
            pagination = ChangeSoulData(dic, pagination);
            var result = new List<InStorageInfoEntity>();
            DateTime startTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate();
            DateTime endTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate().AddDays(1);
            switch (timetype)
            {
                case 1:
                    break;
                case 2:
                    startTime = startTime.AddDays(-7);
                    break;
                case 3:
                    startTime = startTime.AddMonths(-1);
                    break;
                case 4:
                    startTime = startTime.AddMonths(-2);
                    break;
                default:
                    break;
            }
            var list = uniwork.IQueryable<InStorageInfoEntity>()
                .LeftJoin<InStorageEntity>((a, b) => a.F_InStorageId == b.F_Id).Select((a, b) => new InStorageInfoEntity
                {
                    F_Id = a.F_Id,
                    F_BandingTime = a.F_BandingTime,
                    F_BandingUserId = a.F_BandingUserId,
                    F_BandingUserName = a.F_BandingUserName,
                    F_CreatorTime = a.F_CreatorTime,
                    F_CreatorUserId = a.F_CreatorUserId,
                    F_CreatorUserName = a.F_CreatorUserName,
                    F_Description = a.F_Description,
                    F_EnabledMark = a.F_EnabledMark,
                    F_InStorageId = a.F_InStorageId,
                    F_LocationCode = a.F_LocationCode,
                    F_MaterialBatch = a.F_MaterialBatch,
                    F_MaterialCode = a.F_MaterialCode,
                    F_MaterialId = a.F_MaterialId,
                    F_MaterialName = a.F_MaterialName,
                    F_MaterialType = a.F_MaterialType,
                    F_MaterialUnit = a.F_MaterialUnit,
                    F_Num = a.F_Num,
                    F_OriginalBatch = a.F_OriginalBatch,
                    F_TransferBoxCode = a.F_TransferBoxCode,
                    F_InStorageCode = b.F_InStorageCode,
                    F_IsTemp=a.F_IsTemp
                }).Where(t => t.F_CreatorTime >= startTime && t.F_CreatorTime <= endTime && t.F_IsTemp!=true);
            if (!string.IsNullOrEmpty(keyword))
            {
                list = list.Where(u => u.F_TransferBoxCode.Contains(keyword) || u.F_LocationCode.Contains(keyword) || u.F_MaterialCode.Contains(keyword)
                 || u.F_MaterialName.Contains(keyword) || u.F_MaterialBatch.Contains(keyword));
            }
            list = GetDataPrivilege("u", "InStorageReport", list);
            result = await repository.OrderList(list, pagination);
            return result;
        }
        public async Task<List<OutStorageInfoEntity>> GetOutStorageInfoList(SoulPage<OutStorageInfoEntity> pagination, int timetype, string keyword)
        {
            //反格式化显示只能用"等于"，其他不支持
            Dictionary<string, Dictionary<string, string>> dic = new Dictionary<string, Dictionary<string, string>>();
            var setList = await itemsApp.GetItemList("Mes_MaterialType");
            Dictionary<string, string> stateTemp = new Dictionary<string, string>();
            foreach (var item in setList)
            {
                stateTemp.Add(item.F_ItemName, item.F_ItemCode);
            }
            dic.Add("F_MaterialType", stateTemp);
            pagination = ChangeSoulData(dic, pagination);
            var result = new List<OutStorageInfoEntity>();
            DateTime startTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate();
            DateTime endTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate().AddDays(1);
            switch (timetype)
            {
                case 1:
                    break;
                case 2:
                    startTime = startTime.AddDays(-7);
                    break;
                case 3:
                    startTime = startTime.AddMonths(-1);
                    break;
                case 4:
                    startTime = startTime.AddMonths(-2);
                    break;
                default:
                    break;
            }
            var list = uniwork.IQueryable<OutStorageInfoEntity>(a=>a.F_IsTemp!=true).InnerJoin<OutStorageEntity>((a, b) => a.F_OutStorageId == b.F_Id)
                .Select((a, b) => new OutStorageInfoEntity
                { 
                F_BandingTime=a.F_BandingTime,
                F_BandingUserId=a.F_BandingUserId,
                F_BandingUserName=a.F_BandingUserName,
                F_CreatorTime=a.F_CreatorTime,
                F_CreatorUserId=a.F_CreatorUserId,
                F_CreatorUserName=a.F_CreatorUserName,
                F_Description=a.F_Description,
                F_EnabledMark=a.F_EnabledMark,
                F_Id=a.F_Id,
                F_LocationCode=a.F_LocationCode,
                F_MaterialBatch=a.F_MaterialBatch,
                F_MaterialCode=a.F_MaterialCode,
                F_MaterialId=a.F_MaterialId,
                F_MaterialName=a.F_MaterialName,
                F_MaterialType=a.F_MaterialType,
                F_MaterialUnit=a.F_MaterialUnit,
                F_Num=a.F_Num,
                F_OutStorageCode=b.F_OutStorageCode,
                F_OutStorageId=a.F_OutStorageId,
                F_TransferBoxCode=a.F_TransferBoxCode,
                F_TargetTransferCode=a.F_TargetTransferCode,
                F_IsTemp=a.F_IsTemp,
                }).Where(t => t.F_BandingTime >= startTime && t.F_BandingTime <= endTime);
            if (!string.IsNullOrEmpty(keyword))
            {
                list = list.Where(u => u.F_TransferBoxCode.Contains(keyword) || u.F_LocationCode.Contains(keyword) || u.F_MaterialCode.Contains(keyword)
                 || u.F_MaterialName.Contains(keyword) || u.F_MaterialBatch.Contains(keyword));
            }
            list = GetDataPrivilege("u", "OutStorageReport", list);
            result = await repository.OrderList(list, pagination);
            return result;
        }
        public async Task<List<EqpMaterialUseEntity>> GetEqpUseInfoList(SoulPage<EqpMaterialUseEntity> pagination, int timetype, string keyword)
        {
            //反格式化显示只能用"等于"，其他不支持
            Dictionary<string, Dictionary<string, string>> dic = new Dictionary<string, Dictionary<string, string>>();
            var setList = await itemsApp.GetItemList("Mes_MaterialType");
            Dictionary<string, string> stateTemp = new Dictionary<string, string>();
            foreach (var item in setList)
            {
                stateTemp.Add(item.F_ItemName, item.F_ItemCode);
            }
            dic.Add("F_MaterialType", stateTemp);
            pagination = ChangeSoulData(dic, pagination);
            var result = new List<EqpMaterialUseEntity>();
            DateTime startTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate();
            DateTime endTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate().AddDays(1);
            switch (timetype)
            {
                case 1:
                    break;
                case 2:
                    startTime = startTime.AddDays(-7);
                    break;
                case 3:
                    startTime = startTime.AddMonths(-1);
                    break;
                case 4:
                    startTime = startTime.AddMonths(-2);
                    break;
                default:
                    break;
            }
            var list = uniwork.IQueryable<EqpMaterialUseEntity>().Where(t => t.F_CreatorTime >= startTime && t.F_CreatorTime <= endTime);
            if (!string.IsNullOrEmpty(keyword))
            {
                list = list.Where(u => u.F_TransferBoxCode.Contains(keyword) || u.F_EqpName.Contains(keyword) || u.F_MaterialCode.Contains(keyword)
                 || u.F_MaterialName.Contains(keyword) || u.F_MaterialBatch.Contains(keyword) || u.F_ProcessName.Contains(keyword));
            }
            list = GetDataPrivilege("u", "EqpMaterialUseReport", list);
            result = await repository.OrderList(list, pagination);
            return result;
        }
        public async Task<List<ReturnMaterialEntity>> GetReturnUseInfoList(SoulPage<ReturnMaterialEntity> pagination, int timetype, string keyword)
        {
            //反格式化显示只能用"等于"，其他不支持
            Dictionary<string, Dictionary<string, string>> dic = new Dictionary<string, Dictionary<string, string>>();
            var setList = await itemsApp.GetItemList("Mes_MaterialType");
            Dictionary<string, string> stateTemp = new Dictionary<string, string>();
            foreach (var item in setList)
            {
                stateTemp.Add(item.F_ItemName, item.F_ItemCode);
            }
            dic.Add("F_MaterialType", stateTemp);
            pagination = ChangeSoulData(dic, pagination);
            var result = new List<ReturnMaterialEntity>();
            DateTime startTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate();
            DateTime endTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate().AddDays(1);
            switch (timetype)
            {
                case 1:
                    break;
                case 2:
                    startTime = startTime.AddDays(-7);
                    break;
                case 3:
                    startTime = startTime.AddMonths(-1);
                    break;
                case 4:
                    startTime = startTime.AddMonths(-2);
                    break;
                default:
                    break;
            }
            var list = uniwork.IQueryable<ReturnMaterialEntity>().Where(t => t.F_CreatorTime >= startTime && t.F_CreatorTime <= endTime);
            if (!string.IsNullOrEmpty(keyword))
            {
                list = list.Where(u => u.F_TransferBoxCode.Contains(keyword) || u.F_EqpName.Contains(keyword) || u.F_MaterialCode.Contains(keyword)
                 || u.F_MaterialName.Contains(keyword) || u.F_MaterialBatch.Contains(keyword) || u.F_ProcessName.Contains(keyword));
            }
            list = GetDataPrivilege("u", "ReturnMaterialReport", list);
            result = await repository.OrderList(list, pagination);
            return result;
        }
        public async Task<List<ConsumeInfoEntity>> GetConsumeInfoList(SoulPage<ConsumeInfoEntity> pagination, int timetype, string keyword)
        {
            //反格式化显示只能用"等于"，其他不支持
            Dictionary<string, Dictionary<string, string>> dic = new Dictionary<string, Dictionary<string, string>>();
            var setList = await itemsApp.GetItemList("Mes_MaterialType");
            Dictionary<string, string> stateTemp = new Dictionary<string, string>();
            foreach (var item in setList)
            {
                stateTemp.Add(item.F_ItemName, item.F_ItemCode);
            }
            dic.Add("F_MaterialType", stateTemp);
            pagination = ChangeSoulData(dic, pagination);
            var result = new List<ConsumeInfoEntity>();
            DateTime startTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate();
            DateTime endTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate().AddDays(1);
            switch (timetype)
            {
                case 1:
                    break;
                case 2:
                    startTime = startTime.AddDays(-7);
                    break;
                case 3:
                    startTime = startTime.AddMonths(-1);
                    break;
                case 4:
                    startTime = startTime.AddMonths(-2);
                    break;
                default:
                    break;
            }
            var list = uniwork.IQueryable<ConsumeInfoEntity>().Where(t => t.F_CreatorTime >= startTime && t.F_CreatorTime <= endTime);
            if (!string.IsNullOrEmpty(keyword))
            {
                list = list.Where(u => u.F_TransferBoxCode.Contains(keyword) || u.F_EqpName.Contains(keyword) || u.F_MaterialCode.Contains(keyword)
                 || u.F_MaterialName.Contains(keyword) || u.F_MaterialBatch.Contains(keyword) || u.F_ProcessName.Contains(keyword));
            }
            list = GetDataPrivilege("u", "ConsumeReport", list);
            result = await repository.OrderList(list, pagination);
            return result;
        }
        public async Task<List<OutPutInfoEntity>> GetOutputInfoList(SoulPage<OutPutInfoEntity> pagination, int timetype, string keyword)
        {
            //反格式化显示只能用"等于"，其他不支持
            Dictionary<string, Dictionary<string, string>> dic = new Dictionary<string, Dictionary<string, string>>();
            var setList = await itemsApp.GetItemList("Mes_MaterialType");
            Dictionary<string, string> stateTemp = new Dictionary<string, string>();
            foreach (var item in setList)
            {
                stateTemp.Add(item.F_ItemName, item.F_ItemCode);
            }
            dic.Add("F_MaterialType", stateTemp);
            Dictionary<string, string> isTemp = new Dictionary<string, string>();
            isTemp.Add("是", "0");
            isTemp.Add("否", "1");
            dic.Add("F_IsTemp", isTemp);
            pagination = ChangeSoulData(dic, pagination);
            var result = new List<OutPutInfoEntity>();
            DateTime startTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate();
            DateTime endTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate().AddDays(1);
            switch (timetype)
            {
                case 1:
                    break;
                case 2:
                    startTime = startTime.AddDays(-7);
                    break;
                case 3:
                    startTime = startTime.AddMonths(-1);
                    break;
                case 4:
                    startTime = startTime.AddMonths(-2);
                    break;
                default:
                    break;
            }
            var list = uniwork.IQueryable<OutPutInfoEntity>().Where(t => t.F_BandingTime >= startTime && t.F_BandingTime <= endTime);
            if (!string.IsNullOrEmpty(keyword))
            {
                list = list.Where(u => u.F_TransferBoxCode.Contains(keyword) || u.F_LocationCode.Contains(keyword) || u.F_MaterialCode.Contains(keyword)
                 || u.F_MaterialName.Contains(keyword) || u.F_MaterialBatch.Contains(keyword));
            }
            list = GetDataPrivilege("u", "OutputReport", list);
            result = await repository.OrderList(list, pagination);
            return result;
        }
        public async Task<List<StorageChangeInfoEntity>> GetStorageChangeInfoList(SoulPage<StorageChangeInfoEntity> pagination, int timetype, string keyword)
        {
            //反格式化显示只能用"等于"，其他不支持
            Dictionary<string, Dictionary<string, string>> dic = new Dictionary<string, Dictionary<string, string>>();
            var setList = await itemsApp.GetItemList("Mes_MaterialType");
            Dictionary<string, string> stateTemp = new Dictionary<string, string>();
            foreach (var item in setList)
            {
                stateTemp.Add(item.F_ItemName, item.F_ItemCode);
            }
            dic.Add("F_MaterialType", stateTemp);
            pagination = ChangeSoulData(dic, pagination);
            var result = new List<StorageChangeInfoEntity>();
            DateTime startTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate();
            DateTime endTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate().AddDays(1);
            switch (timetype)
            {
                case 1:
                    break;
                case 2:
                    startTime = startTime.AddDays(-7);
                    break;
                case 3:
                    startTime = startTime.AddMonths(-1);
                    break;
                case 4:
                    startTime = startTime.AddMonths(-2);
                    break;
                default:
                    break;
            }
            var list = uniwork.IQueryable<StorageChangeInfoEntity>().Where(t => t.F_CreatorTime >= startTime && t.F_CreatorTime <= endTime);
            if (!string.IsNullOrEmpty(keyword))
            {
                list = list.Where(u => u.F_TransferBoxCode.Contains(keyword) || u.F_LocationCode.Contains(keyword) || u.F_MaterialCode.Contains(keyword)
                 || u.F_MaterialName.Contains(keyword) || u.F_MaterialBatch.Contains(keyword) || (u.F_NewTransferBoxCode != null && u.F_NewTransferBoxCode.Contains(keyword)) || (u.F_NewLocationCode != null && u.F_MaterialBatch.Contains(keyword))); ;
            }
            list = GetDataPrivilege("u", "StorageChangeReport", list);
            result = await repository.OrderList(list, pagination);

            return result;
        }
        #endregion


        #region 提交数据
        public async Task RemoveInStorageRecord(string keepTime)
        {
            DateTime operateTime = DateTime.Now;
            if (keepTime == "7")            //保留近一周
            {
                operateTime = DateTime.Now.AddDays(-7);
            }
            else if (keepTime == "1")       //保留近一个月
            {
                operateTime = DateTime.Now.AddMonths(-1);
            }
            else if (keepTime == "3")       //保留近三个月
            {
                operateTime = DateTime.Now.AddMonths(-2);
            }
            var expression = ExtLinq.True<InStorageInfoEntity>();
            expression = expression.And(t => t.F_CreatorTime <= operateTime);
            await uniwork.Delete<InStorageInfoEntity>(expression);
        }
        public async Task RemoveOutStorageRecord(string keepTime)
        {
            DateTime operateTime = DateTime.Now;
            if (keepTime == "7")            //保留近一周
            {
                operateTime = DateTime.Now.AddDays(-7);
            }
            else if (keepTime == "1")       //保留近一个月
            {
                operateTime = DateTime.Now.AddMonths(-1);
            }
            else if (keepTime == "3")       //保留近三个月
            {
                operateTime = DateTime.Now.AddMonths(-2);
            }
            var expression = ExtLinq.True<OutStorageInfoEntity>();
            expression = expression.And(t => t.F_CreatorTime <= operateTime);
            uniwork.BeginTrans();
            await uniwork.Delete(expression);
            var expression2 = ExtLinq.True<OutStorageInfoEntity>();
            expression2 = expression2.And(t => t.F_CreatorTime <= operateTime);
            await uniwork.Delete<OutStorageInfoEntity>(expression2);
            uniwork.Commit();
        }
        public async Task RemoveEqpUseRecord(string keepTime)
        {
            DateTime operateTime = DateTime.Now;
            if (keepTime == "7")            //保留近一周
            {
                operateTime = DateTime.Now.AddDays(-7);
            }
            else if (keepTime == "1")       //保留近一个月
            {
                operateTime = DateTime.Now.AddMonths(-1);
            }
            else if (keepTime == "3")       //保留近三个月
            {
                operateTime = DateTime.Now.AddMonths(-2);
            }
            var expression = ExtLinq.True<EqpMaterialUseEntity>();
            expression = expression.And(t => t.F_CreatorTime <= operateTime);
            uniwork.BeginTrans();
            await uniwork.Delete<EqpMaterialUseEntity>(expression);
            uniwork.Commit();
        }
        public async Task RemoveReturnUseRecord(string keepTime)
        {
            DateTime operateTime = DateTime.Now;
            if (keepTime == "7")            //保留近一周
            {
                operateTime = DateTime.Now.AddDays(-7);
            }
            else if (keepTime == "1")       //保留近一个月
            {
                operateTime = DateTime.Now.AddMonths(-1);
            }
            else if (keepTime == "3")       //保留近三个月
            {
                operateTime = DateTime.Now.AddMonths(-2);
            }
            var expression = ExtLinq.True<ReturnMaterialEntity>();
            expression = expression.And(t => t.F_CreatorTime <= operateTime);
            uniwork.BeginTrans();
            await uniwork.Delete<ReturnMaterialEntity>(expression);
            uniwork.Commit();
        }
        public async Task RemoveConsumeRecord(string keepTime)
        {
            DateTime operateTime = DateTime.Now;
            if (keepTime == "7")            //保留近一周
            {
                operateTime = DateTime.Now.AddDays(-7);
            }
            else if (keepTime == "1")       //保留近一个月
            {
                operateTime = DateTime.Now.AddMonths(-1);
            }
            else if (keepTime == "3")       //保留近三个月
            {
                operateTime = DateTime.Now.AddMonths(-2);
            }
            var expression = ExtLinq.True<ConsumeInfoEntity>();
            expression = expression.And(t => t.F_CreatorTime <= operateTime);
            uniwork.BeginTrans();
            await uniwork.Delete<ConsumeInfoEntity>(expression);
            uniwork.Commit();
        }
        public async Task RemoveOutputRecord(string keepTime)
        {
            DateTime operateTime = DateTime.Now;
            if (keepTime == "7")            //保留近一周
            {
                operateTime = DateTime.Now.AddDays(-7);
            }
            else if (keepTime == "1")       //保留近一个月
            {
                operateTime = DateTime.Now.AddMonths(-1);
            }
            else if (keepTime == "3")       //保留近三个月
            {
                operateTime = DateTime.Now.AddMonths(-2);
            }
            var expression = ExtLinq.True<OutPutInfoEntity>();
            expression = expression.And(t => t.F_CreatorTime <= operateTime);
            uniwork.BeginTrans();
            await uniwork.Delete<OutPutInfoEntity>(expression);
            uniwork.Commit();
        }
        public async Task RemoveStorageChangeRecord(string keepTime)
        {
            DateTime operateTime = DateTime.Now;
            if (keepTime == "7")            //保留近一周
            {
                operateTime = DateTime.Now.AddDays(-7);
            }
            else if (keepTime == "1")       //保留近一个月
            {
                operateTime = DateTime.Now.AddMonths(-1);
            }
            else if (keepTime == "3")       //保留近三个月
            {
                operateTime = DateTime.Now.AddMonths(-2);
            }
            var expression = ExtLinq.True<StorageChangeInfoEntity>();
            expression = expression.And(t => t.F_CreatorTime <= operateTime);
            uniwork.BeginTrans();
            await uniwork.Delete<StorageChangeInfoEntity>(expression);
            uniwork.Commit();
        }

        public async Task SubmitAllStorageForm(int? num, string keyValue)
        {
            string cacheKey = "watercloud_materialdata_";
            var ids = keyValue.Split(',');
            await uniwork.Update<MaterialEntity>(a => ids.Contains(a.F_Id), a => new MaterialEntity
            {
                F_WarmNum=num
            });
            foreach (var item in ids)
            {
                await CacheHelper.Remove(cacheKey + item);
            }
            await CacheHelper.Remove(cacheKey + "list");
        }
        #endregion

    }
}
