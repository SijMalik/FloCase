--RUN EACH STEP IN ORDER
--I'M SURE THIS CAN BE DONE IN A SINGLE STATEEMENT BUT C.B.A. SO USING TEMP TABLES

--1. GET ALL DUPLICATES
select a.ID 
INTO #temp1
from dbo.ActiveSpsFlosuite a
INNER JOIN
(select a.SP_Name, COUNT(*) as rc from dbo.ActiveSpsFlosuite a
group by a.SP_Name
having COUNT(*) > 1)b
ON a.SP_Name = b.SP_Name




--2. GET THE MAX ID FOR DUPLICATE CASE/CODE (WE ARE GOING TO MAKE THE OTHERS INACTIVE)
select max(a.ID) as MaxID
into #temp2
from dbo.ActiveSpsFlosuite a
where a.ID
IN
(
select ID from dbo.ActiveSpsFlosuite ckd
INNER JOIN
(select a.SP_Name, COUNT(*) as rc from dbo.ActiveSpsFlosuite a
group by a.SP_Name
having COUNT(*) > 1) a
ON ckd.SP_Name = a.SP_Name)
group by a.SP_Name
having COUNT(*) > 1

--3. WE ONLY WANT TO DEAL WITH DUPLICATE RECORDS, SO STORE THE ID'S OF DUPLICATE
--	RECORDS WHERE THEY'RE NOT THE MAX ID IN A TEMP TABLE
select * 
into #delete
from #temp1 
where ID
NOT IN 
(SELECT MaxID FROM #temp2) 

--4. THESE ARE THE DUPLICATES
select * from #delete

--5. DO THE DELETE
DELETE FROM dbo.ActiveSpsFlosuite 
WHERE ID IN 
(SELECT ID FROM #delete)

--CHECK WE HAVE NO DUPLICATES
select a.ID 
from dbo.ActiveSpsFlosuite a
INNER JOIN
(select a.SP_Name, COUNT(*) as rc from dbo.ActiveSpsFlosuite a
group by a.SP_Name
having COUNT(*) > 1)b
ON a.SP_Name = b.SP_Name


--DROP THE TEMP TABLES
DROP TABLE #temp1
DROP TABLE #temp2
DROP TABLE #delete

