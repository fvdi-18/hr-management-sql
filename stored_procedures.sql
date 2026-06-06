-- ============================================
-- HR Management - Stored Procedures
-- Author: Fadi
-- Description: Reusable procedures for common HR operations
-- ============================================

USE hr_management;

DELIMITER $$

-- ============================================
-- PROCEDURE 1: Give Salary Raise
-- Applies a percentage raise to an employee
-- and logs it to salary_history automatically
-- ============================================
CREATE PROCEDURE sp_give_raise (
    IN  p_emp_id       INT,
    IN  p_raise_pct    DECIMAL(5,2),
    IN  p_reason       VARCHAR(255)
)
BEGIN
    DECLARE v_current_salary DECIMAL(10,2);
    DECLARE v_new_salary     DECIMAL(10,2);

    -- Get current salary
    SELECT salary INTO v_current_salary
    FROM employees
    WHERE emp_id = p_emp_id;

    -- Validate employee exists
    IF v_current_salary IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee not found.';
    END IF;

    -- Calculate new salary
    SET v_new_salary = ROUND(v_current_salary * (1 + p_raise_pct / 100), 2);

    -- Update employee salary
    UPDATE employees
    SET salary = v_new_salary
    WHERE emp_id = p_emp_id;

    -- Log the change to salary_history
    INSERT INTO salary_history (emp_id, old_salary, new_salary, change_date, reason)
    VALUES (p_emp_id, v_current_salary, v_new_salary, CURDATE(), p_reason);

    SELECT
        p_emp_id               AS emp_id,
        v_current_salary       AS old_salary,
        v_new_salary           AS new_salary,
        p_raise_pct            AS raise_pct_applied,
        p_reason               AS reason;
END $$


-- ============================================
-- PROCEDURE 2: Get Department Report
-- Returns full stats for a given department
-- ============================================
CREATE PROCEDURE sp_department_report (
    IN p_dept_name VARCHAR(100)
)
BEGIN
    -- Department summary
    SELECT
        d.dept_name,
        d.location,
        d.budget,
        COUNT(e.emp_id)                              AS headcount,
        ROUND(AVG(e.salary), 2)                      AS avg_salary,
        SUM(e.salary) * 12                           AS annual_payroll,
        ROUND((SUM(e.salary) * 12 / d.budget) * 100, 2) AS budget_used_pct
    FROM departments d
    JOIN employees e ON d.dept_id = e.dept_id
    WHERE d.dept_name = p_dept_name
    GROUP BY d.dept_id, d.dept_name, d.location, d.budget;

    -- Employee list in that department
    SELECT
        CONCAT(e.first_name, ' ', e.last_name)  AS full_name,
        e.job_title,
        e.salary,
        e.hire_date,
        TIMESTAMPDIFF(YEAR, e.hire_date, CURDATE()) AS tenure_years
    FROM employees e
    JOIN departments d ON e.dept_id = d.dept_id
    WHERE d.dept_name = p_dept_name
    ORDER BY e.salary DESC;
END $$


-- ============================================
-- PROCEDURE 3: Transfer Employee
-- Moves an employee to a different department
-- ============================================
CREATE PROCEDURE sp_transfer_employee (
    IN p_emp_id      INT,
    IN p_new_dept_id INT
)
BEGIN
    DECLARE v_old_dept_id   INT;
    DECLARE v_old_dept_name VARCHAR(100);
    DECLARE v_new_dept_name VARCHAR(100);

    -- Get current department
    SELECT dept_id INTO v_old_dept_id
    FROM employees
    WHERE emp_id = p_emp_id;

    IF v_old_dept_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee not found.';
    END IF;

    -- Get department names for the result message
    SELECT dept_name INTO v_old_dept_name
    FROM departments WHERE dept_id = v_old_dept_id;

    SELECT dept_name INTO v_new_dept_name
    FROM departments WHERE dept_id = p_new_dept_id;

    IF v_new_dept_name IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Target department not found.';
    END IF;

    -- Perform the transfer
    UPDATE employees
    SET dept_id = p_new_dept_id
    WHERE emp_id = p_emp_id;

    SELECT
        p_emp_id        AS emp_id,
        v_old_dept_name AS transferred_from,
        v_new_dept_name AS transferred_to,
        NOW()           AS transfer_date;
END $$

DELIMITER ;
