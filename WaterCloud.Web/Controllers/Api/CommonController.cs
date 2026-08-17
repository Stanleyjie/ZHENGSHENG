using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using WaterCloud.Code;
using WaterCloud.Domain.MaterialManage;
using WaterCloud.Service.EquipmentManage;
using WaterCloud.Service.MaterialManage;
using WaterCloud.Service.ReportRecord;
using WaterCloud.Service.SystemSecurity;

namespace WaterCloud.Web.Controllers
{
    /// <summary>
    /// 常规接口
    /// </summary>
    // 移动端(钉钉小程序)功能已屏蔽,以下路由特性已注释,接口不再对外开放
    //[Route("api/[controller]/[action]")]
    //[ApiController]
    //[ServiceFilter(typeof(LoginFilterAttribute))]
    public class CommonController : ControllerBase
	{
        //自动注入服务
        public LogService _logService { get; set; }
        public EquipmentService _eqpService { get; set; }
        public MaterialService _materialService { get; set; }
        public TransferBoxService _boxService { get; set; }
        public StorageService _storageService { get; set; }
        public AreaService _areaService { get; set; }
        public LocationService _locationService { get; set; }
        public WorkRunService _service { get; set; }
        public ReportRecordService _repService { get; set; }
		#region 获取数据
		/// <summary>
		/// 获取区域列表
		/// </summary>
		/// <param name="keyword">关键词</param>
		/// <param name="type">类型</param>
		/// <returns></returns>
		[HttpGet]
        public async Task<AlwaysResult> GetAreaList([FromQuery] string keyword = "", [FromQuery] int? type = null)
        {
            var data = await _areaService.GetList(keyword);
            data=data.Where(a => a.F_EnabledMark == true).OrderBy(a=>a.F_AreaType).ToList();
            if (type!=null)
				data = data.Where(a => a.F_AreaType == type).ToList();
			return new AlwaysResult<List<AreaEntity>> { state = ResultType.success.ToString(), data = data };
        }
        /// <summary>
        /// 获取物料列表
        /// </summary>
        /// <param name="keyword">关键词</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetMaterialList([FromQuery] string keyword)
        {
            var data = await _repService.GetAllStorageInfoList(keyword);
            return new AlwaysResult<List<MaterialEntity>> { state = ResultType.success.ToString(), data = data };
        }
        /// <summary>
        /// 获取可用库位列表
        /// </summary>
        /// <param name="materialCode">物料编号</param>
        /// <param name="eqpName">设备名称</param>
        /// <param name="areaCode">区域编号</param>
        /// <param name="isAll">全部</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetLocationList([FromQuery] string materialCode, [FromQuery] string eqpName, [FromQuery] string areaCode, [FromQuery] bool isAll=false)
        {
            var data = await _locationService.GetLocationList( eqpName, areaCode,materialCode);
            List<LocationExtend> list = new List<LocationExtend>();
            if (isAll)
            {
                data = data.Where(a => a.F_LocationState == false).OrderBy(a=>a.F_LocationCode).ToList();
            }
            else
            {
                var first = data.Where(a => a.F_LocationState == false).FirstOrDefault();
                data = data.Where(a => a.F_LocationState == false && a.F_SortCode == first.F_SortCode).ToList();
            }
            var areas = await _areaService.GetList();
            foreach (var item in data)
            {
                var temp = list.Where(a => item.F_LocationCode.Contains(a.Prefix)).FirstOrDefault();
                var area = areas.FirstOrDefault(a => a.F_AreaCode == item.F_AreaCode);
                if (temp!=null)
				{
					if (isAll || temp.list[0].F_LocationCode.Replace("-", "").Substring(0, area.F_Prefix) == item.F_LocationCode.Replace("-", "").Substring(0, area.F_Prefix))
					{
						temp.list.Add(item);
					}
				}
                else
                {
                    LocationExtend ex = new LocationExtend();
					ex.Prefix = item.F_LocationCode.Substring(0, area.F_Prefix);
					ex.list = new List<LocationEntity>();
                    ex.list.Add(item);
                    list.Add(ex);
                }
            }
            return new AlwaysResult<List<LocationExtend>> { state = ResultType.success.ToString(), data = list, count = list.Count };
        }
        /// <summary>
        /// 获取可用库位列表
        /// </summary>
        /// <param name="locationCode">库位号</param>
        /// <param name="isAll">全部</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetLocationListByLocation([FromQuery] string locationCode, [FromQuery] string materialCode, [FromQuery] bool isAll = false)
        {
            var data = await _locationService.GetLocationListByLocation(locationCode, materialCode);
            List<LocationExtend> list = new List<LocationExtend>();
            if (isAll)
            {
                data = data.Where(a => a.F_LocationState == false).OrderBy(a => a.F_LocationCode.Length).ToList();
            }
            else
            {
                var first = data.Where(a => a.F_LocationState == false).FirstOrDefault();
                data = data.Where(a => a.F_LocationState == false && a.F_SortCode == first.F_SortCode).ToList();
            }
			var areas = await _areaService.GetList();
			foreach (var item in data)
            {
                var temp = list.Where(a => item.F_LocationCode.Contains(a.Prefix)).FirstOrDefault();
				var area = areas.FirstOrDefault(a => a.F_AreaCode == item.F_AreaCode);
				if (temp != null)
                {
					if (isAll || temp.list[0].F_LocationCode.Replace("-", "").Substring(0, area.F_Prefix) == item.F_LocationCode.Replace("-", "").Substring(0, area.F_Prefix))
					{
						temp.list.Add(item);
					}
				}
                else
                {
                    LocationExtend ex = new LocationExtend();
					ex.Prefix = item.F_LocationCode.Substring(0, area.F_Prefix);
					ex.list = new List<LocationEntity>();
                    ex.list.Add(item);
                    list.Add(ex);
                }
            }
            return new AlwaysResult<List<LocationExtend>> { state = ResultType.success.ToString(), data = list, count = data.Count };
        }
        /// <summary>
        /// 根据流转箱编号获取库存
        /// </summary>
        /// <param name="code">流转箱编号</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetStorageByCode([Required, FromQuery] string code)
        {
            var data = (await _storageService.GetList(code)).Where(a => a.F_TransferBoxCode == code.ToUpper()).FirstOrDefault();
            return new AlwaysResult<StorageEntity> { state = ResultType.success.ToString(), data = data };
        }
        /// <summary>
        /// 根据物料编号获取库存
        /// </summary>
        /// <param name="code">物料编号</param>
        /// <param name="eqpName">当前设备</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetStorageByMaterial([Required, FromQuery] string code, [FromQuery] string eqpName)
        {
            var data = await _storageService.GetStorageByMaterial(code, eqpName);
            return new AlwaysResult<StorageEntity> { state = ResultType.success.ToString(), data = data.FirstOrDefault() };
        }
        /// <summary>
        /// 根据物料编号获取库存列表
        /// </summary>
        /// <param name="code">物料编号</param>
        /// <param name="eqpName">当前设备</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<AlwaysResult> GetStorageListByMaterial([Required, FromQuery] string code, [FromQuery] string eqpName, [FromQuery] bool isAll = false)
        {
            var data = await _storageService.GetStorageByMaterial(code, eqpName, isAll);
            List<StorageExtend> list = new List<StorageExtend>();
			var areas = await _areaService.GetList();
			foreach (var item in data)
            {
                var temp = list.Where(a => item.F_LocationCode.Contains(a.Prefix)).FirstOrDefault();
				var area = areas.FirstOrDefault(a => a.F_AreaCode == item.F_AreaCode);
				if (temp != null)
                {
					if (isAll || temp.list[0].F_LocationCode.Replace("-", "").Substring(0, area.F_Prefix) == item.F_LocationCode.Replace("-", "").Substring(0, area.F_Prefix))
					{
						temp.list.Add(item);
					}
				}
                else
                {
                    StorageExtend ex = new StorageExtend();
					ex.Prefix = item.F_LocationCode.Substring(0, area.F_Prefix);
					ex.list = new List<StorageEntity>();
                    ex.list.Add(item);
                    list.Add(ex);
                }
            }
            return new AlwaysResult<List<StorageExtend>> { state = ResultType.success.ToString(), data = list, count= list.Count() };
        }
        #endregion

