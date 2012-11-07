select * from AppTask a
where a.AppInstanceValue = '66924-2499'
and a.StatusCode = 'Active'
order by a.Description

update AppTask
set AssignedTo = 'BLH'
where AppTaskID = 352464   