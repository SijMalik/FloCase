SELECT OBJECT_NAME(st.objectid,dbid) StoredProcedure
      ,max(cp.usecounts) Execution_count
      ,sum(qs.total_worker_time)/1000000 total_cpu_time
      ,sum(qs.total_worker_time) / (max(cp.usecounts) * 1.0)/1000000  avg_cpu_time 
 FROM sys.dm_exec_cached_plans cp join sys.dm_exec_query_stats qs on cp.plan_handle = qs.plan_handle
      CROSS APPLY sys.dm_exec_sql_text(cp.plan_handle) st
 where DB_NAME(st.dbid) ='Flosuite_Data_Live' and cp.objtype = 'proc'
 group by DB_NAME(st.dbid),OBJECT_SCHEMA_NAME(objectid,st.dbid), OBJECT_NAME(objectid,st.dbid) 
 order by sum(qs.total_worker_time) desc

