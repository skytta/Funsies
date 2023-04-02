
CREATE DATABASE IMT_PROJ_0940554; 

CREATE TABLE Staff (
    StaffID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    StaffLname varchar(255) NOT NULL,
    StaffFname varchar(255) NOT NULL,
    HireDate Date NOT NULL,
    EmployeeNum INT NOT NULL, 
    AllocationsALD varchar(255),
    Staff_statsID INT NOT NULL,
    JOBS_ID INT
    );  
      
   CREATE TABLE Publications (
    PublicationsID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Journal varchar(255) NOT NULL,
    PubDate DATE NOT NULL DEFAULT 'Unpublished',
    StaffID INT,
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
    ); 
   
   CREATE TABLE ETM (
    ETM_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    FTE_percent VARCHAR(255) NOT NULL,
    ); 
   
   CREATE TABLE Computers (
    Computers_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    ComputerName varchar(255) NOT NULL,
    Desk_Locat varchar(255) NOT NULL,
    StaffID INT,
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
    ); 
    
   CREATE TABLE Purchases (
    PurchaseID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    UNIT_ID INT NOT NULL,
    Amount INT NOT NULL,
    Item_order Varchar (255),
    PO_Number INT NOT NULL,
    Invoice INT,
    LAN_ID INT,
    Project_ID INT
    ); 
    
    CREATE TABLE LAN (
    LAN_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    LAN INT NOT NULL,
    UNIT_ID INT
    ); 
    
    CREATE TABLE Grants (
    Grant_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    GrantCode Varchar (25) NOT NULL,
    GrantType Varchar (255) NOT NULL,
    NIH_ID INT
    ); 
    
    CREATE TABLE Projects (
    Project_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    ProjectName Varchar (25) NOT NULL,
    GrantType Varchar (255) NOT NULL,
    NIH_ID INT,
    IRB_ID INT,
    LAN_ID INT,
    FOREIGN KEY (LAN_ID) REFERENCES LAN(LAN_ID),
    PublicationsID INT,
    FOREIGN KEY (PublicationsID) REFERENCES Publications(PublicationsID),
    Grant_ID INT,
    FOREIGN KEY (Grant_ID) REFERENCES Grants(Grant_ID)
    ); 
    
    CREATE TABLE IRB (
    IRB_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    ApprovalDate DATE NOT NULL,
    RenewDate DATE NOT NULL,
    CLICK_NUM INT NOT NULL,
    Project_ID INT,
    FOREIGN KEY (Project_ID) REFERENCES Projects(Project_ID)
    ); 
    
    CREATE TABLE NIH (
    NIH_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    RPPRDUE DATE NOT NULL,
    RMR DATE NOT NULL,
    Project_ID INT NOT NULL,
    FOREIGN KEY (Project_ID) REFERENCES Projects(Project_ID),
    Grant_ID INT,
    FOREIGN KEY (Grant_ID) REFERENCES Grants(Grant_ID)
    ); 
    
    CREATE TABLE UNIT_Codes (
    UNIT_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Unit_Code INT NOT NULL,
    ); 

    CREATE TABLE UnittoLantoStudy (
    UNIT_ID INT,
    FOREIGN KEY (UNIT_ID) REFERENCES Unit_Codes(UNIT_ID),
    LAN_ID INT,
    FOREIGN KEY (LAN_ID) REFERENCES LAN(LAN_ID),
    Project_ID INT,
    FOREIGN KEY (Project_ID) REFERENCES Projects(Project_ID)
    ); 
       
    CREATE TABLE Staff_status (
    StatusID INT,
    FOREIGN KEY (StatusID) REFERENCES Status_type(StatusID),
    StaffID INT,
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
    ); 

    CREATE TABLE Status_type (
    StatusID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Statuses Varchar (255) NOT NULL,
    )
    
    CREATE TABLE Regulatory (
    REG_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Regulatory_type VARCHAR (255) NOT NULL
    );  
    
    CREATE TABLE JobTitles (
    JOBS_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Titles Varchar (255) NOT NULL,
    StaffID INT,
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
    ); 

    CREATE TABLE JobtoStaff (
    JOBS_ID INT,
    FOREIGN KEY (JOBS_ID) REFERENCES JobTitles(JOBS_ID),
    StaffID INT,
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
    ); 

    CREATE TABLE ETMtoStaff (
    ETM_ID INT,
    FOREIGN KEY (ETM_ID) REFERENCES ETM(ETM_ID),
    StaffID INT,
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
    ); 

ALTER TABLE Staff
ADD FOREIGN KEY (JOBS_ID) REFERENCES JobTitles(JOBS_ID); 

ALTER TABLE Staff
ADD FOREIGN KEY (Staff_statsID) REFERENCES Staff_Status(Staff_statsID); 

ALTER TABLE ETM
ADD FOREIGN KEY (LAN_ID) REFERENCES LAN(LAN_ID); 
    
ALTER TABLE Purchases
ADD FOREIGN KEY (Project_ID) REFERENCES Projects(Project_ID); 

ALTER TABLE Purchases
ADD FOREIGN KEY (LAN_ID) REFERENCES LAN(LAN_ID); 

ALTER TABLE Purchases
ADD FOREIGN KEY (UNIT_ID) REFERENCES UNIT_Codes(UNIT_ID); 

ALTER TABLE LAN
ADD FOREIGN KEY (UNIT_ID) REFERENCES UNIT_Codes(UNIT_ID); 

ALTER TABLE Grants
ADD FOREIGN KEY (NIH_ID) REFERENCES NIH(NIH_ID); 

ALTER TABLE Projects
ADD FOREIGN KEY (NIH_ID) REFERENCES NIH(NIH_ID); 

ALTER TABLE Projects
ADD FOREIGN KEY (IRB_ID) REFERENCES IRB(IRB_ID); 

ALTER TABLE Licensing
ADD FOREIGN KEY (REG_ID) REFERENCES Regulatory(REG_ID);     

ALTER TABLE Licensing
ADD FOREIGN KEY (REG_ID) REFERENCES Regulatory(REG_ID);   

ALTER TABLE Staff
ADD JOBS_ID INT; 

ALTER TABLE Publications 
ADD NIH INT;

ALTER TABLE LAN
ADD FOREIGN KEY (UNIT_ID) REFERENCES Unit_Codes(UNIT_ID);   

ALTER TABLE Purchases 
ALTER COLUMN Amount decimal(15,2);

ALTER TABLE PUrhcase
DROP COLUMN StaffID;

ALTER TABLE Staff_status
DROP COLUMN Statuses;

Select * from UNIT_Codes;
Select * from Projects;