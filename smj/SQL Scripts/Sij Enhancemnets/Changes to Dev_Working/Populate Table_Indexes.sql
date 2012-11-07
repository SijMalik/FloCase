TRUNCATE TABLE dbo.Table_Indexes


INSERT INTO dbo.Table_Indexes (TableName, IndexName)
SELECT   DISTINCT
         object_name(t.object_id), 
         i.Name 
FROM     sys.indexes i 
         INNER JOIN sys.tables t 
           ON i.object_id = t.object_id 
         INNER JOIN sys.index_columns ic 
           ON ic.object_id = t.object_id 
              AND ic.index_id = i.index_id 
         INNER JOIN sys.columns c 
           ON c.object_id = t.object_id 
              AND ic.column_id = c.column_id
WHERE SUBSTRING(i.name,1,1) <> '_'             
ORDER BY object_name(t.object_id), 
          i.Name
         