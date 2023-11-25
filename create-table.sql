-- Create a database named 'temp'
CREATE DATABASE Temp;
GO

-- Use the 'temp' database
USE Temp;
GO

-- Drop table if exists
IF OBJECT_ID('dbo.SampleTable', 'U') IS NOT NULL
    DROP TABLE dbo.SampleTable;
GO

-- Create a table
CREATE TABLE dbo.SampleTable (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    City VARCHAR(50),
    Country VARCHAR(50),
    Salary DECIMAL(10, 2)
);

-- Insert some sample data
INSERT INTO dbo.SampleTable (ID, Name, Age, City, Country, Salary)
VALUES
    (1, 'John', 25, 'New York', 'USA', 50000.00),
    (2, 'Jane', 30, 'London', 'UK', 60000.00),
    (3, 'Bob', 28, 'Paris', 'France', 55000.00),
    (4, 'Alice', 35, 'Tokyo', 'Japan', 70000.00),
    (5, 'Charlie', 22, 'Berlin', 'Germany', 48000.00),
    (6, 'David', 32, 'Toronto', 'Canada', 65000.00),
    (7, 'Emma', 27, 'Melbourne', 'Australia', 52000.00),
    (8, 'Frank', 40, 'Seoul', 'South Korea', 75000.00),
    (9, 'Grace', 26, 'Mumbai', 'India', 51000.00),
    (10, 'Henry', 33, 'Beijing', 'China', 68000.00),
    (11, 'Ivy', 31, 'Mexico City', 'Mexico', 62000.00),
    (12, 'Jack', 29, 'Cairo', 'Egypt', 59000.00),
    (13, 'Katie', 34, 'Moscow', 'Russia', 71000.00),
    (14, 'Leo', 23, 'Johannesburg', 'South Africa', 49000.00),
    (15, 'Eva', 29, 'Sydney', 'Australia', 58000.00),
	(16, 'Mike', 36, 'Los Angeles', 'USA', 72000.00),
    (17, 'Nina', 28, 'Berlin', 'Germany', 53000.00),
    (18, 'Oliver', 39, 'Paris', 'France', 67000.00),
    (19, 'Pam', 25, 'London', 'UK', 51000.00),
    (20, 'Quinn', 30, 'Tokyo', 'Japan', 69000.00),
    (22, 'Eva', 29, 'Sydney', 'Australia', 58000.00),
    (23, 'Frank', 40, 'Seoul', 'South Korea', 75000.00),
    (24, 'Ivy', 31, 'Mexico City', 'Mexico', 62000.00);

-- See data
select * from dbo.SampleTable