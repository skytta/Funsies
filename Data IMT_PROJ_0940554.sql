
INSERT INTO ETM (FTE_percent)
VALUES 
('1.0')
,('.80')
,('.65')
,('.60')
,('.25')
,('.40')
,('.90')
GO
PRINT '7 rows added to ETM'

INSERT INTO Computers (ComputerName, Desk_Locat)
VALUES 
('EWRGS20263', 'BC.03.704.15')
,('EWRGSR415','BC.03.704.17')
,('EWCTR20296', 'BC.03.704.16')
,('EWCTR20295', 'BC.03.704.14')
,('EWRGS19897', 'BC.03.704.20')
,('EWRGS20260', 'BC.03.704.22')
,('EWRGS19908', 'BC.03.704.23')
,('EWRGSRQ24', 'BC.03.704.19')
,('EWRGSRQ94', 'BC.03.704.18')
,('fredddd', 'BC.03.03.228')
,('unassigned', 'BC.03.704.21')

GO
PRINT '11 rows added to Computers'

INSERT INTO Grants (GrantCode, GrantType)
VALUES 
('NIHM898098', 'R01')
,('NIHM898798','R01')
,('NIHM448098', 'R21')
,('NIHM1298098', 'R21')
,('NIHM338098', 'R21')
,('NIHM638098', 'R01')
,('NIHM897598', 'U19')
,('NIHM890198', 'U19')
,('NIHM89J012', 'U19')
GO
PRINT '9 rows added to Grants'

INSERT INTO IRB (ApprovalDate, RenewDate, CLICK_NUM)
VALUES 
('2018-05-23', '2023-05-23','STUDY000012')
,('2020-04-01','2023-04-01', 'STUDY000014')
,('2020-03-01', '2023-03-01', 'STUDY000412')
,('2020-02-01', '2023-02-01', 'STUDY000045')
,('2020-11-01', '2022-11-01', 'STUDY000458')
,('2020-01-01', '2023-01-01', 'STUDY0004568')
,('2020-12-01', '2022-12-01', 'STUDY0000963')
,('2019-03-01', '2019-03-01', 'STUDY0002145')
,('2019-09-01', '2022-09-01', 'STUDY0000552')
GO
PRINT '9 rows added to IRB'

INSERT INTO JobTitles (Titles)
VALUES 
('Clinical Research Scientist')
,('Clinical Research Coordinator 1')
,('Clinical Research Coordinator 2')
,('Clinical Research Coordinator 3')
,('Principal Investigator')
,('Psychometrist')
,('Research Assistant')
,('Student Intern')
,('Psychologist')
,('Clinical Research Supervisor')
GO
PRINT '10 rows added to JobTitles'

INSERT INTO LAN (LAN)
VALUES 
('417960120101')
,('417960110101')
,('417960040101')
,('415980030702')
,('417960130101')
,('417960080101')
,('24010059')
,('417960010101')
,('505850270101')
,('39437076')
GO
PRINT '10 rows added to LAN'

INSERT INTO UNIT_Codes (Unit_Code)
VALUES 
('41000')
,('34564')
,('41010')
GO
PRINT '10 rows added to UNIT_Codes'

INSERT INTO NIH (RPPRDUE, RMR, Project_ID)
VALUES 
('2023-01-15','2023-08-23', '1')
,('2023-04-15','2023-08-23', '2')
,('2023-03-15','2023-08-23', '3')
,('2023-02-15','2023-09-23', '4')
,('2023-01-15','2023-09-23', '5')
GO
PRINT '10 rows added to NIH'

INSERT INTO Staff (StaffLname, StaffFname, HireDate, EmployeeNum, AllocationsALD)
VALUES 
('Skytta', 'Junior', '2014-07-08', '105454', '5%FP-15%UCSD-58%Wonder')
,('Willis', 'Honor', '2020-11-11', '108888', '5%FP-15%UCSD-58%Wonder')
,('Riley', 'Karl', '2020-04-11', '148999', '5%FP-15%UCSD-58%Wonder')
,('Soledad', 'Michie', '2022-02-18', '145887', '5%FP-15%UCSD-58%Wonder')
,('Shic', 'Frankie', '2015-05-11', '145698', '5%FP-15%UCSD-58%Wonder')
,('Dommer', 'Karma', '2021-05-16', '136547', '5%FP-15%UCSD-58%Wonder')
,('Corrigan', 'Santa', '2012-01-22', '123654', '5%FP-15%UCSD-58%Wonder')
,('Olson', 'Elrod', '2020-05-11', '104569', '5%FP-15%UCSD-58%Wonder')
,('Picoto', 'Janson', '2022-01-11', '124569', '5%FP-15%UCSD-58%Wonder')
,('Ajwani', 'Archie', '2022-02-11', '145784', '5%FP-15%UCSD-58%Wonder')
GO
PRINT '10 rows added to Staff'

