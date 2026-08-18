using System;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;
using WaterCloud.Code;
using Chloe;
using WaterCloud.Domain.MaterialManage;

namespace WaterCloud.Service.MaterialManage
{
    /// <summary>
    /// 创 建：超级管理员
    /// 日 期：2020-12-03 13:55
    /// 描 述：Bom结构服务类
    /// </summary>
    public class BomInfoService : DataFilterService<BomFormEntity>, IDenpendency
    {
        public BomInfoService(IDbContext context) : base(context)
        {
        }
        #region 获取数据
        public async Task<List<MaterialEntity>> GetLookList(string itemId, string keyword = "")
        {
            var query = repository.IQueryable(a => a.F_MaterialId == itemId && a.F_BomType == 1).LeftJoin<MaterialEntity>((a, b) => a.F_SonMaterialId == b.F_Id).Select((a, b) => new MaterialEntity
            {
                F_Id = a.F_Id,
                F_Num = a.F_Num,
                F_CreatorTime = b.F_CreatorTime,
                F_CreatorUserId = b.F_CreatorUserId,
                F_Customer = b.F_Customer,
                F_CustomerProNO = b.F_CustomerProNO,
                F_DeleteMark = b.F_DeleteMark,
                F_DeleteTime = b.F_DeleteTime,
                F_DeleteUserId = b.F_DeleteUserId,
                F_Description = a.F_Description,
                F_EnabledMark = b.F_EnabledMark,
                F_LastModifyTime = b.F_LastModifyTime,
                F_LastModifyUserId = b.F_LastModifyUserId,
                F_MaterialBy = b.F_MaterialBy,
                F_MaterialCode = b.F_MaterialCode,
                F_MaterialDescription = b.F_MaterialDescription,
                F_MaterialName = b.F_MaterialName,
                F_MaterialPic = b.F_MaterialPic,
                F_MaterialSize = b.F_MaterialSize,
                F_MaterialType = b.F_MaterialType,
                F_MaterialUnit = b.F_MaterialUnit,
                F_ProcessId = a.F_ProcessId,
                F_SonMaterialId = b.F_Id,
            });
            if (!string.IsNullOrEmpty(keyword))
            {
                query = query.Where(a => a.F_MaterialCode.Contains(keyword) || a.F_MaterialName.Contains(keyword));
            }
            return query.ToList();
        }

		#endregion

		public async Task<MaterialEntity> GetLookForm(string itemId)
        {
            var cachedata = await uniwork.FindEntity<MaterialEntity>(itemId);
            cachedata.listData = (await GetLookList(itemId)).ToJson();
            return cachedata;
        }

        #region 提交数据
        public async Task SubmitForm(BomFormEntity entity, string listData)
        {
            uniwork.BeginTrans();
            if (!string.IsNullOrEmpty(listData))
            {
                var list = listData.ToList<BomFormEntity>();
                if (list.Any(a => a.F_SonMaterialId == a.F_MaterialId))
                    throw new Exception("bom构物料异常");
                //循环引用检测
                if (CheckBomCycle(entity.F_MaterialId, entity.F_ProcessId, list))
                    throw new Exception("BOM构成存在循环引用，子料号不能是其自身的上层料号，保存失败");
                foreach (var item in list)
                {
                    item.Create();
                    item.F_MaterialId = entity.F_MaterialId;
                    item.F_ProcessId = entity.F_ProcessId;
                    item.F_DeleteMark = false;
                    item.F_BomType = 1;
                }
                await repository.Delete(a => a.F_BomType == 1 && a.F_MaterialId == entity.F_MaterialId && a.F_ProcessId == entity.F_ProcessId);
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
        /// <summary>
        /// 获取BOM树（递归展开，dtree格式）
        /// </summary>
        public async Task<List<TreeGridModel>> GetBomTree(string keyValue)
        {
            List<TreeGridModel> treeList = new List<TreeGridModel>();
            var material = await uniwork.FindEntity<MaterialEntity>(keyValue);
            if (material == null)
            {
                return treeList;
            }
            treeList.Add(new TreeGridModel { id = material.F_Id, parentId = "0", title = material.F_MaterialCode + " " + material.F_MaterialName });
            BuildBomTree(treeList, material.F_Id, new List<string> { material.F_Id });
            return treeList;
        }
        private void BuildBomTree(List<TreeGridModel> treeList, string parentId, List<string> visited)
        {
            var bomList = uniwork.IQueryable<BomFormEntity>(a => a.F_MaterialId == parentId && a.F_BomType == 1).ToList();
            foreach (var item in bomList)
            {
                if (visited.Contains(item.F_SonMaterialId))
                {
                    continue;
                }
                var child = uniwork.FindEntity<MaterialEntity>(item.F_SonMaterialId).GetAwaiter().GetResult();
                if (child == null)
                {
                    continue;
                }
                treeList.Add(new TreeGridModel
                {
                    id = child.F_Id,
                    parentId = parentId,
                    title = child.F_MaterialCode + " " + child.F_MaterialName + "  x" + item.F_Num
                });
                var childVisited = new List<string>(visited);
                childVisited.Add(child.F_Id);
                BuildBomTree(treeList, child.F_Id, childVisited);
            }
        }
        public async Task DeleteForm(string itemId, string keyValue)
        {
            if (string.IsNullOrEmpty(keyValue))
                await repository.Delete(a => a.F_BomType == 1 && a.F_MaterialId == itemId);
            await repository.Delete(a => a.F_BomType == 1 && a.F_MaterialId == itemId && a.F_ProcessId == keyValue);
        }
        #endregion

    }
}
