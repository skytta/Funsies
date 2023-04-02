/*
Module 8
Practice Lab for managing Security
*/

-- STEP 1: Create a new database on IS-HAY09.iSchool.uw.edu
CREATE DATABASE IMT543_Practice8_yourAliasGoesHere --> example IMT543_Practice8_gthay

-- STEP 2: Create a new login that has a default connection to the new database just created
CREATE LOGIN [IMT543_yourAliasGoesHere] 
WITH PASSWORD = 'something you can remember like a favorite food or song name',
DEFAULT_DATABASE = IMT543_Practice8_yourAliasWentHere,
CHECK_POLICY = OFF,
CHECK_EXPIRATION = OFF ;
GO

CREATE USER [IMT543_yourAliasGoesHere]
GO

-- STEP 3: ensure to USE your database to make sure you are not in any other database like UNIVERSITY 
-- Example: USE IMT543_Practice8_gthay

-- STEP 4: Run the following code to establish 3 tables:
CREATE TABLE tblCUSTOMER
(CustomerID INT IDENTITY primary key,
CustFname varchar(30) not null,
CustLname varchar(30) not null,
CustBirth Date not null,
CustStreetAddress varchar(100) not null,
CustCity varchar(50) not null,
CustState varchar(30) not null,
CustZip varchar(10) not null)
GO

CREATE TABLE tblPRODUCT
(ProductID INT IDENTITY primary key,
ProductName varchar(50) not null,
Price Numeric(8,2) not null,
ProductDescr varchar(500) NULL)
GO

CREATE TABLE tblORDER
(OrderID INT IDENTITY primary key,
OrderDate Date not null,
CustomerID INT FOREIGN KEY REFERENCES tblCUSTOMER (CustomerID) not null,
ProductID INT FOREIGN KEY REFERENCES tblPRODUCT (ProductID) not null,
Quantity INT not null)
GO

-- STEP 5: Run the following code to populate a handful of rows into each look-up table (tblPRODUCT and tblCUSTOMER)
INSERT INTO tblPRODUCT (ProductName, Price, ProductDescr)
VALUES 
('1 Pound Bag of Corn Chips', 4.56, 'This is a big bag of salty chips'), 
('Heavy Duty Cleaning Wipes', 9.87, '200 sheets of handi-wipes for the kitchen'), 
('100-Page Spiral Notebook', 1.98, 'College Rule spiral notebook with cardboard cover'), 
('Large Drinking Glass', 3.85, '18 ounce cup for cold drinks')
GO

INSERT INTO tblCUSTOMER (CustFname,	CustLname,	CustBirth, CustStreetAddress,	CustCity,	CustState,	CustZIP)
VALUES 
('Karima','Butterworth','1976-05-23','3727 E Aucuba Point Pass','Letohatchee','Alabama, AL','36047'),		
('Lessie','Fevold','1972-04-06','25083 North Hillcrest Hill Highway','Buffalo','Minnesota, MN','55313'),
('Sharyn','Bednarczyk','1994-03-19','16815 S Morton Beach Sloop','Crocketville','South Carolina, SC','29913'),
('Brigette','Atienza','1951-07-10','2723 SE Impala Lily Beach Avenue','Kingsport','Tennessee, TN','37669'),
('Sanda','Bowell','1956-07-18','10305 North Araucaria View Boulevard','Vero Beach','Florida, FL','329640'),
('Mikki','Vallero','1986-01-15','1031 S Locust Island Pass','Silverton','Colorado, CO','81433')
GO

-- STEP 6: Run the following code to create a stored procedure to INSERT a new row into tblORDER
CREATE PROCEDURE uspNewOrder
@F varchar(30),
@L varchar(30),
@DOB Date,
@Prod varchar(50),
@Qty INT,
@OrderDate Date
AS
DECLARE @C_ID INT, @P_ID INT

SET @C_ID = (SELECT CustomerID FROM tblCUSTOMER WHERE CustFname = @F AND CustLname = @L AND CustBirth = @DOB)

SET @P_ID = (SELECT ProductID FROM tblPRODUCT WHERE ProductName = @Prod)

