    Exec dbo.dba_indexDefrag_sp
          @executeSQL           = 1
        , @minFragmentation     = 40 -- ONLY DEFRAG INDEXES WHERE FRAG IS HIGHER THAN THIS 
        , @printCommands        = 1
        , @debugMode            = 0
        , @printFragmentation   = 1
        , @database             = 'FloSuite_Data_Dev' --CHANGE TO APPROPRIATE DB
        , @tableName            = NULL --NULL = DO ALL TABLES/INDEXES