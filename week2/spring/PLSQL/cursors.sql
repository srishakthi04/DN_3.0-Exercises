--scenario1:
DECLARE
    CURSOR transaction_cursor IS
        SELECT customer_id, transaction_date, amount
        FROM Transactions
        WHERE EXTRACT(MONTH FROM transaction_date) = EXTRACT(MONTH FROM SYSDATE)
          AND EXTRACT(YEAR FROM transaction_date) = EXTRACT(YEAR FROM SYSDATE);
    
    transaction_record transaction_cursor%ROWTYPE;
BEGIN
    OPEN transaction_cursor;
    LOOP
        FETCH transaction_cursor INTO transaction_record;
        EXIT WHEN transaction_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Customer ID: ' || transaction_record.customer_id);
        DBMS_OUTPUT.PUT_LINE('Transaction Date: ' || transaction_record.transaction_date);
        DBMS_OUTPUT.PUT_LINE('Amount: ' || transaction_record.amount);
        DBMS_OUTPUT.PUT_LINE('-----------------------------');
    END LOOP;
    CLOSE transaction_cursor;
END;
--scenario2:
DECLARE
    annual_fee CONSTANT NUMERIC := 100.00;
    CURSOR account_cursor IS
        SELECT id, balance
        FROM Accounts;
    
    account_record account_cursor%ROWTYPE;
BEGIN
    OPEN account_cursor;
    LOOP
        FETCH account_cursor INTO account_record;
        EXIT WHEN account_cursor%NOTFOUND;
        
        UPDATE Accounts
        SET balance = balance - annual_fee
        WHERE id = account_record.id;
        
        DBMS_OUTPUT.PUT_LINE('Account ID: ' || account_record.id || ' - Annual fee applied.');
    END LOOP;
    CLOSE account_cursor;
END;

--scenario3:
DECLARE
    new_interest_rate CONSTANT NUMERIC := 5.00;
    CURSOR loan_cursor IS
        SELECT id, interest_rate
        FROM Loans;
    
    loan_record loan_cursor%ROWTYPE;
BEGIN
    OPEN loan_cursor;
    LOOP
        FETCH loan_cursor INTO loan_record;
        EXIT WHEN loan_cursor%NOTFOUND;
        
        UPDATE Loans
        SET interest_rate = new_interest_rate
        WHERE id = loan_record.id;
        
        DBMS_OUTPUT.PUT_LINE('Loan ID: ' || loan_record.id || ' - Interest rate updated.');
    END LOOP;
    CLOSE loan_cursor;
END;
