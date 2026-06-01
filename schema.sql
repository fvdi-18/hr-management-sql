-- ============================================
-- Employee & Department Management System
-- Author: Fadi
-- Description: A complete HR database schema
-- ============================================

-- Create Database
CREATE DATABASE IF NOT EXISTS hr_management;
USE hr_management;

-- ============================================
-- Table 1: Departments
-- ============================================
CREATE TABLE departments (
    dept_id     INT PRIMARY KEY AUTO_INCREMENT,
    dept_name   VARCHAR(100) NOT NULL,
    location    VARCHAR(100),
    budget      DECIMAL(15, 2),
    created_at  DATE DEFAULT (CURRENT_DATE)
);

-- ============================================
-- Table 2: Employees
-- ============================================
CREATE TABLE employees (
    emp_id      INT PRIMARY KEY AUTO_INCREMENT,
    first_name  VARCHAR(50) NOT NULL,
    last_name   VARCHAR(50) NOT NULL,
    email       VARCHAR(100) UNIQUE NOT NULL,
    phone       VARCHAR(20),
    hire_date   DATE NOT NULL,
    job_title   VARCHAR(100),
    salary      DECIMAL(10, 2),
    dept_id     INT,
    manager_id  INT,
    FOREIGN KEY (dept_id)    REFERENCES departments(dept_id),
    FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);

-- ============================================
-- Table 3: Projects
-- ============================================
CREATE TABLE projects (
    project_id   INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(150) NOT NULL,
    start_date   DATE,
    end_date     DATE,
    status       ENUM('Active', 'Completed', 'On Hold') DEFAULT 'Active',
    dept_id      INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- ============================================
-- Table 4: Employee_Projects (Many-to-Many)
-- ============================================
CREATE TABLE employee_projects (
    emp_id     INT,
    project_id INT,
    role       VARCHAR(100),
    PRIMARY KEY (emp_id, project_id),
    FOREIGN KEY (emp_id)     REFERENCES employees(emp_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

-- ============================================
-- Table 5: Salary History
-- ============================================
CREATE TABLE salary_history (
    history_id  INT PRIMARY KEY AUTO_INCREMENT,
    emp_id      INT,
    old_salary  DECIMAL(10, 2),
    new_salary  DECIMAL(10, 2),
    change_date DATE DEFAULT (CURRENT_DATE),
    reason      VARCHAR(200),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);