INSERT INTO Projects (ProjectName)
VALUES 
('Wonder')
,('K Peirce')
,('Facial Privacy')
,('ABC-cT')
,('FragileX')
GO
PRINT '5 rows added to Projects'

INSERT INTO JobtoStaff (JOBS_ID, StaffID)
VALUES 
('100', '91')
,('93', '92')
,('93', '93')
,('92', '94')
,('95', '95')
,('91', '96')
,('96', '97')
,('99', '98')
,('96', '99')
,('97', '100')
GO
PRINT '10 rows added to Jobstostaff'


INSERT INTO ETMtoStaff (ETM_ID, StaffID)
VALUES 
('2', '91')
,('1', '92')
,('4', '93')
,('1', '94')
,('1', '95')
,('3', '96')
,('2', '97')
,('5', '98')
,('5', '99')
,('5', '100')
GO
PRINT '10 rows added to ETMtoStaff'

INSERT INTO Publications (Journal, PubDate, StaffID)
VALUES 
('JADD','2019-01-13','91')
,('Computer Science','2018-01-16','95')
,('Autism','2020-02-15','95')
GO
PRINT '10 rows added to Publications'

INSERT INTO Publications (Journal, PubDate, StaffID)
VALUES 
('Fraggy','2019-01-13','91')
,('Data Mines','2018-01-16','95')
GO
PRINT '10 rows added to Publications'

INSERT INTO Regulatory (GCP_Exp, HSP)
VALUES 
('06-01-2024', '06-01-2024')
,('01-01-2022', '01-01-2023')
,('01-01-2024', '01-01-2022')
,('06-01-2024', '06-01-2022')
,('02-14-2024', '02-14-2025')
,('06-01-2024', '06-01-2022')
,('03-25-2024', '03-25-2023')
,('06-01-2025', '06-01-2024')
,('07-15-2024', '07-15-2024')
,('06-01-2024', '05-01-2024')
GO
PRINT '10 rows added to Regulatory'

INSERT INTO Status_type (Statuses)
VALUES 
('ACTIVE')
,('ONBOAREDING')
,('ON PIP')
,('EXITED')
,('TERMED')
,('Per DIEM')
,('INTERN')
,('IND CONTRACT')
,('EXPIRED')
,('OFFERED POS')
,('PENDING UPDATE')
GO
PRINT '10 rows added to Status_type'

INSERT INTO Staff_status (StatusID, StaffID)
VALUES 
('1', '91')
,('1', '92')
,('1', '93')
,('1', '94')
,('1', '95')
,('1', '96')
,('8', '97')
,('6', '98')
,('6', '99')
,('7', '100')
GO
PRINT '10 rows added to Staff_Status'

INSERT INTO Regulatory (Regulatory_type)
VALUES 
('GCP')
,('HSP')
,('IATA')
,('RCR')
,('HIPAA')
GO
PRINT '5 rows added to Regulatory'

INSERT INTO Regulatory (Regulatory_type)
VALUES 
('MA-R')
,('Psychologist')
,('RN')
,('LMHT')
GO
PRINT '5 rows added to Regulatory'

INSERT INTO UNIT_Codes (Unit_Code)
VALUES 
('41000')
,('41010')
,('35455')
GO
PRINT '5 rows added to Unit_Codes'

INSERT INTO Purchases (UNIT_ID, Amount, Item_order, PO_Number, Invoice, LAN_ID, Project_ID)
VALUES 
('1', '56.99', 'monkey bars', '456987456', '45646542', '92', '1')
,('1', '99.99', 'ASD assessment', '00456987456', '01246542', '92', '1')
,('1', '19.99', 'stamps', '12300578', '0236456542', '92', '3')
,('3', '4000.99', 'ADOS manuals', '1203260578', '000056542', '92', '3')
,('3', '222.99', 'mullen assessments', '12300568', '01236500', '92', '2')
,('4', '350.99', 'ADOS assessments', '12300558', '0236456543', '92', '4')
,('4', '4569.99', 'Funko assessments', '00036598', '0236456001', '92', '4')
GO
PRINT '5 rows added to Purchases'

