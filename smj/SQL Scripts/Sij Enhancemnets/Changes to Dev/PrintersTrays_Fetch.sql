USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[PrintersTrays_Fetch]    Script Date: 09/24/2012 13:24:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[PrintersTrays_Fetch]
	(
		@pPrinterCode NVARCHAR(25) = '' -- MANDATORY
	) 
	--==============================================================--
	-- Created By:	SMJ
	-- Create Date:	13/10/2011
	-- Description: Gets tray configuration for printer code passed in
	--==============================================================--

	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 24-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================		
	
	AS 
	
	DECLARE @errNoPrinterCode VARCHAR(50)
	
	SET NOCOUNT ON
	
	SET @errNoPrinterCode = 'Please enter a printer code.'
	
	BEGIN TRY
	
		--Check printer code passed in
		IF @pPrinterCode = ''
			RAISERROR (@errNoPrinterCode, 16,1)

		
		SELECT	PrinterSettingID,
				TrayAssignmentCode AS TrayNumber, 
				TrayCode 
		FROM	dbo.PrinterSetting WITH (NOLOCK)
		WHERE	PrinterCode = @pPrinterCode
		ORDER BY TrayAssignmentCode
	
	END TRY
	
	BEGIN CATCH
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME(@@PROCID)
	END CATCH
	

