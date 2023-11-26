-- Create 'employees' table
DROP TABLE IF EXISTS dbo.Employees

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10, 2)
);

-- Insert data into 'employees' table
INSERT INTO employees (employee_id, employee_name, department_id, salary)
VALUES
    (1, 'John', 1, 60000.00),
    (2, 'Jane', 2, 55000.00),
    (3, 'Bob', 1, 70000.00),
    (4, 'Alice', 2, 62000.00),
    (5, 'Charlie', 1, 55000.00);

-- Create 'departments' table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- Insert data into 'departments' table
INSERT INTO departments (department_id, department_name)
VALUES
    (1, 'IT'),
    (2, 'Marketing');




--Scalar Subquery
SELECT employee_name, salary,
       (SELECT AVG(salary) FROM employees) AS avg_salary
FROM employees;

--Single-Row Subquery
SELECT employee_name, salary
FROM employees
WHERE department_id = (
    SELECT TOP 1 department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
);

--Multi-Row Subquery
SELECT department_name
FROM departments
WHERE (SELECT AVG(salary) FROM employees WHERE department_id = departments.department_id) >
      (SELECT AVG(salary) FROM employees WHERE department_id = (SELECT department_id FROM departments WHERE department_name = 'Marketing'));


--Correlated Subquery
SELECT employee_name, salary, department_id
FROM employees e
WHERE salary > (SELECT AVG(salary) FROM employees WHERE department_id = e.department_id);


--Table Subquery
SELECT employee_name, salary
FROM employees
WHERE department_id IN (SELECT department_id FROM departments WHERE department_name = 'IT');


--Correlated EXISTS Subquery
SELECT department_name
FROM departments d
WHERE EXISTS (SELECT 1 FROM employees e WHERE e.department_id = d.department_id AND e.salary > 65000);