INSERT INTO Reg_Lic_Staff (REG_ID, REG_EXP, StaffID)
VALUES 
('1', '2-2-2023', '91')
,('2', '2-2-2023', '91')
,('6', '8-28-2023', '91')
,('1', '2-2-2023', '92')
,('2', '2-2-2023', '92')
,('6', '6-25-2023', '92')
,('1', '4-2-2023', '93')
,('2', '4-2-2023', '93')
,('6', '9-12-2022', '93')
,('1', '4-2-2023', '94')
,('2', '4-2-2023', '94')
,('6', '9-12-2022', '94')
,('1', '4-2-2023', '95')
,('2', '4-2-2023', '95')
,('4', '9-12-2022', '95')
,('1', '4-2-2021', '96')
,('2', '4-2-2023', '96')
,('6', '9-12-2022', '96')
,('1', '4-2-2021', '97')
,('2', '4-2-2023', '97')
,('6', '9-12-2022', '97')
,('9', '9-12-2022', '97')
,('1', '4-2-2023', '98')
,('2', '4-2-2023', '98')
,('7', '9-12-2022', '98')
,('1', '4-2-2023', '99')
,('2', '4-2-2023', '99')
,('1', '4-2-2023', '100')
,('2', '4-2-2023', '100')
GO
PRINT '5 rows added to Reg_Lic_Staff'

INSERT INTO Unittolantostudy (UNIT_ID, LAN_ID, Project_ID)
VALUES
('1', '97', '1')
,('1', '96', '2')
,('1', '93', '3')
,('1', '95', '4')
,('1', '92', '5')
GO
PRINT ' rows added to Unittolantostudy'

-- Updates to Staff
UPDATE Staff
SET JOBS_ID = 100
WHERE StaffLname = 'Skytta'; 

UPDATE Staff
SET JOBS_ID = 93
WHERE StaffLname = 'Willis'; 

UPDATE Staff
SET JOBS_ID = 93
WHERE StaffLname = 'Riley'; 

UPDATE Staff
SET JOBS_ID = 92
WHERE StaffLname = 'Soledad'; 

UPDATE Staff
SET JOBS_ID = 95
WHERE StaffLname = 'Shic'; 

UPDATE Staff
SET JOBS_ID = 91
WHERE StaffLname = 'Dommer'; 

UPDATE Staff
SET JOBS_ID = 96
WHERE StaffLname = 'Corrigan'; 

UPDATE Staff
SET JOBS_ID = 99
WHERE StaffLname = 'Olson'; 

UPDATE Staff
SET JOBS_ID = 96
WHERE StaffLname = 'Picoto'; 

UPDATE Staff
SET JOBS_ID = 97
WHERE StaffLname = 'Ajwani'; 

-- UPDATE LAN TABLE

UPDATE LAN
SET UNIT_ID = 1
WHERE LAN = '417960120101'; 

UPDATE LAN
SET UNIT_ID = 2
WHERE LAN = '417960110101'; 

UPDATE LAN
SET UNIT_ID = 1
WHERE LAN = '417960040101'; 

UPDATE LAN
SET UNIT_ID = 1
WHERE LAN = '415980030702'; 

UPDATE LAN
SET UNIT_ID = 1
WHERE LAN = '417960130101'; 

UPDATE LAN
SET UNIT_ID = 2
WHERE LAN = '417960080101'; 

UPDATE LAN
SET UNIT_ID = 3
WHERE LAN = '24010059'; 

UPDATE LAN
SET UNIT_ID = 1
WHERE LAN = '417960010101'; 

UPDATE LAN
SET UNIT_ID = 2
WHERE LAN = '505850270101'; 

UPDATE LAN
SET UNIT_ID = 3
WHERE LAN = '39437076'; 

-- UPDATE Grants TABLE

UPDATE Grants
SET UNIT_ID = 3
WHERE LAN = '39437076'; 

UPDATE LAN
SET UNIT_ID = 3
WHERE LAN = '39437076'; 

UPDATE LAN
SET UNIT_ID = 3
WHERE LAN = '39437076'; 

UPDATE LAN
SET UNIT_ID = 3
WHERE LAN = '39437076'; 

UPDATE LAN
SET UNIT_ID = 3
WHERE LAN = '39437076'; 

UPDATE LAN
SET UNIT_ID = 3
WHERE LAN = '39437076'; 

UPDATE LAN
SET UNIT_ID = 3
WHERE LAN = '39437076'; 

UPDATE LAN
SET UNIT_ID = 3
WHERE LAN = '39437076'; 

UPDATE LAN
SET UNIT_ID = 3
WHERE LAN = '39437076'; 

-- UPDATE NIH

UPDATE NIH
SET Grant_ID = 82
WHERE NIH_ID = '8'; 

UPDATE NIH
SET Grant_ID = 83
WHERE NIH_ID = '5'; 

UPDATE NIH
SET Grant_ID = 84
WHERE NIH_ID = '6'; 

UPDATE NIH
SET Grant_ID = 85
WHERE NIH_ID = '7'; 

UPDATE NIH
SET Grant_ID = 86
WHERE NIH_ID = '4'; 

-- UPDATE Grants

