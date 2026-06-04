# HR Management System — SQL Project

A complete SQL project demonstrating real-world database design and advanced query techniques using an Employee and Department Management scenario.

---

## Project Overview

This project simulates a company's HR database, covering employees, departments, projects, and salary history. It showcases database design skills and progressively advanced SQL from basic JOINs to Window Functions.

---

## Database Schema

```
departments --< employees >-- employee_projects --< projects
                   |
                   +--< salary_history
```

### Tables

| Table               | Description                                           |
|---------------------|-------------------------------------------------------|
| `departments`       | Company departments with budget and location          |
| `employees`         | Employee info including manager (self-referencing FK) |
| `projects`          | Company projects linked to departments                |
| `employee_projects` | Many-to-many: which employee works on which project   |
| `salary_history`    | Track every salary change with reason                 |

---

## File Structure

```
hr-management-sql/
|-- schema.sql     Table definitions and relationships
|-- data.sql       Sample data (13 employees, 5 depts, 5 projects)
|-- queries.sql    15 analytical queries
|-- README.md      This file
```

---

## Queries Overview

### Section 1 - Basic Queries

- List all employees with department name
- Count employees per department

### Section 2 - Aggregation and GROUP BY

- Avg / Min / Max salary per department
- Departments with avg salary above threshold (HAVING)

### Section 3 - Subqueries

- Employees earning above company average
- Highest paid employee in each department

### Section 4 - JOINs

- Employees and their managers (Self JOIN)
- Employees and their projects
- Employees NOT assigned to any project

### Section 5 - Window Functions

- Salary rank within each department (RANK())
- Running total of salaries (SUM() OVER)
- Compare salary to department average

### Section 6 - Salary History

- Total salary increase per employee

### Section 7 - Business Insights

- Budget utilization per department
- Employee tenure in years

---

## Tech Stack

- **Database**: MySQL 8.0+
- **Concepts**: ERD Design, Normalization, Foreign Keys, Subqueries, JOINs, Window Functions

---

## How to Run

```bash
# 1. Clone the repo
git clone https://github.com/unreallfadi/hr-management-sql.git

# 2. Open MySQL and run in order:
mysql -u root -p < schema.sql
mysql -u root -p hr_management < data.sql
mysql -u root -p hr_management < queries.sql
```

---

## Author

**Fadi**
SQL Developer | Database Design

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue)](https://linkedin.com)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black)](https://github.com)
