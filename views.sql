-- ============================================
-- HR Management - SQL Views
-- Author: Fadi
-- Description: Reusable views for common HR queries
-- ============================================

USE hr_management;

-- ============================================
-- VIEW 1: Employee Full Profile
-- Combines employee info with department and manager name
-- ============================================
CREATE OR REPLACE VIEW vw_employee_profile AS
SELECT
    e.emp_id,
    CONCAT(e.first_name, ' ', e.last_name)      AS full_name,
    e.email,
    e.job_title,
    e.salary,
    e.hire_date,
    TIMESTAMPDIFF(YEAR, e.hire_date, CURDATE())  AS tenure_years,
    d.dept_name,
    CONCAT(m.first_name, ' ', m.last_name)       AS manager_name
FROM employees e
JOIN departments d       ON e.dept_id   = d.dept_id
LEFT JOIN employees m    ON e.manager_id = m.emp_id;


-- ============================================
-- VIEW 2: Department Salary Summary
-- Aggregated salary stats per department
-- ============================================
CREATE OR REPLACE VIEW vw_dept_salary_summary AS
SELECT
    d.dept_id,
    d.dept_name,
    COUNT(e.emp_id)                              AS headcount,
    ROUND(AVG(e.salary), 2)                      AS avg_salary,
    MIN(e.salary)                                AS min_salary,
    MAX(e.salary)                                AS max_salary,
    SUM(e.salary)                                AS monthly_salary_cost,
    SUM(e.salary) * 12                           AS annual_salary_cost,
    d.budget,
    ROUND((SUM(e.salary) * 12 / d.budget) * 100, 2) AS budget_utilization_pct
FROM departments d
JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name, d.budget;


-- ============================================
-- VIEW 3: Active Project Assignments
-- Shows each employee with their current project(s)
-- ============================================
CREATE OR REPLACE VIEW vw_active_project_assignments AS
SELECT
    CONCAT(e.first_name, ' ', e.last_name)  AS employee_name,
    e.job_title,
    d.dept_name,
    p.project_name,
    p.status                                AS project_status,
    ep.role                                 AS project_role,
    p.start_date,
    p.end_date
FROM employees e
JOIN departments d           ON e.dept_id      = d.dept_id
JOIN employee_projects ep    ON e.emp_id        = ep.emp_id
JOIN projects p              ON ep.project_id   = p.project_id
WHERE p.status = 'Active'
ORDER BY p.project_name, e.last_name;


-- ============================================
-- VIEW 4: Employee Salary Growth
-- Shows salary progression per employee from salary_history
-- ============================================
CREATE OR REPLACE VIEW vw_employee_salary_growth AS
SELECT
    e.emp_id,
    CONCAT(e.first_name, ' ', e.last_name)       AS full_name,
    e.job_title,
    d.dept_name,
    COUNT(sh.history_id)                          AS total_raises,
    MIN(sh.old_salary)                            AS starting_salary,
    e.salary                                      AS current_salary,
    ROUND(e.salary - MIN(sh.old_salary), 2)       AS total_increase,
    ROUND(
        ((e.salary - MIN(sh.old_salary)) / MIN(sh.old_salary)) * 100, 2
    )                                             AS growth_pct
FROM employees e
JOIN departments d       ON e.dept_id   = d.dept_id
JOIN salary_history sh   ON e.emp_id    = sh.emp_id
GROUP BY e.emp_id, full_name, e.job_title, d.dept_name, e.salary
ORDER BY growth_pct DESC;


-- ============================================
-- VIEW 5: Unassigned Employees
-- Employees with no project assignment
-- ============================================
CREATE OR REPLACE VIEW vw_unassigned_employees AS
SELECT
    e.emp_id,
    CONCAT(e.first_name, ' ', e.last_name)  AS full_name,
    e.job_title,
    d.dept_name,
    e.salary,
    e.hire_date
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE e.emp_id NOT IN (
    SELECT DISTINCT emp_id FROM employee_projects
)
ORDER BY d.dept_name;
