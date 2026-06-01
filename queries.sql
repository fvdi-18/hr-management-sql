-- ============================================
-- HR Management - Advanced SQL Queries
-- Author: Fadi
-- ============================================

USE hr_management;

-- ============================================
-- SECTION 1: Basic Queries
-- ============================================

-- Q1: List all employees with their department name
SELECT 
    e.emp_id,
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    e.job_title,
    e.salary,
    d.dept_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
ORDER BY d.dept_name, e.salary DESC;


-- Q2: Count employees per department
SELECT 
    d.dept_name,
    COUNT(e.emp_id) AS total_employees
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name
ORDER BY total_employees DESC;


-- ============================================
-- SECTION 2: Aggregation & GROUP BY
-- ============================================

-- Q3: Average, Min, Max salary per department
SELECT 
    d.dept_name,
    ROUND(AVG(e.salary), 2)  AS avg_salary,
    MIN(e.salary)             AS min_salary,
    MAX(e.salary)             AS max_salary,
    SUM(e.salary)             AS total_salary_cost
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
ORDER BY avg_salary DESC;


-- Q4: Departments where avg salary > 10,000
SELECT 
    d.dept_name,
    ROUND(AVG(e.salary), 2) AS avg_salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
HAVING AVG(e.salary) > 10000
ORDER BY avg_salary DESC;


-- ============================================
-- SECTION 3: Subqueries
-- ============================================

-- Q5: Employees earning above the company average salary
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    job_title,
    salary
FROM employees
WHERE salary > (
    SELECT AVG(salary) FROM employees
)
ORDER BY salary DESC;


-- Q6: The highest paid employee in each department (Subquery)
SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    e.job_title,
    e.salary,
    d.dept_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.dept_id = e.dept_id
)
ORDER BY e.salary DESC;


-- ============================================
-- SECTION 4: JOINs
-- ============================================

-- Q7: Employees and their managers (Self JOIN)
SELECT 
    CONCAT(e.first_name, ' ', e.last_name)   AS employee_name,
    e.job_title,
    CONCAT(m.first_name, ' ', m.last_name)   AS manager_name,
    m.job_title                               AS manager_title
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id
ORDER BY manager_name;


-- Q8: Employees working on each project
SELECT 
    p.project_name,
    p.status,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    ep.role
FROM projects p
JOIN employee_projects ep ON p.project_id = ep.project_id
JOIN employees e          ON ep.emp_id = e.emp_id
ORDER BY p.project_name, ep.role;


-- Q9: Employees NOT assigned to any project
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    job_title
FROM employees
WHERE emp_id NOT IN (
    SELECT DISTINCT emp_id FROM employee_projects
);


-- ============================================
-- SECTION 5: Window Functions
-- ============================================

-- Q10: Salary rank within each department
SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    d.dept_name,
    e.salary,
    RANK() OVER (
        PARTITION BY e.dept_id 
        ORDER BY e.salary DESC
    ) AS salary_rank
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;


-- Q11: Running total of salaries per department
SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    d.dept_name,
    e.salary,
    SUM(e.salary) OVER (
        PARTITION BY e.dept_id 
        ORDER BY e.hire_date
    ) AS running_total
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
ORDER BY d.dept_name, e.hire_date;


-- Q12: Compare each employee salary to department average
SELECT 
    CONCAT(e.first_name, ' ', e.last_name)  AS full_name,
    d.dept_name,
    e.salary,
    ROUND(AVG(e.salary) OVER (PARTITION BY e.dept_id), 2) AS dept_avg,
    ROUND(e.salary - AVG(e.salary) OVER (PARTITION BY e.dept_id), 2) AS diff_from_avg
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
ORDER BY d.dept_name, diff_from_avg DESC;


-- ============================================
-- SECTION 6: Salary History Analysis
-- ============================================

-- Q13: Total salary increase per employee
SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    COUNT(sh.history_id)                   AS num_raises,
    MIN(sh.old_salary)                     AS starting_salary,
    MAX(sh.new_salary)                     AS current_salary,
    MAX(sh.new_salary) - MIN(sh.old_salary) AS total_increase
FROM employees e
JOIN salary_history sh ON e.emp_id = sh.emp_id
GROUP BY e.emp_id, full_name
ORDER BY total_increase DESC;


-- ============================================
-- SECTION 7: Business Insights
-- ============================================

-- Q14: Department budget utilization (salary vs budget)
SELECT 
    d.dept_name,
    d.budget,
    SUM(e.salary) * 12              AS annual_salary_cost,
    ROUND(
        (SUM(e.salary) * 12 / d.budget) * 100, 2
    )                               AS budget_utilization_pct
FROM departments d
JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name, d.budget
ORDER BY budget_utilization_pct DESC;


-- Q15: Employee tenure in years
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    hire_date,
    TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS years_at_company,
    job_title
FROM employees
ORDER BY years_at_company DESC;
