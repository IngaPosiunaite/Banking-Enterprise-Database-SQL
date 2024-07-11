-- Select the database
USE bank;

-- Query 1: List all customers with their account types and balances
-- This query retrieves the names of customers along with the types and balances of their accounts.
SELECT 
    Customer.CustomerName,
    Account.AccountType,
    Account.Balance
FROM 
    Customer
JOIN 
    Account_Customer ON Customer.CustomerID = Account_Customer.CustomerID
JOIN 
    Account ON Account_Customer.AccountID = Account.AccountID;

-- Query 2: List all employees and their respective branches
-- This query retrieves the names of employees and the branches they work in.
SELECT 
    Employee.EmployeeName,
    Branch.BranchName
FROM 
    Employee
JOIN 
    Branch ON Employee.BranchID = Branch.BranchID;

-- Query 3: List all accounts and the customers associated with them
-- This query retrieves the IDs and types of accounts along with the names of the customers associated with those accounts.
SELECT 
    Account.AccountID,
    Account.AccountType,
    Customer.CustomerName
FROM 
    Account
JOIN 
    Account_Customer ON Account.AccountID = Account_Customer.AccountID
JOIN 
    Customer ON Account_Customer.CustomerID = Customer.CustomerID;

-- Query 4: List all branches with their employees and managers
-- This query retrieves the names of branches along with the names of the employees and their managers.
SELECT 
    Branch.BranchName,
    Employee.EmployeeName AS Employee,
    Manager.EmployeeName AS Manager
FROM 
    Branch
JOIN 
    Employee ON Branch.BranchID = Employee.BranchID
LEFT JOIN 
    Employee AS Manager ON Employee.ManagerID = Manager.EmployeeID;

