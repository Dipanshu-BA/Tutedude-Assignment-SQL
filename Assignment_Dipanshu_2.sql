use company_db;

-- 1.
select *
from employees;

-- 2.
INSERT INTO departments (department_id, department_name, company_id)
VALUES (4, 'Sales', 1);
INSERT INTO employees (employee_id, first_name, last_name, department_id, salary, hire_date, manager_id, job_title)
VALUES
(5, 'Amit', 'Sharma', 4, 450000.00, '2024-09-01', 1, 'Sales Executive'),
(6, 'Neha', 'Verma', 4, 480000.00, '2024-09-05', 1, 'Sales Manager');

Select E.*
from employees E 
Join departments D on D.department_id = E.department_id
where D.department_name = 'Sales';

-- 3.
SELECT DISTINCT job_title
FROM employees;

-- 4. 
select*
from employees
order by salary DESC;

-- 5. 
select count(employee_id) as 'Total Employees'
from employees;

-- 6. 
select D.department_name, Avg(E.salary) as Average_Salary
from employees E 
Join departments D on D.department_id = E.department_id
Group by D.department_name;

-- 7.
Select Concat(E.first_name, ' ',E.last_name) as 'Employee Name', D.department_name
from employees E
Join departments D on D.department_id = E.department_id;



