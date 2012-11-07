/****** Object:  StoredProcedure [dbo].[LTMM_Costs_Fetch]    Script Date: 11/11/2011 15:12:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[LTMM_Costs_Fetch]
		(
			@CaseID INT = 0 -- MANDATORY
		)
		
	--==============================================================--
	-- Created By:	SMJ
	-- Create Date:	30/10/2011
	-- Description: Fetches Costs KeyDates and UserRoleTypes
	--==============================================================--		
	
AS
	
	SET NOCOUNT ON	
	
	DECLARE @errNoCaseID VARCHAR(50)
	DECLARE @AppInsVal VARCHAR(20)
	
	SET @errNoCaseID = 'Please enter a Case ID.'
	
	BEGIN TRY
		--Do some error-checking
		IF @CaseID = 0
			RAISERROR (@errNoCaseID, 16, 1)	
			
		--Get the App Instance Value
		SELECT	@AppInsVal = IdentifierValue 
		FROM	ApplicationInstance
		WHERE	CaseID = @CaseID
		
		--Insert initial details into a temp table - Will contain multiple rows/duplicates 
		SELECT	DISTINCT 
				ck.CaseKeyDates_Date AS DateAssToCosts,
				ck2.CaseKeyDates_Date AS DateAutToAss,
				c.Case_CostsOnly,
				au.UserName,
				au.AppUserRoleCode,
				c.Case_ExternalDraftsPerson As ExtDraftsPerson				
		INTO	#Costs				
		FROM	CaseKeyDates ck
		INNER JOIN [Case] c	WITH (NOLOCK) ON ck.CaseKeyDates_CaseID = c.Case_CaseID 
		INNER JOIN CaseKeyDates ck2 WITH (NOLOCK) ON ck2.CaseKeyDates_CaseID = c.Case_CaseID	
		INNER JOIN AppUser au WITH (NOLOCK) ON au.AppInstanceValue = @AppInsVal
		WHERE c.Case_CaseID = @CaseID		
		AND ck.CaseKeyDates_KeyDatesCode = 'CostAssDte'
		AND ck.CaseKeyDates_Inactive = 0
		AND ck2.CaseKeyDates_KeyDatesCode = 'CostAutAss'
		AND ck2.CaseKeyDates_Inactive = 0
		AND au.AppUserRoleCode IN ('CFE', 'CTL','CTA')		
		AND au.InActive = 0
		AND c.Case_CostsAssgn = 1
		
		--Declare temp table to hold data in one line
		DECLARE @Costs TABLE 
				(
					DateAssCosts	SMALLDATETIME NULL,
					CostsFE			VARCHAR(10) NULL,
					CostsTL			VARCHAR(10) NULL, 
					CostsTA			VARCHAR(10) NULL,
					CostsOnly		BIT NULL,
					DateAuthAss		SMALLDATETIME NULL,
					ExtDraftsPerson BIT NULL
				)
				
		--Create new line in @Costs by populating first column from #Costs			
		INSERT INTO @Costs (DateAssCosts)		
		SELECT DISTINCT DateAssToCosts FROM #Costs
		
		--Update subsequent columns from #Costs
		----------------------------
		UPDATE @Costs 
		SET CostsFE= UserName FROM #Costs WHERE AppUserRoleCode = 'CFE'

		UPDATE @Costs 
		SET CostsTL = UserName FROM #Costs WHERE AppUserRoleCode = 'CTL'		
		
		UPDATE @Costs 
		SET CostsTA = UserName FROM #Costs WHERE AppUserRoleCode = 'CTA'				

		UPDATE @Costs 
		SET CostsOnly = Case_CostsOnly FROM #Costs
		
		UPDATE @Costs 
		SET DateAuthAss = DateAutToAss FROM #Costs
		
		UPDATE @Costs 
		SET ExtDraftsPerson = ExtDraftsPerson FROM #Costs
		----------------------------

		SELECT * FROM @Costs
			
	END TRY
	
	BEGIN CATCH
			SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH			
	

GO


