/****** Object:  StoredProcedure [dbo].[LTMM_Costs_Save]    Script Date: 11/11/2011 15:13:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[LTMM_Costs_Save]
		(
			@CaseID			INT = 0, -- MANDATORY
			@DteAssCosts	SMALLDATETIME = '', -- MANDATORY
			@CostsDraft		VARCHAR(50) = '', --FES, MANDATORY
			@CostsSVisor	VARCHAR(50) = '', --TL, MANDATORY
			@CostsTA		VARCHAR(50) = '', --TA, MANDATORY
			@CostsOnly		BIT = 0,
			@DteAuthAss		SMALLDATETIME = '',
			@UserName		VARCHAR(50) = '', -- MANDATORY
			@ExtDraftPerson BIT = 0			
		)
		
	--==============================================================--
	-- Created By:	SMJ
	-- Create Date:	30/10/2011
	-- Description: Saves Costs KeyDates and UserRoleTypes
	--==============================================================--
			

AS
	DECLARE @errNoCaseID VARCHAR(50)
	DECLARE @errNoDteAssCosts VARCHAR(50)
	DECLARE @errNoDraft VARCHAR(50)
	DECLARE @errNoSVisor VARCHAR(50)
	DECLARE @errNoTA VARCHAR(50)
	DECLARE @errNoUserName VARCHAR(50)
	
	SELECT @errNoCaseID = 'No Case ID entered.'
	SELECT @errNoDteAssCosts = 'Please enter Date Assigned To Costs.'
	SELECT @errNoDraft = 'Please select a Costs Draftsperson.'
	SELECT @errNoSVisor = 'Please select a Costs Supervisor.'
	SELECT @errNoTA = 'Please select a Costs Team Admin.'
	SELECT @errNoUserName = 'No User Name entered.'
	
	BEGIN TRY
		--Do some error checking 
		-------------------------
		IF @CaseID = 0
			RAISERROR(@errNoCaseID, 16, 1)
					
		IF @DteAssCosts = ''
			RAISERROR(@errNoDteAssCosts, 16, 1)
			
		IF @CostsDraft = ''
			RAISERROR(@errNoDraft, 16, 1)
			
		IF @CostsSVisor = ''
			RAISERROR(@errNoSVisor, 16, 1)
			
		IF @CostsTA = ''
			RAISERROR(@errNoTA, 16, 1)

		IF @UserName = ''
			RAISERROR(@errNoUserName, 16, 1)			
		-------------------------
		
		--Save Date Assigned KeyDate
		EXEC LTMM_CaseKeyDates_Save
			@CaseKeyDates_CaseID = @CaseID,
			@CaseKeyDates_KeyDatesCode = 'CostAssDte',
			@CaseKeyDates_Date = @DteAssCosts,
			@pUsername = @UserName,
			@pReturnID	= 0
			
		--Save Date of Authority to Assess KeyDate if required
		IF @DteAuthAss <> ''
			EXEC LTMM_CaseKeyDates_Save
				@CaseKeyDates_CaseID = @CaseID,
				@CaseKeyDates_KeyDatesCode = 'CostAutAss',
				@CaseKeyDates_Date =@DteAuthAss,
				@pUsername = @UserName,
				@pReturnID	= 0			
		
		--Save Costs Draftsperson
		EXEC AppUser_Save
			@UserName = @UserName,
			@CaseID	= @CaseID,
			@AppUserName = @CostsDraft,
			@AppUserRoleCode = 'CFE',
			@InActive = 0

		--Save Costs Supervisor
		EXEC AppUser_Save
			@UserName = @UserName,
			@CaseID	= @CaseID,
			@AppUserName = @CostsSVisor,
			@AppUserRoleCode = 'CTL',
			@InActive = 0
		
		--Save Costs Team Admin
		EXEC AppUser_Save
			@UserName = @UserName,
			@CaseID	= @CaseID,
			@AppUserName = @CostsTA,
			@AppUserRoleCode = 'CTA',
			@InActive = 0	
			
		--Update Case table - Case_CostsAssgn: Always set to 1
		UPDATE [Case]
		SET Case_CostsAssgn = 1
		WHERE Case_CaseID = @CaseID
		
		--Update Case table - Case_CostsOnly: Set to value of @CostsOnly
		UPDATE [Case]
		SET Case_CostsOnly = @CostsOnly
		WHERE Case_CaseID = @CaseID	
		
		UPDATE [Case]
		SET Case_ExternalDraftsPerson = @ExtDraftPerson
		WHERE Case_CaseID = @CaseID			
		
												
	END TRY
	
	BEGIN CATCH
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME(@@PROCID)
	END CATCH

GO


