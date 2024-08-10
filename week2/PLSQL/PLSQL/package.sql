--scenario1:
CREATE OR REPLACE PACKAGE BODY CustomerManagement AS

    PROCEDURE AddCustomer(p_name VARCHAR2, p_dob DATE, p_balance NUMERIC) IS
    BEGIN
        INSERT INTO Customers (name, date_of_birth, balance)
        VALUES (p_name, p_dob, p_balance);
    END AddCustomer;

    PROCEDURE UpdateCustomer(p_id INT, p_name VARCHAR2, p_dob DATE) IS
    BEGIN
        UPDATE Customers
        SET name = p_name, date_of_birth = p_dob
        WHERE id = p_id;
    END UpdateCustomer;

    FUNCTION GetCustomerBalance(p_id INT) RETURN NUMERIC IS
        v_balance NUMERIC;
    BEGIN
        SELECT balance INTO v_balance
        FROM Customers
        WHERE id = p_id;
        RETURN v_balance;
    END GetCustomerBalance;

END CustomerManagement;
--scenario2:CREATE OR REPLACE PACKAGE BODY EmployeeManagement AS

    PROCEDURE HireEmployee(p_name VARCHAR2, p_position VARCHAR2, p_salary NUMERIC) IS
    BEGIN
        INSERT INTO Employees (name, position, salary)
        VALUES (p_name, p_position, p_salary);
    END HireEmployee;

    PROCEDURE UpdateEmployee(p_id INT, p_name VARCHAR2, p_position VARCHAR2, p_salary NUMERIC) IS
    BEGIN
        UPDATE Employees
        SET name = p_name, position = p_position, salary = p_salary
        WHERE id = p_id;
    END UpdateEmployee;

    FUNCTION CalculateAnnualSalary(p_id INT) RETURN NUMERIC IS
        v_salary NUMERIC;
    BEGIN
        SELECT salary * 12 INTO v_salary
        FROM Employees
        WHERE id = p_id;
        RETURN v_salary;
    END CalculateAnnualSalary;

END EmployeeManagement;
--scenario3:
CREATE OR REPLACE PACKAGE BODY AccountOperations AS

    PROCEDURE OpenAccount(p_customer_id INT, p_initial_balance NUMERIC) IS
    BEGIN
        INSERT INTO Accounts (customer_id, balance)
        VALUES (p_customer_id, p_initial_balance);
    END OpenAccount;

    PROCEDURE CloseAccount(p_account_id INT) IS
    BEGIN
        DELETE FROM Accounts
        WHERE id = p_account_id;
    END CloseAccount;

    FUNCTION GetTotalBalance(p_customer_id INT) RETURN NUMERIC IS
        v_total_balance NUMERIC;
    BEGIN
        SELECT SUM(balance) INTO v_total_balance
        FROM Accounts
        WHERE customer_id = p_customer_id;
        RETURN v_total_balance;
    END GetTotalBalance;

END AccountOperations;

