Use company_db;
-- 1. 
Alter Table employees
Modify manager_id INT Null;
INSERT INTO employees (employee_id, first_name, last_name, department_id, salary, hire_date, manager_id, job_title)
VALUES
(7, 'Karan', 'Mehta', 1, 700000.00, '2024-09-10', NULL, 'Department Head'),
(8, 'Pooja', 'Singh', 2, 750000.00, '2024-09-12', NULL, 'Senior Manager');

UPDATE employees SET manager_id = 7 WHERE employee_id = 1;  
UPDATE employees SET manager_id = 7 WHERE employee_id = 2;  
UPDATE employees SET manager_id = 8 WHERE employee_id = 3;  
UPDATE employees SET manager_id = 8 WHERE employee_id = 4;  
UPDATE employees SET manager_id = 6 WHERE employee_id = 5;  
UPDATE employees SET manager_id = 7 WHERE employee_id = 6;  

select * from employees;

SELECT 
    e.employee_id AS Employee_ID,
    CONCAT(e.first_name, ' ', e.last_name) AS Employee_Name,
    e.job_title AS Employee_Job_Title,
    CONCAT(m.first_name, ' ', m.last_name) AS Manager_Name,
    m.job_title AS Manager_Job_Title
FROM employees e
LEFT JOIN employees m 
    ON e.manager_id = m.employee_id
ORDER BY e.employee_id;

-- 2. 
SELECT 
    employee_id,
    CONCAT(first_name, ' ', last_name) AS Employee_Name,
    job_title,
    salary
FROM employees
WHERE salary > (
    SELECT AVG(salary) 
    FROM employees
);


-- 3. 
SELECT 
    e.employee_id, CONCAT(e.first_name, ' ', e.last_name) AS Employee_Name, e.job_title, d.department_name, c.company_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN companies c ON d.company_id = c.company_id
ORDER BY e.employee_id;


-- 4. 
WITH SalaryRank AS (
    SELECT employee_id, CONCAT(first_name, ' ', last_name) AS Employee_Name, job_title, salary,
        RANK() OVER (ORDER BY salary DESC) AS salary_rank
    FROM employees
)
SELECT 
    employee_id, Employee_Name, job_title, salary
FROM SalaryRank
WHERE salary_rank = 2;

-- 5. 
SELECT 
    e.employee_id, CONCAT(e.first_name, ' ', e.last_name) AS Employee_Name, e.job_title, d.department_name, e.salary,
    RANK() OVER (PARTITION BY d.department_id ORDER BY e.salary DESC) AS Salary_Rank
FROM employees e
JOIN departments d ON e.department_id = d.department_id
ORDER BY d.department_name, Salary_Rank;

-- 6. 
SELECT employee_id, CONCAT(first_name, ' ', last_name) AS Employee_Name, job_title, salary,
    CASE
        WHEN salary < 500000 THEN 'Low'
        WHEN salary BETWEEN 500000 AND 650000 THEN 'Medium'
        ELSE 'High'
    END AS Salary_Category
FROM employees
ORDER BY salary DESC;










