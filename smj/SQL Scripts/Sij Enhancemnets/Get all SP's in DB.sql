  SELECT name as [SP_Name]
  into AllSpsDB
FROM sys.procedures
where is_ms_shipped = 0
and name not like 'sp%'
union
select 'sp_CompareDB'
order by name
