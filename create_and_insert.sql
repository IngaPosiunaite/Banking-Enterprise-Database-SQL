-- This script creates the tables for the banking enterprise database
-- and inserts initial data into those tables.

-- Drop the database if it exists
DROP DATABASE IF EXISTS bank;

-- Create the database
CREATE DATABASE bank;
USE bank;

-- Create the Branch table
CREATE TABLE Branch (
    BranchID INT PRIMARY KEY, -- Unique identifier for each branch
    BranchName VARCHAR(100) NOT NULL, -- Name of the branch
    City VARCHAR(100) NOT NULL -- City where the branch is located
);

-- Create the Employee table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY, -- Unique identifier for each employee
    EmployeeName VARCHAR(100) NOT NULL, -- Name of the employee
    ManagerID INT, -- ID of the manager (references EmployeeID)
    BranchID INT, -- ID of the branch where the employee works (references BranchID)
    FOREIGN KEY (ManagerID) REFERENCES Employee(EmployeeID), -- Foreign key constraint for ManagerID
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID) -- Foreign key constraint for BranchID
);

-- Create the Customer table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY, -- Unique identifier for each customer
    CustomerName VARCHAR(100) NOT NULL, -- Name of the customer
    Street VARCHAR(100) NOT NULL, -- Street address of the customer
    City VARCHAR(100) NOT NULL, -- City where the customer lives
    BankerID INT, -- ID of the personal banker (references EmployeeID)
    FOREIGN KEY (BankerID) REFERENCES Employee(EmployeeID) -- Foreign key constraint for BankerID
);

-- Create the Account table
CREATE TABLE Account (
    AccountID INT PRIMARY KEY, -- Unique identifier for each account
    AccountType VARCHAR(50) NOT NULL, -- Type of the account (savings or current)
    Balance DECIMAL(15, 2) NOT NULL -- Balance of the account
);

-- Create the Account_Customer table to handle the many-to-many relationship between customers and accounts
CREATE TABLE Account_Customer (
    AccountID INT, -- ID of the account (references AccountID)
    CustomerID INT, -- ID of the customer (references CustomerID)
    PRIMARY KEY (AccountID, CustomerID), -- Composite primary key for the relationship
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID), -- Foreign key constraint for AccountID
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) -- Foreign key constraint for CustomerID
);

-- Insert data into the Branch table
INSERT INTO Branch (BranchID, BranchName, City) VALUES 
(1, 'Main Branch', 'New York'), -- Main branch located in New York
(2, 'East Branch', 'Boston'), -- East branch located in Boston
(3, 'West Branch', 'Los Angeles'); -- West branch located in Los Angeles

-- Insert data into the Employee table
INSERT INTO Employee (EmployeeID, EmployeeName, ManagerID, BranchID) VALUES 
(1, 'John Doe', NULL, 1), -- John Doe is the manager of Main Branch
(2, 'Jane Smith', 1, 1), -- Jane Smith works at Main Branch and is managed by John Doe
(3, 'Alice Johnson', 2, 2); -- Alice Johnson works at East Branch and is managed by Jane Smith

-- Insert data into the Customer table
INSERT INTO Customer (CustomerID, CustomerName, Street, City, BankerID) VALUES 
(1, 'Charlie Brown', '123 Main St', 'New York', 2), -- Charlie Brown lives in New York and is managed by Jane Smith
(2, 'Lucy Van Pelt', '456 Oak St', 'Boston', 3); -- Lucy Van Pelt lives in Boston and is managed by Alice Johnson

-- Insert data into the Account table
INSERT INTO Account (AccountID, AccountType, Balance) VALUES 
(1, 'Savings', 1000.00), -- Savings account with a balance of 1000.00
(2, 'Current', 1500.00); -- Current account with a balance of 1500.00

-- Insert data into the Account_Customer table to establish the relationships
INSERT INTO Account_Customer (AccountID, CustomerID) VALUES 
(1, 1), -- Charlie Brown has a savings account
(2, 1), -- Charlie Brown has a current account
(1, 2); -- Lucy Van Pelt has a savings account
