
USE Project

-- Display employees table

SELECT * 
FROM employees

-- Display departments table

SELECT * 
FROM departments

SELECT * 
FROM project_assignments


-- Joining on the basis of Department ID / Employee ID

SELECT * FROM employees e
join departments d
on e.department_id = d.department_id
join project_assignments pa
on pa.employee_id = e.employee_id

-- Selecting specific columns as per needed

--- Big table

SELECT 
e.employee_id, 
e.first_name, 
e.last_name, 
e.job_title, 
e.salary,
d.department_name,
pa.project_id
FROM employees e
join departments d
on e.department_id = d.department_id
join project_assignments pa
on pa.employee_id = e.employee_id

-- Checking both the tables

SELECT * FROM upcoming_projects
SELECT * FROM completed_projects

-- Columns are same, we need to stack one on top of each other so we can use Union. Union needs same number of columns, project_lead is missing.

SELECT
project_id,
project_name,
project_budget
FROM 
upcoming_projects

UNION ALL

SELECT
project_id,
project_name,
project_budget
FROM 
completed_projects

-- Adding status

SELECT
project_id,
project_name,
project_budget,
'Upcoming' AS status
FROM 
upcoming_projects

UNION ALL

SELECT
project_id,
project_name,
project_budget,
'Completed' AS status
FROM 
completed_projects

-- Creating Common Table Expression (CTE) [Putting both queries, adding join to the bottom of Big Table, and adding new columns to big table from project status]

WITH project_status AS (
SELECT
project_id,
project_name,
project_budget,
'Upcoming' AS status
FROM upcoming_projects

UNION ALL

SELECT
project_id,
project_name,
project_budget,
'Completed' AS status
FROM completed_projects )


SELECT 
e.employee_id, 
e.first_name, 
e.last_name, 
e.job_title, 
e.salary,
d.department_name,
pa.project_id,
p.project_name,
p.status
FROM employees e
join departments d
on e.department_id = d.department_id
join project_assignments pa
on pa.employee_id = e.employee_id
join project_status p
on p.project_id = pa.project_id
