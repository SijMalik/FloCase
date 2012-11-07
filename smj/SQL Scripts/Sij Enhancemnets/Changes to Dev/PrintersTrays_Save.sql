USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[PrintersTrays_Save]    Script Date: 09/24/2012 13:21:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--PrintersTrays_Save '11,12,13,14,15', ',TRAYCREAM,,TRAYHEAD,NULL', 'SMJ'
ALTER PROCEDURE [dbo].[PrintersTrays_Save]
	(
		@pPrinterSettingIDs VARCHAR(255) = '', -- MANDATORY - COMMA DE-LIMITED LIST OF ID's
		@pTrayCodes VARCHAR(255) = '', -- MANDATORY - COMMA DE-LIMITED LIST OF TRAY CODE's
		@UserName VARCHAR(255) = '' -- MANDATORY
	) 
	--==============================================================--
	-- Created By:	SMJ
	-- Create Date:	25/10/2011
	-- Description: Updates tray configuration for a particular 
	--				printer tray or array of trays's
	--==============================================================--
	
	--==============================================================--
	-- Updated By:	SMJ
	-- Create Date:	28/05/2012
	-- Description: Don't save blank traycodes - If blank and record exists, make inactive
	--==============================================================--	
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 24-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================		
	
	AS 
	
	DECLARE @errNoPrintSettingID VARCHAR(50)
	DECLARE @errNoTrayCode VARCHAR(50)	
	DECLARE @errInvalidTrayCode VARCHAR(50)	
	DECLARE @errNoUserName VARCHAR(50)		
	DECLARE @PrinterCode NVARCHAR(25)
	DECLARE @TrayCode NVARCHAR(10)
	DECLARE @PrinterSettingID INT
	DECLARE @MaxCount INT
	DECLARE @iCount INT
	
	
	SET NOCOUNT ON
	
	SET @errNoPrintSettingID = 'Please enter the printer setting IDs.'
	SET @errNoTrayCode = 'Please enter the tray codes.'
	SET @errInvalidTrayCode = 'Invalid Tray Codes entered.'
	SET @errNoUserName = 'Please enter a user name.'	
	
	BEGIN TRY
	
		--Check User Name passed in
		IF @UserName = ''
			RAISERROR (@errNoUserName, 16,1)
					
		--Check printer setting ID passed in
		IF @pPrinterSettingIDs = ''
			RAISERROR (@errNoPrintSettingID, 16,1)
			
		--Check tray code passed in
		IF @pTrayCodes = ''
			RAISERROR (@errNoTrayCode, 16,1)
			
		--Populate PrinterSettingID's		
		DECLARE @PrintSettings TABLE (ID  INT IDENTITY(1,1),PrintSettingID INT, Traycodes VARCHAR(10))
		
		INSERT INTO @PrintSettings (PrintSettingID)
		SELECT * FROM dbo.SplitWithBlanks (@pPrinterSettingIDs,',')  
		
		--Populate TrayCodes
		DECLARE @Trays TABLE (ID  INT IDENTITY(1,1), Traycode VARCHAR(10))
		INSERT INTO @Trays		
		SELECT * FROM dbo.SplitWithBlanks (@pTrayCodes,',') AS Traycode

		--SMJ: 28/05/2012 - DELETE WHERE BLANK TRAY CODE PASSED IN
		DELETE FROM @Trays
		WHERE Traycode IS NULL OR Traycode = 'NULL' OR Traycode = ''
			
		--Update temp PrinterSettings table with corresponding TrayCodes
		UPDATE @PrintSettings
		SET Traycodes = t.Traycode
		FROM @PrintSettings ps
		INNER JOIN @Trays t 
		ON ps.ID = t.ID

		--Get number of records in temp PrinterSettings table, + 1
	    SELECT @MaxCount = COUNT(*) FROM @PrintSettings
	    SELECT @MaxCount = @MaxCount  + 1
	    
	    SET @iCount = 1	
	    
		WHILE @iCount < @MaxCount
		BEGIN

			--Get ID and TrayCode
			SELECT	@PrinterSettingID = PrintSettingID,
					@TrayCode = Traycodes
			FROM	@PrintSettings
			WHERE	ID = @iCount
			

			--Check tray code is valid
			IF @TrayCode NOT IN (	SELECT Code FROM dbo.LookupCode WITH (NOLOCK)
									WHERE LookupTypeCode = 'TrayAssgnt'
									AND Inactive = 0
								  )
				RAISERROR (@errInvalidTrayCode, 16,1)

			--SMJ: 28/05/2012 - CHECK IF TRAYCODE IS BLANK						
			IF @TrayCode IS NOT NULL 
			BEGIN
				--UPDATE EXISTING RECORD
				UPDATE	dbo.PrinterSetting
				SET		TrayCode = @TrayCode,
						InActive = 0 --SMJ - IF PREVIOUSLY INACTIVE AND TRAYCODE NOW PASSED IN, MAKE ACTIVE
				WHERE	PrinterSettingID = @PrinterSettingID
			END
			ELSE				
			BEGIN
				--BLANK TRAY CODE SO SET INACTIVE
				UPDATE	dbo.PrinterSetting
				SET		InActive = 1
				WHERE	PrinterSettingID = @PrinterSettingID
			END
						
			SELECT @iCount = @iCount + 1
		END
	
	END TRY
	
	BEGIN CATCH	
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME(@@PROCID)	
	END CATCH
	




