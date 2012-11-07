USE [FloSuite_Data_Dev]
GO

/****** Object:  StoredProcedure [dbo].[LTMM_KeyDatesType_Save]    Script Date: 08/16/2011 12:36:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[LTMM_KeyDatesType_Save]
(
	@pKeyDatesTypeID			int = 0,
	@pDescription				nvarchar(256) = '',
	@pCode						nvarchar(10) = '',
	@pInactive					bit = 0, 
	@pUsername					nvarchar(255) = ''
)

	-- ==========================================================================================
	-- SMJ - CREATED - 15-08-2011
	-- SP saves a new record to KeyDatesType table
	-- ==========================================================================================
AS
	--DECLARE ERROR TRAP VARIABLES AND INITIALISE THEM
	SET NOCOUNT ON
	SET DATEFORMAT DMY
	
	DECLARE @CreateDate smalldatetime
	DECLARE @errFailedInsert VARCHAR (255)
	DECLARE @errDuplicate VARCHAR (255)
	DECLARE @errSetInactive VARCHAR (255)
	DECLARE @errFailedUpdate VARCHAR (255)
	DECLARE @errFailedExists VARCHAR (255)
	
	--INITIALISE VARIABLES
	
	SET @CreateDate = CAST(GETDATE() AS SMALLDATETIME)
	SET @errFailedInsert = 'Failed to insert or update KeyDate Type. SP:'
	SET @errDuplicate  = 'Cannot insert a duplicate KeyDate type code. SP: '
	SET @errSetInactive = 'Couldn''t set KeyDate Type to inactive. SP:'
	SET @errFailedExists = 'Cannot update or insert KeyDate code as it is already in use or doesn''t exist. SP: '
	
	BEGIN TRANSACTION KEYDATES
	
	BEGIN TRY	
	--IF NO KEYDATE TYPE ID THEN INSERT	
	IF ISNULL(@pKeyDatesTypeID, 0) = 0
	BEGIN
		--CHECK FOR DUPLICATE CODE
		IF EXISTS (SELECT Code FROM KeyDatesType WHERE Code = @pCode) 
		Raiserror (@errDuplicate, 16, 1)
		 
		--INSERT NEW VALUES
		INSERT INTO KeyDatesType ([Description], Code, Inactive, CreateUser, CreateDate)
		VALUES(@pDescription, @pCode, 0, @pUsername, @CreateDate)
		
		IF @@ROWCOUNT =0 
 		RaisError (@errFailedInsert,16,1)
 		
		SET @pKeyDatesTypeID = SCOPE_IDENTITY()
		
	END
	ELSE		
	BEGIN
		--IF WE ARE SETTING AN EXISTING TYPE AS INACTIVE
		IF @pInactive = 1 AND (ISNULL(@pKeyDatesTypeID, 0) <> 0)
		BEGIN
		
			--CHECK TO SEE THAT THE TYPE IS NOT USED BY AN EXISTING LOOKUP CODES
			IF EXISTS (SELECT [CaseKeyDates_KeyDatesCode] FROM [FloSuite_Data_Dev].[dbo].[CaseKeyDates] WHERE [CaseKeyDates_KeyDatesCode] = @pCode)
			BEGIN
				--IF USED BY EXISTING LOOKUP CODES THROW ERROR ACCORDINGLY
				RaisError (@errFailedExists,16,1)
			END
			ELSE	
				--ELSE SET TYPE AS INACTIVE
				UPDATE KeyDatesType SET Inactive = @pInactive, CreateUser = @pUsername, CreateDate = @CreateDate WHERE KeyDatesTypeID = @pKeyDatesTypeID				
				IF @@ROWCOUNT = 0
				RaisError (@errSetInactive,16,1)
			END
		--ELSE WE ARE CHANGING THE DETAILS OF AN EXISTING TYPE WHICH WILL REMAIN ACTIVE
		ELSE
		BEGIN
			IF EXISTS (SELECT [CaseKeyDates_KeyDatesCode] FROM [FloSuite_Data_Dev].[dbo].[CaseKeyDates] WHERE [CaseKeyDates_KeyDatesCode] =(SELECT Code FROM KeyDatesType WHERE KeyDatesTypeID = @pKeyDatesTypeID AND Inactive = 0))
				RaisError (@errFailedExists,16,1)			
			ELSE
				--UPDATE THESE CODES TO LINK THROUGH THE CODE PROVIDED FOR THE UPDATE ON THE TYPE
				UPDATE KeyDatesType SET [Description] = @pDescription, Code = @pCode, Inactive = @pInactive, CreateUser = @pUsername, CreateDate = GETDATE()
				WHERE KeyDatesTypeID = @pKeyDatesTypeID
				IF @@ROWCOUNT = 0
				RaisError (@errFailedExists,16,1)
			END
			
		END
			COMMIT TRANSACTION KEYDATES
			
			SELECT @pKeyDatesTypeID AS KeyDatesTypeID
	END TRY
	
	BEGIN CATCH
		SELECT (ERROR_MESSAGE() + object_name(@@procid)) AS Error
		ROLLBACK TRANSACTION KEYDATES
	END CATCH
	
	
	



GO