        #region 提交数据
        /// <summary>
        /// 库存变动
        /// </summary>
        /// <param name="request">库存变动请求对象</param>
        /// <returns></returns>
        [HttpPost]
        [Lock]
        public async Task<AlwaysResult> StorageChange([FromBody] StorageChangeRequest request)
        {
            try
            {
                StorageChangeInfoEntity entity = new StorageChangeInfoEntity();
                entity.F_TransferBoxCode = request.transferCode;
                entity.F_Num = request.changeNum;
                entity.F_NewTransferBoxCode = request.newTransferCode;
                entity.F_NewLocationCode = request.newLocationCode;
                entity.F_Description = request.description;
                entity.F_ChangeType = request.changeType;
                if (string.IsNullOrEmpty(request.newTransferCode)&& string.IsNullOrEmpty(request.newLocationCode))
                {
                    throw new Exception("不能修改库存数量");
                }
                await _storageService.StorageChange(entity);
                await _logService.WriteLog("操作成功", "库存接口-库存变动", "", Service.DbLogType.Submit);
                return new AlwaysResult { state = ResultType.success.ToString() };
            }
            catch (Exception ex)
            {
                await _logService.WriteLog(ex.Message, "库存接口-库存变动", "", Service.DbLogType.Submit, true);
                return new AlwaysResult { state = ResultType.error.ToString(), message = LogHelper.ExMsgFormat(ex.Message) };
            }
        }

        #endregion

        #region 请求对象
        /// <summary>
        /// 库存变动请求对象
        /// </summary>
        public class StorageChangeRequest
        {
            /// <summary>
            /// 变动类型
            /// </summary>
            [Required(ErrorMessage = "变动类型")]
            public int? changeType { get; set; }
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
            public float? changeNum { get; set; }
            /// <summary>
            /// 新流转箱编号
            /// </summary>
            public string newTransferCode { get; set; }
            /// <summary>
            /// 新库位
            /// </summary>
            /// <returns></returns>
            public string newLocationCode { get; set; }
            /// <summary>
            /// 描述
            /// </summary>
            /// <returns></returns>
            public string description { get; set; }
        }
        #endregion
    }
}
