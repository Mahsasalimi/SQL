# Batch Updating Large Tables in SQL Server

## Overview

Updating millions of rows in a single SQL statement can cause long locks, transaction log growth, and performance issues.  
This repository demonstrates a simple and repeatable pattern to safely update large tables in **batches**.

## Approach

1. Select the next batch of rows that have not been updated yet.  
2. Update only that batch.  
3. Track processed rows in a temporary table.  
4. Repeat until all rows are updated.

This approach keeps transactions small, reduces locking, and ensures predictable performance.

## Example Snippet

Here is a short example illustrating the concept:

```sql
-- Track processed rows
IF OBJECT_ID('tempdb..#UpdatedIDs') IS NOT NULL DROP TABLE #UpdatedIDs;
SELECT TOP 0 RecordID INTO #UpdatedIDs FROM dbo.SourceTable;

WHILE 1 = 1
BEGIN
    IF OBJECT_ID('tempdb..#Batch') IS NOT NULL DROP TABLE #Batch;

    -- Select next batch of unprocessed rows
    SELECT TOP (5000) s.RecordID
    INTO #Batch
    FROM dbo.SourceTable s
    LEFT JOIN #UpdatedIDs u ON s.RecordID = u.RecordID
    WHERE u.RecordID IS NULL;

    -- Update using a join to a lookup table
    UPDATE s
    SET s.TargetColumn = l.LookupValue
    FROM dbo.SourceTable s
    JOIN dbo.LookupTable l ON s.MatchKey = l.MatchKey
    JOIN #Batch b ON s.RecordID = b.RecordID;

    -- Mark batch as processed
    INSERT INTO #UpdatedIDs (RecordID)
    SELECT RecordID FROM #Batch;

    IF @@ROWCOUNT = 0 BREAK;
END
```

The full script is available in -[Link](batch-update-large-tables/batch_update.sql)

## Notes & Best Practices:

* Adjust the batch size according to your system resources.
* Ensure proper indexing on MatchKey and RecordID.
* This approach is useful for backfills, data corrections, and large-scale data enrichment.
* Test on a staging environment before running on production.
