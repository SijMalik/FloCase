
--[LTMM_Change_Limitation_Date] 1956, '2014-10-09'
ALTER PROC [dbo].[LTMM_Change_Limitation_Date] 
	(	@pCaseID INT = 0, --MANDATORY
		@pNewAccidentDate SMALLDATETIME = NULL --MANDATORY
	)
AS
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		1
	-- Create Date: 09-10-2012
	-- Description:	Changes limitation date when accident date changes, for claimants who are over 18
	-- ===============================================================
	SET NOCOUNT ON 
	
	DECLARE @errNoCaseID VARCHAR(50)
	DECLARE @errAccDate VARCHAR(50)
	DECLARE @Counter INT
	DECLARE @MaxID INT
	DECLARE @ContactID INT
	DECLARE @ContactName VARCHAR(100)
	DECLARE @DescLimit VARCHAR(255)
	DECLARE @LimitDate SMALLDATETIME
	DECLARE @LimitDateChar VARCHAR(10)
	DECLARE @AppInsVal VARCHAR(20)
	DECLARE	@ATCreatedBy VARCHAR(255)
	DECLARE @ATAssignedTo VARCHAR(255)
	DECLARE @ATRoleCode VARCHAR (10)
	DECLARE @CKDIDLimit INT
	DECLARE @AppTaskIDLimit INT
	DECLARE @CKDCode VARCHAR(10)
	DECLARE @CaseKeyDates_CaseKeyDatesIDLim INT
	
	SET @errNoCaseID = 'Please pass in @pCaseID.'
	SET @errAccDate = 'Please pass in @pNewAcccidentDate.'
	
	SET @Counter = 1
	
	BEGIN TRY
		--Check mandatory params passed in 
		IF @pCaseID = 0
			RAISERROR (@errNoCaseID, 16,1)

		IF @pNewAccidentDate IS NULL
					RAISERROR (@errAccDate, 16,1)
		----
		
		--Get the AppInsVal
		SELECT @AppInsVal = c.Case_BLMREF FROM [Case] c				 
		WHERE c.Case_CaseID = @pCaseID
		
		--Get the values to pass to AppTask_CreatePending later
		SELECT	TOP 1
				@ATCreatedBy = a.CreatedBy,
				@ATAssignedTo = a.AssignedTo,
				@ATRoleCode = a.RoleCode		
		FROM	dbo.AppTask a WITH (NOLOCK) 
		WHERE a.AppInstanceValue = @AppInsVal
		AND a.AppTaskDefinitionCode = 'KeyDate'
		AND a.[Description] like 'Key Date: Limitation%'	
		AND a.StatusCode = 'Active'
		----		
	
		--Get Claimants/KeyDates info for Claimants with an active Limitation date 					
		DECLARE @MatterClaimantsLim TABLE (ID INT IDENTITY(1,1),CaseID INT, MatCaseConID INT, MatConID INT, MatConFullName VARCHAR(100), MatConDOB SMALLDATETIME, CKDCode VARCHAR(10), CKDDate SMALLDATETIME, CKDID INT) 						

		INSERT INTO @MatterClaimantsLim
		SELECT	
				b.CaseContacts_CaseID,
				b.CaseContacts_CaseContactsID,
				b.CaseContacts_MatterContactID,  
				b.CaseContacts_SearchName,
				b.MatterContact_DOB,
				ckd.CaseKeyDates_KeyDatesCode,
				DATEADD(YEAR,3,@pNewAccidentDate),--New Limit Date = New Accident Date + 3 years
				ckd.CaseKeyDates_CaseKeyDatesID
		FROM	CaseKeyDates ckd
		INNER JOIN
			(SELECT 
				a.CaseContacts_CaseID,
				a.CaseContacts_CaseContactsID,
				a.CaseContacts_MatterContactID, 
				a.CaseContacts_SearchName,
				a.MatterContact_DOB
			FROM dbo.MatterContact mc WITH (NOLOCK)
			INNER JOIN
				(SELECT	
						cc.CaseContacts_CaseID,
						cc.CaseContacts_CaseContactsID,
						cc.CaseContacts_MatterContactID, 
						cc.CaseContacts_SearchName, 
						mc.MatterContact_DOB 
				FROM	dbo.CaseContacts cc WITH (NOLOCK)
				INNER JOIN dbo.MatterContact mc WITH (NOLOCK)
				ON cc.CaseContacts_MatterContactID = mc.MatterContact_MatterContactID
				WHERE	cc.CaseContacts_Inactive = 0
				AND		cc.CaseContacts_RoleCode = 'Claimant'
				AND		cc.CaseContacts_CaseID = @pCaseID
				AND		mc.MatterContact_DateOfDeath IS NULL
				AND		mc.MatterContact_Inactive = 0			
				)a
			ON mc.MatterContact_MatterContactID = a.CaseContacts_MatterContactID
			)b
		ON ckd.CaseKeyDates_CaseID = @pCaseID
		AND ckd.CaseKeyDates_KeyDatesCode ='Limit'
		AND ckd.CaseKeyDates_Inactive = 0
		AND ckd.CaseKeyDates_CaseContactsID = b.CaseContacts_CaseContactsID			
		ORDER BY b.MatterContact_DOB
		----

		--Remove Claimants under 18, taking into account leap years
		--As we're looking at an 18 year period there will have been leap years
		DELETE FROM @MatterClaimantsLim
		WHERE DATEDIFF(d, MatConDOB, GETDATE())/365.25 < 18
		----
		
		--UPDATE Accident Date		
		UPDATE CaseKeyDates
		SET CaseKeyDates_Inactive = 1
		WHERE CaseKeyDates_CaseID = @pCaseID
		AND CaseKeyDates_KeyDatesCode = 'Accident'
				
		INSERT INTO [dbo].[CaseKeyDates]
			([CaseKeyDates_CaseID]
			,[CaseKeyDates_KeyDatesCode]
			,[CaseKeyDates_Date]
			,[CaseKeyDates_CaseContactsID]
			,[CaseKeyDates_Inactive]
			,[CaseKeyDates_CreateUser]
			,[CaseKeyDates_CreateDate])
		VALUES
			(@pCaseID,
			'Accident',
			@pNewAccidentDate, 
			0, 
			0,
			'ADMIN',
			GETDATE()) 
		----
		
		/*** UPDATE LIMITATION INFO ***/			
		SELECT @MaxID = MAX(ID) + 1 FROM @MatterClaimantsLim 

		WHILE @Counter < @MaxID
		BEGIN
			--Set variables for Limitation task for contact							
			SELECT	@ContactID = MatCaseConID, 
					@ContactName = MatConFullName,
					@CKDCode = CKDCode,
					@LimitDate =CKDDate,
					@CKDIDLimit = CKDID			
			FROM	@MatterClaimantsLim 
			WHERE	ID = @Counter			
			----

			--Save new Limitation Date
			INSERT INTO [dbo].[CaseKeyDates]
			(	[CaseKeyDates_CaseID]
				,[CaseKeyDates_KeyDatesCode]
				,[CaseKeyDates_Date]
				,[CaseKeyDates_CaseContactsID]
				,[CaseKeyDates_Inactive]
				,[CaseKeyDates_CreateUser]
				,[CaseKeyDates_CreateDate]
			)
			VALUES
			(	@pCaseID,
				@CKDCode,
				@LimitDate, 
				@ContactID, 
				0,
				'ADMIN',
				GETDATE()
			)			
			----
			
			--Get new CKD Limit Date ID for contact
			SET @CaseKeyDates_CaseKeyDatesIDLim	= SCOPE_IDENTITY()
		  
			--Set old CKD Limit Date ID for contact inactive
			UPDATE CaseKeyDates
			SET CaseKeyDates_Inactive = 1
			WHERE CaseKeyDates_CaseKeyDatesID = @CKDIDLimit	
			----											  		
			
			/*** Set existing Limition task to Complete and create new task with new LimitDate ***/			
			--Check Limitation task exists for contact
			IF EXISTS ( SELECT 1 
						FROM	dbo.AppTask a WITH (NOLOCK)
						WHERE	a.AppInstanceValue = @AppInsVal
						AND		a.AppTaskDefinitionCode = 'KeyDate'
						AND		a.[Description] LIKE 'Key Date: Limitation%'
						AND		a.ContactID = @ContactID
					  )
			BEGIN	
			
				--Set the Description
				SELECT @LimitDateChar = CONVERT(VARCHAR(10),@LimitDate, 103)
				SET @DescLimit = 'Key Date: Limitation Period Expires ' + @LimitDateChar + ' (' + @ContactName + ')'			
				----
								
				--Get existing AppTaskID for Limitation task for contact				
				SELECT	@AppTaskIDLimit = a.AppTaskID 
				FROM	dbo.AppTask a WITH (NOLOCK)
				WHERE	a.AppInstanceValue =@AppInsVal
				AND		a.AppTaskDefinitionCode = 'KeyDate'
				AND		a.[Description] LIKE 'Key Date: Limitation%'
				AND		a.ContactID = @ContactID
				----
			END
			
			--Set existing task to completed
			IF @AppTaskIDLimit IS NOT NULL
			BEGIN
				UPDATE	dbo.AppTask 
				set		StatusCode='Complete', 
						CompletedBy='ADMIN', 
						CompletedDate=GETDATE(), 
						[Description]='Updated by Admin - ' + [Description] 
				WHERE	AppTaskID = @AppTaskIDLimit			
			END
			----
			
			--Create new Limitation task for contact
			EXEC AppTask_CreatePending				
				@AppTaskDefinitionCode	= 'KeyDate',		
				@AppInstanceValue		= @AppInsVal,
				@CaseID					= @pCaseID,
				@Description			= @DescLimit,
				@CreatedBy				= @ATCreatedBy,
				@AssignedTo				= @ATAssignedTo,		
				@DueDate				= @LimitDate,
				@CaseContactID			= @ContactID,
				@KeyDateID              = @CaseKeyDates_CaseKeyDatesIDLim,						@pReferencialCode		= @ContactID,
				@pPriorityCode			= 'Normal',		
				@pAppTaskSubTypeCode	= 'KeyDate'
			----
				
			SET @AppTaskIDLimit = NULL 				
			/*** END - Set existing Limition task to Complete and create new task with new LimitDate ***/									
									
			SET @Counter = @Counter + 1					
		END
		/*** END - UPDATE LIMITATION INFO ***/
		
	END TRY
	
	BEGIN CATCH		
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH
	

	
	

