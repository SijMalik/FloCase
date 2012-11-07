/****** Object:  Table [dbo].[DetailedAssessment]    Script Date: 11/02/2011 14:33:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DetailedAssessment](
	[DetailedAssessment_DetailedAssessmentID] [int] IDENTITY(1,1) NOT NULL,
	[DetailedAssessment_CaseID] [int] NOT NULL,
	[DetailedAssessment_Code] [int] NOT NULL,
	[DetailedAssessment_CostCourtID] [int] NULL,
	[DetailedAssessment_DAHAttend] [nvarchar](50) NULL,
	[DetailedAssessment_DAHResult] [nvarchar](50) NULL,
	[DetailedAssessment_DAHAppeal] [bit] NULL,
	[DetailedAssessment_DAHAppealBy] [nvarchar](50) NULL,
	[DetailedAssessment_InActive] [bit] NULL,
	[DetailedAssessment_CreateDate] [smalldatetime] NOT NULL,
	[DetailedAssessment_CreateUser] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_DetailedAssessment] PRIMARY KEY CLUSTERED 
(
	[DetailedAssessment_DetailedAssessmentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[DetailedAssessment] ADD  CONSTRAINT [DF_DetailedAssessment_DetailedAssessment_DAHAppeal]  DEFAULT ((0)) FOR [DetailedAssessment_DAHAppeal]
GO

ALTER TABLE [dbo].[DetailedAssessment] ADD  CONSTRAINT [DF_DetailedAssessment_DetailedAssessment_InActive]  DEFAULT ((0)) FOR [DetailedAssessment_InActive]
GO

ALTER TABLE [dbo].[DetailedAssessment] ADD  CONSTRAINT [DF_DetailedAssessment_DetailedAssessment_CreateDate]  DEFAULT (getdate()) FOR [DetailedAssessment_CreateDate]
GO


