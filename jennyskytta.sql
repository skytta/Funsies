
CREATE DATABASE IMT_PROJ_0940554; 

CREATE TABLE Staff (
    StaffID AUTOINCREMENT PRIMARY KEY,
    StaffLname varchar(255) NOT NULL,
    StaffFname varchar(255) NOT NULL,
    HireDate Date NOT NULL,
    EmployeeNum INT (7) NOT NULL, 
    AllocationsALD varchat(255),
    JOBS_ID INT,
    FOREIGN KEY (JOBS_ID) REFERENCES JobTitles(id)
    );  
   
   CREATE TABLE StaffMeeting (
    MeetingID AUTOINCREMENT PRIMARY KEY,
    MtgDate Date NOT NULL,
    STAFFID INT, 
    AllocationsALD varchat(255),
    StaffID INT,
    FOREIGN KEY (StaffID) REFERENCES Staff(id)
    ); 
   
   CREATE TABLE Publications (
    PublicationsID AUTOINCREMENT PRIMARY KEY,
    Journal varchat(255) NOT NULL,
    StaffID INT,
    PubDate DATE,
    FOREIGN KEY (StaffID) REFERENCES Staff(id)
    ); 
   
   CREATE TABLE ETM (
    ETM_ID AUTOINCREMENT PRIMARY KEY,
    FTE_percent INT NOT NULL,
    LAN_ID INT,
    FOREIGN KEY (LAN_ID) REFERENCES LAN(id),
    StaffID INT,
    FOREIGN KEY (StaffID) REFERENCES Staff(id)
    ); 
   
   CREATE TABLE Computers (
    Computers_ID AUTOINCREMENT PRIMARY KEY,
    ComputerName varchar(255) NOT NULL,
    Desk_Locat varchar(255) NOT NULL,
    StaffID INT,
    FOREIGN KEY (StaffID) REFERENCES Staff(id)
    ); 
    
   CREATE TABLE Purchases (
    PurchaseID AUTOINCREMENT PRIMARY KEY,
    Unit INT(50) NOT NULL,
    Amount INT(50) NOT NULL,
    Item_order Varchat (255),
    PO_Number INT(50) NOT NULL,
    LAN_ID INT,
    FOREIGN KEY (LAN_ID) REFERENCES LAN(id),
    Project_ID INT,
    FOREIGN KEY (Project_ID) REFERENCES Projects(id)
    ); 
    
    CREATE TABLE LAN (
    LAN_ID AUTOINCREMENT PRIMARY KEY,
    LAN INT (25) NOT NULL,
    UNIT_ID INT,
    FOREIGN KEY (UNIT_ID) REFERENCES UNIT_Codes(id)
    ); 
    
    CREATE TABLE Grants (
    Grant_ID AUTOINCREMENT PRIMARY KEY,
    GrantCode Varchar (25) NOT NULL,
    GrantType Varchar (255) NOT NULL,
    NIH_ID INT,
    FOREIGN KEY (NIH_ID) REFERENCES NIH(id)
    ); 
    
    CREATE TABLE Projects (
    Project_ID AUTOINCREMENT PRIMARY KEY,
    ProjectName Varchar (25) NOT NULL,
    GrantType Varchar (255) NOT NULL,
    NIH_ID INT,
    FOREIGN KEY (NIH_ID) REFERENCES NIH(id)
    IRB_ID INT,
    FOREIGN KEY (IRB_ID) REFERENCES IRB(id)
    LAN_ID INT,
    FOREIGN KEY (LAN_ID) REFERENCES LAN(id)
    PublicationsID,
    FOREIGN KEY (PublicationsID) REFERENCES Publications(id)
    ); 
    
    CREATE TABLE IRB (
    IRB_ID AUTOINCREMENT PRIMARY KEY,
    ApprovalDate DATE NOT NULL,
    RenewDate DATE NOT NULL,
    CLICK_NUM INT (50) NOT NULL,
    Project_ID INT,
    FOREIGN KEY (Project_ID) REFERENCES Projects(id)
    ); 
    
    CREATE TABLE NIH (
    NIH_ID AUTOINCREMENT PRIMARY KEY,
    RPPRDUE DATE NOT NULL,
    RMR DATE NOT NULL,
    Project_ID INT NOT NULL,
    FOREIGN KEY (Project_ID) REFERENCES Projects(id)
    GrantsID INT,
    FOREIGN KEY (GrantsID) REFERENCES Grants(id)
    ); 
    
    CREATE TABLE UNIT_Codes (
    UNIT_ID AUTOINCREMENT PRIMARY KEY,
    Unit_Code INT (25) NOT NULL,
    LAN_ID INT,
    FOREIGN KEY (LAN_ID) REFERENCES LAN(id)
    ); 
       
    CREATE TABLE Staff_status (
    Staff_statsID AUTOINCREMENT PRIMARY KEY,
    Statuses Varchar (255) NOT NULL,
    StaffID INT,
    FOREIGN KEY (StaffID) REFERENCES Staff(id)
    ); 
    
    CREATE TABLE Licensing (
    LicenseID AUTOINCREMENT PRIMARY KEY,
    Lic_Exp DATE NOT NULL,
    REG_ID,
    FOREIGN KEY (REG_ID) REFERENCES Regulatory(id)
    ); 
    
    CREATE TABLE Regulatory (
    REG_ID AUTOINCREMENT PRIMARY KEY,
    GCP_Exp DATE NOT NULL,
    HSP DATE NOT NULL,
    LicenseID,
    FOREIGN KEY (LicenseID) REFERENCES Licensing(id)
    ); 
    
    CREATE TABLE JobTitles (
    JOBS_ID AUTOINCREMENT PRIMARY KEY,
    Titles Varchar (255) NOT NULL
    StaffID INT,
    FOREIGN KEY (StaffID) REFERENCES Staff(id)
    ); 