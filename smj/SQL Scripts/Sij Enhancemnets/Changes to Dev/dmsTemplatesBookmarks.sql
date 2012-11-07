
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[dmsTemplatesBookmarks]') AND name = N'dmsTemplatesBookmarks_BookmarkCode')
	DROP INDEX [dmsTemplatesBookmarks_BookmarkCode] ON [dbo].[dmsTemplatesBookmarks] WITH ( ONLINE = OFF )
GO
CREATE NONCLUSTERED INDEX dmsTemplatesBookmarks_BookmarkCode ON [dbo].dmsTemplatesBookmarks
(
	dmsTemplatesBookmarks_BookmarkCode ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[dmsTemplatesBookmarks]') AND name = N'dmsTemplatesBookmarks_TemplateCode')
	DROP INDEX dmsTemplatesBookmarks_TemplateCode ON [dbo].dmsTemplatesBookmarks WITH ( ONLINE = OFF )
GO
CREATE NONCLUSTERED INDEX dmsTemplatesBookmarks_TemplateCode ON [dbo].dmsTemplatesBookmarks
(
	dmsTemplatesBookmarks_TemplateCode ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO

