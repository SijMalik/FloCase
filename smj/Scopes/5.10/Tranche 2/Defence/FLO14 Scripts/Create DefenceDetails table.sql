--SMJ - 15-08-2011 Create main table for holding defence details

USE [FloSuite_Data_Dev]
GO

/****** Object:  Table [dbo].[DefenceDetails]    Script Date: 08/15/2011 14:09:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DefenceDetails]
(
	[DefenceDetails_DefenceDetailsID] [int] IDENTITY(1,1) NOT NULL,
	[DefenceDetails_CaseID] [int] NOT NULL,
	[DefenceDetails_Code] [varchar](25) NOT NULL,
	[DefenceDetails_POCRec] [bit] NULL,
	[DefenceDetails_DefStatus] [varchar](255) NULL,
	[DefenceDetails_Part18] [bit] NULL,
	[DefenceDetails_PrpsdExtnDate] [smalldatetime] NULL,
	[DefenceDetails_DefDueDate] [smalldatetime] NULL,
	[DefenceDetails_DateJdgEntrd] [smalldatetime] NULL,
	[DefenceDetails_DDService] [smalldatetime] NULL,
	[DefenceDetails_InActive] [bit] NULL,
	[DefenceDetails_CreateUser] [varchar](255) NULL,
	[DefenceDetails_CreateDate] [smalldatetime] NULL,
 CONSTRAINT [PK_DefenceDetailsID] PRIMARY KEY CLUSTERED 
(
	[DefenceDetails_DefenceDetailsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[DefenceDetails] ADD  DEFAULT ((0)) FOR [DefenceDetails_Code]
GO

ALTER TABLE [dbo].[DefenceDetails] ADD  DEFAULT ((0)) FOR [DefenceDetails_POCRec]
GO

ALTER TABLE [dbo].[DefenceDetails] ADD  DEFAULT ((0)) FOR [DefenceDetails_Part18]
GO

ALTER TABLE [dbo].[DefenceDetails] ADD  DEFAULT ((0)) FOR [DefenceDetails_InActive]
GO

ALTER TABLE [dbo].[DefenceDetails] ADD  DEFAULT (getdate()) FOR [DefenceDetails_CreateDate]
GO


