
-- Batch update large tables safely in SQL Server
-- Adjust table names, column names, and batch size as needed

IF OBJECT_ID('tempdb..#UpdatedIDs') IS NOT NULL DROP TABLE #UpdatedIDs;

SELECT TOP 0 RecordID
INTO #UpdatedIDs
FROM dbo.SourceTable;

WHILE 1 = 1
BEGIN
    IF OBJECT_ID('tempdb..#Batch') IS NOT NULL DROP TABLE #Batch;

    SELECT TOP (5000) s.RecordID
    INTO #Batch
    FROM dbo.SourceTable s
    LEFT JOIN #UpdatedIDs u ON s.RecordID = u.RecordID
    WHERE u.RecordID IS NULL;

    UPDATE s
    SET s.TargetColumn = l.LookupValue
    FROM dbo.SourceTable s
    JOIN dbo.LookupTable l ON s.MatchKey = l.MatchKey
    JOIN #Batch b ON s.RecordID = b.RecordID;

    INSERT INTO #UpdatedIDs (RecordID)
    SELECT RecordID FROM #Batch;

    IF @@ROWCOUNT = 0 BREAK;
END

