/****** Object:  Table [dbo].[LVMIDetails]    Script Date: 05/23/2012 16:38:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[LVMIDetails](
	[LVMIDetails_LVMIDetailsID] [int] IDENTITY(1,1) NOT NULL,
	[LVMIDetails_CaseID] [int] NOT NULL,
	[LVMIDetails_CliRef] [varchar](50) NULL,
	[LVMIDetails_ClmHndlr] [varchar](50) NULL,
	[LVMIDetails_Office] [varchar](50) NULL,
	[LVMIDetails_CoDefSol] [varchar](255) NULL,
	[LVMIDetails_CDSCntct] [varchar](255) NULL,
	[LVMIDetails_Lit] [varchar](50) NULL,
	[LVMIDetails_CompRec] [varchar](50) NULL,
	[LVMIDetails_Limit] [varchar](50) NULL,
	[LVMIDetails_CLSO] [varchar](50) NULL,
	[LVMIDetails_ActResJud] [varchar](255) NULL,
	[LVMIDetails_PresPos] [varchar](255) NULL,
	[LVMIDetails_JudSetAsd] [varchar](50) NULL,
	[LVMIDetails_SettPoint] [varchar](50) NULL,
	[LVMIDetails_NilDam] [varchar](50) NULL,
	[LVMIDetails_NilTP] [varchar](50) NULL,
	[LVMIDetails_DaysToSett] [int] NULL,
	[LVMIDetails_ResMeth] [varchar](50) NULL,
	[CreateUser] [varchar](255) NULL,
	[CreateDate] [smalldatetime] NULL,
	[Inactive] [int] NULL,
 CONSTRAINT [PK_LVMIDetails_1] PRIMARY KEY CLUSTERED 
(
	[LVMIDetails_LVMIDetailsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


