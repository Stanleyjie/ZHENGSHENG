using System;
using System.Linq;
using System.Threading.Tasks;
using WaterCloud.Code;
using Chloe;
using WaterCloud.Domain.MaterialManage;
using System.Collections.Generic;
using WaterCloud.Domain.EquipmentManage;
using WaterCloud.Domain.ProcessManage;

namespace WaterCloud.Service.MaterialManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2020-12-01 12:23
    /// 描 述：模具物料绑定服务类
    /// </summary>
    public class MaterialBomService : DataFilterService<BomFormEntity>, IDenpendency
    {

        public MaterialBomService(IDbContext context) : base(context)
        {
        }
        #region 获取数据
        public async Task<List<MaterialEntity>> GetLookList(string keyValue, string itemId)
        {
            var query = repository.IQueryable(a => a.F_MaterialId == keyValue && a.F_BomType == 1 && a.F_ProcessId==itemId).LeftJoin<MaterialEntity>((a, b) => a.F_SonMaterialId== b.F_Id).Select((a, b) => new MaterialEntity { 
                F_Id=b.F_Id,
                F_MaterialBy=b.F_MaterialBy,
                F_Customer=b.F_Customer,
                F_CustomerProNO=b.F_CustomerProNO,
                F_MaterialCode=b.F_MaterialCode,
                F_CpkStData=b.F_CpkStData,
                F_EnabledMark=b.F_EnabledMark,
                F_MaterialName=b.F_MaterialName,
                F_MaterialDescription=b.F_MaterialDescription,
                F_MaterialPic=b.F_MaterialPic,
                F_MaterialSize=b.F_MaterialSize,
                F_MaterialType=b.F_MaterialType,
                F_MaterialUnit=b.F_MaterialUnit,
                F_Description=b.F_Description,
                F_DeleteMark=b.F_DeleteMark,
                F_Num=a.F_Num,
                F_ContainerNum=b.F_ContainerNum,
                F_ModelRefer=b.F_ModelRefer,
                F_ReceiveNum=b.F_ReceiveNum,
                F_NeedCheckout=b.F_NeedCheckout, 
                F_ProcessId=a.F_ProcessId
            });
            return query.ToList();

        }
        #endregion

        public async Task<MaterialEntity> GetLookForm(string keyValue,string itemId)
        {
            var cachedata = await uniwork.FindEntity<MaterialEntity>(keyValue);
            cachedata.listData = (await GetLookList(keyValue, itemId)).ToJson();
            return cachedata;
        }

		public async Task<List<MaterialEntity>> GetBomList(string keyValue, string itemId)
		{
            var query = repository.IQueryable(a => a.F_MaterialId == keyValue && a.F_BomType == 1 && a.F_ProcessId == itemId).LeftJoin<MaterialEntity>((a, b) => a.F_SonMaterialId == b.F_Id).Select((a, b) => b);
            return await query.ToListAsync();
        }

        #region 提交数据
        public async Task SubmitForm(BomFormEntity entity, string listData)
        {
            uniwork.BeginTrans();
            List<BomFormEntity> list = null;
            if (!string.IsNullOrEmpty(listData))
            {
                list = listData.ToList<BomFormEntity>();
                if (list.Any(a => a.F_SonMaterialId == a.F_MaterialId))
                    throw new Exception("bom构物料异常");
                //循环引用检测
                if (CheckBomCycle(entity.F_MaterialId, entity.F_ProcessId, list))
                    throw new Exception("BOM构成存在循环引用，子料号不能是其自身的上层料号，保存失败");
            }
            await repository.Delete(a => a.F_BomType == 1 && a.F_MaterialId == entity.F_MaterialId && a.F_ProcessId==entity.F_ProcessId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    item.Create();
                    item.F_MaterialId = entity.F_MaterialId;
                    item.F_ProcessId = entity.F_ProcessId;
                    item.F_DeleteMark = false;
                    item.F_BomType = 1;
                }
                await repository.Insert(list);
            }
            uniwork.Commit();
        }
        /// <summary>
        /// 循环引用检测：模拟删除被替换记录+插入新构成后的BOM图，存在环则返回true
        /// </summary>
        private bool CheckBomCycle(string parentId, string processId, List<BomFormEntity> newList)
        {
            var all = uniwork.IQueryable<BomFormEntity>(a => a.F_BomType == 1).ToList()
                .Where(a => !(a.F_MaterialId == parentId && a.F_ProcessId == processId)).ToList();
            Dictionary<string, List<string>> graph = new Dictionary<string, List<string>>();
            foreach (var b in all)
            {
                if (!graph.ContainsKey(b.F_MaterialId)) graph[b.F_MaterialId] = new List<string>();
                if (!graph[b.F_MaterialId].Contains(b.F_SonMaterialId)) graph[b.F_MaterialId].Add(b.F_SonMaterialId);
            }
            if (!graph.ContainsKey(parentId)) graph[parentId] = new List<string>();
            foreach (var item in newList)
            {
                if (!graph[parentId].Contains(item.F_SonMaterialId)) graph[parentId].Add(item.F_SonMaterialId);
            }
            Dictionary<string, int> state = new Dictionary<string, int>();
            foreach (var node in graph.Keys.ToList())
            {
                if (BomDfs(graph, node, state)) return true;
            }
            return false;
        }
        private bool BomDfs(Dictionary<string, List<string>> graph, string node, Dictionary<string, int> state)
        {
            if (!state.ContainsKey(node)) state[node] = 0;
            if (state[node] == 1) return true;
            if (state[node] == 2) return false;
            state[node] = 1;
            if (graph.ContainsKey(node))
            {
                foreach (var next in graph[node])
                {
                    if (BomDfs(graph, next, state)) return true;
                }
            }
            state[node] = 2;
            return false;
        }
        #endregion

    }
}
