--SMJ - Populated by LTMM_Populate_LV_MI_Tables

--OWN FEES
/****** Object:  Table [dbo].[LVFeesBilled]    Script Date: 05/31/2012 10:55:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[LVFeesBilled](
	[LVFeesBilled_ID] [int] IDENTITY(1,1) NOT NULL,
	[LVFeesBilled_CaseID] [int] NOT NULL,
	[LVFeesBilled_AEMatterUno] [int] NOT NULL,
	[LVFeesBilled_OwnFees] [money] NULL,
	[LVFeesBilled_DisbCouns] [money] NULL,
	[LVFeesBilled_DisbOther] [money] NULL,
	[LVFeesBilled_CostsTotal] [money] NULL,
	[LVFeesBilled_LastScheduledUpdateDate] [smalldatetime] NOT NULL,
	[LVFeesBilled_AdHocUserUpdateBy] [varchar](255) NULL,
	[LVFeesBilled_AdHocUserUpdateDate] [smalldatetime] NULL,
	[LVFeesBilled_Inactive] [bit] NOT NULL,
 CONSTRAINT [PK_LVFeesBilled] PRIMARY KEY CLUSTERED 
(
	[LVFeesBilled_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[LVFeesBilled] ADD  DEFAULT ((0)) FOR [LVFeesBilled_Inactive]
GO

--DATE OF LAST ACTION (FINAL BILL PAID DATE)
/****** Object:  Table [dbo].[LVFinalBillDP]    Script Date: 05/31/2012 10:59:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[LVFinalBillDP](
	[LVFinalBillDP_ID] [int] IDENTITY(1,1) NOT NULL,
	[LVFinalBillDP_CaseID] [int] NOT NULL,
	[LVFinalBillDP_AEMatterUno] [int] NOT NULL,
	[LVFinalBillDP_FinalBillDatePaid] [smalldatetime] NULL,
	[LVFinalBillDP_LastScheduledUpdateDate] [smalldatetime] NOT NULL,
	[LVFinalBillDP_AdHocUserUpdateBy] [varchar](255) NULL,
	[LVFinalBillDP_AdHocUserUpdateDate] [smalldatetime] NULL,
	[LVFinalBillDP_Inactive] [bit] NOT NULL,
 CONSTRAINT [PK_LVFinalBillDP] PRIMARY KEY CLUSTERED 
(
	[LVFinalBillDP_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[LVFinalBillDP] ADD  DEFAULT ((0)) FOR [LVFinalBillDP_Inactive]
GO

--LV OFFICE
/****** Object:  Table [dbo].[LVOffice]    Script Date: 05/31/2012 11:00:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[LVOffice](
	[LVOffice_ID] [int] IDENTITY(1,1) NOT NULL,
	[LVOffice_CaseID] [int] NOT NULL,
	[LVOffice_AEMatter_Uno] [int] NOT NULL,
	[LVOffice_Office] [varchar](255) NOT NULL,
	[LVOffice_LastScheduledUpdateDate] [smalldatetime] NOT NULL,
	[LVOffice_AdHocUserUpdateBy] [varchar](255) NULL,
	[LVOffice_AdHocUserUpdateDate] [smalldatetime] NULL,
	[LVOffice_Inactive] [bit] NOT NULL,
 CONSTRAINT [PK_LVOffice] PRIMARY KEY CLUSTERED 
(
	[LVOffice_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[LVOffice] ADD  DEFAULT ((0)) FOR [LVOffice_Inactive]
GO