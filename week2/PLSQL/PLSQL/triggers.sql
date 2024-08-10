--scenario1:
Triggers

Scenario 1: Automatically update the last modified date when a customer's record is updated.
o	Question: Write a trigger UpdateCustomerLastModified that updates the LastModified column of the Customers table to the current date whenever a customer's record is updated.
Scenario 2: Maintain an audit log for all transactions.
o	Question: Write a trigger LogTransaction that inserts a record into an AuditLog table whenever a transaction is inserted into the Transactions table.

Scenario 3: Enforce business rules on deposits and withdrawals.
o	Question: Write a trigger CheckTransactionRules that ensures withdrawals do not exceed the balance and deposits are positive before inserting a record into the Transactions table.
--scenario2:
CREATE TRIGGER LogTransaction
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    DECLARE transaction_id INT;
    DECLARE account_id INT;
    DECLARE amount NUMERIC;
    DECLARE transaction_date DATE;
    
    SET transaction_id = NEW.id;
    SET account_id = NEW.account_id;
    SET amount = NEW.amount;
    SET transaction_date = NEW.transaction_date;
    
    INSERT INTO AuditLog (transaction_id, account_id, amount, transaction_date)
    VALUES (transaction_id, account_id, amount, transaction_date);
END;

--scenario3:
CREATE TRIGGER CheckTransactionRules
BEFORE INSERT ON Transactions
FOR EACH ROW
BEGIN
    DECLARE current_balance NUMERIC;
    DECLARE transaction_amount NUMERIC;
    
    SELECT balance INTO current_balance FROM accounts WHERE id = NEW.account_id;
    SET transaction_amount = NEW.amount;
    
    IF transaction_amount < 0 AND current_balance + transaction_amount < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient balance for withdrawal';
    ELSIF transaction_amount <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Deposit amount must be positive';
    END IF;
END;