INSERT INTO tblORDER (CustomerID, ProductID, Quantity, OrderDate)
VALUES (@C_ID, @P_ID, @Qty, @OrderDate)
GO

-- STEP 7: review the above statement! Make sure you 'see' the creation and population of the database :-)

-- STEP 8: EXECUTE the following stored procedure calls to put several rows of data into the tblORDER table

EXEC uspNewOrder
@F = 'Karima',
@L = 'Butterworth',
@DOB = '1976-05-23',
@Prod = 'Heavy Duty Cleaning Wipes',
@Qty = '3',
@OrderDate = 'October 26, 2019'
GO

EXEC uspNewOrder
@F = 'Karima',
@L = 'Butterworth',
@DOB = '1976-05-23',
@Prod = '100-Page Spiral Notebook',
@Qty = '2',
@OrderDate = 'November 9, 2021'
GO

EXEC uspNewOrder
@F = 'Brigette',
@L = 'Atienza',
@DOB = '1951-07-10',
@Prod = 'Heavy Duty Cleaning Wipes',
@Qty = '4',
@OrderDate = 'July 18, 2017'
GO

EXEC uspNewOrder
@F = 'Mikki',
@L = 'Vallero',
@DOB = '1986-01-15',
@Prod = '1 Pound Bag of Corn Chips',
@Qty = '4',
@OrderDate = 'June 9, 2019'
GO

EXEC uspNewOrder
@F = 'Sharyn',
@L = 'Bednarczyk',
@DOB = '1994-03-19',
@Prod = '1 Pound Bag of Corn Chips',
@Qty = '8',
@OrderDate = ''
GO


EXEC uspNewOrder
@F = 'Mikki',
@L = 'Vallero',
@DOB = '1986-01-15',
@Prod = 'Large Drinking Glass',
@Qty = '6',
@OrderDate = 'March 5, 2019'
GO

EXEC uspNewOrder
@F = 'Sharyn',
@L = 'Bednarczyk',
@DOB = '1994-03-19',
@Prod = 'Heavy Duty Cleaning Wipes',
@Qty = '1',
@OrderDate = 'January 11, 2020'
GO

EXEC uspNewOrder
@F = 'Brigette',
@L = 'Atienza',
@DOB = '1951-07-10',
@Prod = 'Heavy Duty Cleaning Wipes',
@Qty = '1',
@OrderDate = 'January 23, 2020'
GO

EXEC uspNewOrder
@F = 'Brigette',
@L = 'Atienza',
@DOB = '1951-07-10',
@Prod = '1 Pound Bag of Corn Chips',
@Qty = '7',
@OrderDate = 'Feb 11, 2020'
GO

EXEC uspNewOrder
@F = 'Brigette',
@L = 'Atienza',
@DOB = '1951-07-10',
@Prod = 'Heavy Duty Cleaning Wipes',
@Qty = '1',
@OrderDate = 'January 18, 2020'
GO

-- STEP 9: run the following code to establish a view of the data populated in tblORDER
CREATE VIEW vwORDER_Last36Months
AS
SELECT *
FROM tblORDER
WHERE OrderDate > DateAdd(Month, -36, GetDate())
GO

-- STEP 10: Run the following code to SELECT from the View just created
SELECT * FROM vwORDER_Last36Months


-- STEP 11: DENY permissions to the new login!
Use <database name> --> be sure to be in the context of login IMT543
DENY SELECT on vwORDER_Last36Months to  XX --> make sure to reference your new login (example IMT543_Practice8_gthay)
GO

DENY EXECUTE ON OBJECT::DBO.uspNewOrder 
    TO XX; --> make sure to reference your new login (example IMT543_Practice8_gthay)

-- STEP 12: logout from SQL Server

-- STEP 13: re-connect with SQL Server using the recently-created login

-- STEP 14: try to run the following code; what happens?
SELECT * FROM vwORDER_Last36Months

-- STEP 15: try to run the following code; what happens?

EXEC uspNewOrder
@F = 'Brigette',
@L = 'Atienza',
@DOB = '1951-07-10',
@Prod = 'Heavy Duty Cleaning Wipes',
@Qty = '4',
@OrderDate = 'April 18, 2022'
GO
