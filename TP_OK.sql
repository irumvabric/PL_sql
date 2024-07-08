
-- Create Customer table 
CREATE TABLE Customer 
(     CustomerID INT PRIMARY KEY,     
Name VARCHAR2(255),     
Address VARCHAR2(255),     
Contact VARCHAR2(255),     
Username VARCHAR2(50) UNIQUE,     
Password VARCHAR2(255) 
);


-- Create Account table 
CREATE TABLE Account (     
AccountID INT PRIMARY KEY ,     
CustomerID INT,     
Type VARCHAR2(50),     
Balance DECIMAL(10, 2),     
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) 
);

CREATE  TABLE Transaction (
      TransactionID INT PRIMARY KEY,
      AccountID INT,
     Type VARCHAR2(10), -- Using VARCHAR2 with check constraint
      Amount DECIMAL(10, 2),
      Timestamp TIMESTAMP,
      FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
    );

-- Create Beneficiary table 
CREATE TABLE Beneficiary 
(     
BeneficiaryID VARCHAR2(90) PRIMARY KEY ,     
CustomerID INT,     
Name VARCHAR(255),     
AccountNumber VARCHAR(50),     
BankDetails VARCHAR(255),     
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) 
);
------------------------Trigger Auto increment-------------------------
create or replace trigger cleauto_transaction
before insert on Transaction
for each row
declare
nombre integer;
nouveaucle integer;
premierCle exception;
begin
select count(*) into nombre from Transaction;
if nombre=0 then
raise premierCle;-- Premiere insertion
end if;
select max(TransactionID) into nouveaucle from Transaction;
:new.TransactionID := nouveaucle+1;
exception
when premierCle then :new.TransactionID := 1;
end;
/


------------------------Trigger Auto id Account--------------------------
create or replace trigger cleauto_Customer
before insert on Customer
for each row
declare
nombre integer;
nouveaucle integer;
premierCle exception;
begin
select count(*) into nombre from Customer;
if nombre=0 then
raise premierCle;-- Premiere insertion
end if;
select max(CustomerID) into nouveaucle from Customer;
:new.CustomerID := nouveaucle+1;
exception
when premierCle then :new.CustomerID := 1;
end;
/



--------------------------------------------------------------------------


create or replace trigger cleauto_Beneficiary
before insert on Beneficiary
for each row
declare
nombre integer;
nouveaucle integer;
premierCle exception;
begin
--select count(*) into nombre from Transaction;
--if nombre=0 then
--raise premierCle;-- Premiere insertion
--end if;
select count(BeneficiaryID) into nouveaucle from Transaction;
:new.BeneficiaryID := 'C-'||SUBSTR(new.Name, 1, 2)||'-'||nouveaucle||'-'||TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY'));
-- :new.BeneficiaryID := nouveaucle+1;
--exception
--when premierCle then :new.CustomerID := 1;
end;
/




  ------------------------------------Update Account Balance---------------------------------------------


CREATE OR REPLACE TRIGGER update_account_balance
AFTER INSERT ON Transaction
FOR EACH ROW
DECLARE
    v_balance Account.Balance%TYPE;
BEGIN
    -- Get the current balance of the account
    SELECT Balance INTO v_balance
    FROM Account
    WHERE AccountID = :NEW.AccountID
    FOR UPDATE;

    -- Check for insufficient funds on withdrawal
    IF :NEW.Type = 'Withdrawal' AND v_balance < :NEW.Amount THEN
        RAISE_APPLICATION_ERROR(-20002, 'Insufficient funds for withdrawal.');
    END IF;

    -- Update the balance based on the transaction type
    IF :NEW.Type = 'Deposit' THEN
        v_balance := v_balance + :NEW.Amount;
    ELSIF :NEW.Type = 'Withdrawal' THEN
        v_balance := v_balance - :NEW.Amount;
    ELSE
        RAISE_APPLICATION_ERROR(-20001, 'Invalid transaction type: ' || :NEW.Type);
    END IF;

    -- Update the account balance
    UPDATE Account
    SET Balance = v_balance
    WHERE AccountID = :NEW.AccountID;
END;
/



-------------------------------------Package----------------------------------------

create or replace package P_Customer
is
-- procedure update_Customer_password(Username Customer.Username%type,Password Customer.Password%type)

procedure supprimer_Customer(CustomerID Customer.CustomerID%type);

end P_Customer;
/




create or replace package body P_Customer
IS
procedure supprimer_Customer(Customer_id Customer.CustomerID%type)
is
begin
Delete FROM Customer WHERE CustomerID = client_id;
end;

end P_Customer;
/


procedure supprimer_client(client_id CLIENT.CLIENTID%type)
is
begin
Delete FROM CLIENT WHERE CLIENTID = client_id;
end;

end P_Customer;
/


CREATE OR REPLACE PROCEDURE gestCustomer IS

BEGIN
  INSERT INTO Customer(Name, Address, Contact, Username, Password) values()
END;
/


CREATE OR REPLACE PROCEDURE insertAccount IS
BEGIN
  INSERT INTO ACCOUNT(ACCOUNTID,CUSTOMERID,TYPE,BALANCE) values()
END;
/




------------------------------Delete Procedure--------------------------------


CREATE OR REPLACE procedure supprimer_Customer(Customer_id Customer.CustomerID%type)
is
begin
    Delete FROM Customer WHERE CustomerID = Customer_id;
end;
/

BEGIN

supprimer_Customer(4);
END;
/



------------------------------Delete Procedure--------------------------------


CREATE OR REPLACE procedure supprimer_Customer(Customer_id Customer.CustomerID%type)
is
begin
    Delete FROM Customer WHERE CustomerID = Customer_id;
end;
/

BEGIN

supprimer_Customer(4);
END;
/
