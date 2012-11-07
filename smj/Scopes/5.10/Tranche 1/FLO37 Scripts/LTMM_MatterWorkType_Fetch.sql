USE [FloSuite_Data_Dev]
GO

/****** Object:  StoredProcedure [dbo].[LTMM_MatterWorkType_Fetch]    Script Date: 08/15/2011 12:39:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[LTMM_MatterWorkType_Fetch]
(
	@pMatter_CaseID								int   = 0
)

	-- ==========================================================================================
	-- Author:		SMJ
	-- Create date: 15-08-2011
	-- This stored proc is used to return the Work Type of the Matter being accessed by the user.
	-- ==========================================================================================

AS

	SET NOCOUNT ON
	
	DECLARE @errCaseID VARCHAR(255)
	DECLARE @errDescription VARCHAR (255)

	SELECT @errCaseID = 'CaseID ' + CONVERT(VARCHAR(5),@pMatter_CaseID) + ' doesn''t exist in Case table in '
	SELECT @errDescription = 'Couldn''t find Description for WorkType in '
	
	BEGIN TRY
	
		--Raise error if case ID is invalid
		IF @pMatter_CaseID < 1 
		RAISERROR (@errCaseID,16,1)
		
		SELECT lc.[Description] 
		FROM dbo.[Case] c
		INNER JOIN  dbo.LookupCode lc ON c.Case_WorkTypeCode = lc.Code
		WHERE c.Case_CaseID = @pMatter_CaseID
		AND lc.LookupTypeCode = 'WORKTYPE'
		
		--Raise error if no description found in LookupCode table
		IF @@ROWCOUNT = 0 
		RAISERROR (@errDescription,16,1)
		
	END TRY

	BEGIN CATCH
		SELECT (ERROR_MESSAGE() + object_name(@@procid)) AS Error
	END CATCH




GO


