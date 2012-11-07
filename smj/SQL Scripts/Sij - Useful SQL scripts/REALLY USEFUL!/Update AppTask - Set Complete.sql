--GET THE APPTASKID's YOU WANT TO SET TO COMPLETE
select * from AppTask a
where a.AppInstanceValue = '140435-81'
and a.StatusCode = 'Active'
order by [Description]

--UPDAte AppTask
--set AssignedTo = 'MMS'
--where AppTaskID = 998152
----UNCOMMENT CODE BELOW:
--update AppTask 
--set StatusCode='Complete', 
--	CompletedBy='ADMIN', 
--	CompletedDate=GETDATE(), 
--	[Description]='Completed by Admin - ' + Description 
--where AppTaskID IN 
--(
----*PASTE SINGLE OR MULTIPLE IDS's IN HERE:
--503972,
--503982
--)

--RUN ABOVE QUERY
--RUN ORIGINAL SELECT QUERY AGAIN TO CHECK THEY'RE NOT ACTIVE
