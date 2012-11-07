USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[Temp_Rebuild_Indexes]    Script Date: 09/24/2012 16:40:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Temp_Rebuild_Indexes]
AS
-----------------------------------------------------------
-- Author: SMJ
-- Create Date: 09/08/2012
-- Description - Rebuild all indexes to reduce fragmentation.
------------------------------------------------------------
DECLARE @MaxCount INT
DECLARE @iCount INT
DECLARE @TableName VARCHAR(100)
DECLARE @IndexName VARCHAR(100)
DECLARE @DynSQL NVARCHAR(MAX)


		--Get number of records in temp PrinterSettings table, + 1
	    SELECT @MaxCount = COUNT(*) FROM Table_Indexes
	    SELECT @MaxCount = @MaxCount  + 1
	    
	    SET @iCount = 1	
	    
		WHILE @iCount < @MaxCount
		BEGIN

			--Get ID and TrayCode
			SELECT	@TableName = TableName,
					@IndexName = IndexName
			FROM	Table_Indexes
			WHERE	TableIndexes_ID = @iCount
			
			IF @IndexName NOT LIKE 'PK%' AND  @TableName <> 'Case' --Won't do Case as it's a keyword
			BEGIN
				SELECT @DynSQL = 'ALTER INDEX ' +  @IndexName + ' ON ' + @TableName + 
				' REBUILD WITH (ONLINE = ON); '
				
				EXECUTE sp_executesql @DynSQL
			END
						
			SELECT @iCount = @iCount + 1
		END
		
		--DO THE CASE TABLE
		
		ALTER INDEX Case_BranchCode ON [case] REBUILD WITH (ONLINE = ON);
		ALTER INDEX Case_ClientCode ON [case] REBUILD WITH (ONLINE = ON);
		ALTER INDEX Case_ClientUno ON [case] REBUILD WITH (ONLINE = ON);
		ALTER INDEX Case_DeptCode ON [case] REBUILD WITH (ONLINE = ON);
		ALTER INDEX Case_MatterCode ON [case] REBUILD WITH (ONLINE = ON);								
		ALTER INDEX Case_MatterUno ON [case] REBUILD WITH (ONLINE = ON);
		ALTER INDEX Case_StageCode ON [case] REBUILD WITH (ONLINE = ON);
		ALTER INDEX Case_StateCode ON [case] REBUILD WITH (ONLINE = ON);
		ALTER INDEX Case_WorkTypeCode ON [case] REBUILD WITH (ONLINE = ON);								
		ALTER INDEX Case_WorkValueCode ON [case] REBUILD WITH (ONLINE = ON);	
		










