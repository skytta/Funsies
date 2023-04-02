

/* 
-- Connect to the class server for this exercise.
-- IS-HAY09.iSchool.UW.EDU
-- UNIVERSITY database

The following 5 questions are based on material introduced in Module 6. The last 2 questions are similar in that each involve creating a stored procedure that calls other stored procedures (aka 'nested' procedures). There are four expectations when following best-practices:
1) the outer (aka 'calling') stored procedure will call each nested stored procedure to retrieve every foreign key value
2) the FK value that is retrieved via nested stored procedure will be placed into a variable before being used in any transaction
3) all input parameters of both the calling and nested procedures are to use 'name' values of foreign keys as opposed to hard-coding actual foreign key ID values
4) Assume identity() is enabled on all tables to auto-increment each primary key value
*/

/*
Q1  Write the SQL code to find the 3 staff who have worked at UW the longest under the following conditions. 
HINTS: 
1) Account for NULL values in EndDate for people still actively employed (they do not have an EndDate) by using ISNULL() function
2) Considering using DateDiff() with DAY in first position with the results divided by 365.25 to obtain decimal values in the result
3) Change the resulting value from 6 decimal places to 2 using CAST()
4) Consider only those staff that has a position of the following: 'Facilities Assistant', 'Academic Support Officer', 'Academic Compliance Director',
'Academic Tutor','Landscape Engineer', 'Grant Writer', 'Researcher'
*/




/*
Q2 Write the SQL code to find the top 3 Departments ordered by the most dollars received from RegistrationFees with the following conditions:
1) classes are '300-level' (Hint: CourseNumber begins with a '3') 
2) only measure fees from students that have the number '5' in the third position of their areacode
3) only measure fees that are associated with a registration date between March 3, 1997 and September 23, 2012
*/





/*
Q3 Write the SQL code to label every student into one of the following based on their birthdate and return a count of how many are under each label (HINT: this will be easiest if you use a CASE statement):
1) if they were born before January 1, 1925, label them as 'Greatest Generation'  
2) if they were born between 1925 and 1945, label them as 'Silent Generation'
3) if they were born between 1946 and 1964, label them as 'Baby Boomers'
4) if they were born between 1965 and 1976, label them as 'Generation X'
5) if they were born between 1977 and 1995, label them as 'Millenials'
6) Else 'Generation ZZZZZZZ'
*/



/*
Q4 Write the SQL to create a stored procedure to INSERT and new row into tblSTAFF_POSITION that calls three nested stored procedures (one for each FK). You will need to write the SQL code to create the nested stored procedures as well. Include an explicit transaction as well as error-handling if any variable ends-up NULL (either RAISERROR or THROW).

HINT: Use @Fname, @Lname, and @Birthdate as parameters to retrieve StaffID; use @DeptName to retrieve DeptID, and @PosName to obtain PositionID. There will be 2 additional parameters that pass values straight through to the INSERT statement, including @BeginDate and @EndDate (which may be NULL).
*/



/*
Q5 Write the SQL to create a stored procedure to INSERT and new row into tblCLASS that calls four nested stored procedures (one for each FK). You will need to write the SQL code to create the nested stored procedures as well. Include an explicit transaction as well as error-handling if any variable ends-up NULL (either RAISERROR or THROW).

HINT: Use @Q_Name to obtain QuarterID, @C_Name to obtain CourseID, @C_Room to obtain ClassroomID, and @ScheduleName to retrieve ScheduleID. There will be 2 additional parameters that pass values straight through to the INSERT statement, including @Year and @Section.
*/


