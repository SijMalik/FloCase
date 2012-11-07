  DECLARE @MaxID INT
  DECLARE @Counter INT
  
  SET @MaxID = 0
  SET @Counter = 1
  
  DECLARE @Docs TABLE (ID INT IDENTITY(1,1), MatNum VARCHAR(20))
  DECLARE @DocsCount TABLE (ID INT IDENTITY(1,1), MatNum VARCHAR(20), DocCount INT)  
  
  INSERT INTO @Docs
  SELECT DISTINCT Docpath FROM AppTaskDocument WITH (NOLOCK)
  WHERE DocPath IS NOT NULL AND RTRIM(LTRIM(DocPath)) <> ''  
  
  SELECT @MaxID = MAX(ID) FROM @Docs
  
  WHILE @Counter <= @MaxID
  BEGIN
	INSERT INTO @DocsCount 
	SELECT docpath, COUNT(*) FROM AppTaskDocument WITH (NOLOCK)
	WHERE DocPath in (select matnum from @Docs where ID = @Counter)
	GROUP BY docpath
	
	SET @Counter = @Counter + 1
  END
  
  SELECT * FROM @DocsCount



Select c.Case_CaseID, Case_BLMREF, a.DocumentCount, c.Case_StateCode, c.Case_GroupCode
 from [Case] c
inner join dbo.DocCount_Temp a
on c.Case_BLMREF = a.MatterNumber
order by c.Case_CaseID