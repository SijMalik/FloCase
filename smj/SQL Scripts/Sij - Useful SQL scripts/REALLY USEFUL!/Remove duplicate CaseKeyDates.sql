--RUN EACH STEP IN ORDER
--I'M SURE THIS CAN BE DONE IN A SINGLE STATEEMENT BUT C.B.A. SO USING TEMP TABLES

--1. GET ALL DUPLICATES
select CaseKeyDates_CaseKeyDatesID 
INTO #temp1
from casekeydates ckd 
INNER JOIN
(select a.CaseKeyDates_CaseID, a.CaseKeyDates_KeyDatesCode, COUNT(*) as rc from CaseKeyDates a
where a.CaseKeyDates_Inactive = 0
group by a.CaseKeyDates_CaseID, a.CaseKeyDates_KeyDatesCode
having COUNT(*) > 1)a
ON ckd.CaseKeyDates_CaseID = a.CaseKeyDates_CaseID
and ckd.CaseKeyDates_KeyDatesCode = a.CaseKeyDates_KeyDatesCode
and ckd.CaseKeyDates_Inactive = 0

--2. GET THE MAX ID FOR DUPLICATE CASE/CODE (WE ARE GOING TO MAKE THE OTHERS INACTIVE)
select max(a.CaseKeyDates_CaseKeyDatesID) as MaxID
into #temp2
from CaseKeyDates a
where a.CaseKeyDates_Inactive = 0
and a.CaseKeyDates_CaseKeyDatesID 
IN
(
select CaseKeyDates_CaseKeyDatesID from casekeydates ckd 
INNER JOIN
(select a.CaseKeyDates_CaseID, a.CaseKeyDates_KeyDatesCode, COUNT(*) as rc from CaseKeyDates a
where a.CaseKeyDates_Inactive = 0
group by a.CaseKeyDates_CaseID, a.CaseKeyDates_KeyDatesCode
having COUNT(*) > 1)a
ON ckd.CaseKeyDates_CaseID = a.CaseKeyDates_CaseID
and ckd.CaseKeyDates_KeyDatesCode = a.CaseKeyDates_KeyDatesCode
and ckd.CaseKeyDates_Inactive = 0
)
group by a.CaseKeyDates_CaseID, a.CaseKeyDates_KeyDatesCode
having COUNT(*) > 1

--3. WE ONLY WANT TO DEAL WITH DUPLICATE RECORDS, SO STORE THE ID'S OF DUPLICATE
--	RECORDS WHERE THEY'RE NOT THE MAX ID IN A TEMP TABLE
select * 
into #delete
from #temp1 
where CaseKeyDates_CaseKeyDatesID
NOT IN 
(SELECT MaxID FROM #temp2) 

--4. THESE ARE THE DUPLICATES
select * from #delete

--5. DO THE DELETE
UPDATE CaseKeyDates
SET CaseKeyDates_Inactive = 1
WHERE CaseKeyDates_CaseKeyDatesID IN
(SELECT CaseKeyDates_CaseKeyDatesID FROM #delete)

--CHECK WE HAVE NO DUPLICATES
SELECT a.CaseKeyDates_CaseID, a.CaseKeyDates_KeyDatesCode, COUNT(*) 
FROM CaseKeyDates a
WHERE a.CaseKeyDates_Inactive = 0
GROUP BY a.CaseKeyDates_CaseID, a.CaseKeyDates_KeyDatesCode
HAVING COUNT(*) > 1


--DROP THE TEMP TABLES
DROP TABLE #temp1
DROP TABLE #temp2
DROP TABLE #delete

