
DROP TABLE IF EXISTS dbo.Departments
DROP TABLE IF EXISTS dbo.Employees
DROP TABLE IF EXISTS dbo.Projects



-- Create Employees table with additional columns
CREATE TABLE dbo.Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10, 2),
    HireDate DATE
);

-- Insert sample data into Employees table
INSERT INTO dbo.Employees (EmployeeID, EmployeeName, DepartmentID, Salary, HireDate)
VALUES
    (101, 'Alice Johnson', 1, 60000.00, '2022-01-15'),
    (102, 'Bob Smith', 2, 70000.00, '2022-02-20'),
    (103, 'Charlie Brown', 1, 55000.00, '2021-11-10'),
    (104, 'David Lee', 3, 80000.00, '2020-08-05'),
    (105, 'Emma Wang', 2, 75000.00, '2023-03-12'),
    (106, 'Frank Chen', 3, 90000.00, '2019-05-18'),
    (107, 'Grace Kim', 1, 58000.00, '2020-12-22'),
    (108, 'Henry Davis', 4, 72000.00, '2021-09-01'),
    (109, 'Ivy Patel', 5, 85000.00, '2018-07-14'),
    (110, 'Jack Miller', 6, 67000.00, '2022-04-30');


-- Create Departments table 
CREATE TABLE dbo.Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50),
    Location VARCHAR(50),
    ManagerID INT,
    CONSTRAINT FK_Departments_Employees FOREIGN KEY (ManagerID) REFERENCES dbo.Employees(EmployeeID)
);

-- Insert sample data into Departments table
INSERT INTO dbo.Departments (DepartmentID, DepartmentName, Location, ManagerID)
VALUES
    (1, 'Sales', 'New York', 101),
    (2, 'Marketing', 'London', 102),
    (3, 'Engineering', 'Paris', 106),
    (4, 'Human Resources', 'Berlin', 108),
    (5, 'Finance', 'Tokyo', 109),
    (6, 'Operations', 'Sydney', 110);


-- Create Projects table with additional columns
CREATE TABLE dbo.Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50),
    DepartmentID INT,
    StartDate DATE,
    EndDate DATE,
    CONSTRAINT FK_Projects_Departments FOREIGN KEY (DepartmentID) REFERENCES dbo.Departments(DepartmentID)
);

-- Insert sample data into Projects table
INSERT INTO dbo.Projects (ProjectID, ProjectName, DepartmentID, StartDate, EndDate)
VALUES
    (201, 'Project A', 1, '2022-03-01', '2022-06-30'),
    (202, 'Project B', 2, '2023-01-15', '2023-07-31'),
    (203, 'Project C', 3, '2021-08-10', '2022-02-28'),
    (204, 'Project D', 4, '2022-05-20', '2022-12-15'),
    (205, 'Project E', 5, '2023-04-01', '2023-10-31'),
    (206, 'Project F', 6, '2022-09-15', '2023-03-31');



-- INNER JOIN
SELECT
    E.EmployeeID,
    E.EmployeeName,
    E.Salary,
    D.DepartmentID,
    D.DepartmentName,
    D.Location,
    D.ManagerID,
    P.ProjectID,
    P.ProjectName,
    P.StartDate,
    P.EndDate
FROM
    dbo.Employees E
INNER JOIN
    dbo.Departments D ON E.DepartmentID = D.DepartmentID
INNER JOIN
    dbo.Projects P ON D.DepartmentID = P.DepartmentID
WHERE
    E.Salary >= 60000.00
    AND D.Location = 'New York'
    AND (P.StartDate >= '2022-03-01' OR P.StartDate IS NULL)
ORDER BY
    E.EmployeeID;

-- LEFT JOIN
SELECT
    E.EmployeeID,
    E.EmployeeName,
    E.Salary,
    D.DepartmentID,
    D.DepartmentName,
    D.Location,
    D.ManagerID,
    P.ProjectID,
    P.ProjectName,
    P.StartDate,
    P.EndDate
FROM
    dbo.Employees E
INNER JOIN
    dbo.Departments D ON E.DepartmentID = D.DepartmentID
LEFT JOIN
    dbo.Projects P ON D.DepartmentID = P.DepartmentID
WHERE
    D.Location = 'New York'
    AND (P.StartDate >= '2022-03-01' OR P.StartDate IS NULL)
ORDER BY
    E.EmployeeID;

-- RIGHT JOIN
SELECT
    E.EmployeeID,
    E.EmployeeName,
    E.Salary,
    D.DepartmentID,
    D.DepartmentName,
    D.Location,
    D.ManagerID,
    P.ProjectID,
    P.ProjectName,
    P.StartDate,
    P.EndDate
FROM
    dbo.Employees E
RIGHT JOIN
    dbo.Departments D ON E.DepartmentID = D.DepartmentID
RIGHT JOIN
    dbo.Projects P ON D.DepartmentID = P.DepartmentID
WHERE
    E.Salary >= 60000.00
    AND (P.StartDate >= '2022-01-01' OR P.StartDate IS NULL)
ORDER BY
    E.EmployeeID;

-- FULL OUTER JOIN
SELECT
    E.EmployeeID,
    E.EmployeeName,
    E.Salary,
    D.DepartmentID,
    D.DepartmentName,
    D.Location,
    D.ManagerID,
    P.ProjectID,
    P.ProjectName,
    P.StartDate,
    P.EndDate
FROM
    dbo.Employees E
FULL OUTER JOIN
    dbo.Departments D ON E.DepartmentID = D.DepartmentID
FULL OUTER JOIN
    dbo.Projects P ON D.DepartmentID = P.DepartmentID
WHERE
	(P.StartDate >= '2022-03-01' OR P.StartDate IS NULL)
ORDER BY
    E.EmployeeID;
