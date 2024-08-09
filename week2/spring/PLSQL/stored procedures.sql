--scenario:
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
    v_account_id savings_accounts.account_id%TYPE;
    v_balance savings_accounts.balance%TYPE;
BEGIN
    FOR account IN (SELECT account_id, balance FROM savings_accounts) LOOP
        v_account_id := account.account_id;
        v_balance := account.balance;

        UPDATE savings_accounts
        SET balance = v_balance + (v_balance * 0.01)
        WHERE account_id = v_account_id;
    END LOOP;
    COMMIT;
END;
--scenario2:
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(p_department_id IN employees.department_id%TYPE, p_bonus_percentage IN NUMBER) IS
    v_employee_id employees.employee_id%TYPE;
    v_salary employees.salary%TYPE;
BEGIN
    FOR employee IN (SELECT employee_id, salary FROM employees WHERE department_id = p_department_id) LOOP
        v_employee_id := employee.employee_id;
        v_salary := employee.salary;

        UPDATE employees
        SET salary = v_salary + (v_salary * p_bonus_percentage / 100)
        WHERE employee_id = v_employee_id;
    END LOOP;
    COMMIT;
END;
--scenario3:
CREATE OR REPLACE PROCEDURE TransferFunds(p_account_from IN accounts.account_id%TYPE, p_account_to IN accounts.account_id%TYPE, p_amount IN accounts.balance%TYPE) IS
    v_balance accounts.balance%TYPE;
BEGIN
    -- Check if the source account has sufficient balance
    SELECT balance INTO v_balance FROM accounts WHERE account_id = p_account_from;
    IF v_balance < p_amount THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds in the source account.');
    END IF;

    -- Perform the transfer
    UPDATE accounts SET balance = balance - p_amount WHERE account_id = p_account_from;
    UPDATE accounts SET balance = balance + p_amount WHERE account_id = p_account_to;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
