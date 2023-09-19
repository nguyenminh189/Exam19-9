create database AZBank
GO

use AZBank
GO

CREATE TABLE Customer (
	CustomerID int PRIMARY KEY,
	Name nvarchar(50),
	City nvarchar(50),
	Country nvarchar(50),
	Phone nvarchar(15),
	Email nvarchar(50)
)
GO

INSERT INTO Customer(CustomerID, Name, City, Country, Phone, Email) 
VALUES (1111, 'Minh', 'HaNoi', 'VietNam', '0983111628', 'nguyenducminh24@gmail.com'),
(1112, 'Tom Shelby', 'London', 'England', '0228751762', 'shelbyisme11@gmail.com'),
(1113, 'Steve Rogers', 'Brooklyn', 'USA', '0261118765', 'usaasshihi88@gmail.com')
GO

CREATE TABLE CustomerAccount (
	AccountNumber char(9) PRIMARY KEY,
	CustomerID int NOT NULL,
	Balance money NOT NULL,
	MinAccount money,
FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID)
)
GO

INSERT INTO CustomerAccount(AccountNumber, CustomerID, Balance, MinAccount) 
VALUES (101, 1111, 1500, 20000),
(102, 1112, 1400, 16000),
(103, 1113, 1700, 25000)
GO

CREATE TABLE CustomerTransaction (
	TransactionID int PRIMARY KEY,
	AccountNumber char(9),
	TransactionDate smalldatetime,
	Amount money,
	DepositorWithdraw bit,
FOREIGN KEY (AccountNumber) REFERENCES CustomerAccount (AccountNumber)
)
GO

INSERT INTO CustomerTransaction(TransactionID, AccountNumber, TransactionDate, Amount, DepositorWithdraw) 
VALUES (666, 101, '2023-02-23', 1000, 1),
(667, 102, '2023-09-20', 1300, 1),
(668, 103, '2023-12-15', 1600, 0)
GO


SELECT * FROM Customer
SELECT * FROM CustomerAccount
SELECT * FROM CustomerTransaction

--4
SELECT * FROM Customer
WHERE city = 'HaNoi';

--5
SELECT Customer.*, CustomerAccount.*
FROM Customer
JOIN CustomerAccount ON Customer.CustomerID = CustomerAccount.CustomerID;

--6
ALTER TABLE CustomerTransaction
ADD CONSTRAINT AmountRange 
CHECK (Amount > 0 AND Amount <= 1000000);

--7
CREATE VIEW CustomerTransactions AS
SELECT C.Name, CT.AccountNumber, CT.TransactionDate, CT.Amount, CT.DepositorWithdraw
FROM CustomerTransaction CT
JOIN CustomerAccount CA ON CT.AccountNumber = CA.AccountNumber
JOIN Customer C ON CA.CustomerID = C.CustomerID;
GO