CREATE DATABASE company_db;
USE company_db;
CREATE TABLE companies(
company_id INT Primary Key auto_increment,
company_name VARCHAR(255) Not Null);
describe companies;

CREATE TABLE departments(
department_id INT Primary Key auto_increment,
department_name VARCHAR(255) Not Null,
company_id INT,
Foreign Key (company_id) references companies(company_id));
describe departments;

CREATE TABLE employees(
employee_id INT Primary Key auto_increment,
first_name VARCHAR(255) Not Null,
last_name VARCHAR(255) Not Null,
department_id INT,
Foreign Key (department_id) references departments(department_id),
salary decimal(15,2) Not Null,
hire_date date Not Null,
manager_id INT Not Null,
job_title VARCHAR(255) Not Null);

describe employees;
show tables;

Insert into companies
values
(1, 'CPM'),
(2, 'BDE'),
(3, 'ZOHO');
select * from companies;

Insert into departments
values
(1, 'Business Insights', 1),
(2, 'Business Development', 2),
(3, 'Operations', 3);
select * from departments;

Insert into employees
values
(1, 'Dipanshu', 'Sapra', 1, 600000.00, '2024-06-10', 1, 'Business Analyst'),
(2, 'Ravjot', 'Kaur', 1, 600000.00, '2023-01-01', 1, 'Assistant Manager'),
(3, 'Soumya' , 'Jha', 2, 500000.00, '2024-07-12', 28, 'Business Development Executive'),
(4, 'Rahul', 'Kumar', 3, 500000.00, '2024-08-16', 22, 'Business Development Operation'); 
select* from employees;


