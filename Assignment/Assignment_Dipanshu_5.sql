use company_db;
-- 1. 
START TRANSACTION;
UPDATE employees
SET salary = salary + 1000
WHERE employee_id = 1;  -- receiver
UPDATE employees
SET salary = salary - 1000
WHERE employee_id = 2;  -- sender
SELECT employee_id, CONCAT(first_name,' ',last_name) AS Employee_Name, salary
FROM employees
WHERE employee_id IN (1,2);
COMMIT;

-- 2. 
SELECT d.department_id, d.department_name, c.company_name
FROM departments d
JOIN companies c ON d.company_id = c.company_id
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.department_id
);

-- 3. 
WITH RECURSIVE EmployeeHierarchy AS (
    -- Base case: top-level employees (no manager)
    SELECT employee_id, CONCAT(first_name, ' ', last_name) AS Employee_Name, manager_id, job_title,
        1 AS hierarchy_level
    FROM employees
    WHERE manager_id IS NULL
    UNION ALL
    -- Recursive case: employees reporting to someone in the hierarchy
    SELECT e.employee_id, CONCAT(e.first_name, ' ', e.last_name) AS Employee_Name, e.manager_id, e.job_title,
        eh.hierarchy_level + 1
    FROM employees e
    INNER JOIN EmployeeHierarchy eh ON e.manager_id = eh.employee_id
)
SELECT hierarchy_level, employee_id, Employee_Name, job_title, manager_id
FROM EmployeeHierarchy
ORDER BY hierarchy_level, manager_id;

-- 4. 
SELECT employee_id, CONCAT(first_name, ' ', last_name) AS Employee_Name, job_title, salary,
    LAG(salary) OVER (ORDER BY salary) AS Previous_Salary,
    LEAD(salary) OVER (ORDER BY salary) AS Next_Salary
FROM employees
ORDER BY salary;

-- 5. 
SELECT 
  COALESCE(d.department_name, 'Grand Total') AS department_name,
  SUM(e.salary) AS Total_Salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name WITH ROLLUP;


-- 6. 
-- mysqldump -u root -p company_db > company_db_backup.sql
-- To Export Only Structure (no data)
-- mysqldump -u root -p --no-data company_db > company_db_structure.sql
-- To Export Only Data (no structure)
-- mysqldump -u root -p --no-create-info company_db > company_db_data.sql






