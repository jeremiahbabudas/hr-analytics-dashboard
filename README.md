# HR Analytics Dashboard – SQL & Power BI

This project focuses on building a comprehensive **HR Analytics Dashboard** by integrating **multiple Excel files into SQL Server**, performing data transformation using **SQL queries and Power Query**, and developing a dynamic **Power BI dashboard** to support organizational decision-making.


## 📊 Objective

To analyze and visualize HR data to:

1. **Identify underperforming departments or overbudget projects** for corrective action  
2. **Organize and structure HR data** to ensure it's clean, queryable, and useful for reporting  
3. **Develop a user-friendly Power BI dashboard** that provides insights into:
   - Employee performance  
   - Salary distribution  
   - Departmental and project management  


## 🛠️ Tools Used

- **SQL Server Management Studio (SSMS)** – For importing and querying Excel datasets  
- **Power BI Desktop** – For data visualization  
- **Power Query** – For additional transformation and row-level operations  
- **Excel** – Original data source  


## 🗃️ Data Sources

The following Excel files were imported into SQL Server:

- `completed_projects`
- `departments`
- `employees`
- `project_assignments`
- `projects`
- `upcoming_projects`

Additionally, a `Head_Shots` file containing employee images was imported **directly into Power BI**, as it did not require querying.


## 📈 Dashboard Features

**Employee Selector (Dropdown):**  
Displays employee ID, name, job title, department, and salary

**Department Summary Table:**  
Shows department name, department goals, total salary cost, total project cost, and capital allocation (adjusts based on department selection)

**Donut Chart:**  
Visualizes how capital is distributed across department goals or departments (interactive based on slicer)

**Bar Charts with Gradients:**  
- Project budgets by project  
- Project budgets by department


## ✅ Key Outcomes

- Gained familiarity with SQL syntax including `JOIN`, `UNION`, `CTE`, and selective querying  
- Learned how to import and filter SQL data into Power BI using custom SQL statements  
- Improved proficiency with Power BI tools (slicers, cards, visuals, model relationships)  
- Built a visually appealing and interactive dashboard  
- Strengthened skills in data modeling, transformation, and visualization

## 🔍 Data Preparation

A **Common Table Expression (CTE)** was used to unify completed and upcoming projects:

```sql
WITH project_status AS (
  SELECT project_id, project_name, project_budget, 'Upcoming' AS status
  FROM upcoming_projects
  UNION ALL
  SELECT project_id, project_name, project_budget, 'Completed' AS status
  FROM completed_projects
)

SELECT 
  e.employee_id, 
  e.first_name, 
  e.last_name, 
  e.job_title, 
  e.salary,
  d.department_name,
  d.department_budget,
  d.department_goals,
  pa.project_id,
  p.project_name,
  p.project_budget,
  p.status
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN project_assignments pa ON pa.employee_id = e.employee_id
JOIN project_status p ON p.project_id = pa.project_id
