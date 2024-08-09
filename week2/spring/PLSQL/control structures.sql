--scenario1
DECLARE
    v_customer_id customers.customer_id%TYPE;
    v_age customers.age%TYPE;
    v_loan_interest_rate customers.loan_interest_rate%TYPE;
BEGIN
    FOR customer IN (SELECT customer_id, age, loan_interest_rate FROM customers) LOOP
        v_customer_id := customer.customer_id;
        v_age := customer.age;
        v_loan_interest_rate := customer.loan_interest_rate;

        IF v_age > 60 THEN
            UPDATE customers
            SET loan_interest_rate = v_loan_interest_rate - (v_loan_interest_rate * 0.01)
            WHERE customer_id = v_customer_id;
        END IF;
    END LOOP;
    COMMIT;
END;
--scenario2
DECLARE
    v_customer_id customers.customer_id%TYPE;
    v_balance customers.balance%TYPE;
BEGIN
    FOR customer IN (SELECT customer_id, balance FROM customers) LOOP
        v_customer_id := customer.customer_id;
        v_balance := customer.balance;

        IF v_balance > 10000 THEN
            UPDATE customers
            SET IsVIP = TRUE
            WHERE customer_id = v_customer_id;
        END IF;
    END LOOP;
    COMMIT;
END;
--scenario3
DECLARE
    v_customer_id loans.customer_id%TYPE;
    v_due_date loans.due_date%TYPE;
BEGIN
    FOR loan IN (SELECT customer_id, due_date FROM loans WHERE due_date BETWEEN SYSDATE AND SYSDATE + 30) LOOP
        v_customer_id := loan.customer_id;
        v_due_date := loan.due_date;

        DBMS_OUTPUT.PUT_LINE('Reminder: Your loan is due on ' || TO_CHAR(v_due_date, 'DD-MON-YYYY') || '.');
    END LOOP;
END;

