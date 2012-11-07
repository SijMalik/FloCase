USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[AppDefinitionSchedule_Add]    Script Date: 09/24/2012 12:44:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER Procedure [dbo].[AppDefinitionSchedule_Add]
(
	@pAppTaskDefinitionCode NVARCHAR(50)= '',
	@pScheduleDefinitionName NVARCHAR(255) =''
)
AS


	-- ==========================================================================================
	-- Author:		SMJ
	-- Create date: 15-07-2011
	-- Description:	Stored Procedure to add a new record to the AppDefinitionSchedule table
	-- ==========================================================================================
	
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 05-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================

	
  	SET NOCOUNT ON
  	DECLARE @errNoAppTaskDefCode VARCHAR(50)
  	DECLARE @errNoSchedDefName VARCHAR(50)
  	DECLARE @errRecExist VARCHAR(50)
  	
  	SET @errNoAppTaskDefCode = 'No @pAppTaskDefinitionCode passed in.'
  	SET @errNoSchedDefName = 'No @pScheduleDefinitionName passed in.'
  	SET @errRecExist = 'Record already exists.'
  	
  	
	BEGIN TRY
		--Error-checking
		IF @pAppTaskDefinitionCode = ''  
			RAISERROR (@errNoAppTaskDefCode, 16,1) 
		
		IF @pScheduleDefinitionName = ''  
			RAISERROR (@errNoSchedDefName, 16,1) 
			
		--CHECK IF RECORD ALREADY EXISTS
		IF EXISTS(SELECT 1 FROM dbo.AppDefinitionSchedule WITH (NOLOCK)
					WHERE AppTaskDefinitionCode = @pAppTaskDefinitionCode
					AND ScheduleDefinitionName = @pScheduleDefinitionName)
			RAISERROR (@errRecExist, 16,1) 
		----
		
		--EVERYTHING'S OK SO DO THE INSERT
		INSERT INTO dbo.AppDefinitionSchedule
		SELECT @pAppTaskDefinitionCode, @pScheduleDefinitionName
	END TRY
	
	BEGIN CATCH
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME(@@PROCID)
	END CATCH

