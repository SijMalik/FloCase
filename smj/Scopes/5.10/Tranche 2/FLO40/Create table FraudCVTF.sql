
/****** Object:  Table [dbo].[FraudCVTF]    Script Date: 09/13/2011 15:06:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[FraudCVTF](
	[FraudCVTF_FraudCVTFID] [int] IDENTITY(1,1) NOT NULL,
	[FraudCVTF_FraudCVTFCode] [varchar](255) NOT NULL,
	[FraudCVTF_CaseID] [int] NOT NULL,
	[FraudCVTF_IndmntyCnfmd] [bit] NULL,
	[FraudCVTF_IndmntyRsvrd] [bit] NULL,
	[FraudCVTF_IndmntyRfsd] [bit] NULL,
	[FraudCVTF_CnsntIndmntyFrmSnt] [bit] NULL,
	[FraudCVTF_PolAppIssues] [bit] NULL,
	[FraudCVTF_RsrvtnLtrSnt] [bit] NULL,
	[FraudCVTF_RfslIndmntyLtrSnt] [bit] NULL,
	[FraudCVTF_LwyrNotes] [varchar](max) NULL,
	[FraudCVTF_AccdntHtSpt] [bit] NULL,
	[FraudCVTF_UnslAccdntCirc] [bit] NULL,
	[FraudCVTF_MutiClaim] [bit] NULL,
	[FraudCVTF_NoAccdntBkEntry] [bit] NULL,
	[FraudCVTF_UnslLOE] [bit] NULL,
	[FraudCVTF_LegalBfrMdcl] [bit] NULL,
	[FraudCVTF_OtherAccdnts] [bit] NULL,
	[FraudCVTF_UnslNoWtnss] [bit] NULL,
	[FraudCVTF_InconMedRec] [bit] NULL,
	[FraudCVTF_InconOccHlth] [bit] NULL,
	[FraudCVTF_InconFnncl] [bit] NULL,
	[FraudCVTF_InconWitEvid] [bit] NULL,
	[FraudCVTF_ClmntUncprtv] [bit] NULL,
	[FraudCVTF_ClmntEmpStat] [bit] NULL,
	[FraudCVTF_ClmntGrvnce] [bit] NULL,
	[FraudCVTF_ClmntEmpBust] [bit] NULL,
	[FraudCVTF_ClmntDshnst] [bit] NULL,
	[FraudCVTF_ClmntNilCRU] [bit] NULL,
	[FraudCVTF_ClmntMultiClaim] [bit] NULL,
	[FraudCVTF_ClmntFnnclDiff] [bit] NULL,
	[FraudCVTF_ClmntRddnt] [bit] NULL,
	[FraudCVTF_ClmntDlyNtfctn] [bit] NULL,
	[FraudCVTF_ClmntTrnsntAddrss] [bit] NULL,
	[FraudCVTF_ClmntUnslSttlmnt] [bit] NULL,
	[FraudCVTF_ClmntGrvnc] [bit] NULL,
	[FraudCVTF_PlcyhldrUncprtv] [bit] NULL,
	[FraudCVTF_PlcyhldrPlcyExprs] [bit] NULL,
	[FraudCVTF_PlcyhldrNonDsclsr] [bit] NULL,
	[FraudCVTF_PlcyhldrLateNtfctnClm] [bit] NULL,
	[FraudCVTPlcyhldrF_PlcyhldrPlcyStrts] [bit] NULL,
	[FraudCVTF_PlcyhldrMultiClm] [bit] NULL,
	[FraudCVTF_PlcyhldrRcntChngsCvr] [bit] NULL,
	[FraudCVTF_FraudLwyr] [nvarchar](255) NULL,
	[FraudCVTF_LwyrRvwDte] [smalldatetime] NULL,
	[FraudCVTF_LwyrRfrFile] [bit] NULL,
	[FraudCVTF_AssgndFraudCrdntr] [nvarchar](255) NULL,
	[FraudCVTF_FraudRskRtng] [nvarchar](255) NULL,
	[FraudCVTF_CUE] [bit] NULL,
	[FraudCVTF_InsrncFraudInvGrp] [bit] NULL,
	[FraudCVTF_CrdtHstry] [bit] NULL,
	[FraudCVTF_FnceRprt] [bit] NULL,
	[FraudCVTF_LndRgstryChck] [bit] NULL,
	[FraudCVTF_IDChck] [bit] NULL,
	[FraudCVTF_OpnDataSrcs] [bit] NULL,
	[FraudCVTF_OthrSrcs] [bit] NULL,
	[FraudCVTF_FileNotes] [nvarchar](max) NULL,
	[FraudCVTF_FraudCrdntr] [nvarchar](255) NULL,
	[FraudCVTF_FraudCrdntrRvwDte] [smalldatetime] NULL,
	[FraudCVTF_FraudCrdntrRfrFile] [bit] NULL,
	[FraudCVTF_FraudTmMmbr] [nvarchar](255) NULL,
	[FraudCVTF_IIVRDate] [smalldatetime] NULL,
	[FraudCVTF_IIVRName] [nvarchar](255) NULL,
	[FraudCVTF_FraudTmCmmnts] [nvarchar](max) NULL,
	[FraudCVTF_DtldIntllgncRprtRqrd] [bit] NULL,
	[FraudCVTF_DtldIntllgncRprtDte] [smalldatetime] NULL,
	[FraudCVTF_DtldIntllgncRprtNme] [nvarchar](255) NULL,
	[FraudCVTF_FraudClsreTag] [nvarchar](255) NULL,
	[FraudCVTF_FraudTmRvwNme] [nvarchar](255) NULL,
	[FraudCVTF_FraudTmRvwDte] [smalldatetime] NULL,
	[FraudCVTF_InActive] [bit] NULL,
	[FraudCVTF_CreateUser] [nvarchar](255) NOT NULL,
	[FraudCVTF_CreateDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_FraudCVTF] PRIMARY KEY CLUSTERED 
(
	[FraudCVTF_FraudCVTFID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__65DA1E33]  DEFAULT ((0)) FOR [FraudCVTF_IndmntyCnfmd]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__66CE426C]  DEFAULT ((0)) FOR [FraudCVTF_IndmntyRsvrd]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__67C266A5]  DEFAULT ((0)) FOR [FraudCVTF_IndmntyRfsd]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__68B68ADE]  DEFAULT ((0)) FOR [FraudCVTF_CnsntIndmntyFrmSnt]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__69AAAF17]  DEFAULT ((0)) FOR [FraudCVTF_PolAppIssues]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__6A9ED350]  DEFAULT ((0)) FOR [FraudCVTF_RsrvtnLtrSnt]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__6B92F789]  DEFAULT ((0)) FOR [FraudCVTF_RfslIndmntyLtrSnt]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__6C871BC2]  DEFAULT ((0)) FOR [FraudCVTF_AccdntHtSpt]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__6D7B3FFB]  DEFAULT ((0)) FOR [FraudCVTF_UnslAccdntCirc]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__6E6F6434]  DEFAULT ((0)) FOR [FraudCVTF_MutiClaim]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__6F63886D]  DEFAULT ((0)) FOR [FraudCVTF_NoAccdntBkEntry]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__7057ACA6]  DEFAULT ((0)) FOR [FraudCVTF_UnslLOE]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__714BD0DF]  DEFAULT ((0)) FOR [FraudCVTF_LegalBfrMdcl]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__723FF518]  DEFAULT ((0)) FOR [FraudCVTF_OtherAccdnts]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__73341951]  DEFAULT ((0)) FOR [FraudCVTF_UnslNoWtnss]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__74283D8A]  DEFAULT ((0)) FOR [FraudCVTF_InconMedRec]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__751C61C3]  DEFAULT ((0)) FOR [FraudCVTF_InconOccHlth]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__761085FC]  DEFAULT ((0)) FOR [FraudCVTF_InconFnncl]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__7704AA35]  DEFAULT ((0)) FOR [FraudCVTF_InconWitEvid]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__77F8CE6E]  DEFAULT ((0)) FOR [FraudCVTF_ClmntUncprtv]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__78ECF2A7]  DEFAULT ((0)) FOR [FraudCVTF_ClmntEmpStat]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__79E116E0]  DEFAULT ((0)) FOR [FraudCVTF_ClmntGrvnce]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__7AD53B19]  DEFAULT ((0)) FOR [FraudCVTF_ClmntEmpBust]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__7BC95F52]  DEFAULT ((0)) FOR [FraudCVTF_ClmntDshnst]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__7CBD838B]  DEFAULT ((0)) FOR [FraudCVTF_ClmntNilCRU]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__7DB1A7C4]  DEFAULT ((0)) FOR [FraudCVTF_ClmntMultiClaim]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__7EA5CBFD]  DEFAULT ((0)) FOR [FraudCVTF_ClmntFnnclDiff]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__7F99F036]  DEFAULT ((0)) FOR [FraudCVTF_ClmntRddnt]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__008E146F]  DEFAULT ((0)) FOR [FraudCVTF_ClmntDlyNtfctn]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__018238A8]  DEFAULT ((0)) FOR [FraudCVTF_ClmntTrnsntAddrss]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__02765CE1]  DEFAULT ((0)) FOR [FraudCVTF_ClmntUnslSttlmnt]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__036A811A]  DEFAULT ((0)) FOR [FraudCVTF_ClmntGrvnc]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__045EA553]  DEFAULT ((0)) FOR [FraudCVTF_PlcyhldrUncprtv]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__0552C98C]  DEFAULT ((0)) FOR [FraudCVTF_PlcyhldrPlcyExprs]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__0646EDC5]  DEFAULT ((0)) FOR [FraudCVTF_PlcyhldrNonDsclsr]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__073B11FE]  DEFAULT ((0)) FOR [FraudCVTF_PlcyhldrLateNtfctnClm]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__082F3637]  DEFAULT ((0)) FOR [FraudCVTPlcyhldrF_PlcyhldrPlcyStrts]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__09235A70]  DEFAULT ((0)) FOR [FraudCVTF_PlcyhldrMultiClm]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__0A177EA9]  DEFAULT ((0)) FOR [FraudCVTF_PlcyhldrRcntChngsCvr]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__0B0BA2E2]  DEFAULT ((0)) FOR [FraudCVTF_LwyrRfrFile]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__0BFFC71B]  DEFAULT ((0)) FOR [FraudCVTF_CUE]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__0CF3EB54]  DEFAULT ((0)) FOR [FraudCVTF_InsrncFraudInvGrp]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__0DE80F8D]  DEFAULT ((0)) FOR [FraudCVTF_CrdtHstry]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__0EDC33C6]  DEFAULT ((0)) FOR [FraudCVTF_FnceRprt]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__0FD057FF]  DEFAULT ((0)) FOR [FraudCVTF_LndRgstryChck]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__10C47C38]  DEFAULT ((0)) FOR [FraudCVTF_IDChck]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__11B8A071]  DEFAULT ((0)) FOR [FraudCVTF_OpnDataSrcs]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__12ACC4AA]  DEFAULT ((0)) FOR [FraudCVTF_OthrSrcs]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__13A0E8E3]  DEFAULT ((0)) FOR [FraudCVTF_FraudCrdntrRfrFile]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__14950D1C]  DEFAULT ((0)) FOR [FraudCVTF_DtldIntllgncRprtRqrd]
GO

ALTER TABLE [dbo].[FraudCVTF] ADD  CONSTRAINT [DF__FraudCVTF__Fraud__15893155]  DEFAULT ((0)) FOR [FraudCVTF_InActive]
GO
