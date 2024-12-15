DROP TABLE IF EXISTS Manages CASCADE;
DROP TABLE IF EXISTS Works CASCADE;
DROP TABLE IF EXISTS Company CASCADE;
DROP TABLE IF EXISTS Employee CASCADE;

-- Create Employee table
CREATE TABLE Employee (
    employee_name VARCHAR(50) PRIMARY KEY,
    street VARCHAR(100),
    city VARCHAR(50)
);

-- Create Works table
CREATE TABLE Works (
    employee_name VARCHAR(50),
    company_name VARCHAR(50),
    salary DECIMAL(10, 2),
    PRIMARY KEY (employee_name, company_name),
    FOREIGN KEY (employee_name) REFERENCES Employee(employee_name)
);

-- Create Company table
CREATE TABLE Company (
    company_name VARCHAR(50) PRIMARY KEY,
    city VARCHAR(50)
);

-- Create Manages table
CREATE TABLE Manages (
    employee_name VARCHAR(50),
    manager_name VARCHAR(50),
    PRIMARY KEY (employee_name, manager_name),
    FOREIGN KEY (employee_name) REFERENCES Employee(employee_name),
    FOREIGN KEY (manager_name) REFERENCES Employee(employee_name)
);

-- Insert data into Employee table
INSERT INTO Employee (employee_name, street, city) VALUES
('Alice', '123 Main St', 'New York'),
('Bob', '456 Maple Ave', 'Los Angeles'),
('Charlie', '789 Oak St', 'New York'),
('David', '321 Pine Rd', 'Chicago'),
('Eve', '654 Elm St', 'New York'),
('Frank', '987 Cedar St', 'Los Angeles');

-- Insert data into Works table
INSERT INTO Works (employee_name, company_name, salary) VALUES
('Alice', 'First Bank Corporation', 120000.00),
('Bob', 'Tech Solutions', 95000.00),
('Charlie', 'First Bank Corporation', 110000.00),
('David', 'Financial Group', 105000.00),
('Eve', 'First Bank Corporation', 115000.00),
('Frank', 'Tech Solutions', 98000.00);

-- Insert data into Company table
INSERT INTO Company (company_name, city) VALUES
('First Bank Corporation', 'New York'),
('Tech Solutions', 'Los Angeles'),
('Financial Group', 'Chicago');

-- Insert data into Manages table
INSERT INTO Manages (employee_name, manager_name) VALUES
('Alice', 'Charlie'),
('Bob', 'Frank'),
('Charlie', 'Alice'),
('David', 'Charlie'),
('Eve', 'Charlie');


-- a. Find the names of all employees who work for “First Bank Corporation.”

SELECT E.employee_name
FROM Employee E
JOIN Works W ON E.employee_name = W.employee_name
WHERE W.company_name = 'First Bank Corporation';

-- b. Find all employees in the database who live in the same cities as the companies for which they work.

SELECT E.employee_name
FROM Employee E
JOIN Works W ON E.employee_name = W.employee_name
JOIN Company C ON W.company_name = C.company_name
WHERE E.city = C.city;

-- c. Find all employees in the database who live in the same cities and on the same streets as do their managers.

SELECT E.employee_name
FROM Employee E
JOIN Manages M ON E.employee_name = M.employee_name
JOIN Employee Mgr ON M.manager_name = Mgr.employee_name
WHERE E.city = Mgr.city AND E.street = Mgr.street;