--scenario1:
CREATE OR REPLACE FUNCTION CalculateAge(date_of_birth DATE)
RETURNS INT AS $$
DECLARE
    age INT;
BEGIN
    SELECT EXTRACT(YEAR FROM AGE(date_of_birth)) INTO age;
    RETURN age;
END;
$$ LANGUAGE plpgsql;
--scenario2:
CREATE OR REPLACE FUNCTION CalculateMonthlyInstallment(loan_amount NUMERIC, interest_rate NUMERIC, loan_duration_years INT)
RETURNS NUMERIC AS $$
DECLARE
    monthly_rate NUMERIC;
    number_of_payments INT;
    monthly_installment NUMERIC;
BEGIN
    monthly_rate := interest_rate / 12 / 100;
    number_of_payments := loan_duration_years * 12;
    monthly_installment := loan_amount * monthly_rate / (1 - POWER(1 + monthly_rate, -number_of_payments));
    RETURN monthly_installment;
END;
$$ LANGUAGE plpgsql;
--scenario3:
CREATE OR REPLACE FUNCTION HasSufficientBalance(account_id INT, amount NUMERIC)
RETURNS BOOLEAN AS $$
DECLARE
    current_balance NUMERIC;
BEGIN
    SELECT balance INTO current_balance FROM accounts WHERE id = account_id;
    IF current_balance >= amount THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;
