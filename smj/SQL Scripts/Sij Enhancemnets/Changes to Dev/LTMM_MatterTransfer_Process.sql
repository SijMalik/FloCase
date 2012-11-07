
ALTER PROC [dbo].[LTMM_MatterTransfer_Process]
(
	@pUsername		nvarchar(255) = ''
)
AS
	
	--Stored Procedure to 
	--Automate the Matter Transfer Process
	--
	--Author(s) GQL
	--16-11-2010
	
	--===========================================================
	-- Modified by SMJ on 06/12/2011
	-- Removed hard-coded reference to update Aderent DB
	-- Release 5.11a
	--============================================================		
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Release:		5.17
	-- Modify date: 04-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema name
	-- ===============================================================		
	
	--Initialise error trapping
	SET NOCOUNT ON

	--Declare variables
	DECLARE		@TODAYDATE AS SMALLDATETIME,
				@MINID AS INT,
				@MAXID AS INT,
				@pCurrentClientNumber AS NVARCHAR(10),
				@pCurrentMatterNumber AS NVARCHAR(10),
				@pNewClientNumber AS NVARCHAR(10),
				@pNewMatterNumber AS NVARCHAR(10),
				@CurrentClientNumberInt	as int,
				@CurrentMatterNumberInt	as int,
				@NewClientNumberInt		as int,
				@NewMatterNumberInt		as int,
				@CurrentDocPath as nvarchar(max),
				@NewDocPath as nvarchar(max),
				@CurrentEmailPath as nvarchar(max),
				@NewDocEmailPath as nvarchar(max),
				@DOCSTORE as nvarchar(max),
				@MatterUno as int,
				@FeeEmail as nvarchar(max),
				@ActionLink  as nvarchar(max),
				@Server as nvarchar(max),
				@CaseID as int,
				@MailProfile as NVARCHAR(MAX),
				@filestatus as int,
				@inpath as nvarchar(100),
				@UserID as int, 
				@ActionID as int, 
				@ActionName as NVARCHAR(255),
				@EmailBody as NVARCHAR(MAX),
				@EmailSubject as NVARCHAR(255),
				@UserEmail as NVARCHAR(255),
				@DynSQL AS NVARCHAR(MAX)
	
		--Initialise while loop counter variable
		SET @MINID = 1
	
	BEGIN TRY	
		--start transaction
		BEGIN TRANSACTION MatterTransfer
		
		
		--declare temporary holding table for matters requiring transfer
		CREATE TABLE #MatterTransfer
		(
			ResultID						INT IDENTITY,
			FLOCASE_EXPERT_MATTER_UNO			int,
			FLOCASE_CLIENT_NUMBER				int, 
			FLOCASE_MATTER_NUMBER				int, 
			ADERANT_CLIENT_NUMBER				int, 
			ADERANT_MATTER_NUMBER				int, 
			ADERANT_MATTER_UNO					int
		)
		
		
		--insert all matters into temporary holding table that do not match in terms of client and matter number 
		-- but do match in terms of aderant matter uno
		SELECT @DynSQL = 'INSERT INTO #MatterTransfer(FLOCASE_EXPERT_MATTER_UNO, FLOCASE_CLIENT_NUMBER, FLOCASE_MATTER_NUMBER, 
										ADERANT_CLIENT_NUMBER, ADERANT_MATTER_NUMBER, ADERANT_MATTER_UNO)
			SELECT ai.AExpert_MatterUno AS FLOCASE_EXPERT_MATTER_UNO,  cl1.CLIENT_NUMBER AS FLOCASE_CLIENT_NUMBER, 
			c.Case_MatterUno FLOCASE_MATTER_NUMBER, cl2.CLIENT_NUMBER AS ADERANT_CLIENT_NUMBER, 
			X.MATTER_NUMBER AS ADERANT_MATTER_NUMBER, X.MATTER_UNO AS ADERANT_MATTER_UNO
			FROM dbo.ApplicationInstance ai WITH (NOLOCK) INNER JOIN
			dbo.[Case] c  WITH (NOLOCK) 
				ON ai.CaseID = c.Case_CaseID INNER JOIN
			dbo.CaseContacts cc  WITH (NOLOCK)  
				ON c.Case_CaseID = cc.CaseContacts_CaseID AND ISNULL(cc.CaseContacts_ClientID, 0) > 0 
				AND cc.CaseContacts_Inactive = 0 INNER JOIN
			dbo.HBM_CLIENT cl1  WITH (NOLOCK) 
				ON cc.CaseContacts_ClientID = cl1.CLIENT_UNO INNER JOIN '
			+ SystemSettings_ADERANTEXPERTSERVER + '.' + SystemSettings_ADERANTEXPERTDB + '.[dbo].[HBM_MATTER] X
				ON ai.AExpert_MatterUno = X.MATTER_UNO INNER JOIN '
			+ SystemSettings_ADERANTEXPERTSERVER + '.' + SystemSettings_ADERANTEXPERTDB + '.[dbo].[_HBM_MATTER_USR_DATA] M
				 ON ai.AExpert_MatterUno = M.MATTER_UNO INNER JOIN
			dbo.HBM_CLIENT cl2  WITH (NOLOCK) 
				ON cl2.CLIENT_UNO = X.CLIENT_UNO
			WHERE (ai.IdentifierValue <> cast(cl2.CLIENT_NUMBER as nvarchar(8)) + ''-'' + cast(X.MATTER_NUMBER as nvarchar(8)))
			AND (CAST(cl2.CLIENT_NUMBER AS NVARCHAR(255)) + ''-'' + CAST(X.MATTER_NUMBER AS NVARCHAR(255)) NOT IN (SELECT IdentifierValue FROM ApplicationInstance))'
		FROM dbo.SystemSettings  WITH (NOLOCK) 
		
		--PRINT(@DynSQL)
		
		EXECUTE sp_executesql @DynSQL
		
		--set the max counter variable for the while loop = to the number of matter transfers identified
		SET @MAXID = (SELECT ISNULL(MAX(ResultID), 0) FROM #MatterTransfer  WITH (NOLOCK) )
		
		WHILE @MINID <= @MAXID 
		BEGIN
			
			--get details of the first matter transfer
			SELECT	@pCurrentClientNumber = RIGHT('0000000'+ CONVERT(VARCHAR,FLOCASE_CLIENT_NUMBER),8), 
					@pCurrentMatterNumber = RIGHT('0000000'+ CONVERT(VARCHAR,FLOCASE_MATTER_NUMBER),8), 
					@pNewClientNumber = RIGHT('0000000'+ CONVERT(VARCHAR,ADERANT_CLIENT_NUMBER),8), 
					@pNewMatterNumber = RIGHT('0000000'+ CONVERT(VARCHAR,ADERANT_MATTER_NUMBER),8),
					@MatterUno = FLOCASE_EXPERT_MATTER_UNO
			FROM #MatterTransfer  WITH (NOLOCK)  
			WHERE ResultID = @MINID 
			
			--Convert the strings to interger values from the transfer process
			SELECT	@CurrentClientNumberInt = CAST(@pCurrentClientNumber as INT),
					@CurrentMatterNumberInt = CAST(@pCurrentMatterNumber as INT),
					@NewClientNumberInt = CAST(@pNewClientNumber as INT),
					@NewMatterNumberInt = CAST(@pNewMatterNumber as INT)
			
			 
			--PRINT '@pCurrentClientNumber - ' + CAST(@pCurrentClientNumber AS NVARCHAR(8))
			--PRINT '@pCurrentMatterNumber - ' + CAST(@pCurrentMatterNumber AS NVARCHAR(8))
			--PRINT '@pNewClientNumber - ' + CAST(@pNewClientNumber AS NVARCHAR(8))
			--PRINT '@pNewMatterNumber - ' + CAST(@pNewMatterNumber AS NVARCHAR(8))
			--PRINT '@pUserName - ' + @pUserName
			
			--perform matter transfer from database end		
			EXECUTE [LTMM_MoveMatterClient] 
			   @pCurrentClientNumber
			  ,@pCurrentMatterNumber
			  ,@pNewClientNumber
			  ,@pNewMatterNumber
			  ,@pUserName
			
			--get the docstore settings
			SELECT @DOCSTORE = SystemSettings_Docstore, 
			@Server = SystemSettings_ServerName 
			FROM dbo.SystemSettings  WITH (NOLOCK)  
			
			--set current and new docstore paths for matter to be transfers along with email paths		
			SELECT @CurrentDocPath = @DOCSTORE + '\' + CAST(@CurrentClientNumberInt AS nvarchar(10)) + '\' + CAST(@CurrentMatterNumberInt AS nvarchar(10)),
			@NewDocPath = @DOCSTORE + '\' + CAST(@NewClientNumberInt AS nvarchar(10)) + '\' + CAST(@NewMatterNumberInt AS nvarchar(10)),
			@CurrentEmailPath = @DOCSTORE + '\' + CAST(@CurrentClientNumberInt AS nvarchar(10)) + '\' + CAST(@CurrentMatterNumberInt AS nvarchar(10)) + '\Email Attachments',
			@NewDocEmailPath = @DOCSTORE + '\' + CAST(@NewClientNumberInt AS nvarchar(10)) + '\' + CAST(@NewMatterNumberInt AS nvarchar(10)) + '\Email Attachments'
			
			--*** START MOVE DOCSTORE
			
			--CREATE NEW FOLDERS
			SET @inpath = 'MD "' + @NewDocPath + '"'

			EXEC @filestatus = master..xp_cmdshell @inpath

			--COPY existing FILES TO NEW FOLDERS
			SET @inpath = 'XCOPY "' + @CurrentDocPath + '" "' + @NewDocPath + '" /E'

			EXEC @filestatus = master..xp_cmdshell @inpath
			

			--REMOVE OLD FOLDERS deltree
			SET @inpath = 'RMDIR ' + @CurrentDocPath + ' /S /Q'

			EXEC @filestatus = master..xp_cmdshell @inpath
				
			--get details of the fee earner on the matter being transfered to send them a notification email		
			select @FeeEmail = ap.ContactEmail, @CaseID = ai.CaseID  from dbo.ApplicationInstance ai  WITH (NOLOCK) inner join
			dbo.AppUser au  WITH (NOLOCK) on ai.IdentifierValue = au.AppInstanceValue and au.AppUserRoleCode = 'FES' and au.InActive = 0 inner join
			dbo.AppUserProfile ap  WITH (NOLOCK) on au.UserName = ap.UserName and ap.InActive = 0
			where ai.AExpert_MatterUno = @MatterUno 
			
			--PRINT '@FeeEmail: ' + @FeeEmail
			
			
			--set up standard email
			SET @EmailSubject = N'FloCase Matter Transfer Notification'
			SET @MailProfile = (SELECT SystemSettings_SystemEmail FROM dbo.SystemSettings  WITH (NOLOCK) )
			set @ActionLink = '<a href=http://' + @Server + '/FloClient/default.aspx?CallType=Process&ProcessName=LTMM+Case+Console&CaseID=' + RTRIM(CAST(@CaseID as varchar(15))) + ' target=_blank>here</a>'
			SET @EmailBody = 
				N'<BODY>'
				+ N'<FONT FACE="Calibri">'
				+ N'<FONT SIZE=11pt COLOR="black">'
				+ N'<P><B>New FloCase Matter Transfer Alert</B></P>' 
				+ N'<P>An existing Matter has been transferred to a new Matter and Client number.  Please verify the details are correct by clicking '
				+ N'' + @ActionLink + '</P>'
				+ N'<P>Old Client Number: '
				+ N'' + @pCurrentClientNumber + '</P>'
				+ N'<P>Old Matter Number: '
				+ N'' + @pCurrentMatterNumber + '</P>'
				+ N'<P>New Client Number: '
				+ N'' + @pNewClientNumber + '</P>'
				+ N'<P>New Matter Number: '
				+ N'' + @pNewMatterNumber + '</P>'
				+ N'<P>Matter Description: '
				+ N'' + (SELECT Case_MatterDescription FROM dbo.[Case] WITH (NOLOCK)  WHERE Case_CaseID = @CaseID) + '</P>'
				+ N'</FONT>'
				+ N'</BODY>'
			SET @EmailBody = REPLACE(@EmailBody, '&lt;', '<')
			SET @EmailBody = REPLACE(@EmailBody, '&gt;', '>')
			
			IF ISNULL(@FeeEmail, '') <> ''
			BEGIN
				--send notification email
				EXEC msdb.dbo.sp_send_dbmail 
							@profile_name = @MailProfile, 
							@recipients = @FeeEmail,  
							@subject = @EmailSubject, 
							@body = @EmailBody,
							@body_format = 'HTML' 
			END
			
			--record transfer in log table 
			INSERT INTO [dbo].[MatterTransferLog]
				   ([MatterTransferLog_OldClientNo]
				,[MatterTransferLog_OldMatterNo]
				,[MatterTransferLog_NewClientNo]
				,[MatterTransferLog_NewMatterNo]
				,[MatterTransferLog_ProcessedDate])
			VALUES (@pCurrentClientNumber, 
				@pCurrentMatterNumber, 
				@pNewClientNumber, 
				@pNewMatterNumber, 
				getdate())
			
			--move to next matter transfer			
			SET @MINID = @MINID + 1
		END
		
		DROP TABLE #MatterTransfer
	
		
		--commit transaction	
		COMMIT TRANSACTION MatterTransfer
	END TRY
	
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION MatterTransfer
			
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH	
	


