-- Update data in dbo.SampleTable
UPDATE dbo.SampleTable
SET
    Salary = Salary * 1.1,  -- Increase salary by 10%
    Age = Age + 1           -- Increase age by 1
WHERE
    Country = 'USA';        -- Update only for records in the USA


-- See updated data
SELECT * FROM dbo.SampleTable;


-- Delete data from dbo.SampleTable where Age is less than 30
DELETE FROM dbo.SampleTable
WHERE Age < 30;

-- Delete all data from dbo.SampleTable
DELETE FROM dbo.SampleTable;

