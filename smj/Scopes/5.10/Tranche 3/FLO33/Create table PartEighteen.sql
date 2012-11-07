USE [FloSuite_Data_Dev]
GO

/****** Object:  Table [dbo].[PartEighteen]    Script Date: 09/23/2011 09:46:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[PartEighteen](
	[PartEighteen_PartEighteenID] [int] IDENTITY(1,1) NOT NULL,
	[PartEighteen_CaseID] [int] NOT NULL,
	[PartEighteen_RequestPreparedBy] [varchar](10) NOT NULL,
	[PartEighteen_RequestDate] [datetime] NOT NULL,
	[PartEighteen_ResponseRequiredByDate] [datetime] NULL,
	[PartEighteen_ResponseReceivedDate] [datetime] NULL,
	[PartEighteen_Description] [varchar](255) NOT NULL,
	[PartEighteen_Comment] [nvarchar](max) NULL,
	[PartEighteen_Amended] [bit] NULL,
	[PartEighteen_Inactive] [bit] NULL,
	[PartEighteen_CreatedBy] [varchar](255) NOT NULL,
	[PartEighteen_CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PartEighteen] PRIMARY KEY CLUSTERED 
(
	[PartEighteen_PartEighteenID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[PartEighteen] ADD  CONSTRAINT [DF__PartEight__PartE__387D67D7]  DEFAULT ('') FOR [PartEighteen_RequestPreparedBy]
GO

ALTER TABLE [dbo].[PartEighteen] ADD  CONSTRAINT [DF__PartEight__PartE__39718C10]  DEFAULT (getdate()) FOR [PartEighteen_RequestDate]
GO

ALTER TABLE [dbo].[PartEighteen] ADD  CONSTRAINT [DF__PartEight__PartE__3A65B049]  DEFAULT ('Part 18 Request For Further Information') FOR [PartEighteen_Description]
GO

ALTER TABLE [dbo].[PartEighteen] ADD  CONSTRAINT [DF__PartEight__PartE__3B59D482]  DEFAULT ((0)) FOR [PartEighteen_Amended]
GO

ALTER TABLE [dbo].[PartEighteen] ADD  CONSTRAINT [DF__PartEight__PartE__3C4DF8BB]  DEFAULT (getdate()) FOR [PartEighteen_CreatedDate]
GO


