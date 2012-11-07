
ALTER PROC [dbo].[LTMM_ClearMatter]
(
	@BLMRef					nvarchar(255) = '',
	@UserName				nvarchar(255)  = ''			
)
AS
	--Stored Procedure to Clear thE contents of a Matter	
	--YOU MUST ENSURE THAT NO OTHER CASE HAS THE SAME BLM-REF OR BOTH WILL BE CLEARED OF ALL DATA
	--Author(s) GQL
	--30-10-2009
	
	SET NOCOUNT ON
	DECLARE @myLastError int 
	SELECT @myLastError = 0
	DECLARE @myLastErrorString nvarchar(255)
	SELECT @myLastErrorString = ''
	
	set @BLMRef = REPLACE(@blmref,' ','')
	
	----Test to see that a username has been supplied
	IF (ISNULL(@UserName,'') = '')
	BEGIN
		SET @myLastErrorString = 'YOU MUST PROVIDE A @UserName'
		GOTO THROW_ERROR_UPWARDS	
	END
	
	----Test to see that a BLM-REF has been supplied
	IF (ISNULL(@BLMRef,'') = '')
	BEGIN
		SET @myLastErrorString = 'YOU MUST PROVIDE A @BLMRef'
		GOTO THROW_ERROR_UPWARDS	
	END
	
	BEGIN TRANSACTION ClearMatter
	
	IF EXISTS (SELECT CaseID FROM ApplicationInstance WHERE IdentifierValue = @BLMRef)
	BEGIN		
		DECLARE @CASEID INT = (SELECT CaseID FROM ApplicationInstance WHERE IdentifierValue = @BLMRef)
		DECLARE @dte as smalldatetime = getdate()
		DECLARE @FeCode AS NVARCHAR(255) = (SELECT USERNAME FROM AppUser WHERE AppInstanceValue = @BLMRef AND AppUserRoleCode = 'FES' AND InActive = 0)
		
		-- GV 22/3/2012: Clear AppUser
		DELETE FROM AppUser 
		WHERE AppInstanceValue = @BLMRef
		AND AppUserRoleCode IN('CFE','CTL','CTA')
	
		-- GV 4/5/2012: clear Part 8
		DELETE FROM PartEight
		WHERE PartEight_CaseID = @CASEID
		
		--REMOVE FINACIAL AND MI FROM THE MATTER
		DELETE FROM ManagementInformation WHERE ManagementInformation_CaseID = @CASEID
		DELETE FROM FinancialReserve WHERE FinancialReserve_CaseID = @CASEID
		DELETE FROM FinancialReserveHistory WHERE FinancialReserveHistory_CASEID = @CASEID
		DELETE FROM Financial WHERE Financial_CASEID = @CASEID
		
		--REMOVE KEY DATES FROM TEH MATTER
		DELETE FROM CaseKeyDates WHERE CaseKeyDates_CASEID = @CASEID
		
		--REMOVE TASKS AND DOCUMENTS FROM THE MATTER
		DELETE FROM AppTaskSchedule WHERE AppTaskID IN (SELECT AppTaskID FROM AppTask WHERE AppInstanceValue = @BLMRef)
		DELETE FROM AppTaskDocumentVersion WHERE AppTaskDocumentID IN (SELECT DocumentID FROM AppTask WHERE AppInstanceValue = @BLMRef)
		DELETE FROM AppTaskDocument WHERE AppTaskDocumentID IN (SELECT DocumentID FROM AppTask WHERE AppInstanceValue = @BLMRef)
		DELETE FROM AppTask WHERE AppInstanceValue = @BLMRef 
		
		update [case]		
		set --Case_MITypeCode 		= @Case_MITypeCode,
			--Case_OtlkTmCalCode		= '',
			Case_PriCaseType		= '',
			Case_SecCaseTypeInj		= '',
			Case_SecCaseTypeNInj	= '',
			Case_TerCaseType		= '',
			Case_CreditHire			= '',
			Case_PAD				= '',
			Case_MatterValue		= '',
			Case_CourtTrack			= '',
			Case_MatterType			= '',
			Case_Prt8App			= '',
			Case_LOCAck				= '',
			Case_ClientRuleCode		= '',
			Case_Disease			= ''	,
			Case_Date_Updated		= '', -- SMJ 06/08
			Case_LOCAckCode			= '',
			Case_CostsAssgn			= 0	  -- GV 10/10/12		
		where Case_CaseID = @CASEID
		
		--REMOVE CONTACTS FROM THE MATTER WITH THE EXCEPTION OF TEH CLIENT
		--DELETE FROM CaseContacts WHERE CaseContacts_CaseID = @CASEID AND ISNULL(CaseContacts_ClientID, 0) = 0
		
		--Add case mainatainance task to matter for FE
		EXECUTE AppTask_CreatePending
		   @AppTaskID = 0
		  ,@UserName = 'Admin'
		  ,@AppTaskDefinitionCode = 'CaseDetails'
		  ,@AppInstanceValue = @BLMRef
		  ,@CaseID = @CASEID 
		  ,@CreatedBy = 'Admin'
		  ,@Description = 'Case Maintenance'
		  ,@Location = ''
		  ,@AssignedTo = @FeCode
		  ,@DueDate = @dte
		  ,@ReminderDate = @dte
		  ,@CaseContactID = 0
		  ,@DocumentID = 0
		  ,@CustomID1 = 0
		  ,@CustomID2 = 0
		  ,@CustomID3 = 0
		  ,@CustomID4 = 0
		  ,@CustomID5 = 0
		  ,@pAppTaskSubTypeCode = 'Task'
		  ,@pComment = ''
		  ,@pPriorityCode = 'Normal'
		  ,@KeyDateID = ''
		  ,@StartScheduleDate = @dte
		  ,@EndScheduleDate = @dte
		  ,@Outlook_GUID = ''
		  ,@pRoleCode = 'FES,FEJ'
		
	END
	ELSE
	BEGIN
		SET @myLastErrorString = 'Invalid BLM-REF provided - The BLM-REF did not match any Matters contained within FloCase'
		GOTO THROW_ERROR_UPWARDS
	END
	
	--TEST FOR ERRORS
	SELECT @myLastError = @@ERROR
	IF @myLastError <> 0 GOTO THROW_ERROR_UPWARDS
	
	COMMIT TRANSACTION ClearMatter
	
	THROW_ERROR_UPWARDS:
	IF (@myLastError <> 0 ) OR (@myLastErrorString <> '')
	BEGIN
		ROLLBACK TRANSACTION ClearMatter
		SET @myLastErrorString = 'Error Occurred In Stored Procedure LTMM_ClearMatter - ' + @myLastErrorString
		RAISERROR (@myLastErrorString, 16,1)
	END