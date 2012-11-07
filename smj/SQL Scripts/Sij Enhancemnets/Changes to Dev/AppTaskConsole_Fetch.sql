
ALTER PROC [dbo].[AppTaskConsole_Fetch]
(
	@UserName				nvarchar(255)  = '',		-- eg CKJ.  Map System.Username for Current User
	@CaseID					int = 0						-- eg 34545	
)

	-- ==========================================================================================
	-- SMJ - Amended - 21-09-2011
	-- New column AppTask_DateModified to AppTask table
	-- Changed SP to take in this parameter and use it in fetch
	-- ==========================================================================================

AS	

	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 27-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================
	
	SET DATEFORMAT DMY
	
	DECLARE @TEST AS INT
	
	SET @TEST = 0
	
	BEGIN TRY 
		IF (ISNULL(@CaseID,0)<>0) AND ((SELECT Case_StateCode FROM dbo.[CASE] WITH (NOLOCK) WHERE Case_CaseID = @CaseID) = 'Closed')
		BEGIN
			SET @TEST = 1
		END
		
		IF @TEST = 0
		BEGIN
			
			SELECT
					AppTask.AppTaskID,
							
					Case when DueDate < GETDATE() then '<a href=http://' + SystemSettings.SystemSettings_ServerName + '/floclient/default.aspx?CallType=Process&ProcessName=LTMM+Action+Manager&LTMMProcessName=' + REPLACE(AppTaskDefinition.ProcessName,' ','%20') + '&LTMMWorkFlowName=' + REPLACE(AppTaskDefinition.WorkflowName,' ','%20') + '&CaseID=' + RTRIM(CAST(ApplicationInstance.CaseID AS VARCHAR(MAX))) + '&AppTaskID=' + RTRIM(CAST(AppTask.AppTaskID AS VARCHAR(MAX))) + '&ReferencialCode=' + RTRIM(CAST(AppTask.Referencial_Code AS VARCHAR(MAX)))  + '&TeamPendingTask=True Target=_blank><font color="red">' + AppTask.Description + '</font></a>'
					Else '<a href=http://' + SystemSettings.SystemSettings_ServerName + '/floclient/default.aspx?CallType=Process&ProcessName=LTMM+Action+Manager&LTMMProcessName=' + REPLACE(AppTaskDefinition.ProcessName,' ','%20') + '&LTMMWorkFlowName=' + REPLACE(AppTaskDefinition.WorkflowName,' ','%20') + '&CaseID=' + RTRIM(CAST(ApplicationInstance.CaseID AS VARCHAR(MAX))) + '&AppTaskID=' + RTRIM(CAST(AppTask.AppTaskID AS VARCHAR(MAX))) + '&ReferencialCode=' + RTRIM(CAST(AppTask.Referencial_Code AS VARCHAR(MAX))) + '&TeamPendingTask=True Target=_blank>' + AppTask.Description + '</a>'
					END AS 'TaskLink',
											
					Case when DueDate < GETDATE() then '<font color="red">' + AppTask.Description + '</font>' 
					Else AppTask.Description
					END AS 'Description',
					
					Case when DueDate < GETDATE() then '<font color="red">' + AssignedTo + '</font>' 
					Else AssignedTo
					END AS 'AssignedTo',
					
					DueDate as 'DueDate2',
					
					Case when DueDate < GETDATE() then '<font color="red" other="' + CAST(ROW_NUMBER() over (order by DueDate)  AS nvarchar(10)) + '">' + convert(varchar(20), DueDate, 103) + '</font>' 
					Else convert(varchar(20), DueDate, 103)
					END AS 'DueDate',				
							
					Case when DueDate < GETDATE() then '<font color="red">' + AppTask.PriorityCode + '</font>' 
					Else AppTask.PriorityCode
					END AS 'PriorityCode',
					
					Case when DueDate < GETDATE() then '<font color="red">' + left(datename(WEEKDAY , DueDate),3) + ' ' + cast(datepart(d,DueDate) as nvarchar(2)) +  ' ' + left(datename(M , DueDate),3) + ' ' + cast(datepart(YYYY, DueDate) as nvarchar(4)) + '</font>' 
					Else left(datename(WEEKDAY , DueDate),3) + ' ' + cast(datepart(d,DueDate) as nvarchar(2)) +  ' ' + left(datename(M , DueDate),3) + ' ' + cast(datepart(YYYY, DueDate) as nvarchar(4))
					END AS 'TextDueDate',				
					
					Case when DueDate < GETDATE() then '<font color="red">' + AppTaskDefinition.AppTaskTypeCode + '</font>' 
					Else AppTaskDefinition.AppTaskTypeCode
					END AS 'AppTaskTypeCode',
					
					Case when DueDate < GETDATE() then '<font color="red">' + D.CaseContacts_SearchName + '</font>' 
					Else D.CaseContacts_SearchName
					END AS 'ClientName',
					
					Case when DueDate < GETDATE() then '<font color="red">' + c.Case_MatterDescription + '</font>' 
					Else c.Case_MatterDescription
					END AS 'MatterDescription',
									
					Case when DueDate < GETDATE() then '<font color="red">' + c.Case_BLMREF + '</font>' 
					Else c.Case_BLMREF
					END AS 'BLMREF',
					
					c.Case_CaseID as CaseID,
					AppTaskDefinition.ProcessName as ProcessName,
					AppTaskDefinition.WorkflowName as WorkflowName,
								
					Case when DueDate < GETDATE() then '<font color="red">' + convert(varchar(20), AppTask.AppTask_DateModified, 103)  + '</font>' 
					Else convert(varchar(20), AppTask.AppTask_DateModified, 103) 
					END AS 'AppTaskDateModified',				
					
					AppTask.Referencial_Code as Referencial_Code,
					'Yes' as TeamPendingTasks
				FROM dbo.AppTask WITH (NOLOCK)
				INNER JOIN dbo.AppTaskDefinition WITH (NOLOCK) ON (AppTaskDefinition.AppTaskDefinitionCode = AppTask.AppTaskDefinitionCode)
				INNER JOIN dbo.ApplicationInstance WITH (NOLOCK) ON (ApplicationInstance.IdentifierValue = AppTask.AppInstanceValue)
				INNER JOIN dbo.SystemSettings WITH (NOLOCK) ON (SystemSettings.SystemSettings_Inactive = 0)
				INNER JOIN dbo.[Case] c WITH (NOLOCK) ON (c.Case_CaseID = ApplicationInstance.CaseID)
				INNER JOIN dbo.CaseContacts d WITH (NOLOCK) ON (d.CaseContacts_CaseID = c.Case_CaseID) and (ISNULL(d.CaseContacts_ClientID, 0) > 0) AND (d.CaseContacts_Inactive = 0)
				WHERE ((AppTask.StatusCode = 'Active'))
				and ((c.Case_StateCode = 'Active'))
					AND ((ISNULL(@UserName,'') = '') OR (AppTask.AssignedTo = @UserName))
					AND ((ISNULL(@CaseID,0) = 0) OR (ApplicationInstance.CaseID = @CaseID))	
				ORDER BY DueDate2, AppTask.AppTaskID
		END
	END TRY
	
	BEGIN CATCH			
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH
