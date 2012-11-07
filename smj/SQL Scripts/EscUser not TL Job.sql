--TASK NOT ESCALATED
UPDATE AppTask
SET EscUser = AppUser.UserName
FROM AppTask 
inner join AppUser  
on AppTask.AppInstanceValue = AppUser.AppInstanceValue
and AppTask.StatusCode = 'Active'
and AppUser.InActive = 0
and AppUser.AppUserRoleCode = 'TL'
and ISNULL(AppTask.EscUser, '') <> ''
and AppTask.EscUser <> AppUser.UserName


--TASK ESCALATED
UPDATE AppTask 
SET AssignedTo = username
FROM AppTask
INNER JOIN AppUser 
ON Apptask.AppInstanceValue = appuser.AppInstanceValue
WHERE StatusCode = 'Active'
and InActive = 0
and AppUserRoleCode = 'TL'
and AssignedTo <> UserName
and AppTaskDefinitionCode = 'EscTask'