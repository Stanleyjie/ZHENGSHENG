
-- ----------------------------
-- Table structure for mes_Area
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_Area]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_Area]
GO

CREATE TABLE [dbo].[mes_Area] (
  [F_Id] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_AreaCode] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_AreaType] int DEFAULT 0 NOT NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_NeedRule] tinyint DEFAULT 1 NULL,
  [F_StackType] tinyint DEFAULT 0 NULL,
  [F_Prefix] int  NULL
)
GO

ALTER TABLE [dbo].[mes_Area] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'库区编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_Area',
'COLUMN', N'F_AreaCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'库区类型',
'SCHEMA', N'dbo',
'TABLE', N'mes_Area',
'COLUMN', N'F_AreaType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_Area',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否需要先进先出',
'SCHEMA', N'dbo',
'TABLE', N'mes_Area',
'COLUMN', N'F_NeedRule'
GO

EXEC sp_addextendedproperty
'MS_Description', N'true货架 false叠加',
'SCHEMA', N'dbo',
'TABLE', N'mes_Area',
'COLUMN', N'F_StackType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'库位前缀',
'SCHEMA', N'dbo',
'TABLE', N'mes_Area',
'COLUMN', N'F_Prefix'
GO


-- ----------------------------
-- Records of mes_Area
-- ----------------------------

-- ----------------------------
-- Table structure for mes_BatchInfo
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_BatchInfo]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_BatchInfo]
GO

CREATE TABLE [dbo].[mes_BatchInfo] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_FlowType] int  NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialUnit] nvarchar(10) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialType] int DEFAULT 0 NOT NULL,
  [F_TransferBoxCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_LocationCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialBatch] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EqpId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EqpName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Num] float(53) DEFAULT 0 NOT NULL,
  [F_DoneNum] float(53)  NOT NULL,
  [F_ParentId] nvarchar(max) COLLATE Chinese_PRC_CI_AS DEFAULT '' NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[mes_BatchInfo] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_BatchInfo',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流转类型(0入库绑定，1领用，2产出，3库存，4出库，5检验)',
'SCHEMA', N'dbo',
'TABLE', N'mes_BatchInfo',
'COLUMN', N'F_FlowType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_BatchInfo',
'COLUMN', N'F_MaterialId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_BatchInfo',
'COLUMN', N'F_MaterialCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_BatchInfo',
'COLUMN', N'F_MaterialName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号单位',
'SCHEMA', N'dbo',
'TABLE', N'mes_BatchInfo',
'COLUMN', N'F_MaterialUnit'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号分类',
'SCHEMA', N'dbo',
'TABLE', N'mes_BatchInfo',
'COLUMN', N'F_MaterialType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流转箱编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_BatchInfo',
'COLUMN', N'F_TransferBoxCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'库位号',
'SCHEMA', N'dbo',
'TABLE', N'mes_BatchInfo',
'COLUMN', N'F_LocationCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号批次',
'SCHEMA', N'dbo',
'TABLE', N'mes_BatchInfo',
'COLUMN', N'F_MaterialBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备id',
'SCHEMA', N'dbo',
'TABLE', N'mes_BatchInfo',
'COLUMN', N'F_EqpId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备名称',
'SCHEMA', N'dbo',
'TABLE', N'mes_BatchInfo',
'COLUMN', N'F_EqpName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_BatchInfo',
'COLUMN', N'F_Num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'使用数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_BatchInfo',
'COLUMN', N'F_DoneNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'父级',
'SCHEMA', N'dbo',
'TABLE', N'mes_BatchInfo',
'COLUMN', N'F_ParentId'
GO


-- ----------------------------
-- Records of mes_BatchInfo
-- ----------------------------

-- ----------------------------
-- Table structure for mes_BoardAccount
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_BoardAccount]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_BoardAccount]
GO

CREATE TABLE [dbo].[mes_BoardAccount] (
  [F_Id] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_Account] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_Password] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT 0 NOT NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EqpId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[mes_BoardAccount] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'账户',
'SCHEMA', N'dbo',
'TABLE', N'mes_BoardAccount',
'COLUMN', N'F_Account'
GO

EXEC sp_addextendedproperty
'MS_Description', N'密码',
'SCHEMA', N'dbo',
'TABLE', N'mes_BoardAccount',
'COLUMN', N'F_Password'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_BoardAccount',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'所属设备',
'SCHEMA', N'dbo',
'TABLE', N'mes_BoardAccount',
'COLUMN', N'F_EqpId'
GO


-- ----------------------------
-- Records of mes_BoardAccount
-- ----------------------------

-- ----------------------------
-- Table structure for mes_BomForm
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_BomForm]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_BomForm]
GO

CREATE TABLE [dbo].[mes_BomForm] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_SonMaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_BomType] int DEFAULT 0 NULL,
  [F_ProcessId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Num] float(53) DEFAULT 0 NOT NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[mes_BomForm] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号主键-1',
'SCHEMA', N'dbo',
'TABLE', N'mes_BomForm',
'COLUMN', N'F_MaterialId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'组成主键-n',
'SCHEMA', N'dbo',
'TABLE', N'mes_BomForm',
'COLUMN', N'F_SonMaterialId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'Bom类型（0erp,1mes）',
'SCHEMA', N'dbo',
'TABLE', N'mes_BomForm',
'COLUMN', N'F_BomType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工序主键',
'SCHEMA', N'dbo',
'TABLE', N'mes_BomForm',
'COLUMN', N'F_ProcessId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_BomForm',
'COLUMN', N'F_Num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_BomForm',
'COLUMN', N'F_Description'
GO


-- ----------------------------
-- Records of mes_BomForm
-- ----------------------------

-- ----------------------------
-- Table structure for mes_CheckDateStorage
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_CheckDateStorage]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_CheckDateStorage]
GO

CREATE TABLE [dbo].[mes_CheckDateStorage] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_CheckStorageType] int  NOT NULL,
  [F_CheckDate] date  NOT NULL,
  [F_ClassNum] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialUnit] nvarchar(10) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialType] int DEFAULT 0 NOT NULL,
  [F_BeginNum] float(53) DEFAULT 0 NOT NULL,
  [F_CurrentNum] float(53)  NULL,
  [F_CurrentPallet] int  NULL,
  [F_InNum] float(53)  NULL,
  [F_OutNum] float(53)  NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[mes_CheckDateStorage] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_CheckDateStorage',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'盘点类型',
'SCHEMA', N'dbo',
'TABLE', N'mes_CheckDateStorage',
'COLUMN', N'F_CheckStorageType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'盘点日期',
'SCHEMA', N'dbo',
'TABLE', N'mes_CheckDateStorage',
'COLUMN', N'F_CheckDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'班别（A白班，B夜班）',
'SCHEMA', N'dbo',
'TABLE', N'mes_CheckDateStorage',
'COLUMN', N'F_ClassNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_CheckDateStorage',
'COLUMN', N'F_MaterialId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_CheckDateStorage',
'COLUMN', N'F_MaterialCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_CheckDateStorage',
'COLUMN', N'F_MaterialName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号单位',
'SCHEMA', N'dbo',
'TABLE', N'mes_CheckDateStorage',
'COLUMN', N'F_MaterialUnit'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号分类',
'SCHEMA', N'dbo',
'TABLE', N'mes_CheckDateStorage',
'COLUMN', N'F_MaterialType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'上一班数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_CheckDateStorage',
'COLUMN', N'F_BeginNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'当前数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_CheckDateStorage',
'COLUMN', N'F_CurrentNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'当前托数',
'SCHEMA', N'dbo',
'TABLE', N'mes_CheckDateStorage',
'COLUMN', N'F_CurrentPallet'
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_CheckDateStorage',
'COLUMN', N'F_InNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_CheckDateStorage',
'COLUMN', N'F_OutNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_CheckDateStorage',
'COLUMN', N'F_Description'
GO


-- ----------------------------
-- Records of mes_CheckDateStorage
-- ----------------------------

-- ----------------------------
-- Table structure for mes_CheckoutDescription
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_CheckoutDescription]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_CheckoutDescription]
GO

CREATE TABLE [dbo].[mes_CheckoutDescription] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_ParentId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_Description] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Layers] int  NULL,
  [F_ClickNum] bigint DEFAULT 0 NOT NULL
)
GO

ALTER TABLE [dbo].[mes_CheckoutDescription] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'主键',
'SCHEMA', N'dbo',
'TABLE', N'mes_CheckoutDescription',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'父级id',
'SCHEMA', N'dbo',
'TABLE', N'mes_CheckoutDescription',
'COLUMN', N'F_ParentId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_CheckoutDescription',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_CheckoutDescription',
'COLUMN', N'F_CreatorTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'mes_CheckoutDescription',
'COLUMN', N'F_CreatorUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'层级',
'SCHEMA', N'dbo',
'TABLE', N'mes_CheckoutDescription',
'COLUMN', N'F_Layers'
GO

EXEC sp_addextendedproperty
'MS_Description', N'选择次数',
'SCHEMA', N'dbo',
'TABLE', N'mes_CheckoutDescription',
'COLUMN', N'F_ClickNum'
GO


-- ----------------------------
-- Records of mes_CheckoutDescription
-- ----------------------------

-- ----------------------------
-- Table structure for mes_ConsumeInfo
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_ConsumeInfo]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_ConsumeInfo]
GO

CREATE TABLE [dbo].[mes_ConsumeInfo] (
  [F_Id] bigint  IDENTITY(1,1) NOT NULL,
  [F_TransferBoxCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialUnit] nvarchar(10) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialType] int DEFAULT 0 NOT NULL,
  [F_MaterialBatch] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Num] float(53) DEFAULT 0 NOT NULL,
  [F_ProcessId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ProcessName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EqpId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EqpName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_WorkOrderId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_WorkOrderCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_WorkOrderRunSort] int  NULL,
  [F_OutPutId] bigint  NULL,
  [F_WorkOrderDetailId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorUserName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[mes_ConsumeInfo] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ConsumeInfo',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流转箱编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_ConsumeInfo',
'COLUMN', N'F_TransferBoxCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ConsumeInfo',
'COLUMN', N'F_MaterialId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_ConsumeInfo',
'COLUMN', N'F_MaterialCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_ConsumeInfo',
'COLUMN', N'F_MaterialName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号单位',
'SCHEMA', N'dbo',
'TABLE', N'mes_ConsumeInfo',
'COLUMN', N'F_MaterialUnit'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号分类',
'SCHEMA', N'dbo',
'TABLE', N'mes_ConsumeInfo',
'COLUMN', N'F_MaterialType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号批次',
'SCHEMA', N'dbo',
'TABLE', N'mes_ConsumeInfo',
'COLUMN', N'F_MaterialBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_ConsumeInfo',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_ConsumeInfo',
'COLUMN', N'F_CreatorTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ConsumeInfo',
'COLUMN', N'F_CreatorUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_ConsumeInfo',
'COLUMN', N'F_Num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工序Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ConsumeInfo',
'COLUMN', N'F_ProcessId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工序名称',
'SCHEMA', N'dbo',
'TABLE', N'mes_ConsumeInfo',
'COLUMN', N'F_ProcessName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ConsumeInfo',
'COLUMN', N'F_EqpId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备名称',
'SCHEMA', N'dbo',
'TABLE', N'mes_ConsumeInfo',
'COLUMN', N'F_EqpName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工单Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ConsumeInfo',
'COLUMN', N'F_WorkOrderId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工单编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_ConsumeInfo',
'COLUMN', N'F_WorkOrderCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'执行顺序',
'SCHEMA', N'dbo',
'TABLE', N'mes_ConsumeInfo',
'COLUMN', N'F_WorkOrderRunSort'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产出id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ConsumeInfo',
'COLUMN', N'F_OutPutId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工单明细Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ConsumeInfo',
'COLUMN', N'F_WorkOrderDetailId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'mes_ConsumeInfo',
'COLUMN', N'F_CreatorUserName'
GO


-- ----------------------------
-- Records of mes_ConsumeInfo
-- ----------------------------
SET IDENTITY_INSERT [dbo].[mes_ConsumeInfo] ON
GO

SET IDENTITY_INSERT [dbo].[mes_ConsumeInfo] OFF
GO


-- ----------------------------
-- Table structure for mes_ControlJob
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_ControlJob]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_ControlJob]
GO

CREATE TABLE [dbo].[mes_ControlJob] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_JobCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_JobInfo] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_IsToPlanMan] tinyint DEFAULT 0 NOT NULL,
  [F_IsNotice] tinyint DEFAULT 0 NOT NULL,
  [F_Priority] int  NOT NULL,
  [F_DoneTime] datetime2(7)  NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_JobType] int  NOT NULL,
  [F_NeedId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_FinishTime] datetime2(7)  NULL,
  [F_JobState] int  NOT NULL,
  [F_NeedEqpId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_NeedNum] float(53)  NULL,
  [F_NeedTime] datetime2(7)  NULL
)
GO

ALTER TABLE [dbo].[mes_ControlJob] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ControlJob',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'调度编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_ControlJob',
'COLUMN', N'F_JobCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'调度信息',
'SCHEMA', N'dbo',
'TABLE', N'mes_ControlJob',
'COLUMN', N'F_JobInfo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否发送计划人员',
'SCHEMA', N'dbo',
'TABLE', N'mes_ControlJob',
'COLUMN', N'F_IsToPlanMan'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否通知',
'SCHEMA', N'dbo',
'TABLE', N'mes_ControlJob',
'COLUMN', N'F_IsNotice'
GO

EXEC sp_addextendedproperty
'MS_Description', N'优先级（从大到小执行）',
'SCHEMA', N'dbo',
'TABLE', N'mes_ControlJob',
'COLUMN', N'F_Priority'
GO

EXEC sp_addextendedproperty
'MS_Description', N'执行时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_ControlJob',
'COLUMN', N'F_DoneTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_ControlJob',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'0补货，1入库，2出库，3产出上架，4移库，5作业开始，6作业结束,7领用退回',
'SCHEMA', N'dbo',
'TABLE', N'mes_ControlJob',
'COLUMN', N'F_JobType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'需求id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ControlJob',
'COLUMN', N'F_NeedId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'完成时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_ControlJob',
'COLUMN', N'F_FinishTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务状态（0等待，1执行，2完成,3结束）',
'SCHEMA', N'dbo',
'TABLE', N'mes_ControlJob',
'COLUMN', N'F_JobState'
GO

EXEC sp_addextendedproperty
'MS_Description', N'需求设备id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ControlJob',
'COLUMN', N'F_NeedEqpId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_ControlJob',
'COLUMN', N'F_NeedNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'需求时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_ControlJob',
'COLUMN', N'F_NeedTime'
GO


-- ----------------------------
-- Records of mes_ControlJob
-- ----------------------------

-- ----------------------------
-- Table structure for mes_ControlJobMustTime
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_ControlJobMustTime]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_ControlJobMustTime]
GO

CREATE TABLE [dbo].[mes_ControlJobMustTime] (
  [F_Id] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_JobType] int  NOT NULL,
  [F_NeedTime] int  NOT NULL
)
GO

ALTER TABLE [dbo].[mes_ControlJobMustTime] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ControlJobMustTime',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'0补货，1入库，2出库，3产出上架，4移库，5作业开始，6作业结束,7领用退回',
'SCHEMA', N'dbo',
'TABLE', N'mes_ControlJobMustTime',
'COLUMN', N'F_JobType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务响应时间(分)',
'SCHEMA', N'dbo',
'TABLE', N'mes_ControlJobMustTime',
'COLUMN', N'F_NeedTime'
GO


-- ----------------------------
-- Records of mes_ControlJobMustTime
-- ----------------------------
INSERT INTO [dbo].[mes_ControlJobMustTime] ([F_Id], [F_JobType], [F_NeedTime]) VALUES (N'08d92a23-54c9-41c3-8c19-a76e74652839', N'0', N'40')
GO

INSERT INTO [dbo].[mes_ControlJobMustTime] ([F_Id], [F_JobType], [F_NeedTime]) VALUES (N'08d92a24-ba9b-4f0d-880f-23b034c09db3', N'3', N'40')
GO

INSERT INTO [dbo].[mes_ControlJobMustTime] ([F_Id], [F_JobType], [F_NeedTime]) VALUES (N'08d92a24-bd7e-4d42-8e3f-10a0f129175d', N'4', N'120')
GO

INSERT INTO [dbo].[mes_ControlJobMustTime] ([F_Id], [F_JobType], [F_NeedTime]) VALUES (N'08d92a24-c795-4cfa-81f5-21b9b6e3f78c', N'7', N'40')
GO

INSERT INTO [dbo].[mes_ControlJobMustTime] ([F_Id], [F_JobType], [F_NeedTime]) VALUES (N'08d92a24-cb8e-403b-8cc1-cf4aa9300762', N'10', N'120')
GO

INSERT INTO [dbo].[mes_ControlJobMustTime] ([F_Id], [F_JobType], [F_NeedTime]) VALUES (N'08d92a24-d259-49ed-842e-4fbc5dfa9774', N'11', N'120')
GO

INSERT INTO [dbo].[mes_ControlJobMustTime] ([F_Id], [F_JobType], [F_NeedTime]) VALUES (N'08d92a2d-3da1-46bf-829d-b44762284e44', N'9', N'7200')
GO

INSERT INTO [dbo].[mes_ControlJobMustTime] ([F_Id], [F_JobType], [F_NeedTime]) VALUES (N'08d92a2d-4149-43d9-8625-b3dd858f8a0d', N'8', N'2880')
GO

INSERT INTO [dbo].[mes_ControlJobMustTime] ([F_Id], [F_JobType], [F_NeedTime]) VALUES (N'08d92a2d-4908-4ecf-8e56-60d3128cc201', N'6', N'1500')
GO

INSERT INTO [dbo].[mes_ControlJobMustTime] ([F_Id], [F_JobType], [F_NeedTime]) VALUES (N'08d92a2d-4dab-488f-8d4b-d3df864fdb1e', N'5', N'1500')
GO

INSERT INTO [dbo].[mes_ControlJobMustTime] ([F_Id], [F_JobType], [F_NeedTime]) VALUES (N'08d92a2d-5576-4034-8727-2bf9b41d4869', N'2', N'1500')
GO

INSERT INTO [dbo].[mes_ControlJobMustTime] ([F_Id], [F_JobType], [F_NeedTime]) VALUES (N'08d92a2d-58fc-4a14-8c55-88444f708673', N'1', N'1500')
GO


-- ----------------------------
-- Table structure for mes_ControlJobUserBanding
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_ControlJobUserBanding]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_ControlJobUserBanding]
GO

CREATE TABLE [dbo].[mes_ControlJobUserBanding] (
  [F_Id] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_JobType] int  NOT NULL,
  [F_UserId] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EqpId] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_UserName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EqpName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[mes_ControlJobUserBanding] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ControlJobUserBanding',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'0补货，1入库，2出库，3产出上架，4移库，5作业开始，6作业结束,7领用退回',
'SCHEMA', N'dbo',
'TABLE', N'mes_ControlJobUserBanding',
'COLUMN', N'F_JobType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户ID',
'SCHEMA', N'dbo',
'TABLE', N'mes_ControlJobUserBanding',
'COLUMN', N'F_UserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备ID',
'SCHEMA', N'dbo',
'TABLE', N'mes_ControlJobUserBanding',
'COLUMN', N'F_EqpId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户名',
'SCHEMA', N'dbo',
'TABLE', N'mes_ControlJobUserBanding',
'COLUMN', N'F_UserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备',
'SCHEMA', N'dbo',
'TABLE', N'mes_ControlJobUserBanding',
'COLUMN', N'F_EqpName'
GO


-- ----------------------------
-- Records of mes_ControlJobUserBanding
-- ----------------------------

-- ----------------------------
-- Table structure for mes_EqpAreaBanding
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_EqpAreaBanding]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_EqpAreaBanding]
GO

CREATE TABLE [dbo].[mes_EqpAreaBanding] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_EqpId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_AreaId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL
)
GO

ALTER TABLE [dbo].[mes_EqpAreaBanding] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpAreaBanding',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流转箱编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpAreaBanding',
'COLUMN', N'F_EqpId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'库区Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpAreaBanding',
'COLUMN', N'F_AreaId'
GO


-- ----------------------------
-- Records of mes_EqpAreaBanding
-- ----------------------------

-- ----------------------------
-- Table structure for mes_EqpMaterialBanding
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_EqpMaterialBanding]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_EqpMaterialBanding]
GO

CREATE TABLE [dbo].[mes_EqpMaterialBanding] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_EqpId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialUnit] nvarchar(10) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialType] int DEFAULT 0 NOT NULL,
  [F_Num] float(53) DEFAULT 0 NOT NULL,
  [F_ProduceType] int  NOT NULL,
  [F_Priority] int  NOT NULL
)
GO

ALTER TABLE [dbo].[mes_EqpMaterialBanding] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialBanding',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备ID',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialBanding',
'COLUMN', N'F_EqpId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialBanding',
'COLUMN', N'F_MaterialId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialBanding',
'COLUMN', N'F_MaterialCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialBanding',
'COLUMN', N'F_MaterialName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号单位',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialBanding',
'COLUMN', N'F_MaterialUnit'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号分类',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialBanding',
'COLUMN', N'F_MaterialType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产量数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialBanding',
'COLUMN', N'F_Num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'生产模式(0独立，1共享)',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialBanding',
'COLUMN', N'F_ProduceType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'从大到小',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialBanding',
'COLUMN', N'F_Priority'
GO

EXEC sp_addextendedproperty
'MS_Description', N'夹具编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialBanding',
'COLUMN', N'F_PrgName'
GO


-- ----------------------------
-- Records of mes_EqpMaterialBanding
-- ----------------------------

-- ----------------------------
-- Table structure for mes_EqpMaterialUse
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_EqpMaterialUse]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_EqpMaterialUse]
GO

CREATE TABLE [dbo].[mes_EqpMaterialUse] (
  [F_Id] bigint  IDENTITY(1,1) NOT NULL,
  [F_TransferBoxCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialUnit] nvarchar(10) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialType] int DEFAULT 0 NOT NULL,
  [F_MaterialBatch] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Num] float(53) DEFAULT 0 NOT NULL,
  [F_DoneNum] float(53) DEFAULT 0 NULL,
  [F_ProcessId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ProcessName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EqpId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_EqpName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_WorkOrderId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_WorkOrderCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_WorkOrderRunSort] int  NULL,
  [F_WorkOrderDetailId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorUserName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LocationCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[mes_EqpMaterialUse] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialUse',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流转箱编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialUse',
'COLUMN', N'F_TransferBoxCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialUse',
'COLUMN', N'F_MaterialId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialUse',
'COLUMN', N'F_MaterialCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialUse',
'COLUMN', N'F_MaterialName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号单位',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialUse',
'COLUMN', N'F_MaterialUnit'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号分类',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialUse',
'COLUMN', N'F_MaterialType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号批次',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialUse',
'COLUMN', N'F_MaterialBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialUse',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialUse',
'COLUMN', N'F_CreatorTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人id',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialUse',
'COLUMN', N'F_CreatorUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialUse',
'COLUMN', N'F_Num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'消耗数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialUse',
'COLUMN', N'F_DoneNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工序Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialUse',
'COLUMN', N'F_ProcessId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工序名称',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialUse',
'COLUMN', N'F_ProcessName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备id',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialUse',
'COLUMN', N'F_EqpId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备名称',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialUse',
'COLUMN', N'F_EqpName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工单Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialUse',
'COLUMN', N'F_WorkOrderId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工单编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialUse',
'COLUMN', N'F_WorkOrderCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'执行顺序',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialUse',
'COLUMN', N'F_WorkOrderRunSort'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工单明细Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialUse',
'COLUMN', N'F_WorkOrderDetailId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialUse',
'COLUMN', N'F_CreatorUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'库位号',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpMaterialUse',
'COLUMN', N'F_LocationCode'
GO


-- ----------------------------
-- Records of mes_EqpMaterialUse
-- ----------------------------
SET IDENTITY_INSERT [dbo].[mes_EqpMaterialUse] ON
GO

SET IDENTITY_INSERT [dbo].[mes_EqpMaterialUse] OFF
GO


-- ----------------------------
-- Table structure for mes_EqpPqcCheckItem
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_EqpPqcCheckItem]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_EqpPqcCheckItem]
GO

CREATE TABLE [dbo].[mes_EqpPqcCheckItem] (
  [F_Id] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_EqpId] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_Sequence] int  NULL,
  [F_CheckItem] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CheckStand] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[mes_EqpPqcCheckItem] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备ID',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpPqcCheckItem',
'COLUMN', N'F_EqpId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'顺序',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpPqcCheckItem',
'COLUMN', N'F_Sequence'
GO

EXEC sp_addextendedproperty
'MS_Description', N'点检项目',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpPqcCheckItem',
'COLUMN', N'F_CheckItem'
GO

EXEC sp_addextendedproperty
'MS_Description', N'检验基准',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpPqcCheckItem',
'COLUMN', N'F_CheckStand'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpPqcCheckItem',
'COLUMN', N'F_Description'
GO


-- ----------------------------
-- Records of mes_EqpPqcCheckItem
-- ----------------------------

-- ----------------------------
-- Table structure for mes_EqpPqcDetail
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_EqpPqcDetail]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_EqpPqcDetail]
GO

CREATE TABLE [dbo].[mes_EqpPqcDetail] (
  [F_Id] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_PId] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_CheckItemId] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day1] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day2] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day3] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day4] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day5] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day6] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day7] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day8] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day9] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day10] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day11] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day12] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day13] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day14] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day15] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day16] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day17] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day18] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day19] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day20] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day21] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day22] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day23] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day24] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day25] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day26] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day27] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day28] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day29] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day30] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day31] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CheckItem] varchar(255) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_CheckStand] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[mes_EqpPqcDetail] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'检测项名字',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpPqcDetail',
'COLUMN', N'F_CheckItem'
GO

EXEC sp_addextendedproperty
'MS_Description', N'检测标准',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpPqcDetail',
'COLUMN', N'F_CheckStand'
GO


-- ----------------------------
-- Records of mes_EqpPqcDetail
-- ----------------------------

-- ----------------------------
-- Table structure for mes_EqpPqcMaster
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_EqpPqcMaster]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_EqpPqcMaster]
GO

CREATE TABLE [dbo].[mes_EqpPqcMaster] (
  [F_Id] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_EqpId] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_CheckMonth] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Shift] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Remark] varchar(2000) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[mes_EqpPqcMaster] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备ID',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpPqcMaster',
'COLUMN', N'F_EqpId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'点检月份',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpPqcMaster',
'COLUMN', N'F_CheckMonth'
GO

EXEC sp_addextendedproperty
'MS_Description', N'班别',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpPqcMaster',
'COLUMN', N'F_Shift'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpPqcMaster',
'COLUMN', N'F_Remark'
GO


-- ----------------------------
-- Records of mes_EqpPqcMaster
-- ----------------------------

-- ----------------------------
-- Table structure for mes_EqpRepair
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_EqpRepair]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_EqpRepair]
GO

CREATE TABLE [dbo].[mes_EqpRepair] (
  [F_Id] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_RepairNo] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EqpId] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ProblemType] int  NULL,
  [F_ProblemClass] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ProblemDesc] varchar(1000) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_PhotoPath] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CallRepairMan] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CallRepairTime] datetime2(7)  NULL,
  [F_DistributeTime] datetime2(7)  NULL,
  [F_StartRepairTime] datetime2(7)  NULL,
  [F_EndRepairTime] datetime2(7)  NULL,
  [F_Status] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ConfirmMan] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ConfirmTime] datetime2(7)  NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EqpName] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CallRepairManName] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[mes_EqpRepair] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'维修单号',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepair',
'COLUMN', N'F_RepairNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'故障分类',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepair',
'COLUMN', N'F_ProblemType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'故障等级：1低级，2中级，3高级',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepair',
'COLUMN', N'F_ProblemClass'
GO

EXEC sp_addextendedproperty
'MS_Description', N'故障描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepair',
'COLUMN', N'F_ProblemDesc'
GO

EXEC sp_addextendedproperty
'MS_Description', N'故障图片路径',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepair',
'COLUMN', N'F_PhotoPath'
GO

EXEC sp_addextendedproperty
'MS_Description', N'报修人ID',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepair',
'COLUMN', N'F_CallRepairMan'
GO

EXEC sp_addextendedproperty
'MS_Description', N'报修时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepair',
'COLUMN', N'F_CallRepairTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'派工时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepair',
'COLUMN', N'F_DistributeTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'维修开始时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepair',
'COLUMN', N'F_StartRepairTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'维修结束时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepair',
'COLUMN', N'F_EndRepairTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'状态：1,报修；2，已派工；3,维修中；4，确认中，99，关闭',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepair',
'COLUMN', N'F_Status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'确认人ID,同报修人',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepair',
'COLUMN', N'F_ConfirmMan'
GO

EXEC sp_addextendedproperty
'MS_Description', N'确认时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepair',
'COLUMN', N'F_ConfirmTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepair',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'报修人姓名',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepair',
'COLUMN', N'F_CallRepairManName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备维修记录表',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepair'
GO


-- ----------------------------
-- Records of mes_EqpRepair
-- ----------------------------

-- ----------------------------
-- Table structure for mes_EqpRepairManRecord
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_EqpRepairManRecord]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_EqpRepairManRecord]
GO

CREATE TABLE [dbo].[mes_EqpRepairManRecord] (
  [F_Id] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_RepairId] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_RepairMan] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DistributeTime] datetime2(7)  NULL,
  [F_StartRepairTime] datetime2(7)  NULL,
  [F_EndRepairTime] datetime2(7)  NULL,
  [F_RepairResult] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Status] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_RepairManName] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[mes_EqpRepairManRecord] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备维修记录表主键',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepairManRecord',
'COLUMN', N'F_RepairId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'维修人Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepairManRecord',
'COLUMN', N'F_RepairMan'
GO

EXEC sp_addextendedproperty
'MS_Description', N'派工时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepairManRecord',
'COLUMN', N'F_DistributeTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'维修开始时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepairManRecord',
'COLUMN', N'F_StartRepairTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'维修结束时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepairManRecord',
'COLUMN', N'F_EndRepairTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'维修结果',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepairManRecord',
'COLUMN', N'F_RepairResult'
GO

EXEC sp_addextendedproperty
'MS_Description', N'状态：1,派工，2，维修中，99，完成',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepairManRecord',
'COLUMN', N'F_Status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepairManRecord',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'维修人姓名',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepairManRecord',
'COLUMN', N'F_RepairManName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'维修人员记录表',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepairManRecord'
GO


-- ----------------------------
-- Records of mes_EqpRepairManRecord
-- ----------------------------

-- ----------------------------
-- Table structure for mes_EqpRepairProcess
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_EqpRepairProcess]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_EqpRepairProcess]
GO

CREATE TABLE [dbo].[mes_EqpRepairProcess] (
  [F_RepairId] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_AddTime] datetime2(7)  NULL,
  [F_ActionDesc] varchar(1000) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[mes_EqpRepairProcess] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'维修单主键',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepairProcess',
'COLUMN', N'F_RepairId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'动作时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepairProcess',
'COLUMN', N'F_AddTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'动作描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpRepairProcess',
'COLUMN', N'F_ActionDesc'
GO


-- ----------------------------
-- Records of mes_EqpRepairProcess
-- ----------------------------

-- ----------------------------
-- Table structure for mes_EqpStopRecord
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_EqpStopRecord]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_EqpStopRecord]
GO

CREATE TABLE [dbo].[mes_EqpStopRecord] (
  [F_Id] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_EqpId] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_StopType] int  NULL,
  [F_PlanStopStartTime] datetime2(7)  NULL,
  [F_PlanStopEndTime] datetime2(7)  NULL,
  [F_StopReasonType] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_StopReason] nvarchar(1000) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_RealStopStartTime] datetime2(7)  NULL,
  [F_RealStopEndTime] datetime2(7)  NULL,
  [F_Solution] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NULL,
  [F_EqpName] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsRecovery] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Shift] varchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Day] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_RepeatWeekday] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[mes_EqpStopRecord] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'1：故障停机，2：计划内停机，3:急停停机',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpStopRecord',
'COLUMN', N'F_StopType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'计划停机开始时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpStopRecord',
'COLUMN', N'F_PlanStopStartTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'计划停机结束时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpStopRecord',
'COLUMN', N'F_PlanStopEndTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'停机原因分类：1人2机3料4法5环',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpStopRecord',
'COLUMN', N'F_StopReasonType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'停机原因',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpStopRecord',
'COLUMN', N'F_StopReason'
GO

EXEC sp_addextendedproperty
'MS_Description', N'实际停机开始时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpStopRecord',
'COLUMN', N'F_RealStopStartTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'实际停机结束时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpStopRecord',
'COLUMN', N'F_RealStopEndTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'解决措施',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpStopRecord',
'COLUMN', N'F_Solution'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpStopRecord',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否恢复，Y是，N否',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpStopRecord',
'COLUMN', N'F_IsRecovery'
GO

EXEC sp_addextendedproperty
'MS_Description', N'班别',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpStopRecord',
'COLUMN', N'F_Shift'
GO

EXEC sp_addextendedproperty
'MS_Description', N'当班日期',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpStopRecord',
'COLUMN', N'F_Day'
GO

EXEC sp_addextendedproperty
'MS_Description', N'周几重复，空不重复',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpStopRecord',
'COLUMN', N'F_RepeatWeekday'
GO

EXEC sp_addextendedproperty
'MS_Description', N'停机记录表',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpStopRecord'
GO


-- ----------------------------
-- Records of mes_EqpStopRecord
-- ----------------------------

-- ----------------------------
-- Table structure for mes_EqpWorkTime
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_EqpWorkTime]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_EqpWorkTime]
GO

CREATE TABLE [dbo].[mes_EqpWorkTime] (
  [F_Id] bigint  IDENTITY(1,1) NOT NULL,
  [F_StartTime] datetime  NOT NULL,
  [F_EndTime] datetime  NOT NULL,
  [F_TimeNum] float(53) DEFAULT 0 NOT NULL,
  [F_UserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_UserName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[mes_EqpWorkTime] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'主键',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpWorkTime',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'结束时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpWorkTime',
'COLUMN', N'F_StartTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'开始时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpWorkTime',
'COLUMN', N'F_EndTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'计算以半小时算',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpWorkTime',
'COLUMN', N'F_TimeNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户id',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpWorkTime',
'COLUMN', N'F_UserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户名称',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpWorkTime',
'COLUMN', N'F_UserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_EqpWorkTime',
'COLUMN', N'F_Description'
GO


-- ----------------------------
-- Records of mes_EqpWorkTime
-- ----------------------------
SET IDENTITY_INSERT [dbo].[mes_EqpWorkTime] ON
GO

SET IDENTITY_INSERT [dbo].[mes_EqpWorkTime] OFF
GO


-- ----------------------------
-- Table structure for mes_Equipment
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_Equipment]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_Equipment]
GO

CREATE TABLE [dbo].[mes_Equipment] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_ParentId] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT 0 NOT NULL,
  [F_EqpName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EqpState] int  NOT NULL,
  [F_EqpOwner] int  NULL,
  [F_UseDate] datetime2(7)  NULL,
  [F_PlanUserNum] int  NULL,
  [F_UsedNum] int  NULL,
  [F_MaintainNum] int  NULL,
  [F_EqpType] int  NOT NULL,
  [F_IsMaintain] tinyint DEFAULT 0 NOT NULL,
  [F_IsOtherEqp] tinyint DEFAULT 0 NOT NULL,
  [F_MaintainType] int  NULL,
  [F_EqpUse] int  NOT NULL,
  [F_MoldingNum] int  NULL,
  [F_CompanyName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MouldType] int  NULL,
  [F_DieNum] int  NULL,
  [F_PlcState] int  NULL,
  [F_BatchPrefix] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_BatchType] int DEFAULT 0 NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_OutTransferNum] int DEFAULT 1 NULL,
  [F_PlanStopTime] int  NULL,
  [F_OEE] int  NULL,
  [F_Beat] float(53)  NULL
)
GO

ALTER TABLE [dbo].[mes_Equipment] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备名称',
'SCHEMA', N'dbo',
'TABLE', N'mes_Equipment',
'COLUMN', N'F_EqpName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_Equipment',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'财产所属',
'SCHEMA', N'dbo',
'TABLE', N'mes_Equipment',
'COLUMN', N'F_EqpOwner'
GO

EXEC sp_addextendedproperty
'MS_Description', N'接收日期',
'SCHEMA', N'dbo',
'TABLE', N'mes_Equipment',
'COLUMN', N'F_UseDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'预计使用次数',
'SCHEMA', N'dbo',
'TABLE', N'mes_Equipment',
'COLUMN', N'F_PlanUserNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'已使用次数',
'SCHEMA', N'dbo',
'TABLE', N'mes_Equipment',
'COLUMN', N'F_UsedNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'保养周期',
'SCHEMA', N'dbo',
'TABLE', N'mes_Equipment',
'COLUMN', N'F_MaintainNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备类型',
'SCHEMA', N'dbo',
'TABLE', N'mes_Equipment',
'COLUMN', N'F_EqpType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否需要保养',
'SCHEMA', N'dbo',
'TABLE', N'mes_Equipment',
'COLUMN', N'F_IsMaintain'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否加载流动设备',
'SCHEMA', N'dbo',
'TABLE', N'mes_Equipment',
'COLUMN', N'F_IsOtherEqp'
GO

EXEC sp_addextendedproperty
'MS_Description', N'保养类型',
'SCHEMA', N'dbo',
'TABLE', N'mes_Equipment',
'COLUMN', N'F_MaintainType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备用途',
'SCHEMA', N'dbo',
'TABLE', N'mes_Equipment',
'COLUMN', N'F_EqpUse'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模具模数',
'SCHEMA', N'dbo',
'TABLE', N'mes_Equipment',
'COLUMN', N'F_MoldingNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'所属公司',
'SCHEMA', N'dbo',
'TABLE', N'mes_Equipment',
'COLUMN', N'F_CompanyName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模具类型',
'SCHEMA', N'dbo',
'TABLE', N'mes_Equipment',
'COLUMN', N'F_MouldType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模具号',
'SCHEMA', N'dbo',
'TABLE', N'mes_Equipment',
'COLUMN', N'F_DieNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'plc状态',
'SCHEMA', N'dbo',
'TABLE', N'mes_Equipment',
'COLUMN', N'F_PlcState'
GO

EXEC sp_addextendedproperty
'MS_Description', N'批次前缀',
'SCHEMA', N'dbo',
'TABLE', N'mes_Equipment',
'COLUMN', N'F_BatchPrefix'
GO

EXEC sp_addextendedproperty
'MS_Description', N'批次类型(0、年月日班，1、年月日时分秒)',
'SCHEMA', N'dbo',
'TABLE', N'mes_Equipment',
'COLUMN', N'F_BatchType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'绑定物料',
'SCHEMA', N'dbo',
'TABLE', N'mes_Equipment',
'COLUMN', N'F_MaterialId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产出容器限制',
'SCHEMA', N'dbo',
'TABLE', N'mes_Equipment',
'COLUMN', N'F_OutTransferNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'固定停机时间分钟(min)',
'SCHEMA', N'dbo',
'TABLE', N'mes_Equipment',
'COLUMN', N'F_PlanStopTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'OEE(%)',
'SCHEMA', N'dbo',
'TABLE', N'mes_Equipment',
'COLUMN', N'F_OEE'
GO

EXEC sp_addextendedproperty
'MS_Description', N'节拍(s)',
'SCHEMA', N'dbo',
'TABLE', N'mes_Equipment',
'COLUMN', N'F_Beat'
GO


-- ----------------------------
-- Records of mes_Equipment
-- ----------------------------

-- ----------------------------
-- Table structure for mes_EquipmentStatusDate
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_EquipmentStatusDate]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_EquipmentStatusDate]
GO

CREATE TABLE [dbo].[mes_EquipmentStatusDate] (
  [F_EqpId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_OfflineTimes] int  NULL,
  [F_RunTimes] int  NULL,
  [F_WarningTimes] int  NULL,
  [F_ErrorTimes] int  NULL,
  [F_OffTimes] int  NULL,
  [F_Date] date  NULL,
  [F_CurrQty] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastUpdateTime] datetime2(7)  NULL,
  [F_MsgSended] nvarchar(20) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[mes_EquipmentStatusDate] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备的ID，（无主键）',
'SCHEMA', N'dbo',
'TABLE', N'mes_EquipmentStatusDate',
'COLUMN', N'F_EqpId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'离线累计秒数',
'SCHEMA', N'dbo',
'TABLE', N'mes_EquipmentStatusDate',
'COLUMN', N'F_OfflineTimes'
GO

EXEC sp_addextendedproperty
'MS_Description', N'运行累计秒数',
'SCHEMA', N'dbo',
'TABLE', N'mes_EquipmentStatusDate',
'COLUMN', N'F_RunTimes'
GO

EXEC sp_addextendedproperty
'MS_Description', N'报警累计秒数',
'SCHEMA', N'dbo',
'TABLE', N'mes_EquipmentStatusDate',
'COLUMN', N'F_WarningTimes'
GO

EXEC sp_addextendedproperty
'MS_Description', N'故障累计秒数',
'SCHEMA', N'dbo',
'TABLE', N'mes_EquipmentStatusDate',
'COLUMN', N'F_ErrorTimes'
GO

EXEC sp_addextendedproperty
'MS_Description', N'停机累计秒数',
'SCHEMA', N'dbo',
'TABLE', N'mes_EquipmentStatusDate',
'COLUMN', N'F_OffTimes'
GO

EXEC sp_addextendedproperty
'MS_Description', N'日期',
'SCHEMA', N'dbo',
'TABLE', N'mes_EquipmentStatusDate',
'COLUMN', N'F_Date'
GO

EXEC sp_addextendedproperty
'MS_Description', N'实时下料数',
'SCHEMA', N'dbo',
'TABLE', N'mes_EquipmentStatusDate',
'COLUMN', N'F_CurrQty'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后更新时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_EquipmentStatusDate',
'COLUMN', N'F_LastUpdateTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否已通知',
'SCHEMA', N'dbo',
'TABLE', N'mes_EquipmentStatusDate',
'COLUMN', N'F_MsgSended'
GO


-- ----------------------------
-- Records of mes_EquipmentStatusDate
-- ----------------------------

-- ----------------------------
-- Table structure for mes_EquipmentStatusDateByHour
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_EquipmentStatusDateByHour]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_EquipmentStatusDateByHour]
GO

CREATE TABLE [dbo].[mes_EquipmentStatusDateByHour] (
  [F_EqpId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_OfflineTimes] int  NULL,
  [F_RunTimes] int  NULL,
  [F_WarningTimes] int  NULL,
  [F_ErrorTimes] int  NULL,
  [F_OffTimes] int  NULL,
  [F_DateHour] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Date] date  NULL
)
GO

ALTER TABLE [dbo].[mes_EquipmentStatusDateByHour] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备的ID，（无主键）',
'SCHEMA', N'dbo',
'TABLE', N'mes_EquipmentStatusDateByHour',
'COLUMN', N'F_EqpId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'离线累计秒数',
'SCHEMA', N'dbo',
'TABLE', N'mes_EquipmentStatusDateByHour',
'COLUMN', N'F_OfflineTimes'
GO

EXEC sp_addextendedproperty
'MS_Description', N'运行累计秒数',
'SCHEMA', N'dbo',
'TABLE', N'mes_EquipmentStatusDateByHour',
'COLUMN', N'F_RunTimes'
GO

EXEC sp_addextendedproperty
'MS_Description', N'报警累计秒数',
'SCHEMA', N'dbo',
'TABLE', N'mes_EquipmentStatusDateByHour',
'COLUMN', N'F_WarningTimes'
GO

EXEC sp_addextendedproperty
'MS_Description', N'故障累计秒数',
'SCHEMA', N'dbo',
'TABLE', N'mes_EquipmentStatusDateByHour',
'COLUMN', N'F_ErrorTimes'
GO

EXEC sp_addextendedproperty
'MS_Description', N'停机累计秒数',
'SCHEMA', N'dbo',
'TABLE', N'mes_EquipmentStatusDateByHour',
'COLUMN', N'F_OffTimes'
GO

EXEC sp_addextendedproperty
'MS_Description', N'日期小时',
'SCHEMA', N'dbo',
'TABLE', N'mes_EquipmentStatusDateByHour',
'COLUMN', N'F_DateHour'
GO

EXEC sp_addextendedproperty
'MS_Description', N'日期',
'SCHEMA', N'dbo',
'TABLE', N'mes_EquipmentStatusDateByHour',
'COLUMN', N'F_Date'
GO


-- ----------------------------
-- Records of mes_EquipmentStatusDateByHour
-- ----------------------------

-- ----------------------------
-- Table structure for mes_EquipmentStatusLog
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_EquipmentStatusLog]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_EquipmentStatusLog]
GO

CREATE TABLE [dbo].[mes_EquipmentStatusLog] (
  [F_EqpId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_PLCSTATUS] nvarchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DATE] datetime2(7)  NULL
)
GO

ALTER TABLE [dbo].[mes_EquipmentStatusLog] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备的ID，（无主键）',
'SCHEMA', N'dbo',
'TABLE', N'mes_EquipmentStatusLog',
'COLUMN', N'F_EqpId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'状态',
'SCHEMA', N'dbo',
'TABLE', N'mes_EquipmentStatusLog',
'COLUMN', N'F_PLCSTATUS'
GO

EXEC sp_addextendedproperty
'MS_Description', N'日期',
'SCHEMA', N'dbo',
'TABLE', N'mes_EquipmentStatusLog',
'COLUMN', N'F_DATE'
GO


-- ----------------------------
-- Records of mes_EquipmentStatusLog
-- ----------------------------

-- ----------------------------
-- Table structure for mes_InStorage
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_InStorage]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_InStorage]
GO

CREATE TABLE [dbo].[mes_InStorage] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_InStorageCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialUnit] nvarchar(10) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialType] int DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Num] float(53) DEFAULT 0 NOT NULL,
  [F_DoneNum] float(53) DEFAULT 0 NOT NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_InStorageState] int DEFAULT 0 NOT NULL,
  [F_BadNum] float(53)  NULL,
  [F_BatchJson] text COLLATE Chinese_PRC_CI_AS  NULL,
  [F_PlanTime] datetime2(7)  NULL,
  [F_CarNo] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsUserEdit] tinyint  NULL
)
GO

ALTER TABLE [dbo].[mes_InStorage] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorage',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库单编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorage',
'COLUMN', N'F_InStorageCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorage',
'COLUMN', N'F_MaterialId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorage',
'COLUMN', N'F_MaterialCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorage',
'COLUMN', N'F_MaterialName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号单位',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorage',
'COLUMN', N'F_MaterialUnit'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号分类',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorage',
'COLUMN', N'F_MaterialType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorage',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorage',
'COLUMN', N'F_CreatorTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人id',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorage',
'COLUMN', N'F_CreatorUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorage',
'COLUMN', N'F_Num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'完成数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorage',
'COLUMN', N'F_DoneNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库单状态',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorage',
'COLUMN', N'F_InStorageState'
GO

EXEC sp_addextendedproperty
'MS_Description', N'不良数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorage',
'COLUMN', N'F_BadNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'批号列表',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorage',
'COLUMN', N'F_BatchJson'
GO

EXEC sp_addextendedproperty
'MS_Description', N'计划时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorage',
'COLUMN', N'F_PlanTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'车牌',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorage',
'COLUMN', N'F_CarNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否修改',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorage',
'COLUMN', N'F_IsUserEdit'
GO


-- ----------------------------
-- Records of mes_InStorage
-- ----------------------------

-- ----------------------------
-- Table structure for mes_InStorageInfo
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_InStorageInfo]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_InStorageInfo]
GO

CREATE TABLE [dbo].[mes_InStorageInfo] (
  [F_Id] bigint  IDENTITY(1,1) NOT NULL,
  [F_TransferBoxCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialUnit] nvarchar(10) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialType] int DEFAULT 0 NOT NULL,
  [F_MaterialBatch] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Num] float(53) DEFAULT 0 NOT NULL,
  [F_InStorageId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LocationCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorUserName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_BandingUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_BandingUserName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_BandingTime] datetime2(7)  NULL,
  [F_OriginalBatch] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsTemp] tinyint DEFAULT 0 NULL
)
GO

ALTER TABLE [dbo].[mes_InStorageInfo] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorageInfo',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流转箱编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorageInfo',
'COLUMN', N'F_TransferBoxCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorageInfo',
'COLUMN', N'F_MaterialId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorageInfo',
'COLUMN', N'F_MaterialCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorageInfo',
'COLUMN', N'F_MaterialName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号单位',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorageInfo',
'COLUMN', N'F_MaterialUnit'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号分类',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorageInfo',
'COLUMN', N'F_MaterialType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号批次',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorageInfo',
'COLUMN', N'F_MaterialBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorageInfo',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorageInfo',
'COLUMN', N'F_CreatorTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人id',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorageInfo',
'COLUMN', N'F_CreatorUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorageInfo',
'COLUMN', N'F_Num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'入库单id',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorageInfo',
'COLUMN', N'F_InStorageId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorageInfo',
'COLUMN', N'F_CreatorUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'绑定人id',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorageInfo',
'COLUMN', N'F_BandingUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'绑定人',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorageInfo',
'COLUMN', N'F_BandingUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'绑定时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorageInfo',
'COLUMN', N'F_BandingTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'原始批次',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorageInfo',
'COLUMN', N'F_OriginalBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'临时标识绑定中',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorageInfo',
'COLUMN', N'F_IsTemp'
GO


-- ----------------------------
-- Records of mes_InStorageInfo
-- ----------------------------
SET IDENTITY_INSERT [dbo].[mes_InStorageInfo] ON
GO

SET IDENTITY_INSERT [dbo].[mes_InStorageInfo] OFF
GO



-- ----------------------------
-- Table structure for mes_Location
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_Location]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_Location]
GO

CREATE TABLE [dbo].[mes_Location] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_AreaId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_AreaCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_LocationCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT 0 NOT NULL,
  [F_SortCode] int DEFAULT 0 NOT NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LocationState] tinyint DEFAULT 0 NOT NULL,
  [F_MaterialCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialName] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LocationType] int DEFAULT 0 NOT NULL
)
GO

ALTER TABLE [dbo].[mes_Location] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'库区id',
'SCHEMA', N'dbo',
'TABLE', N'mes_Location',
'COLUMN', N'F_AreaId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'库区编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_Location',
'COLUMN', N'F_AreaCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'库位编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_Location',
'COLUMN', N'F_LocationCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'顺序',
'SCHEMA', N'dbo',
'TABLE', N'mes_Location',
'COLUMN', N'F_SortCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_Location',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'物料编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_Location',
'COLUMN', N'F_MaterialCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'物料名称',
'SCHEMA', N'dbo',
'TABLE', N'mes_Location',
'COLUMN', N'F_MaterialName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'库位类型(0正常，1临时)',
'SCHEMA', N'dbo',
'TABLE', N'mes_Location',
'COLUMN', N'F_LocationType'
GO


-- ----------------------------
-- Records of mes_Location
-- ----------------------------

-- ----------------------------
-- Table structure for mes_LocationMaterialBanding
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_LocationMaterialBanding]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_LocationMaterialBanding]
GO

CREATE TABLE [dbo].[mes_LocationMaterialBanding] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_LocationId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL
)
GO

ALTER TABLE [dbo].[mes_LocationMaterialBanding] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'库位id',
'SCHEMA', N'dbo',
'TABLE', N'mes_LocationMaterialBanding',
'COLUMN', N'F_LocationId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'物料id',
'SCHEMA', N'dbo',
'TABLE', N'mes_LocationMaterialBanding',
'COLUMN', N'F_MaterialId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'物料编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_LocationMaterialBanding',
'COLUMN', N'F_MaterialCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'物料名称',
'SCHEMA', N'dbo',
'TABLE', N'mes_LocationMaterialBanding',
'COLUMN', N'F_MaterialName'
GO


-- ----------------------------
-- Records of mes_LocationMaterialBanding
-- ----------------------------

-- ----------------------------
-- Table structure for mes_Material
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_Material]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_Material]
GO

CREATE TABLE [dbo].[mes_Material] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialDescription] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialUnit] nvarchar(10) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialSize] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialBy] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialType] int DEFAULT 0 NOT NULL,
  [F_MaterialPic] varchar(100) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Customer] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CustomerProNO] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CpkStData] nvarchar(2000) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ModelRefer] nvarchar(100) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_NeedCheckout] tinyint  NULL,
  [F_WarmNum] int DEFAULT 0 NULL,
  [F_ContainerNum] int DEFAULT 0 NULL,
  [F_CheckoutDescriptionId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ReceiveNum] int DEFAULT 2 NOT NULL,
)
GO

ALTER TABLE [dbo].[mes_Material] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号id',
'SCHEMA', N'dbo',
'TABLE', N'mes_Material',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_Material',
'COLUMN', N'F_MaterialCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号名称',
'SCHEMA', N'dbo',
'TABLE', N'mes_Material',
'COLUMN', N'F_MaterialName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_Material',
'COLUMN', N'F_MaterialDescription'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号单位',
'SCHEMA', N'dbo',
'TABLE', N'mes_Material',
'COLUMN', N'F_MaterialUnit'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号规格',
'SCHEMA', N'dbo',
'TABLE', N'mes_Material',
'COLUMN', N'F_MaterialSize'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号材质',
'SCHEMA', N'dbo',
'TABLE', N'mes_Material',
'COLUMN', N'F_MaterialBy'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号分类',
'SCHEMA', N'dbo',
'TABLE', N'mes_Material',
'COLUMN', N'F_MaterialType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'图片路径',
'SCHEMA', N'dbo',
'TABLE', N'mes_Material',
'COLUMN', N'F_MaterialPic'
GO

EXEC sp_addextendedproperty
'MS_Description', N'客户',
'SCHEMA', N'dbo',
'TABLE', N'mes_Material',
'COLUMN', N'F_Customer'
GO

EXEC sp_addextendedproperty
'MS_Description', N'客户品号',
'SCHEMA', N'dbo',
'TABLE', N'mes_Material',
'COLUMN', N'F_CustomerProNO'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_Material',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'零件cpk标准Json字符串',
'SCHEMA', N'dbo',
'TABLE', N'mes_Material',
'COLUMN', N'F_CpkStData'
GO

EXEC sp_addextendedproperty
'MS_Description', N'参考模型',
'SCHEMA', N'dbo',
'TABLE', N'mes_Material',
'COLUMN', N'F_ModelRefer'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否需要检验',
'SCHEMA', N'dbo',
'TABLE', N'mes_Material',
'COLUMN', N'F_NeedCheckout'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最小预警值',
'SCHEMA', N'dbo',
'TABLE', N'mes_Material',
'COLUMN', N'F_WarmNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'容器值',
'SCHEMA', N'dbo',
'TABLE', N'mes_Material',
'COLUMN', N'F_ContainerNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'检验说明id',
'SCHEMA', N'dbo',
'TABLE', N'mes_Material',
'COLUMN', N'F_CheckoutDescriptionId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'领料倍数限制',
'SCHEMA', N'dbo',
'TABLE', N'mes_Material',
'COLUMN', N'F_ReceiveNum'
GO


-- ----------------------------
-- Records of mes_Material
-- ----------------------------

-- ----------------------------
-- Table structure for mes_MaterialEqpBanding
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_MaterialEqpBanding]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_MaterialEqpBanding]
GO

CREATE TABLE [dbo].[mes_MaterialEqpBanding] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_EqpId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_EqpUse] int  NULL
)
GO

ALTER TABLE [dbo].[mes_MaterialEqpBanding] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号主键-1',
'SCHEMA', N'dbo',
'TABLE', N'mes_MaterialEqpBanding',
'COLUMN', N'F_MaterialId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备主键-n',
'SCHEMA', N'dbo',
'TABLE', N'mes_MaterialEqpBanding',
'COLUMN', N'F_EqpId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备用途',
'SCHEMA', N'dbo',
'TABLE', N'mes_MaterialEqpBanding',
'COLUMN', N'F_EqpUse'
GO


-- ----------------------------
-- Records of mes_MaterialEqpBanding
-- ----------------------------

-- ----------------------------
-- Table structure for mes_NeedCheck
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_NeedCheck]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_NeedCheck]
GO

CREATE TABLE [dbo].[mes_NeedCheck] (
  [F_Id] bigint  IDENTITY(1,1) NOT NULL,
  [F_IsCheck] tinyint DEFAULT 0 NOT NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CheckType] int  NOT NULL,
  [F_TransferBoxCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialUnit] nvarchar(10) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialType] int DEFAULT 0 NOT NULL,
  [F_MaterialBatch] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LocationCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EqpName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EqpId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Num] float(53)  NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsTwoCheck] tinyint  NULL,
  [F_IsNeedTwoCheck] tinyint  NULL,
  [F_FinishTime] datetime2(7)  NULL,
  [F_TwoFinishTime] datetime2(7)  NULL,
  [F_SourceId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL
)
GO

ALTER TABLE [dbo].[mes_NeedCheck] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'主键',
'SCHEMA', N'dbo',
'TABLE', N'mes_NeedCheck',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'检验标识',
'SCHEMA', N'dbo',
'TABLE', N'mes_NeedCheck',
'COLUMN', N'F_IsCheck'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_NeedCheck',
'COLUMN', N'F_CreatorTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'检验类型',
'SCHEMA', N'dbo',
'TABLE', N'mes_NeedCheck',
'COLUMN', N'F_CheckType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流转箱编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_NeedCheck',
'COLUMN', N'F_TransferBoxCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_NeedCheck',
'COLUMN', N'F_MaterialId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_NeedCheck',
'COLUMN', N'F_MaterialCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号名称',
'SCHEMA', N'dbo',
'TABLE', N'mes_NeedCheck',
'COLUMN', N'F_MaterialName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号单位',
'SCHEMA', N'dbo',
'TABLE', N'mes_NeedCheck',
'COLUMN', N'F_MaterialUnit'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号分类',
'SCHEMA', N'dbo',
'TABLE', N'mes_NeedCheck',
'COLUMN', N'F_MaterialType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号批次',
'SCHEMA', N'dbo',
'TABLE', N'mes_NeedCheck',
'COLUMN', N'F_MaterialBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'库位号',
'SCHEMA', N'dbo',
'TABLE', N'mes_NeedCheck',
'COLUMN', N'F_LocationCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备名称',
'SCHEMA', N'dbo',
'TABLE', N'mes_NeedCheck',
'COLUMN', N'F_EqpName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_NeedCheck',
'COLUMN', N'F_EqpId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'检验数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_NeedCheck',
'COLUMN', N'F_Num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'质检信息',
'SCHEMA', N'dbo',
'TABLE', N'mes_NeedCheck',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'二次检验标识',
'SCHEMA', N'dbo',
'TABLE', N'mes_NeedCheck',
'COLUMN', N'F_IsTwoCheck'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否二次检验',
'SCHEMA', N'dbo',
'TABLE', N'mes_NeedCheck',
'COLUMN', N'F_IsNeedTwoCheck'
GO

EXEC sp_addextendedproperty
'MS_Description', N'检验完成时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_NeedCheck',
'COLUMN', N'F_FinishTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'二次检验完成时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_NeedCheck',
'COLUMN', N'F_TwoFinishTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'来源id',
'SCHEMA', N'dbo',
'TABLE', N'mes_NeedCheck',
'COLUMN', N'F_SourceId'
GO


-- ----------------------------
-- Records of mes_NeedCheck
-- ----------------------------
SET IDENTITY_INSERT [dbo].[mes_NeedCheck] ON
GO

SET IDENTITY_INSERT [dbo].[mes_NeedCheck] OFF
GO


-- ----------------------------
-- Table structure for mes_Order
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_Order]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_Order]
GO

CREATE TABLE [dbo].[mes_Order] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_OrderCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_Customer] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT 0 NOT NULL,
  [F_PlanStartTime] datetime2(7)  NOT NULL,
  [F_PlanEndTime] datetime2(7)  NOT NULL,
  [F_DayNum] int  NOT NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsFinish] tinyint  NOT NULL,
  [F_PredictOverTime] datetime2(7)  NULL,
  [F_ActualOverTime] datetime2(7)  NULL
)
GO

ALTER TABLE [dbo].[mes_Order] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_Order',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'订单编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_Order',
'COLUMN', N'F_OrderCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'客户',
'SCHEMA', N'dbo',
'TABLE', N'mes_Order',
'COLUMN', N'F_Customer'
GO

EXEC sp_addextendedproperty
'MS_Description', N'计划开始时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_Order',
'COLUMN', N'F_PlanStartTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'计划结束时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_Order',
'COLUMN', N'F_PlanEndTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'天数',
'SCHEMA', N'dbo',
'TABLE', N'mes_Order',
'COLUMN', N'F_DayNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_Order',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'完成状态',
'SCHEMA', N'dbo',
'TABLE', N'mes_Order',
'COLUMN', N'F_IsFinish'
GO

EXEC sp_addextendedproperty
'MS_Description', N'预期完成时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_Order',
'COLUMN', N'F_PredictOverTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'实际完成时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_Order',
'COLUMN', N'F_ActualOverTime'
GO


-- ----------------------------
-- Records of mes_Order
-- ----------------------------

-- ----------------------------
-- Table structure for mes_OrderDetail
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_OrderDetail]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_OrderDetail]
GO

CREATE TABLE [dbo].[mes_OrderDetail] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_OrderId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_NeedNum] float(53) DEFAULT 0 NOT NULL
)
GO

ALTER TABLE [dbo].[mes_OrderDetail] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_OrderDetail',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'订单Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_OrderDetail',
'COLUMN', N'F_OrderId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_OrderDetail',
'COLUMN', N'F_MaterialId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'需求数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_OrderDetail',
'COLUMN', N'F_NeedNum'
GO


-- ----------------------------
-- Records of mes_OrderDetail
-- ----------------------------

-- ----------------------------
-- Table structure for mes_OutputInfo
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_OutputInfo]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_OutputInfo]
GO

CREATE TABLE [dbo].[mes_OutputInfo] (
  [F_Id] bigint  IDENTITY(1,1) NOT NULL,
  [F_TransferBoxCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialUnit] nvarchar(10) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialType] int DEFAULT 0 NOT NULL,
  [F_MaterialBatch] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Num] float(53) DEFAULT 0 NOT NULL,
  [F_ProcessId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ProcessName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EqpId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EqpName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_WorkOrderId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_WorkOrderCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_WorkOrderRunSort] int  NULL,
  [F_LocationCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_WorkOrderDetailId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorUserName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_BandingUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_BandingUserName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_BandingTime] datetime2(7)  NULL,
  [F_IsTemp] tinyint DEFAULT 0 NULL
)
GO

ALTER TABLE [dbo].[mes_OutputInfo] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutputInfo',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流转箱编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutputInfo',
'COLUMN', N'F_TransferBoxCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutputInfo',
'COLUMN', N'F_MaterialId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutputInfo',
'COLUMN', N'F_MaterialCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutputInfo',
'COLUMN', N'F_MaterialName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号单位',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutputInfo',
'COLUMN', N'F_MaterialUnit'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号分类',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutputInfo',
'COLUMN', N'F_MaterialType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号批次',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutputInfo',
'COLUMN', N'F_MaterialBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutputInfo',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutputInfo',
'COLUMN', N'F_CreatorTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人id',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutputInfo',
'COLUMN', N'F_CreatorUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutputInfo',
'COLUMN', N'F_Num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工序Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutputInfo',
'COLUMN', N'F_ProcessId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工序名称',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutputInfo',
'COLUMN', N'F_ProcessName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutputInfo',
'COLUMN', N'F_EqpId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备名称',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutputInfo',
'COLUMN', N'F_EqpName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工单Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutputInfo',
'COLUMN', N'F_WorkOrderId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工单编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutputInfo',
'COLUMN', N'F_WorkOrderCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'执行顺序',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutputInfo',
'COLUMN', N'F_WorkOrderRunSort'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工单明细Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutputInfo',
'COLUMN', N'F_WorkOrderDetailId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutputInfo',
'COLUMN', N'F_CreatorUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'绑定人id',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutputInfo',
'COLUMN', N'F_BandingUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'绑定人',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutputInfo',
'COLUMN', N'F_BandingUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'绑定时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutputInfo',
'COLUMN', N'F_BandingTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'临时标识绑定中',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutputInfo',
'COLUMN', N'F_IsTemp'
GO

EXEC sp_addextendedproperty
'MS_Description', N'继续生产',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutputInfo',
'COLUMN', N'F_GoOnProduce'
GO


-- ----------------------------
-- Records of mes_OutputInfo
-- ----------------------------
SET IDENTITY_INSERT [dbo].[mes_OutputInfo] ON
GO

SET IDENTITY_INSERT [dbo].[mes_OutputInfo] OFF
GO


-- ----------------------------
-- Table structure for mes_OutStorage
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_OutStorage]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_OutStorage]
GO

CREATE TABLE [dbo].[mes_OutStorage] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_OutStorageCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialUnit] nvarchar(10) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialType] int DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Num] float(53) DEFAULT 0 NOT NULL,
  [F_DoneNum] float(53) DEFAULT 0 NOT NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_OutStorageState] int DEFAULT 0 NOT NULL,
  [F_PlanTime] datetime2(7)  NULL,
  [F_CarNo] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_OrderId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsUserEdit] tinyint  NULL
)
GO

ALTER TABLE [dbo].[mes_OutStorage] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorage',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库单编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorage',
'COLUMN', N'F_OutStorageCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorage',
'COLUMN', N'F_MaterialId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorage',
'COLUMN', N'F_MaterialCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorage',
'COLUMN', N'F_MaterialName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号单位',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorage',
'COLUMN', N'F_MaterialUnit'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号分类',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorage',
'COLUMN', N'F_MaterialType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorage',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorage',
'COLUMN', N'F_CreatorTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人id',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorage',
'COLUMN', N'F_CreatorUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorage',
'COLUMN', N'F_Num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'完成数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorage',
'COLUMN', N'F_DoneNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库单状态',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorage',
'COLUMN', N'F_OutStorageState'
GO

EXEC sp_addextendedproperty
'MS_Description', N'计划时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorage',
'COLUMN', N'F_PlanTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'车牌',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorage',
'COLUMN', N'F_CarNo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'订单Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorage',
'COLUMN', N'F_OrderId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否修改',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorage',
'COLUMN', N'F_IsUserEdit'
GO


-- ----------------------------
-- Records of mes_OutStorage
-- ----------------------------

-- ----------------------------
-- Table structure for mes_OutStorageInfo
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_OutStorageInfo]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_OutStorageInfo]
GO

CREATE TABLE [dbo].[mes_OutStorageInfo] (
  [F_Id] bigint  IDENTITY(1,1) NOT NULL,
  [F_TransferBoxCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialUnit] nvarchar(10) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialType] int DEFAULT 0 NOT NULL,
  [F_MaterialBatch] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Num] float(53) DEFAULT 0 NOT NULL,
  [F_OutStorageId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LocationCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorUserName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_BandingUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_BandingUserName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_BandingTime] datetime2(7)  NULL,
  [F_TargetTransferCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsTemp] tinyint DEFAULT 0 NULL
)
GO

ALTER TABLE [dbo].[mes_OutStorageInfo] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorageInfo',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流转箱编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorageInfo',
'COLUMN', N'F_TransferBoxCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorageInfo',
'COLUMN', N'F_MaterialId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorageInfo',
'COLUMN', N'F_MaterialCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorageInfo',
'COLUMN', N'F_MaterialName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号单位',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorageInfo',
'COLUMN', N'F_MaterialUnit'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号分类',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorageInfo',
'COLUMN', N'F_MaterialType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号批次',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorageInfo',
'COLUMN', N'F_MaterialBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorageInfo',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorageInfo',
'COLUMN', N'F_CreatorTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人id',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorageInfo',
'COLUMN', N'F_CreatorUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorageInfo',
'COLUMN', N'F_Num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'出库单id',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorageInfo',
'COLUMN', N'F_OutStorageId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorageInfo',
'COLUMN', N'F_CreatorUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'绑定人id',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorageInfo',
'COLUMN', N'F_BandingUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'绑定人',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorageInfo',
'COLUMN', N'F_BandingUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'绑定时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorageInfo',
'COLUMN', N'F_BandingTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'装箱容器',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorageInfo',
'COLUMN', N'F_TargetTransferCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'临时标识绑定中',
'SCHEMA', N'dbo',
'TABLE', N'mes_OutStorageInfo',
'COLUMN', N'F_IsTemp'
GO


-- ----------------------------
-- Records of mes_OutStorageInfo
-- ----------------------------
SET IDENTITY_INSERT [dbo].[mes_OutStorageInfo] ON
GO

SET IDENTITY_INSERT [dbo].[mes_OutStorageInfo] OFF
GO


-- ----------------------------
-- Table structure for mes_ProcessEqpBanding
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_ProcessEqpBanding]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_ProcessEqpBanding]
GO

CREATE TABLE [dbo].[mes_ProcessEqpBanding] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_ProcessId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_EqpId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL
)
GO

ALTER TABLE [dbo].[mes_ProcessEqpBanding] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'工序主键-1',
'SCHEMA', N'dbo',
'TABLE', N'mes_ProcessEqpBanding',
'COLUMN', N'F_ProcessId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备主键-1',
'SCHEMA', N'dbo',
'TABLE', N'mes_ProcessEqpBanding',
'COLUMN', N'F_EqpId'
GO


-- ----------------------------
-- Records of mes_ProcessEqpBanding
-- ----------------------------

-- ----------------------------
-- Table structure for mes_ProcessFlow
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_ProcessFlow]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_ProcessFlow]
GO

CREATE TABLE [dbo].[mes_ProcessFlow] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_ProcessFlowName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[mes_ProcessFlow] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'工序id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ProcessFlow',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工序名称',
'SCHEMA', N'dbo',
'TABLE', N'mes_ProcessFlow',
'COLUMN', N'F_ProcessFlowName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工序备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_ProcessFlow',
'COLUMN', N'F_Description'
GO


-- ----------------------------
-- Records of mes_ProcessFlow
-- ----------------------------

-- ----------------------------
-- Table structure for mes_ReadyTransferBox
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_ReadyTransferBox]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_ReadyTransferBox]
GO

CREATE TABLE [dbo].[mes_ReadyTransferBox] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_TransferBoxCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EqpId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL
)
GO

ALTER TABLE [dbo].[mes_ReadyTransferBox] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'流转箱编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_ReadyTransferBox',
'COLUMN', N'F_TransferBoxCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ReadyTransferBox',
'COLUMN', N'F_EqpId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_ReadyTransferBox',
'COLUMN', N'F_CreatorTime'
GO


-- ----------------------------
-- Records of mes_ReadyTransferBox
-- ----------------------------

-- ----------------------------
-- Table structure for mes_ReturnMaterial
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_ReturnMaterial]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_ReturnMaterial]
GO

CREATE TABLE [dbo].[mes_ReturnMaterial] (
  [F_Id] bigint  IDENTITY(1,1) NOT NULL,
  [F_TransferBoxCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialUnit] nvarchar(10) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialType] int DEFAULT 0 NOT NULL,
  [F_MaterialBatch] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Num] float(53) DEFAULT 0 NOT NULL,
  [F_ProcessId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ProcessName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EqpId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EqpName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_WorkOrderId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_WorkOrderCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_WorkOrderRunSort] int  NULL,
  [F_LocationCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_WorkOrderDetailId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorUserName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[mes_ReturnMaterial] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ReturnMaterial',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流转箱编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_ReturnMaterial',
'COLUMN', N'F_TransferBoxCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ReturnMaterial',
'COLUMN', N'F_MaterialId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_ReturnMaterial',
'COLUMN', N'F_MaterialCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_ReturnMaterial',
'COLUMN', N'F_MaterialName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号单位',
'SCHEMA', N'dbo',
'TABLE', N'mes_ReturnMaterial',
'COLUMN', N'F_MaterialUnit'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号分类',
'SCHEMA', N'dbo',
'TABLE', N'mes_ReturnMaterial',
'COLUMN', N'F_MaterialType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号批次',
'SCHEMA', N'dbo',
'TABLE', N'mes_ReturnMaterial',
'COLUMN', N'F_MaterialBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_ReturnMaterial',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_ReturnMaterial',
'COLUMN', N'F_CreatorTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ReturnMaterial',
'COLUMN', N'F_CreatorUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_ReturnMaterial',
'COLUMN', N'F_Num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工序Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ReturnMaterial',
'COLUMN', N'F_ProcessId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工序名称',
'SCHEMA', N'dbo',
'TABLE', N'mes_ReturnMaterial',
'COLUMN', N'F_ProcessName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ReturnMaterial',
'COLUMN', N'F_EqpId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备名称',
'SCHEMA', N'dbo',
'TABLE', N'mes_ReturnMaterial',
'COLUMN', N'F_EqpName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工单Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ReturnMaterial',
'COLUMN', N'F_WorkOrderId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工单编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_ReturnMaterial',
'COLUMN', N'F_WorkOrderCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'执行顺序',
'SCHEMA', N'dbo',
'TABLE', N'mes_ReturnMaterial',
'COLUMN', N'F_WorkOrderRunSort'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工单明细Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ReturnMaterial',
'COLUMN', N'F_WorkOrderDetailId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'mes_ReturnMaterial',
'COLUMN', N'F_CreatorUserName'
GO


-- ----------------------------
-- Records of mes_ReturnMaterial
-- ----------------------------
SET IDENTITY_INSERT [dbo].[mes_ReturnMaterial] ON
GO

SET IDENTITY_INSERT [dbo].[mes_ReturnMaterial] OFF
GO


-- ----------------------------
-- Table structure for mes_ScapImage
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_ScapImage]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_ScapImage]
GO

CREATE TABLE [dbo].[mes_ScapImage] (
  [F_Id] bigint  IDENTITY(1,1) NOT NULL,
  [F_ScapId] bigint  NOT NULL,
  [F_FilePath] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DescriptionId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[mes_ScapImage] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapImage',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'可疑id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapImage',
'COLUMN', N'F_ScapId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'上传路径',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapImage',
'COLUMN', N'F_FilePath'
GO

EXEC sp_addextendedproperty
'MS_Description', N'缺陷信息',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapImage',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'缺陷id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapImage',
'COLUMN', N'F_DescriptionId'
GO


-- ----------------------------
-- Records of mes_ScapImage
-- ----------------------------
SET IDENTITY_INSERT [dbo].[mes_ScapImage] ON
GO

SET IDENTITY_INSERT [dbo].[mes_ScapImage] OFF
GO


-- ----------------------------
-- Table structure for mes_ScapMaterial
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_ScapMaterial]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_ScapMaterial]
GO

CREATE TABLE [dbo].[mes_ScapMaterial] (
  [F_Id] bigint  IDENTITY(1,1) NOT NULL,
  [F_BatchCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialUnit] nvarchar(10) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialType] int DEFAULT 0 NOT NULL,
  [F_MaterialBatch] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorUserName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CheckId] bigint  NOT NULL,
  [F_CheckType] int  NOT NULL,
  [F_IsCheck] tinyint  NOT NULL,
  [F_IsTemp] tinyint  NOT NULL,
  [F_Num] float(53) DEFAULT 0 NOT NULL,
  [F_ScapNum] float(53) DEFAULT 0 NOT NULL,
  [F_ReturnNum] float(53) DEFAULT 0 NOT NULL
)
GO

ALTER TABLE [dbo].[mes_ScapMaterial] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterial',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'条码编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterial',
'COLUMN', N'F_BatchCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterial',
'COLUMN', N'F_MaterialId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterial',
'COLUMN', N'F_MaterialCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterial',
'COLUMN', N'F_MaterialName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号单位',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterial',
'COLUMN', N'F_MaterialUnit'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号分类',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterial',
'COLUMN', N'F_MaterialType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号批次',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterial',
'COLUMN', N'F_MaterialBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterial',
'COLUMN', N'F_CreatorTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterial',
'COLUMN', N'F_CreatorUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterial',
'COLUMN', N'F_CreatorUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'检验id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterial',
'COLUMN', N'F_CheckId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'检验类型',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterial',
'COLUMN', N'F_CheckType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'检验完成',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterial',
'COLUMN', N'F_IsCheck'
GO

EXEC sp_addextendedproperty
'MS_Description', N'临时表示还在常规质检',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterial',
'COLUMN', N'F_IsTemp'
GO

EXEC sp_addextendedproperty
'MS_Description', N'可疑数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterial',
'COLUMN', N'F_Num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'报废数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterial',
'COLUMN', N'F_ScapNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'退回数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterial',
'COLUMN', N'F_ReturnNum'
GO


-- ----------------------------
-- Records of mes_ScapMaterial
-- ----------------------------
SET IDENTITY_INSERT [dbo].[mes_ScapMaterial] ON
GO

SET IDENTITY_INSERT [dbo].[mes_ScapMaterial] OFF
GO


-- ----------------------------
-- Table structure for mes_ScapMaterialReturn
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_ScapMaterialReturn]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_ScapMaterialReturn]
GO

CREATE TABLE [dbo].[mes_ScapMaterialReturn] (
  [F_Id] bigint  IDENTITY(1,1) NOT NULL,
  [F_BatchCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_ScapMaterialId] bigint  NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialUnit] nvarchar(10) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialType] int DEFAULT 0 NOT NULL,
  [F_MaterialBatch] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorUserName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Num] float(53)  NOT NULL,
  [F_TransferBoxCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_BackMaterialBatch] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsProduce] bit DEFAULT 0 NOT NULL
)
GO

ALTER TABLE [dbo].[mes_ScapMaterialReturn] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterialReturn',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'条码编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterialReturn',
'COLUMN', N'F_BatchCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'可疑物料Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterialReturn',
'COLUMN', N'F_ScapMaterialId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterialReturn',
'COLUMN', N'F_MaterialId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterialReturn',
'COLUMN', N'F_MaterialCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterialReturn',
'COLUMN', N'F_MaterialName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号单位',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterialReturn',
'COLUMN', N'F_MaterialUnit'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号分类',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterialReturn',
'COLUMN', N'F_MaterialType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号批次',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterialReturn',
'COLUMN', N'F_MaterialBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterialReturn',
'COLUMN', N'F_CreatorTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人id',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterialReturn',
'COLUMN', N'F_CreatorUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterialReturn',
'COLUMN', N'F_CreatorUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'退回数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterialReturn',
'COLUMN', N'F_Num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'退回流转箱编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterialReturn',
'COLUMN', N'F_TransferBoxCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'退回料号批次',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterialReturn',
'COLUMN', N'F_BackMaterialBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否生产',
'SCHEMA', N'dbo',
'TABLE', N'mes_ScapMaterialReturn',
'COLUMN', N'F_IsProduce'
GO


-- ----------------------------
-- Records of mes_ScapMaterialReturn
-- ----------------------------
SET IDENTITY_INSERT [dbo].[mes_ScapMaterialReturn] ON
GO

SET IDENTITY_INSERT [dbo].[mes_ScapMaterialReturn] OFF
GO


-- ----------------------------
-- Table structure for mes_Storage
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_Storage]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_Storage]
GO

CREATE TABLE [dbo].[mes_Storage] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_TransferBoxCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialUnit] nvarchar(10) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialType] int DEFAULT 0 NOT NULL,
  [F_MaterialBatch] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Num] float(53) DEFAULT 0 NOT NULL,
  [F_LocationCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsCheckout] tinyint DEFAULT 0 NOT NULL,
  [F_BatchId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[mes_Storage] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_Storage',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流转箱编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_Storage',
'COLUMN', N'F_TransferBoxCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_Storage',
'COLUMN', N'F_MaterialId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_Storage',
'COLUMN', N'F_MaterialCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_Storage',
'COLUMN', N'F_MaterialName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号单位',
'SCHEMA', N'dbo',
'TABLE', N'mes_Storage',
'COLUMN', N'F_MaterialUnit'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号分类',
'SCHEMA', N'dbo',
'TABLE', N'mes_Storage',
'COLUMN', N'F_MaterialType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号批次',
'SCHEMA', N'dbo',
'TABLE', N'mes_Storage',
'COLUMN', N'F_MaterialBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_Storage',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_Storage',
'COLUMN', N'F_CreatorTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人id',
'SCHEMA', N'dbo',
'TABLE', N'mes_Storage',
'COLUMN', N'F_CreatorUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_Storage',
'COLUMN', N'F_Num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'批次Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_Storage',
'COLUMN', N'F_BatchId'
GO


-- ----------------------------
-- Records of mes_Storage
-- ----------------------------

-- ----------------------------
-- Table structure for mes_StorageChangeInfo
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_StorageChangeInfo]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_StorageChangeInfo]
GO

CREATE TABLE [dbo].[mes_StorageChangeInfo] (
  [F_Id] bigint  IDENTITY(1,1) NOT NULL,
  [F_TransferBoxCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialUnit] nvarchar(10) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialType] int DEFAULT 0 NOT NULL,
  [F_MaterialBatch] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Num] float(53) DEFAULT 0 NOT NULL,
  [F_LocationCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_NewLocationCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_NewTransferBoxCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorUserName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_StorageId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ChangeType] int DEFAULT 0 NULL
)
GO

ALTER TABLE [dbo].[mes_StorageChangeInfo] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_StorageChangeInfo',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流转箱编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_StorageChangeInfo',
'COLUMN', N'F_TransferBoxCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_StorageChangeInfo',
'COLUMN', N'F_MaterialId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_StorageChangeInfo',
'COLUMN', N'F_MaterialCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号描述',
'SCHEMA', N'dbo',
'TABLE', N'mes_StorageChangeInfo',
'COLUMN', N'F_MaterialName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号单位',
'SCHEMA', N'dbo',
'TABLE', N'mes_StorageChangeInfo',
'COLUMN', N'F_MaterialUnit'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号分类',
'SCHEMA', N'dbo',
'TABLE', N'mes_StorageChangeInfo',
'COLUMN', N'F_MaterialType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号批次',
'SCHEMA', N'dbo',
'TABLE', N'mes_StorageChangeInfo',
'COLUMN', N'F_MaterialBatch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_StorageChangeInfo',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_StorageChangeInfo',
'COLUMN', N'F_CreatorTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人id',
'SCHEMA', N'dbo',
'TABLE', N'mes_StorageChangeInfo',
'COLUMN', N'F_CreatorUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'转移数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_StorageChangeInfo',
'COLUMN', N'F_Num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'库位编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_StorageChangeInfo',
'COLUMN', N'F_LocationCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'新库位编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_StorageChangeInfo',
'COLUMN', N'F_NewLocationCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'新流转箱编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_StorageChangeInfo',
'COLUMN', N'F_NewTransferBoxCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'mes_StorageChangeInfo',
'COLUMN', N'F_CreatorUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'变动类型',
'SCHEMA', N'dbo',
'TABLE', N'mes_StorageChangeInfo',
'COLUMN', N'F_ChangeType'
GO


-- ----------------------------
-- Records of mes_StorageChangeInfo
-- ----------------------------
SET IDENTITY_INSERT [dbo].[mes_StorageChangeInfo] ON
GO

SET IDENTITY_INSERT [dbo].[mes_StorageChangeInfo] OFF
GO


-- ----------------------------
-- Table structure for mes_TransferBox
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_TransferBox]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_TransferBox]
GO

CREATE TABLE [dbo].[mes_TransferBox] (
  [F_Id] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_TransferCode] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_TransferType] varchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT 0 NOT NULL,
  [F_TransferMaxNum] float(53) DEFAULT 0 NOT NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_TransferState] int DEFAULT 0 NULL,
  [F_LocationCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsTemp] tinyint DEFAULT 0 NULL
)
GO

ALTER TABLE [dbo].[mes_TransferBox] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'流转箱编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_TransferBox',
'COLUMN', N'F_TransferCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流转箱类型',
'SCHEMA', N'dbo',
'TABLE', N'mes_TransferBox',
'COLUMN', N'F_TransferType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流转箱最大数',
'SCHEMA', N'dbo',
'TABLE', N'mes_TransferBox',
'COLUMN', N'F_TransferMaxNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_TransferBox',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流转箱状态',
'SCHEMA', N'dbo',
'TABLE', N'mes_TransferBox',
'COLUMN', N'F_TransferState'
GO

EXEC sp_addextendedproperty
'MS_Description', N'库位编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_TransferBox',
'COLUMN', N'F_LocationCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否一次性',
'SCHEMA', N'dbo',
'TABLE', N'mes_TransferBox',
'COLUMN', N'F_IsTemp'
GO


-- ----------------------------
-- Records of mes_TransferBox
-- ----------------------------

-- ----------------------------
-- Table structure for mes_TransferBoxBatch
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_TransferBoxBatch]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_TransferBoxBatch]
GO

CREATE TABLE [dbo].[mes_TransferBoxBatch] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_BatchName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaxNum] int  NOT NULL,
  [F_BatchCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_BatchNum] bigint DEFAULT 1 NULL,
  [F_IsCheck] bit DEFAULT 0 NULL
)
GO

ALTER TABLE [dbo].[mes_TransferBoxBatch] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'容器条码名称',
'SCHEMA', N'dbo',
'TABLE', N'mes_TransferBoxBatch',
'COLUMN', N'F_BatchName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'容器最大数',
'SCHEMA', N'dbo',
'TABLE', N'mes_TransferBoxBatch',
'COLUMN', N'F_MaxNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'编号前缀',
'SCHEMA', N'dbo',
'TABLE', N'mes_TransferBoxBatch',
'COLUMN', N'F_BatchCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'当前编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_TransferBoxBatch',
'COLUMN', N'F_BatchNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否质检',
'SCHEMA', N'dbo',
'TABLE', N'mes_TransferBoxBatch',
'COLUMN', N'F_IsCheck'
GO


-- ----------------------------
-- Records of mes_TransferBoxBatch
-- ----------------------------

-- ----------------------------
-- Table structure for mes_TransferTypeMaterialBanding
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_TransferTypeMaterialBanding]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_TransferTypeMaterialBanding]
GO

CREATE TABLE [dbo].[mes_TransferTypeMaterialBanding] (
  [F_Id] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_TransferType] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialId] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL
)
GO

ALTER TABLE [dbo].[mes_TransferTypeMaterialBanding] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'流转箱类型',
'SCHEMA', N'dbo',
'TABLE', N'mes_TransferTypeMaterialBanding',
'COLUMN', N'F_TransferType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'物料Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_TransferTypeMaterialBanding',
'COLUMN', N'F_MaterialId'
GO


-- ----------------------------
-- Records of mes_TransferTypeMaterialBanding
-- ----------------------------

-- ----------------------------
-- Table structure for mes_WorkDetailEqpBanding
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_WorkDetailEqpBanding]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_WorkDetailEqpBanding]
GO

CREATE TABLE [dbo].[mes_WorkDetailEqpBanding] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_WorkOrderDetailId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_EqpId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_EqpType] int  NOT NULL,
  [F_EqpUse] int  NOT NULL,
  [F_MouldNum] int DEFAULT 0 NOT NULL,
  [F_IsMaster] tinyint DEFAULT 0 NOT NULL
)
GO

ALTER TABLE [dbo].[mes_WorkDetailEqpBanding] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkDetailEqpBanding',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工单明细Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkDetailEqpBanding',
'COLUMN', N'F_WorkOrderDetailId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkDetailEqpBanding',
'COLUMN', N'F_EqpId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备类型',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkDetailEqpBanding',
'COLUMN', N'F_EqpType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备用途',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkDetailEqpBanding',
'COLUMN', N'F_EqpUse'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模块使用数',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkDetailEqpBanding',
'COLUMN', N'F_MouldNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否主设备',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkDetailEqpBanding',
'COLUMN', N'F_IsMaster'
GO


-- ----------------------------
-- Records of mes_WorkDetailEqpBanding
-- ----------------------------

-- ----------------------------
-- Table structure for mes_WorkDetailProcessBanding
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_WorkDetailProcessBanding]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_WorkDetailProcessBanding]
GO

CREATE TABLE [dbo].[mes_WorkDetailProcessBanding] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_WorkOrderDetailId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_ProcessId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL
)
GO

ALTER TABLE [dbo].[mes_WorkDetailProcessBanding] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkDetailProcessBanding',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工单明细Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkDetailProcessBanding',
'COLUMN', N'F_WorkOrderDetailId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工序Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkDetailProcessBanding',
'COLUMN', N'F_ProcessId'
GO


-- ----------------------------
-- Records of mes_WorkDetailProcessBanding
-- ----------------------------

-- ----------------------------
-- Table structure for mes_WorkDetailTimeBanding
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_WorkDetailTimeBanding]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_WorkDetailTimeBanding]
GO

CREATE TABLE [dbo].[mes_WorkDetailTimeBanding] (
  [F_Id] bigint  IDENTITY(1,1) NOT NULL,
  [F_WorkOrderDetailId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_EqpWorkTimeId] bigint  NOT NULL
)
GO

ALTER TABLE [dbo].[mes_WorkDetailTimeBanding] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkDetailTimeBanding',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'明细id',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkDetailTimeBanding',
'COLUMN', N'F_WorkOrderDetailId'
GO


-- ----------------------------
-- Records of mes_WorkDetailTimeBanding
-- ----------------------------
SET IDENTITY_INSERT [dbo].[mes_WorkDetailTimeBanding] ON
GO

SET IDENTITY_INSERT [dbo].[mes_WorkDetailTimeBanding] OFF
GO


-- ----------------------------
-- Table structure for mes_WorkOrder
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_WorkOrder]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_WorkOrder]
GO

CREATE TABLE [dbo].[mes_WorkOrder] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_WorkOrderCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_PlanNum] int DEFAULT 0 NOT NULL,
  [F_DoneNum] int DEFAULT 0 NOT NULL,
  [F_BadNum] int DEFAULT 0 NOT NULL,
  [F_WorkOrderState] int DEFAULT 0 NOT NULL,
  [F_PlanStartTime] datetime2(7)  NULL,
  [F_PlanEndTime] datetime2(7)  NULL,
  [F_RealStartTime] datetime2(7)  NULL,
  [F_RealEndTime] datetime2(7)  NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_SplitType] int DEFAULT 0 NOT NULL,
  [F_WorkPlanId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_SalesOrderId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_SalesOrderCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_SalesOrderDetailId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[mes_WorkOrder] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrder',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工单编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrder',
'COLUMN', N'F_WorkOrderCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrder',
'COLUMN', N'F_MaterialId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'计划数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrder',
'COLUMN', N'F_PlanNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'完成数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrder',
'COLUMN', N'F_DoneNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'不良数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrder',
'COLUMN', N'F_BadNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工单状态',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrder',
'COLUMN', N'F_WorkOrderState'
GO

EXEC sp_addextendedproperty
'MS_Description', N'计划开始时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrder',
'COLUMN', N'F_PlanStartTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'计划结束时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrder',
'COLUMN', N'F_PlanEndTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'开始时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrder',
'COLUMN', N'F_RealStartTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'结束时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrder',
'COLUMN', N'F_RealEndTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrder',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'计划ID',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrder',
'COLUMN', N'F_WorkPlanId'
GO


-- ----------------------------
-- Records of mes_WorkOrder
-- ----------------------------

-- ----------------------------
-- Table structure for mes_WorkOrderDetail
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_WorkOrderDetail]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_WorkOrderDetail]
GO

CREATE TABLE [dbo].[mes_WorkOrderDetail] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_WorkOrderId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_PlanNum] float(53) DEFAULT 0 NOT NULL,
  [F_DoneNum] float(53) DEFAULT 0 NOT NULL,
  [F_BadNum] float(53) DEFAULT 0 NOT NULL,
  [F_WorkOrderState] int DEFAULT 0 NOT NULL,
  [F_PlanStartTime] datetime2(7)  NULL,
  [F_PlanEndTime] datetime2(7)  NULL,
  [F_RealStartTime] datetime2(7)  NULL,
  [F_RealEndTime] datetime2(7)  NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_RunSort] int  NULL
)
GO

ALTER TABLE [dbo].[mes_WorkOrderDetail] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrderDetail',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工单编号',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrderDetail',
'COLUMN', N'F_WorkOrderId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrderDetail',
'COLUMN', N'F_MaterialId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'计划数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrderDetail',
'COLUMN', N'F_PlanNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'完成数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrderDetail',
'COLUMN', N'F_DoneNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'不良数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrderDetail',
'COLUMN', N'F_BadNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工单状态',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrderDetail',
'COLUMN', N'F_WorkOrderState'
GO

EXEC sp_addextendedproperty
'MS_Description', N'计划开始时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrderDetail',
'COLUMN', N'F_PlanStartTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'计划结束时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrderDetail',
'COLUMN', N'F_PlanEndTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'开始时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrderDetail',
'COLUMN', N'F_RealStartTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'结束时间',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrderDetail',
'COLUMN', N'F_RealEndTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrderDetail',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'执行顺序',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrderDetail',
'COLUMN', N'F_RunSort'
GO


-- ----------------------------
-- Records of mes_WorkOrderDetail
-- ----------------------------

-- ----------------------------
-- Table structure for mes_WorkOrderDetailData
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_WorkOrderDetailData]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_WorkOrderDetailData]
GO

CREATE TABLE [dbo].[mes_WorkOrderDetailData] (
  [F_WorkOrderDetailId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_EqpId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_DataTable] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DataTableId] bigint  NULL,
  [F_MouldNum] int  NULL
)
GO

ALTER TABLE [dbo].[mes_WorkOrderDetailData] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'子工单ID',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrderDetailData',
'COLUMN', N'F_WorkOrderDetailId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备ID',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrderDetailData',
'COLUMN', N'F_EqpId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数据采集表名（HotlineData,WeldlineData,LaserlineData）',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrderDetailData',
'COLUMN', N'F_DataTable'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数据采集表记录ID',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrderDetailData',
'COLUMN', N'F_DataTableId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'每次产出数',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkOrderDetailData',
'COLUMN', N'F_MouldNum'
GO


-- ----------------------------
-- Records of mes_WorkOrderDetailData
-- ----------------------------

-- ----------------------------
-- Table structure for mes_WorkPlan
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_WorkPlan]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_WorkPlan]
GO

CREATE TABLE [dbo].[mes_WorkPlan] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Date] date  NULL,
  [F_ClassNum] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EqpId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EqpName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_PlanNum] float(53) DEFAULT 0 NOT NULL,
  [F_DoneNum] float(53) DEFAULT 0 NOT NULL,
  [F_WorkPlanType] int DEFAULT 0 NOT NULL,
  [F_IsUserEdit] tinyint  NULL,
  [F_ProcessId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[mes_WorkPlan] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'id',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkPlan',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'计划说明',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkPlan',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'计划日期',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkPlan',
'COLUMN', N'F_Date'
GO

EXEC sp_addextendedproperty
'MS_Description', N'班别（A白班，B夜班）',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkPlan',
'COLUMN', N'F_ClassNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkPlan',
'COLUMN', N'F_EqpId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备名称',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkPlan',
'COLUMN', N'F_EqpName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号Id',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkPlan',
'COLUMN', N'F_MaterialId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'计划数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkPlan',
'COLUMN', N'F_PlanNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'完成数量',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkPlan',
'COLUMN', N'F_DoneNum'
GO

EXEC sp_addextendedproperty
'MS_Description', N'计划类型',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkPlan',
'COLUMN', N'F_WorkPlanType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否修改',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkPlan',
'COLUMN', N'F_IsUserEdit'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工序',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkPlan',
'COLUMN', N'F_ProcessId'
GO


-- ----------------------------
-- Records of mes_WorkPlan
-- ----------------------------

-- ----------------------------
-- Table structure for mob_DingTalkConfig
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mob_DingTalkConfig]') AND type IN ('U'))
	DROP TABLE [dbo].[mob_DingTalkConfig]
GO

CREATE TABLE [dbo].[mob_DingTalkConfig] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_DingType] int  NOT NULL,
  [F_IsWebLogin] tinyint DEFAULT 0 NOT NULL,
  [F_AppName] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_RedirectUrl] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_AppId] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_AppSecret] varchar(100) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_AgentId] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorUserName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_AppKey] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsDingInfo] tinyint DEFAULT 0 NOT NULL,
  [F_Url] nvarchar(255) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsBoardLogin] tinyint DEFAULT 0 NOT NULL
)
GO

ALTER TABLE [dbo].[mob_DingTalkConfig] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of mob_DingTalkConfig
-- ----------------------------
INSERT INTO [dbo].[mob_DingTalkConfig] ([F_Id], [F_DingType], [F_IsWebLogin], [F_AppName], [F_RedirectUrl], [F_AppId], [F_AppSecret], [F_AgentId], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_CreatorUserName], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_AppKey], [F_IsDingInfo], [F_Url], [F_IsBoardLogin]) VALUES (N'08d94c02-7cb6-4275-8b5a-b344e494df63', N'1', N'0', N'看板Web', N'http://127.0.0.1:8082/BoardLogin/DingLogin', N'xxxxxxxx', N'xxxxxxxxxx', N'', N'0', N'1', N'', N'2021-07-21 12:46:22.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, N'2022-10-19 10:08:29.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'', N'0', N'http://127.0.0.1:8082/', N'1')
GO

INSERT INTO [dbo].[mob_DingTalkConfig] ([F_Id], [F_DingType], [F_IsWebLogin], [F_AppName], [F_RedirectUrl], [F_AppId], [F_AppSecret], [F_AgentId], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_CreatorUserName], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_AppKey], [F_IsDingInfo], [F_Url], [F_IsBoardLogin]) VALUES (N'0a26a181-c0bf-414b-8e54-f688796858b1', N'0', N'0', N'MES小程序', N'', N'', N'RUCXv_EziNLtYo76sBJFoNwj69L1shAOfPbfrABDafgnepo6jQHT7af6gwT4hpK6', N'656255403', N'0', N'1', N'', N'2020-11-21 10:43:11.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, N'2022-10-24 13:00:14.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'dingbxlfyt9shwpqql7a', N'1', N'', N'0')
GO

INSERT INTO [dbo].[mob_DingTalkConfig] ([F_Id], [F_DingType], [F_IsWebLogin], [F_AppName], [F_RedirectUrl], [F_AppId], [F_AppSecret], [F_AgentId], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_CreatorUserName], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_AppKey], [F_IsDingInfo], [F_Url], [F_IsBoardLogin]) VALUES (N'5353df01-dc34-4dc2-bd4b-6cf155ef00e4', N'1', N'1', N'MES系统PC端', N'http://127.0.0.1:8082/Login/DingLogin', N'xxxxxxxxx', N'xxxxxxxxx', N'', N'0', N'1', N'', N'2020-11-21 10:35:30.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, N'2022-10-19 10:09:26.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'', N'0', N'http://127.0.0.1:8082/', N'0')
GO

INSERT INTO [dbo].[mob_DingTalkConfig] ([F_Id], [F_DingType], [F_IsWebLogin], [F_AppName], [F_RedirectUrl], [F_AppId], [F_AppSecret], [F_AgentId], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_CreatorUserName], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_AppKey], [F_IsDingInfo], [F_Url], [F_IsBoardLogin]) VALUES (N'fb494f74-e9f5-4ce6-8dac-2a922cf5c8a8', N'2', N'0', N'Mes系统移动端', N'', N'', N'xxxxxxx', N'xxxxx', N'0', N'1', N'', N'2020-11-23 09:06:28.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, N'2022-10-19 10:08:50.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'xxxxxxxx', N'1', N'http://127.0.0.1:8082/', N'0')
GO


-- ----------------------------
-- Table structure for mob_DingUser
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mob_DingUser]') AND type IN ('U'))
	DROP TABLE [dbo].[mob_DingUser]
GO

CREATE TABLE [dbo].[mob_DingUser] (
  [F_Id] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_SysUserId] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_UserId] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_UserName] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Active] tinyint  NULL,
  [F_OrderInDepts] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsAdmin] tinyint  NULL,
  [F_IsBoss] tinyint  NULL,
  [F_UnionId] varchar(100) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsLeaderInDepts] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsLeader] tinyint  NULL,
  [F_IsHide] tinyint  NULL,
  [F_DepartmentId] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Position] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Avatar] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_HiredDate] datetime2(7)  NULL,
  [F_JobNumber] varchar(100) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsSenior] tinyint  NULL,
  [F_Email] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Mobile] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Order] int  NULL,
  [F_WorkPlace] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_RolesId] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsWork] tinyint  NULL
)
GO

ALTER TABLE [dbo].[mob_DingUser] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'系统用户Id',
'SCHEMA', N'dbo',
'TABLE', N'mob_DingUser',
'COLUMN', N'F_SysUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'员工唯一标识ID',
'SCHEMA', N'dbo',
'TABLE', N'mob_DingUser',
'COLUMN', N'F_UserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'成员名称',
'SCHEMA', N'dbo',
'TABLE', N'mob_DingUser',
'COLUMN', N'F_UserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否已经激活',
'SCHEMA', N'dbo',
'TABLE', N'mob_DingUser',
'COLUMN', N'F_Active'
GO

EXEC sp_addextendedproperty
'MS_Description', N'在对应的部门中的排序，Map结构的json字符串，key是部门的Id，value是人员在这个部门的排序值',
'SCHEMA', N'dbo',
'TABLE', N'mob_DingUser',
'COLUMN', N'F_OrderInDepts'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否为企业的管理员',
'SCHEMA', N'dbo',
'TABLE', N'mob_DingUser',
'COLUMN', N'F_IsAdmin'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否为企业的老板',
'SCHEMA', N'dbo',
'TABLE', N'mob_DingUser',
'COLUMN', N'F_IsBoss'
GO

EXEC sp_addextendedproperty
'MS_Description', N'在当前isv全局范围内唯一标识一个用户的身份,用户无法修改',
'SCHEMA', N'dbo',
'TABLE', N'mob_DingUser',
'COLUMN', N'F_UnionId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'在对应的部门中是否为主管：Map结构的json字符串，key是部门的Id，value是人员在这个部门中是否为主管，true表示是，false表示不是',
'SCHEMA', N'dbo',
'TABLE', N'mob_DingUser',
'COLUMN', N'F_IsLeaderInDepts'
GO

EXEC sp_addextendedproperty
'MS_Description', N' 是否是部门的主管',
'SCHEMA', N'dbo',
'TABLE', N'mob_DingUser',
'COLUMN', N'F_IsLeader'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否号码隐藏',
'SCHEMA', N'dbo',
'TABLE', N'mob_DingUser',
'COLUMN', N'F_IsHide'
GO

EXEC sp_addextendedproperty
'MS_Description', N'成员所属部门id列表',
'SCHEMA', N'dbo',
'TABLE', N'mob_DingUser',
'COLUMN', N'F_DepartmentId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'职位信息',
'SCHEMA', N'dbo',
'TABLE', N'mob_DingUser',
'COLUMN', N'F_Position'
GO

EXEC sp_addextendedproperty
'MS_Description', N'头像url',
'SCHEMA', N'dbo',
'TABLE', N'mob_DingUser',
'COLUMN', N'F_Avatar'
GO

EXEC sp_addextendedproperty
'MS_Description', N'入职时间',
'SCHEMA', N'dbo',
'TABLE', N'mob_DingUser',
'COLUMN', N'F_HiredDate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'员工工号',
'SCHEMA', N'dbo',
'TABLE', N'mob_DingUser',
'COLUMN', N'F_JobNumber'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否是高管',
'SCHEMA', N'dbo',
'TABLE', N'mob_DingUser',
'COLUMN', N'F_IsSenior'
GO

EXEC sp_addextendedproperty
'MS_Description', N'电子邮件',
'SCHEMA', N'dbo',
'TABLE', N'mob_DingUser',
'COLUMN', N'F_Email'
GO

EXEC sp_addextendedproperty
'MS_Description', N'手机号码',
'SCHEMA', N'dbo',
'TABLE', N'mob_DingUser',
'COLUMN', N'F_Mobile'
GO

EXEC sp_addextendedproperty
'MS_Description', N'部门排序',
'SCHEMA', N'dbo',
'TABLE', N'mob_DingUser',
'COLUMN', N'F_Order'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工作地',
'SCHEMA', N'dbo',
'TABLE', N'mob_DingUser',
'COLUMN', N'F_WorkPlace'
GO

EXEC sp_addextendedproperty
'MS_Description', N'新增的钉钉用户在系统中的角色',
'SCHEMA', N'dbo',
'TABLE', N'mob_DingUser',
'COLUMN', N'F_RolesId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否在班',
'SCHEMA', N'dbo',
'TABLE', N'mob_DingUser',
'COLUMN', N'F_IsWork'
GO


-- ----------------------------
-- Records of mob_DingUser
-- ----------------------------

-- ----------------------------
-- Table structure for oms_FlowInstance
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[oms_FlowInstance]') AND type IN ('U'))
	DROP TABLE [dbo].[oms_FlowInstance]
GO

CREATE TABLE [dbo].[oms_FlowInstance] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_InstanceSchemeId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_Code] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CustomName] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ActivityId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ActivityType] int  NULL,
  [F_ActivityName] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_PreviousId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_SchemeContent] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_SchemeId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DbName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_FrmData] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_FrmType] int  NOT NULL,
  [F_FrmContentData] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_FrmContentParse] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_FrmId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_SchemeType] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_FlowLevel] int  NOT NULL,
  [F_Description] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsFinish] int  NOT NULL,
  [F_MakerList] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_OrganizeId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EnabledMark] tinyint  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorUserName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_FrmContent] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[oms_FlowInstance] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'主键Id',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流程实例模板Id',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_InstanceSchemeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'实例编号',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_Code'
GO

EXEC sp_addextendedproperty
'MS_Description', N'自定义名称',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_CustomName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'当前节点ID',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_ActivityId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'当前节点类型（0会签节点）',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_ActivityType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'当前节点名称',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_ActivityName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'前一个ID',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_PreviousId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流程模板内容',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_SchemeContent'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流程模板ID',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_SchemeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数据库名称',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_DbName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单数据',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_FrmData'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单类型',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_FrmType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单字段',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_FrmContentData'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单参数（冗余）',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_FrmContentParse'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单ID',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_FrmId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流程类型',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_SchemeType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'等级',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_FlowLevel'
GO

EXEC sp_addextendedproperty
'MS_Description', N'实例备注',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否完成',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_IsFinish'
GO

EXEC sp_addextendedproperty
'MS_Description', N'执行人',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_MakerList'
GO

EXEC sp_addextendedproperty
'MS_Description', N'所属部门',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_OrganizeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'有效',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_EnabledMark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_CreatorTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建用户主键',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_CreatorUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建用户',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_CreatorUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单元素json',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance',
'COLUMN', N'F_FrmContent'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工作流流程实例表',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstance'
GO


-- ----------------------------
-- Records of oms_FlowInstance
-- ----------------------------

-- ----------------------------
-- Table structure for oms_FlowInstanceHis
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[oms_FlowInstanceHis]') AND type IN ('U'))
	DROP TABLE [dbo].[oms_FlowInstanceHis]
GO

CREATE TABLE [dbo].[oms_FlowInstanceHis] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_InstanceId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_FromNodeId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_FromNodeType] int  NULL,
  [F_FromNodeName] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ToNodeId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ToNodeType] int  NULL,
  [F_ToNodeName] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_TransitionSate] tinyint  NOT NULL,
  [F_IsFinish] tinyint  NOT NULL,
  [F_CreatorTime] datetime2(7)  NOT NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorUserName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[oms_FlowInstanceHis] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'主键Id',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstanceHis',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'实例Id',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstanceHis',
'COLUMN', N'F_InstanceId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'开始节点Id',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstanceHis',
'COLUMN', N'F_FromNodeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'开始节点类型',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstanceHis',
'COLUMN', N'F_FromNodeType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'开始节点名称',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstanceHis',
'COLUMN', N'F_FromNodeName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'结束节点Id',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstanceHis',
'COLUMN', N'F_ToNodeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'结束节点类型',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstanceHis',
'COLUMN', N'F_ToNodeType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'结束节点名称',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstanceHis',
'COLUMN', N'F_ToNodeName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'转化状态',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstanceHis',
'COLUMN', N'F_TransitionSate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否结束',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstanceHis',
'COLUMN', N'F_IsFinish'
GO

EXEC sp_addextendedproperty
'MS_Description', N'转化时间',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstanceHis',
'COLUMN', N'F_CreatorTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作人Id',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstanceHis',
'COLUMN', N'F_CreatorUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作人名称',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstanceHis',
'COLUMN', N'F_CreatorUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工作流实例流转历史记录',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstanceHis'
GO


-- ----------------------------
-- Records of oms_FlowInstanceHis
-- ----------------------------

-- ----------------------------
-- Table structure for oms_FlowInstanceInfo
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[oms_FlowInstanceInfo]') AND type IN ('U'))
	DROP TABLE [dbo].[oms_FlowInstanceInfo]
GO

CREATE TABLE [dbo].[oms_FlowInstanceInfo] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_InstanceId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_Content] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NOT NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorUserName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[oms_FlowInstanceInfo] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'主键Id',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstanceInfo',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'实例进程Id',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstanceInfo',
'COLUMN', N'F_InstanceId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作内容',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstanceInfo',
'COLUMN', N'F_Content'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstanceInfo',
'COLUMN', N'F_CreatorTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建用户主键',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstanceInfo',
'COLUMN', N'F_CreatorUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建用户',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstanceInfo',
'COLUMN', N'F_CreatorUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工作流实例操作记录',
'SCHEMA', N'dbo',
'TABLE', N'oms_FlowInstanceInfo'
GO


-- ----------------------------
-- Records of oms_FlowInstanceInfo
-- ----------------------------

-- ----------------------------
-- Table structure for oms_FormTest
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[oms_FormTest]') AND type IN ('U'))
	DROP TABLE [dbo].[oms_FormTest]
GO

CREATE TABLE [dbo].[oms_FormTest] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_UserName] nvarchar(10) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_RequestType] nvarchar(20) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_StartTime] datetime2(7)  NULL,
  [F_EndTime] datetime2(7)  NULL,
  [F_RequestComment] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Attachment] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NOT NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorUserName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_FlowInstanceId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[oms_FormTest] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'ID',
'SCHEMA', N'dbo',
'TABLE', N'oms_FormTest',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'请假人姓名',
'SCHEMA', N'dbo',
'TABLE', N'oms_FormTest',
'COLUMN', N'F_UserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'请假分类，病假，事假，公休等',
'SCHEMA', N'dbo',
'TABLE', N'oms_FormTest',
'COLUMN', N'F_RequestType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'开始时间',
'SCHEMA', N'dbo',
'TABLE', N'oms_FormTest',
'COLUMN', N'F_StartTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'结束时间',
'SCHEMA', N'dbo',
'TABLE', N'oms_FormTest',
'COLUMN', N'F_EndTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'请假说明',
'SCHEMA', N'dbo',
'TABLE', N'oms_FormTest',
'COLUMN', N'F_RequestComment'
GO

EXEC sp_addextendedproperty
'MS_Description', N'附件，用于提交病假证据等',
'SCHEMA', N'dbo',
'TABLE', N'oms_FormTest',
'COLUMN', N'F_Attachment'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'oms_FormTest',
'COLUMN', N'F_CreatorTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建用户主键',
'SCHEMA', N'dbo',
'TABLE', N'oms_FormTest',
'COLUMN', N'F_CreatorUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建用户',
'SCHEMA', N'dbo',
'TABLE', N'oms_FormTest',
'COLUMN', N'F_CreatorUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'所属流程ID',
'SCHEMA', N'dbo',
'TABLE', N'oms_FormTest',
'COLUMN', N'F_FlowInstanceId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模拟一个自定页面的表单，该数据会关联到流程实例FrmData，可用于复杂页面的设计及后期的数据分析',
'SCHEMA', N'dbo',
'TABLE', N'oms_FormTest'
GO


-- ----------------------------
-- Records of oms_FormTest
-- ----------------------------

-- ----------------------------
-- Table structure for oms_Message
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[oms_Message]') AND type IN ('U'))
	DROP TABLE [dbo].[oms_Message]
GO

CREATE TABLE [dbo].[oms_Message] (
  [F_Id] bigint  IDENTITY(1,1) NOT NULL,
  [F_MessageType] int  NULL,
  [F_ToUserId] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ToUserName] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MessageInfo] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EnabledMark] tinyint  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorUserName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_HrefTarget] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Href] nvarchar(100) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_KeyValue] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ClickRead] tinyint  NULL
)
GO

ALTER TABLE [dbo].[oms_Message] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'主键Id',
'SCHEMA', N'dbo',
'TABLE', N'oms_Message',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'信息类型（通知、私信、处理）',
'SCHEMA', N'dbo',
'TABLE', N'oms_Message',
'COLUMN', N'F_MessageType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'收件人主键',
'SCHEMA', N'dbo',
'TABLE', N'oms_Message',
'COLUMN', N'F_ToUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'收件人',
'SCHEMA', N'dbo',
'TABLE', N'oms_Message',
'COLUMN', N'F_ToUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'内容',
'SCHEMA', N'dbo',
'TABLE', N'oms_Message',
'COLUMN', N'F_MessageInfo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'有效',
'SCHEMA', N'dbo',
'TABLE', N'oms_Message',
'COLUMN', N'F_EnabledMark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'oms_Message',
'COLUMN', N'F_CreatorTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建用户主键',
'SCHEMA', N'dbo',
'TABLE', N'oms_Message',
'COLUMN', N'F_CreatorUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建用户',
'SCHEMA', N'dbo',
'TABLE', N'oms_Message',
'COLUMN', N'F_CreatorUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'跳转类型',
'SCHEMA', N'dbo',
'TABLE', N'oms_Message',
'COLUMN', N'F_HrefTarget'
GO

EXEC sp_addextendedproperty
'MS_Description', N'跳转地址',
'SCHEMA', N'dbo',
'TABLE', N'oms_Message',
'COLUMN', N'F_Href'
GO

EXEC sp_addextendedproperty
'MS_Description', N'待办关联键',
'SCHEMA', N'dbo',
'TABLE', N'oms_Message',
'COLUMN', N'F_KeyValue'
GO

EXEC sp_addextendedproperty
'MS_Description', N'点击已读',
'SCHEMA', N'dbo',
'TABLE', N'oms_Message',
'COLUMN', N'F_ClickRead'
GO


-- ----------------------------
-- Records of oms_Message
-- ----------------------------
SET IDENTITY_INSERT [dbo].[oms_Message] ON
GO

SET IDENTITY_INSERT [dbo].[oms_Message] OFF
GO


-- ----------------------------
-- Table structure for oms_MessageHis
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[oms_MessageHis]') AND type IN ('U'))
	DROP TABLE [dbo].[oms_MessageHis]
GO

CREATE TABLE [dbo].[oms_MessageHis] (
  [F_Id] bigint  IDENTITY(1,1) NOT NULL,
  [F_MessageId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorUserName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[oms_MessageHis] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'主键Id',
'SCHEMA', N'dbo',
'TABLE', N'oms_MessageHis',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'信息Id',
'SCHEMA', N'dbo',
'TABLE', N'oms_MessageHis',
'COLUMN', N'F_MessageId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'oms_MessageHis',
'COLUMN', N'F_CreatorTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建用户主键',
'SCHEMA', N'dbo',
'TABLE', N'oms_MessageHis',
'COLUMN', N'F_CreatorUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建用户',
'SCHEMA', N'dbo',
'TABLE', N'oms_MessageHis',
'COLUMN', N'F_CreatorUserName'
GO


-- ----------------------------
-- Records of oms_MessageHis
-- ----------------------------
SET IDENTITY_INSERT [dbo].[oms_MessageHis] ON
GO

SET IDENTITY_INSERT [dbo].[oms_MessageHis] OFF
GO


-- ----------------------------
-- Table structure for oms_UploadFile
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[oms_UploadFile]') AND type IN ('U'))
	DROP TABLE [dbo].[oms_UploadFile]
GO

CREATE TABLE [dbo].[oms_UploadFile] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_FilePath] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_FileName] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_FileType] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_FileSize] int  NULL,
  [F_FileExtension] nvarchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_FileBy] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Description] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_OrganizeId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EnabledMark] tinyint  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorUserName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[oms_UploadFile] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'主键Id',
'SCHEMA', N'dbo',
'TABLE', N'oms_UploadFile',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'文件路径',
'SCHEMA', N'dbo',
'TABLE', N'oms_UploadFile',
'COLUMN', N'F_FilePath'
GO

EXEC sp_addextendedproperty
'MS_Description', N'文件名称',
'SCHEMA', N'dbo',
'TABLE', N'oms_UploadFile',
'COLUMN', N'F_FileName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'文件类型（0 文件，1 图片）',
'SCHEMA', N'dbo',
'TABLE', N'oms_UploadFile',
'COLUMN', N'F_FileType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'文件大小',
'SCHEMA', N'dbo',
'TABLE', N'oms_UploadFile',
'COLUMN', N'F_FileSize'
GO

EXEC sp_addextendedproperty
'MS_Description', N'文件扩展名',
'SCHEMA', N'dbo',
'TABLE', N'oms_UploadFile',
'COLUMN', N'F_FileExtension'
GO

EXEC sp_addextendedproperty
'MS_Description', N'文件所属',
'SCHEMA', N'dbo',
'TABLE', N'oms_UploadFile',
'COLUMN', N'F_FileBy'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'oms_UploadFile',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'所属部门',
'SCHEMA', N'dbo',
'TABLE', N'oms_UploadFile',
'COLUMN', N'F_OrganizeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'有效',
'SCHEMA', N'dbo',
'TABLE', N'oms_UploadFile',
'COLUMN', N'F_EnabledMark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'oms_UploadFile',
'COLUMN', N'F_CreatorTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建用户主键',
'SCHEMA', N'dbo',
'TABLE', N'oms_UploadFile',
'COLUMN', N'F_CreatorUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建用户',
'SCHEMA', N'dbo',
'TABLE', N'oms_UploadFile',
'COLUMN', N'F_CreatorUserName'
GO


-- ----------------------------
-- Records of oms_UploadFile
-- ----------------------------

-- ----------------------------
-- Table structure for sys_DataPrivilegeRule
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_DataPrivilegeRule]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_DataPrivilegeRule]
GO

CREATE TABLE [dbo].[sys_DataPrivilegeRule] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_ModuleId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ModuleCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_PrivilegeRules] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_SortCode] int  NULL,
  [F_DeleteMark] tinyint  NULL,
  [F_EnabledMark] tinyint  NULL,
  [F_Description] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[sys_DataPrivilegeRule] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of sys_DataPrivilegeRule
-- ----------------------------

-- ----------------------------
-- Table structure for sys_FilterIp
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_FilterIp]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_FilterIp]
GO

CREATE TABLE [dbo].[sys_FilterIp] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_Type] tinyint  NULL,
  [F_StartIP] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EndIP] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_SortCode] int  NULL,
  [F_DeleteMark] tinyint  NULL,
  [F_EnabledMark] tinyint  NULL,
  [F_Description] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EndTime] datetime2(7)  NULL
)
GO

ALTER TABLE [dbo].[sys_FilterIp] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of sys_FilterIp
-- ----------------------------

-- ----------------------------
-- Table structure for sys_FlowScheme
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_FlowScheme]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_FlowScheme]
GO

CREATE TABLE [dbo].[sys_FlowScheme] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_SchemeCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_SchemeName] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_SchemeType] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_SchemeVersion] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_SchemeCanUser] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_SchemeContent] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_FrmId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_FrmType] int  NOT NULL,
  [F_AuthorizeType] int  NOT NULL,
  [F_SortCode] int  NULL,
  [F_DeleteMark] tinyint  NULL,
  [F_EnabledMark] tinyint  NULL,
  [F_Description] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorUserName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyUserName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_OrganizeId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[sys_FlowScheme] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'主键Id',
'SCHEMA', N'dbo',
'TABLE', N'sys_FlowScheme',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流程编号',
'SCHEMA', N'dbo',
'TABLE', N'sys_FlowScheme',
'COLUMN', N'F_SchemeCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流程名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_FlowScheme',
'COLUMN', N'F_SchemeName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流程分类',
'SCHEMA', N'dbo',
'TABLE', N'sys_FlowScheme',
'COLUMN', N'F_SchemeType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流程内容版本',
'SCHEMA', N'dbo',
'TABLE', N'sys_FlowScheme',
'COLUMN', N'F_SchemeVersion'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流程模板使用者',
'SCHEMA', N'dbo',
'TABLE', N'sys_FlowScheme',
'COLUMN', N'F_SchemeCanUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流程内容',
'SCHEMA', N'dbo',
'TABLE', N'sys_FlowScheme',
'COLUMN', N'F_SchemeContent'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_FlowScheme',
'COLUMN', N'F_FrmId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单类型',
'SCHEMA', N'dbo',
'TABLE', N'sys_FlowScheme',
'COLUMN', N'F_FrmType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模板权限类型：0完全公开,1指定部门/人员',
'SCHEMA', N'dbo',
'TABLE', N'sys_FlowScheme',
'COLUMN', N'F_AuthorizeType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'排序码',
'SCHEMA', N'dbo',
'TABLE', N'sys_FlowScheme',
'COLUMN', N'F_SortCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标记',
'SCHEMA', N'dbo',
'TABLE', N'sys_FlowScheme',
'COLUMN', N'F_DeleteMark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'有效',
'SCHEMA', N'dbo',
'TABLE', N'sys_FlowScheme',
'COLUMN', N'F_EnabledMark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'sys_FlowScheme',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_FlowScheme',
'COLUMN', N'F_CreatorTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建用户主键',
'SCHEMA', N'dbo',
'TABLE', N'sys_FlowScheme',
'COLUMN', N'F_CreatorUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建用户',
'SCHEMA', N'dbo',
'TABLE', N'sys_FlowScheme',
'COLUMN', N'F_CreatorUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'修改时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_FlowScheme',
'COLUMN', N'F_LastModifyTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'修改用户主键',
'SCHEMA', N'dbo',
'TABLE', N'sys_FlowScheme',
'COLUMN', N'F_LastModifyUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'修改用户',
'SCHEMA', N'dbo',
'TABLE', N'sys_FlowScheme',
'COLUMN', N'F_LastModifyUserName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'所属部门',
'SCHEMA', N'dbo',
'TABLE', N'sys_FlowScheme',
'COLUMN', N'F_OrganizeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_FlowScheme',
'COLUMN', N'F_DeleteTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除人',
'SCHEMA', N'dbo',
'TABLE', N'sys_FlowScheme',
'COLUMN', N'F_DeleteUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'工作流模板信息表',
'SCHEMA', N'dbo',
'TABLE', N'sys_FlowScheme'
GO


-- ----------------------------
-- Records of sys_FlowScheme
-- ----------------------------

-- ----------------------------
-- Table structure for sys_Form
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_Form]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_Form]
GO

CREATE TABLE [dbo].[sys_Form] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_Name] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_FrmType] int  NULL,
  [F_WebId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Fields] int  NULL,
  [F_ContentData] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ContentParse] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Content] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_SortCode] int  NULL,
  [F_EnabledMark] tinyint  NULL,
  [F_DeleteMark] tinyint  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_OrganizeId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DbName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[sys_Form] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单模板Id',
'SCHEMA', N'dbo',
'TABLE', N'sys_Form',
'COLUMN', N'F_Id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_Form',
'COLUMN', N'F_Name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单类型，0：默认动态表单；1：Web自定义表单',
'SCHEMA', N'dbo',
'TABLE', N'sys_Form',
'COLUMN', N'F_FrmType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'系统页面标识，当表单类型为用Web自定义的表单时，需要标识加载哪个页面',
'SCHEMA', N'dbo',
'TABLE', N'sys_Form',
'COLUMN', N'F_WebId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字段个数',
'SCHEMA', N'dbo',
'TABLE', N'sys_Form',
'COLUMN', N'F_Fields'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单中的控件属性描述',
'SCHEMA', N'dbo',
'TABLE', N'sys_Form',
'COLUMN', N'F_ContentData'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单控件位置模板',
'SCHEMA', N'dbo',
'TABLE', N'sys_Form',
'COLUMN', N'F_ContentParse'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单原html模板未经处理的',
'SCHEMA', N'dbo',
'TABLE', N'sys_Form',
'COLUMN', N'F_Content'
GO

EXEC sp_addextendedproperty
'MS_Description', N'排序码',
'SCHEMA', N'dbo',
'TABLE', N'sys_Form',
'COLUMN', N'F_SortCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否启用',
'SCHEMA', N'dbo',
'TABLE', N'sys_Form',
'COLUMN', N'F_EnabledMark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'逻辑删除标志',
'SCHEMA', N'dbo',
'TABLE', N'sys_Form',
'COLUMN', N'F_DeleteMark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_Form',
'COLUMN', N'F_CreatorTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'sys_Form',
'COLUMN', N'F_CreatorUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后修改时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_Form',
'COLUMN', N'F_LastModifyTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后修改人',
'SCHEMA', N'dbo',
'TABLE', N'sys_Form',
'COLUMN', N'F_LastModifyUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_Form',
'COLUMN', N'F_DeleteTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除人',
'SCHEMA', N'dbo',
'TABLE', N'sys_Form',
'COLUMN', N'F_DeleteUserId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'内容',
'SCHEMA', N'dbo',
'TABLE', N'sys_Form',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'所属组织',
'SCHEMA', N'dbo',
'TABLE', N'sys_Form',
'COLUMN', N'F_OrganizeId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数据库名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_Form',
'COLUMN', N'F_DbName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单模板表',
'SCHEMA', N'dbo',
'TABLE', N'sys_Form'
GO


-- ----------------------------
-- Records of sys_Form
-- ----------------------------

-- ----------------------------
-- Table structure for sys_Items
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_Items]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_Items]
GO

CREATE TABLE [dbo].[sys_Items] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_ParentId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EnCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_FullName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsTree] tinyint  NULL,
  [F_Layers] int  NULL,
  [F_SortCode] int  NULL,
  [F_DeleteMark] tinyint  NULL,
  [F_EnabledMark] tinyint  NULL,
  [F_Description] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[sys_Items] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of sys_Items
-- ----------------------------
INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'002eeaa9-c804-4c98-afd9-7ddc7c1e4c46', N'879dc37f-8b6e-44d5-a153-ce4bdc3e66e1', N'Mes_ControlJobType', N'调度任务类型', N'0', N'2', N'12', N'0', N'1', N'', N'2021-01-20 09:35:26.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'00F76465-DBBA-484A-B75C-E81DEE9313E6', N'77070117-3F1A-41BA-BF81-B8B85BF10D5E', N'Education', N'学历', N'0', N'2', N'8', N'0', N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'08d9344e-25dc-40ab-8eeb-473d9321c7e2', N'879dc37f-8b6e-44d5-a153-ce4bdc3e66e1', N'Mes_StopConfig', N'急停停机配置', N'0', N'2', N'14', N'0', N'1', N'', N'2021-06-21 08:47:30.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'08d93f50-133e-4fe7-860d-4dd9cd33cfe5', N'879dc37f-8b6e-44d5-a153-ce4bdc3e66e1', N'Mes_ScapType', N'可疑状态', N'0', N'2', N'15', N'0', N'1', N'', N'2021-07-05 08:59:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'08dab327-a5c5-4ce4-8567-a45c414ab232', N'879dc37f-8b6e-44d5-a153-ce4bdc3e66e1', N'Mes_MoveEqpSetting', N'流动设备设定', N'0', N'2', N'16', N'0', N'1', N'', N'2022-10-21 13:46:49.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2022-10-21 13:46:56.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'0DF5B725-5FB8-487F-B0E4-BC563A77EB04', N'77070117-3F1A-41BA-BF81-B8B85BF10D5E', N'DbType', N'数据库类型', N'0', N'2', N'4', N'0', N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'15023A4E-4856-44EB-BE71-36A106E2AA59', N'77070117-3F1A-41BA-BF81-B8B85BF10D5E', N'103', N'民族', N'0', N'2', N'14', N'0', N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'2748F35F-4EE2-417C-A907-3453146AAF67', N'77070117-3F1A-41BA-BF81-B8B85BF10D5E', N'Certificate', N'证件名称', N'0', N'2', N'7', N'0', N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'2e440789-bd9b-46a5-9a64-190163f8a9cf', N'879dc37f-8b6e-44d5-a153-ce4bdc3e66e1', N'Mes_EqpState', N'设备状态', N'0', N'2', N'1', N'0', N'1', N'', N'2020-11-30 14:45:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-01 15:51:42.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'3d2fc3d0-ef1c-41c2-9ca0-cf027dc7a854', N'879dc37f-8b6e-44d5-a153-ce4bdc3e66e1', N'Mes_EqpType', N'设备类型', N'0', N'2', N'0', N'0', N'1', N'', N'2020-11-30 14:35:02.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-01 15:51:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'5da129a3-45ce-43cf-a483-e7f9ad90297d', N'879dc37f-8b6e-44d5-a153-ce4bdc3e66e1', N'Mes_MouldType', N'模具类型', N'0', N'2', N'5', N'0', N'1', N'', N'2020-12-01 10:16:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-01 15:52:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'64c10822-0c85-4516-9b59-879b818547ae', N'77070117-3F1A-41BA-BF81-B8B85BF10D5E', N'MessageType', N'信息类型', N'0', N'2', N'16', N'0', N'1', N'', N'2020-07-29 16:51:19.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'77070117-3F1A-41BA-BF81-B8B85BF10D5E', N'0', N'Sys_Items', N'通用字典', N'1', N'1', N'1', N'0', N'1', NULL, NULL, NULL, N'2020-04-20 17:17:39.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'7e0b19a6-89f5-4802-bf76-0a692a518473', N'0', N'Mob_Items', N'移动端', N'0', N'1', N'3', N'0', N'1', N'', N'2020-11-21 10:02:12.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'8742966f-322c-4ed8-b737-ffee53d85a5d', N'879dc37f-8b6e-44d5-a153-ce4bdc3e66e1', N'Mes_AreaType', N'库区类型', N'0', N'2', N'10', N'0', N'1', N'', N'2020-12-17 09:37:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'879dc37f-8b6e-44d5-a153-ce4bdc3e66e1', N'0', N'Mes_Items', N'Mes字典', N'0', N'1', N'2', N'0', N'1', N'', N'2020-11-18 10:32:40.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'885d3b97-ae33-4cb6-b7b0-e1a7e72f6de2', N'7e0b19a6-89f5-4802-bf76-0a692a518473', N'Mob_DingType', N'钉钉应用类型', N'0', N'2', N'0', N'0', N'1', N'', N'2020-11-21 10:02:34.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-11-21 10:31:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'8CEB2F71-026C-4FA6-9A61-378127AE7320', N'77070117-3F1A-41BA-BF81-B8B85BF10D5E', N'102', N'生育', N'0', N'2', N'13', N'0', N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'954AB9A1-9928-4C6D-820A-FC1CDC85CDE0', N'77070117-3F1A-41BA-BF81-B8B85BF10D5E', N'AuditState', N'审核状态', N'0', N'2', N'6', N'0', N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'9a7079bd-0660-4549-9c2d-db5e8616619f', N'77070117-3F1A-41BA-BF81-B8B85BF10D5E', N'DbLogType', N'系统日志', N'0', N'2', N'16', N'0', N'1', NULL, N'2016-07-19 17:09:45.0000000', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'9EB4602B-BF9A-4710-9D80-C73CE89BEC5D', N'77070117-3F1A-41BA-BF81-B8B85BF10D5E', N'OrganizeCategory', N'机构分类', N'0', N'2', N'2', N'0', N'1', NULL, NULL, NULL, N'2020-04-28 09:07:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'a7faf382-c88c-43e1-aff3-98f261a693ea', N'879dc37f-8b6e-44d5-a153-ce4bdc3e66e1', N'Mes_TransferType', N'流转箱类型', N'0', N'2', N'8', N'0', N'1', N'', N'2020-12-14 12:39:09.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'BDD797C3-2323-4868-9A63-C8CC3437AEAA', N'77070117-3F1A-41BA-BF81-B8B85BF10D5E', N'104', N'性别', N'0', N'2', N'15', N'0', N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'bf06d1e0-cfde-40c9-954c-df930e26e319', N'879dc37f-8b6e-44d5-a153-ce4bdc3e66e1', N'Mes_EqpUse', N'设备用途', N'0', N'2', N'3', N'0', N'1', N'', N'2020-11-30 15:03:02.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-01 15:51:53.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'c2a3ec97-e4f0-46a5-addf-1ba4e40e2ab9', N'879dc37f-8b6e-44d5-a153-ce4bdc3e66e1', N'Mes_WorkOrderState', N'工单状态', N'0', N'2', N'7', N'0', N'1', N'', N'2020-12-07 13:39:42.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'cd6a17c3-34ca-44d3-a072-4f75a94f5960', N'879dc37f-8b6e-44d5-a153-ce4bdc3e66e1', N'Mes_EqpOwner', N'财产所属', N'0', N'2', N'4', N'0', N'1', N'', N'2020-12-01 09:37:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-01 15:51:58.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'd56acc3d-39f2-41a0-a900-a6866139d348', N'879dc37f-8b6e-44d5-a153-ce4bdc3e66e1', N'Mes_MaintainType', N'保养周期类型', N'0', N'2', N'2', N'0', N'1', N'', N'2020-11-30 14:50:40.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-01 15:51:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'D94E4DC1-C2FD-4D19-9D5D-3886D39900CE', N'77070117-3F1A-41BA-BF81-B8B85BF10D5E', N'RoleType', N'角色类型', N'0', N'2', N'3', N'0', N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'e3c2ee7c-14e8-42c9-bb0d-29fc4c42ec37', N'879dc37f-8b6e-44d5-a153-ce4bdc3e66e1', N'Mes_TransferState', N'流转箱状态', N'0', N'2', N'11', N'0', N'1', N'', N'2021-01-06 13:11:30.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'f948d392-2b2c-4c07-9143-13635e955ed6', N'879dc37f-8b6e-44d5-a153-ce4bdc3e66e1', N'Mes_MaterialType', N'物料分类', N'0', N'2', N'6', N'0', N'1', N'', N'2020-12-01 15:52:30.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'FA7537E2-1C64-4431-84BF-66158DD63269', N'77070117-3F1A-41BA-BF81-B8B85BF10D5E', N'101', N'婚姻', N'0', N'2', N'12', N'0', N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'faff6e57-5a15-4ba7-a971-d5453e3040c2', N'879dc37f-8b6e-44d5-a153-ce4bdc3e66e1', N'Mes_CheckType', N'检验类型', N'0', N'2', N'13', N'0', N'1', N'', N'2021-05-21 15:05:40.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_Items] ([F_Id], [F_ParentId], [F_EnCode], [F_FullName], [F_IsTree], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES ('08dab7e1-2118-47e0-8604-dbf1803eec08', '879dc37f-8b6e-44d5-a153-ce4bdc3e66e1', 'Mes_ClassNumber', '班别', 0, 2, 17, 0, 1, '', '2022-10-27 14:04:38', '9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL)
GO

-- ----------------------------
-- Table structure for sys_ItemsDetail
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_ItemsDetail]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_ItemsDetail]
GO

CREATE TABLE [dbo].[sys_ItemsDetail] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_ItemId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ParentId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ItemCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ItemName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_SimpleSpelling] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsDefault] tinyint  NULL,
  [F_Layers] int  NULL,
  [F_SortCode] int  NULL,
  [F_DeleteMark] tinyint  NULL,
  [F_EnabledMark] tinyint  NULL,
  [F_Description] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[sys_ItemsDetail] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of sys_ItemsDetail
-- ----------------------------
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'0096ad81-4317-486e-9144-a6a02999ff19', N'2748F35F-4EE2-417C-A907-3453146AAF67', NULL, N'4', N'护照', NULL, 0, NULL, 4, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'018e7873-e7dd-4163-a9f2-e99eadcc44fb', N'bf06d1e0-cfde-40c9-954c-df930e26e319', NULL, N'6', N'激光切割', NULL, 0, NULL, 6, 0, 1, N'固定', '2020-11-30 15:04:57.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2022-10-09 20:17:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'04aba88d-f09b-46c6-bd90-a38471399b0e', N'D94E4DC1-C2FD-4D19-9D5D-3886D39900CE', NULL, N'2', N'业务角色', NULL, 0, NULL, 2, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'07d28cf3-eb8d-479e-b7b0-b353ca2dbd72', N'bf06d1e0-cfde-40c9-954c-df930e26e319', NULL, N'0', N'3D扫描站', NULL, 0, NULL, 0, 0, 1, N'固定', '2020-11-30 15:03:51.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2022-10-09 20:16:39.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'0883b606-2b0b-493f-9b9a-6e94fefc7d99', N'c2a3ec97-e4f0-46a5-addf-1ba4e40e2ab9', NULL, N'3', N'已终止', NULL, 0, NULL, 3, 0, 1, N'', '2021-01-04 13:38:19.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'08d9344e-5290-4470-8b94-367ced6d6c84', N'08d9344e-25dc-40ab-8eeb-473d9321c7e2', NULL, N'0', N'质检异常停机', NULL, 0, NULL, 0, 0, 0, N'', '2021-06-21 08:48:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2021-07-14 18:28:31.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'08d93f50-1eb2-44a8-8b01-58293dad9a3c', N'08d93f50-133e-4fe7-860d-4dd9cd33cfe5', NULL, N'0', N'可疑', NULL, 0, NULL, 0, 0, 1, N'', '2021-07-05 08:59:19.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'08d93f50-2a0b-4ee0-85ed-991d2f83205c', N'08d93f50-133e-4fe7-860d-4dd9cd33cfe5', NULL, N'1', N'报废', NULL, 0, NULL, 1, 0, 1, N'', '2021-07-05 08:59:39.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'08d93f50-3018-40c7-8c57-23039cd57610', N'08d93f50-133e-4fe7-860d-4dd9cd33cfe5', NULL, N'2', N'正常', NULL, 0, NULL, 2, 0, 1, N'', '2021-07-05 08:59:49.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2021-07-05 09:00:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'08d941ac-6c83-449a-80ec-f7cce40335fe', N'bf06d1e0-cfde-40c9-954c-df930e26e319', NULL, N'18', N'夹具', NULL, 0, NULL, 18, 0, 1, N'流动', '2021-07-08 09:05:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2022-10-09 20:16:02.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'08d946b2-3901-4172-8337-67f5936e04ee', N'08d9344e-25dc-40ab-8eeb-473d9321c7e2', NULL, N'1', N'是否开立工单', NULL, 0, NULL, 1, 0, 1, N'', '2021-07-14 18:29:12.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'08d946b3-3244-45a0-81df-5ee294a46666', N'08d9344e-25dc-40ab-8eeb-473d9321c7e2', NULL, N'2', N'是否及时领料和产出', NULL, 0, NULL, 2, 0, 0, N'', '2021-07-14 18:36:11.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2021-08-18 14:07:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'08dab327-d32e-48bd-87b3-61e547d314f1', N'08dab327-a5c5-4ce4-8567-a45c414ab232', NULL, N'1', N'共享型设备', NULL, 0, NULL, 1, 0, 1, N'8,18', '2022-10-21 13:48:05.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2022-10-21 13:48:18.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'08dab327-fa33-4f53-8fec-07fd7799c94b', N'08dab327-a5c5-4ce4-8567-a45c414ab232', NULL, N'2', N'模具型设备', NULL, 0, NULL, 2, 0, 1, N'7', '2022-10-21 13:49:11.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'0a2ba6b9-716f-410f-8e89-929ec2277333', N'64c10822-0c85-4516-9b59-879b818547ae', NULL, N'1', N'私信', NULL, 0, NULL, 1, 0, 1, N'', '2020-07-29 16:51:59.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'0bfc45f0-009f-4fa7-8883-d2dd8700629c', N'faff6e57-5a15-4ba7-a971-d5453e3040c2', NULL, N'1', N'领用检验', NULL, 0, NULL, 1, 0, 1, N'', '2021-05-21 15:06:14.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'0c9d7265-6b7d-4830-a3e4-bf7a89646697', N'8742966f-322c-4ed8-b737-ffee53d85a5d', NULL, N'0', N'物料库区', NULL, 0, NULL, 0, 0, 1, N'', '2020-12-17 09:40:58.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2020-12-17 09:41:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'0fb9b7d9-97c1-4702-b29c-845a692e61da', N'2e440789-bd9b-46a5-9a64-190163f8a9cf', NULL, N'1', N'运行', NULL, 0, NULL, 1, 0, 1, N'', '2020-11-30 14:45:29.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2020-11-30 14:46:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'1950efdf-8685-4341-8d2c-ac85ac7addd0', N'00F76465-DBBA-484A-B75C-E81DEE9313E6', NULL, N'1', N'小学', NULL, 0, NULL, 1, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'19EE595A-E775-409D-A48F-B33CF9F262C7', N'9EB4602B-BF9A-4710-9D80-C73CE89BEC5D', NULL, N'WorkGroup', N'小组', NULL, 0, NULL, 7, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'1a18d92e-f55f-47e7-a28d-2bb3c32aca2c', N'bf06d1e0-cfde-40c9-954c-df930e26e319', NULL, N'3', N'攻牙', NULL, 0, NULL, 3, 0, 1, N'固定', '2020-11-30 15:04:18.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2022-10-09 20:16:53.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'1bc8abe3-abb4-41df-97fc-3f60299a5889', N'002eeaa9-c804-4c98-afd9-7ddc7c1e4c46', NULL, N'3', N'产出上架', NULL, 0, NULL, 3, 0, 1, N'', '2021-01-20 09:37:05.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'2146dbe0-6e99-42de-b717-66c84eef42e9', N'f948d392-2b2c-4c07-9143-13635e955ed6', NULL, N'2', N'成品', NULL, 0, NULL, 2, 0, 1, N'', '2020-12-01 16:09:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2021-01-22 09:35:07.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'24e39617-f04e-4f6f-9209-ad71e870e7c6', N'9a7079bd-0660-4549-9c2d-db5e8616619f', NULL, N'Submit', N'提交', NULL, 0, NULL, 7, 0, 1, NULL, '2016-07-19 17:11:19.0000000', NULL, '2016-07-19 18:20:54.0000000', NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'2533c1a9-3902-403e-81ee-9b82c5c2e68f', N'3d2fc3d0-ef1c-41c2-9ca0-cf027dc7a854', NULL, N'1', N'流动', NULL, 0, NULL, 1, 0, 1, N'', '2020-11-30 14:35:32.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'27e85cb8-04e7-447b-911d-dd1e97dfab83', N'0DF5B725-5FB8-487F-B0E4-BC563A77EB04', NULL, N'Oracle', N'Oracle', NULL, 0, NULL, 2, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'27f4ae04-8c5b-4318-b259-2cf59c1bc72a', N'cd6a17c3-34ca-44d3-a072-4f75a94f5960', NULL, N'1', N'客户', NULL, 0, NULL, 1, 0, 1, N'', '2020-12-01 09:37:43.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'28e1b5be-7532-4fa8-b382-e270d8e4b464', N'c2a3ec97-e4f0-46a5-addf-1ba4e40e2ab9', NULL, N'2', N'已完成', NULL, 0, NULL, 2, 0, 1, N'', '2020-12-07 13:43:30.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'2B540AC5-6E64-4688-BB60-E0C01DFA982C', N'9EB4602B-BF9A-4710-9D80-C73CE89BEC5D', NULL, N'SubCompany', N'子公司', NULL, 0, NULL, 4, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'2bde0211-abd8-4186-9986-9258028a973d', N'5da129a3-45ce-43cf-a483-e7f9ad90297d', NULL, N'1', N'冷冲型', NULL, 0, NULL, 1, 0, 1, N'', '2020-12-01 10:16:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'2C3715AC-16F7-48FC-AB40-B0931DB1E729', N'9EB4602B-BF9A-4710-9D80-C73CE89BEC5D', NULL, N'Area', N'区域', NULL, 0, NULL, 2, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'34222d46-e0c6-446e-8150-dbefc47a1d5f', N'00F76465-DBBA-484A-B75C-E81DEE9313E6', NULL, N'6', N'本科', NULL, 0, NULL, 6, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'342baf8f-2cc4-4cca-a709-7b11b8dca510', N'3d2fc3d0-ef1c-41c2-9ca0-cf027dc7a854', NULL, N'0', N'固定', NULL, 0, NULL, 0, 0, 1, N'', '2020-11-30 14:35:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'34a642b2-44d4-485f-b3fc-6cce24f68b0f', N'0DF5B725-5FB8-487F-B0E4-BC563A77EB04', NULL, N'MySql', N'MySql', NULL, 0, NULL, 3, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'355ad7a4-c4f8-4bd3-9c72-ff07983da0f0', N'00F76465-DBBA-484A-B75C-E81DEE9313E6', NULL, N'9', N'其他', NULL, 0, NULL, 9, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'376dfe19-9de6-45e8-ba5b-39ecff7e9794', N'bf06d1e0-cfde-40c9-954c-df930e26e319', NULL, N'11', N'抛丸', NULL, 0, NULL, 11, 0, 1, N'固定', '2020-11-30 15:06:05.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2022-10-09 20:17:21.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'392f88a8-02c2-49eb-8aed-b2acf474272a', N'9a7079bd-0660-4549-9c2d-db5e8616619f', NULL, N'Update', N'修改', NULL, 0, NULL, 6, 0, 1, NULL, '2016-07-19 17:11:14.0000000', NULL, '2016-07-19 18:20:49.0000000', NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'3c884a03-4f34-4150-b134-966387f1de2a', N'9a7079bd-0660-4549-9c2d-db5e8616619f', NULL, N'Exit', N'退出', NULL, 0, NULL, 2, 0, 1, NULL, '2016-07-19 17:10:49.0000000', NULL, '2016-07-19 18:20:23.0000000', NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'3f280e2b-92f6-466c-8cc3-d7c8ff48cc8d', N'00F76465-DBBA-484A-B75C-E81DEE9313E6', NULL, N'7', N'硕士', NULL, 0, NULL, 7, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'41053517-215d-4e11-81cd-367c0e9578d7', N'954AB9A1-9928-4C6D-820A-FC1CDC85CDE0', NULL, N'3', N'通过', NULL, 0, NULL, 3, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'433511a9-78bd-41a0-ab25-e4d4b3423055', N'00F76465-DBBA-484A-B75C-E81DEE9313E6', NULL, N'2', N'初中', NULL, 0, NULL, 2, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'442a9185-439b-4c7a-943c-773ea57015e1', N'002eeaa9-c804-4c98-afd9-7ddc7c1e4c46', NULL, N'6', N'工单结束', NULL, 0, NULL, 6, 0, 1, N'', '2021-01-20 09:37:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'45000772-a0a7-4789-9cd1-793b5646d09e', N'c2a3ec97-e4f0-46a5-addf-1ba4e40e2ab9', NULL, N'0', N'等待中', NULL, 0, NULL, 0, 0, 1, N'', '2020-12-07 13:43:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'477ea5b7-24d2-43e2-8e87-8e068a911d80', N'002eeaa9-c804-4c98-afd9-7ddc7c1e4c46', NULL, N'11', N'出库装箱', NULL, 0, NULL, 11, 0, 1, N'', '2021-05-24 15:11:44.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'486a82e3-1950-425e-b2ce-b5d98f33016a', N'00F76465-DBBA-484A-B75C-E81DEE9313E6', NULL, N'5', N'大专', NULL, 0, NULL, 5, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'48a01591-f00c-4a5e-a105-bc32858304b7', N'faff6e57-5a15-4ba7-a971-d5453e3040c2', NULL, N'4', N'出库检验', NULL, 0, NULL, 4, 0, 1, N'', '2021-05-21 15:06:47.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'48c4e0f5-f570-4601-8946-6078762db3bf', N'2748F35F-4EE2-417C-A907-3453146AAF67', NULL, N'3', N'军官证', NULL, 0, NULL, 3, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'49300258-1227-4b85-b6a2-e948dbbe57a4', N'15023A4E-4856-44EB-BE71-36A106E2AA59', NULL, N'汉族', N'汉族', NULL, 0, NULL, 1, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'49b68663-ad01-4c43-b084-f98e3e23fee8', N'954AB9A1-9928-4C6D-820A-FC1CDC85CDE0', NULL, N'7', N'废弃', NULL, 0, NULL, 7, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'4c2f2428-2e00-4336-b9ce-5a61f24193f6', N'2748F35F-4EE2-417C-A907-3453146AAF67', NULL, N'2', N'士兵证', NULL, 0, NULL, 2, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'4d205f1f-9414-4beb-a9cf-4750cfee3e9e', N'bf06d1e0-cfde-40c9-954c-df930e26e319', NULL, N'12', N'激光落料', NULL, 0, NULL, 12, 0, 1, N'固定', '2020-11-30 15:06:18.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2022-10-09 20:17:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'4f7fd03e-af20-418a-9d68-25f0d756dca6', N'3d2fc3d0-ef1c-41c2-9ca0-cf027dc7a854', NULL, N'2', N'其他', NULL, 0, NULL, 2, 0, 1, N'', '2020-11-30 14:35:39.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'53fafeba-99af-4eb6-95e6-0481c8395556', N'bf06d1e0-cfde-40c9-954c-df930e26e319', NULL, N'8', N'端拾器', NULL, 0, NULL, 8, 0, 1, N'流动', '2020-11-30 15:05:18.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2022-10-09 20:15:42.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'54128d90-1cd0-4bce-a1dc-47e58ecc58c1', N'bf06d1e0-cfde-40c9-954c-df930e26e319', NULL, N'17', N'行架', NULL, 0, NULL, 17, 0, 1, N'固定', '2021-03-08 09:46:33.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2022-10-09 20:17:33.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'57eec4b3-6f50-4186-b82d-2d62ee306d0f', N'885d3b97-ae33-4cb6-b7b0-e1a7e72f6de2', NULL, N'2', N'H5', NULL, 0, NULL, 2, 0, 1, N'', '2020-11-23 09:01:49.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2020-11-23 09:04:16.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'582e0b66-2ee9-4885-9f0c-3ce3ebf96e12', N'8CEB2F71-026C-4FA6-9A61-378127AE7320', NULL, N'1', N'已育', NULL, 0, NULL, 1, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'5ba53647-a0d2-4e6b-8bce-fee2e589d872', N'002eeaa9-c804-4c98-afd9-7ddc7c1e4c46', NULL, N'4', N'物料变动', NULL, 0, NULL, 4, 0, 1, N'', '2021-01-20 09:37:24.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'5d6def0e-e2a7-48eb-b43c-cc3631f60dd7', N'BDD797C3-2323-4868-9A63-C8CC3437AEAA', NULL, N'1', N'男', NULL, 0, NULL, 1, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'616fc56d-bc05-43bf-942c-c23299255ac6', N'2e440789-bd9b-46a5-9a64-190163f8a9cf', NULL, N'3', N'维修', NULL, 0, NULL, 3, 0, 1, N'', '2020-11-30 14:45:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'62e0afc3-e194-4f75-ad75-434f30acf387', N'8742966f-322c-4ed8-b737-ffee53d85a5d', NULL, N'2', N'产品库区', NULL, 0, NULL, 2, 0, 1, N'', '2020-12-17 09:41:32.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2020-12-17 09:41:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'63acf96d-6115-4d76-a994-438f59419aad', N'954AB9A1-9928-4C6D-820A-FC1CDC85CDE0', NULL, N'5', N'退回', NULL, 0, NULL, 5, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'643209c8-931b-4641-9e04-b8bdd11800af', N'9a7079bd-0660-4549-9c2d-db5e8616619f', NULL, N'Login', N'登录', NULL, 0, NULL, 1, 0, 1, NULL, '2016-07-19 17:10:39.0000000', NULL, '2016-07-19 18:20:17.0000000', NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'65b7a5a2-ada2-4c8f-9b2e-bee2f0b5d8e7', N'002eeaa9-c804-4c98-afd9-7ddc7c1e4c46', NULL, N'2', N'产品出库', NULL, 0, NULL, 2, 0, 1, N'', '2021-01-20 09:36:57.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'6623a0f8-09a3-458c-82e7-e41710fb19bb', N'f948d392-2b2c-4c07-9143-13635e955ed6', NULL, N'0', N'原料', NULL, 0, NULL, 0, 0, 1, N'', '2020-12-01 16:10:02.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2021-01-22 09:35:14.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'6b29542c-cb70-4d6b-9769-16f4fde65038', N'd56acc3d-39f2-41a0-a900-a6866139d348', NULL, N'0', N'次数', NULL, 0, NULL, 0, 0, 1, N'', '2020-11-30 14:51:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2020-11-30 14:55:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'711ccaab-a8b1-46b4-89bc-474042e2acd1', N'5da129a3-45ce-43cf-a483-e7f9ad90297d', NULL, N'0', N'热成型', NULL, 0, NULL, 0, 0, 1, N'', '2020-12-01 10:16:28.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'7306bc04-3e76-4925-92e3-d2b8638ec42c', N'bf06d1e0-cfde-40c9-954c-df930e26e319', NULL, N'15', N'焊机', NULL, 0, NULL, 15, 0, 1, N'固定', '2021-03-08 09:29:59.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2022-10-09 20:17:29.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'738edf2a-d59f-4992-97ef-d847db23bcb8', N'FA7537E2-1C64-4431-84BF-66158DD63269', NULL, N'1', N'已婚', NULL, 0, NULL, 1, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'795f2695-497a-4f5e-ab1d-706095c1edb9', N'9a7079bd-0660-4549-9c2d-db5e8616619f', NULL, N'Other', N'其他', NULL, 0, NULL, 0, 0, 1, NULL, '2016-07-19 17:10:33.0000000', NULL, '2016-07-19 18:20:09.0000000', NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'7a6d1bc4-3ec7-4c57-be9b-b4c97d60d5f6', N'954AB9A1-9928-4C6D-820A-FC1CDC85CDE0', NULL, N'1', N'草稿', NULL, 0, NULL, 1, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'7c1135be-0148-43eb-ae49-62a1e16ebbe3', N'FA7537E2-1C64-4431-84BF-66158DD63269', NULL, N'5', N'其他', NULL, 0, NULL, 5, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'7d18b3d6-738b-4b63-8163-b14a5750a6d0', N'2e440789-bd9b-46a5-9a64-190163f8a9cf', NULL, N'4', N'异常', NULL, 0, NULL, 4, 0, 1, N'', '2020-11-30 14:45:56.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'7d2d71e9-71f8-489c-b37e-8c684268af4b', N'bf06d1e0-cfde-40c9-954c-df930e26e319', NULL, N'13', N'其他', NULL, 0, NULL, 13, 0, 1, N'其他', '2020-11-30 15:06:33.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2022-10-09 20:16:16.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'7fc8fa11-4acf-409a-a771-aaf1eb81e814', N'9a7079bd-0660-4549-9c2d-db5e8616619f', NULL, N'Exception', N'异常', NULL, 0, NULL, 8, 0, 1, NULL, '2016-07-19 17:11:25.0000000', NULL, '2016-07-19 18:21:01.0000000', NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'80aa1d96-8b52-43f3-bb1a-ad4733ac8dec', N'a7faf382-c88c-43e1-aff3-98f261a693ea', NULL, N'0', N'通用', NULL, 0, NULL, 0, 0, 1, N'', '2020-12-14 12:39:33.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'822baf7c-abdb-4257-9b78-1f550806f544', N'BDD797C3-2323-4868-9A63-C8CC3437AEAA', NULL, N'0', N'女', NULL, 0, NULL, 2, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'835cb824-c29e-4275-a1bc-1624b32fa8de', N'002eeaa9-c804-4c98-afd9-7ddc7c1e4c46', NULL, N'5', N'工单作业', NULL, 0, NULL, 5, 0, 1, N'', '2021-01-20 09:37:34.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'84738997-117e-4e0a-9460-abd65df7c6a0', N'bf06d1e0-cfde-40c9-954c-df930e26e319', NULL, N'10', N'冲压', NULL, 0, NULL, 10, 0, 1, N'固定', '2020-11-30 15:05:47.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2022-10-09 20:17:17.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'85cf359c-80be-4bd7-9a0c-876b3048c19a', N'cd6a17c3-34ca-44d3-a072-4f75a94f5960', NULL, N'0', N'公司', NULL, 0, NULL, 0, 0, 1, N'', '2020-12-01 09:37:34.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'8892186f-22ff-40c4-9907-e80721f9c5fe', N'64c10822-0c85-4516-9b59-879b818547ae', NULL, N'2', N'待办', NULL, 0, NULL, 2, 0, 1, N'', '2020-07-29 16:52:21.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2020-07-31 17:33:40.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'8b7b38bf-07c5-4f71-a853-41c5add4a94e', N'954AB9A1-9928-4C6D-820A-FC1CDC85CDE0', NULL, N'6', N'完成', NULL, 0, NULL, 6, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'8bc2effa-5f12-4b27-bdb9-2e90152d7735', N'c2a3ec97-e4f0-46a5-addf-1ba4e40e2ab9', NULL, N'1', N'执行中', NULL, 0, NULL, 1, 0, 1, N'', '2020-12-07 13:43:19.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'8d6ec317-0cb9-4db3-a6b2-97b1bbfa6b5a', N'8742966f-322c-4ed8-b737-ffee53d85a5d', NULL, N'3', N'空置库区', NULL, 0, NULL, 3, 0, 1, N'', '2020-12-17 09:41:47.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'929c380a-d11d-4983-8c9c-ca326a3b6331', N'002eeaa9-c804-4c98-afd9-7ddc7c1e4c46', NULL, N'1', N'来料入库', NULL, 0, NULL, 1, 0, 1, N'', '2021-01-20 09:36:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2021-05-24 15:11:53.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'930b8de2-049f-4753-b9fd-87f484911ee4', N'00F76465-DBBA-484A-B75C-E81DEE9313E6', NULL, N'8', N'博士', NULL, 0, NULL, 8, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'9638f236-260b-41fd-bb57-3ff897de2c57', N'faff6e57-5a15-4ba7-a971-d5453e3040c2', NULL, N'2', N'产出检验', NULL, 0, NULL, 2, 0, 1, N'', '2021-05-21 15:06:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'9b6a2225-6138-4cf2-9845-1bbecdf9b3ed', N'8CEB2F71-026C-4FA6-9A61-378127AE7320', NULL, N'3', N'其他', NULL, 0, NULL, 3, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'a13ccf0d-ac8f-44ac-a522-4a54edf1f0fa', N'9a7079bd-0660-4549-9c2d-db5e8616619f', NULL, N'Delete', N'删除', NULL, 0, NULL, 5, 0, 1, NULL, '2016-07-19 17:11:09.0000000', NULL, '2016-07-19 18:20:43.0000000', NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'a4974810-d88d-4d54-82cc-fd779875478f', N'00F76465-DBBA-484A-B75C-E81DEE9313E6', NULL, N'4', N'中专', NULL, 0, NULL, 4, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'A64EBB80-6A24-48AF-A10E-B6A532C32CA6', N'9EB4602B-BF9A-4710-9D80-C73CE89BEC5D', NULL, N'Department', N'部门', NULL, 0, NULL, 5, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'a6f271f9-8653-4c5c-86cf-4cd00324b3c3', N'FA7537E2-1C64-4431-84BF-66158DD63269', NULL, N'4', N'丧偶', NULL, 0, NULL, 4, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'a7258605-6d35-4240-bb7e-b3a77252b0d3', N'bf06d1e0-cfde-40c9-954c-df930e26e319', NULL, N'7', N'模具', NULL, 0, NULL, 7, 0, 1, N'流动', '2020-11-30 15:05:07.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2022-10-09 20:15:34.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'a7c4aba2-a891-4558-9b0a-bd7a1100a645', N'FA7537E2-1C64-4431-84BF-66158DD63269', NULL, N'2', N'未婚', NULL, 0, NULL, 2, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'acb128a6-ff63-4e25-b1e8-0a336ed3ab18', N'00F76465-DBBA-484A-B75C-E81DEE9313E6', NULL, N'3', N'高中', NULL, 0, NULL, 3, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'accdd4db-f825-4940-abdb-8f485e4d5927', N'e3c2ee7c-14e8-42c9-bb0d-29fc4c42ec37', NULL, N'1', N'绑定', NULL, 0, NULL, 1, 0, 1, N'', '2021-01-06 13:12:24.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2021-01-06 13:13:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'ace2d5e8-56d4-4c8b-8409-34bc272df404', N'2748F35F-4EE2-417C-A907-3453146AAF67', NULL, N'5', N'其它', NULL, 0, NULL, 5, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'ad0700cb-1fef-4fd0-a500-d78924b0e91f', N'bf06d1e0-cfde-40c9-954c-df930e26e319', NULL, N'9', N'加热炉', NULL, 0, NULL, 9, 0, 1, N'固定', '2020-11-30 15:05:28.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2022-10-09 20:17:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'aec54116-8583-46e9-96ea-af9aca5827d0', N'885d3b97-ae33-4cb6-b7b0-e1a7e72f6de2', NULL, N'1', N'三方Web', NULL, 0, NULL, 1, 0, 1, N'', '2020-11-21 10:03:34.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2020-11-23 09:04:09.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'b63f7a2a-7f23-408a-8781-56b34475b0d1', N'faff6e57-5a15-4ba7-a971-d5453e3040c2', NULL, N'0', N'入库检验', NULL, 0, NULL, 0, 0, 1, N'', '2021-05-21 15:06:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'B97BD7F5-B212-40C1-A1F7-DD9A2E63EEF2', N'9EB4602B-BF9A-4710-9D80-C73CE89BEC5D', NULL, N'Group', N'集团', NULL, 0, NULL, 1, 0, 1, N'', NULL, NULL, '2020-06-29 17:35:07.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'ba1d27db-cf19-4cc0-9b18-0745e98f8088', N'64c10822-0c85-4516-9b59-879b818547ae', NULL, N'0', N'通知', NULL, 0, NULL, 0, 0, 1, N'', '2020-07-29 16:51:50.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'bcaa8409-3597-4360-9d7f-11f0a6ad5488', N'002eeaa9-c804-4c98-afd9-7ddc7c1e4c46', NULL, N'9', N'二次质检', NULL, 0, NULL, 9, 0, 1, N'', '2021-05-24 12:03:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'c092c994-b763-4068-a425-0a4896a00999', N'002eeaa9-c804-4c98-afd9-7ddc7c1e4c46', NULL, N'0', N'设备领料', NULL, 0, NULL, 0, 0, 1, N'', '2021-01-20 09:36:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'c5ce1bd9-6971-4d76-8642-6ec7a5202c75', N'f948d392-2b2c-4c07-9143-13635e955ed6', NULL, N'1', N'半成品', NULL, 0, NULL, 1, 0, 1, N'', '2020-12-01 16:09:54.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'ca2fb710-57e0-4401-89ce-474f4fb0994d', N'bf06d1e0-cfde-40c9-954c-df930e26e319', NULL, N'4', N'镟铆', NULL, 0, NULL, 4, 0, 1, N'固定', '2020-11-30 15:04:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2022-10-09 20:16:58.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'cc6daa5c-a71c-4b2c-9a98-336bc3ee13c8', N'D94E4DC1-C2FD-4D19-9D5D-3886D39900CE', NULL, N'3', N'其他角色', NULL, 0, NULL, 3, 0, 1, N'', NULL, NULL, '2020-06-18 10:15:51.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'ccc8e274-75da-4eb8-bed0-69008ab7c41c', N'9a7079bd-0660-4549-9c2d-db5e8616619f', NULL, N'Visit', N'访问', NULL, 0, NULL, 3, 0, 1, NULL, '2016-07-19 17:10:55.0000000', NULL, '2016-07-19 18:20:29.0000000', NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'ccf113a8-4374-44be-aec0-2eddda1161dc', N'e3c2ee7c-14e8-42c9-bb0d-29fc4c42ec37', NULL, N'3', N'使用', NULL, 0, NULL, 3, 0, 1, N'', '2021-01-06 13:12:42.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'ce340c73-5048-4940-b86e-e3b3d53fdb2c', N'954AB9A1-9928-4C6D-820A-FC1CDC85CDE0', NULL, N'2', N'提交', NULL, 0, NULL, 2, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'cf05666d-07a6-4dbd-bafb-0c931874fe2a', N'002eeaa9-c804-4c98-afd9-7ddc7c1e4c46', NULL, N'8', N'常规质检', NULL, 0, NULL, 8, 0, 1, N'', '2021-05-24 12:03:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'd03c7953-f9af-4b26-8795-58f6d249e752', N'002eeaa9-c804-4c98-afd9-7ddc7c1e4c46', NULL, N'10', N'入库上架', NULL, 0, NULL, 10, 0, 1, N'', '2021-05-24 15:11:35.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'D082BDB9-5C34-49BF-BD51-4E85D7BFF646', N'9EB4602B-BF9A-4710-9D80-C73CE89BEC5D', NULL, N'Company', N'公司', NULL, 0, NULL, 3, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'd14e661c-c921-4df8-a247-cadde6adc1bf', N'8742966f-322c-4ed8-b737-ffee53d85a5d', NULL, N'1', N'半成品库区', NULL, 0, NULL, 1, 0, 1, N'', '2020-12-17 09:41:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'D1F439B9-D80E-4547-9EF0-163391854AB5', N'9EB4602B-BF9A-4710-9D80-C73CE89BEC5D', NULL, N'SubDepartment', N'子部门', NULL, 0, NULL, 6, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'd5e847ce-44d8-4e35-845d-d81ed0498cbf', N'bf06d1e0-cfde-40c9-954c-df930e26e319', NULL, N'5', N'机械人', NULL, 0, NULL, 5, 0, 1, N'固定', '2020-11-30 15:04:36.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2022-10-09 20:17:02.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'd69cb819-2bb3-4e1d-9917-33b9a439233d', N'2748F35F-4EE2-417C-A907-3453146AAF67', NULL, N'1', N'身份证', NULL, 0, NULL, 1, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'de2167f3-40fe-4bf7-b8cb-5b1c554bad7a', N'8CEB2F71-026C-4FA6-9A61-378127AE7320', NULL, N'2', N'未育', NULL, 0, NULL, 2, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'e1979a4f-7fc1-42b9-a0e2-52d7059e8fb9', N'954AB9A1-9928-4C6D-820A-FC1CDC85CDE0', NULL, N'4', N'待审', NULL, 0, NULL, 4, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'e2be96dd-e124-490d-8aa6-bcec4909651d', N'bf06d1e0-cfde-40c9-954c-df930e26e319', NULL, N'1', N'液压机', NULL, 0, NULL, 1, 0, 1, N'固定', '2020-11-30 15:04:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2022-10-09 20:16:44.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'e5079bae-a8c0-4209-9019-6a2b4a3a7dac', N'D94E4DC1-C2FD-4D19-9D5D-3886D39900CE', NULL, N'1', N'系统角色', NULL, 0, NULL, 1, 0, 1, N'', NULL, NULL, '2020-06-24 09:08:22.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'e545061c-93fd-4ca2-ab29-b43db9db798b', N'9a7079bd-0660-4549-9c2d-db5e8616619f', NULL, N'Create', N'新增', NULL, 0, NULL, 4, 0, 1, NULL, '2016-07-19 17:11:03.0000000', NULL, '2016-07-19 18:20:35.0000000', NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'eba0de8f-ff66-4415-827d-336da3ea39f1', N'885d3b97-ae33-4cb6-b7b0-e1a7e72f6de2', NULL, N'0', N'小程序', NULL, 0, NULL, 0, 0, 1, N'', '2020-11-21 10:03:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'ed56c545-56f6-48e2-bfef-6a90ab8b1420', N'd56acc3d-39f2-41a0-a900-a6866139d348', NULL, N'1', N'时间(天)', NULL, 0, NULL, 1, 0, 1, N'', '2020-11-30 14:51:18.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'f08a9823-e331-4837-a28d-f766668592b0', N'e3c2ee7c-14e8-42c9-bb0d-29fc4c42ec37', NULL, N'2', N'在库', NULL, 0, NULL, 2, 0, 1, N'', '2021-01-06 13:12:35.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'f29973bf-eb91-414e-959f-52e8251e1b87', N'e3c2ee7c-14e8-42c9-bb0d-29fc4c42ec37', NULL, N'0', N'空闲', NULL, 0, NULL, 0, 0, 1, N'', '2021-01-06 13:11:58.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'f9609400-7caf-49af-ae3c-7671a9292fb3', N'FA7537E2-1C64-4431-84BF-66158DD63269', NULL, N'3', N'离异', NULL, 0, NULL, 3, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'fa6c1873-888c-4b70-a2cc-59fccbb22078', N'0DF5B725-5FB8-487F-B0E4-BC563A77EB04', NULL, N'SqlServer', N'SqlServer', NULL, 0, NULL, 1, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'faaac4dc-9413-4971-8f1b-348397c1a7b7', N'2e440789-bd9b-46a5-9a64-190163f8a9cf', NULL, N'2', N'保养', NULL, 0, NULL, 2, 0, 1, N'', '2020-11-30 14:45:40.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'fad061eb-9ec8-4d9f-ae47-0588194caf02', N'2e440789-bd9b-46a5-9a64-190163f8a9cf', NULL, N'0', N'空闲', NULL, 0, NULL, 0, 0, 1, N'', '2020-11-30 14:45:22.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'fc35d37e-1030-442a-9b2b-d153710f03ca', N'002eeaa9-c804-4c98-afd9-7ddc7c1e4c46', NULL, N'7', N'物料退回', NULL, 0, NULL, 7, 0, 1, N'', '2021-01-20 09:37:50.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'fc42e714-3fe9-429e-a1dd-6e4a30f7eddd', N'faff6e57-5a15-4ba7-a971-d5453e3040c2', NULL, N'3', N'库存检验', NULL, 0, NULL, 3, 0, 1, N'', '2021-05-21 15:06:35.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'fe1668c9-362f-42b8-a868-ac9e59f39d26', N'bf06d1e0-cfde-40c9-954c-df930e26e319', NULL, N'2', N'焊接', NULL, 0, NULL, 2, 0, 1, N'固定', '2020-11-30 15:04:09.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2022-10-09 20:16:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'08dab7e1-3d86-4e60-8743-965132ed3b6c', N'08dab7e1-2118-47e0-8604-dbf1803eec08', NULL, 'B', '夜班', NULL, 0, NULL, 1, 0, 1, N'20:00-8:00', '2022-10-27 14:05:25', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2022-10-27 14:10:57', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
INSERT INTO [dbo].[sys_ItemsDetail] ([F_Id], [F_ItemId], [F_ParentId], [F_ItemCode], [F_ItemName], [F_SimpleSpelling], [F_IsDefault], [F_Layers], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'08dab7e1-34aa-4b58-8cc5-a95f6dafb32e', N'08dab7e1-2118-47e0-8604-dbf1803eec08', NULL, 'A', '白班', NULL, 0, NULL, 0, 0, 1, '8:00-20:00', '2022-10-27 14:05:11', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', '2022-10-27 14:11:09', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL);
-- ----------------------------
-- Table structure for sys_Log
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_Log]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_Log]
GO

CREATE TABLE [dbo].[sys_Log] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_Date] datetime2(7)  NULL,
  [F_Account] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_NickName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Type] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IPAddress] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IPAddressName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ModuleId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ModuleName] nvarchar(4000) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Result] tinyint  NULL,
  [F_Description] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_KeyValue] text COLLATE Chinese_PRC_CI_AS DEFAULT '' NULL,
  [F_CompanyId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[sys_Log] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of sys_Log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_Module
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_Module]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_Module]
GO

CREATE TABLE [dbo].[sys_Module] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_ParentId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Layers] int  NULL,
  [F_EnCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_FullName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Icon] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_UrlAddress] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Target] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsMenu] tinyint  NULL,
  [F_IsExpand] tinyint  NULL,
  [F_IsFields] tinyint  NULL,
  [F_IsPublic] tinyint  NULL,
  [F_AllowEdit] tinyint  NULL,
  [F_AllowDelete] tinyint  NULL,
  [F_SortCode] int  NULL,
  [F_DeleteMark] tinyint  NULL,
  [F_EnabledMark] tinyint  NULL,
  [F_Description] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsBoard] tinyint DEFAULT 0 NULL,
  [F_Authorize] varchar(100) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[sys_Module] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否看板',
'SCHEMA', N'dbo',
'TABLE', N'sys_Module',
'COLUMN', N'F_IsBoard'
GO


-- ----------------------------
-- Records of sys_Module
-- ----------------------------
INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'01849cc9-c6da-4184-92f8-34875dac1d42', N'462027E0-0848-41DD-BCC3-025DCAE65555', N'2', N'CodeGenerator', N'代码生成', N'fa fa-code', N'/SystemManage/CodeGenerator/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2020-05-06 13:11:32.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-16 09:27:33.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'08d92a3f-bdb2-42be-89c7-fae5d3a4fec3', N'83e2713c-3b2b-4795-8e48-646785a1936b', N'3', N'EqpPqcCheckItem', N'设备点检项', N'fa fa-cc-diners-club', N'/EquipmentManage/EqpPqcCheckItem/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2021-06-08 13:39:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2022-10-24 13:40:34.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'08d92af0-e091-40c3-8a90-914a3266dafc', N'83e2713c-3b2b-4795-8e48-646785a1936b', N'3', N'EqpPqcCheckMD', N'设备日点检', N'fa fa-adjust', N'/EquipmentManage/EqpPqcCheckMD/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'6', N'0', N'1', N'', N'2021-06-09 10:47:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'08d92be4-74ba-4edf-8357-49547cae7fbc', N'83e2713c-3b2b-4795-8e48-646785a1936b', N'3', N'EqpStopRecord', N'设备停机', N'fa fa-exclamation-triangle', N'/EquipmentManage/EqpStopRecord/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'7', N'0', N'1', N'', N'2021-06-10 15:50:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-08-27 10:12:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'08d92fa2-7423-43dc-8839-359e00c53878', N'08d935e2-5205-4f27-8a80-331f2856ee0e', N'3', N'WorkPlan', N'生产计划', N'fa fa-paper-plane-o', N'/ProcessManage/WorkPlan/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-06-15 10:08:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-06-23 09:04:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'08d92fb7-7754-4c3b-8341-c60bc590212d', N'83e2713c-3b2b-4795-8e48-646785a1936b', N'3', N'EqpRepair', N'设备维修记录', N'fa fa-bitbucket-square', N'/EquipmentManage/EqpRepair/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'8', N'0', N'1', N'', N'2021-06-15 12:38:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2022-10-24 13:42:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'08d93158-2459-490a-868d-a826777f22e4', N'101358e6-eb92-431a-9f05-949f05738506', N'3', N'TransferBoxBatch', N'条码打印', N'fa fa-print', N'/MaterialManage/TransferBoxBatch/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'101', N'0', N'1', N'', N'2021-06-17 14:21:29.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-07-05 09:03:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'08d935e2-5205-4f27-8a80-331f2856ee0e', N'd5be1a41-547d-4001-8ae7-f6568e4d6cfe', N'2', N'PlanManage', N'计划管理', N'fa fa-paper-plane', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-06-23 09:00:40.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'08d9360c-dd12-43e8-8ebe-0104c5bd3c08', N'08d935e2-5205-4f27-8a80-331f2856ee0e', N'3', N'InStoragePlan', N'采购计划', N'fa fa-adjust', N'/PlanManage/InStoragePlan/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-06-23 14:05:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-06-23 15:04:16.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'08d93615-4748-4f48-88aa-162ed2db75a9', N'08d935e2-5205-4f27-8a80-331f2856ee0e', N'3', N'OutStoragePlan', N'交付计划', N'fa fa-hand-paper-o', N'/PlanManage/OutStoragePlan/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2021-06-23 15:05:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'08d93d2e-a9ac-44ba-86bf-af6814a028b3', N'5c4c18b1-88be-4819-ab5a-199bba8ae070', N'3', N'AllBadStorageReport', N'不良品汇总', N'', N'/ReportRecord/AllBadStorageReport/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'11', N'0', N'1', N'', N'2021-07-02 15:54:47.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-07-02 16:26:39.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'08d94670-7854-4707-8a1e-256200820167', N'732b0226-a8d6-41e7-b731-a8c4252f1c88', N'3', N'ScapMaterialReturn', N'退回记录', N'fa fa-caret-left', N'/QualityManage/ScapMaterialReturn/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2021-07-14 10:38:32.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-07-14 10:59:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'08d94b44-8770-42cb-8dc2-ef4c67a7b162', N'5c4c18b1-88be-4819-ab5a-199bba8ae070', N'3', N'CheckDateStorage', N'盘点记录', N'', N'/ReportRecord/CheckDateStorage/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'12', N'0', N'1', N'', N'2021-07-20 14:06:35.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-07-20 14:06:49.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'08d94c14-e1b5-4b56-8873-37fb81ebaad3', N'08d935e2-5205-4f27-8a80-331f2856ee0e', N'3', N'Order', N'订单管理', N'fa fa-500px', N'/PlanManage/Order/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2021-07-21 14:58:02.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-07-26 09:15:07.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'08d97330-6dd4-4435-851b-d6b12ea91518', N'462027E0-0848-41DD-BCC3-025DCAE65555', N'3', N'ReportTemplate', N'报表模板', N'fa fa-area-chart', N'/SystemManage/ReportTemplate/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'11', N'0', N'1', N'', N'2021-09-09 09:23:29.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-09-09 13:30:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'08dab306-91ba-4cd2-8fd2-591c0fce6ab1', N'd5be1a41-547d-4001-8ae7-f6568e4d6cfe', N'2', N'RunMonitor', N'运营监控', N'fa fa-tv', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'96', N'0', N'1', N'', N'2022-10-21 09:50:02.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'08dab30a-d896-4019-8066-7001d27a834e', N'08dab306-91ba-4cd2-8fd2-591c0fce6ab1', N'3', N'BoardAccount', N'看板账户', N'fa fa-address-book', N'/RunMonitor/BoardAccount/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2022-10-21 10:20:39.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'08dab30b-0c23-4b79-8743-35952367b7d8', N'08dab306-91ba-4cd2-8fd2-591c0fce6ab1', N'3', N'LogisticScanScreen', N'物流信息看板', N'fa fa-clock-o', N'/RunMonitor/LogisticScanScreen/Index', N'blank', N'1', N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2022-10-21 10:22:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'08dab30b-24a5-4bd2-8124-6f5037002a73', N'08dab306-91ba-4cd2-8fd2-591c0fce6ab1', N'3', N'EqpScanScreen', N'设备扫码看板', N'fa fa-sheqel', N'/RunMonitor/EqpScanScreen/Index', N'blank', N'1', N'0', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2022-10-21 10:22:47.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'08dab30b-4c9e-445f-82a9-e0264f432d57', N'08dab306-91ba-4cd2-8fd2-591c0fce6ab1', N'3', N'SmartScreen', N'总生产情况', N'fa fa-file-movie-o', N'/RunMonitor/SmartScreen/Index', N'blank', N'1', N'0', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2022-10-21 10:23:54.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'0a479fd4-57ca-46db-a8bf-c30d5871b1f9', N'5c841e96-00f1-47ea-aec7-d197278562de', N'3', N'ControlJobPlaner', N'调度人员', N'fa fa-user-secret', N'/ClassTask/ControlJobPlaner/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-01-18 14:53:07.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-18 15:18:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'0bddfade-d5b4-46c3-b0b6-45fb9f728e38', N'5c4c18b1-88be-4819-ab5a-199bba8ae070', N'3', N'ReturnMaterialReport', N'领用退回记录', N'', N'/ReportRecord/ReturnMaterialReport/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'6', N'0', N'1', N'', N'2021-02-26 08:50:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-02-26 08:55:33.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'101358e6-eb92-431a-9f05-949f05738506', N'd5be1a41-547d-4001-8ae7-f6568e4d6cfe', N'2', N'MaterialManage', N'生产管理', N'fa fa-shopping-cart', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2020-11-18 10:43:50.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-06-23 09:03:26.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'152a8e93-cebb-4574-ae74-2a86595ff986', N'462027E0-0848-41DD-BCC3-025DCAE65555', N'2', N'ModuleFields', N'字段管理', N'fa fa-table', N'/SystemManage/ModuleFields/Index', N'iframe', N'0', N'0', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2020-05-21 14:39:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-15 14:55:50.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'240eb9e4-d5f8-4097-8611-dcdb30c2f49a', N'732b0226-a8d6-41e7-b731-a8c4252f1c88', N'3', N'CheckoutDescription', N'检验参数', N'fa fa-sitemap', N'/QualityManage/CheckoutDescription/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-05-18 08:17:36.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-06-18 13:11:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'253646c6-ffd8-4c7f-9673-f349bbafcbe5', N'87dc2de3-ccbc-4dab-bb90-89fc68cbde4f', N'2', N'SystemOrganize', N'单位组织', N'fa fa-reorder', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2020-06-15 14:52:19.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-23 10:37:58.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'25b77622-ff89-47d2-b0b4-c8c8a7ff74d9', N'5c4c18b1-88be-4819-ab5a-199bba8ae070', N'3', N'ConsumeReport', N'消耗记录', N'', N'/ReportRecord/ConsumeReport/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'7', N'0', N'1', N'', N'2021-02-26 08:51:29.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-02-26 08:55:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'25ca371f-9c67-4e0e-9ca7-0dec2e836613', N'101358e6-eb92-431a-9f05-949f05738506', N'3', N'InStorage', N'入库管理', N'fa fa-get-pocket', N'/MaterialManage/InStorage/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2020-12-16 13:38:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-17 09:51:09.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'262ca754-1c73-436c-a9a2-b6374451a845', N'253646c6-ffd8-4c7f-9673-f349bbafcbe5', N'2', N'DataPrivilegeRule', N'数据权限', N'fa fa-database', N'/SystemOrganize/DataPrivilegeRule/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2020-06-01 09:44:58.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-16 08:11:44.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'26452c9a-243d-4c81-97b9-a3ad581c3bf4', N'253646c6-ffd8-4c7f-9673-f349bbafcbe5', N'2', N'Organize', N'机构管理', N'fa fa-sitemap', N'/SystemOrganize/Organize/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2020-04-09 15:24:34.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-16 08:11:39.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'2c2ddbce-ee87-4134-9b32-54d0bd572910', N'462027E0-0848-41DD-BCC3-025DCAE65555', N'3', N'Form', N'表单设计', N'fa fa-wpforms', N'/SystemManage/Form/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'8', N'0', N'1', N'', N'2020-07-08 14:34:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-03-02 09:47:32.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'2ffc3301-8ec2-4157-a4c3-232797aae120', N'3e431a6e-1906-48f6-91da-16015b40dd20', N'3', N'WorkOrderRun', N'工单作业', N'fa fa-fast-forward', N'/ProcessManage/WorkOrderRun/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2020-12-09 08:32:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'30c629a0-910e-404b-8c29-a73a6291fd95', N'73FD1267-79BA-4E23-A152-744AF73117E9', N'3', N'AppLog', N'系统日志', N'fa fa-file', N'/SystemSecurity/AppLog/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2020-07-08 10:12:42.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-07-08 10:14:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'33f831db-f9a4-43e7-8688-d08073af575b', N'5c841e96-00f1-47ea-aec7-d197278562de', N'3', N'DoneControlJob', N'已完成任务', N'fa fa-history', N'/ClassTask/ControlJob/Done', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2021-01-18 14:30:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'38CA5A66-C993-4410-AF95-50489B22939C', N'253646c6-ffd8-4c7f-9673-f349bbafcbe5', N'2', N'User', N'用户管理', N'fa fa-address-card-o', N'/SystemOrganize/User/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'6', N'0', N'1', N'', NULL, NULL, N'2020-06-16 08:11:59.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'39226710-b665-489e-aaa0-a8c15d29ed4c', N'101358e6-eb92-431a-9f05-949f05738506', N'3', N'BomInfo', N'Bom结构', N'fa fa-anchor', N'/MaterialManage/BomInfo/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2020-12-03 13:56:34.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-17 09:50:59.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'39fce29e-2d24-934c-432b-87fda7e92d81', N'5c841e96-00f1-47ea-aec7-d197278562de', N'3', N'ControlJobUserBanding', N'信息设置', N'fa fa-info', N'/ClassTask/ControlJobUserBanding/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2021-06-03 13:55:59.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-06-03 15:49:57.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'3e431a6e-1906-48f6-91da-16015b40dd20', N'd5be1a41-547d-4001-8ae7-f6568e4d6cfe', N'2', N'ProcessManage', N'工艺排程', N'fa fa-hourglass-start', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2020-11-18 10:40:24.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-06-23 09:03:39.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'423A200B-FA5F-4B29-B7B7-A3F5474B725F', N'462027E0-0848-41DD-BCC3-025DCAE65555', N'2', N'ItemsData', N'数据字典', N'fa fa-align-justify', N'/SystemManage/ItemsData/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'5', N'0', N'1', N'', NULL, NULL, N'2020-06-15 14:57:31.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'462027E0-0848-41DD-BCC3-025DCAE65555', N'87dc2de3-ccbc-4dab-bb90-89fc68cbde4f', N'2', N'SystemManage', N'系统管理', N'fa fa-gears', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', NULL, NULL, N'2020-06-23 10:38:07.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'4666f434-3178-42e5-a44f-1f34cadb3c43', N'a955a782-35d2-4a47-b6de-2c93a0e524b2', N'2', N'MesStorageApp', N'库存应用', N'', NULL, N'expand', N'0', N'0', N'0', N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2021-04-27 15:45:44.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'MesStorageApp')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'4666f434-3178-42e5-a44f-1f34cadb3c44', N'a955a782-35d2-4a47-b6de-2c93a0e524b2', N'2', N'MesHotlineApp', N'设备相关', N'', NULL, N'expand', N'0', N'0', N'0', N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2021-04-27 15:45:44.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'MesHotlineApp')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'484269cb-9aea-4af1-b7f6-f99e7e396ad1', N'462027E0-0848-41DD-BCC3-025DCAE65555', N'3', N'SystemOptions', N'系统配置', N'fa fa-gears', N'/SystemOrganize/SystemSet/SetForm', N'iframe', N'1', N'0', N'1', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2020-06-12 14:32:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-03-02 09:47:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'49F61713-C1E4-420E-BEEC-0B4DBC2D7DE8', N'73FD1267-79BA-4E23-A152-744AF73117E9', N'3', N'ServerMonitoring', N'服务器监控', N'fa fa-desktop', N'/SystemSecurity/ServerMonitoring/Index', N'expand', N'1', N'0', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', NULL, NULL, N'2020-07-02 08:45:07.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'50cdea18-b06a-43c8-963c-8f52fb9d94de', N'101358e6-eb92-431a-9f05-949f05738506', N'3', N'MaterialBom', N'物料工序绑定', N'', N'/MaterialManage/MaterialBom/Index', N'iframe', N'0', N'0', N'0', N'0', N'0', N'0', N'99', N'0', N'1', N'', N'2020-12-03 14:42:53.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-17 09:50:07.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'5391c5c0-55c0-4132-a26d-5d27fcec1c18', N'101358e6-eb92-431a-9f05-949f05738506', N'3', N'Location', N'库位管理', N'fa fa-map-marker', N'/MaterialManage/Location/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2020-12-17 08:32:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-17 09:49:29.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'5c4c18b1-88be-4819-ab5a-199bba8ae070', N'd5be1a41-547d-4001-8ae7-f6568e4d6cfe', N'2', N'ReportRecord', N'报表记录', N'fa fa-bar-chart', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'98', N'0', N'1', N'', N'2021-02-26 08:36:39.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-06-23 09:01:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'5c841e96-00f1-47ea-aec7-d197278562de', N'd5be1a41-547d-4001-8ae7-f6568e4d6cfe', N'2', N'ClassTask', N'调度任务', N'fa fa-address-card-o', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2020-12-04 08:20:50.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-18 15:59:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'5f9873e9-0308-4a8e-84b7-1c4c61f37654', N'87dc2de3-ccbc-4dab-bb90-89fc68cbde4f', N'2', N'FlowManage', N'流程中心', N'fa fa-stack-overflow', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2020-07-14 15:39:44.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-05-19 16:16:21.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'605444e5-704f-4cca-8d00-75175e2aef05', N'5f9873e9-0308-4a8e-84b7-1c4c61f37654', N'3', N'ToDoFlow', N'待处理流程', N'fa fa-volume-control-phone', N'/FlowManage/Flowinstance/ToDoFlow', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2020-07-15 15:03:12.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'64A1C550-2C61-4A8C-833D-ACD0C012260F', N'462027E0-0848-41DD-BCC3-025DCAE65555', N'3', N'Module', N'系统菜单', N'fa fa-music', N'/SystemManage/Module/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'测试', NULL, NULL, N'2020-07-14 15:45:36.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'667a7393-ed53-43e0-bf2a-c349e5dd48e5', N'5c4c18b1-88be-4819-ab5a-199bba8ae070', N'3', N'EqpMaterialUseReport', N'领用记录', N'', N'/ReportRecord/EqpMaterialUseReport/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2021-02-26 08:50:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-02-26 08:55:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'69f6aebb-965b-4380-910f-99aba0776261', N'101358e6-eb92-431a-9f05-949f05738506', N'3', N'Storage', N'库存管理', N'fa fa-shopping-basket', N'/MaterialManage/Storage/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'7', N'0', N'1', N'', N'2020-12-31 09:50:14.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-04 11:09:32.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'6b196514-0df1-41aa-ae64-9bb598960709', N'87dc2de3-ccbc-4dab-bb90-89fc68cbde4f', N'2', N'FileManage', N'文件中心', N'fa fa-file-text-o', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2020-07-22 11:43:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-08-12 11:17:44.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'6bdd6d88-4391-476e-bcec-10e41cbdcea7', N'5c4c18b1-88be-4819-ab5a-199bba8ae070', N'3', N'EqpWorkTime', N'设备值班记录', N'', N'/ReportRecord/EqpWorkTime/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'10', N'0', N'1', N'', N'2021-04-08 11:40:30.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'6d903aa1-35e3-4b75-b2a4-261be30a0e15', N'5c4c18b1-88be-4819-ab5a-199bba8ae070', N'3', N'AllStorageReport', N'库存汇总', N'', N'/ReportRecord/AllStorageReport/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-04-01 14:24:05.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-04-01 14:25:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'732b0226-a8d6-41e7-b731-a8c4252f1c88', N'd5be1a41-547d-4001-8ae7-f6568e4d6cfe', N'2', N'QualityManage', N'品质监管', N'fa fa-calendar-check-o', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2020-11-18 10:45:07.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-06-23 09:03:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'73FD1267-79BA-4E23-A152-744AF73117E9', N'87dc2de3-ccbc-4dab-bb90-89fc68cbde4f', N'2', N'SystemSecurity', N'系统安全', N'fa fa-desktop', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', NULL, NULL, N'2020-06-23 10:54:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'788d27cb-598d-41da-ac11-b7ddf0914b08', N'c9a88d3e-e66b-4929-906a-f6eaec00527f', N'3', N'DingTalkConfig', N'应用配置', NULL, N'/DingTalkManage/DingTalkConfig/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2020-11-21 09:55:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'79c73d26-6f49-463a-9002-98eba48e36b2', N'101358e6-eb92-431a-9f05-949f05738506', N'3', N'Area', N'库区管理', N'fa fa-home', N'/MaterialManage/Area/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2020-12-17 08:31:32.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-17 09:49:21.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'7cb65e00-8af2-4cf2-b318-8ba28b3c154e', N'6b196514-0df1-41aa-ae64-9bb598960709', N'3', N'Uploadfile', N'文件管理', N'fa fa-file-text-o', N'/FileManage/Uploadfile/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2020-07-22 12:05:35.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-07-22 17:20:34.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'7cce1014-5087-4184-9848-77e164be4e17', N'3e431a6e-1906-48f6-91da-16015b40dd20', N'3', N'WorkOrder', N'工单管理', N'fa fa-sticky-note', N'/ProcessManage/WorkOrder/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2020-12-07 12:14:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-07 13:46:55.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'7e4e4a48-4d51-4159-a113-2a211186f13a', N'253646c6-ffd8-4c7f-9673-f349bbafcbe5', N'3', N'Notice', N'系统公告', N'fa fa-book', N'/SystemOrganize/Notice/Index', N'iframe', N'0', N'0', N'1', N'0', N'0', N'0', N'0', N'0', N'0', N'', N'2020-04-14 15:39:29.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-11-15 13:38:44.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'83d761e9-4ab8-45db-a9ce-32bc148b6922', N'83e2713c-3b2b-4795-8e48-646785a1936b', N'3', N'EqpArea', N'设备区域绑定', N'', N'/EquipmentManage/EqpArea/Index', N'iframe', N'0', N'0', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2020-12-17 11:22:14.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'83e2713c-3b2b-4795-8e48-646785a1936b', N'd5be1a41-547d-4001-8ae7-f6568e4d6cfe', N'2', N'EquipmentManage', N'设备维护', N'fa fa-sheqel', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2020-11-18 10:46:55.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-06-23 09:03:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'84e5ec65-f803-485e-b703-4d07eaaf6c05', N'101358e6-eb92-431a-9f05-949f05738506', N'3', N'OutStorage', N'出库管理', N'fa fa-sign-out', N'/MaterialManage/OutStorage/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'6', N'0', N'1', N'', N'2020-12-16 13:39:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-17 09:51:15.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'87dc2de3-ccbc-4dab-bb90-89fc68cbde4f', N'0', N'1', N'GeneralManage', N'常规管理', N'', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2020-06-23 10:37:39.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-30 15:33:51.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'8968b428-2a8b-4dbe-ad47-73dd408ddd5e', N'3e431a6e-1906-48f6-91da-16015b40dd20', N'3', N'ProcessFlow', N'工序管理', N'fa fa-hourglass-1', N'/ProcessManage/ProcessFlow/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2020-12-03 09:49:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-03 10:30:43.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'91448822-e10b-4146-b9fe-2669073cc7f1', N'a955a782-35d2-4a47-b6de-2c93a0e524b2', N'2', N'MesProduceApp', N'生产应用', N'', NULL, N'expand', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-04-27 15:17:39.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'MesProduceApp')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'91A6CFAD-B2F9-4294-BDAE-76DECF412C6C', N'253646c6-ffd8-4c7f-9673-f349bbafcbe5', N'2', N'Role', N'角色管理', N'fa fa-user-circle', N'/SystemOrganize/Role/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', NULL, NULL, N'2020-06-16 08:11:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'96EE855E-8CD2-47FC-A51D-127C131C9FB9', N'73FD1267-79BA-4E23-A152-744AF73117E9', N'3', N'Log', N'操作日志', N'fa fa-clock-o', N'/SystemSecurity/Log/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', NULL, NULL, N'2020-07-08 10:13:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'a083a171-932a-48b8-b053-13f9b39d555a', N'a955a782-35d2-4a47-b6de-2c93a0e524b2', N'2', N'MesLogisticsApp', N'物流应用', N'', NULL, N'expand', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-04-27 15:19:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'MesLogisticsApp')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'a2cae27f-0b49-4181-8760-4be3a3560988', N'5c841e96-00f1-47ea-aec7-d197278562de', N'3', N'DoingControlJob', N'当前任务', N'fa fa-snowflake-o', N'/ClassTask/ControlJob/Doing', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2021-01-18 14:28:15.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-22 09:16:26.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'a303cbe1-60eb-437b-9a69-77ff8b48f173', N'253646c6-ffd8-4c7f-9673-f349bbafcbe5', N'3', N'SystemSet', N'租户设置', N'fa fa-connectdevelop', N'/SystemOrganize/SystemSet/Index', N'iframe', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'0', N'', N'2020-06-12 13:54:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-14 16:40:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'a3a4742d-ca39-42ec-b95a-8552a6fae579', N'73FD1267-79BA-4E23-A152-744AF73117E9', N'2', N'FilterIP', N'访问控制', N'fa fa-filter', N'/SystemSecurity/FilterIP/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2016-07-17 22:06:10.0000000', NULL, N'2020-04-16 14:10:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'a5b323e7-db24-468f-97d7-a17bf5396742', N'87dc2de3-ccbc-4dab-bb90-89fc68cbde4f', N'2', N'InfoManage', N'信息中心', N'fa fa-info', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2020-07-29 16:40:58.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-08-12 11:17:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'a620c016-27cb-46f8-86c9-44c197617524', N'83e2713c-3b2b-4795-8e48-646785a1936b', N'3', N'EqpUser', N'设备人员绑定', N'', N'/EquipmentManage/EqpUser/Index', N'iframe', N'0', N'0', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2021-01-15 11:26:19.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'a8f0c195-53c5-4b05-b65e-5fafb14a3aec', N'5c841e96-00f1-47ea-aec7-d197278562de', N'3', N'ControlJob', N'待执行任务', N'fa fa-tasks', N'/ClassTask/ControlJob/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-01-15 14:19:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-18 14:29:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'a955a782-35d2-4a47-b6de-2c93a0e524b2', N'0', N'1', N'MesSmallApp', N'MES小程序', N'', NULL, N'expand', N'0', N'1', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2021-04-27 14:19:17.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-04-27 15:20:12.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'MesSmallApp')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'af863666-a357-4e06-bffd-df98e1d29ab8', N'83e2713c-3b2b-4795-8e48-646785a1936b', N'3', N'Equipment', N'设备管理', N'fa fa-sheqel', N'/EquipmentManage/Equipment/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2020-11-30 14:05:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-02 14:30:05.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'b26cea9c-21ba-42fa-98fc-b8fe0b92451d', N'732b0226-a8d6-41e7-b731-a8c4252f1c88', N'3', N'NeedCheck', N'质检管理', N'fa fa-calendar-check-o', N'/QualityManage/NeedCheck/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-05-21 13:57:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-06-18 13:11:15.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'b39698da-6117-433e-8a02-ef1392d1fe3b', N'732b0226-a8d6-41e7-b731-a8c4252f1c88', N'3', N'ScapMaterial', N'不良品管理', N'fa fa-bluetooth-b', N'/QualityManage/ScapMaterial/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2021-05-21 13:59:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-06-18 13:11:44.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'b398f0e5-44d3-4206-9d90-e2f5d2740379', N'0', N'1', N'MobileManage', N'移动端', N'', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2020-11-21 08:47:32.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-11-21 08:47:51.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'b5ff9591-f939-41c0-8c68-3b9c2fe02bdd', N'a955a782-35d2-4a47-b6de-2c93a0e524b2', N'2', N'MesCheckoutApp', N'质检应用', N'', NULL, N'expand', N'0', N'0', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2021-04-27 15:29:33.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'MesCheckoutApp')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'badc3ee2-fcbb-43ae-9efe-2309f8a63834', N'101358e6-eb92-431a-9f05-949f05738506', N'3', N'MaterialEqp', N'物料设备绑定', N'', N'/MaterialManage/MaterialEqp/Index', N'iframe', N'0', N'0', N'0', N'0', N'0', N'0', N'100', N'0', N'1', N'', N'2020-12-02 15:54:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-17 09:49:47.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'be2173ad-0833-4a9a-8024-b9f32f892de5', N'5c4c18b1-88be-4819-ab5a-199bba8ae070', N'3', N'InStorageReport', N'入库报表', N'', N'/ReportRecord/InStorageReport/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-02-26 08:39:47.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-02-26 08:54:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'beaddc98-9037-4fc6-8d21-493fe47f20e8', N'101358e6-eb92-431a-9f05-949f05738506', N'3', N'TransferTypeManage', N'流转类型绑定', N'', N'/MaterialManage/TransferType/Index', N'iframe', N'0', N'0', N'0', N'0', N'0', N'0', N'98', N'0', N'1', N'', N'2020-12-14 13:12:40.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-17 09:50:18.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'c87cd44f-d064-4d3c-a43e-de01a7a8785e', N'5f9873e9-0308-4a8e-84b7-1c4c61f37654', N'3', N'Flowinstance', N'我的流程', N'fa fa-user-o', N'/FlowManage/Flowinstance/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2020-07-14 09:21:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-07-24 15:59:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'c9a88d3e-e66b-4929-906a-f6eaec00527f', N'b398f0e5-44d3-4206-9d90-e2f5d2740379', N'2', N'DingTalkManage', N'钉钉应用', N'fa fa-mobile-phone', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2020-11-21 09:09:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-11-21 09:52:26.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'cf527f37-2b29-403a-a83b-a6fb0af33b7f', N'5c4c18b1-88be-4819-ab5a-199bba8ae070', N'3', N'StorageChangeReport', N'库存变动记录', N'', N'/ReportRecord/StorageChangeReport/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'9', N'0', N'1', N'', N'2021-02-26 08:53:12.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-02-26 08:55:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'd5be1a41-547d-4001-8ae7-f6568e4d6cfe', N'0', N'1', N'MesManage', N'MES系统', N'', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2020-11-18 10:37:47.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'd742c96e-b61c-4cea-afeb-81805789687b', N'462027E0-0848-41DD-BCC3-025DCAE65555', N'2', N'ItemsType', N'字典分类', N'fa fa-align-justify', N'/SystemManage/ItemsType/Index', N'iframe', N'0', N'0', N'0', N'0', N'0', N'0', N'6', N'0', N'1', N'', N'2020-04-27 16:51:07.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-15 14:57:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'd9078b9a-5db6-4429-b489-3700e56f367f', N'462027E0-0848-41DD-BCC3-025DCAE65555', N'3', N'PrintTemplate', N'打印模板', N'fa fa-print', N'/SystemManage/PrintTemplate/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'10', N'0', N'1', N'', N'2021-01-14 13:24:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-14 13:57:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'db891a42-1b8a-4797-9518-2b038f457a25', N'5c4c18b1-88be-4819-ab5a-199bba8ae070', N'3', N'MaterialReport', N'物料追溯', N'', N'/ReportRecord/MaterialReport/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-02-26 08:54:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'e093b2d3-ec49-4b4d-91ec-63f57f4e3f1d', N'101358e6-eb92-431a-9f05-949f05738506', N'3', N'TransferBox', N'流转箱管理', N'fa fa-paper-plane-o', N'/MaterialManage/TransferBox/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2020-12-14 12:44:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-17 09:50:28.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'e3188a69-de3a-40ef-a5ff-5eaf460f5d20', N'73FD1267-79BA-4E23-A152-744AF73117E9', N'3', N'OpenJobs', N'定时任务', N'fa fa-paper-plane-o', N'/SystemSecurity/OpenJobs/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2020-05-26 13:55:22.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-07-08 10:13:54.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'e9190a56-e173-4483-8a3e-f17b86e4766e', N'a5b323e7-db24-468f-97d7-a17bf5396742', N'3', N'Message', N'通知管理', N'fa fa-info-circle', N'/InfoManage/Message/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2020-07-29 16:44:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-08-03 16:13:56.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'ea9864ce-e397-42b0-8819-0680b78fcf4c', N'a955a782-35d2-4a47-b6de-2c93a0e524b2', N'2', N'MesOutstorageApp', N'出库应用', N'', NULL, N'expand', N'0', N'0', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2021-04-27 15:27:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'MesOutstorageApp')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'eb3cf8ac-947d-4091-9c8e-75da8bae5e7f', N'5c4c18b1-88be-4819-ab5a-199bba8ae070', N'3', N'OutStorageReport', N'出库记录', N'', N'/ReportRecord/OutStorageReport/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2021-02-26 08:40:47.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-02-26 08:54:40.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'ed757a25-82d5-43cc-89f4-ed26a51fb4f0', N'462027E0-0848-41DD-BCC3-025DCAE65555', N'2', N'ModuleButton', N'菜单按钮', N'fa fa-arrows-alt', N'/SystemManage/ModuleButton/Index', N'iframe', N'0', N'0', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2020-04-27 16:56:30.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-15 14:55:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'ed896675-541a-4d34-bf77-29c87d7a26bb', N'101358e6-eb92-431a-9f05-949f05738506', N'3', N'Material', N'物料管理', N'fa fa-product-hunt', N'/MaterialManage/Material/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2020-12-01 14:31:51.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-17 09:50:39.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'ee136db7-178a-4bb0-b878-51287a5e2e2b', N'5f9873e9-0308-4a8e-84b7-1c4c61f37654', N'3', N'DoneFlow', N'已处理流程', N'fa fa-history', N'/FlowManage/Flowinstance/DoneFlow', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2020-07-15 15:05:33.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'eeb05603-45d5-4205-88fc-0fe60357710d', N'a955a782-35d2-4a47-b6de-2c93a0e524b2', N'2', N'MesInstorageApp', N'入库应用', N'', NULL, N'expand', N'0', N'0', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2021-04-27 15:19:50.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'MesInstorageApp')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'F298F868-B689-4982-8C8B-9268CBF0308D', N'253646c6-ffd8-4c7f-9673-f349bbafcbe5', N'2', N'Duty', N'岗位管理', N'fa fa-users', N'/SystemOrganize/Duty/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'5', N'0', N'1', N'', NULL, NULL, N'2020-06-16 08:11:54.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', NULL)
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'f82fd629-5f3a-45d6-8681-5ec47e66a807', N'462027E0-0848-41DD-BCC3-025DCAE65555', N'3', N'Flowscheme', N'流程设计', N'fa fa-list-alt', N'/SystemManage/Flowscheme/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'9', N'0', N'1', N'', N'2020-07-10 08:50:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-03-02 09:47:26.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'ffcf9006-570e-44f5-80d4-32c213813a92', N'5c4c18b1-88be-4819-ab5a-199bba8ae070', N'3', N'OutputReport', N'产出记录', N'', N'/ReportRecord/OutputReport/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'8', N'0', N'1', N'', N'2021-02-26 08:52:04.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-02-26 08:55:14.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0', N'')
GO


-- ----------------------------
-- Table structure for sys_ModuleButton
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_ModuleButton]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_ModuleButton]
GO

CREATE TABLE [dbo].[sys_ModuleButton] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_ModuleId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ParentId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Layers] int  NULL,
  [F_EnCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_FullName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Icon] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Location] int  NULL,
  [F_JsEvent] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_UrlAddress] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Split] tinyint  NULL,
  [F_IsPublic] tinyint  NULL,
  [F_AllowEdit] tinyint  NULL,
  [F_AllowDelete] tinyint  NULL,
  [F_SortCode] int  NULL,
  [F_DeleteMark] tinyint  NULL,
  [F_EnabledMark] tinyint  NULL,
  [F_Description] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Authorize] varchar(100) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[sys_ModuleButton] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of sys_ModuleButton
-- ----------------------------
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'00121ebb-3871-465d-9586-cd38c5a25b18', N'6bdd6d88-4391-476e-bcec-10e41cbdcea7', N'0', N'1', N'NF-add', N'清空记录', NULL, N'1', N'add', N'/ReportRecord/EqpWorkTime/Fotm', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-04-08 11:40:51.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-04-08 11:41:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'0063eff0-11b4-4da6-b864-f6e3b4c3f89a', N'6d903aa1-35e3-4b75-b2a4-261be30a0e15', N'0', N'1', N'NF-add', N'预警', NULL, N'1', N'add', N'/ReportRecord/AllStorageReport/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-04-01 14:26:05.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-04-01 14:26:36.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'00eafd02-2d7e-4750-a799-3d8cdf062b14', N'eeb05603-45d5-4205-88fc-0fe60357710d', N'0', N'1', N'InStorageCancleBanding', N'入库取消绑定', NULL, N'1', N'InStorageCancleBanding', N'', NULL, N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-04-27 16:05:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'InStorageCancleBanding')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'01600a2b-c218-48d6-bb37-842daa727248', N'152a8e93-cebb-4574-ae74-2a86595ff986', N'0', N'1', N'NF-delete', N'删除字段', NULL, N'2', N'delete', N'/SystemManage/ModuleFields/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2020-05-21 14:39:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-05-21 15:15:16.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'02a4ee76-4715-4d98-a742-f7ecd7e7d9dd', N'b5ff9591-f939-41c0-8c68-3b9c2fe02bdd', N'0', N'1', N'ReturnCheckout', N'质检返库', NULL, N'1', N'ReturnCheckout', N'', NULL, N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2021-05-26 09:24:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'ReturnCheckout')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'05a198ba-cafa-42c2-8ed8-3140f9c4ef9d', N'd9078b9a-5db6-4429-b489-3700e56f367f', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/SystemManage/PrintTemplate/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2021-01-14 13:24:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'064d1ffc-40dd-4bf2-8e7e-aab42e683995', N'b39698da-6117-433e-8a02-ef1392d1fe3b', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/QualityManage/ScapMaterial/Details', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2021-05-21 13:59:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'071f5982-efb2-4fa3-a6cf-a02f3f1f9d92', N'ed757a25-82d5-43cc-89f4-ed26a51fb4f0', N'0', N'1', N'NF-add', N'新增按钮', NULL, N'1', N'add', N'/SystemManage/ModuleButton/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, NULL, NULL, N'2020-04-27 16:56:56.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'0726694c-417d-4222-bbe6-268fec47145f', N'91448822-e10b-4146-b9fe-2669073cc7f1', N'0', N'1', N'NeedMaterialJob', N'生产领用申请', NULL, N'1', N'NeedMaterialJob', N'', NULL, N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-04-27 15:53:40.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'NeedMaterialJob')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d92a20-b747-4c5a-8a06-c1ce8588c7ce', N'39fce29e-2d24-934c-432b-87fda7e92d81', N'0', N'1', N'NF-time', N'设置时间', NULL, N'1', N'time', N'/ClassTask/ControlJobUserBanding/TimeForm', NULL, N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-06-08 09:57:05.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d92a3f-db7e-48a4-85f6-6fa01dfa49e2', N'08d92a3f-bdb2-42be-89c7-fae5d3a4fec3', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/EquipmentManage/EqpPqcCheckitem/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-06-08 13:40:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-06-08 13:41:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d92a3f-db7e-492e-8761-8d531b99eea2', N'08d92a3f-bdb2-42be-89c7-fae5d3a4fec3', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/EquipmentManage/EqpPqcCheckitem/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-06-08 13:40:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-06-08 13:41:17.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d92a3f-db7e-496f-8818-7e8575081481', N'08d92a3f-bdb2-42be-89c7-fae5d3a4fec3', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/EquipmentManage/EqpPqcCheckitem/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2021-06-08 13:40:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-06-08 13:41:36.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d92a3f-db7e-49c7-8997-8b28aa22bd1f', N'08d92a3f-bdb2-42be-89c7-fae5d3a4fec3', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/EquipmentManage/EqpPqcCheckitem/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2021-06-08 13:40:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-06-08 13:41:43.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d92ba9-f27c-4d5f-8d21-1acdd7cd6c4b', N'69f6aebb-965b-4380-910f-99aba0776261', N'0', N'1', N'NF-import', N'导入', NULL, N'1', N'import', N'/MaterialManage/Storage/Import', NULL, N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2021-06-10 08:51:57.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-06-10 08:52:30.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d92be4-74ca-4f08-8388-da5aca619fee', N'08d92be4-74ba-4edf-8357-49547cae7fbc', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/EquipmentManage/EqpStopRecord/AddForm', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-06-10 15:50:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-10-08 09:41:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d92be4-74ca-4f8d-87b4-1be4e1137e9d', N'08d92be4-74ba-4edf-8357-49547cae7fbc', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/EquipmentManage/EqpStopRecord/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2021-06-10 15:50:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d92be4-74ca-4fee-8728-e784d4edd9e9', N'08d92be4-74ba-4edf-8357-49547cae7fbc', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/EquipmentManage/EqpStopRecord/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2021-06-10 15:50:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d92be4-74cb-4045-8935-d894e9a5098f', N'08d92be4-74ba-4edf-8357-49547cae7fbc', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/EquipmentManage/EqpStopRecord/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2021-06-10 15:50:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d92c81-b505-4041-8f6c-f18e9630ed1c', N'08d92a3f-bdb2-42be-89c7-fae5d3a4fec3', N'0', N'1', N'NF-clonebutton', N'点检项复制', NULL, N'2', N'CloneForm', N'/EquipmentManage/EqpPqcCheckitem/CloneForm', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2021-06-11 10:36:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-06-11 10:37:31.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d92fa2-7437-4d8b-8592-8dce722502bf', N'08d92fa2-7423-43dc-8839-359e00c53878', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/ProcessManage/WorkPlan/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2021-06-15 10:08:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d92fa2-7437-4e6b-804d-6843753457d9', N'08d92fa2-7423-43dc-8839-359e00c53878', N'0', N'1', N'NF-batchAdd', N'批量创建工单', NULL, N'2', N'batchAdd', N'/ProcessManage/WorkPlan/BatchCreateWorkOrder', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-06-15 10:08:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-06-17 15:25:04.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d92fa2-7437-4ef3-8737-91cc6871ae8b', N'08d92fa2-7423-43dc-8839-359e00c53878', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/ProcessManage/WorkPlan/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2021-06-15 10:08:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d92fb7-7762-4998-8f28-acc9f98831a6', N'08d92fb7-7754-4c3b-8341-c60bc590212d', N'0', N'1', N'TF-add', N'新增', NULL, N'1', N'add', N'/EquipmentManage/EqpRepair/ManRecordForm', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2021-06-15 12:38:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-06-17 10:48:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d92fb7-7762-4a62-8cbb-c60e9098f62e', N'08d92fb7-7754-4c3b-8341-c60bc590212d', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/EquipmentManage/EqpRepair/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2021-06-15 12:38:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d92fb7-7762-4aa6-828e-83a1a9b06913', N'08d92fb7-7754-4c3b-8341-c60bc590212d', N'0', N'1', N'TF-delete', N'删除', NULL, N'2', N'delete', N'/EquipmentManage/EqpRepair/ManRecordDeleteForm', N'0', N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2021-06-15 12:38:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-06-17 10:49:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d92fb7-7762-4ae8-83f5-2aeed3949514', N'08d92fb7-7754-4c3b-8341-c60bc590212d', N'0', N'1', N'TF-details', N'查看', NULL, N'2', N'details', N'/EquipmentManage/EqpRepair/ManRecordDetails', N'0', N'0', N'0', N'0', N'6', N'0', N'1', N'', N'2021-06-15 12:38:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-06-18 08:50:36.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d9313a-3be4-4173-8d12-5227170b7c60', N'08d92fb7-7754-4c3b-8341-c60bc590212d', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/EquipmentManage/EqpRepair/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2021-06-17 10:47:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d9313a-3be4-4281-842e-de7dcfdeaa34', N'08d92fb7-7754-4c3b-8341-c60bc590212d', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/EquipmentManage/EqpRepair/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2021-06-17 10:47:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d93158-2734-48a5-8aaa-cb936a2d8dd9', N'08d93158-2459-490a-868d-a826777f22e4', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/MaterialManage/TransferBoxBatch/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2021-06-17 14:21:33.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d93158-2734-4988-8ec7-b05bdd501837', N'08d93158-2459-490a-868d-a826777f22e4', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/MaterialManage/TransferBoxBatch/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2021-06-17 14:21:33.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d93158-2734-4a10-810d-19bf895a26f1', N'08d93158-2459-490a-868d-a826777f22e4', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/MaterialManage/TransferBoxBatch/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2021-06-17 14:21:33.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d93159-94c7-440b-8243-118a163a60f0', N'08d93158-2459-490a-868d-a826777f22e4', N'0', N'1', N'NF-print', N'打印', NULL, N'1', N'print', N'/MaterialManage/TransferBoxBatch/PrinterForm', NULL, N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2021-06-17 14:31:47.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-06-18 10:14:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d931f3-0997-4e93-8110-2eacfb6cdbbe', N'08d92fb7-7754-4c3b-8341-c60bc590212d', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/EquipmentManage/EqpRepair/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2021-06-18 08:50:16.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d93219-b1c6-42da-88e3-b486742cdf43', N'b26cea9c-21ba-42fa-98fc-b8fe0b92451d', N'0', N'1', N'NF-enabled', N'完成质检', NULL, N'2', N'enabled', N'/QualityManage/NeedCheck/EnabledForm', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-06-18 13:26:59.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-06-18 13:27:33.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d93615-5caa-4d8b-831d-d6c728780fc4', N'08d93615-4748-4f48-88aa-162ed2db75a9', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/PlanManage/OutStoragePlan/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-06-23 15:06:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-08-16 20:39:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d93615-5caa-4e25-85fb-a71993e2687e', N'08d93615-4748-4f48-88aa-162ed2db75a9', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/PlanManage/OutStoragePlan/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2021-06-23 15:06:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-08-16 20:39:30.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d93615-773a-47ed-8a25-0cbf31c4f892', N'08d9360c-dd12-43e8-8ebe-0104c5bd3c08', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/PlanManage/InStoragePlan/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-06-23 15:06:47.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-08-16 20:38:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d93615-773a-4979-862b-1f1d852fb314', N'08d9360c-dd12-43e8-8ebe-0104c5bd3c08', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/PlanManage/InStoragePlan/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2021-06-23 15:06:47.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-08-16 20:38:54.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d936a5-bfd2-49d6-88fd-9b19bff30f88', N'08d92fa2-7423-43dc-8839-359e00c53878', N'0', N'1', N'NF-createNote', N'创建工单', NULL, N'1', N'createNote', N'/ProcessManage/WorkPlan/CreateWorkOrder', NULL, N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2021-06-24 08:19:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d93c2e-efcb-4f18-8829-fa085aad9c10', N'08d92fa2-7423-43dc-8839-359e00c53878', N'0', N'1', N'NF-otherAdd', N'附加生产', NULL, N'1', N'otherAdd', N'/ProcessManage/WorkPlan/AddForm', NULL, N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2021-07-01 09:24:14.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d93d33-d056-459d-8c47-d3aafb539c2b', N'b5ff9591-f939-41c0-8c68-3b9c2fe02bdd', N'0', N'1', N'BadStorageInfo', N'不良品汇总', NULL, N'1', N'BadStorageInfo', N'', NULL, N'0', N'0', N'0', N'7', N'0', N'1', N'', N'2021-07-02 16:31:40.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'BadStorageInfo')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d94a91-7899-437d-8fd2-e1c5e10f61b2', N'a083a171-932a-48b8-b053-13f9b39d555a', N'0', N'1', N'ConsumeMaterial1', N'扫码领用物料', NULL, N'1', N'ConsumeMaterial1', N'', NULL, N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2021-07-19 16:44:50.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'ConsumeMaterial1')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d94a91-8849-4e26-846f-5cd3edbe5d9f', N'a083a171-932a-48b8-b053-13f9b39d555a', N'0', N'1', N'OutputMaterialLocation1', N'扫码产出上架', NULL, N'1', N'OutputMaterialLocation1', N'', NULL, N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2021-07-19 16:45:17.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'OutputMaterialLocation1')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d94b27-e1ff-46ab-8f47-46c5c900b0d6', N'69f6aebb-965b-4380-910f-99aba0776261', N'0', N'1', N'NF-print', N'打印', NULL, N'1', N'print', N'print', NULL, N'0', N'0', N'0', N'6', N'0', N'1', N'', N'2021-07-20 10:41:32.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-13 14:23:40.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d94b38-5252-492f-8acf-744c5a3906bf', N'ea9864ce-e397-42b0-8819-0680b78fcf4c', N'0', N'1', N'OutStorage1', N'扫码下架', NULL, N'1', N'OutStorage1', N'', NULL, N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2021-07-20 12:39:12.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'OutStorage1')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d94b47-2fa7-4b05-87a2-e8b827c489c5', N'08d94b44-8770-42cb-8dc2-ef4c67a7b162', N'0', N'1', N'NF-add', N'清空记录', NULL, N'1', N'add', N'/ReportRecord/CheckDateStorage/Fotm', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-07-20 14:25:36.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-07-20 14:25:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d94c14-e1ca-4206-8a31-d60d885e9ac2', N'08d94c14-e1b5-4b56-8873-37fb81ebaad3', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/PlanManage/Order/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2021-07-21 14:58:02.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d94c14-e1ca-42ca-8ddc-2ceea031a8ea', N'08d94c14-e1b5-4b56-8873-37fb81ebaad3', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/PlanManage/Order/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2021-07-21 14:58:02.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d94c14-e1ca-434d-8024-3eb69cce8bb0', N'08d94c14-e1b5-4b56-8873-37fb81ebaad3', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/PlanManage/Order/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2021-07-21 14:58:02.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d94c14-e1ca-43be-899c-34cd6122a6db', N'08d94c14-e1b5-4b56-8873-37fb81ebaad3', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/PlanManage/Order/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2021-07-21 14:58:02.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d94fe5-2f1f-4ba2-8d92-63a2e8e3b4be', N'08d94c14-e1b5-4b56-8873-37fb81ebaad3', N'0', N'1', N'NF-enabled', N'启用', NULL, N'2', N'enabled', N'/PlanManage/Order/EnabledForm', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2021-07-26 11:26:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-07-26 11:26:56.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d95878-a40e-4413-86f4-21042d7998dc', N'08d92fa2-7423-43dc-8839-359e00c53878', N'0', N'1', N'NF-deleteall', N'删除全部计划', NULL, N'1', N'deleteall', N'/ProcessManage/WorkPlan/DeleteAllForm', NULL, N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2021-08-06 09:22:22.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d95878-b9f4-47a9-8a4f-e41b9a5c7a1b', N'08d9360c-dd12-43e8-8ebe-0104c5bd3c08', N'0', N'1', N'NF-deleteall', N'删除全部计划', NULL, N'1', N'deleteall', N'/PlanManage/InStoragePlan/DeleteAllForm', NULL, N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2021-08-06 09:22:59.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-08-16 20:38:59.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d95878-ce7f-4716-877e-d9d6331e64a3', N'08d93615-4748-4f48-88aa-162ed2db75a9', N'0', N'1', N'NF-deleteall', N'删除全部计划', NULL, N'1', N'deleteall', N'/PlanManage/OutStoragePlan/DeleteAllForm', NULL, N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2021-08-06 09:23:33.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-08-16 20:39:35.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d9612f-406a-4650-8469-829593b485df', N'08d94c14-e1b5-4b56-8873-37fb81ebaad3', N'0', N'1', N'NF-over', N'结案', NULL, N'1', N'over', N'/PlanManage/Order/OverForm', NULL, N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2021-08-17 11:29:42.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d963a3-ed2f-468f-8d22-6e20aeea4b71', N'08d9360c-dd12-43e8-8ebe-0104c5bd3c08', N'0', N'1', N'NF-enabledAll', N'显示全部计划', NULL, N'1', N'enabledAll', N'/PlanManage/InStoragePlan/EnabledAllForm', NULL, N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2021-08-20 14:29:56.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-08-23 14:11:57.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d963a3-f586-4385-8db2-d37f37689c90', N'08d93615-4748-4f48-88aa-162ed2db75a9', N'0', N'1', N'NF-enabledAll', N'显示全部计划', NULL, N'1', N'enabledAll', N'/PlanManage/OutStoragePlan/EnabledAllForm', NULL, N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2021-08-20 14:30:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-08-23 14:12:09.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d96da9-64f0-49d7-8528-fe30b78e529d', N'38CA5A66-C993-4410-AF95-50489B22939C', N'0', N'1', N'NF-print', N'打印', NULL, N'1', N'print', N'print', NULL, N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2021-09-02 08:34:16.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-14 14:29:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d97330-c16b-4b70-868c-5f1511c02f78', N'08d97330-6dd4-4435-851b-d6b12ea91518', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/SystemManage/ReportTemplate/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-09-09 09:25:49.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-09-09 13:30:30.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d97330-c16b-4bf2-8fc3-586be9c6b02a', N'08d97330-6dd4-4435-851b-d6b12ea91518', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/SystemManage/ReportTemplate/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-09-09 09:25:49.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-09-09 13:30:33.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d97330-c16b-4c5c-88a4-9e05027097a1', N'08d97330-6dd4-4435-851b-d6b12ea91518', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/SystemManage/ReportTemplate/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2021-09-09 09:25:49.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-09-09 13:30:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d97330-c16b-4cb8-8329-b6a539ee51ca', N'08d97330-6dd4-4435-851b-d6b12ea91518', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/SystemManage/ReportTemplate/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2021-09-09 09:25:49.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-09-09 13:30:40.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d97353-5dbb-4d3b-868c-b64e56ac96a6', N'd9078b9a-5db6-4429-b489-3700e56f367f', N'0', N'1', N'NF-download', N'下载', NULL, N'1', N'download', N'/SystemManage/PrintTemplate/Download', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2021-09-09 13:33:34.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-09-09 13:33:53.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d97353-77a5-418c-8554-9815ea09cdef', N'08d97330-6dd4-4435-851b-d6b12ea91518', N'0', N'1', N'NF-download', N'下载', NULL, N'1', N'download', N'/SystemManage/ReportTemplate/Download', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2021-09-09 13:34:18.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-09-09 13:34:28.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d98082-e408-47c9-8978-0ad58a19a792', N'08d98082-e3f5-4234-847c-4ff7cc1d0b9f', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/ProduceReport/GP12CheckReport/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2021-09-26 08:16:31.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d98082-e408-486b-8448-8b0a9e8add12', N'08d98082-e3f5-4234-847c-4ff7cc1d0b9f', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/ProduceReport/GP12CheckReport/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2021-09-26 08:16:31.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d98082-e408-48ce-85c8-06062ec63c13', N'08d98082-e3f5-4234-847c-4ff7cc1d0b9f', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/ProduceReport/GP12CheckReport/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2021-09-26 08:16:31.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d98082-e408-4926-87c5-6fd8aa21aedd', N'08d98082-e3f5-4234-847c-4ff7cc1d0b9f', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/ProduceReport/GP12CheckReport/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2021-09-26 08:16:31.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d98083-00a8-425d-8588-aff74ef85732', N'08d98082-e3f5-4234-847c-4ff7cc1d0b9f', N'0', N'1', N'NF-download', N'下载', NULL, N'1', N'download', N'/ProduceReport/GP12CheckReport/Download', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2021-09-26 08:17:19.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-09-26 08:17:32.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d98157-42c2-42e6-8f61-10c17452a972', N'08d966c3-26bd-4808-8e49-03d2085e08f4', N'0', N'1', N'NF-add', N'停机原因', NULL, N'1', N'add', N'/ProduceReport/HotProduceReport/Form', NULL, N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-09-27 09:36:43.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d98157-4f3a-4196-81be-d9fe01221b68', N'08d9679f-3156-4e38-8788-1c11763b3ece', N'0', N'1', N'NF-add', N'停机原因', NULL, N'1', N'add', N'/ProduceReport/WeldlineProduceReport/Form', NULL, N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-09-27 09:37:04.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-09-27 09:37:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d98157-6104-4adb-8951-3fc82d041189', N'08d9679f-4591-41be-86dc-56924fc0d49c', N'0', N'1', N'NF-add', N'停机原因', NULL, N'1', N'add', N'/ProduceReport/LaserProduceReport/Form', NULL, N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-09-27 09:37:34.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-09-27 09:37:50.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d98256-54bc-4b73-807e-4d3e7dba2b5d', N'69f6aebb-965b-4380-910f-99aba0776261', N'0', N'1', N'NF-done', N'批量删除', NULL, N'2', N'done', N'/MaterialManage/Storage/DoneForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2021-09-28 16:02:35.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-09-28 16:03:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d9a4b8-24a5-4b3e-8682-169a9ab29c04', N'39226710-b665-489e-aaa0-a8c15d29ed4c', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/MaterialManage/BomInfo/Form', NULL, N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-11-11 10:08:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d9a573-f1e5-4726-8a35-4feb68fdb31f', N'50cdea18-b06a-43c8-963c-8f52fb9d94de', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/MaterialManage/BomInfo/Form', NULL, N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-11-12 08:32:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08dab58c-bd53-4793-85de-bd4bd3aa4a35', N'4666f434-3178-42e5-a44f-1f34cadb3c44', N'0', N'1', N'EqpCallRepair', N'故障报修', NULL, N'1', N'EqpCallRepair', N'', NULL, N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2022-10-24 14:55:30.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2022-10-24 14:56:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'EqpCallRepair')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08dab58c-bd53-49c1-8a1e-ff507ece06ab', N'4666f434-3178-42e5-a44f-1f34cadb3c44', N'0', N'1', N'EqpRepairInfo', N'设备维修', NULL, N'1', N'EqpRepairInfo', N'', NULL, N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2022-10-24 14:55:30.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2022-10-24 14:56:42.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'EqpRepairInfo')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08dab58c-bd53-4a2f-8a6b-1403129ee16c', N'4666f434-3178-42e5-a44f-1f34cadb3c44', N'0', N'1', N'EqpRepairRecord', N'维修记录', NULL, N'1', N'EqpRepairRecord', N'', NULL, N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2022-10-24 14:55:30.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2022-10-24 14:57:14.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'EqpRepairRecord')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'094d05bd-f2d8-47c1-989c-76525539b457', N'e093b2d3-ec49-4b4d-91ec-63f57f4e3f1d', N'0', N'1', N'NF-import', N'导入', NULL, N'1', N'import', N'/MaterialManage/TransferBox/Import', NULL, N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2021-01-12 12:14:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-12 12:14:29.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'09711a0c-18c9-42e0-9cc4-ebfbc2745200', N'beaddc98-9037-4fc6-8d21-493fe47f20e8', N'0', N'1', N'TF-add', N'新增', NULL, N'1', N'add', N'/MaterialManage/TransferType/Form', NULL, N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2020-12-14 14:09:39.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-14 14:10:04.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'0a1ba1d7-b4f3-45a4-a4da-e70fb25bb766', N'e9190a56-e173-4483-8a3e-f17b86e4766e', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/InfoManage/Message/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2020-07-29 16:44:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'0b1b307b-2aac-456b-acfb-484a05c71bd7', N'26452c9a-243d-4c81-97b9-a3ad581c3bf4', N'0', N'1', N'NF-edit', N'修改机构', NULL, N'2', N'edit', N'/SystemOrganize/Organize/Form', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', NULL, NULL, N'2020-07-23 10:47:04.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'0cd16e19-6532-4260-abf8-83b8eb32b25b', N'240eb9e4-d5f8-4097-8611-dcdb30c2f49a', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/QualityManage/CheckoutDescription/Form', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2021-05-18 08:18:07.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-05-18 08:18:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'0d777b07-041a-4205-a393-d1a009aaafc7', N'423A200B-FA5F-4B29-B7B7-A3F5474B725F', N'0', N'1', N'NF-edit', N'修改字典', NULL, N'2', N'edit', N'/SystemManage/ItemsData/Form', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, NULL, NULL, N'2016-07-25 15:37:42.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'0e156a57-8133-4d1b-9d0f-9b7554e7b1fc', N'd742c96e-b61c-4cea-afeb-81805789687b', N'0', N'1', N'NF-edit', N'修改分类', NULL, N'2', N'edit', N'/SystemManage/ItemsType/Form', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, NULL, NULL, N'2020-04-27 16:52:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'0eb93272-6e36-4d9e-866b-b238f41a8581', N'a8f0c195-53c5-4b05-b65e-5fafb14a3aec', N'0', N'1', N'NF-Run', N'执行', NULL, N'1', N'Run', N'/ClassTask/ControlJob/RunForm', NULL, N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2021-01-18 14:25:55.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-18 14:26:35.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'0f4d177b-1aa4-4807-a4c2-8d918813ac53', N'25ca371f-9c67-4e0e-9ca7-0dec2e836613', N'0', N'1', N'NF-enabled', N'启用', NULL, N'2', N'enabled', N'/MaterialManage/InStorage/EnabledForm', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2021-01-04 14:11:21.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-04 14:11:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'0fa5e0a8-c786-40af-81af-b133b42dded5', N'262ca754-1c73-436c-a9a2-b6374451a845', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/SystemOrganize/DataPrivilegeRule/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2020-06-01 09:44:58.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-16 08:13:22.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'0fee2019-e009-4047-876a-c2d8a62f9672', N'828084e8-4361-40f2-bd3e-96acb4bc229b', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/RunMonitor/BoardAccount/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2021-01-25 09:03:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'104bcc01-0cfd-433f-87f4-29a8a3efb313', N'423A200B-FA5F-4B29-B7B7-A3F5474B725F', N'0', N'1', N'NF-add', N'新建字典', NULL, N'1', N'add', N'/SystemManage/ItemsData/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, NULL, NULL, N'2016-07-25 15:37:35.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'1191df4c-0593-4ee8-85ab-ad4f3bbc8184', N'beaddc98-9037-4fc6-8d21-493fe47f20e8', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/SystemManage/ItemsData/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2020-12-14 14:09:39.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-14 14:11:53.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'13c9a15f-c50d-4f09-8344-fd0050f70086', N'F298F868-B689-4982-8C8B-9268CBF0308D', N'0', N'1', N'NF-add', N'新建岗位', NULL, N'1', N'add', N'/SystemOrganize/Duty/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', NULL, NULL, N'2020-06-16 08:13:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'14617a4f-bfef-4bc2-b943-d18d3ff8d22f', N'38CA5A66-C993-4410-AF95-50489B22939C', N'0', N'1', N'NF-delete', N'删除用户', NULL, N'2', N'delete', N'/SystemOrganize/User/DeleteForm', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', NULL, NULL, N'2020-06-16 08:14:19.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'15362a59-b242-494a-bc6e-413b4a63580e', N'38CA5A66-C993-4410-AF95-50489B22939C', N'0', N'1', N'NF-disabled', N'禁用', NULL, N'2', N'disabled', N'/SystemOrganize/User/DisabledAccount', N'0', N'0', N'0', N'0', N'6', N'0', N'1', N'', N'2016-07-25 15:25:54.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-16 08:14:30.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'153e4773-7425-403f-abf7-42db13f84c8d', N'c87cd44f-d064-4d3c-a43e-de01a7a8785e', N'0', N'1', N'NF-details', N'进度', NULL, N'2', N'details', N'/FlowManage/Flowinstance/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2020-07-14 09:21:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-07-14 13:58:40.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'16030e33-e405-4c5b-ae20-d875e471fd04', N'7cce1014-5087-4184-9848-77e164be4e17', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/ProcessManage/WorkOrder/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2020-12-07 12:14:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'171f1fa5-6c98-4686-8efa-6534378fb93f', N'79c73d26-6f49-463a-9002-98eba48e36b2', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/MaterialManage/Area/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2020-12-17 08:31:32.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'17a0e46f-28f9-4787-832c-0da25c321ce4', N'7cb65e00-8af2-4cf2-b318-8ba28b3c154e', N'0', N'1', N'NF-download', N'下载', NULL, N'1', N'download', N'/FileManage/Uploadfile/Download', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2020-07-22 12:05:35.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-07-22 14:47:39.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'17d2d452-bf13-42ce-bcff-68d840a4ce78', N'fb087f6b-fa45-43c7-903c-3a80a450ff45', N'0', N'1', N'NF-details', N'查看详细', NULL, N'2', N'details', N'/ProductionReport/Tdreport/TdDetails', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2021-02-05 08:50:36.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-02-04 15:51:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'1a588a3b-95d7-4b3a-b50a-d3bc40de9fe3', N'7cb65e00-8af2-4cf2-b318-8ba28b3c154e', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/FileManage/Uploadfile/Details', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2020-07-22 12:05:35.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-07-22 14:47:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'1b32e4d2-1e93-4b40-b3f6-da20a5957234', N'5391c5c0-55c0-4132-a26d-5d27fcec1c18', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/MaterialManage/Location/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2020-12-17 08:32:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'1b72be70-e44d-43d6-91d0-dc3ad628d22e', N'26452c9a-243d-4c81-97b9-a3ad581c3bf4', N'0', N'1', N'NF-details', N'查看机构', NULL, N'2', N'details', N'/SystemOrganize/Organize/Details', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', NULL, NULL, N'2020-07-23 10:47:15.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'1c97a035-f3ba-4dc5-a711-5fbf87e24c47', N'a620c016-27cb-46f8-86c9-44c197617524', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/EquipmentManage/EqpUser/DeleteForm', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-01-15 11:26:32.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-15 11:26:44.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'1d1e71a6-dd8b-4052-8093-f1d7d347b9bc', N'a303cbe1-60eb-437b-9a69-77ff8b48f173', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/SystemOrganize/SystemSet/Details', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2020-06-12 13:54:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-16 08:12:44.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'1e4f989f-9110-41e9-bfec-302a671d53af', N'79c73d26-6f49-463a-9002-98eba48e36b2', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/MaterialManage/Area/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2020-12-17 08:31:32.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'1ee1c46b-e767-4532-8636-936ea4c12003', N'423A200B-FA5F-4B29-B7B7-A3F5474B725F', N'0', N'1', N'NF-delete', N'删除字典', NULL, N'2', N'delete', N'/SystemManage/ItemsData/DeleteForm', N'0', N'0', N'0', N'0', N'4', N'0', N'1', NULL, NULL, NULL, N'2016-07-25 15:37:53.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'208c2915-d6d0-4bb0-8ec4-154f86561f5a', N'e3188a69-de3a-40ef-a5ff-5eaf460f5d20', N'0', N'1', N'NF-enabled', N'启用', NULL, N'2', N'enabled', N'/SystemSecurity/OpenJobs/ChangeStatus', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2020-05-26 13:55:50.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-05-27 08:42:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'215c648d-f86a-49cc-b0d5-b68cddcff792', N'84e5ec65-f803-485e-b703-4d07eaaf6c05', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/MaterialManage/OutStorage/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2020-12-16 13:39:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'23780fa8-b92c-4c0e-830e-ddcbe6cf4463', N'64A1C550-2C61-4A8C-833D-ACD0C012260F', N'0', N'1', N'NF-modulefields', N'字段管理', NULL, N'2', N'modulefields', N'/SystemManage/ModuleFields/Index', N'0', N'0', N'0', N'0', N'6', N'0', N'1', N'', N'2020-05-21 14:28:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'239077ff-13e1-4720-84e1-67b6f0276979', N'91A6CFAD-B2F9-4294-BDAE-76DECF412C6C', N'0', N'1', N'NF-delete', N'删除角色', NULL, N'2', N'delete', N'/SystemOrganize/Role/DeleteForm', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', NULL, NULL, N'2020-06-16 08:13:39.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'24ba1d09-4675-473e-b429-9d63cc3e50d1', N'fb087f6b-fa45-43c7-903c-3a80a450ff45', N'0', N'1', N'NF-chart', N'曲线分析', NULL, N'2', N'chart', N'/ProductionReport/Tdreport/ChartEnterDialog', N'0', N'0', N'0', N'0', N'6', N'0', N'1', N'', N'2021-03-24 10:26:04.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-03-24 10:25:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'25613ba8-8bb2-4357-a8d4-a558cb85eea3', N'af863666-a357-4e06-bffd-df98e1d29ab8', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/EquipmentManage/Equipment/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2020-11-30 14:05:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'28592383-195f-4911-98ce-c817a8c1a716', N'e093b2d3-ec49-4b4d-91ec-63f57f4e3f1d', N'0', N'1', N'NF-banding', N'物料绑定', NULL, N'1', N'banding', N'/MaterialManage/TransferType/Index', NULL, N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2020-12-14 13:13:21.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-14 14:09:19.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'29306956-f9b2-4e76-bc23-4b8f02d21be3', N'F298F868-B689-4982-8C8B-9268CBF0308D', N'0', N'1', N'NF-import', N'导入', NULL, N'1', N'import', N'/SystemOrganize/Duty/Import', NULL, N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2020-08-12 10:17:30.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-08-12 10:17:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'29421e16-0ddd-466b-8b6f-19980c01c955', N'ed896675-541a-4d34-bf77-29c87d7a26bb', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/MaterialManage/Material/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2020-12-01 14:31:51.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'2a05c5ca-1eb3-4204-86fb-e355d798a535', N'e093b2d3-ec49-4b4d-91ec-63f57f4e3f1d', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/MaterialManage/TransferBox/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2020-12-14 12:44:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'2a8f5342-5eb7-491c-a1a9-a2631d8eb5d6', N'38CA5A66-C993-4410-AF95-50489B22939C', N'0', N'1', N'NF-enabled', N'启用', NULL, N'2', N'enabled', N'/SystemOrganize/User/EnabledAccount', N'0', N'0', N'0', N'0', N'7', N'0', N'1', N'', N'2016-07-25 15:28:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-16 08:14:33.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'2aa1b5c9-57e7-4e1f-bd44-c477fa847d8c', N'7cce1014-5087-4184-9848-77e164be4e17', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/ProcessManage/WorkOrder/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2020-12-07 12:14:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'2cde1cd0-cfc8-4901-96ef-1fe0c8bf997c', N'2c2ddbce-ee87-4134-9b32-54d0bd572910', N'0', N'1', N'NF-view', N'视图模型', NULL, N'1', N'view', N'/SystemManage/Form/Index', NULL, N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2020-07-09 12:06:05.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'2cfa7ae3-260c-4c48-b7fb-3d94861e9cea', N'beaddc98-9037-4fc6-8d21-493fe47f20e8', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/SystemManage/ItemsData/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2020-12-14 14:09:39.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-14 14:12:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'2ec7f52c-43b7-45bb-8714-17511817d1b8', N'e3188a69-de3a-40ef-a5ff-5eaf460f5d20', N'0', N'1', N'NF-log', N'日志', NULL, N'1', N'log', N'/SystemSecurity/OpenJobs/Details', NULL, N'0', N'0', N'0', N'6', N'0', N'1', N'', N'2020-12-02 12:17:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'30bf72ed-f62f-49a9-adfc-49693871605f', N'd742c96e-b61c-4cea-afeb-81805789687b', N'0', N'1', N'NF-details', N'查看分类', NULL, N'2', N'details', N'/SystemManage/ItemsType/Details', N'0', N'0', N'0', N'0', N'5', N'0', N'1', NULL, NULL, NULL, N'2020-04-27 16:52:39.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'310bb831-a46f-4117-9d02-a3e551611dcf', N'e3188a69-de3a-40ef-a5ff-5eaf460f5d20', N'0', N'1', N'NF-delete', N'删除任务', NULL, N'2', N'delete', N'/SystemSecurity/OpenJobs/DeleteForm', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2020-05-26 13:55:50.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-05-26 13:56:35.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'329c0326-ce68-4a24-904d-aade67a90fc7', N'a3a4742d-ca39-42ec-b95a-8552a6fae579', N'0', N'1', N'NF-details', N'查看策略', NULL, N'2', N'details', N'/SystemSecurity/FilterIP/Details', N'0', N'0', N'0', N'0', N'4', N'0', N'1', NULL, NULL, NULL, N'2020-04-17 12:51:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'3440df47-fa09-47c2-abe8-44411985701c', N'ed896675-541a-4d34-bf77-29c87d7a26bb', N'0', N'1', N'NF-eqpbanding', N'设备绑定', NULL, N'1', N'eqpbanding', N'/MaterialManage/MaterialEqp/Index', NULL, N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2020-12-03 08:05:50.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-03 08:14:39.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'34d0a617-86dc-44e1-83fc-815043ac1af4', N'91448822-e10b-4146-b9fe-2669073cc7f1', N'0', N'1', N'OutputMaterial', N'生产产出物料', NULL, N'1', N'OutputMaterial', N'', NULL, N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2021-04-27 16:02:15.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'OutputMaterial')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'352de4d7-1e60-41a8-b983-b79676c6a556', N'ea9864ce-e397-42b0-8819-0680b78fcf4c', N'0', N'1', N'OutStorageBandingCancle', N'出库取消装箱', NULL, N'1', N'OutStorageBandingCancle', N'', NULL, N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2021-04-27 16:06:57.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'OutStorageBandingCancle')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'35fc1b7c-40b0-42b8-a0f9-c67087566289', N'f82fd629-5f3a-45d6-8681-5ec47e66a807', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/SystemManage/Flowscheme/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2020-07-10 08:50:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'38e39592-6e86-42fb-8f72-adea0c82cbc1', N'38CA5A66-C993-4410-AF95-50489B22939C', N'0', N'1', N'NF-revisepassword', N'密码重置', NULL, N'2', N'revisepassword', N'/SystemOrganize/User/RevisePassword', N'0', N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2016-07-25 14:18:19.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-16 08:14:26.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'398edf66-1ca8-4519-b2a7-f202008901c7', N'badc3ee2-fcbb-43ae-9efe-2309f8a63834', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/MaterialManage/MaterialEqp/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2020-12-02 16:23:53.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-02 16:24:17.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'39fce29e-2dac-4340-a9ea-1034e0ede28f', N'39fce29e-2d24-934c-432b-87fda7e92d81', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/ClassTask/ControlJobUserBanding/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2021-06-03 13:55:59.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'39fce29e-2dac-c882-a2ae-efe34a55a09f', N'39fce29e-2d24-934c-432b-87fda7e92d81', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/ClassTask/ControlJobUserBanding/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2021-06-03 13:55:59.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'39fce31f-fd77-2934-0b3d-74948cf3d490', N'39fce29e-2d24-934c-432b-87fda7e92d81', N'0', N'1', N'NF-clonebutton', N'克隆按人员', NULL, N'2', N'clonebutton', N'/ClassTask/ControlJobUserBanding/CloneForm', N'0', N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2021-06-03 16:17:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-06-08 09:57:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'3a2b4848-3749-486a-8986-5f7efe10e4d4', N'3108dc9a-a476-4709-be34-1b8ee82d54d6', N'0', N'1', N'NF-chart', N'曲线分析', NULL, N'2', N'chart', N'/ProductionReport/HotlineData/Chart', N'0', N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2021-02-03 09:39:31.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-02-02 12:43:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'3a35c662-a356-45e4-953d-00ebd981cad6', N'96EE855E-8CD2-47FC-A51D-127C131C9FB9', N'0', N'1', N'NF-add', N'清空日志', NULL, N'1', N'add', N'/SystemSecurity/Log/RemoveLog', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', NULL, NULL, N'2021-02-26 13:19:54.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'3c20ddc2-8a64-4d3f-bd39-ffcc36dc69c5', N'e093b2d3-ec49-4b4d-91ec-63f57f4e3f1d', N'0', N'1', N'NF-return', N'退回', NULL, N'1', N'return', N'/MaterialManage/TransferBox/ReturnForm', NULL, N'0', N'0', N'0', N'7', N'0', N'1', N'', N'2021-02-09 13:26:07.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'3c8bc8ed-4cc4-43bc-accd-d4acb2a0358d', N'30c629a0-910e-404b-8c29-a73a6291fd95', N'0', N'1', N'NF-details', N'查看日志', NULL, N'2', N'details', N'/SystemSecurity/AppLog/Details', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2020-07-08 10:41:26.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-30 15:42:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'3d0e99d1-a150-43dc-84ae-f0e2e0ad2217', N'ed757a25-82d5-43cc-89f4-ed26a51fb4f0', N'0', N'1', N'NF-edit', N'修改按钮', NULL, N'2', N'edit', N'/SystemManage/ModuleButton/Form', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, NULL, NULL, N'2020-04-27 16:57:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'3f69d32f-cb3b-4fa0-863b-98b9a090d7e9', N'7e4e4a48-4d51-4159-a113-2a211186f13a', N'0', N'1', N'NF-add', N'新建公告', NULL, N'1', N'add', N'/SystemOrganize/Notice/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', NULL, NULL, N'2020-06-16 08:12:18.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'43e09a61-c2b0-46c1-9b81-76d686b390d4', N'ed757a25-82d5-43cc-89f4-ed26a51fb4f0', N'0', N'1', N'NF-clonebutton', N'克隆按钮', NULL, N'1', N'clonebutton', N'/SystemManage/ModuleButton/CloneButton', N'0', N'0', N'0', N'0', N'5', N'0', N'1', NULL, N'2020-04-28 09:54:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-05-11 14:55:36.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'44ac9a8e-f4ac-4b6c-ab1a-8723da6ea36a', N'4666f434-3178-42e5-a44f-1f34cadb3c43', N'0', N'1', N'GetStorage', N'库存查询', NULL, N'1', N'GetStorage', N'', NULL, N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-04-27 16:08:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'GetStorage')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'45a11ce3-c470-4dad-b5ed-189f8efcadf3', N'2ffc3301-8ec2-4157-a4c3-232797aae120', N'0', N'1', N'NF-Run', N'执行', NULL, N'1', N'Run', N'/ProcessManage/WorkOrderRun/Form', NULL, N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2020-12-09 08:33:22.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'4727adf7-5525-4c8c-9de5-39e49c268349', N'38CA5A66-C993-4410-AF95-50489B22939C', N'0', N'1', N'NF-edit', N'修改用户', NULL, N'2', N'edit', N'/SystemOrganize/User/Form', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', NULL, NULL, N'2020-06-16 08:14:16.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'4748945e-e179-483e-b14a-7cc29cc18ab6', N'7cce1014-5087-4184-9848-77e164be4e17', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/ProcessManage/WorkOrder/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2020-12-07 12:14:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'482b1be7-10c2-4ca0-9efd-dcbb15396466', N'788d27cb-598d-41da-ac11-b7ddf0914b08', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/DingTalkManage/DingTalkConfig/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2020-11-21 09:55:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'48679ba7-74ef-48ae-9de1-e9fc2eae7621', N'7cce1014-5087-4184-9848-77e164be4e17', N'0', N'1', N'NF-flow', N'流程', NULL, N'2', N'flow', N'/ProcessManage/WorkOrder/Flow', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2021-01-08 12:22:09.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-11 12:12:47.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'491df014-bc06-4d49-bbb5-2235b5436836', N'5391c5c0-55c0-4132-a26d-5d27fcec1c18', N'0', N'1', N'NF-print', N'打印', NULL, N'1', N'print', N'print', NULL, N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2021-01-14 14:29:34.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-14 14:29:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'4b876abc-1b85-47b0-abc7-96e313b18ed8', N'423A200B-FA5F-4B29-B7B7-A3F5474B725F', N'0', N'1', N'NF-itemstype', N'分类管理', NULL, N'1', N'itemstype', N'/SystemManage/ItemsType/Index', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2016-07-25 15:36:21.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-04-07 14:33:58.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'4bb19533-8e81-419b-86a1-7ee56bf1dd45', N'252229DB-35CA-47AE-BDAE-C9903ED5BA7B', N'0', N'1', N'NF-delete', N'删除机构', NULL, N'2', N'delete', N'/SystemManage/Organize/DeleteForm', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, NULL, NULL, N'2020-04-07 14:22:56.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'4c794628-9b09-4d60-8fb5-63c1a37b2b60', N'2c2ddbce-ee87-4134-9b32-54d0bd572910', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/SystemManage/Form/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2020-07-08 14:34:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'4d559146-7425-4e67-b02d-f16c41eb481a', N'e093b2d3-ec49-4b4d-91ec-63f57f4e3f1d', N'0', N'1', N'NF-print', N'打印', NULL, N'1', N'print', N'print', NULL, N'0', N'0', N'0', N'6', N'0', N'1', N'', N'2021-01-13 14:23:19.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-13 14:23:40.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'4e044eb2-a753-4e99-a1af-a707a3475fc5', N'0a479fd4-57ca-46db-a8bf-c30d5871b1f9', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/ClassTask/ControlJobPlaner/DeleteForm', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-01-18 14:53:55.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-18 14:54:11.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'4e44d96b-bd7d-4634-bfe4-9fe2aeec8592', N'8968b428-2a8b-4dbe-ad47-73dd408ddd5e', N'0', N'1', N'TF-delete', N'设备-删除', NULL, N'1', N'delete', N'/ProcessManage/ProcessFlow/DeleteForm', NULL, N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2020-12-03 11:22:39.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-06 09:13:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'4e97842e-3b1f-44fc-ba0f-bddf9449a44a', N'0bddfade-d5b4-46c3-b0b6-45fb9f728e38', N'0', N'1', N'NF-add', N'清空记录', NULL, N'1', N'add', N'/ReportRecord/ReturnMaterialReport/Fotm', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-03-09 14:40:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-03-09 14:40:04.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'4f727b61-0aa4-45f0-83b5-7fcddfe034e8', N'ed757a25-82d5-43cc-89f4-ed26a51fb4f0', N'0', N'1', N'NF-delete', N'删除按钮', NULL, N'2', N'delete', N'/SystemManage/ModuleButton/DeleteForm', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, NULL, NULL, N'2020-04-27 16:57:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'5084abcf-21ec-4edf-bf9f-513bb17514d9', N'eeb05603-45d5-4205-88fc-0fe60357710d', N'0', N'1', N'InStorageBanding', N'入库绑定', NULL, N'1', N'InStorageBanding', N'', NULL, N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-04-27 16:05:04.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'InStorageBanding')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'50a6975c-48e2-45d3-932b-8c7423dcc2be', N'af863666-a357-4e06-bffd-df98e1d29ab8', N'0', N'1', N'NF-banding', N'区域绑定', NULL, N'1', N'banding', N'/EquipmentManage/EqpArea/Index', NULL, N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2020-12-17 11:17:51.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-17 11:19:31.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'51eb09eb-09be-44ab-82be-10c2e3d1c482', N'91448822-e10b-4146-b9fe-2669073cc7f1', N'0', N'1', N'ReturnMaterialJob', N'生产退料申请', NULL, N'1', N'ReturnMaterialJob', N'', NULL, N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-04-27 16:00:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'ReturnMaterialJob')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'52613262-e95b-4f2c-b339-d75e9dbf03b2', N'af863666-a357-4e06-bffd-df98e1d29ab8', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/EquipmentManage/Equipment/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2020-11-30 14:05:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'551df1d7-f8fc-4a4e-a34d-5691b589c5c4', N'af863666-a357-4e06-bffd-df98e1d29ab8', N'0', N'1', N'NF-materialbanding', N'物料绑定', NULL, N'1', N'NF-materialbanding', N'/EquipmentManage/Equipment/MaterialForm', NULL, N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2021-01-15 11:02:07.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-07-22 11:27:11.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'55cc5aba-8121-4151-8df5-f6846396d1a3', N'2c2ddbce-ee87-4134-9b32-54d0bd572910', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/SystemManage/Form/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2020-07-08 14:34:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'56376d1f-3244-48c8-b5ff-c25793f0811e', N'25b77622-ff89-47d2-b0b4-c8c8a7ff74d9', N'0', N'1', N'NF-add', N'清空记录', NULL, N'1', N'add', N'/ReportRecord/ConsumeReport/Fotm', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-03-09 14:40:28.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-03-09 14:40:32.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'572c3ed8-94e8-4d5e-a0b7-324732f718f8', N'2ffc3301-8ec2-4157-a4c3-232797aae120', N'0', N'1', N'NF-Over', N'结束', NULL, N'1', N'Over', N'/ProcessManage/WorkOrderRun/OverForm', NULL, N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2020-12-21 14:45:19.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'5c1265c0-e72a-4bdc-a5be-2515d6afc107', N'fb087f6b-fa45-43c7-903c-3a80a450ff45', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/ProductionReport/Tdreport/DeleteForm', N'0', N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2021-03-24 10:24:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-02-05 08:51:39.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'5c321b1f-4f56-4276-a1aa-dd23ce12a1fc', N'c87cd44f-d064-4d3c-a43e-de01a7a8785e', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/FlowManage/Flowinstance/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2020-07-14 09:21:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'5d708d9d-6ebe-40ea-8589-e3efce9e74ec', N'91A6CFAD-B2F9-4294-BDAE-76DECF412C6C', N'0', N'1', N'NF-add', N'新建角色', NULL, N'1', N'add', N'/SystemOrganize/Role/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', NULL, NULL, N'2020-06-16 08:13:32.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'60e3aef8-126d-4bde-a8b5-6b378a1fa9f6', N'beaddc98-9037-4fc6-8d21-493fe47f20e8', N'0', N'1', N'TF-delete', N'删除', NULL, N'1', N'delete', N'/MaterialManage/TransferType/DeleteForm', NULL, N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2020-12-14 14:09:39.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-14 14:10:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'61a54b03-776d-460b-91b5-9b048ea8a15d', N'a8f0c195-53c5-4b05-b65e-5fafb14a3aec', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/ClassTask/ControlJob/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2021-01-15 14:19:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'62442d35-234d-4ca1-9105-68ed5a8b4e11', N'3108dc9a-a476-4709-be34-1b8ee82d54d6', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/ProductionReport/HotlineData/Details', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2021-02-02 12:42:18.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-29 10:27:07.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'634d0a2e-d274-4d9a-8fa4-d910f1d0eb2c', N'828084e8-4361-40f2-bd3e-96acb4bc229b', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/RunMonitor/BoardAccount/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2021-01-25 09:03:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'63cd2162-ab5f-4b7f-9bbd-5c2e7625e639', N'152a8e93-cebb-4574-ae74-2a86595ff986', N'0', N'1', N'NF-details', N'查看字段', NULL, N'2', N'details', N'/SystemManage/ModuleFields/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2020-05-21 14:39:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-05-21 15:11:22.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'641fd85a-96a6-4801-9385-b27fa5d3e564', N'b5ff9591-f939-41c0-8c68-3b9c2fe02bdd', N'0', N'1', N'CheckoutJob', N'质检申请', NULL, N'1', N'CheckoutJob', N'', NULL, N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-05-26 09:22:49.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'CheckoutJob')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'6453cb3c-c527-4f74-a09f-48c3d26b5863', N'e093b2d3-ec49-4b4d-91ec-63f57f4e3f1d', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/MaterialManage/TransferBox/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2020-12-14 12:44:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'66fdc1a7-327a-42bd-97e8-8dcfb6212e8c', N'84e5ec65-f803-485e-b703-4d07eaaf6c05', N'0', N'1', N'NF-disabled', N'终止', NULL, N'2', N'disabled', N'/MaterialManage/OutStorage/DisabledForm', N'0', N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2021-01-04 14:32:43.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-04 14:33:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'67dac5bd-b923-43f0-9b29-a850ec8d356e', N'ed896675-541a-4d34-bf77-29c87d7a26bb', N'0', N'1', N'NF-print', N'打印', NULL, N'1', N'print', N'print', NULL, N'0', N'0', N'0', N'7', N'0', N'1', N'', N'2021-01-14 14:30:15.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-14 14:30:21.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'67e487ea-f49b-4f86-ad1e-f31248f461a8', N'25ca371f-9c67-4e0e-9ca7-0dec2e836613', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/MaterialManage/InStorage/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2020-12-16 13:38:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'6b3aa51b-7590-471a-bd84-49e6589c1f32', N'8968b428-2a8b-4dbe-ad47-73dd408ddd5e', N'0', N'1', N'NF-details', N'工序-查看', NULL, N'2', N'details', N'/ProcessManage/ProcessFlow/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2020-12-03 09:49:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-06 09:13:26.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'6f872aa0-1aae-4f42-a3ba-a61079057749', N'e9190a56-e173-4483-8a3e-f17b86e4766e', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/InfoManage/Message/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2020-07-29 16:44:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'709a4a7b-4d98-462d-b47c-351ef11db06f', N'252229DB-35CA-47AE-BDAE-C9903ED5BA7B', N'0', N'1', N'NF-Details', N'查看机构', NULL, N'2', N'details', N'/SystemManage/Organize/Details', N'0', N'0', N'0', N'0', N'4', N'0', N'1', NULL, NULL, NULL, N'2020-04-07 14:23:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'73ac1957-7558-49f6-8642-59946d05b8e6', N'f82fd629-5f3a-45d6-8681-5ec47e66a807', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/SystemManage/Flowscheme/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2020-07-10 08:50:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'746629aa-858b-4c5e-9335-71b0fa08a584', N'ed757a25-82d5-43cc-89f4-ed26a51fb4f0', N'0', N'1', N'NF-details', N'查看按钮', NULL, N'2', N'details', N'/SystemManage/ModuleButton/Details', N'0', N'0', N'0', N'0', N'4', N'0', N'1', NULL, NULL, NULL, N'2020-04-27 17:37:40.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'74eecdfb-3bee-405d-be07-27a78219c179', N'38CA5A66-C993-4410-AF95-50489B22939C', N'0', N'1', N'NF-add', N'新建用户', NULL, N'1', N'add', N'/SystemOrganize/User/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', NULL, NULL, N'2020-06-16 08:14:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'7667ca4d-9f37-48af-9c2e-a11801c0ae33', N'38CA5A66-C993-4410-AF95-50489B22939C', N'0', N'1', N'NF-dingcancle', N'钉钉清除', NULL, N'1', N'dingcancle', N'/SystemOrganize/User/DingCancle', NULL, N'0', N'0', N'0', N'8', N'0', N'1', N'', N'2020-11-19 16:38:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'772eb88a-5f67-4bb1-a122-0c83a2bdb5ef', N'c87cd44f-d064-4d3c-a43e-de01a7a8785e', N'0', N'1', N'NF-add', N'申请', NULL, N'1', N'add', N'/FlowManage/Flowinstance/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2020-07-14 09:21:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-07-14 13:58:30.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'7e10a7ac-8b65-4c7c-8eee-92d69d7dcbd9', N'26452c9a-243d-4c81-97b9-a3ad581c3bf4', N'0', N'1', N'NF-add', N'新建机构', NULL, N'1', N'add', N'/SystemOrganize/Organize/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', NULL, NULL, N'2020-07-23 10:46:58.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'7ee3ff62-ab18-4886-9451-89b1d152172e', N'7e4e4a48-4d51-4159-a113-2a211186f13a', N'0', N'1', N'NF-details', N'查看公告', NULL, N'2', N'details', N'/SystemOrganize/Notice/Details', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', NULL, NULL, N'2020-06-16 08:12:28.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'7f57c359-0c70-414f-9446-55faf534f204', N'5391c5c0-55c0-4132-a26d-5d27fcec1c18', N'0', N'1', N'NF-import', N'导入', NULL, N'1', N'import', N'/MaterialManage/Location/Import', NULL, N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2021-02-02 08:54:16.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-02-02 08:57:24.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'810a68f6-40cb-413c-b351-d065173bd6f7', N'84e5ec65-f803-485e-b703-4d07eaaf6c05', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/MaterialManage/OutStorage/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2020-12-16 13:39:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'815d472a-abdf-448e-bc67-172123ba60df', N'beaddc98-9037-4fc6-8d21-493fe47f20e8', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/SystemManage/ItemsData/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2020-12-14 14:09:39.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-14 14:11:34.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'8187bc3a-d003-45e5-9327-7e7267d24fcd', N'ed896675-541a-4d34-bf77-29c87d7a26bb', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/MaterialManage/Material/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2020-12-01 14:31:51.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'81a8dd98-9ad6-4dcd-b878-25560a7f59f0', N'3108dc9a-a476-4709-be34-1b8ee82d54d6', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/ProductionReport/HotlineData/DeleteForm', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2021-01-29 10:25:07.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-29 10:27:02.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'81c01c51-304c-43a0-aee1-4fc096c58892', N'828084e8-4361-40f2-bd3e-96acb4bc229b', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/RunMonitor/BoardAccount/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2021-01-25 09:03:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'822b37d6-3d6a-463b-93fb-fe06f43d90e0', N'af863666-a357-4e06-bffd-df98e1d29ab8', N'0', N'1', N'NF-print', N'打印', NULL, N'1', N'print', N'print', NULL, N'0', N'0', N'0', N'6', N'0', N'1', N'', N'2021-01-14 14:31:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-15 11:02:16.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'82b2f4a2-55a1-4f44-b667-3449739643f6', N'262ca754-1c73-436c-a9a2-b6374451a845', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/SystemOrganize/DataPrivilegeRule/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2020-06-01 09:44:58.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-16 08:13:18.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'82f162cb-beb9-4a79-8924-cd1860e26e2e', N'423A200B-FA5F-4B29-B7B7-A3F5474B725F', N'0', N'1', N'NF-details', N'查看字典', NULL, N'2', N'details', N'/SystemManage/ItemsData/Details', N'0', N'0', N'0', N'0', N'5', N'0', N'1', NULL, NULL, NULL, N'2020-04-17 12:50:57.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'832f5195-f3ab-4683-82ad-a66a71735ffc', N'2c2ddbce-ee87-4134-9b32-54d0bd572910', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/SystemManage/Form/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2020-07-08 14:34:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'83690e2c-43f0-489f-9481-4b72ad828d4e', N'4666f434-3178-42e5-a44f-1f34cadb3c43', N'0', N'1', N'StorageChange', N'流转箱转移', NULL, N'1', N'StorageChange', N'', NULL, N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2021-04-27 16:09:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'StorageChange')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'8379135e-5b13-4236-bfb1-9289e6129034', N'a3a4742d-ca39-42ec-b95a-8552a6fae579', N'0', N'1', N'NF-delete', N'删除策略', NULL, N'2', N'delete', N'/SystemSecurity/FilterIP/DeleteForm', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, NULL, NULL, N'2016-07-25 15:57:57.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'84445468-0716-400e-8072-100a292246b6', N'84e5ec65-f803-485e-b703-4d07eaaf6c05', N'0', N'1', N'NF-print', N'打印', NULL, N'2', N'print', N'print', NULL, N'0', N'0', N'0', N'6', N'0', N'1', N'', N'2021-03-29 08:38:39.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-03-29 08:38:54.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'85bfbb9d-24f0-4a6f-8bb8-0f87826d04fa', N'152a8e93-cebb-4574-ae74-2a86595ff986', N'0', N'1', N'NF-add', N'新增字段', NULL, N'1', N'add', N'/SystemManage/ModuleFields/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2020-05-21 14:39:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-05-21 15:38:53.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'85F5212F-E321-4124-B155-9374AA5D9C10', N'64A1C550-2C61-4A8C-833D-ACD0C012260F', N'0', N'1', N'NF-delete', N'删除菜单', NULL, N'2', N'delete', N'/SystemManage/Module/DeleteForm', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, NULL, NULL, N'2016-07-25 15:41:15.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'87068c95-42c8-4f20-b786-27cb9d3d5ff7', N'e3188a69-de3a-40ef-a5ff-5eaf460f5d20', N'0', N'1', N'NF-add', N'新建任务', NULL, N'1', N'add', N'/SystemSecurity/OpenJobs/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2020-05-26 13:55:50.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-05-26 13:56:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'88f7b3a8-fd6d-4f8e-a861-11405f434868', N'F298F868-B689-4982-8C8B-9268CBF0308D', N'0', N'1', N'NF-details', N'查看岗位', NULL, N'2', N'details', N'/SystemOrganize/Duty/Details', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', NULL, NULL, N'2020-06-16 08:14:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'897b1de8-3710-439f-b252-b1d6d06a082c', N'4666f434-3178-42e5-a44f-1f34cadb3c43', N'0', N'1', N'StorageMove', N'流转箱移库', NULL, N'1', N'StorageMove', N'', NULL, N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2021-04-27 16:09:29.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'StorageMove')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'89c915bb-35f7-47dc-a206-9deae36b34db', N'a8f0c195-53c5-4b05-b65e-5fafb14a3aec', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/ClassTask/ControlJob/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2021-01-15 14:19:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'8a9993af-69b2-4d8a-85b3-337745a1f428', N'F298F868-B689-4982-8C8B-9268CBF0308D', N'0', N'1', N'NF-delete', N'删除岗位', NULL, N'2', N'delete', N'/SystemOrganize/Duty/DeleteForm', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', NULL, NULL, N'2020-06-16 08:13:58.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'8c0df9a6-af02-4450-bab8-226755f1a806', N'240eb9e4-d5f8-4097-8611-dcdb30c2f49a', N'0', N'1', N'NF-add', N'新建', NULL, N'1', N'add', N'/QualityManage/CheckoutDescription/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-05-18 08:18:07.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-05-18 08:18:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'8c4cdddd-24b2-4fb0-9cb3-86273a476d0a', N'788d27cb-598d-41da-ac11-b7ddf0914b08', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/DingTalkManage/DingTalkConfig/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2020-11-21 09:55:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'8f32069f-20f3-48c9-8e35-cd245fffcf64', N'01849cc9-c6da-4184-92f8-34875dac1d42', N'0', N'1', N'NF-add', N'模板生成', NULL, N'2', N'add', N'/SystemManage/CodeGenerator/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', NULL, NULL, N'2020-07-23 15:36:31.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'8f698747-a1c3-468d-9279-99990987e0f9', N'7e4e4a48-4d51-4159-a113-2a211186f13a', N'0', N'1', N'NF-delete', N'删除公告', NULL, N'2', N'delete', N'/SystemOrganize/Notice/DeleteForm', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', NULL, NULL, N'2021-04-27 14:54:40.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'90e52c1e-8fbd-4169-95ed-747f1dccfcf9', N'8968b428-2a8b-4dbe-ad47-73dd408ddd5e', N'0', N'1', N'NF-edit', N'工序-修改', NULL, N'2', N'edit', N'/ProcessManage/ProcessFlow/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2020-12-03 09:49:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-06 09:13:18.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'91260897-df2c-4228-8323-d42795faaf90', N'84e5ec65-f803-485e-b703-4d07eaaf6c05', N'0', N'1', N'NF-enabled', N'启用', NULL, N'2', N'enabled', N'/MaterialManage/OutStorage/EnabledForm', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2021-01-04 14:32:43.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-04 14:32:53.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'91be873e-ccb7-434f-9a3b-d312d6d5798a', N'252229DB-35CA-47AE-BDAE-C9903ED5BA7B', N'0', N'1', N'NF-edit', N'修改机构', NULL, N'2', N'edit', N'/SystemManage/Organize/Form', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, NULL, NULL, N'2020-04-07 14:22:50.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'91d768bb-fb68-4807-b3b6-db355bdd6e09', N'2c2ddbce-ee87-4134-9b32-54d0bd572910', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/SystemManage/Form/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2020-07-08 14:34:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'9230de13-fb93-43f3-9c27-17bc0f950717', N'd9078b9a-5db6-4429-b489-3700e56f367f', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/SystemManage/PrintTemplate/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2021-01-14 13:24:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'923e066d-a552-450c-af6f-1ced15a71308', N'25ca371f-9c67-4e0e-9ca7-0dec2e836613', N'0', N'1', N'NF-disabled', N'终止', NULL, N'2', N'disabled', N'/MaterialManage/InStorage/DisabledForm', N'0', N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2021-01-04 14:11:21.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-04 14:12:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'926ae4a9-0ecb-4d5e-a66e-5bae15ae27c2', N'a303cbe1-60eb-437b-9a69-77ff8b48f173', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/SystemOrganize/SystemSet/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2020-06-12 13:54:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-16 08:12:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'957a355d-d931-40f6-9da0-dddfd9135fe0', N'e9190a56-e173-4483-8a3e-f17b86e4766e', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/InfoManage/Message/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2020-07-29 16:44:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'95c46c7a-41d9-45ad-8633-913bece2fafe', N'ed896675-541a-4d34-bf77-29c87d7a26bb', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/MaterialManage/Material/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2020-12-01 14:31:51.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'9685d895-e557-4212-8afb-c9b4170faeaf', N'828084e8-4361-40f2-bd3e-96acb4bc229b', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/RunMonitor/BoardAccount/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2021-01-25 09:03:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'98c2519c-b39f-4bf3-9543-5cc2630a4bbd', N'152a8e93-cebb-4574-ae74-2a86595ff986', N'0', N'1', N'NF-clonefields', N'克隆字段', NULL, N'1', N'clonefields', N'/SystemManage/ModuleFields/CloneFields', N'0', N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2020-05-21 15:39:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-05-21 15:40:35.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'9a908e26-f348-45d1-a470-15d20f798a84', N'e093b2d3-ec49-4b4d-91ec-63f57f4e3f1d', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/MaterialManage/TransferBox/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2020-12-14 12:44:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'9fc77888-bbca-4996-9240-a0f389819f6f', N'7e4e4a48-4d51-4159-a113-2a211186f13a', N'0', N'1', N'NF-edit', N'修改公告', NULL, N'2', N'edit', N'/SystemOrganize/Notice/Form', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', NULL, NULL, N'2020-06-16 08:12:21.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'9FD543DB-C5BB-4789-ACFF-C5865AFB032C', N'64A1C550-2C61-4A8C-833D-ACD0C012260F', N'0', N'1', N'NF-add', N'新增菜单', NULL, N'1', N'add', N'/SystemManage/Module/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, NULL, NULL, N'2016-07-25 15:41:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'a2d11fb0-767d-4ed6-8f7d-7e2f2d47a7cb', N'a2cae27f-0b49-4181-8760-4be3a3560988', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/ClassTask/ControlJob/Details', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-01-18 14:30:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-19 08:41:24.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'a361156a-db2c-40b9-8449-189ce27da27c', N'ea9864ce-e397-42b0-8819-0680b78fcf4c', N'0', N'1', N'OutStorageBanding', N'出库装箱', NULL, N'1', N'OutStorageBanding', N'', NULL, N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-04-27 16:06:36.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'OutStorageBanding')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'a3a37705-a4cb-4f26-b247-dfc68e00046d', N'8968b428-2a8b-4dbe-ad47-73dd408ddd5e', N'0', N'1', N'NF-add', N'工序-新增', NULL, N'1', N'add', N'/ProcessManage/ProcessFlow/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2020-12-03 09:49:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-06 09:13:14.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'a525955f-81ad-4521-849a-dbc355531883', N'b5ff9591-f939-41c0-8c68-3b9c2fe02bdd', N'0', N'1', N'TwoCheckout', N'二次质检', NULL, N'1', N'TwoCheckout', N'', NULL, N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2021-05-26 09:23:55.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'TwoCheckout')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'a5c8f6ff-1f2b-4827-88e3-e7af141af6f5', N'0a479fd4-57ca-46db-a8bf-c30d5871b1f9', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/ClassTask/ControlJobPlaner/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-01-18 14:53:55.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-18 14:54:16.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'a9bd165e-2ab0-4463-b054-586d2c0a93f2', N'3108dc9a-a476-4709-be34-1b8ee82d54d6', N'0', N'1', N'NF-cpk', N'Cpk分析', NULL, N'2', N'cpk', N'/ProductionReport/HotlineData/CpkEnterDialog', N'0', N'0', N'0', N'0', N'6', N'0', N'1', N'', N'2021-01-29 10:25:07.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-02-03 09:42:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'aadb4281-3b01-4cfa-9398-767ad60a8703', N'ea9864ce-e397-42b0-8819-0680b78fcf4c', N'0', N'1', N'OutStorage', N'产品出库', NULL, N'1', N'OutStorage', N'', NULL, N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-04-27 16:06:16.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'OutStorage')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'aaf58c1b-4af2-4e5f-a3e4-c48e86378191', N'a3a4742d-ca39-42ec-b95a-8552a6fae579', N'0', N'1', N'NF-edit', N'修改策略', NULL, N'2', N'edit', N'/SystemSecurity/FilterIP/Form', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, NULL, NULL, N'2016-07-25 15:57:49.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'ab68803e-02ed-4abf-907a-b5878da021fb', N'788d27cb-598d-41da-ac11-b7ddf0914b08', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/DingTalkManage/DingTalkConfig/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2020-11-21 09:55:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'abfdff21-8ebf-4024-8555-401b4df6acd9', N'38CA5A66-C993-4410-AF95-50489B22939C', N'0', N'1', N'NF-details', N'查看用户', NULL, N'2', N'details', N'/SystemOrganize/User/Details', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', NULL, NULL, N'2020-06-16 08:14:22.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'ac332167-9f87-4d0a-9c0d-0fadd1bfda50', N'a083a171-932a-48b8-b053-13f9b39d555a', N'0', N'1', N'OutputMaterialLocation', N'物流产出上架', NULL, N'1', N'OutputMaterialLocation', N'', NULL, N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2021-04-27 16:04:26.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'OutputMaterialLocation')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'ad02b7e4-b558-47a4-852d-b141e8ef27aa', N'5391c5c0-55c0-4132-a26d-5d27fcec1c18', N'0', N'1', N'NF-banding', N'绑定物料', NULL, N'2', N'banding', N'/MaterialManage/Location/AddForm', NULL, N'0', N'0', N'0', N'6', N'0', N'1', N'', N'2021-04-12 14:45:19.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'ae2cb069-b8f9-4e33-ac9c-10766c5b8a0a', N'3108dc9a-a476-4709-be34-1b8ee82d54d6', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/ProductionReport/HotlineData/Form', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2021-01-29 10:25:07.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-29 10:26:55.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'aef967fa-e331-4891-b26e-ad4161b60150', N'b26cea9c-21ba-42fa-98fc-b8fe0b92451d', N'0', N'1', N'NF-print', N'打印', NULL, N'1', N'print', N'/QualityManage/NeedCheck/PrinterForm', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-05-27 12:39:31.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-07-05 08:43:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'af3ce4e5-ae06-4558-a01b-a6b031c31bfd', N'79c73d26-6f49-463a-9002-98eba48e36b2', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/MaterialManage/Area/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2020-12-17 08:31:32.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'afa6eb2a-9477-4c91-816a-652dce303675', N'84e5ec65-f803-485e-b703-4d07eaaf6c05', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/MaterialManage/OutStorage/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2020-12-16 13:39:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'afa9fd66-a535-4fe0-940e-34f413c98355', N'5391c5c0-55c0-4132-a26d-5d27fcec1c18', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/MaterialManage/Location/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2020-12-17 08:32:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'b07d18b7-8f32-4fe8-a402-f1df22b70ef8', N'25ca371f-9c67-4e0e-9ca7-0dec2e836613', N'0', N'1', N'NF-print', N'打印', NULL, N'2', N'print', N'print', NULL, N'0', N'0', N'0', N'6', N'0', N'1', N'', N'2021-03-29 08:38:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-03-29 08:39:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'b2d222c3-ea50-4cb6-b05f-eadd4ab68c04', N'a8f0c195-53c5-4b05-b65e-5fafb14a3aec', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/ClassTask/ControlJob/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2021-01-15 14:19:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'b2f7f312-86c7-416a-86a4-c6409e786b11', N'ed896675-541a-4d34-bf77-29c87d7a26bb', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/MaterialManage/Material/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2020-12-01 14:31:51.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'b4be6eee-3509-4685-8064-34b9cacc690a', N'ee136db7-178a-4bb0-b878-51287a5e2e2b', N'0', N'1', N'NF-details', N'进度', NULL, N'2', N'details', N'/FlowManage/Flowinstance/Details', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2020-07-15 15:05:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-07-15 15:04:15.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'b55330a1-3190-4cee-aba5-e60a9b515817', N'ed896675-541a-4d34-bf77-29c87d7a26bb', N'0', N'1', N'NF-bombanding', N'工序绑定', NULL, N'1', N'bombanding', N'/MaterialManage/MaterialBom/Index', NULL, N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2020-12-03 09:26:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-03 14:41:36.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'b6f741f3-53a1-4dfb-9cd8-cd24da010e1c', N'79c73d26-6f49-463a-9002-98eba48e36b2', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/MaterialManage/Area/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2020-12-17 08:31:32.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'b6fb6da1-ee60-4635-98d5-ccc48a6ea790', N'788d27cb-598d-41da-ac11-b7ddf0914b08', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/DingTalkManage/DingTalkConfig/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2020-11-21 09:55:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'b70177e4-40b6-4221-8807-f081310d5540', N'84e5ec65-f803-485e-b703-4d07eaaf6c05', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/MaterialManage/OutStorage/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2020-12-16 13:39:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'b7bf4423-23f7-495f-8f09-a402e3e3cfc8', N'83d761e9-4ab8-45db-a9ce-32bc148b6922', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/EquipmentManage/EqpArea/DeleteForm', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2020-12-17 11:22:40.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-17 11:23:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'b83c84e4-6264-4b8e-b319-a49fbf34860d', N'262ca754-1c73-436c-a9a2-b6374451a845', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/SystemOrganize/DataPrivilegeRule/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2020-06-01 09:44:58.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-16 08:13:15.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'b88f2b75-0d9a-4400-8a15-0df5bec263a5', N'beaddc98-9037-4fc6-8d21-493fe47f20e8', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/SystemManage/ItemsData/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2020-12-14 14:09:39.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-14 14:11:47.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'b8939694-f8e9-4931-a7bd-7114e7170c80', N'25ca371f-9c67-4e0e-9ca7-0dec2e836613', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/MaterialManage/InStorage/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2020-12-16 13:38:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'ba72435b-1185-4108-8020-7310c5a70233', N'01849cc9-c6da-4184-92f8-34875dac1d42', N'0', N'1', N'NF-details', N'查看数据表', NULL, N'2', N'details', N'/SystemManage/CodeGenerator/Details', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, NULL, NULL, N'2020-05-06 13:12:42.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'bc8f5f31-f226-41f2-aaff-bdc9571bd54c', N'd9078b9a-5db6-4429-b489-3700e56f367f', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/SystemManage/PrintTemplate/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2021-01-14 13:24:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'be75a305-421e-4d91-9967-dff081e3a4f7', N'eeb05603-45d5-4205-88fc-0fe60357710d', N'0', N'1', N'InStorageLocation', N'入库上架', NULL, N'1', N'InStorageLocation', N'', NULL, N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2021-04-27 16:05:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'InStorageLocation')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'c26b571e-5d29-4d5d-b841-c934edb17ca0', N'cf527f37-2b29-403a-a83b-a6fb0af33b7f', N'0', N'1', N'NF-add', N'清空记录', NULL, N'1', N'add', N'/ReportRecord/StorageChangeReport/Fotm', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-03-09 14:41:09.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-03-09 14:41:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'c3793300-ff6f-4790-89ad-215bc4f3348b', N'8941c6fe-7413-40cb-9852-695ecf69662a', N'0', N'1', N'NF-details', N'查看详细', NULL, N'2', N'details', N'/ProductionReport/AutoCpkLog/CpkLogDetail', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2021-02-01 10:08:44.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-02-05 09:00:36.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'c7f6afc9-0eeb-4ebc-a4e8-5cceedb08604', N'6bdd6d88-4391-476e-bcec-10e41cbdcea7', N'0', N'1', N'NF-details', N'查看设备', NULL, N'2', N'details', N'/ReportRecord/EqpWorkTime/Details', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2021-04-08 11:41:19.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-04-08 11:41:51.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'c8eed325-56ad-4210-b610-3e3bb68eb0be', N'c87cd44f-d064-4d3c-a43e-de01a7a8785e', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/FlowManage/Flowinstance/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2020-07-14 09:21:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'c97bdd88-5df3-40a9-aa33-fdf2beed9d1c', N'a083a171-932a-48b8-b053-13f9b39d555a', N'0', N'1', N'ReturnMaterial', N'物流退回物料', NULL, N'1', N'ReturnMaterial', N'', NULL, N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-04-27 16:04:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'ReturnMaterial')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'ca302b02-6835-41c0-ae24-97dfb690fd1c', N'240eb9e4-d5f8-4097-8611-dcdb30c2f49a', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/QualityManage/CheckoutDescription/Details', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2021-05-18 08:18:07.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-05-18 08:18:50.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'cb409d35-a09a-4808-b278-32f349ae0459', N'2ffc3301-8ec2-4157-a4c3-232797aae120', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/ProcessManage/WorkOrderRun/Details', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2021-01-08 08:05:16.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-08 08:05:33.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'cba403cb-6418-44b7-868d-19e04af673ce', N'd742c96e-b61c-4cea-afeb-81805789687b', N'0', N'1', N'NF-delete', N'删除分类', NULL, N'2', N'delete', N'/SystemManage/ItemsType/DeleteForm', N'0', N'0', N'0', N'0', N'4', N'0', N'1', NULL, NULL, NULL, N'2020-04-27 16:52:32.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'ccfb8572-f661-4da2-8bc0-ceff351229ec', N'83d761e9-4ab8-45db-a9ce-32bc148b6922', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/EquipmentManage/EqpArea/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2020-12-17 11:22:40.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-17 11:22:57.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'cd65e50a-0bea-45a9-b82e-f2eacdbd209e', N'252229DB-35CA-47AE-BDAE-C9903ED5BA7B', N'0', N'1', N'NF-add', N'新建机构', NULL, N'1', N'add', N'/SystemManage/Organize/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, NULL, NULL, N'2020-04-07 14:22:42.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'ceb3cbcf-5dca-4d1b-afec-0e356ea33bc6', N'69f6aebb-965b-4380-910f-99aba0776261', N'0', N'1', N'NF-transfer', N'库存变动', NULL, N'1', N'transfer', N'/MaterialManage/Storage/Form', NULL, N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2020-12-31 09:52:36.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-03-10 13:43:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'cf235c14-e4ad-478a-8e9c-9f7ec5a80255', N'4666f434-3178-42e5-a44f-1f34cadb3c43', N'0', N'1', N'AreaStorage', N'库存汇总', NULL, N'1', N'AreaStorage', N'', NULL, N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-04-27 16:09:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'AreaStorage')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'd00db889-23eb-41d4-b941-be4e6e236455', N'e093b2d3-ec49-4b4d-91ec-63f57f4e3f1d', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/MaterialManage/TransferBox/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2020-12-14 12:44:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'd1086ccf-e605-44a4-9777-629810cec02d', N'152a8e93-cebb-4574-ae74-2a86595ff986', N'0', N'1', N'NF-edit', N'修改字段', NULL, N'2', N'edit', N'/SystemManage/ModuleFields/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2020-05-21 14:39:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-05-21 15:15:11.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'd20c1c0a-a0d3-4227-b24f-81ef1bcff60c', N'25ca371f-9c67-4e0e-9ca7-0dec2e836613', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/MaterialManage/InStorage/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2020-12-16 13:38:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'd20ee9fb-48ee-48d2-99e5-44b92cde7ec8', N'b5ff9591-f939-41c0-8c68-3b9c2fe02bdd', N'0', N'1', N'CheckoutCancle', N'取消可疑', NULL, N'1', N'CheckoutCancle', N'', NULL, N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2021-05-26 09:23:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'CheckoutCancle')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'd26da420-7e73-41ef-8361-86551b8dd1bb', N'a303cbe1-60eb-437b-9a69-77ff8b48f173', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/SystemOrganize/SystemSet/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2020-06-12 13:54:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-16 08:12:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'd2ecb5e8-e5cc-49c8-ba86-dbd7e51ca20b', N'e3188a69-de3a-40ef-a5ff-5eaf460f5d20', N'0', N'1', N'NF-edit', N'修改任务', NULL, N'2', N'edit', N'/SystemSecurity/OpenJobs/Form', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2020-05-26 13:55:50.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-05-26 13:56:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'd30ff0f3-39da-4033-a320-56f26edd5b51', N'f82fd629-5f3a-45d6-8681-5ec47e66a807', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/SystemManage/Flowscheme/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2020-07-10 08:50:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'd4074121-0d4f-465e-ad37-409bbe15bf8a', N'a3a4742d-ca39-42ec-b95a-8552a6fae579', N'0', N'1', N'NF-add', N'新建策略', NULL, N'1', N'add', N'/SystemSecurity/FilterIP/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, NULL, NULL, N'2016-07-25 15:57:40.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'd42aaaae-4973-427c-ad86-7a6b20b09325', N'605444e5-704f-4cca-8d00-75175e2aef05', N'0', N'1', N'NF-vft', N'处理', NULL, N'1', N'vft', N'/FlowManage/Flowinstance/Verification', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2020-07-15 15:03:33.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-07-15 15:04:24.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'd4a4bb19-36f5-4267-b264-1a3ea2c510e6', N'91448822-e10b-4146-b9fe-2669073cc7f1', N'0', N'1', N'FinishWorkOrderJob', N'工单结束申请', NULL, N'1', N'FinishWorkOrderJob', N'', NULL, N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2021-04-27 16:01:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'FinishWorkOrderJob')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'D4FCAFED-7640-449E-80B7-622DDACD5012', N'64A1C550-2C61-4A8C-833D-ACD0C012260F', N'0', N'1', N'NF-details', N'查看菜单', NULL, N'2', N'details', N'/SystemManage/Module/Details', N'0', N'0', N'0', N'0', N'4', N'0', N'1', NULL, NULL, NULL, N'2020-04-27 17:37:29.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'd5d5de3c-2182-420d-b44e-6c71c5ab1537', N'af863666-a357-4e06-bffd-df98e1d29ab8', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/EquipmentManage/Equipment/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2020-11-30 14:05:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'd6251574-692e-4fce-a3a0-fa1ed64cd05b', N'd9078b9a-5db6-4429-b489-3700e56f367f', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/SystemManage/PrintTemplate/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2021-01-14 13:24:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'd63212a7-5977-43e9-a162-9ff5763f20e2', N'240eb9e4-d5f8-4097-8611-dcdb30c2f49a', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/QualityManage/CheckoutDescription/DeleteForm', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2021-05-18 08:18:07.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-05-18 08:18:34.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'd75fd32e-6ef7-4514-915b-5165794df754', N'50cdea18-b06a-43c8-963c-8f52fb9d94de', N'0', N'1', N'NF-submit', N'保存', NULL, N'1', N'submit', N'/MaterialManage/MaterialBom/SubmitForm', NULL, N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-01-06 08:13:49.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-06 08:14:05.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'd7a452f3-3596-4339-8803-d61fb4eec013', N'F298F868-B689-4982-8C8B-9268CBF0308D', N'0', N'1', N'NF-export', N'导出', NULL, N'1', N'export', N'/SystemOrganize/Duty/Export', NULL, N'0', N'0', N'0', N'6', N'0', N'1', N'', N'2020-08-12 10:17:30.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-08-12 10:18:15.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'd8d92dcd-db85-4dde-8df2-d3be835dcc56', N'91448822-e10b-4146-b9fe-2669073cc7f1', N'0', N'1', N'GetWorkOrderInfo', N'工单查询', NULL, N'1', N'GetWorkOrderInfo', N'', NULL, N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2021-04-27 16:01:33.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'GetWorkOrderInfo')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'd9e74251-61ff-4472-adec-ad316cb9a307', N'd742c96e-b61c-4cea-afeb-81805789687b', N'0', N'1', N'NF-add', N'新建分类', NULL, N'1', N'add', N'/SystemManage/ItemsType/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, NULL, NULL, N'2020-04-27 16:52:12.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'da9da00e-d30a-4ef6-b86d-5f402cd3e64d', N'8968b428-2a8b-4dbe-ad47-73dd408ddd5e', N'0', N'1', N'NF-delete', N'工序-删除', NULL, N'2', N'delete', N'/ProcessManage/ProcessFlow/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2020-12-03 09:49:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-06 09:13:22.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'da9f9a0d-e350-46fd-a44e-e543acaa8d34', N'33f831db-f9a4-43e7-8688-d08073af575b', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/ClassTask/ControlJob/Details', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-01-19 08:41:42.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-19 08:41:47.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'dc8064f7-1122-4ebd-820e-79964716c13d', N'be2173ad-0833-4a9a-8024-b9f32f892de5', N'0', N'1', N'NF-add', N'清空记录', NULL, N'1', N'add', N'/ReportRecord/InStorageReport/Fotm', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-02-26 13:16:47.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-03-09 10:43:05.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'dd259bbd-51a8-4bfe-adac-586738779351', N'5391c5c0-55c0-4132-a26d-5d27fcec1c18', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/MaterialManage/Location/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2020-12-17 08:32:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'dd9f45e6-0fa5-4c98-8420-8199c9175507', N'a620c016-27cb-46f8-86c9-44c197617524', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/EquipmentManage/EqpUser/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-01-15 11:26:32.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-15 11:26:40.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'dddaa429-6ebb-4d0e-ab1f-86307fa8a385', N'af863666-a357-4e06-bffd-df98e1d29ab8', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/EquipmentManage/Equipment/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2020-11-30 14:05:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'df626d9c-e3ba-4851-8926-3e175055cc8b', N'8941c6fe-7413-40cb-9852-695ecf69662a', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/ProductionReport/AutoCpkLog/DeleteForm', N'0', N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2021-02-05 08:58:05.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-02-05 09:00:49.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'e06965bc-b693-4b91-96f9-fc10ca2aa1f0', N'e3188a69-de3a-40ef-a5ff-5eaf460f5d20', N'0', N'1', N'NF-disabled', N'关闭', NULL, N'2', N'disabled', N'/SystemSecurity/OpenJobs/ChangeStatus', N'0', N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2020-05-26 13:55:50.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-05-27 08:42:32.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'e12bc302-e651-463a-a159-68968ece733a', N'b26cea9c-21ba-42fa-98fc-b8fe0b92451d', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/QualityManage/NeedCheck/Details', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2021-05-21 13:57:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-06-18 13:27:24.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'E29FCBA7-F848-4A8B-BC41-A3C668A9005D', N'64A1C550-2C61-4A8C-833D-ACD0C012260F', N'0', N'1', N'NF-edit', N'修改菜单', NULL, N'2', N'edit', N'/SystemManage/Module/Form', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, NULL, NULL, N'2016-07-25 15:41:02.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'e376d482-023e-4715-a9c8-2a393c24426e', N'605444e5-704f-4cca-8d00-75175e2aef05', N'0', N'1', N'NF-details', N'进度', NULL, N'2', N'details', N'/FlowManage/Flowinstance/Details', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2020-07-15 15:03:33.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-07-15 15:04:15.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'e46372b7-7c30-4f62-af2b-33a4f3393ddc', N'b5ff9591-f939-41c0-8c68-3b9c2fe02bdd', N'0', N'1', N'CheckoutInfo', N'不良查询', NULL, N'1', N'CheckoutInfo', N'', NULL, N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-04-27 16:07:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-05-26 09:22:18.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'CheckoutInfo')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'e4ddb5b5-d576-4c50-847c-aa501ac5a38c', N'b5ff9591-f939-41c0-8c68-3b9c2fe02bdd', N'0', N'1', N'FirstCheckout', N'常规检验', NULL, N'1', N'FirstCheckout', N'', NULL, N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2021-04-27 16:07:54.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-05-26 09:23:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'FirstCheckout')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'e6514544-1436-431d-acbc-c44802831ea8', N'01849cc9-c6da-4184-92f8-34875dac1d42', N'0', N'1', N'NF-entitycode', N'实体生成', NULL, N'2', N'entitycode', N'/SystemManage/CodeGenerator/EntityCode', NULL, N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2020-07-23 15:36:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-07-23 15:36:42.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'e68fffbb-00bd-465c-9527-b04c554b6ba6', N'7cce1014-5087-4184-9848-77e164be4e17', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/ProcessManage/WorkOrder/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2020-12-07 12:14:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'e75e4efc-d461-4334-a764-56992fec38e6', N'F298F868-B689-4982-8C8B-9268CBF0308D', N'0', N'1', N'NF-edit', N'修改岗位', NULL, N'2', N'edit', N'/SystemOrganize/Duty/Form', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', NULL, NULL, N'2020-06-16 08:13:55.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'e8ec8398-2a2e-4b00-82e2-6f2bb19a63cd', N'8968b428-2a8b-4dbe-ad47-73dd408ddd5e', N'0', N'1', N'TF-add', N'设备-新增', NULL, N'1', N'add', N'/ProcessManage/ProcessFlow/EqpForm', NULL, N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2020-12-03 11:22:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-06 09:13:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'eb71bee8-e348-4892-9257-4b7147921918', N'ed896675-541a-4d34-bf77-29c87d7a26bb', N'0', N'1', N'NF-import', N'导入', NULL, N'1', N'import', N'/MaterialManage/Material/Import', NULL, N'0', N'0', N'0', N'6', N'0', N'1', N'', N'2021-01-12 12:14:56.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-12 12:15:14.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'ebbe0e28-966a-402f-bae6-6ceaa5475006', N'eb3cf8ac-947d-4091-9c8e-75da8bae5e7f', N'0', N'1', N'NF-add', N'清空记录', NULL, N'1', N'add', N'/ReportRecord/OutStorageReport/Fotm', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-03-09 10:43:19.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-03-09 10:43:26.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'ec452d72-4969-4880-b52f-316ffdfa19bd', N'f82fd629-5f3a-45d6-8681-5ec47e66a807', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/SystemManage/Flowscheme/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2020-07-10 08:50:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'f0db4138-2d89-4553-9322-5ebb9bbafbc3', N'39226710-b665-489e-aaa0-a8c15d29ed4c', N'0', N'1', N'NF-submit', N'保存', NULL, N'1', N'submit', N'/MaterialManage/BomInfo/SubmitForm', NULL, N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-01-05 16:46:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-01-05 17:07:44.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'f1eb5b12-2898-4aa6-81bf-14473482b764', N'25ca371f-9c67-4e0e-9ca7-0dec2e836613', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/MaterialManage/InStorage/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2020-12-16 13:38:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'f353f74e-644c-4ed5-8558-eef6bdd35985', N'5391c5c0-55c0-4132-a26d-5d27fcec1c18', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/MaterialManage/Location/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2020-12-17 08:32:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'f4299350-e36f-4cd3-90a4-86b418e05f92', N'a8f0c195-53c5-4b05-b65e-5fafb14a3aec', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/ClassTask/ControlJob/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2021-01-15 14:19:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'f48f69a6-53b7-4636-8738-0748d44353e6', N'ffcf9006-570e-44f5-80d4-32c213813a92', N'0', N'1', N'NF-add', N'清空记录', NULL, N'1', N'add', N'/ReportRecord/OutputReport/Fotm', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-03-09 14:40:47.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-03-09 14:40:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'f4ed7001-d04e-4b5f-843a-767edc8506f7', N'fb087f6b-fa45-43c7-903c-3a80a450ff45', N'0', N'1', N'NF-cpk', N'Cpk分析', NULL, N'2', N'cpk', N'/ProductionReport/Tdreport/CpkEnterDialog', N'0', N'0', N'0', N'0', N'7', N'0', N'1', N'', N'2021-02-04 12:50:18.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-03-24 10:26:33.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'f51da6f6-8511-49f3-982b-a30ed0946706', N'26452c9a-243d-4c81-97b9-a3ad581c3bf4', N'0', N'1', N'NF-delete', N'删除机构', NULL, N'2', N'delete', N'/SystemOrganize/Organize/DeleteForm', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', NULL, NULL, N'2020-07-23 10:47:09.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'f552d4fa-791c-4891-95ff-298ca775c656', N'badc3ee2-fcbb-43ae-9efe-2309f8a63834', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/MaterialManage/MaterialEqp/DeleteForm', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2020-12-02 16:23:53.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-12-02 16:24:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'f688f8af-262a-4769-9ad5-4122422f072f', N'b5ff9591-f939-41c0-8c68-3b9c2fe02bdd', N'0', N'1', N'ChangeCheckoutState', N'状态变动', NULL, N'1', N'ChangeCheckoutState', N'', NULL, N'0', N'0', N'0', N'6', N'0', N'1', N'', N'2021-04-27 16:08:11.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-05-26 09:21:50.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'ChangeCheckoutState')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'f7b696c4-9af0-4bde-b92a-1f9f151007b8', N'91448822-e10b-4146-b9fe-2669073cc7f1', N'0', N'1', N'OutputMaterialCancle', N'生产产出取消', NULL, N'1', N'OutputMaterialCancle', N'', NULL, N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2021-04-27 16:02:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'OutputMaterialCancle')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'f85f3bd5-ad1b-43d2-84f6-bbae465c65d9', N'667a7393-ed53-43e0-bf2a-c349e5dd48e5', N'0', N'1', N'NF-add', N'清空记录', NULL, N'1', N'add', N'/ReportRecord/EqpMaterialUseReport/Fotm', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2021-03-09 14:39:04.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-03-09 14:39:17.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'f8c0cd71-e206-4991-91cf-fa96d5652eac', N'a083a171-932a-48b8-b053-13f9b39d555a', N'0', N'1', N'ConsumeMaterial', N'物流领用物料', NULL, N'1', N'ConsumeMaterial', N'', NULL, N'0', N'0', N'0', N'0', N'0', N'1', N'', N'2021-04-27 16:03:39.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'ConsumeMaterial')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'f93763ff-51a1-478d-9585-3c86084c54f3', N'91A6CFAD-B2F9-4294-BDAE-76DECF412C6C', N'0', N'1', N'NF-details', N'查看角色', NULL, N'2', N'details', N'/SystemOrganize/Role/Details', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', NULL, NULL, N'2020-06-16 08:13:42.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'fcb4d9f0-63f0-4bd0-9779-eed26da5c4b3', N'e9190a56-e173-4483-8a3e-f17b86e4766e', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/InfoManage/Message/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2020-07-29 16:44:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'FD3D073C-4F88-467A-AE3B-CDD060952CE6', N'64A1C550-2C61-4A8C-833D-ACD0C012260F', N'0', N'1', N'NF-modulebutton', N'按钮管理', NULL, N'2', N'modulebutton', N'/SystemManage/ModuleButton/Index', N'0', N'0', N'0', N'0', N'5', N'0', N'1', NULL, NULL, NULL, N'2020-04-07 14:34:09.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'ffffe7f8-900c-413a-9970-bee7d6599cce', N'91A6CFAD-B2F9-4294-BDAE-76DECF412C6C', N'0', N'1', N'NF-edit', N'修改角色', NULL, N'2', N'edit', N'/SystemOrganize/Role/Form', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', NULL, NULL, N'2020-06-16 08:13:35.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL)
GO


-- ----------------------------
-- Table structure for sys_ModuleFields
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_ModuleFields]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_ModuleFields]
GO

CREATE TABLE [dbo].[sys_ModuleFields] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_ModuleId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EnCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_FullName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteMark] tinyint  NULL,
  [F_EnabledMark] tinyint  NULL,
  [F_Description] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsPublic] tinyint  NULL
)
GO

ALTER TABLE [dbo].[sys_ModuleFields] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of sys_ModuleFields
-- ----------------------------
INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'00a79cc3-a490-4772-909a-38567e3ea6da', N'484269cb-9aea-4af1-b7f6-f99e7e396ad1', N'F_ProjectName', N'项目名称', N'0', N'1', N'', N'2020-06-12 14:33:15.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-12 16:13:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'0153fba2-3b50-4294-b699-43606a5e7fa4', N'39226710-b665-489e-aaa0-a8c15d29ed4c', N'F_BomType', N'Bom类型（0erp,1mes）', N'0', N'1', NULL, N'2020-12-03 13:56:34.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'01722807-2004-4e33-a13d-cbd33d0f917e', N'25ca371f-9c67-4e0e-9ca7-0dec2e836613', N'F_DoneNum', N'完成数量', N'0', N'1', NULL, N'2020-12-16 13:38:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'01c48d54-a8fe-4471-818e-adb42bd34c41', N'79c73d26-6f49-463a-9002-98eba48e36b2', N'F_AreaType', N'库区类型', N'0', N'1', NULL, N'2020-12-17 08:31:32.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'01c5a74f-682c-462e-87af-0eaf445854a9', N'79c73d26-6f49-463a-9002-98eba48e36b2', N'F_AreaCode', N'库区编号', N'0', N'1', NULL, N'2020-12-17 08:31:32.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'035d9296-1e17-42b7-9d8f-c9cc3b1d8e3f', N'7cb65e00-8af2-4cf2-b318-8ba28b3c154e', N'F_FileExtension', N'文件扩展名', N'0', N'1', NULL, N'2020-07-22 12:05:35.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'06896834-cc65-47bd-9bcc-55526f828d6e', N'b26cea9c-21ba-42fa-98fc-b8fe0b92451d', N'F_Num', N'检验数量', N'0', N'1', NULL, N'2021-05-21 13:57:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92be4-74cb-40ab-8cc3-0a7932cc0be3', N'08d92be4-74ba-4edf-8357-49547cae7fbc', N'F_EqpId', N'F_EqpId', N'0', N'1', NULL, N'2021-06-10 15:50:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92be4-74cb-410a-887f-faa313013934', N'08d92be4-74ba-4edf-8357-49547cae7fbc', N'F_StopType', N'1：故障停机，2：计划内停机', N'0', N'1', NULL, N'2021-06-10 15:50:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92be4-74cb-4171-867f-b5ae990e1af5', N'08d92be4-74ba-4edf-8357-49547cae7fbc', N'F_PlanStopStartTime', N'计划停机开始时间', N'0', N'1', NULL, N'2021-06-10 15:50:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92be4-74cb-41c6-842a-b6d5f1616da6', N'08d92be4-74ba-4edf-8357-49547cae7fbc', N'F_PlanStopEndTime', N'计划停机结束时间', N'0', N'1', NULL, N'2021-06-10 15:50:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92be4-74cb-422b-8d95-2f44b8b5d33e', N'08d92be4-74ba-4edf-8357-49547cae7fbc', N'F_StopReasonType', N'停机原因分类：1人2机3料4法5环', N'0', N'1', NULL, N'2021-06-10 15:50:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92be4-74cb-4280-81dd-eb3f81e52386', N'08d92be4-74ba-4edf-8357-49547cae7fbc', N'F_StopReason', N'停机原因', N'0', N'1', NULL, N'2021-06-10 15:50:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92be4-74cb-42bf-819b-093738061c33', N'08d92be4-74ba-4edf-8357-49547cae7fbc', N'F_RealStopStartTime', N'实际停机开始时间', N'0', N'1', NULL, N'2021-06-10 15:50:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92be4-74cb-42fa-8eee-4478e878b9f9', N'08d92be4-74ba-4edf-8357-49547cae7fbc', N'F_RealStopEndTime', N'实际停机结束时间', N'0', N'1', NULL, N'2021-06-10 15:50:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92be4-74cb-4335-8fed-933cb6bb87b5', N'08d92be4-74ba-4edf-8357-49547cae7fbc', N'F_Solution', N'解决措施', N'0', N'1', NULL, N'2021-06-10 15:50:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92be4-74cb-4371-8d66-b6349a315591', N'08d92be4-74ba-4edf-8357-49547cae7fbc', N'F_Description', N'备注', N'0', N'1', NULL, N'2021-06-10 15:50:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92be4-74cb-43ac-8f96-7678560197e2', N'08d92be4-74ba-4edf-8357-49547cae7fbc', N'F_CreatorTime', N'F_CreatorTime', N'0', N'1', NULL, N'2021-06-10 15:50:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92be4-74cb-43e9-8779-93727f0924e4', N'08d92be4-74ba-4edf-8357-49547cae7fbc', N'F_CreatorUserId', N'F_CreatorUserId', N'0', N'1', NULL, N'2021-06-10 15:50:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fa2-7438-4012-80c1-3bfe8c202004', N'08d92fa2-7423-43dc-8839-359e00c53878', N'F_WorkPlanCode', N'计划编号', N'0', N'1', NULL, N'2021-06-15 10:08:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fa2-7438-40a5-8de9-97e1e68dd328', N'08d92fa2-7423-43dc-8839-359e00c53878', N'F_MaterialId', N'料号Id', N'0', N'1', NULL, N'2021-06-15 10:08:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fa2-7438-4125-8e5b-6bde895875ce', N'08d92fa2-7423-43dc-8839-359e00c53878', N'F_PlanNum', N'计划数量', N'0', N'1', NULL, N'2021-06-15 10:08:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fa2-7438-41b4-8dc6-451275072498', N'08d92fa2-7423-43dc-8839-359e00c53878', N'F_PlanStartTime', N'计划开始时间', N'0', N'1', NULL, N'2021-06-15 10:08:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fa2-7438-4244-8db5-520b82fb8b17', N'08d92fa2-7423-43dc-8839-359e00c53878', N'F_PlanEndTime', N'计划结束时间', N'0', N'1', NULL, N'2021-06-15 10:08:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fa2-7438-42d4-85fb-cfdddd6e954d', N'08d92fa2-7423-43dc-8839-359e00c53878', N'F_EnabledMark', N'F_EnabledMark', N'0', N'1', NULL, N'2021-06-15 10:08:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fa2-7438-4361-88e1-8b94d9d774d3', N'08d92fa2-7423-43dc-8839-359e00c53878', N'F_Description', N'备注', N'0', N'1', NULL, N'2021-06-15 10:08:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fa2-7438-43f0-8246-a64ba6637ee1', N'08d92fa2-7423-43dc-8839-359e00c53878', N'F_CreatorTime', N'F_CreatorTime', N'0', N'1', NULL, N'2021-06-15 10:08:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fa2-7438-4474-84a8-37e072b7eaf2', N'08d92fa2-7423-43dc-8839-359e00c53878', N'F_CreatorUserId', N'F_CreatorUserId', N'0', N'1', NULL, N'2021-06-15 10:08:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fa2-7438-44f3-8581-3b191ee12ce5', N'08d92fa2-7423-43dc-8839-359e00c53878', N'F_SplitType', N'F_SplitType', N'0', N'1', NULL, N'2021-06-15 10:08:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fa2-7438-456f-8c25-2435376aefbe', N'08d92fa2-7423-43dc-8839-359e00c53878', N'F_DoneNum', N'完成数量', N'0', N'1', NULL, N'2021-06-15 10:08:23.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fb7-7762-4b2b-84f6-19133394a7e9', N'08d92fb7-7754-4c3b-8341-c60bc590212d', N'F_RepairNo', N'维修单号', N'0', N'1', NULL, N'2021-06-15 12:38:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fb7-7762-4b78-833a-899f8810120b', N'08d92fb7-7754-4c3b-8341-c60bc590212d', N'F_EqpId', N'F_EqpId', N'0', N'1', NULL, N'2021-06-15 12:38:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fb7-7762-4bcb-8494-7aa7648d7ead', N'08d92fb7-7754-4c3b-8341-c60bc590212d', N'F_ProblemType', N'故障分类', N'0', N'1', NULL, N'2021-06-15 12:38:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fb7-7762-4c1d-89c6-c9739106ad52', N'08d92fb7-7754-4c3b-8341-c60bc590212d', N'F_ProblemClass', N'故障等级：低级，中级，高级', N'0', N'1', NULL, N'2021-06-15 12:38:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fb7-7762-4c70-8ada-cbbf32f483f1', N'08d92fb7-7754-4c3b-8341-c60bc590212d', N'F_ProblemDesc', N'故障描述', N'0', N'1', NULL, N'2021-06-15 12:38:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fb7-7762-4cc4-88ca-dd845207a850', N'08d92fb7-7754-4c3b-8341-c60bc590212d', N'F_PhotoPath', N'故障图片路径', N'0', N'1', NULL, N'2021-06-15 12:38:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fb7-7762-4d17-801e-0c640c99ca1b', N'08d92fb7-7754-4c3b-8341-c60bc590212d', N'F_CallRepairMan', N'报修人ID', N'0', N'1', NULL, N'2021-06-15 12:38:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fb7-7762-4d6d-8acf-bb570a4a409f', N'08d92fb7-7754-4c3b-8341-c60bc590212d', N'F_CallRepairTime', N'报修时间', N'0', N'1', NULL, N'2021-06-15 12:38:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fb7-7762-4dc0-89b8-8d6486fc7083', N'08d92fb7-7754-4c3b-8341-c60bc590212d', N'F_DistributeTime', N'派工时间', N'0', N'1', NULL, N'2021-06-15 12:38:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fb7-7762-4e13-8f81-d9fea77f4f50', N'08d92fb7-7754-4c3b-8341-c60bc590212d', N'F_StartRepairTime', N'维修开始时间', N'0', N'1', NULL, N'2021-06-15 12:38:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fb7-7762-4e55-8942-bea5dd5458f6', N'08d92fb7-7754-4c3b-8341-c60bc590212d', N'F_EndRepairTime', N'维修结束时间', N'0', N'1', NULL, N'2021-06-15 12:38:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fb7-7762-4e94-8c77-c3c91965b82e', N'08d92fb7-7754-4c3b-8341-c60bc590212d', N'F_Status', N'状态：1,报修；2，已派工；3,维修中；4，确认中，5，关闭', N'0', N'1', NULL, N'2021-06-15 12:38:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fb7-7762-4ed1-857d-74c68411f4b6', N'08d92fb7-7754-4c3b-8341-c60bc590212d', N'F_ConfirmMan', N'确认人ID,同报修人', N'0', N'1', NULL, N'2021-06-15 12:38:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fb7-7762-4f0e-8059-7c3992125358', N'08d92fb7-7754-4c3b-8341-c60bc590212d', N'F_ConfirmTime', N'确认时间', N'0', N'1', NULL, N'2021-06-15 12:38:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fb7-7762-4f4b-8361-4ff2077066ef', N'08d92fb7-7754-4c3b-8341-c60bc590212d', N'F_EnabledMark', N'F_EnabledMark', N'0', N'1', NULL, N'2021-06-15 12:38:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fb7-7762-4f88-83e5-c2c3c57928db', N'08d92fb7-7754-4c3b-8341-c60bc590212d', N'F_Description', N'备注', N'0', N'1', NULL, N'2021-06-15 12:38:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fb7-7762-4fc6-875d-160b3eea6b71', N'08d92fb7-7754-4c3b-8341-c60bc590212d', N'F_CreatorTime', N'F_CreatorTime', N'0', N'1', NULL, N'2021-06-15 12:38:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d92fb7-7763-4031-8bbd-9b1edf82690d', N'08d92fb7-7754-4c3b-8341-c60bc590212d', N'F_CreatorUserId', N'F_CreatorUserId', N'0', N'1', NULL, N'2021-06-15 12:38:48.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d93158-2734-4af9-845b-b260d1c782ac', N'08d93158-2459-490a-868d-a826777f22e4', N'F_BatchName', N'容器条码名称', N'0', N'1', NULL, N'2021-06-17 14:21:33.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d93158-2734-4b71-888e-16ae948f2291', N'08d93158-2459-490a-868d-a826777f22e4', N'F_MaxNum', N'容器最大数', N'0', N'1', NULL, N'2021-06-17 14:21:33.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d93158-2734-4be3-8197-da919fbb5bf9', N'08d93158-2459-490a-868d-a826777f22e4', N'F_BatchCode', N'条码当前编号', N'0', N'1', NULL, N'2021-06-17 14:21:33.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9360c-dd24-496f-88bd-e29db67c6d88', N'08d9360c-dd12-43e8-8ebe-0104c5bd3c08', N'F_InStorageCode', N'入库单编号', N'0', N'1', NULL, N'2021-06-23 14:05:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9360c-dd24-4a18-88c3-caee22d95444', N'08d9360c-dd12-43e8-8ebe-0104c5bd3c08', N'F_MaterialId', N'料号Id', N'0', N'1', NULL, N'2021-06-23 14:05:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9360c-dd24-4aa7-8984-c004045ae8c6', N'08d9360c-dd12-43e8-8ebe-0104c5bd3c08', N'F_MaterialCode', N'料号描述', N'0', N'1', NULL, N'2021-06-23 14:05:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9360c-dd24-4b4a-8953-8391f90872b8', N'08d9360c-dd12-43e8-8ebe-0104c5bd3c08', N'F_MaterialName', N'料号描述', N'0', N'1', NULL, N'2021-06-23 14:05:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9360c-dd24-4bde-8882-e415c95a7820', N'08d9360c-dd12-43e8-8ebe-0104c5bd3c08', N'F_MaterialUnit', N'料号单位', N'0', N'1', NULL, N'2021-06-23 14:05:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9360c-dd24-4c72-86f8-fb652be55cc1', N'08d9360c-dd12-43e8-8ebe-0104c5bd3c08', N'F_MaterialType', N'料号分类', N'0', N'1', NULL, N'2021-06-23 14:05:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9360c-dd24-4cee-8b23-657dba7aaa1d', N'08d9360c-dd12-43e8-8ebe-0104c5bd3c08', N'F_EnabledMark', N'F_EnabledMark', N'0', N'1', NULL, N'2021-06-23 14:05:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9360c-dd24-4d74-864f-96df96694674', N'08d9360c-dd12-43e8-8ebe-0104c5bd3c08', N'F_Description', N'备注', N'0', N'1', NULL, N'2021-06-23 14:05:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9360c-dd24-4df4-8797-16226c1e2444', N'08d9360c-dd12-43e8-8ebe-0104c5bd3c08', N'F_CreatorTime', N'创建时间', N'0', N'1', NULL, N'2021-06-23 14:05:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9360c-dd24-4e84-852a-ed87518334f1', N'08d9360c-dd12-43e8-8ebe-0104c5bd3c08', N'F_CreatorUserId', N'创建人id', N'0', N'1', NULL, N'2021-06-23 14:05:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9360c-dd24-4eff-8c7a-5b7b7957158a', N'08d9360c-dd12-43e8-8ebe-0104c5bd3c08', N'F_Num', N'数量', N'0', N'1', NULL, N'2021-06-23 14:05:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9360c-dd24-4fde-865f-661381dfcd10', N'08d9360c-dd12-43e8-8ebe-0104c5bd3c08', N'F_DoneNum', N'完成数量', N'0', N'1', NULL, N'2021-06-23 14:05:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9360c-dd25-4057-8c67-32866d3ef6ad', N'08d9360c-dd12-43e8-8ebe-0104c5bd3c08', N'F_InStorageState', N'入库单状态', N'0', N'1', NULL, N'2021-06-23 14:05:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9360c-dd25-40c9-89cb-2c81a0508f58', N'08d9360c-dd12-43e8-8ebe-0104c5bd3c08', N'F_BadNum', N'不良数量', N'0', N'1', NULL, N'2021-06-23 14:05:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9360c-dd25-413a-8f13-d1793e7816eb', N'08d9360c-dd12-43e8-8ebe-0104c5bd3c08', N'F_BatchJson', N'批号列表', N'0', N'1', NULL, N'2021-06-23 14:05:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9360c-dd25-41a7-8bab-77b3c68008f0', N'08d9360c-dd12-43e8-8ebe-0104c5bd3c08', N'F_PlanTime', N'计划时间', N'0', N'1', NULL, N'2021-06-23 14:05:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9360c-dd25-4218-882a-2fe5e52e8123', N'08d9360c-dd12-43e8-8ebe-0104c5bd3c08', N'F_CarNo', N'车牌', N'0', N'1', NULL, N'2021-06-23 14:05:13.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d94c14-e1ca-4436-8a1a-39fba065ab87', N'08d94c14-e1b5-4b56-8873-37fb81ebaad3', N'F_OrderCode', N'订单编号', N'0', N'1', NULL, N'2021-07-21 14:58:02.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d94c14-e1ca-44b2-89c9-dccc224cbb7c', N'08d94c14-e1b5-4b56-8873-37fb81ebaad3', N'F_Customer', N'客户', N'0', N'1', NULL, N'2021-07-21 14:58:02.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d94c14-e1ca-4529-8a4b-dd62bde75495', N'08d94c14-e1b5-4b56-8873-37fb81ebaad3', N'F_PlanStartTime', N'计划开始时间', N'0', N'1', NULL, N'2021-07-21 14:58:02.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d94c14-e1ca-459d-8aed-9bfec1abd366', N'08d94c14-e1b5-4b56-8873-37fb81ebaad3', N'F_PlanEndTime', N'计划结束时间', N'0', N'1', NULL, N'2021-07-21 14:58:02.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d94c14-e1ca-4614-84d2-4ba39de1a91e', N'08d94c14-e1b5-4b56-8873-37fb81ebaad3', N'F_DayNum', N'天数', N'0', N'1', NULL, N'2021-07-21 14:58:02.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d94c14-e1ca-4688-8217-c8caed2fad93', N'08d94c14-e1b5-4b56-8873-37fb81ebaad3', N'F_EnabledMark', N'F_EnabledMark', N'0', N'1', NULL, N'2021-07-21 14:58:02.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d94c14-e1ca-46ff-8b5b-6d65f54c43fc', N'08d94c14-e1b5-4b56-8873-37fb81ebaad3', N'F_Description', N'备注', N'0', N'1', NULL, N'2021-07-21 14:58:02.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d94c14-e1ca-4776-8a2a-adf8bbe68a4a', N'08d94c14-e1b5-4b56-8873-37fb81ebaad3', N'F_CreatorTime', N'F_CreatorTime', N'0', N'1', NULL, N'2021-07-21 14:58:02.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d94c14-e1ca-47e7-8a04-df5a5a5d5fb6', N'08d94c14-e1b5-4b56-8873-37fb81ebaad3', N'F_CreatorUserId', N'F_CreatorUserId', N'0', N'1', NULL, N'2021-07-21 14:58:02.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d966c3-26cc-42e9-8419-b4b307abffe8', N'08d966c3-26bd-4808-8e49-03d2085e08f4', N'F_EqpId', N'设备ID', N'0', N'1', NULL, N'2021-08-24 13:51:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d966c3-26cc-4375-836b-558a4d944edd', N'08d966c3-26bd-4808-8e49-03d2085e08f4', N'F_Date', N'日期', N'0', N'1', NULL, N'2021-08-24 13:51:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d966c3-26cc-43de-872e-04a1db8908d5', N'08d966c3-26bd-4808-8e49-03d2085e08f4', N'F_Shift', N'班别', N'0', N'1', NULL, N'2021-08-24 13:51:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d966c3-26cc-4466-80b4-6d13851bc7af', N'08d966c3-26bd-4808-8e49-03d2085e08f4', N'F_EqpName', N'设备名称', N'0', N'1', NULL, N'2021-08-24 13:51:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d966c3-26cc-44e4-85f9-06f058e2a3c7', N'08d966c3-26bd-4808-8e49-03d2085e08f4', N'F_DieNum', N'模具号', N'0', N'1', NULL, N'2021-08-24 13:51:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d966c3-26cc-4575-8a5c-767dd451d2d2', N'08d966c3-26bd-4808-8e49-03d2085e08f4', N'F_MaterialName', N'产品名称', N'0', N'1', NULL, N'2021-08-24 13:51:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d966c3-26cc-45e7-86a3-ca4a5ce4b5e1', N'08d966c3-26bd-4808-8e49-03d2085e08f4', N'F_Beat', N'节拍(s)', N'0', N'1', NULL, N'2021-08-24 13:51:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d966c3-26cc-4677-8f16-bd0b6c6ae90b', N'08d966c3-26bd-4808-8e49-03d2085e08f4', N'F_Num', N'总产量', N'0', N'1', NULL, N'2021-08-24 13:51:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d966c3-26cc-470b-8041-37553a8a6b3c', N'08d966c3-26bd-4808-8e49-03d2085e08f4', N'F_SourceBadNum', N'料片报废', N'0', N'1', NULL, N'2021-08-24 13:51:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d966c3-26cc-47a9-8804-d22d5a46042d', N'08d966c3-26bd-4808-8e49-03d2085e08f4', N'F_ProduceBadNum', N'产品报废', N'0', N'1', NULL, N'2021-08-24 13:51:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d966c3-26cc-488b-8751-bfaf0559e682', N'08d966c3-26bd-4808-8e49-03d2085e08f4', N'F_DetailJson', N'明细', N'0', N'1', NULL, N'2021-08-24 13:51:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9679f-315c-4b76-80ee-2aaddb66bbe7', N'08d9679f-3156-4e38-8788-1c11763b3ece', N'F_Date', N'日期', N'0', N'1', NULL, N'2021-08-25 16:06:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9679f-315c-4bf6-8f0d-8d635bd076df', N'08d9679f-3156-4e38-8788-1c11763b3ece', N'F_Shift', N'班别', N'0', N'1', NULL, N'2021-08-25 16:06:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9679f-315c-4c72-8043-1c5efa1ff342', N'08d9679f-3156-4e38-8788-1c11763b3ece', N'F_ProduceException', N'生产异常', N'0', N'1', NULL, N'2021-08-25 16:06:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9679f-315c-4cc8-8cca-da3ac83558b2', N'08d9679f-3156-4e38-8788-1c11763b3ece', N'F_DetailJson', N'明细', N'0', N'1', NULL, N'2021-08-25 16:06:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9679f-315c-4d12-8f8f-8a0ca45d41b2', N'08d9679f-3156-4e38-8788-1c11763b3ece', N'F_WorkerMan', N'值班人', N'0', N'1', NULL, N'2021-08-25 16:06:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9679f-4596-4036-8fa4-c749031c04c1', N'08d9679f-4591-41be-86dc-56924fc0d49c', N'F_Date', N'日期', N'0', N'1', NULL, N'2021-08-25 16:06:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9679f-4596-4085-846b-b0fd6b39cba5', N'08d9679f-4591-41be-86dc-56924fc0d49c', N'F_Shift', N'班别', N'0', N'1', NULL, N'2021-08-25 16:06:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9679f-4596-40c4-871f-d0cc4075e072', N'08d9679f-4591-41be-86dc-56924fc0d49c', N'F_ProduceException', N'生产异常', N'0', N'1', NULL, N'2021-08-25 16:06:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9679f-4596-4107-8e30-71434f953d98', N'08d9679f-4591-41be-86dc-56924fc0d49c', N'F_DetailJson', N'明细', N'0', N'1', NULL, N'2021-08-25 16:06:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d9679f-4596-4144-85f8-16fc09773118', N'08d9679f-4591-41be-86dc-56924fc0d49c', N'F_WorkerMan', N'值班人', N'0', N'1', NULL, N'2021-08-25 16:06:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d98082-e408-498f-866f-179be589a58e', N'08d98082-e3f5-4234-847c-4ff7cc1d0b9f', N'F_Date', N'日期', N'0', N'1', NULL, N'2021-09-26 08:16:31.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d98082-e408-49eb-8849-e62e95cdb5d5', N'08d98082-e3f5-4234-847c-4ff7cc1d0b9f', N'F_FilePath', N'文件路径', N'0', N'1', NULL, N'2021-09-26 08:16:31.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d98082-e408-4a2b-8480-4335a6f307bf', N'08d98082-e3f5-4234-847c-4ff7cc1d0b9f', N'F_MaterialName', N'产品名称', N'0', N'1', NULL, N'2021-09-26 08:16:31.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d98082-e408-4a6a-8102-a5631dd0466d', N'08d98082-e3f5-4234-847c-4ff7cc1d0b9f', N'F_MaterialId', N'物料id', N'0', N'1', NULL, N'2021-09-26 08:16:31.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'08d98082-e408-4aa6-89c9-bbb0adebb70e', N'08d98082-e3f5-4234-847c-4ff7cc1d0b9f', N'F_MaterialCode', N'产品编号', N'0', N'1', NULL, N'2021-09-26 08:16:31.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'0917606f-f448-49d3-b78d-e08a17a1cc4f', N'2c2ddbce-ee87-4134-9b32-54d0bd572910', N'F_CreatorTime', N'创建时间', N'0', N'1', NULL, N'2020-07-08 14:34:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'0927895a-9d35-435c-b980-13f7102043c3', N'484269cb-9aea-4af1-b7f6-f99e7e396ad1', N'F_PrincipalMan', N'联系人', N'0', N'1', NULL, N'2020-06-12 14:33:15.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'094611e9-37b7-4acb-b4a7-842dc6745f04', N'b39698da-6117-433e-8a02-ef1392d1fe3b', N'F_MaterialName', N'物料名称', N'0', N'1', NULL, N'2021-05-21 13:59:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'095a270d-f1f3-4713-ae90-1a23ee0597d1', N'7cce1014-5087-4184-9848-77e164be4e17', N'F_PlanEndTime', N'计划结束时间', N'0', N'1', NULL, N'2020-12-07 12:14:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'0986da5b-16a3-4330-8449-0508699c93e3', N'f82fd629-5f3a-45d6-8681-5ec47e66a807', N'F_SchemeName', N'流程名称', N'0', N'1', NULL, N'2020-07-10 08:50:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'0bee31e0-9c06-4270-980e-05e40090cdda', N'af863666-a357-4e06-bffd-df98e1d29ab8', N'F_IsOtherEqp', N'是否加载流动设备', N'0', N'1', NULL, N'2020-11-30 14:05:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'0c137838-42bc-45e0-a376-c12f161fb449', N'b26cea9c-21ba-42fa-98fc-b8fe0b92451d', N'F_EqpName', N'设备名称', N'0', N'1', NULL, N'2021-05-21 13:57:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'0d216246-f372-48fb-8c2f-dda9924a4625', N'2c2ddbce-ee87-4134-9b32-54d0bd572910', N'F_Content', N'表单原html模板未经处理的', N'0', N'1', NULL, N'2020-07-08 14:34:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'0d373b77-62fa-420d-84b3-b8219f94c0fc', N'ed896675-541a-4d34-bf77-29c87d7a26bb', N'F_EnabledMark', N'F_EnabledMark', N'0', N'1', NULL, N'2020-12-01 14:31:51.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'0f2f8e1b-8dce-4780-9374-d94023e9227d', N'b39698da-6117-433e-8a02-ef1392d1fe3b', N'F_CreatorUserName', N'检验人', N'0', N'1', NULL, N'2021-05-21 13:59:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'113ad8cf-e4cd-4ee5-b825-66014b46e62f', N'a8f0c195-53c5-4b05-b65e-5fafb14a3aec', N'F_NeedId', N'需求id', N'0', N'1', NULL, N'2021-01-15 14:19:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'139014db-12fc-433b-88c8-3893590a624e', N'af863666-a357-4e06-bffd-df98e1d29ab8', N'F_Description', N'设备描述', N'0', N'1', NULL, N'2020-11-30 14:05:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'13e8f8dd-3713-46c9-bbf5-4d5190b8e9b7', N'ed896675-541a-4d34-bf77-29c87d7a26bb', N'F_MaterialDescription', N'料号描述', N'0', N'1', NULL, N'2020-12-01 14:31:51.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'1406d021-de90-4246-af02-6950716214c1', N'a303cbe1-60eb-437b-9a69-77ff8b48f173', N'F_Description', N'备注', N'0', N'1', NULL, N'2020-06-12 13:54:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'14075893-fccf-4011-b875-666e97f80b59', N'a8f0c195-53c5-4b05-b65e-5fafb14a3aec', N'F_JobCode', N'调度编号', N'0', N'1', NULL, N'2021-01-15 14:19:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'1641a15d-87cf-4658-8d39-a1197fb26c43', N'c87cd44f-d064-4d3c-a43e-de01a7a8785e', N'F_ActivityName', N'当前节点名称', N'0', N'1', NULL, N'2020-07-14 09:21:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'16eb5807-81ca-4de5-9eb3-7a5ef6ac7b94', N'ed896675-541a-4d34-bf77-29c87d7a26bb', N'F_MaterialBy', N'料号材质', N'0', N'1', NULL, N'2020-12-01 14:31:51.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'186b9cc1-f4d2-43ad-9369-3f34c1dd7b90', N'c87cd44f-d064-4d3c-a43e-de01a7a8785e', N'F_Code', N'实例编号', N'0', N'1', NULL, N'2020-07-14 09:21:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'18d606fa-4baf-49e7-987d-8dde8561385a', N'484269cb-9aea-4af1-b7f6-f99e7e396ad1', N'F_LogoCode', N'Logo编号', N'0', N'1', NULL, N'2020-06-12 14:33:15.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'1aed66a5-ac73-451d-99a0-fd7ca1da6004', N'5391c5c0-55c0-4132-a26d-5d27fcec1c18', N'F_CreatorTime', N'F_CreatorTime', N'0', N'1', NULL, N'2020-12-17 08:32:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'1b70fa16-9ed5-4142-92d7-42e5f99cb825', N'7cce1014-5087-4184-9848-77e164be4e17', N'F_CreatorUserId', N'F_CreatorUserId', N'0', N'1', NULL, N'2020-12-07 12:14:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'1ba8ebaf-b89c-4699-be3a-520b16efeeb4', N'f82fd629-5f3a-45d6-8681-5ec47e66a807', N'F_FrmId', N'表单ID', N'0', N'1', NULL, N'2020-07-10 08:50:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'1cecc967-7ea1-46d0-b4fa-f90a15783d1c', N'7e4e4a48-4d51-4159-a113-2a211186f13a', N'F_Title', N'标题', N'0', N'1', N'', N'2020-05-22 16:41:18.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-23 09:12:07.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'1eadcbe3-74d7-4192-be4b-5697d89fea6d', N'79c73d26-6f49-463a-9002-98eba48e36b2', N'F_CreatorTime', N'F_CreatorTime', N'0', N'1', NULL, N'2020-12-17 08:31:32.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'1f1bc83a-bb01-4fed-928c-f33288fcb01f', N'25ca371f-9c67-4e0e-9ca7-0dec2e836613', N'F_CreatorTime', N'创建时间', N'0', N'1', NULL, N'2020-12-16 13:38:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'1f7c7123-1777-4d8d-85d3-409c9a9423d4', N'5391c5c0-55c0-4132-a26d-5d27fcec1c18', N'F_LocationCode', N'库位编号', N'0', N'1', NULL, N'2020-12-17 08:32:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'1faf10d8-3007-4e5b-9512-c0ac8fe0a5b7', N'25ca371f-9c67-4e0e-9ca7-0dec2e836613', N'F_InStorageCode', N'入库单编号', N'0', N'1', NULL, N'2020-12-16 13:38:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'1ffb5d50-2dc3-41f0-b863-93c45afd7709', N'f82fd629-5f3a-45d6-8681-5ec47e66a807', N'F_LastModifyUserName', N'修改用户', N'0', N'1', NULL, N'2020-07-10 08:50:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'21a53e80-9887-4ca3-908f-a858c2def860', N'7cb65e00-8af2-4cf2-b318-8ba28b3c154e', N'F_FilePath', N'文件路径', N'0', N'1', NULL, N'2020-07-22 12:05:35.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'21d40431-d289-415f-bfaf-5a23bf4dac9c', N'484269cb-9aea-4af1-b7f6-f99e7e396ad1', N'F_AdminPassword', N'系统密码', N'0', N'1', N'', N'2020-06-12 14:33:15.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-15 14:23:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'22289940-a299-4d46-b68a-204bfab51b01', N'c87cd44f-d064-4d3c-a43e-de01a7a8785e', N'F_EnabledMark', N'有效', N'0', N'1', NULL, N'2020-07-14 09:21:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'25507ea6-0c09-46d5-8887-0c083edc4efa', N'5391c5c0-55c0-4132-a26d-5d27fcec1c18', N'F_AreaCode', N'库区编号', N'0', N'1', NULL, N'2020-12-17 08:32:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'25612b64-9499-46fd-9a3d-779362a3cba2', N'7cb65e00-8af2-4cf2-b318-8ba28b3c154e', N'F_CreatorUserName', N'创建用户', N'0', N'1', NULL, N'2020-07-22 12:05:35.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'26196897-58b0-4ba5-b71c-5802c78064e7', N'ed896675-541a-4d34-bf77-29c87d7a26bb', N'F_CreatorTime', N'F_CreatorTime', N'0', N'1', NULL, N'2020-12-01 14:31:51.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'263acbf3-44b2-4be5-82ce-8a038d43a5c5', N'7cb65e00-8af2-4cf2-b318-8ba28b3c154e', N'F_Description', N'备注', N'0', N'1', NULL, N'2020-07-22 12:05:35.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'27170f5a-fe07-46aa-9772-07493acb5eb2', N'828084e8-4361-40f2-bd3e-96acb4bc229b', N'F_Password', N'密码', N'0', N'1', NULL, N'2021-01-25 09:03:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'2748bc96-8238-4942-aa1b-767cbbda6d26', N'ed896675-541a-4d34-bf77-29c87d7a26bb', N'F_MaterialPic', N'图片路径', N'0', N'1', NULL, N'2020-12-01 14:31:51.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'27b53e39-bad5-4710-8967-8993f5a40de2', N'39226710-b665-489e-aaa0-a8c15d29ed4c', N'F_CreatorTime', N'F_CreatorTime', N'0', N'1', NULL, N'2020-12-03 13:56:34.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'28cac0d8-2e64-4d04-a112-10268f597a23', N'a8f0c195-53c5-4b05-b65e-5fafb14a3aec', N'F_CreatorUserId', N'F_CreatorUserId', N'0', N'1', NULL, N'2021-01-15 14:19:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'29ac033c-6963-437d-ae44-bef31d7a984c', N'b26cea9c-21ba-42fa-98fc-b8fe0b92451d', N'F_MaterialBatch', N'物料批次', N'0', N'1', NULL, N'2021-05-21 13:57:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'2e5702e7-829f-46a2-ac2a-a09b76a084a4', N'b26cea9c-21ba-42fa-98fc-b8fe0b92451d', N'F_IsCheck', N'检验标识', N'0', N'1', NULL, N'2021-05-21 13:57:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'2e6d1a10-ebaf-4458-a697-16f5a64694f5', N'b26cea9c-21ba-42fa-98fc-b8fe0b92451d', N'F_TransferBoxCode', N'流转箱编号', N'0', N'1', NULL, N'2021-05-21 13:57:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'309c622d-2217-499f-aa83-2eccd72205a1', N'484269cb-9aea-4af1-b7f6-f99e7e396ad1', N'F_CreatorTime', N'创建时间', N'0', N'1', N'', N'2020-06-12 14:33:15.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-12 14:35:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'31e67c21-b265-4736-9807-d1f6a4c98b77', N'af863666-a357-4e06-bffd-df98e1d29ab8', N'F_CreatorTime', N'F_CreatorTime', N'0', N'1', NULL, N'2020-11-30 14:05:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'33f55a8a-1daf-4adb-9931-1b6cace1c13a', N'2c2ddbce-ee87-4134-9b32-54d0bd572910', N'F_EnabledMark', N'是否启用', N'0', N'1', NULL, N'2020-07-08 14:34:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'344cf340-e664-446f-ba79-6d37e466f9d8', N'7cb65e00-8af2-4cf2-b318-8ba28b3c154e', N'F_FileSize', N'文件大小', N'0', N'1', NULL, N'2020-07-22 12:05:35.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'35fd6dcf-a4ad-46aa-b8c6-f980fdcefcfe', N'5391c5c0-55c0-4132-a26d-5d27fcec1c18', N'F_SortCode', N'顺序', N'0', N'1', NULL, N'2020-12-17 08:32:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'3633fbd2-bc69-4c09-8b0e-655c424f367a', N'828084e8-4361-40f2-bd3e-96acb4bc229b', N'F_Account', N'账户', N'0', N'1', NULL, N'2021-01-25 09:03:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'36df66b8-bcf1-43bf-92d5-ea915faa8b94', N'2c2ddbce-ee87-4134-9b32-54d0bd572910', N'F_Description', N'内容', N'0', N'1', NULL, N'2020-07-08 14:34:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'39311645-780a-4c55-9f52-6c7ae80b0f02', N'7cce1014-5087-4184-9848-77e164be4e17', N'F_WorkOrderCode', N'工单编号', N'0', N'1', NULL, N'2020-12-07 12:14:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'3961f233-46ef-4fd2-815e-733bb288946c', N'2c2ddbce-ee87-4134-9b32-54d0bd572910', N'F_ContentData', N'表单中的控件属性描述', N'0', N'1', NULL, N'2020-07-08 14:34:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'39fce29e-2dad-38db-332f-fb638a6e64fa', N'39fce29e-2d24-934c-432b-87fda7e92d81', N'F_JobType', N'0补货，1入库，2出库，3产出上架，4移库，5作业开始，6作业结束,7领用退回', N'0', N'1', NULL, N'2021-06-03 13:55:59.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'39fce29e-2dad-584b-b88f-8f014cf32b36', N'39fce29e-2d24-934c-432b-87fda7e92d81', N'F_UserId', N'用户ID', N'0', N'1', NULL, N'2021-06-03 13:55:59.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'39fce29e-2dad-ff3e-10ec-2678a6b671eb', N'39fce29e-2d24-934c-432b-87fda7e92d81', N'F_EqpId', N'设备ID', N'0', N'1', NULL, N'2021-06-03 13:55:59.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'3a02b650-09c6-4826-add8-cef8504b43b1', N'84e5ec65-f803-485e-b703-4d07eaaf6c05', N'F_MaterialType', N'料号分类', N'0', N'1', NULL, N'2020-12-16 13:39:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'3b304c8d-a54d-47b7-ad21-e6d01c283904', N'91A6CFAD-B2F9-4294-BDAE-76DECF412C6C', N'F_CreatorUserName', N'创建人', N'0', N'1', N'', N'2020-06-03 09:57:59.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'3cede4da-ece7-4cd0-a7eb-f149d86b967c', N'84e5ec65-f803-485e-b703-4d07eaaf6c05', N'F_CreatorUserId', N'创建人id', N'0', N'1', NULL, N'2020-12-16 13:39:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'3e4609b9-0b5e-4334-aca5-00b5fc9c4af6', N'7cce1014-5087-4184-9848-77e164be4e17', N'F_RealEndTime', N'结束时间', N'0', N'1', NULL, N'2020-12-07 12:14:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'3e83c9d7-fdde-4626-81d3-f2e4d26d238d', N'b39698da-6117-433e-8a02-ef1392d1fe3b', N'F_IsCheck', N'检验完成', N'0', N'1', NULL, N'2021-05-21 13:59:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'3fd72c46-64cc-49a8-b868-ae692e870971', N'7cce1014-5087-4184-9848-77e164be4e17', N'F_PlanStartTime', N'计划开始时间', N'0', N'1', NULL, N'2020-12-07 12:14:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'3fee41bd-64a6-4280-ac93-0ce835fecf41', N'c87cd44f-d064-4d3c-a43e-de01a7a8785e', N'F_CreatorTime', N'创建时间', N'0', N'1', NULL, N'2020-07-14 09:21:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'437568ca-c79a-418e-ac50-5f218e552e96', N'b26cea9c-21ba-42fa-98fc-b8fe0b92451d', N'F_ScapNum', N'报废数量', N'0', N'1', NULL, N'2021-05-21 13:57:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'4461450b-3e3a-46e6-9ae8-e13180d772d2', N'7cce1014-5087-4184-9848-77e164be4e17', N'F_EnabledMark', N'F_EnabledMark', N'0', N'1', NULL, N'2020-12-07 12:14:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'452cbcbf-c195-4d93-ad33-7c672013eafb', N'788d27cb-598d-41da-ac11-b7ddf0914b08', N'F_CreatorTime', N'创建时间', N'0', N'1', NULL, N'2020-11-21 09:55:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'45f62f54-8ad4-45f2-9f37-a7f0d15ee815', N'484269cb-9aea-4af1-b7f6-f99e7e396ad1', N'F_Description', N'备注', N'0', N'1', NULL, N'2020-06-12 14:33:15.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'468541e1-5c2e-481c-adb8-f8fc9e28aaa4', N'7cce1014-5087-4184-9848-77e164be4e17', N'F_PlanNum', N'计划数量', N'0', N'1', NULL, N'2020-12-07 12:14:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'47b8d043-aa5e-4a09-98b1-aaf24d6589dd', N'7cb65e00-8af2-4cf2-b318-8ba28b3c154e', N'F_FileBy', N'文件所属', N'0', N'1', NULL, N'2020-07-22 12:05:35.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'48b1d488-1bb3-48c4-9893-4f38409a7b2e', N'788d27cb-598d-41da-ac11-b7ddf0914b08', N'F_RedirectUrl', N'回调地址', N'0', N'1', NULL, N'2020-11-21 09:55:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'4986e7eb-efa4-4143-979a-708cfcb3ebfa', N'd9078b9a-5db6-4429-b489-3700e56f367f', N'F_PrintTemplatePath', N'模板地址', N'0', N'1', NULL, N'2021-01-14 13:24:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'49d6a83e-646f-48af-b71e-8f8d60f73396', N'a303cbe1-60eb-437b-9a69-77ff8b48f173', N'F_DbString', N'连接字符串', N'0', N'1', N'', N'2020-06-12 13:54:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-12 13:57:26.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'4b2b3c5b-22f0-4a64-9857-c794f1d8a181', N'a303cbe1-60eb-437b-9a69-77ff8b48f173', N'F_LogoCode', N'Logo编号', N'0', N'1', NULL, N'2020-06-12 13:54:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'4d0ece5d-bb05-4730-990c-02488a5ede60', N'b39698da-6117-433e-8a02-ef1392d1fe3b', N'F_TransferBoxCode', N'退回流转箱编号', N'0', N'1', NULL, N'2021-05-21 13:59:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'4dd71c0e-68e8-4e7d-9c7e-2a5046c97555', N'b39698da-6117-433e-8a02-ef1392d1fe3b', N'F_IsBack', N'是否正常', N'0', N'1', NULL, N'2021-05-21 13:59:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'4e90e4dc-fc8d-456e-aa7d-2420e31212c2', N'e9190a56-e173-4483-8a3e-f17b86e4766e', N'F_ToUserId', N'收件人主键', N'0', N'1', NULL, N'2020-07-29 16:44:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'506bdb21-9de2-48b2-83e5-ea5f90d9e88a', N'b39698da-6117-433e-8a02-ef1392d1fe3b', N'F_CreatorTime', N'检验时间', N'0', N'1', NULL, N'2021-05-21 13:59:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'506e828f-6ff6-48c5-890a-1bcb70d3e57b', N'd9078b9a-5db6-4429-b489-3700e56f367f', N'F_CreatorUserId', N'F_CreatorUserId', N'0', N'1', NULL, N'2021-01-14 13:24:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'5100bb13-038a-45b7-aa54-cd3cf7887d40', N'8968b428-2a8b-4dbe-ad47-73dd408ddd5e', N'F_CreatorTime', N'F_CreatorTime', N'0', N'1', NULL, N'2020-12-03 09:49:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'523a8089-d975-4c73-97a3-95bd0fffff10', N'84e5ec65-f803-485e-b703-4d07eaaf6c05', N'F_OutStorageCode', N'出库单编号', N'0', N'1', NULL, N'2020-12-16 13:39:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'52d0ff8a-b1c2-4766-89bb-410a8181fa13', N'ed896675-541a-4d34-bf77-29c87d7a26bb', N'F_MaterialType', N'料号分类', N'0', N'1', NULL, N'2020-12-01 14:31:51.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'52ebd42b-245a-48bf-83bc-ea0030c933cc', N'39226710-b665-489e-aaa0-a8c15d29ed4c', N'F_SonMaterialId', N'组成主键-n', N'0', N'1', NULL, N'2020-12-03 13:56:34.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'54109c70-142b-47fa-b7fe-1e2efd8862d4', N'a8f0c195-53c5-4b05-b65e-5fafb14a3aec', N'F_CreatorTime', N'F_CreatorTime', N'0', N'1', NULL, N'2021-01-15 14:19:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'588cdc6a-716c-480e-acc3-30937dd44dc4', N'a8f0c195-53c5-4b05-b65e-5fafb14a3aec', N'F_FinishId', N'完成id', N'0', N'1', NULL, N'2021-01-15 14:19:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'5a218598-40b4-4046-a61e-e7b4f8dd0d85', N'f82fd629-5f3a-45d6-8681-5ec47e66a807', N'F_SchemeContent', N'流程内容', N'0', N'1', NULL, N'2020-07-10 08:50:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'5b2cb54c-5fe8-4f8f-b281-d6de27dcfc18', N'7cb65e00-8af2-4cf2-b318-8ba28b3c154e', N'F_FileType', N'文件类型', N'0', N'1', NULL, N'2020-07-22 12:05:35.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'5b369ae0-ce33-4ab5-a954-f29e4a6c1ba6', N'ed896675-541a-4d34-bf77-29c87d7a26bb', N'F_CustomerProNO', N'客户品号', N'0', N'1', NULL, N'2020-12-01 14:31:51.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'5ce0ba1f-f21f-42d2-9e36-7ddead3461f7', N'8968b428-2a8b-4dbe-ad47-73dd408ddd5e', N'F_EnabledMark', N'F_EnabledMark', N'0', N'1', NULL, N'2020-12-03 09:49:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'5e1693ab-9d98-4a14-9afc-fef1d51ac347', N'b26cea9c-21ba-42fa-98fc-b8fe0b92451d', N'F_CheckType', N'检验类型', N'0', N'1', NULL, N'2021-05-21 13:57:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'61b72ebf-78d0-4235-985f-733c06f104cd', N'af863666-a357-4e06-bffd-df98e1d29ab8', N'F_PlanUserNum', N'预计使用次数', N'0', N'1', NULL, N'2020-11-30 14:05:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'61cff792-0cc4-4d46-9bd5-eb5fc272dfeb', N'828084e8-4361-40f2-bd3e-96acb4bc229b', N'F_Description', N'备注', N'0', N'1', NULL, N'2021-01-25 09:03:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'642e8c4b-7762-42b6-9fbd-8495c54606a2', N'a303cbe1-60eb-437b-9a69-77ff8b48f173', N'F_Logo', N'Logo图标', N'0', N'1', NULL, N'2020-06-12 13:54:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'67964562-bd8d-46b6-a5c8-86a17d00dcd5', N'39226710-b665-489e-aaa0-a8c15d29ed4c', N'F_Num', N'数量', N'0', N'1', NULL, N'2020-12-03 13:56:34.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'6b797d08-1ba2-4ef1-a4b7-bf2e193a547c', N'a8f0c195-53c5-4b05-b65e-5fafb14a3aec', N'F_JobState', N'任务状态（0等待，1执行，2完成）', N'0', N'1', NULL, N'2021-01-15 14:19:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'6c6a951c-44ea-4544-b63c-8f018096c007', N'af863666-a357-4e06-bffd-df98e1d29ab8', N'F_ParentId', N'F_ParentId', N'0', N'1', NULL, N'2020-11-30 14:05:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'6d1a0016-9634-4425-b840-af55f4fb383f', N'a303cbe1-60eb-437b-9a69-77ff8b48f173', N'F_DBProvider', N'数据库类型', N'0', N'1', N'', N'2020-06-12 13:54:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-12 13:57:21.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'6e177e5f-4ce8-4f7b-b790-b320bb2659db', N'a303cbe1-60eb-437b-9a69-77ff8b48f173', N'F_EnabledMark', N'有效', N'0', N'1', NULL, N'2020-06-12 13:54:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'6ea5fcb1-7fa3-4750-b39d-c580df5fc645', N'e093b2d3-ec49-4b4d-91ec-63f57f4e3f1d', N'F_EnabledMark', N'F_EnabledMark', N'0', N'1', NULL, N'2020-12-14 12:44:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'6ec6ed61-884c-4519-904c-2f3cb717aef7', N'a303cbe1-60eb-437b-9a69-77ff8b48f173', N'F_PrincipalMan', N'联系人', N'0', N'1', NULL, N'2020-06-12 13:54:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'6ffce56e-bd4c-4e53-907a-fa4c5be9543e', N'b39698da-6117-433e-8a02-ef1392d1fe3b', N'F_MaterialType', N'物料分类', N'0', N'1', NULL, N'2021-05-21 13:59:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'702f2c2e-b66e-44e8-a846-fd96c38027e3', N'c87cd44f-d064-4d3c-a43e-de01a7a8785e', N'F_CustomName', N'实例名称', N'0', N'1', NULL, N'2020-07-14 09:21:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'7209885d-9f4a-4071-a104-714aae9a84d4', N'b26cea9c-21ba-42fa-98fc-b8fe0b92451d', N'F_MaterialCode', N'物料编号', N'0', N'1', NULL, N'2021-05-21 13:57:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'736f74b5-b794-408a-b271-056656eacc97', N'84e5ec65-f803-485e-b703-4d07eaaf6c05', N'F_MaterialBatch', N'料号批次', N'0', N'1', NULL, N'2020-12-16 13:39:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'7419ac65-7138-480f-9196-cec7c6c2ff40', N'25ca371f-9c67-4e0e-9ca7-0dec2e836613', N'F_Description', N'备注', N'0', N'1', NULL, N'2020-12-16 13:38:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'7496086e-32ec-4875-8013-73ce1c2784a2', N'e9190a56-e173-4483-8a3e-f17b86e4766e', N'F_CreatorUserId', N'创建用户主键', N'0', N'1', NULL, N'2020-07-29 16:44:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'7556eb6c-982a-4fde-b6c5-c312524a7e87', N'af863666-a357-4e06-bffd-df98e1d29ab8', N'F_IsMaintain', N'是否需要保养', N'0', N'1', NULL, N'2020-11-30 14:05:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'756ce041-ad4f-4895-b184-d9c9c4df9a04', N'38CA5A66-C993-4410-AF95-50489B22939C', N'F_OrganizeId', N'部门Id', N'0', N'1', N'', N'2020-06-08 16:25:17.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'75c41f22-fa5f-4ed9-a64d-54b80e4b9669', N'79c73d26-6f49-463a-9002-98eba48e36b2', N'F_Description', N'备注', N'0', N'1', NULL, N'2020-12-17 08:31:32.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'760601a9-28f2-415a-b838-14b9cbe9f411', N'd9078b9a-5db6-4429-b489-3700e56f367f', N'F_PrintTemplateName', N'模板名称', N'0', N'1', NULL, N'2021-01-14 13:24:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'765c254a-111f-46ad-815a-561066b63d1d', N'39226710-b665-489e-aaa0-a8c15d29ed4c', N'F_MaterialId', N'料号主键-1', N'0', N'1', NULL, N'2020-12-03 13:56:34.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'7694c8c5-34ba-42fd-bb9e-537f91127538', N'af863666-a357-4e06-bffd-df98e1d29ab8', N'F_UserDate', N'接受日期', N'0', N'1', NULL, N'2020-11-30 14:05:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'76a12c51-00c7-4bf0-af5a-0dfa745c119e', N'b26cea9c-21ba-42fa-98fc-b8fe0b92451d', N'F_CreatorTime', N'创建时间', N'0', N'1', NULL, N'2021-05-21 13:57:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'76cbcdd9-ffeb-41a1-8f9c-51dea4a02fa2', N'a303cbe1-60eb-437b-9a69-77ff8b48f173', N'F_EndTime', N'到期时间', N'0', N'1', NULL, N'2020-06-12 13:54:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'76e64bb6-cb36-45c4-852f-6a044d5b2c3d', N'f82fd629-5f3a-45d6-8681-5ec47e66a807', N'F_SchemeType', N'流程分类', N'0', N'1', NULL, N'2020-07-10 08:50:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'770af4b6-29ef-47b1-aea8-6092562d9800', N'2c2ddbce-ee87-4134-9b32-54d0bd572910', N'F_ContentParse', N'表单控件位置模板', N'0', N'1', NULL, N'2020-07-08 14:34:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'78060317-6db4-4cc8-ab06-49b6c65c5a7d', N'5391c5c0-55c0-4132-a26d-5d27fcec1c18', N'F_EnabledMark', N'F_EnabledMark', N'0', N'1', NULL, N'2020-12-17 08:32:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'78981dd9-c948-47b9-9b10-075b0db74cad', N'84e5ec65-f803-485e-b703-4d07eaaf6c05', N'F_MaterialCode', N'料号描述', N'0', N'1', NULL, N'2020-12-16 13:39:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'78a9a6c0-e854-4225-b75e-5e7cfaf46c67', N'a303cbe1-60eb-437b-9a69-77ff8b48f173', N'F_ProjectName', N'项目名称', N'0', N'1', N'', N'2020-06-12 13:54:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-12 13:56:54.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'7a23d352-33fa-4eba-a2d1-b99da996d824', N'af863666-a357-4e06-bffd-df98e1d29ab8', N'F_EqpState', N'F_EqpState', N'0', N'1', NULL, N'2020-11-30 14:05:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'7a5d9c75-e32a-4a7e-99f2-6169edf13042', N'828084e8-4361-40f2-bd3e-96acb4bc229b', N'F_CreatorUserId', N'F_CreatorUserId', N'0', N'1', NULL, N'2021-01-25 09:03:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'7bbc0446-3621-4f8a-b913-f5889057c0f3', N'788d27cb-598d-41da-ac11-b7ddf0914b08', N'F_AppId', N'AppId', N'0', N'1', NULL, N'2020-11-21 09:55:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'7c9f1bbc-4efc-40cf-bc1f-72fc826bfab8', N'b26cea9c-21ba-42fa-98fc-b8fe0b92451d', N'F_Description', N'检验信息', N'0', N'1', NULL, N'2021-05-21 13:57:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'7d7bfd9b-93f8-4a31-ab35-b361082de79b', N'a8f0c195-53c5-4b05-b65e-5fafb14a3aec', N'F_EnabledMark', N'F_EnabledMark', N'0', N'1', NULL, N'2021-01-15 14:19:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'7dfa39c1-a8d3-4460-922b-5a770d6e307f', N'f82fd629-5f3a-45d6-8681-5ec47e66a807', N'F_SchemeCode', N'流程编号', N'0', N'1', NULL, N'2020-07-10 08:50:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'8024dfbc-8236-4a86-8869-d09e59c3dfe3', N'91A6CFAD-B2F9-4294-BDAE-76DECF412C6C', N'F_CreatorTime', N'创建时间', N'0', N'1', N'', N'2020-06-03 09:57:59.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-05-22 17:06:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'80899139-2938-4e0a-9f80-16bf70d00658', N'7cb65e00-8af2-4cf2-b318-8ba28b3c154e', N'F_CreatorTime', N'创建时间', N'0', N'1', NULL, N'2020-07-22 12:05:35.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'81d404d1-5639-4d5a-8ac1-d47b0414c321', N'e9190a56-e173-4483-8a3e-f17b86e4766e', N'F_MessageType', N'信息类型（通知、私信、处理）', N'0', N'1', NULL, N'2020-07-29 16:44:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'81d74921-21be-4360-bae3-653d0fade184', N'c87cd44f-d064-4d3c-a43e-de01a7a8785e', N'F_CreatorUserName', N'创建用户', N'0', N'1', NULL, N'2020-07-14 09:21:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'823b9649-030c-4dbb-b790-b184565f4746', N'c87cd44f-d064-4d3c-a43e-de01a7a8785e', N'F_MakerList', N'执行人', N'0', N'1', NULL, N'2020-07-14 09:21:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'82f21e4c-0d14-4559-92d4-657b34640a47', N'f82fd629-5f3a-45d6-8681-5ec47e66a807', N'F_SortCode', N'排序码', N'0', N'1', NULL, N'2020-07-10 08:50:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'83584b47-0a29-446d-8ff2-6c6d3eccca3d', N'c87cd44f-d064-4d3c-a43e-de01a7a8785e', N'F_FrmId', N'表单ID', N'0', N'1', NULL, N'2020-07-14 09:21:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'8376537c-b23b-4b51-a6f0-75fc3467c574', N'2c2ddbce-ee87-4134-9b32-54d0bd572910', N'F_Fields', N'字段个数', N'0', N'1', NULL, N'2020-07-08 14:34:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'83e5307e-29e4-4310-8996-dd60a9e1dfaf', N'8968b428-2a8b-4dbe-ad47-73dd408ddd5e', N'F_Description', N'工序备注', N'0', N'1', NULL, N'2020-12-03 09:49:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'84b3ac62-5d85-4263-946d-e12be86cbfa1', N'7cb65e00-8af2-4cf2-b318-8ba28b3c154e', N'F_FileName', N'文件名称', N'0', N'1', NULL, N'2020-07-22 12:05:35.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'886485a3-188b-4821-b0e6-44342892213a', N'e093b2d3-ec49-4b4d-91ec-63f57f4e3f1d', N'F_TransferMaxNum', N'流转箱最大数', N'0', N'1', NULL, N'2020-12-14 12:44:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'889fc780-cd2f-45c9-b07c-030e6d3ddc29', N'e9190a56-e173-4483-8a3e-f17b86e4766e', N'F_CreatorUserName', N'创建用户', N'0', N'1', NULL, N'2020-07-29 16:44:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'8b15457f-7b9b-45e4-af53-f821c3210abb', N'828084e8-4361-40f2-bd3e-96acb4bc229b', N'F_EnabledMark', N'F_EnabledMark', N'0', N'1', NULL, N'2021-01-25 09:03:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'8ba0c532-4b85-4a02-aec8-499d93b97dcb', N'a303cbe1-60eb-437b-9a69-77ff8b48f173', N'F_CreatorTime', N'创建时间', N'0', N'1', NULL, N'2020-06-12 13:54:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'8c16bb85-1e95-4dd3-8537-b15d20cd7ee5', N'ed896675-541a-4d34-bf77-29c87d7a26bb', N'F_Description', N'备注', N'0', N'1', NULL, N'2020-12-01 14:31:51.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'8cb969f8-d126-42e5-81de-279e65a474d3', N'a8f0c195-53c5-4b05-b65e-5fafb14a3aec', N'F_JobInfo', N'调度信息', N'0', N'1', NULL, N'2021-01-15 14:19:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'8cf11fd0-8ee5-408d-9d5d-15c4342befda', N'f82fd629-5f3a-45d6-8681-5ec47e66a807', N'F_OrganizeId', N'所属部门', N'0', N'1', NULL, N'2020-07-10 08:50:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'8d95deea-2b01-453c-85ed-955c48d4b3e4', N'84e5ec65-f803-485e-b703-4d07eaaf6c05', N'F_Description', N'备注', N'0', N'1', NULL, N'2020-12-16 13:39:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'8f5ce993-986c-4825-b3bc-f34f54d4f37f', N'c87cd44f-d064-4d3c-a43e-de01a7a8785e', N'F_FlowLevel', N'等级', N'0', N'1', NULL, N'2020-07-14 09:21:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'8f8260d2-7459-428c-ad95-be3df2023f94', N'788d27cb-598d-41da-ac11-b7ddf0914b08', N'F_AgentId', N'AgentId', N'0', N'1', NULL, N'2020-11-21 09:55:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'8f949940-dc8d-46a1-8a73-8680256d978f', N'39226710-b665-489e-aaa0-a8c15d29ed4c', N'F_CreatorUserId', N'F_CreatorUserId', N'0', N'1', NULL, N'2020-12-03 13:56:34.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'8f9b9573-e271-469b-86e7-6cb3283ac6c3', N'39226710-b665-489e-aaa0-a8c15d29ed4c', N'F_EnabledMark', N'F_EnabledMark', N'0', N'1', NULL, N'2020-12-03 13:56:34.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'90386357-54f8-4aeb-8b24-f45ee8c08ba4', N'c87cd44f-d064-4d3c-a43e-de01a7a8785e', N'F_OrganizeId', N'所属部门', N'0', N'1', NULL, N'2020-07-14 09:21:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'9088560d-f73e-4cb4-babd-0e6bedfe87cb', N'788d27cb-598d-41da-ac11-b7ddf0914b08', N'F_DingType', N'应用类型', N'0', N'1', NULL, N'2020-11-21 09:55:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'91b3ca56-61e8-444d-b506-7dec452f1daa', N'c87cd44f-d064-4d3c-a43e-de01a7a8785e', N'F_SchemeContent', N'流程模板内容', N'0', N'1', NULL, N'2020-07-14 09:21:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'92fcbab0-0e8d-4201-ab94-12291a0123fc', N'a8f0c195-53c5-4b05-b65e-5fafb14a3aec', N'F_DoneUserId', N'执行人id', N'0', N'1', NULL, N'2021-01-15 14:19:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'9306a857-ef87-4a73-a801-9da0a697bfd2', N'84e5ec65-f803-485e-b703-4d07eaaf6c05', N'F_MaterialName', N'料号描述', N'0', N'1', NULL, N'2020-12-16 13:39:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'936023df-503f-4322-b243-47158c9617a6', N'484269cb-9aea-4af1-b7f6-f99e7e396ad1', N'F_EndTime', N'到期时间', N'0', N'1', NULL, N'2020-06-16 09:38:15.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'9507a93a-a258-4ba1-93db-d51798268c5e', N'a303cbe1-60eb-437b-9a69-77ff8b48f173', N'F_CreatorUserId', N'创建人Id', N'0', N'1', N'', N'2020-06-12 13:54:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-12 13:57:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'95e5bdc5-03f1-48bc-9abc-5dfb3eb7063a', N'7cce1014-5087-4184-9848-77e164be4e17', N'F_RealStartTime', N'开始时间', N'0', N'1', NULL, N'2020-12-07 12:14:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'96938fba-948f-422e-8566-bd851151991a', N'84e5ec65-f803-485e-b703-4d07eaaf6c05', N'F_EnabledMark', N'F_EnabledMark', N'0', N'1', NULL, N'2020-12-16 13:39:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'97e01394-7d87-4242-8088-807abbff77c2', N'a8f0c195-53c5-4b05-b65e-5fafb14a3aec', N'F_JobType', N'调度类型（0补货，1下料，2入库，3出库，4移库，5作业开始，6作业结束）', N'0', N'1', NULL, N'2021-01-15 14:19:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'985ab6e3-3818-432c-9d6b-050953bf126c', N'828084e8-4361-40f2-bd3e-96acb4bc229b', N'F_CreatorTime', N'F_CreatorTime', N'0', N'1', NULL, N'2021-01-25 09:03:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'98d6c90c-a46a-49f0-a800-acf97e47bf70', N'84e5ec65-f803-485e-b703-4d07eaaf6c05', N'F_MaterialUnit', N'料号单位', N'0', N'1', NULL, N'2020-12-16 13:39:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'98e7930d-37f0-4499-874d-b89207657eaa', N'7cb65e00-8af2-4cf2-b318-8ba28b3c154e', N'F_OrganizeId', N'所属部门', N'0', N'1', NULL, N'2020-07-22 12:05:35.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'99ecc5e7-2b02-49d8-b091-ee1aec8130ee', N'f82fd629-5f3a-45d6-8681-5ec47e66a807', N'F_Description', N'备注', N'0', N'1', NULL, N'2020-07-10 08:50:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'9b55ddc4-8e5d-4790-be72-4213559b0961', N'b26cea9c-21ba-42fa-98fc-b8fe0b92451d', N'F_LocationCode', N'库位号', N'0', N'1', NULL, N'2021-05-21 13:57:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'9c838bd8-cd68-4d95-a948-5916c52adb23', N'79c73d26-6f49-463a-9002-98eba48e36b2', N'F_EnabledMark', N'F_EnabledMark', N'0', N'1', NULL, N'2020-12-17 08:31:32.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'9e9256e3-bcbb-4be1-b26d-aa832f268580', N'25ca371f-9c67-4e0e-9ca7-0dec2e836613', N'F_MaterialCode', N'料号描述', N'0', N'1', NULL, N'2020-12-16 13:38:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'9f1e6816-49ab-40ff-a0f3-19946c7d6d7b', N'25ca371f-9c67-4e0e-9ca7-0dec2e836613', N'F_MaterialName', N'料号描述', N'0', N'1', NULL, N'2020-12-16 13:38:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'a24c4b7c-6f97-4a68-90b7-c11dd563ea0f', N'ed896675-541a-4d34-bf77-29c87d7a26bb', N'F_MaterialName', N'料号名称', N'0', N'1', NULL, N'2020-12-01 14:31:51.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'a24c6ed3-8c91-4ade-a5c1-8c5eb9719368', N'484269cb-9aea-4af1-b7f6-f99e7e396ad1', N'F_AdminAccount', N'系统账户', N'0', N'1', N'', N'2020-06-12 14:33:15.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-15 14:23:30.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'a4549ab8-73c9-40a1-82ee-1fb794cb651e', N'a8f0c195-53c5-4b05-b65e-5fafb14a3aec', N'F_Description', N'备注', N'0', N'1', NULL, N'2021-01-15 14:19:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'a4bee312-7dde-4594-8f2b-8f357f2cfc90', N'af863666-a357-4e06-bffd-df98e1d29ab8', N'F_UsedNum', N'已使用次数', N'0', N'1', NULL, N'2020-11-30 14:05:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'a619715a-46b9-4b3e-81d2-a450038dceb6', N'c87cd44f-d064-4d3c-a43e-de01a7a8785e', N'F_Description', N'实例备注', N'0', N'1', NULL, N'2020-07-14 09:21:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'a6320b89-1c15-4afa-9c30-2e1f508212e2', N'484269cb-9aea-4af1-b7f6-f99e7e396ad1', N'F_HostUrl', N'域名', N'0', N'1', N'', N'2020-06-15 17:01:14.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-15 17:01:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'a8d7783d-d2eb-424f-a27e-66ea092fc604', N'84e5ec65-f803-485e-b703-4d07eaaf6c05', N'F_MaterialId', N'料号Id', N'0', N'1', NULL, N'2020-12-16 13:39:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'a8e25165-3366-4d06-9145-beefc80156b3', N'd9078b9a-5db6-4429-b489-3700e56f367f', N'F_Description', N'备注', N'0', N'1', NULL, N'2021-01-14 13:24:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'a96a4a9f-7685-4478-920c-fc192840505c', N'e093b2d3-ec49-4b4d-91ec-63f57f4e3f1d', N'F_Description', N'备注', N'0', N'1', NULL, N'2020-12-14 12:44:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'a983cc2e-d045-4c35-a53e-2f0775edf639', N'f82fd629-5f3a-45d6-8681-5ec47e66a807', N'F_CreatorUserName', N'创建用户', N'0', N'1', NULL, N'2020-07-10 08:50:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'aa191acb-86fe-4204-b24c-d27d7cdef4ee', N'25ca371f-9c67-4e0e-9ca7-0dec2e836613', N'F_Num', N'数量', N'0', N'1', NULL, N'2020-12-16 13:38:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'aa75975a-bf00-429b-8c58-825b43d29eb4', N'2c2ddbce-ee87-4134-9b32-54d0bd572910', N'F_SortCode', N'排序码', N'0', N'1', NULL, N'2020-07-08 14:34:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'ade5f260-395e-4ad9-9454-83d1574ef892', N'e093b2d3-ec49-4b4d-91ec-63f57f4e3f1d', N'F_TransferCode', N'流转箱编号', N'0', N'1', NULL, N'2020-12-14 12:44:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'ae4282b2-30ff-48e8-9e3d-9863ceb6c438', N'af863666-a357-4e06-bffd-df98e1d29ab8', N'F_CreatorUserId', N'F_CreatorUserId', N'0', N'1', NULL, N'2020-11-30 14:05:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'ae98e800-05b8-4a67-ab20-03aa1eebb7c8', N'af863666-a357-4e06-bffd-df98e1d29ab8', N'F_MaintainNum', N'保养周期', N'0', N'1', NULL, N'2020-11-30 14:05:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'b06b2f6f-c392-473f-bea7-96bcf04a025d', N'c87cd44f-d064-4d3c-a43e-de01a7a8785e', N'F_IsFinish', N'是否完成', N'0', N'1', NULL, N'2020-07-14 09:21:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'b0da4158-e71b-45cc-9cc4-a3547631295c', N'a8f0c195-53c5-4b05-b65e-5fafb14a3aec', N'F_IsToPlanMan', N'是否发送计划人员', N'0', N'1', NULL, N'2021-01-15 14:19:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'b1d0e803-5b57-4629-9db3-2d232c09cf8a', N'7cce1014-5087-4184-9848-77e164be4e17', N'F_DoneNum', N'完成数量', N'0', N'1', NULL, N'2020-12-07 12:14:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'b1e5e6d9-970e-4422-9ccd-1465da1ec45b', N'b39698da-6117-433e-8a02-ef1392d1fe3b', N'F_CheckType', N'检验类型', N'0', N'1', NULL, N'2021-05-21 13:59:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'b2e8a59b-99ce-432b-b5ed-e7c8859dcfad', N'c87cd44f-d064-4d3c-a43e-de01a7a8785e', N'F_SchemeType', N'流程类型', N'0', N'1', NULL, N'2020-07-14 09:21:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'b3e6bab9-7e4c-4f87-83ff-d0f1bf6f9df8', N'c87cd44f-d064-4d3c-a43e-de01a7a8785e', N'F_FrmType', N'表单类型', N'0', N'1', NULL, N'2020-07-14 09:21:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'b4697530-35c5-4f8c-9221-873472d4124c', N'788d27cb-598d-41da-ac11-b7ddf0914b08', N'F_IsWebLogin', N'Web登录', N'0', N'1', NULL, N'2020-11-21 09:55:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'b474c442-3a67-410a-824d-e9fe7620a10b', N'788d27cb-598d-41da-ac11-b7ddf0914b08', N'F_EnabledMark', N'有效', N'0', N'1', NULL, N'2020-11-21 09:55:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'b4aec327-84c5-4389-9449-2568d3718312', N'25ca371f-9c67-4e0e-9ca7-0dec2e836613', N'F_MaterialUnit', N'料号单位', N'0', N'1', NULL, N'2020-12-16 13:38:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'b56a98de-4f9d-4753-ae06-e3bea339dc9f', N'2c2ddbce-ee87-4134-9b32-54d0bd572910', N'F_WebId', N'系统页面标识，当表单类型为用Web自定义的表单时，需要标识加载哪个页面', N'0', N'1', NULL, N'2020-07-08 14:34:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'b575c4c7-ff55-4d77-be60-9d847ecf5694', N'b26cea9c-21ba-42fa-98fc-b8fe0b92451d', N'F_MaterialType', N'物料分类', N'0', N'1', NULL, N'2021-05-21 13:57:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'b5a08597-f348-48ae-8824-d76628635981', N'af863666-a357-4e06-bffd-df98e1d29ab8', N'F_EqpName', N'设备名称', N'0', N'1', NULL, N'2020-11-30 14:05:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'b67b5eb6-ecae-4156-8ef8-9e80b7a1345a', N'7e4e4a48-4d51-4159-a113-2a211186f13a', N'F_CreatorUserName', N'创建人', N'0', N'1', N'', N'2020-05-22 16:53:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'b68b00b4-6f56-4832-8774-eab1d02e2fc1', N'a303cbe1-60eb-437b-9a69-77ff8b48f173', N'F_AdminPassword', N'系统密码', N'0', N'1', NULL, N'2020-06-12 13:54:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'b765ca2a-4337-4e24-b330-9c923ca793f0', N'c87cd44f-d064-4d3c-a43e-de01a7a8785e', N'F_CreatorUserId', N'创建用户主键', N'0', N'1', NULL, N'2020-07-14 09:21:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'b8e360f7-817f-4dc7-82c4-11fd51fc77de', N'c87cd44f-d064-4d3c-a43e-de01a7a8785e', N'F_FrmContentParse', N'表单控件位置模板', N'0', N'1', NULL, N'2020-07-14 09:21:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'bb0c21c4-4370-47d6-9c0a-670c1bce57f5', N'b39698da-6117-433e-8a02-ef1392d1fe3b', N'F_BatchCode', N'条码编号', N'0', N'1', NULL, N'2021-05-21 13:59:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'bb211871-ec1c-49be-9950-41b09db68ba6', N'7cce1014-5087-4184-9848-77e164be4e17', N'F_Description', N'备注', N'0', N'1', NULL, N'2020-12-07 12:14:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'bb2cf8d7-0702-491e-8bff-8e3a93d39117', N'788d27cb-598d-41da-ac11-b7ddf0914b08', N'F_CreatorUserName', N'创建人', N'0', N'1', NULL, N'2020-11-21 09:55:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'bd5762c4-f9ad-436e-8fe3-6adc8ba4958e', N'39226710-b665-489e-aaa0-a8c15d29ed4c', N'F_ProcessId', N'工序主键', N'0', N'1', NULL, N'2020-12-03 13:56:34.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'bd8b0f82-43fd-44ed-9814-de1876fced8c', N'f82fd629-5f3a-45d6-8681-5ec47e66a807', N'F_SchemeCanUser', N'流程模板使用者', N'0', N'1', NULL, N'2020-07-10 08:50:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'be804654-d6d7-44d1-8950-6841a2626720', N'484269cb-9aea-4af1-b7f6-f99e7e396ad1', N'F_CreatorUserId', N'创建人Id', N'0', N'1', N'', N'2020-06-12 14:33:15.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-12 13:57:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'bee47318-9236-4938-8de6-3a372cff31f7', N'84e5ec65-f803-485e-b703-4d07eaaf6c05', N'F_CreatorTime', N'创建时间', N'0', N'1', NULL, N'2020-12-16 13:39:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'bf5a2919-281c-44e2-a83b-74576e08743e', N'7e4e4a48-4d51-4159-a113-2a211186f13a', N'F_EnabledMark', N'状态', N'0', N'1', N'', N'2020-05-22 16:53:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-08 16:49:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'bfbe0195-3fae-42d2-9d46-6bf5400d64ea', N'484269cb-9aea-4af1-b7f6-f99e7e396ad1', N'F_DbString', N'连接字符串', N'0', N'1', N'', N'2020-06-12 14:33:15.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-12 13:57:26.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'c077b982-c595-43e8-9095-711bee01e830', N'f82fd629-5f3a-45d6-8681-5ec47e66a807', N'F_AuthorizeType', N'模板权限类型：0完全公开,1指定部门/人员', N'0', N'1', NULL, N'2020-07-10 08:50:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'c0a08cd8-43bc-4d57-844a-2a39c4a408e6', N'484269cb-9aea-4af1-b7f6-f99e7e396ad1', N'F_CompanyName', N'公司名称', N'0', N'1', NULL, N'2020-06-12 14:33:15.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'c21bfb1a-b2bb-4a39-bc34-6da262bdd5e5', N'ed896675-541a-4d34-bf77-29c87d7a26bb', N'F_MaterialSize', N'料号规格', N'0', N'1', NULL, N'2020-12-01 14:31:51.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'c2349607-aeec-48e6-95ad-52f14c3df722', N'e093b2d3-ec49-4b4d-91ec-63f57f4e3f1d', N'F_CreatorUserId', N'F_CreatorUserId', N'0', N'1', NULL, N'2020-12-14 12:44:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'c4a2499d-780c-42db-a2a4-a3c1084533ca', N'e9190a56-e173-4483-8a3e-f17b86e4766e', N'F_MessageInfo', N'内容', N'0', N'1', NULL, N'2020-07-29 16:44:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'c4c5840c-90a5-4a4e-aea4-9f284ece3921', N'a303cbe1-60eb-437b-9a69-77ff8b48f173', N'F_AdminAccount', N'系统账户', N'0', N'1', N'', N'2020-06-12 13:54:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-12 13:56:32.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'c4d6a87a-70ec-4065-8188-e82e8ac8690d', N'ed896675-541a-4d34-bf77-29c87d7a26bb', N'F_Customer', N'客户', N'0', N'1', NULL, N'2020-12-01 14:31:51.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'c55d31cd-25fb-44b4-9c7f-3946452aef6f', N'25ca371f-9c67-4e0e-9ca7-0dec2e836613', N'F_MaterialBatch', N'料号批次', N'0', N'1', NULL, N'2020-12-16 13:38:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'c5b6802f-42e4-4655-8fba-53ef3f9056c1', N'7cce1014-5087-4184-9848-77e164be4e17', N'F_BedNum', N'不良数量', N'0', N'1', NULL, N'2020-12-07 12:14:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'c5f26f24-be6b-483e-af07-80c06f5b941b', N'ed896675-541a-4d34-bf77-29c87d7a26bb', N'F_MaterialCode', N'料号编号', N'0', N'1', NULL, N'2020-12-01 14:31:51.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'c5ff9de2-dbd8-477a-8e43-e7910ab874a8', N'af863666-a357-4e06-bffd-df98e1d29ab8', N'F_EqpOwner', N'财产所属', N'0', N'1', NULL, N'2020-11-30 14:05:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'c8761118-40d1-4916-b9df-d041c27320fe', N'd9078b9a-5db6-4429-b489-3700e56f367f', N'F_CreatorTime', N'F_CreatorTime', N'0', N'1', NULL, N'2021-01-14 13:24:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'c87b90e3-6949-47f3-b8c5-c4f69af92200', N'a303cbe1-60eb-437b-9a69-77ff8b48f173', N'F_CompanyName', N'公司名称', N'0', N'1', NULL, N'2020-06-12 13:54:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'c8923b9e-b5f2-4420-a5ab-d35ba16e79f7', N'788d27cb-598d-41da-ac11-b7ddf0914b08', N'F_AppName', N'应用名称', N'0', N'1', NULL, N'2020-11-21 09:55:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'cba04ab7-b1b2-406e-a889-53484469cfe7', N'7e4e4a48-4d51-4159-a113-2a211186f13a', N'F_CreatorUserId', N'创建人Id', N'0', N'0', N'', N'2020-06-03 16:42:33.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-23 09:05:44.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'cddfb494-6d34-408d-8364-1c0bf270d4cd', N'2c2ddbce-ee87-4134-9b32-54d0bd572910', N'F_FrmType', N'表单类型，0：默认动态表单；1：Web自定义表单', N'0', N'1', NULL, N'2020-07-08 14:34:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'cdfbb34c-ce23-4214-b204-d95639c37f7f', N'b39698da-6117-433e-8a02-ef1392d1fe3b', N'F_MaterialBatch', N'物料批次', N'0', N'1', NULL, N'2021-05-21 13:59:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'cdfff32c-c512-4aae-8f37-bcb41fe6338e', N'b39698da-6117-433e-8a02-ef1392d1fe3b', N'F_BackMaterialBatch', N'退回料号批次', N'0', N'1', NULL, N'2021-05-21 13:59:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'cf019cef-8ed1-42f6-a8cf-ce6c5f834288', N'7cce1014-5087-4184-9848-77e164be4e17', N'F_CreatorTime', N'F_CreatorTime', N'0', N'1', NULL, N'2020-12-07 12:14:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'd03113cc-ac15-462f-9ca2-f8b28cde5efd', N'd9078b9a-5db6-4429-b489-3700e56f367f', N'F_EnabledMark', N'F_EnabledMark', N'0', N'1', NULL, N'2021-01-14 13:24:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'd1a990b1-189b-498f-9176-fc009b3952ad', N'5391c5c0-55c0-4132-a26d-5d27fcec1c18', N'F_Description', N'备注', N'0', N'1', NULL, N'2020-12-17 08:32:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'd39fa128-e61c-49e2-83d3-4cb289f34ca3', N'e093b2d3-ec49-4b4d-91ec-63f57f4e3f1d', N'F_CreatorTime', N'F_CreatorTime', N'0', N'1', NULL, N'2020-12-14 12:44:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'd3a77926-a549-4bd5-a8f9-2e0a64815872', N'84e5ec65-f803-485e-b703-4d07eaaf6c05', N'F_Num', N'数量', N'0', N'1', NULL, N'2020-12-16 13:39:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'd4a0cc88-4c3c-42e5-b116-8bdc44da8357', N'a8f0c195-53c5-4b05-b65e-5fafb14a3aec', N'F_ToEqpId', N'指定设备', N'0', N'1', NULL, N'2021-01-15 14:19:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'd4b49a55-491e-494c-b2d2-082a414bcbb9', N'484269cb-9aea-4af1-b7f6-f99e7e396ad1', N'F_Logo', N'Logo图标', N'0', N'1', NULL, N'2020-06-12 14:33:15.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'd52c6878-9283-45d7-82f9-b465fa33a89b', N'484269cb-9aea-4af1-b7f6-f99e7e396ad1', N'F_DBProvider', N'数据库类型', N'0', N'1', N'', N'2020-06-12 14:33:15.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-06-12 13:57:21.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'd53cf640-037a-4126-9b75-daa77fa712b3', N'c87cd44f-d064-4d3c-a43e-de01a7a8785e', N'F_FrmContentData', N'表单中的控件属性描述', N'0', N'1', NULL, N'2020-07-14 09:21:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'd6ab81f8-0deb-4344-b228-bee537801ede', N'788d27cb-598d-41da-ac11-b7ddf0914b08', N'F_AppSecret', N'AppSecret', N'0', N'1', NULL, N'2020-11-21 09:55:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'd6f9071b-f47d-4272-a329-46bd1fa0c2d9', N'b26cea9c-21ba-42fa-98fc-b8fe0b92451d', N'F_MaterialName', N'物料名称', N'0', N'1', NULL, N'2021-05-21 13:57:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'd75e45d3-763d-45ef-ab08-22f58eef5fce', N'25ca371f-9c67-4e0e-9ca7-0dec2e836613', N'F_MaterialType', N'料号分类', N'0', N'1', NULL, N'2020-12-16 13:38:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'd782d010-89af-4c1d-8e96-35833c38c3d8', N'f82fd629-5f3a-45d6-8681-5ec47e66a807', N'F_SchemeVersion', N'流程内容版本', N'0', N'1', NULL, N'2020-07-10 08:50:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'd87ad0d7-6e9c-4795-8144-2c55c331531e', N'39226710-b665-489e-aaa0-a8c15d29ed4c', N'F_Description', N'备注', N'0', N'1', NULL, N'2020-12-03 13:56:34.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'd88a3d04-4a0d-4bfe-b34f-4130eb0accc9', N'2c2ddbce-ee87-4134-9b32-54d0bd572910', N'F_Name', N'表单名称', N'0', N'1', NULL, N'2020-07-08 14:34:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'd9e2a9fe-8a87-4266-aaae-f8e47b63187b', N'c87cd44f-d064-4d3c-a43e-de01a7a8785e', N'F_FrmData', N'表单数据', N'0', N'1', NULL, N'2020-07-14 09:21:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'db09d23a-ca82-4676-8fc4-18e974eb86b8', N'b39698da-6117-433e-8a02-ef1392d1fe3b', N'F_MaterialCode', N'物料编号', N'0', N'1', NULL, N'2021-05-21 13:59:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'dba95c11-47ea-4cb3-9152-c5c5dbc092c5', N'af863666-a357-4e06-bffd-df98e1d29ab8', N'F_EqpType', N'设备类型', N'0', N'1', NULL, N'2020-11-30 14:05:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'dc4cd5fd-8933-44f8-9500-fc36285f50b2', N'7e4e4a48-4d51-4159-a113-2a211186f13a', N'F_CreatorTime', N'创建时间', N'0', N'1', N'', N'2020-05-22 16:53:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-05-22 17:06:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'ddd93ca7-d821-4abd-a342-9be1782dabe9', N'7e4e4a48-4d51-4159-a113-2a211186f13a', N'F_Content', N'内容', N'0', N'1', N'', N'2020-05-22 16:42:41.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2020-05-22 16:53:30.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'0')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'e084f62c-2403-476b-bead-23c5ac4ff13c', N'b26cea9c-21ba-42fa-98fc-b8fe0b92451d', N'F_FinishTime', N'检验完成时间', N'0', N'1', NULL, N'2021-05-21 13:57:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'e175859e-9284-47fd-a168-d1a12ddd125d', N'a303cbe1-60eb-437b-9a69-77ff8b48f173', N'F_MobilePhone', N'联系方式', N'0', N'1', NULL, N'2020-06-12 13:54:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'e18deb3b-188b-497b-a4e3-20c29cc09fd5', N'd9078b9a-5db6-4429-b489-3700e56f367f', N'F_PrintTemplateDescription', N'模板描述', N'0', N'1', NULL, N'2021-01-14 13:24:01.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'e3051d49-b5bf-4aba-b224-e3ba0eb2dd27', N'a8f0c195-53c5-4b05-b65e-5fafb14a3aec', N'F_IsNotice', N'是否通知', N'0', N'1', NULL, N'2021-01-15 14:19:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'e3a8532b-308c-43b5-bc73-2adcaada998a', N'788d27cb-598d-41da-ac11-b7ddf0914b08', N'F_Description', N'备注', N'0', N'1', NULL, N'2020-11-21 09:55:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'e50675bb-3d9d-4d74-bb85-28d253149730', N'7cce1014-5087-4184-9848-77e164be4e17', N'F_MaterialId', N'料号Id', N'0', N'1', NULL, N'2020-12-07 12:14:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'e6c0d0cb-7d44-43c6-9036-0fcce49303f8', N'5391c5c0-55c0-4132-a26d-5d27fcec1c18', N'F_CreatorUserId', N'F_CreatorUserId', N'0', N'1', NULL, N'2020-12-17 08:32:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'e706cac2-aef2-4f3e-85e1-29183a104d68', N'ed896675-541a-4d34-bf77-29c87d7a26bb', N'F_MaterialUnit', N'料号单位', N'0', N'1', NULL, N'2020-12-01 14:31:51.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'e7a49b29-0c59-4665-9e73-5f495fced4d4', N'f82fd629-5f3a-45d6-8681-5ec47e66a807', N'F_CreatorTime', N'创建时间', N'0', N'1', NULL, N'2020-07-10 08:50:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'e843972a-e7ad-4252-b43e-f008b2d7e06a', N'af863666-a357-4e06-bffd-df98e1d29ab8', N'F_EnabledMark', N'F_EnabledMark', N'0', N'1', NULL, N'2020-11-30 14:05:06.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'e85b97a0-d6f6-4d0f-8bdc-a7eccf9fdd95', N'a8f0c195-53c5-4b05-b65e-5fafb14a3aec', N'F_DoneTime', N'执行时间', N'0', N'1', NULL, N'2021-01-15 14:19:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'e9ed0496-046a-41b4-aa8e-1f5c8553b963', N'a8f0c195-53c5-4b05-b65e-5fafb14a3aec', N'F_FinishTime', N'完成时间', N'0', N'1', NULL, N'2021-01-15 14:19:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'eb6b22e7-a804-4f6d-b969-d5c6db5f3043', N'2c2ddbce-ee87-4134-9b32-54d0bd572910', N'F_CreatorUserId', N'创建人', N'0', N'1', NULL, N'2020-07-08 14:34:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'ec413c38-4472-4e36-b406-84f883d48609', N'e9190a56-e173-4483-8a3e-f17b86e4766e', N'F_CreatorTime', N'创建时间', N'0', N'1', NULL, N'2020-07-29 16:44:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'ed938b87-a291-40cd-8a23-204e15f81cb3', N'f82fd629-5f3a-45d6-8681-5ec47e66a807', N'F_EnabledMark', N'有效', N'0', N'1', NULL, N'2020-07-10 08:50:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'edeabb1a-de3c-48d0-b677-5d35807632dc', N'7cb65e00-8af2-4cf2-b318-8ba28b3c154e', N'F_EnabledMark', N'有效', N'0', N'1', NULL, N'2020-07-22 12:05:35.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'edf1d2cb-07dd-41cb-a475-41b982c43dff', N'484269cb-9aea-4af1-b7f6-f99e7e396ad1', N'F_MobilePhone', N'联系方式', N'0', N'1', NULL, N'2020-06-12 14:33:15.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'f0d51864-40c6-44dc-934f-598c7bb04c56', N'25ca371f-9c67-4e0e-9ca7-0dec2e836613', N'F_CreatorUserId', N'创建人id', N'0', N'1', NULL, N'2020-12-16 13:38:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'f0e838e8-c07c-4f24-9dd3-0c1727074441', N'484269cb-9aea-4af1-b7f6-f99e7e396ad1', N'F_EnabledMark', N'有效', N'0', N'1', NULL, N'2020-06-16 09:38:15.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'f2c75a6b-ad06-49b2-93cf-7a7312c97ff5', N'e9190a56-e173-4483-8a3e-f17b86e4766e', N'F_EnabledMark', N'有效', N'0', N'1', NULL, N'2020-07-29 16:44:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'f8a85900-44e6-4786-ad64-e219eb8cffbe', N'f82fd629-5f3a-45d6-8681-5ec47e66a807', N'F_FrmType', N'表单类型', N'0', N'1', NULL, N'2020-07-10 08:50:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'fbce3e50-da9b-4f5a-b919-ad90fe8920ed', N'8968b428-2a8b-4dbe-ad47-73dd408ddd5e', N'F_ProcessFlowName', N'工序名称', N'0', N'1', NULL, N'2020-12-03 09:49:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'fc460468-bb76-4cf8-8107-d710347945ca', N'5391c5c0-55c0-4132-a26d-5d27fcec1c18', N'F_AreaId', N'库区id', N'0', N'1', NULL, N'2020-12-17 08:32:46.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'fc7f572d-6dc2-4592-8d67-4b3155b49dd9', N'e9190a56-e173-4483-8a3e-f17b86e4766e', N'F_ToUserName', N'收件人', N'0', N'1', NULL, N'2020-07-29 16:44:08.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'fc82f7af-efc8-4f25-b9ca-31ecfb2213e1', N'7cce1014-5087-4184-9848-77e164be4e17', N'F_WorkOrderState', N'工单状态', N'0', N'1', NULL, N'2020-12-07 12:14:37.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'fda6f2c8-f5fa-4c49-adc5-ffdedc5897dc', N'e093b2d3-ec49-4b4d-91ec-63f57f4e3f1d', N'F_TransferType', N'流转箱类型', N'0', N'1', NULL, N'2020-12-14 12:44:38.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'fdb9e4f1-e3e8-4e8c-961a-9ee64b64fd4b', N'a8f0c195-53c5-4b05-b65e-5fafb14a3aec', N'F_Priority', N'优先级（从大到小执行）', N'0', N'1', NULL, N'2021-01-15 14:19:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'fdc24c5c-58ae-498d-a637-1d5d59df7ba4', N'84e5ec65-f803-485e-b703-4d07eaaf6c05', N'F_DoneNum', N'完成数量', N'0', N'1', NULL, N'2020-12-16 13:39:10.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'fe1ca281-5d25-43b1-ac14-a924d022d3be', N'25ca371f-9c67-4e0e-9ca7-0dec2e836613', N'F_EnabledMark', N'F_EnabledMark', N'0', N'1', NULL, N'2020-12-16 13:38:27.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'ff0006a8-1e6f-43db-99b7-13e59157e8b6', N'a8f0c195-53c5-4b05-b65e-5fafb14a3aec', N'F_DoneUserName', N'执行人', N'0', N'1', NULL, N'2021-01-15 14:19:45.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'ff60fd1e-d0df-4847-bc5a-1bf4c3310c9c', N'f82fd629-5f3a-45d6-8681-5ec47e66a807', N'F_CreatorUserId', N'创建用户主键', N'0', N'1', NULL, N'2020-07-10 08:50:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO


-- ----------------------------
-- Table structure for sys_Notice
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_Notice]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_Notice]
GO

CREATE TABLE [dbo].[sys_Notice] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_Title] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Content] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteMark] tinyint  NULL,
  [F_EnabledMark] tinyint  NULL,
  [F_Description] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorUserName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[sys_Notice] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of sys_Notice
-- ----------------------------

-- ----------------------------
-- Table structure for sys_OpenJob
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_OpenJob]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_OpenJob]
GO

CREATE TABLE [dbo].[sys_OpenJob] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_FileName] nvarchar(100) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_JobName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_JobGroup] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_StarRunTime] datetime2(7)  NULL,
  [F_EndRunTime] datetime2(7)  NULL,
  [F_CronExpress] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteMark] tinyint  NULL,
  [F_EnabledMark] tinyint  NULL,
  [F_Description] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastRunTime] datetime2(7)  NULL
)
GO

ALTER TABLE [dbo].[sys_OpenJob] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后一次执行时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_OpenJob',
'COLUMN', N'F_LastRunTime'
GO


-- ----------------------------
-- Records of sys_OpenJob
-- ----------------------------
INSERT INTO [dbo].[sys_OpenJob] ([F_Id], [F_FileName], [F_JobName], [F_JobGroup], [F_StarRunTime], [F_EndRunTime], [F_CronExpress], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_LastRunTime]) VALUES (N'08d9296b-2e10-403e-8272-87847110d046', N'WaterCloud.Service.AutoJob.ReadDingUserWorkJob', N'定时更新在班情况', N'WaterCloud', N'2021-11-30 07:25:19.0000000', N'2021-11-30 07:25:18.0000000', N'0 0 0/1 * * ?', N'0', N'1', N'每1小时更新一次在班情况', N'2021-06-07 12:17:36.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-11-30 07:25:19.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'2021-12-13 08:00:00.0000000')
GO

INSERT INTO [dbo].[sys_OpenJob] ([F_Id], [F_FileName], [F_JobName], [F_JobGroup], [F_StarRunTime], [F_EndRunTime], [F_CronExpress], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_LastRunTime]) VALUES (N'08d93471-4a21-4b26-8c4a-5d96d0823c7d', N'WaterCloud.Service.AutoJob.DeleteMessageJob', N'删除通知信息', N'WaterCloud', N'2021-11-30 07:25:19.0000000', N'2021-11-30 07:25:18.0000000', N'0 0 0 * * ?', N'0', N'1', N'每天0点清除1日前的通知', N'2021-06-21 12:59:03.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-11-30 07:25:19.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'2021-12-13 00:00:00.0000000')
GO

INSERT INTO [dbo].[sys_OpenJob] ([F_Id], [F_FileName], [F_JobName], [F_JobGroup], [F_StarRunTime], [F_EndRunTime], [F_CronExpress], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_LastRunTime]) VALUES (N'08d93a92-e732-4df4-89a8-ed2b69b619d8', N'WaterCloud.Service.AutoJob.CheckEqpStopJob', N'未完成任务项设备停机', N'WaterCloud', N'2021-11-30 07:25:19.0000000', N'2021-11-30 07:25:18.0000000', N'0 0/1 * * * ?', N'0', N'1', N'每1分钟扫描一次任务是否完成', N'2021-06-29 08:14:47.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-11-30 07:25:19.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'2021-12-13 08:29:00.0000000')
GO

INSERT INTO [dbo].[sys_OpenJob] ([F_Id], [F_FileName], [F_JobName], [F_JobGroup], [F_StarRunTime], [F_EndRunTime], [F_CronExpress], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_LastRunTime]) VALUES (N'08d94b55-de96-4d88-89dc-67e9745c9f0b', N'WaterCloud.Service.AutoJob.CheckDateStorageJob', N'每日盘点', N'WaterCloud', N'2021-11-30 07:25:19.0000000', N'2021-11-30 07:25:18.0000000', N'0 0 8,20 * * ?', N'0', N'1', N'每天8点、20点 系统进行盘点', N'2021-07-20 16:10:43.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-11-30 07:25:19.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'2021-12-13 08:00:00.0000000')
GO

INSERT INTO [dbo].[sys_OpenJob] ([F_Id], [F_FileName], [F_JobName], [F_JobGroup], [F_StarRunTime], [F_EndRunTime], [F_CronExpress], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_LastRunTime]) VALUES (N'08d95e17-7c91-489b-8615-f660bdc39bd1', N'WaterCloud.Service.AutoJob.AutoUpdatePlanJob', N'APS执行', N'WaterCloud', N'2021-11-30 07:25:19.0000000', N'2021-11-30 07:25:18.0000000', N'0 0 7 * * ?', N'0', N'1', N'每天早上7点执行APS更新计划', N'2021-08-13 13:02:02.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-11-30 07:25:19.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'2021-08-26 07:00:00.0000000')
GO

INSERT INTO [dbo].[sys_OpenJob] ([F_Id], [F_FileName], [F_JobName], [F_JobGroup], [F_StarRunTime], [F_EndRunTime], [F_CronExpress], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_LastRunTime]) VALUES (N'08d961f5-c728-418d-8c54-67c2f74fd2ac', N'WaterCloud.Service.AutoJob.ReturnProduceJob', N'产出退回', N'WaterCloud', N'2021-11-30 07:25:19.0000000', N'2021-11-30 07:25:18.0000000', N'0 50 * * * ?', N'0', N'1', N'每个小时执行，产出退回超过24小时的产出未上架的料,除去检验料', N'2021-08-18 11:10:49.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-11-30 07:25:19.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'2021-12-13 07:50:00.0000000')
GO

INSERT INTO [dbo].[sys_OpenJob] ([F_Id], [F_FileName], [F_JobName], [F_JobGroup], [F_StarRunTime], [F_EndRunTime], [F_CronExpress], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_LastRunTime]) VALUES (N'b57a4ea0-e8f5-4df8-addc-8f0920fab395', N'WaterCloud.Service.AutoJob.SaveServerStateJob', N'服务器状态', N'WaterCloud', N'2021-11-30 07:25:20.0000000', N'2021-11-30 07:25:19.0000000', N'0 0/5 * * * ?', N'0', N'1', N'每5分钟更新一次服务器状态', N'2021-03-03 08:34:29.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2021-11-30 07:25:20.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'2021-12-13 08:25:00.0000000')
GO


-- ----------------------------
-- Table structure for sys_OpenJobLog
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_OpenJobLog]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_OpenJobLog]
GO

CREATE TABLE [dbo].[sys_OpenJobLog] (
  [F_Id] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_JobId] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_EnabledMark] tinyint  NOT NULL,
  [F_JobName] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[sys_OpenJobLog] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务Id',
'SCHEMA', N'dbo',
'TABLE', N'sys_OpenJobLog',
'COLUMN', N'F_JobId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务信息',
'SCHEMA', N'dbo',
'TABLE', N'sys_OpenJobLog',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'执行时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_OpenJobLog',
'COLUMN', N'F_CreatorTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'执行状态',
'SCHEMA', N'dbo',
'TABLE', N'sys_OpenJobLog',
'COLUMN', N'F_EnabledMark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_OpenJobLog',
'COLUMN', N'F_JobName'
GO


-- ----------------------------
-- Records of sys_OpenJobLog
-- ----------------------------

-- ----------------------------
-- Table structure for sys_Organize
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_Organize]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_Organize]
GO

CREATE TABLE [dbo].[sys_Organize] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_ParentId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Layers] int  NULL,
  [F_EnCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_FullName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ShortName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CategoryId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ManagerId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_TelePhone] nvarchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MobilePhone] nvarchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_WeChat] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Fax] nvarchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Email] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_AreaId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Address] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_AllowEdit] tinyint  NULL,
  [F_AllowDelete] tinyint  NULL,
  [F_SortCode] int  NULL,
  [F_DeleteMark] tinyint  NULL,
  [F_EnabledMark] tinyint  NULL,
  [F_Description] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[sys_Organize] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of sys_Organize
-- ----------------------------
INSERT INTO [dbo].[sys_Organize] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_ShortName], [F_CategoryId], [F_ManagerId], [F_TelePhone], [F_MobilePhone], [F_WeChat], [F_Fax], [F_Email], [F_AreaId], [F_Address], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId]) VALUES (N'5AB270C0-5D33-4203-A54F-4552699FDA3C', N'0', N'1', N'Company', N'水之云', NULL, N'Company', N'', NULL, NULL, NULL, NULL, NULL, NULL, N'', N'0', N'0', N'1', N'0', N'1', N'', N'2016-06-10 00:00:00.0000000', NULL, N'2021-03-30 14:41:26.0000000', N'b05fb485-c0ea-4f1b-9c3c-dcf43566e162', NULL, NULL)
GO


-- ----------------------------
-- Table structure for sys_PrintTemplate
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_PrintTemplate]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_PrintTemplate]
GO

CREATE TABLE [dbo].[sys_PrintTemplate] (
  [F_Id] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_PrintTemplateName] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_PrintTemplatePath] nvarchar(max) COLLATE Chinese_PRC_CI_AS DEFAULT 0 NOT NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_PrintTemplateDescription] nvarchar(max) COLLATE Chinese_PRC_CI_AS DEFAULT 0 NOT NULL
)
GO

ALTER TABLE [dbo].[sys_PrintTemplate] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'模板名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_PrintTemplate',
'COLUMN', N'F_PrintTemplateName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模板地址',
'SCHEMA', N'dbo',
'TABLE', N'sys_PrintTemplate',
'COLUMN', N'F_PrintTemplatePath'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'sys_PrintTemplate',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模板描述',
'SCHEMA', N'dbo',
'TABLE', N'sys_PrintTemplate',
'COLUMN', N'F_PrintTemplateDescription'
GO


-- ----------------------------
-- Records of sys_PrintTemplate
-- ----------------------------
INSERT INTO [dbo].[sys_PrintTemplate] ([F_Id], [F_PrintTemplateName], [F_PrintTemplatePath], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_PrintTemplateDescription]) VALUES (N'08dab30e-3e4a-4dab-8536-08eb819a63de', N'二维码编号名称模板', N'/file/code1.frx', N'0', N'1', N'', N'2022-10-21 10:44:58.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'二维码参数barId；名称参数name：编号参数code')
GO

INSERT INTO [dbo].[sys_PrintTemplate] ([F_Id], [F_PrintTemplateName], [F_PrintTemplatePath], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_PrintTemplateDescription]) VALUES (N'08dab30e-5e26-442c-8ad3-8cb4bb9409dd', N'出入库单据模板', N'/file/code2.frx', N'0', N'1', N'', N'2022-10-21 10:45:52.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'二维码参数barId;名称参数name;编号参数code;数量参数num;')
GO


-- ----------------------------
-- Table structure for sys_PrintTemplateHis
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_PrintTemplateHis]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_PrintTemplateHis]
GO

CREATE TABLE [dbo].[sys_PrintTemplateHis] (
  [F_Id] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_PrintTemplatePath] nvarchar(max) COLLATE Chinese_PRC_CI_AS DEFAULT 0 NOT NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ParentId] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL
)
GO

ALTER TABLE [dbo].[sys_PrintTemplateHis] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'模板地址',
'SCHEMA', N'dbo',
'TABLE', N'sys_PrintTemplateHis',
'COLUMN', N'F_PrintTemplatePath'
GO

EXEC sp_addextendedproperty
'MS_Description', N'父级id',
'SCHEMA', N'dbo',
'TABLE', N'sys_PrintTemplateHis',
'COLUMN', N'F_ParentId'
GO


-- ----------------------------
-- Records of sys_PrintTemplateHis
-- ----------------------------

-- ----------------------------
-- Table structure for sys_QuickModule
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_QuickModule]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_QuickModule]
GO

CREATE TABLE [dbo].[sys_QuickModule] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_ModuleId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteMark] tinyint  NULL,
  [F_EnabledMark] tinyint  NULL,
  [F_Description] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[sys_QuickModule] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of sys_QuickModule
-- ----------------------------

-- ----------------------------
-- Table structure for sys_ReportTemplate
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_ReportTemplate]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_ReportTemplate]
GO

CREATE TABLE [dbo].[sys_ReportTemplate] (
  [F_Id] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_PrintTemplateName] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_PrintTemplatePath] nvarchar(max) COLLATE Chinese_PRC_CI_AS DEFAULT 0 NOT NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_PrintTemplateType] int DEFAULT 0 NOT NULL,
  [F_PrintTemplateJson] text COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[sys_ReportTemplate] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'模板名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_ReportTemplate',
'COLUMN', N'F_PrintTemplateName'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模板地址',
'SCHEMA', N'dbo',
'TABLE', N'sys_ReportTemplate',
'COLUMN', N'F_PrintTemplatePath'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'sys_ReportTemplate',
'COLUMN', N'F_Description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模板类型 0json 1xlsx',
'SCHEMA', N'dbo',
'TABLE', N'sys_ReportTemplate',
'COLUMN', N'F_PrintTemplateType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模板内容',
'SCHEMA', N'dbo',
'TABLE', N'sys_ReportTemplate',
'COLUMN', N'F_PrintTemplateJson'
GO


-- ----------------------------
-- Records of sys_ReportTemplate
-- ----------------------------

-- ----------------------------
-- Table structure for sys_ReportTemplateHis
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_ReportTemplateHis]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_ReportTemplateHis]
GO

CREATE TABLE [dbo].[sys_ReportTemplateHis] (
  [F_Id] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_ParentId] varchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_PrintTemplatePath] nvarchar(max) COLLATE Chinese_PRC_CI_AS DEFAULT 0 NOT NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_PrintTemplateType] int DEFAULT 0 NOT NULL,
  [F_PrintTemplateJson] text COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[sys_ReportTemplateHis] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'父级id',
'SCHEMA', N'dbo',
'TABLE', N'sys_ReportTemplateHis',
'COLUMN', N'F_ParentId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模板地址',
'SCHEMA', N'dbo',
'TABLE', N'sys_ReportTemplateHis',
'COLUMN', N'F_PrintTemplatePath'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模板类型 0json 1xlsx',
'SCHEMA', N'dbo',
'TABLE', N'sys_ReportTemplateHis',
'COLUMN', N'F_PrintTemplateType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模板内容',
'SCHEMA', N'dbo',
'TABLE', N'sys_ReportTemplateHis',
'COLUMN', N'F_PrintTemplateJson'
GO


-- ----------------------------
-- Records of sys_ReportTemplateHis
-- ----------------------------

-- ----------------------------
-- Table structure for sys_Role
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_Role]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_Role]
GO

CREATE TABLE [dbo].[sys_Role] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_OrganizeId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Category] int  NULL,
  [F_EnCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_FullName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Type] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_AllowEdit] tinyint  NULL,
  [F_AllowDelete] tinyint  NULL,
  [F_SortCode] int  NULL,
  [F_DeleteMark] tinyint  NULL,
  [F_EnabledMark] tinyint  NULL,
  [F_Description] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[sys_Role] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of sys_Role
-- ----------------------------

-- ----------------------------
-- Table structure for sys_RoleAuthorize
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_RoleAuthorize]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_RoleAuthorize]
GO

CREATE TABLE [dbo].[sys_RoleAuthorize] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_ItemType] int  NULL,
  [F_ItemId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ObjectType] int  NULL,
  [F_ObjectId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_SortCode] int  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[sys_RoleAuthorize] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of sys_RoleAuthorize
-- ----------------------------

-- ----------------------------
-- Table structure for sys_ServerState
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_ServerState]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_ServerState]
GO

CREATE TABLE [dbo].[sys_ServerState] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_WebSite] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ARM] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CPU] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IIS] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Date] date  NULL,
  [F_Cout] int  NULL
)
GO

ALTER TABLE [dbo].[sys_ServerState] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of sys_ServerState
-- ----------------------------

-- ----------------------------
-- Table structure for sys_SystemSet
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_SystemSet]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_SystemSet]
GO

CREATE TABLE [dbo].[sys_SystemSet] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_Logo] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LogoCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ProjectName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CompanyName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_AdminAccount] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_AdminPassword] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteMark] tinyint  NULL,
  [F_EnabledMark] tinyint  NULL,
  [F_Description] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_MobilePhone] nvarchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_PrincipalMan] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_EndTime] datetime2(7)  NULL,
  [F_DbString] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DBProvider] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_HostUrl] nvarchar(255) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[sys_SystemSet] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of sys_SystemSet
-- ----------------------------
INSERT INTO [dbo].[sys_SystemSet] ([F_Id], [F_Logo], [F_LogoCode], [F_ProjectName], [F_CompanyName], [F_AdminAccount], [F_AdminPassword], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_MobilePhone], [F_PrincipalMan], [F_EndTime], [F_DbString], [F_DBProvider], [F_HostUrl]) VALUES (N'd69fd66a-6a77-4011-8a25-53a79bdf5001', N'/icon/favicon.ico', N'EasyMES', N'MES信息系统', N'水之云', N'admin', N'13579', N'0', N'1', N'', N'2020-06-12 16:30:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'2022-10-19 09:56:51.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, N'13600000000', N'xxxx', N'2032-06-26 00:00:00.0000000', N'Data Source = localhost;Initial Catalog = szprslmes;User ID=sa;Password=Hgame3569@;MultipleActiveResultSets=true;', N'System.Data.SqlClient', N'localhost')
GO


-- ----------------------------
-- Table structure for sys_User
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_User]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_User]
GO

CREATE TABLE [dbo].[sys_User] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_Account] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_RealName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_NickName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_HeadIcon] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Gender] tinyint  NULL,
  [F_Birthday] datetime2(7)  NULL,
  [F_MobilePhone] nvarchar(20) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Email] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_WeChat] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ManagerId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_SecurityLevel] int  NULL,
  [F_Signature] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_OrganizeId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DepartmentId] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_RoleId] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DutyId] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsAdmin] tinyint  NULL,
  [F_IsBoss] tinyint  NULL,
  [F_IsLeaderInDepts] tinyint  NULL,
  [F_IsSenior] tinyint  NULL,
  [F_SortCode] int  NULL,
  [F_DeleteMark] tinyint  NULL,
  [F_EnabledMark] tinyint  NULL,
  [F_Description] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DingTalkOpenId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DingTalkNick] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DingTalkUnionId] nvarchar(100) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_WxOpenId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_WxNickName] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_HeadImgUrl] nvarchar(100) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsPlanMan] tinyint DEFAULT 0 NOT NULL,
  [F_WebSocketPort] varchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT 7181 NULL
)
GO

ALTER TABLE [dbo].[sys_User] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'调度人员',
'SCHEMA', N'dbo',
'TABLE', N'sys_User',
'COLUMN', N'F_IsPlanMan'
GO

EXEC sp_addextendedproperty
'MS_Description', N'打印端口',
'SCHEMA', N'dbo',
'TABLE', N'sys_User',
'COLUMN', N'F_WebSocketPort'
GO


-- ----------------------------
-- Records of sys_User
-- ----------------------------
INSERT INTO [dbo].[sys_User] ([F_Id], [F_Account], [F_RealName], [F_NickName], [F_HeadIcon], [F_Gender], [F_Birthday], [F_MobilePhone], [F_Email], [F_WeChat], [F_ManagerId], [F_SecurityLevel], [F_Signature], [F_OrganizeId], [F_DepartmentId], [F_RoleId], [F_DutyId], [F_IsAdmin], [F_IsBoss], [F_IsLeaderInDepts], [F_IsSenior], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_DingTalkOpenId], [F_DingTalkNick], [F_DingTalkUnionId], [F_WxOpenId], [F_WxNickName], [F_HeadImgUrl], [F_IsPlanMan], [F_WebSocketPort]) VALUES (N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'admin', N'超级管理员', N'超级管理员', NULL, N'1', N'2020-03-28 00:00:00.0000000', N'13600000001', N'3333', NULL, NULL, NULL, NULL, N'd69fd66a-6a77-4011-8a25-53a79bdf5001', N'5AB270C0-5D33-4203-A54F-4552699FDA3C', NULL, NULL, N'1', N'0', N'0', N'0', NULL, N'0', N'1', N'系统内置账户', N'2016-07-20 00:00:00.0000000', NULL, NULL, NULL, NULL, NULL, N'', N'', N'', NULL, NULL, NULL, N'0', N'7181')
GO


-- ----------------------------
-- Table structure for sys_UserLogon
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_UserLogon]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_UserLogon]
GO

CREATE TABLE [dbo].[sys_UserLogon] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_UserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_UserPassword] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_UserSecretkey] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_AllowStartTime] datetime2(7)  NULL,
  [F_AllowEndTime] datetime2(7)  NULL,
  [F_LockStartDate] datetime2(7)  NULL,
  [F_LockEndDate] datetime2(7)  NULL,
  [F_FirstVisitTime] datetime2(7)  NULL,
  [F_PreviousVisitTime] datetime2(7)  NULL,
  [F_LastVisitTime] datetime2(7)  NULL,
  [F_ChangePasswordDate] datetime2(7)  NULL,
  [F_MultiUserLogin] tinyint  NULL,
  [F_LogOnCount] int  NULL,
  [F_UserOnLine] tinyint  NULL,
  [F_Question] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_AnswerQuestion] nvarchar(500) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CheckIPAddress] tinyint  NULL,
  [F_Language] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Theme] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LoginSession] nvarchar(100) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_ErrorNum] int  NULL
)
GO

ALTER TABLE [dbo].[sys_UserLogon] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of sys_UserLogon
-- ----------------------------
INSERT INTO [dbo].[sys_UserLogon] ([F_Id], [F_UserId], [F_UserPassword], [F_UserSecretkey], [F_AllowStartTime], [F_AllowEndTime], [F_LockStartDate], [F_LockEndDate], [F_FirstVisitTime], [F_PreviousVisitTime], [F_LastVisitTime], [F_ChangePasswordDate], [F_MultiUserLogin], [F_LogOnCount], [F_UserOnLine], [F_Question], [F_AnswerQuestion], [F_CheckIPAddress], [F_Language], [F_Theme], [F_LoginSession], [F_ErrorNum]) VALUES (N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', N'52c6b3f2456d7a6e4ce848c38bb0a228', N'b648e3d3de301b49', NULL, NULL, NULL, NULL, NULL, N'2020-04-17 14:47:44.0000000', N'2020-04-17 14:59:58.0000000', NULL, N'0', N'360', N'0', NULL, NULL, N'0', NULL, NULL, N'evrcyibdv42f3ykhfy1yz3ur', N'0')
GO


-- ----------------------------
-- Uniques structure for table mes_Area
-- ----------------------------
ALTER TABLE [dbo].[mes_Area] ADD CONSTRAINT [IX_AREA_KEY] UNIQUE NONCLUSTERED ([F_AreaCode] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO

EXEC sp_addextendedproperty
'MS_Description', N'唯一键',
'SCHEMA', N'dbo',
'TABLE', N'mes_Area',
'CONSTRAINT', N'IX_AREA_KEY'
GO


-- ----------------------------
-- Primary Key structure for table mes_Area
-- ----------------------------
ALTER TABLE [dbo].[mes_Area] ADD CONSTRAINT [PK__mes_area__2C6EC7232704CA5F] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mes_BatchInfo
-- ----------------------------
ALTER TABLE [dbo].[mes_BatchInfo] ADD CONSTRAINT [PK__mes_Batc__2C6EC7235BA5028D] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mes_BoardAccount
-- ----------------------------
ALTER TABLE [dbo].[mes_BoardAccount] ADD CONSTRAINT [PK__mes_Boar__2C6EC723A1D10885] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Uniques structure for table mes_BomForm
-- ----------------------------
ALTER TABLE [dbo].[mes_BomForm] ADD CONSTRAINT [IX_BOMINFO_KEY] UNIQUE NONCLUSTERED ([F_MaterialId] ASC, [F_BomType] ASC, [F_SonMaterialId] ASC, [F_ProcessId] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO

EXEC sp_addextendedproperty
'MS_Description', N'唯一键',
'SCHEMA', N'dbo',
'TABLE', N'mes_BomForm',
'CONSTRAINT', N'IX_BOMINFO_KEY'
GO


-- ----------------------------
-- Primary Key structure for table mes_BomForm
-- ----------------------------
ALTER TABLE [dbo].[mes_BomForm] ADD CONSTRAINT [PK__mes_bomi__2C6EC7239FB3A066] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table mes_CheckDateStorage
-- ----------------------------
CREATE UNIQUE NONCLUSTERED INDEX [mes_checkdatestorage]
ON [dbo].[mes_CheckDateStorage] (
  [F_CheckStorageType] ASC,
  [F_CheckDate] ASC,
  [F_ClassNum] ASC,
  [F_MaterialId] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table mes_CheckDateStorage
-- ----------------------------
ALTER TABLE [dbo].[mes_CheckDateStorage] ADD CONSTRAINT [PK__mes_Chec__2C6EC723247D27BB] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mes_CheckoutDescription
-- ----------------------------
ALTER TABLE [dbo].[mes_CheckoutDescription] ADD CONSTRAINT [PK__mes_Chec__2C6EC7236D58170E] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for mes_ConsumeInfo
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[mes_ConsumeInfo]', RESEED, 257377)
GO


-- ----------------------------
-- Primary Key structure for table mes_ConsumeInfo
-- ----------------------------
ALTER TABLE [dbo].[mes_ConsumeInfo] ADD CONSTRAINT [PK__mes_work__2C6EC7237E02B4CC] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Uniques structure for table mes_ControlJob
-- ----------------------------
ALTER TABLE [dbo].[mes_ControlJob] ADD CONSTRAINT [IX_CONTROLJOB_KEY] UNIQUE NONCLUSTERED ([F_JobCode] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mes_ControlJob
-- ----------------------------
ALTER TABLE [dbo].[mes_ControlJob] ADD CONSTRAINT [PK__mes_Cont__2C6EC723095DD374] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mes_ControlJobMustTime
-- ----------------------------
ALTER TABLE [dbo].[mes_ControlJobMustTime] ADD CONSTRAINT [PK__mes_Cont__2C6EC7236D158713] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Uniques structure for table mes_ControlJobUserBanding
-- ----------------------------
ALTER TABLE [dbo].[mes_ControlJobUserBanding] ADD CONSTRAINT [IX_JOBUSERBANDING_KEY] UNIQUE NONCLUSTERED ([F_JobType] ASC, [F_EqpId] ASC, [F_UserId] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO

EXEC sp_addextendedproperty
'MS_Description', N'唯一键',
'SCHEMA', N'dbo',
'TABLE', N'mes_ControlJobUserBanding',
'CONSTRAINT', N'IX_JOBUSERBANDING_KEY'
GO


-- ----------------------------
-- Primary Key structure for table mes_ControlJobUserBanding
-- ----------------------------
ALTER TABLE [dbo].[mes_ControlJobUserBanding] ADD CONSTRAINT [PK__mes_Cont__2C6EC7234D42DF6E] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mes_EqpAreaBanding
-- ----------------------------
ALTER TABLE [dbo].[mes_EqpAreaBanding] ADD CONSTRAINT [PK__mes_eqpa__2C6EC723603D47BB] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mes_EqpMaterialBanding
-- ----------------------------
ALTER TABLE [dbo].[mes_EqpMaterialBanding] ADD CONSTRAINT [PK__mes_EqpM__2C6EC7230922860C] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for mes_EqpMaterialUse
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[mes_EqpMaterialUse]', RESEED, 143858)
GO


-- ----------------------------
-- Primary Key structure for table mes_EqpMaterialUse
-- ----------------------------
ALTER TABLE [dbo].[mes_EqpMaterialUse] ADD CONSTRAINT [PK__mes_eqpm__2C6EC7230B5CAFEA] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mes_EqpPqcCheckItem
-- ----------------------------
ALTER TABLE [dbo].[mes_EqpPqcCheckItem] ADD CONSTRAINT [PK__mes_EqpP__2C6EC723EAE9FF27] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mes_EqpPqcDetail
-- ----------------------------
ALTER TABLE [dbo].[mes_EqpPqcDetail] ADD CONSTRAINT [PK__mes_EqpP__2C6EC7230809A231] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mes_EqpPqcMaster
-- ----------------------------
ALTER TABLE [dbo].[mes_EqpPqcMaster] ADD CONSTRAINT [PK__mes_EqpP__2C6EC7234C8AFE0D] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mes_EqpRepair
-- ----------------------------
ALTER TABLE [dbo].[mes_EqpRepair] ADD CONSTRAINT [PK__mes_EqpR__2C6EC72353321010] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mes_EqpRepairManRecord
-- ----------------------------
ALTER TABLE [dbo].[mes_EqpRepairManRecord] ADD CONSTRAINT [PK__mes_EqpR__2C6EC723604EC0D4] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mes_EqpStopRecord
-- ----------------------------
ALTER TABLE [dbo].[mes_EqpStopRecord] ADD CONSTRAINT [PK__mes_EqpS__2C6EC7237B462E73] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for mes_EqpWorkTime
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[mes_EqpWorkTime]', RESEED, 25837)
GO


-- ----------------------------
-- Primary Key structure for table mes_EqpWorkTime
-- ----------------------------
ALTER TABLE [dbo].[mes_EqpWorkTime] ADD CONSTRAINT [PK__mes_EqpW__2C6EC72346335CF5] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Uniques structure for table mes_Equipment
-- ----------------------------
ALTER TABLE [dbo].[mes_Equipment] ADD CONSTRAINT [IK_Eqp_Key] UNIQUE NONCLUSTERED ([F_EqpName] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备名称唯一',
'SCHEMA', N'dbo',
'TABLE', N'mes_Equipment',
'CONSTRAINT', N'IK_Eqp_Key'
GO


-- ----------------------------
-- Primary Key structure for table mes_Equipment
-- ----------------------------
ALTER TABLE [dbo].[mes_Equipment] ADD CONSTRAINT [PK__mes_equi__2C6EC7235D4EE3CB] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mes_InStorage
-- ----------------------------
ALTER TABLE [dbo].[mes_InStorage] ADD CONSTRAINT [PK__mes_inst__2C6EC72319AACF41] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for mes_InStorageInfo
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[mes_InStorageInfo]', RESEED, 30621)
GO


-- ----------------------------
-- Uniques structure for table mes_InStorageInfo
-- ----------------------------
ALTER TABLE [dbo].[mes_InStorageInfo] ADD CONSTRAINT [IX_INSTORAGE_KEY] UNIQUE NONCLUSTERED ([F_TransferBoxCode] ASC, [F_MaterialId] ASC, [F_MaterialBatch] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO

EXEC sp_addextendedproperty
'MS_Description', N'唯一键',
'SCHEMA', N'dbo',
'TABLE', N'mes_InStorageInfo',
'CONSTRAINT', N'IX_INSTORAGE_KEY'
GO


-- ----------------------------
-- Primary Key structure for table mes_InStorageInfo
-- ----------------------------
ALTER TABLE [dbo].[mes_InStorageInfo] ADD CONSTRAINT [PK__mes_inst__2C6EC723634EBE90] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Uniques structure for table mes_Location
-- ----------------------------
ALTER TABLE [dbo].[mes_Location] ADD CONSTRAINT [IX_LOCATION_KEY] UNIQUE NONCLUSTERED ([F_LocationCode] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO

EXEC sp_addextendedproperty
'MS_Description', N'唯一键',
'SCHEMA', N'dbo',
'TABLE', N'mes_Location',
'CONSTRAINT', N'IX_LOCATION_KEY'
GO


-- ----------------------------
-- Primary Key structure for table mes_Location
-- ----------------------------
ALTER TABLE [dbo].[mes_Location] ADD CONSTRAINT [PK__mes_loca__2C6EC7232EA5EC27] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mes_LocationMaterialBanding
-- ----------------------------
ALTER TABLE [dbo].[mes_LocationMaterialBanding] ADD CONSTRAINT [PK__mes_Loca__2C6EC72306A2E7C5] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Uniques structure for table mes_Material
-- ----------------------------
ALTER TABLE [dbo].[mes_Material] ADD CONSTRAINT [IX_MATERIAL_KEY] UNIQUE NONCLUSTERED ([F_MaterialCode] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO

EXEC sp_addextendedproperty
'MS_Description', N'料号唯一',
'SCHEMA', N'dbo',
'TABLE', N'mes_Material',
'CONSTRAINT', N'IX_MATERIAL_KEY'
GO


-- ----------------------------
-- Primary Key structure for table mes_Material
-- ----------------------------
ALTER TABLE [dbo].[mes_Material] ADD CONSTRAINT [PK__mes_mate__2C6EC7231EFA196B] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Uniques structure for table mes_MaterialEqpBanding
-- ----------------------------
ALTER TABLE [dbo].[mes_MaterialEqpBanding] ADD CONSTRAINT [IX_MATERIALEQP] UNIQUE NONCLUSTERED ([F_MaterialId] ASC, [F_EqpId] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO

EXEC sp_addextendedproperty
'MS_Description', N'物料设备绑定唯一',
'SCHEMA', N'dbo',
'TABLE', N'mes_MaterialEqpBanding',
'CONSTRAINT', N'IX_MATERIALEQP'
GO


-- ----------------------------
-- Primary Key structure for table mes_MaterialEqpBanding
-- ----------------------------
ALTER TABLE [dbo].[mes_MaterialEqpBanding] ADD CONSTRAINT [PK__mes_mate__2C6EC723C8F4BB44] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for mes_NeedCheck
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[mes_NeedCheck]', RESEED, 86970)
GO


-- ----------------------------
-- Primary Key structure for table mes_NeedCheck
-- ----------------------------
ALTER TABLE [dbo].[mes_NeedCheck] ADD CONSTRAINT [PK_mes_OutputNeedCheck] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mes_Order
-- ----------------------------
ALTER TABLE [dbo].[mes_Order] ADD CONSTRAINT [PK__mes_Orde__2C6EC7230157E238] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mes_OrderDetail
-- ----------------------------
ALTER TABLE [dbo].[mes_OrderDetail] ADD CONSTRAINT [PK__mes_Orde__2C6EC723BBAC8232] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for mes_OutputInfo
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[mes_OutputInfo]', RESEED, 159659)
GO


-- ----------------------------
-- Primary Key structure for table mes_OutputInfo
-- ----------------------------
ALTER TABLE [dbo].[mes_OutputInfo] ADD CONSTRAINT [PK__mes_outp__2C6EC72304AFB25B] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mes_OutStorage
-- ----------------------------
ALTER TABLE [dbo].[mes_OutStorage] ADD CONSTRAINT [PK__mes_inst__2C6EC72319AACF41_copy1] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for mes_OutStorageInfo
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[mes_OutStorageInfo]', RESEED, 102651)
GO


-- ----------------------------
-- Primary Key structure for table mes_OutStorageInfo
-- ----------------------------
ALTER TABLE [dbo].[mes_OutStorageInfo] ADD CONSTRAINT [PK__mes_outs__2C6EC72312FDD1B2] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Uniques structure for table mes_ProcessEqpBanding
-- ----------------------------
ALTER TABLE [dbo].[mes_ProcessEqpBanding] ADD CONSTRAINT [IX_PROCESSEQP_KEY] UNIQUE NONCLUSTERED ([F_ProcessId] ASC, [F_EqpId] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO

EXEC sp_addextendedproperty
'MS_Description', N'工序设备唯一',
'SCHEMA', N'dbo',
'TABLE', N'mes_ProcessEqpBanding',
'CONSTRAINT', N'IX_PROCESSEQP_KEY'
GO


-- ----------------------------
-- Primary Key structure for table mes_ProcessEqpBanding
-- ----------------------------
ALTER TABLE [dbo].[mes_ProcessEqpBanding] ADD CONSTRAINT [PK__mes_proc__2C6EC723E7439548] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mes_ProcessFlow
-- ----------------------------
ALTER TABLE [dbo].[mes_ProcessFlow] ADD CONSTRAINT [PK__mes_proc__2C6EC7234AB5FCC4] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table mes_ReadyTransferBox
-- ----------------------------
CREATE UNIQUE NONCLUSTERED INDEX [mes_ReadyTransferBox_key1]
ON [dbo].[mes_ReadyTransferBox] (
  [F_TransferBoxCode] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table mes_ReadyTransferBox
-- ----------------------------
ALTER TABLE [dbo].[mes_ReadyTransferBox] ADD CONSTRAINT [PK__mes_Read__2C6EC723A3B4EEFC] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for mes_ReturnMaterial
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[mes_ReturnMaterial]', RESEED, 473)
GO


-- ----------------------------
-- Primary Key structure for table mes_ReturnMaterial
-- ----------------------------
ALTER TABLE [dbo].[mes_ReturnMaterial] ADD CONSTRAINT [PK_mes_returnmaterial] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for mes_ScapImage
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[mes_ScapImage]', RESEED, 12777)
GO


-- ----------------------------
-- Primary Key structure for table mes_ScapImage
-- ----------------------------
ALTER TABLE [dbo].[mes_ScapImage] ADD CONSTRAINT [PK__mes_Scap__2C6EC723E84AC3CE] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for mes_ScapMaterial
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[mes_ScapMaterial]', RESEED, 13026)
GO


-- ----------------------------
-- Uniques structure for table mes_ScapMaterial
-- ----------------------------
ALTER TABLE [dbo].[mes_ScapMaterial] ADD CONSTRAINT [IX_SCAPMATERIAL_KEY] UNIQUE NONCLUSTERED ([F_BatchCode] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mes_ScapMaterial
-- ----------------------------
ALTER TABLE [dbo].[mes_ScapMaterial] ADD CONSTRAINT [PK__mes_Scap__2C6EC72377A90C24] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for mes_ScapMaterialReturn
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[mes_ScapMaterialReturn]', RESEED, 50)
GO


-- ----------------------------
-- Primary Key structure for table mes_ScapMaterialReturn
-- ----------------------------
ALTER TABLE [dbo].[mes_ScapMaterialReturn] ADD CONSTRAINT [PK__mes_Scap__2C6EC7239BB08E25] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Uniques structure for table mes_Storage
-- ----------------------------
ALTER TABLE [dbo].[mes_Storage] ADD CONSTRAINT [IX_STORAGE_KEY] UNIQUE NONCLUSTERED ([F_TransferBoxCode] ASC, [F_MaterialId] ASC, [F_MaterialBatch] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO

EXEC sp_addextendedproperty
'MS_Description', N'唯一键',
'SCHEMA', N'dbo',
'TABLE', N'mes_Storage',
'CONSTRAINT', N'IX_STORAGE_KEY'
GO


-- ----------------------------
-- Primary Key structure for table mes_Storage
-- ----------------------------
ALTER TABLE [dbo].[mes_Storage] ADD CONSTRAINT [PK__mes_stor__2C6EC7236AEFE058] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for mes_StorageChangeInfo
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[mes_StorageChangeInfo]', RESEED, 34743)
GO


-- ----------------------------
-- Primary Key structure for table mes_StorageChangeInfo
-- ----------------------------
ALTER TABLE [dbo].[mes_StorageChangeInfo] ADD CONSTRAINT [PK__mes_stor__2C6EC7237C45DF34] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mes_TransferBox
-- ----------------------------
ALTER TABLE [dbo].[mes_TransferBox] ADD CONSTRAINT [PK_mes_transferbox] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table mes_TransferBoxBatch
-- ----------------------------
CREATE UNIQUE NONCLUSTERED INDEX [mes_TranferBoxBatch_key1]
ON [dbo].[mes_TransferBoxBatch] (
  [F_BatchCode] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table mes_TransferBoxBatch
-- ----------------------------
ALTER TABLE [dbo].[mes_TransferBoxBatch] ADD CONSTRAINT [PK__mes_Tran__2C6EC723F171DD8E] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Uniques structure for table mes_TransferTypeMaterialBanding
-- ----------------------------
ALTER TABLE [dbo].[mes_TransferTypeMaterialBanding] ADD CONSTRAINT [IX_mes_transfertypematerialbanding] UNIQUE NONCLUSTERED ([F_MaterialId] ASC, [F_TransferType] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mes_TransferTypeMaterialBanding
-- ----------------------------
ALTER TABLE [dbo].[mes_TransferTypeMaterialBanding] ADD CONSTRAINT [PK_mes_transfertypematerialbanding] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mes_WorkDetailEqpBanding
-- ----------------------------
ALTER TABLE [dbo].[mes_WorkDetailEqpBanding] ADD CONSTRAINT [PK_mes_workdetaileqpbanding] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Uniques structure for table mes_WorkDetailProcessBanding
-- ----------------------------
ALTER TABLE [dbo].[mes_WorkDetailProcessBanding] ADD CONSTRAINT [mes_workdetailprocess_key] UNIQUE NONCLUSTERED ([F_WorkOrderDetailId] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO

EXEC sp_addextendedproperty
'MS_Description', N'工单明细id唯一',
'SCHEMA', N'dbo',
'TABLE', N'mes_WorkDetailProcessBanding',
'CONSTRAINT', N'mes_workdetailprocess_key'
GO


-- ----------------------------
-- Primary Key structure for table mes_WorkDetailProcessBanding
-- ----------------------------
ALTER TABLE [dbo].[mes_WorkDetailProcessBanding] ADD CONSTRAINT [PK__mes_Work__2C6EC7233F1491F5] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for mes_WorkDetailTimeBanding
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[mes_WorkDetailTimeBanding]', RESEED, 36098)
GO


-- ----------------------------
-- Primary Key structure for table mes_WorkDetailTimeBanding
-- ----------------------------
ALTER TABLE [dbo].[mes_WorkDetailTimeBanding] ADD CONSTRAINT [PK__mes_Work__2C6EC7234AF81212] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mes_WorkOrder
-- ----------------------------
ALTER TABLE [dbo].[mes_WorkOrder] ADD CONSTRAINT [PK__mes_work__2C6EC7231332DBDC] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mes_WorkOrderDetail
-- ----------------------------
ALTER TABLE [dbo].[mes_WorkOrderDetail] ADD CONSTRAINT [PK__mes_work__2C6EC7231CBC4616] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mes_WorkPlan
-- ----------------------------
ALTER TABLE [dbo].[mes_WorkPlan] ADD CONSTRAINT [PK__mes_Work__2C6EC723C5B1A224] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mob_DingTalkConfig
-- ----------------------------
ALTER TABLE [dbo].[mob_DingTalkConfig] ADD CONSTRAINT [PK__mob_ding__2C6EC72305C6BA82] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Uniques structure for table mob_DingUser
-- ----------------------------
ALTER TABLE [dbo].[mob_DingUser] ADD CONSTRAINT [IX_SysUser] UNIQUE NONCLUSTERED ([F_SysUserId] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO

ALTER TABLE [dbo].[mob_DingUser] ADD CONSTRAINT [IX_UserId] UNIQUE NONCLUSTERED ([F_UserId] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO

EXEC sp_addextendedproperty
'MS_Description', N'系统用户唯一',
'SCHEMA', N'dbo',
'TABLE', N'mob_DingUser',
'CONSTRAINT', N'IX_SysUser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户唯一',
'SCHEMA', N'dbo',
'TABLE', N'mob_DingUser',
'CONSTRAINT', N'IX_UserId'
GO


-- ----------------------------
-- Primary Key structure for table mob_DingUser
-- ----------------------------
ALTER TABLE [dbo].[mob_DingUser] ADD CONSTRAINT [PK__mob_user__2C6EC723A2282F89] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table oms_FlowInstance
-- ----------------------------
ALTER TABLE [dbo].[oms_FlowInstance] ADD CONSTRAINT [PK__oms_flow__2C6EC723F30FF1CA] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table oms_FlowInstanceHis
-- ----------------------------
ALTER TABLE [dbo].[oms_FlowInstanceHis] ADD CONSTRAINT [PK__oms_flow__2C6EC7232AE38E98] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table oms_FlowInstanceInfo
-- ----------------------------
ALTER TABLE [dbo].[oms_FlowInstanceInfo] ADD CONSTRAINT [PK__oms_flow__2C6EC723D42B3430] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table oms_FormTest
-- ----------------------------
ALTER TABLE [dbo].[oms_FormTest] ADD CONSTRAINT [PK__oms_form__2C6EC72341CF8E5A] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for oms_Message
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[oms_Message]', RESEED, 777990)
GO


-- ----------------------------
-- Primary Key structure for table oms_Message
-- ----------------------------
ALTER TABLE [dbo].[oms_Message] ADD CONSTRAINT [PK__oms_mess__2C6EC7233CC3AB58] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for oms_MessageHis
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[oms_MessageHis]', RESEED, 425084)
GO


-- ----------------------------
-- Primary Key structure for table oms_MessageHis
-- ----------------------------
ALTER TABLE [dbo].[oms_MessageHis] ADD CONSTRAINT [PK__oms_mess__2C6EC7233EFB80A3] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table oms_UploadFile
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_OMS_UPLOADFile]
ON [dbo].[oms_UploadFile] (
  [F_FileName] ASC
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'唯一键',
'SCHEMA', N'dbo',
'TABLE', N'oms_UploadFile',
'INDEX', N'IX_OMS_UPLOADFile'
GO


-- ----------------------------
-- Primary Key structure for table oms_UploadFile
-- ----------------------------
ALTER TABLE [dbo].[oms_UploadFile] ADD CONSTRAINT [PK__oms_uplo__2C6EC723856A8FB9] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table sys_DataPrivilegeRule
-- ----------------------------
CREATE NONCLUSTERED INDEX [XK_DataPrivilegeRule_1]
ON [dbo].[sys_DataPrivilegeRule] (
  [F_ModuleId] ASC
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'唯一键',
'SCHEMA', N'dbo',
'TABLE', N'sys_DataPrivilegeRule',
'INDEX', N'XK_DataPrivilegeRule_1'
GO


-- ----------------------------
-- Primary Key structure for table sys_DataPrivilegeRule
-- ----------------------------
ALTER TABLE [dbo].[sys_DataPrivilegeRule] ADD CONSTRAINT [PK__sys_data__2C6EC723842296FC] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table sys_FilterIp
-- ----------------------------
ALTER TABLE [dbo].[sys_FilterIp] ADD CONSTRAINT [PK__sys_filt__2C6EC723AC09ECC5] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table sys_FlowScheme
-- ----------------------------
ALTER TABLE [dbo].[sys_FlowScheme] ADD CONSTRAINT [PK__sys_flow__2C6EC7234B119BE0] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table sys_Form
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_SYS_FORM]
ON [dbo].[sys_Form] (
  [F_Name] ASC
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'唯一',
'SCHEMA', N'dbo',
'TABLE', N'sys_Form',
'INDEX', N'IX_SYS_FORM'
GO


-- ----------------------------
-- Primary Key structure for table sys_Form
-- ----------------------------
ALTER TABLE [dbo].[sys_Form] ADD CONSTRAINT [PK__sys_form__2C6EC7237B02C49D] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table sys_Items
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_Sys_Items]
ON [dbo].[sys_Items] (
  [F_EnCode] ASC
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'唯一键',
'SCHEMA', N'dbo',
'TABLE', N'sys_Items',
'INDEX', N'IX_Sys_Items'
GO


-- ----------------------------
-- Primary Key structure for table sys_Items
-- ----------------------------
ALTER TABLE [dbo].[sys_Items] ADD CONSTRAINT [PK__sys_item__2C6EC723014F6202] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table sys_ItemsDetail
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_Sys_ItemsDetail]
ON [dbo].[sys_ItemsDetail] (
  [F_ItemId] ASC,
  [F_ItemCode] ASC
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'唯一键',
'SCHEMA', N'dbo',
'TABLE', N'sys_ItemsDetail',
'INDEX', N'IX_Sys_ItemsDetail'
GO


-- ----------------------------
-- Primary Key structure for table sys_ItemsDetail
-- ----------------------------
ALTER TABLE [dbo].[sys_ItemsDetail] ADD CONSTRAINT [PK__sys_item__2C6EC723D2B79129] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table sys_Log
-- ----------------------------
ALTER TABLE [dbo].[sys_Log] ADD CONSTRAINT [PK__sys_log__2C6EC723717B8B69] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table sys_Module
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_Sys_Module]
ON [dbo].[sys_Module] (
  [F_FullName] ASC
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'唯一键',
'SCHEMA', N'dbo',
'TABLE', N'sys_Module',
'INDEX', N'IX_Sys_Module'
GO


-- ----------------------------
-- Primary Key structure for table sys_Module
-- ----------------------------
ALTER TABLE [dbo].[sys_Module] ADD CONSTRAINT [PK__sys_modu__2C6EC723B04691FF] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table sys_ModuleButton
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_Sys_ModuleButton]
ON [dbo].[sys_ModuleButton] (
  [F_ModuleId] ASC,
  [F_Layers] ASC,
  [F_EnCode] ASC
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'唯一键',
'SCHEMA', N'dbo',
'TABLE', N'sys_ModuleButton',
'INDEX', N'IX_Sys_ModuleButton'
GO


-- ----------------------------
-- Primary Key structure for table sys_ModuleButton
-- ----------------------------
ALTER TABLE [dbo].[sys_ModuleButton] ADD CONSTRAINT [PK__sys_modu__2C6EC723877DFF46] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table sys_ModuleFields
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_Sys_ModuleFields]
ON [dbo].[sys_ModuleFields] (
  [F_ModuleId] ASC,
  [F_EnCode] ASC
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'唯一键',
'SCHEMA', N'dbo',
'TABLE', N'sys_ModuleFields',
'INDEX', N'IX_Sys_ModuleFields'
GO


-- ----------------------------
-- Primary Key structure for table sys_ModuleFields
-- ----------------------------
ALTER TABLE [dbo].[sys_ModuleFields] ADD CONSTRAINT [PK__sys_modu__2C6EC723A65C7258] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table sys_Notice
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_Sys_Notice]
ON [dbo].[sys_Notice] (
  [F_Title] ASC
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'唯一键',
'SCHEMA', N'dbo',
'TABLE', N'sys_Notice',
'INDEX', N'IX_Sys_Notice'
GO


-- ----------------------------
-- Primary Key structure for table sys_Notice
-- ----------------------------
ALTER TABLE [dbo].[sys_Notice] ADD CONSTRAINT [PK__sys_noti__2C6EC7233C5616A5] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table sys_OpenJob
-- ----------------------------
ALTER TABLE [dbo].[sys_OpenJob] ADD CONSTRAINT [PK__sys_open__2C6EC723BC8BDA92] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table sys_OpenJobLog
-- ----------------------------
ALTER TABLE [dbo].[sys_OpenJobLog] ADD CONSTRAINT [PK__sys_open__2C6EC723BDA80F55] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table sys_Organize
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_Sys_Organize]
ON [dbo].[sys_Organize] (
  [F_EnCode] ASC
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'唯一键',
'SCHEMA', N'dbo',
'TABLE', N'sys_Organize',
'INDEX', N'IX_Sys_Organize'
GO


-- ----------------------------
-- Primary Key structure for table sys_Organize
-- ----------------------------
ALTER TABLE [dbo].[sys_Organize] ADD CONSTRAINT [PK__sys_orga__2C6EC7233F839019] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Uniques structure for table sys_PrintTemplate
-- ----------------------------
ALTER TABLE [dbo].[sys_PrintTemplate] ADD CONSTRAINT [IX_PrintTemplate_Key] UNIQUE NONCLUSTERED ([F_PrintTemplateName] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO

EXEC sp_addextendedproperty
'MS_Description', N'名称唯一',
'SCHEMA', N'dbo',
'TABLE', N'sys_PrintTemplate',
'CONSTRAINT', N'IX_PrintTemplate_Key'
GO


-- ----------------------------
-- Primary Key structure for table sys_PrintTemplate
-- ----------------------------
ALTER TABLE [dbo].[sys_PrintTemplate] ADD CONSTRAINT [PK__sys_Prin__2C6EC723C7CBEB36] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table sys_PrintTemplateHis
-- ----------------------------
ALTER TABLE [dbo].[sys_PrintTemplateHis] ADD CONSTRAINT [PK__sys_Prin__2C6EC723C7CBEB36_copy2] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table sys_QuickModule
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_Sys_QuickModule]
ON [dbo].[sys_QuickModule] (
  [F_ModuleId] ASC,
  [F_CreatorUserId] ASC
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'唯一键',
'SCHEMA', N'dbo',
'TABLE', N'sys_QuickModule',
'INDEX', N'IX_Sys_QuickModule'
GO


-- ----------------------------
-- Primary Key structure for table sys_QuickModule
-- ----------------------------
ALTER TABLE [dbo].[sys_QuickModule] ADD CONSTRAINT [PK__sys_quic__2C6EC72395734434] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Uniques structure for table sys_ReportTemplate
-- ----------------------------
ALTER TABLE [dbo].[sys_ReportTemplate] ADD CONSTRAINT [UQ__sys_Prin__821391E39E5509F7] UNIQUE NONCLUSTERED ([F_PrintTemplateName] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table sys_ReportTemplate
-- ----------------------------
ALTER TABLE [dbo].[sys_ReportTemplate] ADD CONSTRAINT [PK__sys_Prin__2C6EC723C7CBEB36_copy1] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table sys_ReportTemplateHis
-- ----------------------------
ALTER TABLE [dbo].[sys_ReportTemplateHis] ADD CONSTRAINT [PK__sys_Prin__2C6EC723C7CBEB36_copy1_copy1] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table sys_Role
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_Sys_Role]
ON [dbo].[sys_Role] (
  [F_EnCode] ASC
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'唯一键',
'SCHEMA', N'dbo',
'TABLE', N'sys_Role',
'INDEX', N'IX_Sys_Role'
GO


-- ----------------------------
-- Primary Key structure for table sys_Role
-- ----------------------------
ALTER TABLE [dbo].[sys_Role] ADD CONSTRAINT [PK__sys_role__2C6EC7235BFA8DD6] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table sys_RoleAuthorize
-- ----------------------------
ALTER TABLE [dbo].[sys_RoleAuthorize] ADD CONSTRAINT [PK__sys_role__2C6EC7233E5D1ABB] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table sys_ServerState
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_Sys_ServerState]
ON [dbo].[sys_ServerState] (
  [F_WebSite] ASC,
  [F_Date] ASC
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'唯一键',
'SCHEMA', N'dbo',
'TABLE', N'sys_ServerState',
'INDEX', N'IX_Sys_ServerState'
GO


-- ----------------------------
-- Primary Key structure for table sys_ServerState
-- ----------------------------
ALTER TABLE [dbo].[sys_ServerState] ADD CONSTRAINT [PK__sys_serv__2C6EC723AE8017B4] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table sys_SystemSet
-- ----------------------------
ALTER TABLE [dbo].[sys_SystemSet] ADD CONSTRAINT [PK__sys_syst__2C6EC7230241109E] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table sys_User
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_Sys_User]
ON [dbo].[sys_User] (
  [F_Account] ASC
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'唯一键',
'SCHEMA', N'dbo',
'TABLE', N'sys_User',
'INDEX', N'IX_Sys_User'
GO


-- ----------------------------
-- Primary Key structure for table sys_User
-- ----------------------------
ALTER TABLE [dbo].[sys_User] ADD CONSTRAINT [PK__sys_user__2C6EC723380BF160] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table sys_UserLogon
-- ----------------------------
ALTER TABLE [dbo].[sys_UserLogon] ADD CONSTRAINT [PK__sys_user__2C6EC723DFF201AC] PRIMARY KEY CLUSTERED ([F_Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08d9a4b8-24a5-4b3e-8682-169a9ab29c05', N'39226710-b665-489e-aaa0-a8c15d29ed4c', N'0', N'1', N'NF-delete', N'删除', NULL, N'1', N'delete', N'/MaterialManage/BomInfo/DeleteForm', NULL, N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2021-11-11 10:08:25.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'')
GO

-- ----------------------------
-- Table structure for mes_SalesOrder
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_SalesOrder]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_SalesOrder]
GO

CREATE TABLE [dbo].[mes_SalesOrder] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_SalesOrderCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_Customer] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT 0 NOT NULL,
  [F_PlanStartTime] datetime2(7)  NOT NULL,
  [F_PlanEndTime] datetime2(7)  NOT NULL,
  [F_DayNum] int  NOT NULL,
  [F_TotalMoney] float(53)  NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsFinish] tinyint  NOT NULL,
  [F_PredictOverTime] datetime2(7)  NULL,
  [F_ActualOverTime] datetime2(7)  NULL,
  PRIMARY KEY CLUSTERED ([F_Id])
)
GO

ALTER TABLE [dbo].[mes_SalesOrder] SET (LOCK_ESCALATION = TABLE)
GO

-- ----------------------------
-- Table structure for mes_SalesOrderDetail
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_SalesOrderDetail]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_SalesOrderDetail]
GO

CREATE TABLE [dbo].[mes_SalesOrderDetail] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_SalesOrderId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_NeedNum] float(53) DEFAULT 0 NOT NULL,
  [F_Price] float(53) DEFAULT 0 NOT NULL,
  PRIMARY KEY CLUSTERED ([F_Id])
)
GO

ALTER TABLE [dbo].[mes_SalesOrderDetail] SET (LOCK_ESCALATION = TABLE)
GO

-- ----------------------------
-- Table structure for mes_PurchaseOrder
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_PurchaseOrder]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_PurchaseOrder]
GO

CREATE TABLE [dbo].[mes_PurchaseOrder] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_PurchaseOrderCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_Supplier] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT 0 NOT NULL,
  [F_PlanStartTime] datetime2(7)  NOT NULL,
  [F_PlanEndTime] datetime2(7)  NOT NULL,
  [F_DayNum] int  NOT NULL,
  [F_TotalMoney] float(53)  NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_CreatorTime] datetime2(7)  NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_LastModifyTime] datetime2(7)  NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteTime] datetime2(7)  NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_IsFinish] tinyint  NOT NULL,
  [F_PredictOverTime] datetime2(7)  NULL,
  [F_ActualOverTime] datetime2(7)  NULL,
  PRIMARY KEY CLUSTERED ([F_Id])
)
GO

ALTER TABLE [dbo].[mes_PurchaseOrder] SET (LOCK_ESCALATION = TABLE)
GO

-- ----------------------------
-- Table structure for mes_PurchaseOrderDetail
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_PurchaseOrderDetail]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_PurchaseOrderDetail]
GO

CREATE TABLE [dbo].[mes_PurchaseOrderDetail] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_PurchaseOrderId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_NeedNum] float(53) DEFAULT 0 NOT NULL,
  [F_Price] float(53) DEFAULT 0 NOT NULL,
  PRIMARY KEY CLUSTERED ([F_Id])
)
GO

ALTER TABLE [dbo].[mes_PurchaseOrderDetail] SET (LOCK_ESCALATION = TABLE)
GO

-- ----------------------------
-- Module: 销售管理
-- ----------------------------
INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'A1C0D965-8E51-478A-BC0E-0DB733AF3216', N'd5be1a41-547d-4001-8ae7-f6568e4d6cfe', N'2', N'SalesManage', N'销售管理', N'fa fa-shopping-bag', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'97', N'0', N'1', N'', N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'2F5C7582-9002-46B8-86FA-8616E6B23304', N'A1C0D965-8E51-478A-BC0E-0DB733AF3216', N'3', N'SalesOrder', N'销售订单', N'fa fa-list-alt', N'/SalesManage/SalesOrder/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'7262A88F-317C-47F7-9953-38490B0398C7', N'd5be1a41-547d-4001-8ae7-f6568e4d6cfe', N'2', N'PurchaseManage', N'采购管理', N'fa fa-truck', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'99', N'0', N'1', N'', N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO

INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'E351BD20-5974-417B-83F6-9F07DF2312BC', N'7262A88F-317C-47F7-9953-38490B0398C7', N'3', N'PurchaseOrder', N'采购订单', N'fa fa-list-alt', N'/PurchaseManage/PurchaseOrder/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO

-- ----------------------------
-- ModuleButton: 销售订单
-- ----------------------------
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'0B2BBD4A-25B6-4452-81DE-AFF9D88F0461', N'2F5C7582-9002-46B8-86FA-8616E6B23304', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/SalesManage/SalesOrder/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'2FD9622C-1E67-4DCE-8D41-6643B5D03E09', N'2F5C7582-9002-46B8-86FA-8616E6B23304', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/SalesManage/SalesOrder/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'9F353E2D-E0E5-4D14-9DB3-2D0A2AEBA712', N'2F5C7582-9002-46B8-86FA-8616E6B23304', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/SalesManage/SalesOrder/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'8D74C3E7-F66A-498F-94BE-E2077AB73EBC', N'2F5C7582-9002-46B8-86FA-8616E6B23304', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/SalesManage/SalesOrder/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'3944048F-971D-4723-B304-BB010336F179', N'2F5C7582-9002-46B8-86FA-8616E6B23304', N'0', N'1', N'NF-enabled', N'启用', NULL, N'2', N'enabled', N'/SalesManage/SalesOrder/EnabledForm', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'4FBD5AC2-FAD3-4CCA-BA60-EFAC1E3DCA28', N'2F5C7582-9002-46B8-86FA-8616E6B23304', N'0', N'1', N'NF-over', N'结案', NULL, N'1', N'over', N'/SalesManage/SalesOrder/OverForm', NULL, N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'')
GO

-- ----------------------------
-- ModuleButton: 采购订单
-- ----------------------------
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'09A63590-287F-4CF6-B905-32F7EFC0FD53', N'E351BD20-5974-417B-83F6-9F07DF2312BC', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/PurchaseManage/PurchaseOrder/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'A9D84F73-D2CB-4327-A679-6C30CF9B17ED', N'E351BD20-5974-417B-83F6-9F07DF2312BC', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/PurchaseManage/PurchaseOrder/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'5F9432B2-F8A4-4945-A04E-A10DD0FEC933', N'E351BD20-5974-417B-83F6-9F07DF2312BC', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/PurchaseManage/PurchaseOrder/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'0F4CCDCE-07AC-4CCD-8736-4D215ADC4E47', N'E351BD20-5974-417B-83F6-9F07DF2312BC', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/PurchaseManage/PurchaseOrder/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'A7FC151C-0BF2-4894-8851-D0419F513F31', N'E351BD20-5974-417B-83F6-9F07DF2312BC', N'0', N'1', N'NF-enabled', N'启用', NULL, N'2', N'enabled', N'/PurchaseManage/PurchaseOrder/EnabledForm', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'')
GO

INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'8F2B0C2C-504C-471E-BA01-389272D7D320', N'E351BD20-5974-417B-83F6-9F07DF2312BC', N'0', N'1', N'NF-over', N'结案', NULL, N'1', N'over', N'/PurchaseManage/PurchaseOrder/OverForm', NULL, N'0', N'0', N'0', N'5', N'0', N'1', N'', N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'')
GO

-- ----------------------------
-- ModuleFields: 销售订单
-- ----------------------------
INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'6635DE16-2084-4F33-AC10-DA1F6F41135A', N'2F5C7582-9002-46B8-86FA-8616E6B23304', N'F_SalesOrderCode', N'销售订单编号', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO
INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'33D0F49B-85A3-48A3-9F1B-64465822E179', N'2F5C7582-9002-46B8-86FA-8616E6B23304', N'F_Customer', N'客户', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO
INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'24DF6561-6498-48B4-AE1B-2ED4E00569F2', N'2F5C7582-9002-46B8-86FA-8616E6B23304', N'F_PlanStartTime', N'计划开始时间', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO
INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'BE88AF24-ED43-42CE-BA1C-2B45011BE8AF', N'2F5C7582-9002-46B8-86FA-8616E6B23304', N'F_PlanEndTime', N'计划结束时间', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO
INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'1B39B306-705D-4A90-983C-7A7D5C84E008', N'2F5C7582-9002-46B8-86FA-8616E6B23304', N'F_DayNum', N'天数', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO
INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'4C09DED6-DCC9-4FD5-8EE2-F66F76052E7C', N'2F5C7582-9002-46B8-86FA-8616E6B23304', N'F_EnabledMark', N'F_EnabledMark', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO
INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'01B09A21-2E5C-489E-B186-4AE74571FF5E', N'2F5C7582-9002-46B8-86FA-8616E6B23304', N'F_TotalMoney', N'总金额', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO
INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'D702BEBE-F4CA-4BAA-83E2-901F2E1F4506', N'2F5C7582-9002-46B8-86FA-8616E6B23304', N'F_Description', N'备注', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO
INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'1A36BCFA-6826-4F21-9E6B-2ECC5AC3A4DB', N'2F5C7582-9002-46B8-86FA-8616E6B23304', N'F_CreatorTime', N'F_CreatorTime', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO
INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'E3E5FA5A-A17B-40A3-A87B-11A44D7BEE1D', N'2F5C7582-9002-46B8-86FA-8616E6B23304', N'F_CreatorUserId', N'F_CreatorUserId', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

-- ----------------------------
-- ModuleFields: 采购订单
-- ----------------------------
INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'2614CA03-A3C7-457B-A587-09FF2D38FDAB', N'E351BD20-5974-417B-83F6-9F07DF2312BC', N'F_PurchaseOrderCode', N'采购订单编号', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO
INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'C24FC470-1747-4F76-BC3A-30B9D1AA9C1B', N'E351BD20-5974-417B-83F6-9F07DF2312BC', N'F_Supplier', N'供应商', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO
INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'EAFAB8C1-0DB0-495F-AA1D-C0F49341FA5C', N'E351BD20-5974-417B-83F6-9F07DF2312BC', N'F_PlanStartTime', N'计划开始时间', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO
INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'15F5B346-14ED-4964-8EEE-6D97C51EB12A', N'E351BD20-5974-417B-83F6-9F07DF2312BC', N'F_PlanEndTime', N'计划结束时间', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO
INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'2131A3F4-9151-4053-8089-515643826485', N'E351BD20-5974-417B-83F6-9F07DF2312BC', N'F_DayNum', N'天数', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO
INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'89B00F6C-3778-4F2D-A443-60DB0B91E67B', N'E351BD20-5974-417B-83F6-9F07DF2312BC', N'F_EnabledMark', N'F_EnabledMark', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO
INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'EAA06CCA-C392-48D7-BC24-62C546B32A56', N'E351BD20-5974-417B-83F6-9F07DF2312BC', N'F_TotalMoney', N'总金额', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO
INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'CD4FE6AD-6EB6-4D4B-8610-F37DDE9298BC', N'E351BD20-5974-417B-83F6-9F07DF2312BC', N'F_Description', N'备注', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO
INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'553F6810-4585-4C84-B33C-7F7186361877', N'E351BD20-5974-417B-83F6-9F07DF2312BC', N'F_CreatorTime', N'F_CreatorTime', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO
INSERT INTO [dbo].[sys_ModuleFields] ([F_Id], [F_ModuleId], [F_EnCode], [F_FullName], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsPublic]) VALUES (N'678417BF-4427-4D19-9221-121AD18B3E3A', N'E351BD20-5974-417B-83F6-9F07DF2312BC', N'F_CreatorUserId', N'F_CreatorUserId', N'0', N'1', NULL, N'2026-08-14 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'1')
GO

-- ----------------------------
-- Table structure for mes_EqpUserBanding
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_EqpUserBanding]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_EqpUserBanding]
GO

CREATE TABLE [dbo].[mes_EqpUserBanding] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_EqpId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [F_UserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  PRIMARY KEY CLUSTERED ([F_Id])
)
GO

ALTER TABLE [dbo].[mes_EqpUserBanding] SET (LOCK_ESCALATION = TABLE)
GO


-- ============================================
-- 销售管理 / 采购管理 扩展：建表
-- ============================================
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_SalesCustomer]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_SalesCustomer]
GO
CREATE TABLE [dbo].[mes_SalesCustomer] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_CustomerCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_CustomerName] nvarchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_Contact] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_Phone] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_Address] nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS NULL,
  [F_CreatorTime] datetime2(7) NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_LastModifyTime] datetime2(7) NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_DeleteTime] datetime2(7) NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  PRIMARY KEY CLUSTERED ([F_Id])
)
GO
ALTER TABLE [dbo].[mes_SalesCustomer] SET (LOCK_ESCALATION = TABLE)
GO

IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_PurchaseSupplier]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_PurchaseSupplier]
GO
CREATE TABLE [dbo].[mes_PurchaseSupplier] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_SupplierCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_SupplierName] nvarchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_Contact] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_Phone] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_Address] nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS NULL,
  [F_CreatorTime] datetime2(7) NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_LastModifyTime] datetime2(7) NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_DeleteTime] datetime2(7) NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  PRIMARY KEY CLUSTERED ([F_Id])
)
GO
ALTER TABLE [dbo].[mes_PurchaseSupplier] SET (LOCK_ESCALATION = TABLE)
GO

IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_SalesQuote]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_SalesQuote]
GO
CREATE TABLE [dbo].[mes_SalesQuote] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_QuoteCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_Customer] nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [F_QuoteDate] datetime2(7) NOT NULL,
  [F_TotalMoney] float(53) NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_QuoteState] int DEFAULT 0 NOT NULL,
  [F_SalesOrderId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS NULL,
  [F_CreatorTime] datetime2(7) NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_LastModifyTime] datetime2(7) NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_DeleteTime] datetime2(7) NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  PRIMARY KEY CLUSTERED ([F_Id])
)
GO
ALTER TABLE [dbo].[mes_SalesQuote] SET (LOCK_ESCALATION = TABLE)
GO

IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_SalesQuoteDetail]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_SalesQuoteDetail]
GO
CREATE TABLE [dbo].[mes_SalesQuoteDetail] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_QuoteId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_NeedNum] float(53) DEFAULT 0 NOT NULL,
  [F_Price] float(53) DEFAULT 0 NOT NULL,
  PRIMARY KEY CLUSTERED ([F_Id])
)
GO
ALTER TABLE [dbo].[mes_SalesQuoteDetail] SET (LOCK_ESCALATION = TABLE)
GO

IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_SalesDelivery]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_SalesDelivery]
GO
CREATE TABLE [dbo].[mes_SalesDelivery] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_DeliveryCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_SalesOrderId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_Customer] nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [F_DeliveryDate] datetime2(7) NOT NULL,
  [F_TotalMoney] float(53) NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS NULL,
  [F_CreatorTime] datetime2(7) NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_LastModifyTime] datetime2(7) NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_DeleteTime] datetime2(7) NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  PRIMARY KEY CLUSTERED ([F_Id])
)
GO
ALTER TABLE [dbo].[mes_SalesDelivery] SET (LOCK_ESCALATION = TABLE)
GO

IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_SalesDeliveryDetail]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_SalesDeliveryDetail]
GO
CREATE TABLE [dbo].[mes_SalesDeliveryDetail] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_DeliveryId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_NeedNum] float(53) DEFAULT 0 NOT NULL,
  [F_Price] float(53) DEFAULT 0 NOT NULL,
  PRIMARY KEY CLUSTERED ([F_Id])
)
GO
ALTER TABLE [dbo].[mes_SalesDeliveryDetail] SET (LOCK_ESCALATION = TABLE)
GO

IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_SalesReturn]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_SalesReturn]
GO
CREATE TABLE [dbo].[mes_SalesReturn] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_ReturnCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_SalesOrderId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_DeliveryId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_Customer] nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [F_ReturnDate] datetime2(7) NOT NULL,
  [F_TotalMoney] float(53) NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS NULL,
  [F_CreatorTime] datetime2(7) NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_LastModifyTime] datetime2(7) NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_DeleteTime] datetime2(7) NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  PRIMARY KEY CLUSTERED ([F_Id])
)
GO
ALTER TABLE [dbo].[mes_SalesReturn] SET (LOCK_ESCALATION = TABLE)
GO

IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_SalesReturnDetail]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_SalesReturnDetail]
GO
CREATE TABLE [dbo].[mes_SalesReturnDetail] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_ReturnId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_NeedNum] float(53) DEFAULT 0 NOT NULL,
  [F_Price] float(53) DEFAULT 0 NOT NULL,
  PRIMARY KEY CLUSTERED ([F_Id])
)
GO
ALTER TABLE [dbo].[mes_SalesReturnDetail] SET (LOCK_ESCALATION = TABLE)
GO

IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_SalesReceipt]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_SalesReceipt]
GO
CREATE TABLE [dbo].[mes_SalesReceipt] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_ReceiptCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_SalesOrderId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_Customer] nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [F_ReceiptDate] datetime2(7) NOT NULL,
  [F_Amount] float(53) DEFAULT 0 NOT NULL,
  [F_PayType] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS NULL,
  [F_CreatorTime] datetime2(7) NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_LastModifyTime] datetime2(7) NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_DeleteTime] datetime2(7) NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  PRIMARY KEY CLUSTERED ([F_Id])
)
GO
ALTER TABLE [dbo].[mes_SalesReceipt] SET (LOCK_ESCALATION = TABLE)
GO

IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_PurchaseInquiry]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_PurchaseInquiry]
GO
CREATE TABLE [dbo].[mes_PurchaseInquiry] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_InquiryCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_Supplier] nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [F_InquiryDate] datetime2(7) NOT NULL,
  [F_TotalMoney] float(53) NULL,
  [F_QuoteState] int DEFAULT 0 NOT NULL,
  [F_PurchaseOrderId] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS NULL,
  [F_CreatorTime] datetime2(7) NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_LastModifyTime] datetime2(7) NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_DeleteTime] datetime2(7) NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  PRIMARY KEY CLUSTERED ([F_Id])
)
GO
ALTER TABLE [dbo].[mes_PurchaseInquiry] SET (LOCK_ESCALATION = TABLE)
GO

IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_PurchaseInquiryDetail]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_PurchaseInquiryDetail]
GO
CREATE TABLE [dbo].[mes_PurchaseInquiryDetail] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_InquiryId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_NeedNum] float(53) DEFAULT 0 NOT NULL,
  [F_Price] float(53) DEFAULT 0 NOT NULL,
  PRIMARY KEY CLUSTERED ([F_Id])
)
GO
ALTER TABLE [dbo].[mes_PurchaseInquiryDetail] SET (LOCK_ESCALATION = TABLE)
GO

IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_PurchaseReceive]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_PurchaseReceive]
GO
CREATE TABLE [dbo].[mes_PurchaseReceive] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_ReceiveCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_PurchaseOrderId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_Supplier] nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [F_ReceiveDate] datetime2(7) NOT NULL,
  [F_TotalMoney] float(53) NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS NULL,
  [F_CreatorTime] datetime2(7) NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_LastModifyTime] datetime2(7) NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_DeleteTime] datetime2(7) NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  PRIMARY KEY CLUSTERED ([F_Id])
)
GO
ALTER TABLE [dbo].[mes_PurchaseReceive] SET (LOCK_ESCALATION = TABLE)
GO

IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_PurchaseReceiveDetail]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_PurchaseReceiveDetail]
GO
CREATE TABLE [dbo].[mes_PurchaseReceiveDetail] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_ReceiveId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_NeedNum] float(53) DEFAULT 0 NOT NULL,
  [F_Price] float(53) DEFAULT 0 NOT NULL,
  PRIMARY KEY CLUSTERED ([F_Id])
)
GO
ALTER TABLE [dbo].[mes_PurchaseReceiveDetail] SET (LOCK_ESCALATION = TABLE)
GO

IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_PurchaseReturn]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_PurchaseReturn]
GO
CREATE TABLE [dbo].[mes_PurchaseReturn] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_ReturnCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_PurchaseOrderId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_ReceiveId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_Supplier] nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [F_ReturnDate] datetime2(7) NOT NULL,
  [F_TotalMoney] float(53) NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS NULL,
  [F_CreatorTime] datetime2(7) NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_LastModifyTime] datetime2(7) NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_DeleteTime] datetime2(7) NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  PRIMARY KEY CLUSTERED ([F_Id])
)
GO
ALTER TABLE [dbo].[mes_PurchaseReturn] SET (LOCK_ESCALATION = TABLE)
GO

IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_PurchaseReturnDetail]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_PurchaseReturnDetail]
GO
CREATE TABLE [dbo].[mes_PurchaseReturnDetail] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_ReturnId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_MaterialId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_NeedNum] float(53) DEFAULT 0 NOT NULL,
  [F_Price] float(53) DEFAULT 0 NOT NULL,
  PRIMARY KEY CLUSTERED ([F_Id])
)
GO
ALTER TABLE [dbo].[mes_PurchaseReturnDetail] SET (LOCK_ESCALATION = TABLE)
GO

IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mes_PurchasePayment]') AND type IN ('U'))
	DROP TABLE [dbo].[mes_PurchasePayment]
GO
CREATE TABLE [dbo].[mes_PurchasePayment] (
  [F_Id] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_PaymentCode] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [F_PurchaseOrderId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_Supplier] nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [F_PaymentDate] datetime2(7) NOT NULL,
  [F_Amount] float(53) DEFAULT 0 NOT NULL,
  [F_PayType] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_DeleteMark] tinyint DEFAULT 0 NOT NULL,
  [F_EnabledMark] tinyint DEFAULT 1 NOT NULL,
  [F_Description] nvarchar(max) COLLATE Chinese_PRC_CI_AS NULL,
  [F_CreatorTime] datetime2(7) NULL,
  [F_CreatorUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_LastModifyTime] datetime2(7) NULL,
  [F_LastModifyUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [F_DeleteTime] datetime2(7) NULL,
  [F_DeleteUserId] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  PRIMARY KEY CLUSTERED ([F_Id])
)
GO
ALTER TABLE [dbo].[mes_PurchasePayment] SET (LOCK_ESCALATION = TABLE)
GO


-- ============================================
-- 销售管理 / 采购管理 扩展：分组菜单 + 页面菜单
-- ============================================
-- 销售管理子分组
INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'EF8638F2-4BB1-40DB-9833-C8577A5C1FC1', N'A1C0D965-8E51-478A-BC0E-0DB733AF3216', N'3', N'SalesBase', N'基础资料', N'fa fa-database', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO
INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'2517C69D-8C1E-48C7-8452-528A8441174C', N'A1C0D965-8E51-478A-BC0E-0DB733AF3216', N'3', N'SalesBusiness', N'销售业务', N'fa fa-shopping-bag', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO
INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'E606C53D-95CE-4BC4-9025-8991D3632B27', N'A1C0D965-8E51-478A-BC0E-0DB733AF3216', N'3', N'SalesMoney', N'资金管理', N'fa fa-money', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO
INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'F91F7E02-6F35-4217-9A50-2F4A56164509', N'A1C0D965-8E51-478A-BC0E-0DB733AF3216', N'3', N'SalesReportGroup', N'统计报表', N'fa fa-bar-chart', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO
-- 采购管理子分组
INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'D5C2F359-6705-4151-B062-0191B38F9B23', N'7262A88F-317C-47F7-9953-38490B0398C7', N'3', N'PurchaseBase', N'基础资料', N'fa fa-database', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO
INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'A5E310B1-8BFB-4A92-8B14-E4823CE1D001', N'7262A88F-317C-47F7-9953-38490B0398C7', N'3', N'PurchaseBusiness', N'采购业务', N'fa fa-truck', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'2', N'0', N'1', N'', N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO
INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'42F30A72-C965-4DE4-9272-EC1F6D7F5F66', N'7262A88F-317C-47F7-9953-38490B0398C7', N'3', N'PurchaseMoney', N'资金管理', N'fa fa-money', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO
INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'17C91484-056B-4552-8F1E-56C52EC84B89', N'7262A88F-317C-47F7-9953-38490B0398C7', N'3', N'PurchaseReportGroup', N'统计报表', N'fa fa-bar-chart', NULL, N'expand', N'1', N'1', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO
-- 销售页面
INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'59EF09E6-6FC4-4579-B7B5-DF379EB3217E', N'EF8638F2-4BB1-40DB-9833-C8577A5C1FC1', N'4', N'Customer', N'客户管理', N'fa fa-users', N'/SalesManage/Customer/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO
INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'D4888C71-0632-4310-885E-57E99F664885', N'2517C69D-8C1E-48C7-8452-528A8441174C', N'4', N'SalesQuote', N'销售报价单', N'fa fa-file-text-o', N'/SalesManage/SalesQuote/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO
INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'8B6507F4-CB60-48B3-AF7E-4429C5789367', N'2517C69D-8C1E-48C7-8452-528A8441174C', N'4', N'SalesDelivery', N'销售发货单', N'fa fa-truck', N'/SalesManage/SalesDelivery/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO
INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'7F002EAD-1B94-4C7E-87E9-9AF3F8896656', N'2517C69D-8C1E-48C7-8452-528A8441174C', N'4', N'SalesReturn', N'销售退货单', N'fa fa-undo', N'/SalesManage/SalesReturn/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO
INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'6FDCD8E8-C26D-4C5F-BBB0-A4024CB35D13', N'E606C53D-95CE-4BC4-9025-8991D3632B27', N'4', N'SalesReceipt', N'销售收款', N'fa fa-money', N'/SalesManage/SalesReceipt/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO
INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'2AAC38F0-DB62-40FD-88CD-8ABCC68BAD97', N'F91F7E02-6F35-4217-9A50-2F4A56164509', N'4', N'SalesReport', N'销售统计', N'fa fa-line-chart', N'/SalesManage/SalesReport/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO
-- 采购页面
INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'5C9FD769-6081-402A-B1FF-8C59207AF24F', N'D5C2F359-6705-4151-B062-0191B38F9B23', N'4', N'Supplier', N'供应商管理', N'fa fa-users', N'/PurchaseManage/Supplier/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO
INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'6AED7A89-EB85-41F9-A292-4247257086F8', N'A5E310B1-8BFB-4A92-8B14-E4823CE1D001', N'4', N'PurchaseInquiry', N'采购询价单', N'fa fa-file-text-o', N'/PurchaseManage/PurchaseInquiry/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO
INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'6763A41B-9308-4CF7-8C57-5A81B9C37275', N'A5E310B1-8BFB-4A92-8B14-E4823CE1D001', N'4', N'PurchaseReceive', N'采购收货单', N'fa fa-sign-in', N'/PurchaseManage/PurchaseReceive/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'3', N'0', N'1', N'', N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO
INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'7212244A-A45A-40F4-B59A-2E0F4CDBD039', N'A5E310B1-8BFB-4A92-8B14-E4823CE1D001', N'4', N'PurchaseReturn', N'采购退货单', N'fa fa-undo', N'/PurchaseManage/PurchaseReturn/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'4', N'0', N'1', N'', N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO
INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'560F7C48-E85E-4693-89F6-AFC2A77D47A2', N'42F30A72-C965-4DE4-9272-EC1F6D7F5F66', N'4', N'PurchasePayment', N'采购付款', N'fa fa-money', N'/PurchaseManage/PurchasePayment/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO
INSERT INTO [dbo].[sys_Module] ([F_Id], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_UrlAddress], [F_Target], [F_IsMenu], [F_IsExpand], [F_IsFields], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_IsBoard], [F_Authorize]) VALUES (N'B74EC7F9-170A-4C4E-A1FA-9FCCE358B03D', N'17C91484-056B-4552-8F1E-56C52EC84B89', N'4', N'PurchaseReport', N'采购统计', N'fa fa-line-chart', N'/PurchaseManage/PurchaseReport/Index', N'iframe', N'1', N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'1', N'', N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, N'0', N'')
GO
-- 重挂已有订单菜单到业务分组
UPDATE [dbo].[sys_Module] SET [F_ParentId]=N'2517C69D-8C1E-48C7-8452-528A8441174C', [F_Layers]=N'4', [F_SortCode]=N'2' WHERE [F_Id]=N'2F5C7582-9002-46B8-86FA-8616E6B23304'
GO
UPDATE [dbo].[sys_Module] SET [F_ParentId]=N'A5E310B1-8BFB-4A92-8B14-E4823CE1D001', [F_Layers]=N'4', [F_SortCode]=N'2' WHERE [F_Id]=N'E351BD20-5974-417B-83F6-9F07DF2312BC'
GO


-- ============================================
-- 销售管理 / 采购管理 扩展：按钮 + 角色授权
-- ============================================
-- 客户管理 按钮
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'CD6AB6D2-644B-4F7C-B9C9-AC8E75FF2DB9', N'59EF09E6-6FC4-4579-B7B5-DF379EB3217E', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/SalesManage/Customer/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'D344626E-601B-4E8C-B11A-A0B3ED4FFAFD', N'59EF09E6-6FC4-4579-B7B5-DF379EB3217E', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/SalesManage/Customer/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'9FC7A148-7752-45EC-8E5A-DE5261D5CEEE', N'59EF09E6-6FC4-4579-B7B5-DF379EB3217E', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/SalesManage/Customer/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'5DE9EE5A-E6D5-4C35-8EB3-7899161F79B3', N'59EF09E6-6FC4-4579-B7B5-DF379EB3217E', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/SalesManage/Customer/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
-- 销售报价单 按钮
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'B4694DB7-ECAA-41B4-9B5F-B1BB5824E19B', N'D4888C71-0632-4310-885E-57E99F664885', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/SalesManage/SalesQuote/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'2C703E59-2A8D-41DC-843C-210AB01D6C4C', N'D4888C71-0632-4310-885E-57E99F664885', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/SalesManage/SalesQuote/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'92E0A8FB-4476-4DE3-8DF3-11B359299150', N'D4888C71-0632-4310-885E-57E99F664885', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/SalesManage/SalesQuote/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'B4CF44E5-4F8E-452C-A41B-D5A167B4DDDB', N'D4888C71-0632-4310-885E-57E99F664885', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/SalesManage/SalesQuote/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
-- 销售发货单 按钮
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'F02157CD-B9AD-41BA-B81D-2B617902EB56', N'8B6507F4-CB60-48B3-AF7E-4429C5789367', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/SalesManage/SalesDelivery/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'35EF769F-7A26-40E4-B79B-B2B500BA1D24', N'8B6507F4-CB60-48B3-AF7E-4429C5789367', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/SalesManage/SalesDelivery/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'567C3DC7-BC07-4C64-8495-8E8EE4FDE5EF', N'8B6507F4-CB60-48B3-AF7E-4429C5789367', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/SalesManage/SalesDelivery/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'BADDB3B4-6558-4C54-84B5-86F3609F7F1E', N'8B6507F4-CB60-48B3-AF7E-4429C5789367', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/SalesManage/SalesDelivery/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
-- 销售退货单 按钮
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'8D918B1E-3864-4C39-B7FC-B38C95441138', N'7F002EAD-1B94-4C7E-87E9-9AF3F8896656', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/SalesManage/SalesReturn/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'073E9506-1482-41BE-A3B6-4BEF9BBAEE76', N'7F002EAD-1B94-4C7E-87E9-9AF3F8896656', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/SalesManage/SalesReturn/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'747CF646-EFBB-4B57-8C93-6BF9CD5C864B', N'7F002EAD-1B94-4C7E-87E9-9AF3F8896656', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/SalesManage/SalesReturn/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'53A9EAFE-E290-4DB0-B96C-87BF56E054A5', N'7F002EAD-1B94-4C7E-87E9-9AF3F8896656', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/SalesManage/SalesReturn/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
-- 销售收款 按钮
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'C0E9B6D2-5B1C-42BF-A12D-2B7DEE0A2B6A', N'6FDCD8E8-C26D-4C5F-BBB0-A4024CB35D13', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/SalesManage/SalesReceipt/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'F3C2C497-4317-4C47-B0B6-B4A831E9129F', N'6FDCD8E8-C26D-4C5F-BBB0-A4024CB35D13', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/SalesManage/SalesReceipt/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'31EDDF5E-EBE7-478C-B031-3557A43A60F5', N'6FDCD8E8-C26D-4C5F-BBB0-A4024CB35D13', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/SalesManage/SalesReceipt/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'719D8427-75E3-4DC6-9A53-1AD528A5B290', N'6FDCD8E8-C26D-4C5F-BBB0-A4024CB35D13', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/SalesManage/SalesReceipt/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
-- 供应商管理 按钮
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'A4D64066-3725-4E68-B3CD-B7BEB1537410', N'5C9FD769-6081-402A-B1FF-8C59207AF24F', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/PurchaseManage/Supplier/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'A048D717-38ED-421D-AED7-6BE60CFEBD8F', N'5C9FD769-6081-402A-B1FF-8C59207AF24F', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/PurchaseManage/Supplier/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'23DFE88A-4585-47B0-8106-1E6D71925F79', N'5C9FD769-6081-402A-B1FF-8C59207AF24F', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/PurchaseManage/Supplier/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'3C61D86B-8A20-49C0-B418-8F114F02CFFD', N'5C9FD769-6081-402A-B1FF-8C59207AF24F', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/PurchaseManage/Supplier/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
-- 采购询价单 按钮
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'08CA70D0-C8F9-4D42-82DB-72ED5C8EC301', N'6AED7A89-EB85-41F9-A292-4247257086F8', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/PurchaseManage/PurchaseInquiry/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'FB2BB0AB-D168-461C-903A-6C12EBD6146E', N'6AED7A89-EB85-41F9-A292-4247257086F8', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/PurchaseManage/PurchaseInquiry/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'E328D016-BC36-4DA0-A168-F708E013B6F5', N'6AED7A89-EB85-41F9-A292-4247257086F8', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/PurchaseManage/PurchaseInquiry/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'633E0398-7FA2-4A6A-9F63-F9BEA88F383C', N'6AED7A89-EB85-41F9-A292-4247257086F8', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/PurchaseManage/PurchaseInquiry/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
-- 采购收货单 按钮
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'3A854830-8086-40CE-9816-F40A78746408', N'6763A41B-9308-4CF7-8C57-5A81B9C37275', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/PurchaseManage/PurchaseReceive/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'8A5E8F33-6ED5-4E1A-BDBA-EBD5E6217D2E', N'6763A41B-9308-4CF7-8C57-5A81B9C37275', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/PurchaseManage/PurchaseReceive/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'51D5A9DA-A318-4552-9736-E1CDFBE7453D', N'6763A41B-9308-4CF7-8C57-5A81B9C37275', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/PurchaseManage/PurchaseReceive/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'2167DE58-89F4-4264-9321-209C4842720C', N'6763A41B-9308-4CF7-8C57-5A81B9C37275', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/PurchaseManage/PurchaseReceive/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
-- 采购退货单 按钮
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'71D783B2-4927-4FAF-A8AD-570CC5FBD008', N'7212244A-A45A-40F4-B59A-2E0F4CDBD039', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/PurchaseManage/PurchaseReturn/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'EA08BC91-74F3-42A7-9126-4AF6F9526313', N'7212244A-A45A-40F4-B59A-2E0F4CDBD039', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/PurchaseManage/PurchaseReturn/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'FA91802A-4953-4FD4-88A4-9547C50F6622', N'7212244A-A45A-40F4-B59A-2E0F4CDBD039', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/PurchaseManage/PurchaseReturn/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'0221D7A2-4701-4DA2-8467-FFB83F1F7F93', N'7212244A-A45A-40F4-B59A-2E0F4CDBD039', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/PurchaseManage/PurchaseReturn/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
-- 采购付款 按钮
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'7E347338-EA36-4B8B-9214-EE670F14E076', N'560F7C48-E85E-4693-89F6-AFC2A77D47A2', N'0', N'1', N'NF-add', N'新增', NULL, N'1', N'add', N'/PurchaseManage/PurchasePayment/Form', N'0', N'0', N'0', N'0', N'0', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'E28812EF-5E4A-4487-AD99-DE744F9A7C10', N'560F7C48-E85E-4693-89F6-AFC2A77D47A2', N'0', N'1', N'NF-edit', N'修改', NULL, N'2', N'edit', N'/PurchaseManage/PurchasePayment/Form', N'0', N'0', N'0', N'0', N'1', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'D4AB5A91-0CBE-4851-9807-5CA9877BDB4D', N'560F7C48-E85E-4693-89F6-AFC2A77D47A2', N'0', N'1', N'NF-delete', N'删除', NULL, N'2', N'delete', N'/PurchaseManage/PurchasePayment/DeleteForm', N'0', N'0', N'0', N'0', N'2', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO [dbo].[sys_ModuleButton] ([F_Id], [F_ModuleId], [F_ParentId], [F_Layers], [F_EnCode], [F_FullName], [F_Icon], [F_Location], [F_JsEvent], [F_UrlAddress], [F_Split], [F_IsPublic], [F_AllowEdit], [F_AllowDelete], [F_SortCode], [F_DeleteMark], [F_EnabledMark], [F_Description], [F_CreatorTime], [F_CreatorUserId], [F_LastModifyTime], [F_LastModifyUserId], [F_DeleteTime], [F_DeleteUserId], [F_Authorize]) VALUES (N'CC98699C-229C-4E98-8EAF-063735440A27', N'560F7C48-E85E-4693-89F6-AFC2A77D47A2', N'0', N'1', N'NF-details', N'查看', NULL, N'2', N'details', N'/PurchaseManage/PurchasePayment/Details', N'0', N'0', N'0', N'0', N'3', N'0', N'1', NULL, N'2026-08-15 00:00:00.0000000', N'9f2ec079-7d0f-4fe2-90ab-8b09a8302aba', NULL, NULL, NULL, NULL, NULL)
GO
