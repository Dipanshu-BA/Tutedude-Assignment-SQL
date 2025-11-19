use company_db;
select * from employees;
select * from departments;

-- 1. 
UPDATE employees e
JOIN departments d ON e.department_id = d.department_id
SET e.salary = e.salary * 1.10
WHERE d.department_name = 'Sales';
SELECT e.employee_id, CONCAT(e.first_name, ' ', e.last_name) AS Employee_Name, e.job_title, e.salary, d.department_name, c.company_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN companies c ON d.company_id = c.company_id
WHERE d.department_name = 'Sales';

-- 2. 
-- Add the 'Obsolete' department
INSERT INTO departments (department_id, department_name, company_id)
VALUES (5, 'Obsolete', 1);
-- Add an employee in the 'Obsolete' department
INSERT INTO employees (employee_id, first_name, last_name, department_id, salary, hire_date, manager_id, job_title)
VALUES (9, 'Test', 'Employee', 5, 400000, '2024-10-01', NULL, 'Obsolete Staff');
-- Verify the Employee Exists
SELECT e.employee_id, CONCAT(e.first_name,' ',e.last_name) AS Employee_Name, e.job_title, e.salary, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Obsolete';

DELETE e
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Obsolete';
-- Verify Deletion
SELECT * 
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Obsolete';


-- 3. 
INSERT INTO employees (employee_id, first_name, last_name, department_id, salary, hire_date, manager_id, job_title)
VALUES (10, 'Low', 'Earner', 1, 50000, '2024-10-15', 7, 'Junior Staff');
CREATE VIEW High_Earners AS
SELECT employee_id, CONCAT(first_name, ' ', last_name) AS Employee_Name, job_title, salary, department_id
FROM employees
WHERE salary > 80000;
SELECT * FROM High_Earners;

-- 4. 
ALTER TABLE employees
ADD CONSTRAINT chk_salary_positive
CHECK (salary > 0);

-- 5. 
CREATE INDEX idx_employee_lastname
ON employees (last_name);

-- 6. 
DELIMITER $$
CREATE PROCEDURE GetEmployeesByDepartment(IN dept_name VARCHAR(255))
BEGIN
    SELECT e.employee_id, CONCAT(e.first_name, ' ', e.last_name) AS Employee_Name, e.job_title, e.salary, d.department_name, c.company_name
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    JOIN companies c ON d.company_id = c.company_id
    WHERE d.department_name = dept_name;
END$$
DELIMITER ;
CALL GetEmployeesByDepartment('Sales');








