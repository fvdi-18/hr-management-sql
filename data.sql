-- ============================================
-- Sample Data - HR Management System
-- ============================================

USE hr_management;

-- Departments
INSERT INTO departments (dept_name, location, budget) VALUES
('Engineering',       'Riyadh',  500000.00),
('Human Resources',   'Jeddah',  200000.00),
('Marketing',         'Riyadh',  300000.00),
('Finance',           'Dammam',  250000.00),
('Operations',        'Riyadh',  400000.00);

-- Employees (managers first)
INSERT INTO employees (first_name, last_name, email, phone, hire_date, job_title, salary, dept_id, manager_id) VALUES
('Ahmed',   'Al-Rashid',  'ahmed.rashid@company.com',   '0501111111', '2018-03-15', 'Engineering Manager',  18000.00, 1, NULL),
('Sara',    'Al-Otaibi',  'sara.otaibi@company.com',    '0502222222', '2019-06-01', 'HR Manager',           15000.00, 2, NULL),
('Khalid',  'Al-Zahrani', 'khalid.zahrani@company.com', '0503333333', '2017-01-10', 'Finance Director',     20000.00, 4, NULL),
('Fatima',  'Al-Ghamdi',  'fatima.ghamdi@company.com',  '0504444444', '2020-09-20', 'Marketing Manager',    16000.00, 3, NULL),
('Omar',    'Al-Harbi',   'omar.harbi@company.com',     '0505555555', '2019-11-05', 'Operations Manager',   17000.00, 5, NULL);

INSERT INTO employees (first_name, last_name, email, phone, hire_date, job_title, salary, dept_id, manager_id) VALUES
('Youssef', 'Al-Shammari','youssef.s@company.com',      '0506666666', '2021-02-14', 'SQL Developer',        12000.00, 1, 1),
('Nora',    'Al-Qahtani', 'nora.qahtani@company.com',   '0507777777', '2021-07-19', 'Junior Developer',      9000.00, 1, 1),
('Tariq',   'Bin-Laden',  'tariq.bl@company.com',       '0508888888', '2022-03-01', 'HR Specialist',         8500.00, 2, 2),
('Mona',    'Al-Dosari',  'mona.dosari@company.com',    '0509999999', '2020-05-12', 'Marketing Specialist', 10000.00, 3, 4),
('Hassan',  'Al-Mutairi', 'hassan.m@company.com',       '0511111111', '2023-01-08', 'Financial Analyst',     9500.00, 4, 3),
('Layla',   'Al-Anazi',   'layla.anazi@company.com',    '0512222222', '2022-08-22', 'Operations Analyst',    9000.00, 5, 5),
('Faisal',  'Al-Subaie',  'faisal.s@company.com',       '0513333333', '2021-12-01', 'Senior Developer',     14000.00, 1, 1),
('Reem',    'Al-Bishi',   'reem.bishi@company.com',     '0514444444', '2023-06-15', 'Data Analyst',         11000.00, 1, 1);

-- Projects
INSERT INTO projects (project_name, start_date, end_date, status, dept_id) VALUES
('ERP System Upgrade',        '2024-01-01', '2024-12-31', 'Active',    1),
('HR Digital Transformation', '2024-03-01', '2024-09-30', 'Completed', 2),
('Marketing Campaign Q4',     '2024-10-01', '2024-12-31', 'Active',    3),
('Budget Forecasting 2025',   '2024-11-01', '2025-01-31', 'Active',    4),
('Network Monitoring System', '2024-06-01', '2025-03-31', 'Active',    1);

-- Employee Projects
INSERT INTO employee_projects (emp_id, project_id, role) VALUES
(1,  1, 'Project Lead'),
(6,  1, 'SQL Developer'),
(7,  1, 'Junior Developer'),
(12, 1, 'Senior Developer'),
(13, 1, 'Data Analyst'),
(2,  2, 'Project Lead'),
(8,  2, 'HR Specialist'),
(4,  3, 'Project Lead'),
(9,  3, 'Marketing Specialist'),
(3,  4, 'Project Lead'),
(10, 4, 'Financial Analyst'),
(6,  5, 'SQL Developer'),
(13, 5, 'Data Analyst');

-- Salary History
INSERT INTO salary_history (emp_id, old_salary, new_salary, change_date, reason) VALUES
(6,  10000.00, 12000.00, '2023-01-01', 'Annual raise'),
(7,   7500.00,  9000.00, '2023-06-01', 'Performance bonus'),
(12, 12000.00, 14000.00, '2023-03-01', 'Promotion to Senior'),
(9,   8500.00, 10000.00, '2024-01-01', 'Annual raise'),
(10,  8000.00,  9500.00, '2024-01-01', 'Annual raise');
