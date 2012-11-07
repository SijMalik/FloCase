

/****** Object:  Index [AssignedTo_StatusCode_AppInstanceValue_DueDate]    Script Date: 09/25/2012 11:42:52 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AppTask]') AND name = N'StatusCode_AssignedTo_AppInstanceValue_DueDate')
	DROP INDEX StatusCode_AssignedTo_AppInstanceValue_DueDate ON [dbo].[AppTask] WITH ( ONLINE = OFF )
GO



/****** Object:  Index [AssignedTo_StatusCode_AppInstanceValue_DueDate]    Script Date: 09/25/2012 11:42:52 ******/
CREATE NONCLUSTERED INDEX StatusCode_AssignedTo_AppInstanceValue_DueDate ON [dbo].[AppTask] 
(
	[StatusCode] ASC,
	[AssignedTo] ASC,
	[AppInstanceValue] ASC,
	[DueDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO


