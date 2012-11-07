--FIRST - Put spreadsheet data into table called ClaimX
  
--Get just ARISTACLTNUMBER into temp table
  select ID, ARISTACLTNUMBER
  INTO #Temp1
  from [VectusCP_DMSDEV].[dbo].ClaimX
  select * from #temp1

--Get ID's for each case into temp table  
  SELECT DISTINCT cx.ID, cx.ARISTACLTNUMBER
  INTO #Temp_CX
  FROM [VectusCP_DMSDEV].[dbo].ClaimX cx
  INNER JOIN [VectusCP_DMSDEV].[dbo].[VEC_DEFENDPI] dpi
  on cx.ARISTACLTNUMBER = dpi.ARISTACLTNUMBER
  
--select ID from #Temp_CX

--Do main insert - will update userid and code later

 
  INSERT INTO [VectusCP_DMSDEV].[dbo].[VEC_ACTION]
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
	'2012-04-04 10:00:00.000',
	'2012-04-10 10:00:00.000',
	0,
	'MLR Information and Status',
	'MLR Information and Status',
	'MLR Information and Status',
	'MLR Information and Status',
	ID,
	[CASETITLE],
	[CODE]
	FROM [VectusCP_DMSDEV].[dbo].[VEC_CASE]
	  where id IN (SELECT  ID from #Temp_CX)
	  order by id
	  
--CHECK
	  select *
	   from [VectusCP_DMSDEV].[dbo].[VEC_ACTION]
	   where activityid = 9111
	  and usercode = 'xxx'
	  
--Get User code
	select distinct right(casecode,3) as usercode
	into #Temp_CX_User
	   from [VectusCP_DMSDEV].[dbo].[VEC_ACTION]
	   where activityid = 9111
	  and usercode = 'xxx'		  
	  
--INSER userID and usercode into temp table	  
	  select distinct userID, usercode 
	  into #Temp_CX_User2
	  from [VectusCP_DMSDEV].[dbo].[VEC_ACTION]
	  where usercode in (
	  select * from #Temp_CX_User)
	  

--UPDATE userID and usercode	  
	  update [VectusCP_DMSDEV].[dbo].[VEC_ACTION]
	  set usercode = #Temp_CX_User2.usercode,
		userid = #Temp_CX_User2.userID
	  from #Temp_CX_User2
	  where right(casecode,3) = #Temp_CX_User2.usercode
	  and activityid = 9111

	--  update [VectusCP_DMSDEV].[dbo].[VEC_ACTION]
	--  set userid = #Temp_CX_User2.userID
	- - from #Temp_CX_User2
	--  where right(casecode,3) = #Temp_CX_User2.usercode
	--  and activityid = 9111

--Final check
select * from [VectusCP_DMSDEV].[dbo].[VEC_ACTION] where 
activityid = 9111
and caseid in (
1113731,
1113735,
1114170
)

select caseid, userid 
into #temp3
from [VectusCP_DMSDEV].[dbo].[VEC_ACTION]
where  activityid = 9111
group by caseid, userid--,createdate
having count(*) > 1


select caseid, min(createdate) as dt
into #temp4
from [VectusCP_DMSDEV].[dbo].[VEC_ACTION] 
where activityid = 9111
and caseid in (select caseid from #temp3)
group by caseid


delete from [VectusCP_DMSDEV].[dbo].[VEC_ACTION]
where id in(
select id from #temp4 t4
inner join [VectusCP_DMSDEV].[dbo].[VEC_ACTION] va
on t4.caseid = va.caseid
and t4.dt = va.createdate
and activityid = 9111)


