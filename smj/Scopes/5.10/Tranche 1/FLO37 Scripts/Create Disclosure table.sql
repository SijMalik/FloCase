--SMJ - 15-08-2011- Create new table 'DISCLOSURE'

USE [FloSuite_Data_Dev]
GO

/****** Object:  Table [dbo].[Disclosure]    Script Date: 08/15/2011 10:37:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Disclosure](
	[Disclosure_DisclosureID] [int] IDENTITY(1,1) NOT NULL,
	[Disclosure_DisclosureCode] [varchar](255) NOT NULL,
	[Disclosure_CaseID] [int] NOT NULL,
	[Disclosure_DiscDealtWith] [varchar](255) NULL,
	[Disclosure_FurDocsReq] [varchar](255) NULL,
	[Disclosure_ReqDocsFrom] [int] NULL,
	[Disclosure_ExtDam] [bit] NULL,
	[Disclosure_MOT] [bit] NULL,
	[Disclosure_MaintRep] [bit] NULL,
	[Disclosure_Tacho] [bit] NULL,
	[Disclosure_ComMaintRep] [bit] NULL,
	[Disclosure_LocalAuth] [bit] NULL,
	[Disclosure_AccidBook] [bit] NULL,
	[Disclosure_FirstAid] [bit] NULL,
	[Disclosure_SurgeryRec] [bit] NULL,
	[Disclosure_SuperAccidRep] [bit] NULL,
	[Disclosure_SafeRepAccidRep] [bit] NULL,
	[Disclosure_Riddorrep] [bit] NULL,
	[Disclosure_OtherComms] [bit] NULL,
	[Disclosure_MinsHlthSafe] [bit] NULL,
	[Disclosure_DSSRep] [bit] NULL,
	[Disclosure_SimilAccidDocs] [bit] NULL,
	[Disclosure_EarningInfo] [bit] NULL,
	[Disclosure_PreAccidRisk] [bit] NULL,
	[Disclosure_PostAccidRisk] [bit] NULL,
	[Disclosure_AccidInvestRecs] [bit] NULL,
	[Disclosure_HealthSurvRep] [bit] NULL,
	[Disclosure_InfoToEmps] [bit] NULL,
	[Disclosure_HandSTrainDocs] [bit] NULL,
	[Disclosure_WorkPlaceReg] [bit] NULL,
	[Disclosure_WorkEquipReg] [bit] NULL,
	[Disclosure_ProtectEquipReg] [bit] NULL,
	[Disclosure_ManHandReg] [bit] NULL,
	[Disclosure_DispScreenReg] [bit] NULL,
	[Disclosure_COSHHReg] [bit] NULL,
	[Disclosure_PressGasReg] [bit] NULL,
	[Disclosure_LiftingReg] [bit] NULL,
	[Disclosure_NoiseReg] [bit] NULL,
	[Disclosure_ConstructGenReg] [bit] NULL,
	[Disclosure_WPRepMaintRecs] [bit] NULL,
	[Disclosure_WPHouseKeepRecs] [bit] NULL,
	[Disclosure_WPHazardSign] [bit] NULL,
	[Disclosure_WEManSpec] [bit] NULL,
	[Disclosure_WEMaintLog] [bit] NULL,
	[Disclosure_WEInfoToEmps] [bit] NULL,
	[Disclosure_WETrainDocs] [bit] NULL,
	[Disclosure_WENoticeSign] [bit] NULL,
	[Disclosure_WEInstructDocs] [bit] NULL,
	[Disclosure_WECopyMark] [bit] NULL,
	[Disclosure_WECopyWarn] [bit] NULL,
	[Disclosure_PEAssessDocs] [bit] NULL,
	[Disclosure_PEMaintRepDocs] [bit] NULL,
	[Disclosure_PEMaintProcDocs] [bit] NULL,
	[Disclosure_PETestDocs] [bit] NULL,
	[Disclosure_PEInfoToEmps] [bit] NULL,
	[Disclosure_PEInstructDocs] [bit] NULL,
	[Disclosure_MHPreAccidRisk] [bit] NULL,
	[Disclosure_MHPostAccidRisk] [bit] NULL,
	[Disclosure_MHInfoToEmps] [bit] NULL,
	[Disclosure_MHTrainDocs] [bit] NULL,
	[Disclosure_DSPreAccidRisk] [bit] NULL,
	[Disclosure_DSPostAccidRisk] [bit] NULL,
	[Disclosure_DSTrainDocs] [bit] NULL,
	[Disclosure_DSInfoToEmps] [bit] NULL,
	[Disclosure_PGSpecMarking] [bit] NULL,
	[Disclosure_PGWrittenStatmnt] [bit] NULL,
	[Disclosure_PGCopyWrittenStatmnt] [bit] NULL,
	[Disclosure_PGExamRecs] [bit] NULL,
	[Disclosure_PGInstructUse] [bit] NULL,
	[Disclosure_PGRecsA] [bit] NULL,
	[Disclosure_PGRecsB] [bit] NULL,
	[Disclosure_CHAirMonitorRecs] [bit] NULL,
	[Disclosure_CHMonitorRecs] [bit] NULL,
	[Disclosure_CHHlthSurvRecs] [bit] NULL,
	[Disclosure_CHPreAccidRisk] [bit] NULL,
	[Disclosure_CHPostAccidRisk] [bit] NULL,
	[Disclosure_CHCopyLabel] [bit] NULL,
	[Disclosure_CHWarnSign] [bit] NULL,
	[Disclosure_CHLabelData] [bit] NULL,
	[Disclosure_CHMaintExamRecs] [bit] NULL,
	[Disclosure_CHTrainDocs] [bit] NULL,
	[Disclosure_CHAssessDocs] [bit] NULL,
	[Disclosure_CHInstructUse] [bit] NULL,
	[Disclosure_CHMaintRepDocs] [bit] NULL,
	[Disclosure_CHMaintProcDocs] [bit] NULL,
	[Disclosure_CHTestRecs] [bit] NULL,
	[Disclosure_CHInfoToEmps] [bit] NULL,
	[Disclosure_NRiskAssess] [bit] NULL,
	[Disclosure_NManufactLit] [bit] NULL,
	[Disclosure_NInfoToEmps] [bit] NULL,
	[Disclosure_CGRepExcavn] [bit] NULL,
	[Disclosure_CGRepCoffer] [bit] NULL,
	[Disclosure_DMProjectForm] [bit] NULL,
	[Disclosure_DMPlan] [bit] NULL,
	[Disclosure_DMFile] [bit] NULL,
	[Disclosure_DMTrainDocs] [bit] NULL,
	[Disclosure_DMAdviceRecs] [bit] NULL,
	[Disclosure_HPPreAccidRisk] [bit] NULL,
	[Disclosure_HPPostAccidRisk] [bit] NULL,
	[Disclosure_InspectionRecs] [bit] NULL,
	[Disclosure_MaintRecs] [bit] NULL,
	[Disclosure_PolicyMins] [bit] NULL,
	[Disclosure_ComplaintRecs] [bit] NULL,
	[Disclosure_OtherAccidRecs] [bit] NULL,
	[Disclosure_InActive] [bit] NULL,
	[Disclosure_CreateUser] [varchar](255) NULL,
	[Disclosure_CreateDate] [smalldatetime] NULL,
 CONSTRAINT [PK_Disclosure] PRIMARY KEY CLUSTERED 
(
	[Disclosure_DisclosureID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_ExtDam]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_MOT]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_MaintRep]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_Tacho]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_ComMaintRep]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_LocalAuth]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_AccidBook]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_FirstAid]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_SurgeryRec]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_SuperAccidRep]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_SafeRepAccidRep]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_Riddorrep]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_OtherComms]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_MinsHlthSafe]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_DSSRep]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_SimilAccidDocs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_EarningInfo]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_PreAccidRisk]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_PostAccidRisk]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_AccidInvestRecs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_HealthSurvRep]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_InfoToEmps]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_HandSTrainDocs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_WorkPlaceReg]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_WorkEquipReg]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_ProtectEquipReg]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_ManHandReg]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_DispScreenReg]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_COSHHReg]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_PressGasReg]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_LiftingReg]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_NoiseReg]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_ConstructGenReg]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_WPRepMaintRecs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_WPHouseKeepRecs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_WPHazardSign]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_WEManSpec]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_WEMaintLog]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_WEInfoToEmps]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_WETrainDocs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_WENoticeSign]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_WEInstructDocs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_WECopyMark]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_WECopyWarn]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_PEAssessDocs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_PEMaintRepDocs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_PEMaintProcDocs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_PETestDocs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_PEInfoToEmps]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_PEInstructDocs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_MHPreAccidRisk]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_MHPostAccidRisk]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_MHInfoToEmps]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_MHTrainDocs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_DSPreAccidRisk]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_DSPostAccidRisk]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_DSTrainDocs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_DSInfoToEmps]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_PGSpecMarking]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_PGWrittenStatmnt]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_PGCopyWrittenStatmnt]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_PGExamRecs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_PGInstructUse]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_PGRecsA]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_PGRecsB]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_CHAirMonitorRecs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_CHMonitorRecs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_CHHlthSurvRecs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_CHPreAccidRisk]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_CHPostAccidRisk]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_CHCopyLabel]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_CHWarnSign]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_CHLabelData]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_CHMaintExamRecs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_CHTrainDocs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_CHAssessDocs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_CHInstructUse]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_CHMaintRepDocs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_CHMaintProcDocs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_CHTestRecs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_CHInfoToEmps]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_NRiskAssess]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_NManufactLit]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_NInfoToEmps]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_CGRepExcavn]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_CGRepCoffer]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_DMProjectForm]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_DMPlan]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_DMFile]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_DMTrainDocs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_DMAdviceRecs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_HPPreAccidRisk]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_HPPostAccidRisk]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_InspectionRecs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_MaintRecs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_PolicyMins]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_ComplaintRecs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_OtherAccidRecs]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT ((0)) FOR [Disclosure_InActive]
GO

ALTER TABLE [dbo].[Disclosure] ADD  DEFAULT (getdate()) FOR [Disclosure_CreateDate]
GO


