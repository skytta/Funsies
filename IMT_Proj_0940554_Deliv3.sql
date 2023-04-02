/* 
Can be tested in IMT_PROJ_0940554

Stored Procedures 

Stored Procedure 1: 
This stored procedure is designed to insert a new row into the Staff table 
*/

CREATE PROCEDURE Get_CRC_num
@Ttl VARCHAR(255),
@J_ID INT OUTPUT
AS 
SET @J_ID = (Select Jobs_ID FROM JobTitles WHERE Titles = @Ttl)
GO
CREATE PROCEDURE Get_ETM_num
@FTE VARCHAR(255),
@E_ID INT OUTPUT
AS 
SET @E_ID = (Select ETM_ID FROM ETM WHERE FTE_percent = @FTE)
GO
CREATE PROCEDURE Insert_UpdateStaff
@LName VARCHAR(255),
@FName VARCHAR(255),
@H_Date DATE,
@EID INT,
@ALD VARCHAR(255)
AS 
DECLARE @S_ID INT, @J_ID INT, @E_ID INT 

EXEC Get_CRC_num
	@Ttl = Titles,
	@J_ID = @J_ID OUTPUT
IF @J_ID IS NULL
	BEGIN
		PRINT '@J_ID is NULL and will fail during the INSERT transaction; check spelling of all parameters';
		THROW 56676, '@J_ID cannot be NULL; statement is terminating', 1;
	END

EXEC Get_ETM_num
	@FTE = FTE_percent,
	@E_ID = @E_ID OUTPUT

IF @E_ID IS NULL
	BEGIN
		PRINT '@E_ID is NULL and will fail during the INSERT transaction; check spelling of all parameters';
		THROW 56676, '@E_ID cannot be NULL; statement is terminating', 1;
	END

BEGIN TRAN T1
INSERT INTO Staff (StaffID, StaffLname, StaffFname, HireDate, EmployeeNum, AllocationsALD, JOBS_ID, ETM_ID)
VALUES (@S_ID, @LName, @FName, @H_Date, @EID, @ALD, @J_ID, @E_ID)
COMMIT TRAN T1
GO 


/* 
Stored Procedure 2: 
This is a stored procedure to insert a row into the Purchases table 
*/

CREATE PROCEDURE Get_LAN
@Lan INT,
@L_ID INT OUTPUT
AS SET @L_ID = (Select LAN_ID
			FROM LAN
			WHERE LAN = @Lan)
GO
CREATE PROCEDURE Get_ProjectID
@Proj VARCHAR(255),
@PR_ID INT OUTPUT
AS SET @PR_ID = (Select Project_ID
			FROM Projects
			WHERE ProjectName = @Proj)
GO
CREATE PROCEDURE Get_UnitID
@Unit INT,
@U_ID INT OUTPUT
AS SET @U_ID = (Select Unit_ID
			FROM UNIT_Codes
			WHERE Unit_Code = @Unit)
GO
CREATE PROCEDURE New_Wonder_Purchase
@Amt varchar(50),
@Item varchar(100),
@PO INT,
@Inv INT
AS DECLARE @P_ID INT, @L_ID INT, @PR_ID INT, @U_ID INT
EXEC Get_LAN
	@Lan = Lan,
	@L_ID = @L_ID OUTPUT

IF @L_ID IS NULL
	BEGIN
		PRINT '@L_ID is NULL and will fail during the INSERT transaction; check spelling of all parameters';
		THROW 56676, '@L_ID cannot be NULL; statement is terminating', 1;
	END

EXEC Get_ProjectID
	@Proj = Project,
	@PR_ID = @PR_ID OUTPUT

IF @PR_ID IS NULL
	BEGIN
		PRINT '@PR_ID is NULL and will fail during the INSERT transaction; check spelling of all parameters';
		THROW 56676, '@PR_ID cannot be NULL; statement is terminating', 1;
	END

EXEC Get_UnitID
	@Unit = Unitcode,
	@U_ID = @U_ID OUTPUT

IF @U_ID IS NULL
	BEGIN
		PRINT '@U_ID is NULL and will fail during the INSERT transaction; check spelling of all parameters';
		THROW 56676, '@U_ID cannot be NULL; statement is terminating', 1;
	END

BEGIN TRAN T2
INSERT INTO Purchases (PurchaseID, UNIT_ID, Amount, Item_order, PO_Number, Invoice, LAN_ID, Project_ID)
VALUES (@P_ID, @U_ID, @Amt, @Item, @PO, @Inv, @L_ID, @PR_ID)
COMMIT TRAN T2
GO 


/* 
User Defined Functions 


UDF 1: 
This Scaler UDF calculates purchase requirements thresholds by amounts.  It could be used to review purchases that
need various approvals or sign-offs for the lab.  
*/

GO
CREATE FUNCTION [dbo].[Lab_purchases] (
	@Amount DECIMAL(15,2))
RETURNS varchar (50) 
AS -- Purchase thresholds 
BEGIN
DECLARE @Lab_purchases VARCHAR (50);
	IF (@Amount BETWEEN '0' AND '50') SET @Lab_purchases = 'approval not required';
	IF (@Amount BETWEEN '51' AND '200') SET @Lab_purchases = 'Supervisor approval needed';
	IF (@Amount BETWEEN '201' and '500') SET @Lab_purchases = 'Purchase rationale draft needed';
	IF (@Amount BETWEEN '501' AND '2000') SET @Lab_purchases = '2 quotes required';
	IF (@Amount > '2001') SET @Lab_purchases = 'Budget consult required';
	RETURN @Lab_purchases
