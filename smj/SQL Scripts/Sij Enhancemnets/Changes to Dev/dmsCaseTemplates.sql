

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dmsCaseTemplates]') AND type in (N'U'))
	DROP TABLE [dbo].dmsCaseTemplates
GO


CREATE TABLE dmsCaseTemplates
	(
		dmsTemplates_dmsTemplatesID [int] IDENTITY(1,1) NOT NULL,
		dmsTemplates_TemplateCode			nvarchar(255),
		dmsTemplates_TemplateName			nvarchar(255),
		dmsTemplates_TemplateDesc			nvarchar(255),
		dmsTemplates_TemplateGroup			nvarchar(255),
		Template_Group						nvarchar(255),
		dmsTemplates_TemplatePath			nvarchar(255),
		[Documment_Code]					nvarchar(255),
		dmsTemplates_AvailAdhoc				BIT,
		CaseID								int,
		dmsTemplates_Createuser				nvarchar(255),
		dmsTemplates_CreateDate				smalldatetime,
		dmsTemplates_ReqSup					BIT,
	 CONSTRAINT [PK_dmsCaseTemplates] PRIMARY KEY CLUSTERED 
	(
		dmsTemplates_dmsTemplatesID ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE NONCLUSTERED INDEX [dmsCaseTemplates_CaseID] ON [dbo].dmsCaseTemplates 
(
	[CaseID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO


CREATE NONCLUSTERED INDEX dmsTemplates_TemplateCode ON [dbo].dmsCaseTemplates 
(
	dmsTemplates_TemplateCode ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO


CREATE NONCLUSTERED INDEX dmsTemplates_TemplateName ON [dbo].dmsCaseTemplates 
(
	dmsTemplates_TemplateName ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO


CREATE NONCLUSTERED INDEX dmsTemplates_TemplateDesc ON [dbo].dmsCaseTemplates 
(
	dmsTemplates_TemplateDesc ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX dmsTemplates_TemplateGroup ON [dbo].dmsCaseTemplates 
(
	dmsTemplates_TemplateGroup ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO