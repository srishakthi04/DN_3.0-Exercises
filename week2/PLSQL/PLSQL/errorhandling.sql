DECLARE
    v_account_from accounts.account_id%TYPE;
    v_account_to accounts.account_id%TYPE;
    v_amount accounts.balance%TYPE;
    v_employee_id employees.employee_id%TYPE;
    v_percentage employees.salary%TYPE;
    v_customer_id customers.customer_id%TYPE;
    v_customer_name customers.name%TYPE;
    v_customer_age customers.age%TYPE;
    v_balance accounts.balance%TYPE;
    v_salary employees.salary%TYPE;
    v_error_message VARCHAR2(4000);
BEGIN
    -- Scenario 1: 
    PROCEDURE SafeTransferFunds(p_account_from IN accounts.account_id%TYPE, p_account_to IN accounts.account_id%TYPE, p_amount IN accounts.balance%TYPE) IS
    BEGIN
        BEGIN
            SELECT balance INTO v_balance FROM accounts WHERE account_id = p_account_from;
            IF v_balance < p_amount THEN
                RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds in the source account.');
            END IF;

            UPDATE accounts SET balance = balance - p_amount WHERE account_id = p_account_from;
            UPDATE accounts SET balance = balance + p_amount WHERE account_id = p_account_to;

            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                v_error_message := SQLERRM;
                ROLLBACK;
                INSERT INTO error_log (error_message) VALUES (v_error_message);
                DBMS_OUTPUT.PUT_LINE('Error: ' || v_error_message);
        END;
    END SafeTransferFunds;

    -- Scenario 2: 
    PROCEDURE UpdateSalary(p_employee_id IN employees.employee_id%TYPE, p_percentage IN NUMBER) IS
    BEGIN
        BEGIN
            SELECT salary INTO v_salary FROM employees WHERE employee_id = p_employee_id;
            UPDATE employees SET salary = salary + (salary * p_percentage / 100) WHERE employee_id = p_employee_id;
            COMMIT;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                v_error_message := 'Employee ID ' || p_employee_id || ' does not exist.';
                INSERT INTO error_log (error_message) VALUES (v_error_message);
                DBMS_OUTPUT.PUT_LINE('Error: ' || v_error_message);
            WHEN OTHERS THEN
                v_error_message := SQLERRM;
                ROLLBACK;
                INSERT INTO error_log (error_message) VALUES (v_error_message);
                DBMS_OUTPUT.PUT_LINE('Error: ' || v_error_message);
        END;
    END UpdateSalary;

    -- Scenario 3:
    PROCEDURE AddNewCustomer(p_customer_id IN customers.customer_id%TYPE, p_name IN customers.name%TYPE, p_age IN customers.age%TYPE) IS
    BEGIN
        BEGIN
            INSERT INTO customers (customer_id, name, age) VALUES (p_customer_id, p_name, p_age);
            COMMIT;
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                v_error_message := 'Customer ID ' || p_customer_id || ' already exists.';
                INSERT INTO error_log (error_message) VALUES (v_error_message);
                DBMS_OUTPUT.PUT_LINE('Error: ' || v_error_message);
            WHEN OTHERS THEN
                v_error_message := SQLERRM;
                ROLLBACK;
                INSERT INTO error_log (error_message) VALUES (v_error_message);
                DBMS_OUTPUT.PUT_LINE('Error: ' || v_error_message);
        END;
    END AddNewCustomer;
END;