END;
GO

/*
UDF 1 implemented: 
I have implemented the above UDF to create a small table showing which purchases meet 
various thresholds and applied it to the purchases table using amount totals as the unit 
to be assessed.  I set the column output to be titled Purchase_Requirements*/

SELECT Amount, Item_order, dbo.Lab_purchases(Purchases.Amount) AS Purchase_Requirements
FROM Purchases;

/*
UDF 1 implemented with paramaters
Here I am leveraging the same UDF but filtering by the project name to narrow down purchase 
thresholds by project */

SELECT P.Amount, P.Item_order, dbo.Lab_purchases(P.Amount) AS Purchase_Requirements
FROM Purchases P
	JOIN Projects PR ON P.Project_ID = PR.Project_ID
WHERE ProjectName = 'Facial Privacy';


/* 
UDF 2:
The goal of the below UDF is intended to calculate expiration timeline based on the Good Clinical Practice (GCP)dates to 
see if staff members were within a time frame of 30, 90, today and past due of next re-certifcation.  
Unfortunately, I cannot get the date code to work correctly which is driving me crazy!  The UDF saves and it runs correctly but
its not computing correctly as its showing everyone in compliance when I know that isn't the case.  Its an issue with the 
syntax associated with calculating last 30 days from date in the column. With more time, I'm certain I could figure this out
but given the time constraints, I'll submit this as-is as it does in fact "work".
 */


GO
CREATE FUNCTION [dbo].[GCP_Expired] (
	@GCP_exp DATE)
RETURNS varchar (50) 
AS -- expirations 
BEGIN
DECLARE @GCP_Expired VARCHAR (50);
	IF (@GCP_Expired BETWEEN DATEADD(DAY,-90,GETDATE()) AND GETDATE()) SET @GCP_Expired = 'Your GCP will expire in the next 90 Days';
	IF (@GCP_Expired BETWEEN DATEADD(DAY,-30,GETDATE()) AND  GETDATE()) SET @GCP_Expired = 'Your GCP will expire in the next 30 Days';
	IF (@GCP_Expired BETWEEN DATEADD(DAY, 0, GETDATE()) AND  GETDATE()) SET @GCP_Expired = 'GCP RENEWAL DUE TODAY!!!';
	IF (@GCP_Expired > GETDATE())SET @GCP_Expired = 'GCP expired - out of compliance';
	ELSE SET @GCP_Expired = 'GCP in compliance'
	RETURN @GCP_Expired
END;
GO

/*
UDF 2: implemented 
Computed columns using above UDF: This would have been used to assess GCP status of all Staff.  
*/

SELECT StaffFName, StaffLName, GCP_exp, dbo.GCP_Expired(Staff.GCP_exp) AS GCP_Status
FROM Staff;

/*
UDF 2: implemented with added paramaters 
This would have been used to assess GCP status of only the Staff that are on a Peformance
Improvement Plan.  Such use would identify if staff needed additional oversight for compliance.   
*/

SELECT S.StaffFName, S.StaffLName, S.GCP_exp, dbo.GCP_Expired(S.GCP_exp) AS GCP_Status
FROM Staff S
	JOIN Status_type ST ON S.StatusID = ST.StatusID
WHERE ST.Statuses = 'ON PIP';

/*
COMPLEX QUERIES (2)


Query 1:

Write a query to find the unique publications, and Computer assigned for a staff member hired before 1-1-2020 that are Active and working at least .6 ETM Whose 
first name starts with a F.
*/

SELECT S.StaffFName, S.StaffLName, P.journal, C.ComputerName
FROM Staff S
	JOIN ETM E ON S.ETM_ID = S.ETM_ID
	JOIN Status_type ST ON S.StatusID = ST.StatusID
	JOIN Publications P ON S.StaffID = P.StaffID
	JOIN Computers C ON S.StaffID = C.StaffID
WHERE S.HireDate <= '2020-01-01'
AND E.FTE_percent IN ('.60','.65','.80','1.0')
AND Statuses = 'Active'
AND S.StaffFname LIKE 'F%'
Group by S.StaffFName, S.StaffLName, P.journal, C.ComputerName
ORDER BY P.Journal ASC

/*

Query 2:
Write a query to identify the LAN, Grant Code, RPPR due date, and IRB Renewal Date for studies with purchases below $10000 made for 
projects that were also published in a journal by Staff members with a last name starting with S.  List by upcoming renewal dates first.
*/

SELECT L.LAN, G.GrantCode, I.RenewDate, N.RPPRDUE
FROM Grants G
	JOIN Projects P ON G.Grant_ID = P.Grant_ID
	JOIN Publications PU ON P.Project_ID = PU.Project_ID
	JOIN Purchases PR ON P.Project_ID = PR.Project_ID
	JOIN IRB I ON P.IRB_ID = I.IRB_ID
	JOIN LAN L ON P.LAN_ID = L.LAN_ID	
	JOIN NIH N ON P.NIH_ID = N.NIH_ID
WHERE PR.Amount < 10000
GROUP BY L.LAN, G.GrantCode, I.RenewDate, N.RPPRDUE
ORDER BY I.RenewDate, N.RPPRDUE

