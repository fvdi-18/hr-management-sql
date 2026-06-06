# HR Management System — SQL Project

A complete SQL project demonstrating real-world database design and advanced query techniques using an Employee & Department Management scenario.

---

## Project Overview

This project simulates a company's HR database, covering employees, departments, projects, and salary history. It showcases database design skills and progressively advanced SQL — from basic JOINs to Window Functions, CTEs, Views, and Stored Procedures.

---

## Database Schema

```
departments ──< employees >── employee_projects ──< projects
                   │
                   └──< salary_history
```

### Tables

| Table               | Description                                           |
| ------------------- | ----------------------------------------------------- |
| `departments`       | Company departments with budget and location          |
| `employees`         | Employee info including manager (self-referencing FK) |
| `projects`          | Company projects linked to departments                |
| `employee_projects` | Many-to-many: which employee works on which project   |
| `salary_history`    | Track every salary change with reason                 |

---

## File Structure

```
hr-management-sql/
├── schema.sql             — Table definitions & relationships
├── data.sql               — Sample data (13 employees, 5 depts, 5 projects)
├── queries.sql            — 20 analytical queries (Sections 1–8)
├── views.sql              — 5 reusable SQL views
├── stored_procedures.sql  — 3 stored procedures for HR operations
└── README.md              — This file
```

---

## Queries Overview

### Section 1 — Basic Queries
- List all employees with department name
- Count employees per department

### Section 2 — Aggregation & GROUP BY
- Avg / Min / Max salary per department
- Departments with avg salary above threshold (`HAVING`)

### Section 3 — Subqueries
- Employees earning above company average
- Highest paid employee in each department

### Section 4 — JOINs
- Employees and their managers (Self JOIN)
- Employees and their projects
- Employees NOT assigned to any project

### Section 5 — Window Functions
- Salary rank within each department (`RANK()`)
- Running total of salaries (`SUM() OVER`)
- Compare salary to department average

### Section 6 — Salary History
- Total salary increase per employee

### Section 7 — Business Insights
- Budget utilization per department
- Employee tenure in years

### Section 8 — CTEs (Common Table Expressions)
- Top earner per department
- Employees above their department average
- Salary tier breakdown per department (High / Mid / Entry)
- Multi-project employees and their project count
- Running headcount and cumulative payroll by hire date

---

## Views

| View                        | Description                                        |
| --------------------------- | -------------------------------------------------- |
| `vw_employee_profile`       | Full employee info with department and manager     |
| `vw_dept_salary_summary`    | Aggregated salary stats and budget utilization     |
| `vw_active_project_assignments` | Current active project assignments per employee |
| `vw_employee_salary_growth` | Salary growth percentage per employee              |
| `vw_unassigned_employees`   | Employees with no project assignment               |

---

## Stored Procedures

| Procedure               | Description                                                    |
| ----------------------- | -------------------------------------------------------------- |
| `sp_give_raise`         | Apply a % raise to an employee and auto-log to salary_history  |
| `sp_department_report`  | Full stats and employee list for a given department            |
| `sp_transfer_employee`  | Move an employee to a different department                     |

### Usage Examples

```sql
-- Give employee #5 a 10% raise
CALL sp_give_raise(5, 10.00, 'Annual performance review');

-- Full report for the Engineering department
CALL sp_department_report('Engineering');

-- Transfer employee #3 to department #2
CALL sp_transfer_employee(3, 2);
```

---

## Tech Stack

- **Database**: MySQL 8.0+
- **Concepts**: ERD Design, Normalization, Foreign Keys, Subqueries, JOINs, Window Functions, CTEs, Views, Stored Procedures

---

## How to Run

```bash
# 1. Clone the repo
git clone https://github.com/unreallfadi/hr-management-sql.git

# 2. Run files in this order:
mysql -u root -p < schema.sql
mysql -u root -p hr_management < data.sql
mysql -u root -p hr_management < views.sql
mysql -u root -p hr_management < stored_procedures.sql
mysql -u root -p hr_management < queries.sql
```

---
## Author

**Fadi**
SQL Developer | Database Design

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue)](https://linkedin.com)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black)](https://github.com/unreallfadi)