UPDATE Grants
SET NIH_ID = 8
WHERE Grant_ID = '82'; 

UPDATE Grants
SET NIH_ID = 5
WHERE Grant_ID = '83'; 

UPDATE Grants
SET NIH_ID = 6
WHERE Grant_ID = '84'; 

UPDATE Grants
SET NIH_ID = 7
WHERE Grant_ID = '85'; 

UPDATE Grants
SET NIH_ID = 4
WHERE Grant_ID = '86'; 

-- Update Projects

UPDATE Projects
SET NIH_ID = 8
WHERE ProjectName = 'Wonder'; 

UPDATE Projects
SET NIH_ID = 5
WHERE ProjectName = 'K Peirce'; 

UPDATE Projects
SET NIH_ID = 6
WHERE ProjectName = 'Facial Privacy'; 

UPDATE Projects
SET NIH_ID = 7
WHERE ProjectName = 'ABC-cT'; 

UPDATE Projects
SET NIH_ID = 4
WHERE ProjectName = 'FragileX'; 

-- Update Projects

UPDATE Projects
SET Grant_ID = 82
WHERE ProjectName = 'Wonder'; 

UPDATE Projects
SET Grant_ID = 83
WHERE ProjectName = 'K Peirce'; 

UPDATE Projects
SET Grant_ID = 84
WHERE ProjectName = 'Facial Privacy'; 

UPDATE Projects
SET Grant_ID = 85
WHERE ProjectName = 'ABC-cT'; 

UPDATE Projects
SET Grant_ID = 86
WHERE ProjectName = 'FragileX'; 

-- Update Projects

UPDATE Projects
SET IRB_ID = 83
WHERE ProjectName = 'Wonder'; 

UPDATE Projects
SET IRB_ID = 84
WHERE ProjectName = 'K Peirce'; 

UPDATE Projects
SET IRB_ID = 85
WHERE ProjectName = 'Facial Privacy'; 

UPDATE Projects
SET IRB_ID = 86
WHERE ProjectName = 'ABC-cT'; 

UPDATE Projects
SET IRB_ID = 87
WHERE ProjectName = 'FragileX'; 

-- Update Projects

UPDATE Projects
SET LAN_ID = 92
WHERE ProjectName = 'Wonder'; 

UPDATE Projects
SET LAN_ID = 93
WHERE ProjectName = 'K Peirce'; 

UPDATE Projects
SET LAN_ID = 94
WHERE ProjectName = 'Facial Privacy'; 

UPDATE Projects
SET LAN_ID = 95
WHERE ProjectName = 'ABC-cT'; 

UPDATE Projects
SET LAN_ID = 96
WHERE ProjectName = 'FragileX'; 

-- Update IRB

UPDATE IRB
SET Project_ID = 1
WHERE IRB_ID = '83'; 

UPDATE IRB
SET Project_ID = 2
WHERE IRB_ID = '86'; 

UPDATE IRB
SET Project_ID = 3
WHERE IRB_ID = '84'; 

UPDATE IRB
SET Project_ID = 4
WHERE IRB_ID = '85'; 

UPDATE IRB
SET Project_ID = 5
WHERE IRB_ID = '87'; 

-- Update Projects

UPDATE Projects
SET PublicationsID = 2
WHERE ProjectName = 'Facial Privacy'; 

UPDATE Projects
SET PublicationsID = 1
WHERE ProjectName = 'K Peirce'; 

UPDATE Projects
SET PublicationsID = 3
WHERE ProjectName = 'Wonder'; 

UPDATE Projects
SET PublicationsID = 4
WHERE ProjectName = 'ABC-cT'; 

UPDATE Projects
SET PublicationsID = 5
WHERE ProjectName = 'FragileX'; 

-- Update Publications

UPDATE Publications
SET Project_ID = 1
WHERE Journal = 'JADD'; 

UPDATE Publications
SET Project_ID = 2
WHERE Journal = 'Autism'; 

UPDATE Publications
SET Project_ID = 3
WHERE Journal = 'Computer Science'; 

UPDATE Publications
SET Project_ID = 5
WHERE Journal = 'Fraggy'; 

UPDATE Publications
SET Project_ID = 4
WHERE Journal = 'Data Mines'; 



-- DELETE FROM Licensing

-- ALTER TABLE LAN
-- DROP COLUMN UNIT_ID;

DROP TABLE Reg_Lic_Staff; 

-- update LAN for fiscal year using replace 

Select * from JobTitles
JOIN Staff_status SS on S.StaffID = SS.StaffID
Where Status_type = "Active";

Select S.StaffFname from JobTitles J
JOIN Staff S ON J.JOBS_ID = S.JOBS_ID
Where J.Titles = 'Psychometrist'

Select * from UNIT_Codes