--TASKS NOT YET ESCALATED
--Get all AppTasks where EscUser <> TL
select a.EscUser, au.UserName, * from AppTask a
inner join AppUser au 
on a.AppInstanceValue = au.AppInstanceValue
and a.StatusCode = 'Active'
and au.InActive = 0
and au.AppUserRoleCode = 'TL'
and ISNULL(a.EscUser, '') <> ''
and a.EscUser <> au.UserName

--Get details of those to be updated - copy these results to a spreadsheet
select a.AppTaskID, a.AppInstanceValue, a.EscUser, au.UserName as TL  from AppTask a
inner join AppUser au 
on a.AppInstanceValue = au.AppInstanceValue
and a.StatusCode = 'Active'
and au.InActive = 0
and au.AppUserRoleCode = 'TL'
and ISNULL(a.EscUser, '') <> ''
and a.EscUser <> au.UserName
order by a.AppTaskID

--Set the EscUser to the TL
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
---------

--TASKS ALREADY ESCALATED
select a.AssignedTo, au.UserName, * from AppTask a
inner join AppUser au 
on a.AppInstanceValue = au.AppInstanceValue
where a.StatusCode = 'Active'
and au.InActive = 0
and au.AppUserRoleCode = 'TL'
and a.AssignedTo <> au.UserName
and a.AppTaskDefinitionCode = 'EscTask'
order by a.AppInstanceValue

--Get details of those to be updated - copy these results to a spreadsheet
select a.AppTaskID, a.AppInstanceValue, a.AssignedTo, au.UserName as TL  from AppTask a
inner join AppUser au 
on a.AppInstanceValue = au.AppInstanceValue
where a.StatusCode = 'Active'
and au.InActive = 0
and au.AppUserRoleCode = 'TL'
and a.AssignedTo <> au.UserName
and a.AppTaskDefinitionCode = 'EscTask'
order by a.AppInstanceValue

update AppTask 
set AssignedTo = username
from AppTask
inner join AppUser 
on Apptask.AppInstanceValue = appuser.AppInstanceValue
where StatusCode = 'Active'
and InActive = 0
and AppUserRoleCode = 'TL'
and AssignedTo <> UserName
and AppTaskDefinitionCode = 'EscTask'
------------


