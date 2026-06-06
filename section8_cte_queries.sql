-- ============================================
-- SECTION 8: CTEs (Common Table Expressions)
-- ============================================

-- Q16: Top earner per department using CTE
WITH ranked_salaries AS (
    SELECT
        e.emp_id,
        CONCAT(e.first_name, ' ', e.last_name)   AS full_name,
        e.salary,
        d.dept_name,
        RANK() OVER (
            PARTITION BY e.dept_id
            ORDER BY e.salary DESC
        ) AS salary_rank
    FROM employees e
    JOIN departments d ON e.dept_id = d.dept_id
)
SELECT dept_name, full_name, salary
FROM ranked_salaries
WHERE salary_rank = 1
ORDER BY salary DESC;


-- Q17: Employees above their department average using CTE
WITH dept_averages AS (
    SELECT
        dept_id,
        ROUND(AVG(salary), 2) AS dept_avg_salary
    FROM employees
    GROUP BY dept_id
)
SELECT
    CONCAT(e.first_name, ' ', e.last_name)  AS full_name,
    e.job_title,
    e.salary,
    d.dept_name,
    da.dept_avg_salary,
    ROUND(e.salary - da.dept_avg_salary, 2) AS above_avg_by
FROM employees e
JOIN departments d   ON e.dept_id = d.dept_id
JOIN dept_averages da ON e.dept_id = da.dept_id
WHERE e.salary > da.dept_avg_salary
ORDER BY above_avg_by DESC;


-- Q18: Department headcount and salary tier breakdown using CTE
WITH salary_tiers AS (
    SELECT
        e.emp_id,
        d.dept_name,
        e.salary,
        CASE
            WHEN e.salary >= 15000 THEN 'High'
            WHEN e.salary >= 8000  THEN 'Mid'
            ELSE                        'Entry'
        END AS salary_tier
    FROM employees e
    JOIN departments d ON e.dept_id = d.dept_id
)
SELECT
    dept_name,
    salary_tier,
    COUNT(*) AS employee_count
FROM salary_tiers
GROUP BY dept_name, salary_tier
ORDER BY dept_name, salary_tier;


-- Q19: Multi-project employees and their total project count using CTE
WITH project_counts AS (
    SELECT
        emp_id,
        COUNT(project_id) AS total_projects
    FROM employee_projects
    GROUP BY emp_id
)
SELECT
    CONCAT(e.first_name, ' ', e.last_name)  AS full_name,
    e.job_title,
    d.dept_name,
    pc.total_projects
FROM employees e
JOIN departments d    ON e.dept_id = d.dept_id
JOIN project_counts pc ON e.emp_id  = pc.emp_id
WHERE pc.total_projects > 1
ORDER BY pc.total_projects DESC;


-- Q20: Running headcount and cumulative payroll by hire date using CTE
WITH hire_sequence AS (
    SELECT
        emp_id,
        CONCAT(first_name, ' ', last_name)  AS full_name,
        hire_date,
        salary,
        ROW_NUMBER() OVER (ORDER BY hire_date)  AS hire_order
    FROM employees
)
SELECT
    hire_order,
    full_name,
    hire_date,
    salary,
    SUM(salary) OVER (ORDER BY hire_date ROWS UNBOUNDED PRECEDING) AS cumulative_payroll
FROM hire_sequence
ORDER BY hire_order;
