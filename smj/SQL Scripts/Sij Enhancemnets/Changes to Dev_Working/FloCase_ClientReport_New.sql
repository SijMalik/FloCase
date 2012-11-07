
ALTER PROC [dbo].[FloCase_ClientReport_New]
(
	@pUsername		nvarchar(255) = ''
)
AS
	
	--Stored Procedure to 
	--SCHEDULE A REPORT TO CLIENT REMINDER FOR THE FEE FOR ANY CASES THAT ARE DUE A CLIENT REPORT TODAY
	--
	--Author(s) GQL
	--21-1-2010
	--Amended GQL 14.11.2011
	--Restrict report scheduling to Healtcare only
	
	-----------------------------------------------------------------
	-- Modified by GV on 4/10/2011
	-- Call Zurich client SP for reports
	-----------------------------------------------------------------
	-----------------------------------------------------------------
	-- Modified by GV on 24/02/2012
	-- Removed call to Zurich client SP for reports
	-----------------------------------------------------------------
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 02-10-2012
	-- Description:	Set DueDate to today's date if it's NULL as Escalation Date won't get set in AppTask_CreatPending
	-- ===============================================================
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		3
	-- Modify date: 02-10-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================		
	
	-- EXEC FloCase_ClientReport_Zurich @pUsername -- GV 24/02/2012: removed
	
	--Initialise error trapping
	SET NOCOUNT ON
	DECLARE			@DUEDATE AS SMALLDATETIME,
					@REMDATE AS SMALLDATETIME, -- SSCF: Added to set the reminder date to 7 days
					@MaxID as INT,
					@MinID as INT,
					@EscDate as SMALLDATETIME,
					@pCaseID as INT, 
					@pDescription as nvarchar(255),
					@pEscDescription as nvarchar(255),
					@pTLUser as nvarchar(255), 
					@pFEUser as nvarchar(255), 
					@pAppInstanceValue as nvarchar(50)	
	DECLARE @errNoCaseID VARCHAR(50)
	DECLARE @errNoUserName VARCHAR(50)
	DECLARE @errNoAppTaskDef VARCHAR(50)
	DECLARE @errNoCompletedBy VARCHAR(50)
	DECLARE @errNoCompletedDate VARCHAR(50)
	DECLARE @AppInsVal VARCHAR(50)
	
	SET @errNoCaseID = 'Please enter a Case ID.'
	SET @errNoUserName = 'Please enter a User Name.'
	SET @errNoAppTaskDef = 'Please enter AppTaskDefinition Code.'
	SET @errNoCompletedBy = 'Please enter Completed By.'
	SET @errNoCompletedDate = 'Please enter the Completed Date.'
	

	BEGIN TRY	
		--Initialise variables	
		SET @MinID = 1	
			
		BEGIN TRANSACTION ClientReport
		
		--DECLARE TABLE TO HOLD MATTERS REQUIRING Client Report REMINDERS
		DECLARE @MatterReview TABLE
		(
			ResultID						INT IDENTITY,
			AppInstanceValue				nvarchar(255),
			CaseID							int,
			CaseReviewDate					smalldatetime
		)
		
		--Populate Temp table with ALL MATTERS THE CURRENTLY DON'T HAVE A CLIENT REPORT TASK
		--GQL 20.10.2010 ALTERED CRITERIA TO AppTaskTypeCode = 'CLNTREP' 
		-- AS PREVIOUSLY INCORRECTLY  ADDED AGAINST THE APPTASKDEFINITIONCODE
		INSERT INTO @MatterReview(AppInstanceValue, CaseID, CaseReviewDate)
		SELECT ai.IdentifierValue, c.Case_CaseID, c.Case_CaseReviewDate  
		FROM dbo.ApplicationInstance ai WITH (NOLOCK) inner join
		dbo.[Case] c WITH (NOLOCK) on ai.CaseID = c.Case_CaseID 
		WHERE ai.IdentifierValue NOT IN (SELECT AppInstanceValue FROM AppTask WHERE  AppTaskTypeCode = 'CLNTREP' and StatusCode = 'ACTIVE') 
		AND c.Case_StateCode = 'Active'
		AND c.Case_WorkTypeCode in ('HENCL', 'HECLM') --Restrict to healtcare only cases
		
		--Get the max id of the temp table of MATTERS REQUIRING ISO REMINDERS
		SELECT @MaxID = MAX(ResultID) FROM @MatterReview 
		
		--loop from 1 to max id of the temp table of MATTERS REQUIRING ISO REMINDERS
		WHILE @MinID <= @MaxID 
		BEGIN		
			--get details of MATTERS REQUIRING A CLIENT REPORT TASK inorder to create REMINDER task WITH ESCALATION
			SELECT 
			@pAppInstanceValue = AppInstanceValue,
			@pCaseID = CaseID 
			FROM @MatterReview
			WHERE ResultID = @MinID
			
			IF EXISTS (SELECT cl.CLIENT_CODE FROM 
			dbo.CaseContacts cc WITH (NOLOCK) INNER JOIN
			dbo.HBM_CLIENT cl  WITH (NOLOCK) ON cc.CaseContacts_ClientID = cl.CLIENT_UNO AND ISNULL(cc.CaseContacts_ClientID, 0) > 0 AND cc.CaseContacts_Inactive = 0
			WHERE cl.CLIENT_CODE = '107501' AND cc.CaseContacts_CaseID = @pCaseID)
			BEGIN
				--if the task has not been scheduled before
				IF ISNULL((select MAX(AppTaskID) from dbo.AppTask WITH (NOLOCK) where AppTaskDefinitionCode = 'CLNTREP' AND AppInstanceValue = @pAppInstanceValue),0) < 1
				BEGIN
					--set due date as 15 days from the date the file was opened
					SELECT @DUEDATE = CaseKeyDates_Date FROM dbo.CaseKeyDates WITH (NOLOCK) WHERE CaseKeyDates_KeyDatesCode = 'OpenDate' AND CaseKeyDates_CaseID = @pCaseID
					
					IF @DueDate IS NULL
						SET @DueDate = GETDATE()
						
					SET @DUEDATE = DATEADD(DAY,7,@DUEDATE)
					--set escalation date as 5 days from the due date
					SET @EscDate = DATEADD(DAY,5,@DUEDATE)
					SET @REMDATE = DATEADD(DAY,7,@DUEDATE)
					
				END
				ELSE
				BEGIN
					--set due date as 70 days from the date the last client report was ran
					SELECT @DUEDATE = MAX(CompletedDate) FROM dbo.AppTask WITH (NOLOCK) where AppTaskDefinitionCode = 'CLNTREP' AND AppInstanceValue = @pAppInstanceValue
					
					IF @DueDate IS NULL
						SET @DueDate = GETDATE()
						
					SET @DUEDATE = DATEADD(DAY,70,@DUEDATE)
					--set escalation date as 7 days from the due date
					SET @EscDate = DATEADD(DAY,7,@DUEDATE)
					SET @REMDATE = DATEADD(DAY,7,@DUEDATE)
				END 
			END
			ELSE
			BEGIN
				--if the task has not been scheduled before
				IF ISNULL((select MAX(AppTaskID) from dbo.AppTask WITH (NOLOCK) where AppTaskDefinitionCode = 'CLNTREP' AND AppInstanceValue = @pAppInstanceValue),0) < 1
				BEGIN
					--set due date as 15 days from the date the file was opened
					SELECT @DUEDATE = CaseKeyDates_Date FROM dbo.CaseKeyDates WITH (NOLOCK) WHERE CaseKeyDates_KeyDatesCode = 'OpenDate' AND CaseKeyDates_CaseID = @pCaseID

					IF @DueDate IS NULL
						SET @DueDate = GETDATE()
										
					SET @DUEDATE = DATEADD(DAY,14,@DUEDATE)
					--set escalation date as 5 days from the due date
					SET @EscDate = DATEADD(DAY,5,@DUEDATE)
					SET @REMDATE = DATEADD(DAY,7,@DUEDATE)

				END
				ELSE
				BEGIN
					--set due date as 70 days from the date the last client report was ran
					SELECT @DUEDATE = MAX(CompletedDate) FROM dbo.AppTask WITH (NOLOCK) where AppTaskDefinitionCode = 'CLNTREP' AND AppInstanceValue = @pAppInstanceValue
					
					IF @DueDate IS NULL
						SET @DueDate = GETDATE()
										
					SET @DUEDATE = DATEADD(DAY,70,@DUEDATE)
					--set escalation date as 7 days from the due date
					SET @EscDate = DATEADD(DAY,7,@DUEDATE)
					SET @REMDATE = DATEADD(DAY,7,@DUEDATE)
				END
			END
			
			SELECT @pTLUser = UserName FROM dbo.AppUser WITH (NOLOCK) WHERE AppInstanceValue = @pAppInstanceValue AND AppUserRoleCode = 'TL' AND InActive = 0
			SELECT @pFEUser = UserName FROM dbo.AppUser WITH (NOLOCK) WHERE AppInstanceValue = @pAppInstanceValue AND AppUserRoleCode = 'FES' AND InActive = 0
			SELECT @pDescription = 'Reminder: Report to ' + CaseContacts_SearchName FROM CaseContacts WHERE CaseContacts_CaseID = @pCaseID AND ISNULL(CaseContacts_ClientID, 0) <> 0 AND CaseContacts_Inactive = 0
			SELECT @pEscDescription = 'Escalated: Report to ' + CaseContacts_SearchName FROM CaseContacts WHERE CaseContacts_CaseID = @pCaseID AND ISNULL(CaseContacts_ClientID, 0) <> 0 AND CaseContacts_Inactive = 0
							
			--ADD TASK FOR THE Client report
			EXECUTE AppTask_CreatePending
			   @AppTaskID = 0
			  ,@UserName = 'Admin'
			  ,@AppTaskDefinitionCode = 'CLNTREP'
			  ,@AppInstanceValue = @pAppInstanceValue
			  ,@CaseID = @pCaseID 
			  ,@CreatedBy = 'Admin'
			  ,@Description = @pDescription
			  ,@Location = ''
			  ,@AssignedTo = @pFEUser
			  ,@DueDate = @DUEDATE
			  ,@ReminderDate = @REMDATE -- Changed from @DUEDATE
			  ,@CaseContactID = 0
			  ,@DocumentID = 0
			  ,@CustomID1 = 0
			  ,@CustomID2 = 0
			  ,@CustomID3 = 0
			  ,@CustomID4 = 0
			  ,@CustomID5 = 0
			  ,@pAppTaskSubTypeCode = 'CLNTREP'
			  ,@pComment = ''
			  ,@pPriorityCode = 'Normal'
			  ,@KeyDateID = ''
			  ,@StartScheduleDate = @DUEDATE
			  ,@EndScheduleDate = @DUEDATE
			  ,@Outlook_GUID = ''
			  ,@pESCDATE = @EscDate
			  ,@pEscUser = @pTLUser 
			  ,@pEscTaskText = @pEscDescription
			  ,@pRoleCode = 'FES,FEJ'
								
			--increment loop counter
			SET @MinID = @MinID + 1  			  
		END
		
		COMMIT TRANSACTION ClientReport
	END TRY
		
	BEGIN CATCH
		IF @@TRANCOUNT > 0 
			ROLLBACK TRANSACTION ClientReport
			
		SELECT ERROR_MESSAGE() + ' SP:' + OBJECT_NAME(@@PROCID)
	END CATCH
