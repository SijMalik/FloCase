--FIRST - Put spreadsheet data into table called ClaimX
  --drop table #ClaimX
  CREATE TABLE #ClaimX(ID INT, ARISTACLTNUMBER INT)
  --select * from #ClaimX
  
--Get just ARISTACLTNUMBER into temp table
  select ID, ARISTACLTNUMBER
  INTO #Temp1
  from #ClaimX
  
  --select * from #temp1

--Get ID's for each case into temp table  
  SELECT DISTINCT cx.ID, cx.ARISTACLTNUMBER
  INTO #Temp_CX
  FROM #ClaimX cx
  INNER JOIN [VectusCP].[dbo].[VEC_DEFENDPI] dpi
  on cx.ARISTACLTNUMBER = dpi.ARISTACLTNUMBER
  
--select ID from #Temp_CX

--Do main insert - will update userid and code later

 
  INSERT INTO [VectusCP].[dbo].[VEC_ACTION]
  (
	CASEID, 
	CASECODE, 
	ACTIVITYID, 
	USERID, 
	USERCODE,
	[TYPE], 
	CREATEDATE, 
	CREATETIME, 
	DUEDATE,  
	ORIGINALDATE, 
	PRIORITY, 
	DIARYTEXT, 
	ACTIONTEXT, 
	DIARYTEXT1, 
	DIARYTEXT2, --MLR Information and Status  
	MASTER_CASEID, 
	CASETITLE, 
	DIARYTEXT3-- CODE
	)
	SELECT 
	ID,
	CODE,
	9111,
	0,
	'XXX',
	1,
	GETDATE(),
	'1900-01-01 11:00:43.000',
	'2012-05-09 10:00:00.000',
	'2012-05-09 10:00:00.000',
	0,
	'MLR Information and Status',
	'MLR Information and Status',
	'MLR Information and Status',
	'MLR Information and Status',
	ID,
	[CASETITLE],
	[CODE]
	FROM [VectusCP].[dbo].[VEC_CASE]
	  where id IN (SELECT  ID from #Temp_CX)

	  
--CHECK
	  select *
	   from [VectusCP].[dbo].[VEC_ACTION]
	   where activityid = 9111
	  and usercode = 'xxx'
	  
--Get User code
	select distinct right(casecode,3) as usercode
	into #Temp_CX_User
	   from [VectusCP].[dbo].[VEC_ACTION]
	   where activityid = 9111
	  and usercode = 'xxx'		  
	  
--INSER userID and usercode into temp table	  
	  select distinct userID, usercode 
	  into #Temp_CX_User2
	  from [VectusCP].[dbo].[VEC_ACTION]
	  where usercode in (
	  select * from #Temp_CX_User)
	  

--UPDATE userID and usercode	  
	  update [VectusCP].[dbo].[VEC_ACTION]
	  set usercode = #Temp_CX_User2.usercode,
		userid = #Temp_CX_User2.userID
	  from #Temp_CX_User2
	  where right(casecode,3) = #Temp_CX_User2.usercode
	  and activityid = 9111


--Check
select * from [VectusCP].[dbo].[VEC_ACTION] where 
activityid = 9111

--Get DUPS
select caseid, userid 
into #temp3
from [VectusCP].[dbo].[VEC_ACTION]
where  activityid = 9111
group by caseid, userid--,createdate
having count(*) > 1

--Get min date for deleting dups
select caseid, min(createdate) as dt
into #temp4
from [VectusCP].[dbo].[VEC_ACTION] 
where activityid = 9111
and caseid in (select caseid from #temp3)
group by caseid

--DELETE DUPS
delete from [VectusCP].[dbo].[VEC_ACTION]
where id in(
select id from #temp4 t4
inner join [VectusCP].[dbo].[VEC_ACTION] va
on t4.caseid = va.caseid
and t4.dt = va.createdate
and activityid = 9111)


--FINAL CHECK FOR DUPS
select caseid, userid 
from [VectusCP].[dbo].[VEC_ACTION]
where  activityid = 9111
group by caseid, userid--,createdate
having count(*) > 1

--Final check
select * from [VectusCP].[dbo].[VEC_ACTION] where 
activityid = 9111
order by caseid