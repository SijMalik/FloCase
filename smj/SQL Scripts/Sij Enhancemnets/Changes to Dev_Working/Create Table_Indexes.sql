/****** Object:  Table [dbo].[Table_Indexes]    Script Date: 09/25/2012 12:11:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Table_Indexes](
	[TableIndexes_ID] [int] IDENTITY(1,1) NOT NULL,
	[TableName] [nvarchar](255) NOT NULL,
	[IndexName] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Table_Indexes] PRIMARY KEY CLUSTERED 
(
	[TableIndexes_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
