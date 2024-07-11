# Banking Enterprise Database

## Project Overview
This project involves designing and implementing a database for a banking enterprise. The database stores information about branches, employees, customers, and accounts. The main tasks include creating an Entity-Relationship Diagram (ERD), converting the ERD into a normalized relational schema, implementing SQL scripts for table creation and data insertion, and writing SQL queries for data extraction and manipulation.

## Files in the Project

### 1. `create_and_insert.sql`
This SQL script contains the statements to create the necessary tables for the banking enterprise database and to insert initial data into those tables.

#### Table Creation
- **Branch**: Stores information about bank branches, including a unique identifier, branch name, and city.
- **Employee**: Stores information about employees, including a unique identifier, employee name, manager ID, and branch ID.
- **Customer**: Stores information about customers, including a unique identifier, customer name, address, and banker ID.
- **Account**: Stores information about accounts, including a unique identifier, account type, and balance.
- **Account_Customer**: Handles the many-to-many relationship between customers and accounts, storing account IDs and customer IDs.

#### Data Insertion
- Inserts sample data into the `Branch`, `Employee`, `Customer`, `Account`, and `Account_Customer` tables.

### 2. `queries.sql`
This SQL script contains queries for data extraction and manipulation. The queries demonstrate the flexibility and functionality of the database design by retrieving information from multiple tables.

#### Queries
- **Query 1**: Lists all customers with their account types and balances.
- **Query 2**: Lists all employees and their respective branches.
- **Query 3**: Lists all accounts and the customers associated with them.
- **Query 4**: Lists all branches with their employees and managers.

## How to Use

### Setting Up the Database
1. **Create a Database** (if not already created):
    ```sql
    CREATE DATABASE bank;
    ```

2. **Execute the `create_and_insert.sql` Script**:
    ```bash
    mysql -u [username] -p < create_and_insert.sql
    ```

3. **Execute the `queries.sql` Script**:
    ```bash
    mysql -u [username] -p < queries.sql
    ```

Make sure to replace `[username]` with your actual MySQL username.

### Understanding the Data
- The **Branch** table stores information about different branches of the bank.
- The **Employee** table stores information about bank employees and their managers.
- The **Customer** table stores information about customers and their assigned personal bankers.
- The **Account** table stores information about different types of accounts and their balances.
- The **Account_Customer** table establishes the many-to-many relationship between customers and accounts.

### Query Outputs
1. **Query 1**: Retrieves the names of customers along with the types and balances of their accounts.
2. **Query 2**: Retrieves the names of employees and the branches they work in.
3. **Query 3**: Retrieves the IDs and types of accounts along with the names of the customers associated with those accounts.
4. **Query 4**: Retrieves the names of branches along with the names of the employees and their managers.

## Entity-Relationship Diagram (ERD)

### Entities:
1. **Branch**: 
   - **Attributes**: BranchID (PK), BranchName, City

2. **Employee**: 
   - **Attributes**: EmployeeID (PK), EmployeeName, ManagerID (FK), BranchID (FK)

3. **Customer**: 
   - **Attributes**: CustomerID (PK), CustomerName, Street, City, BankerID (FK)

4. **Account**: 
   - **Attributes**: AccountID (PK), AccountType, Balance

5. **Account_Customer**: 
   - **Attributes**: AccountID (FK), CustomerID (FK)

### Relationships:
1. **Branch** (1) ↔ (M) **Employee**
2. **Employee** (1) ↔ (M) **Customer**
3. **Customer** (M) ↔ (M) **Account** (through **Account_Customer**)

### ER Diagram

Here is a textual representation of the ER diagram:

![Screenshot 2024-07-10 081646](https://github.com/IngaPosiunaite/Banking-Enterprise-Database-SQL/assets/119749457/51624a54-2e43-451c-bcde-4bc748334db5)
