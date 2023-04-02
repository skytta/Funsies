



/*
Reminders:
-- This set of queries require a connection to IS-HAY10.iSchool.uw.edu so please refer to section 1.14 to get downloaded software and connection credentials
-- Anytime you wish to execute or run a block of code (a 'query'), simply highlight the block and hit [Ctrl + E] keys at the same time. 
-- Alternatively, you can highlight a block of code and select the EXECUTE button from the top menu bar
-- [Ctrl + N] will create a brand new, empty query window if there are too many practice questions on your screen (it can get crowded!)

1) Write the SQL query to return StudentFname, StudentLname and StudentBirth from tblSTUDENT to determine which students were born after November 5, 1996.
2) Write the code to return StudentFname, StudentLname and StudentBirth from tblSTUDENT to determine the students who have StudentPermState in either ‘Texas, TX’ or ‘Idaho, ID’.
3) Write the SQL query to return the building names as well as YearOpened from tblBUILDING for all buildings that opened before 1960.
4) Write the SQL query to determine the type classrooms that are available in buildings around campus that have a seating capacity greater than 15. 
5) Write the SQL query to list the CourseName, CourseNumber and Credits from tblCOURSE for all courses that are greater than 1 credit.
*/

/*
1) Write the SQL query to return StudentFname, StudentLname and StudentBirth from tblSTUDENT to determine which students were born after November 5, 1996.

-- Let us break down this question into parts; the SELECT line, the FROM clause as well as the WHERE clause. We have seen all of this before!

SELECT --> will contain the column(s) required. Question 1 asks for StudentFname, StudentLname and StudentBirth (these are the columns).

SELECT StudentFname, StudentLname, StudentBirth

-- now let us evaluate the FROM clause. Question 1 states 'from tblSTUDENT' but we can check for ourselves; do we need to JOIN any other tables? Nope! 
-- All three columns requested for this query are contained in tblSTUDENT so the FROM clause will have just tblSTUDENT (no JOIN required).
*/
SELECT StudentFname, StudentLname, StudentBirth
FROM tblSTUDENT


/*
-- The code immediately above is 'valid' in the sense that it will run and return a ton of rows (go ahead and give it a try! it might take upwards of 10 seconds to return any rows so please be patient).
-- The code above does not have a filter and therefore returned upwards of 536,000 rows (look in lower right of your screen for '535981 rows')
-- The filter requested for question 1 is '...which students were born after November 5, 1996'. This will need to be added to the basic query in the WHERE clause.
-- HINT: Date columns are pretty forgiving when it comes to format or spelling. You can write 'November 5, 1996', 'Nov 5, 96', '11/5/96' as well as several other variations and they all work. Give it a try!
-- Please be aware of the '>' greater-than sign; this is important too as a simple mistake here will greatly affect results. Change the direct to '<' and '=' to see how results are affected.
*/
SELECT StudentFname, StudentLname, StudentBirth
FROM tblSTUDENT
WHERE StudentBirth > 'November 5, 1996'

-- when the filter of StudentBirth is applied, only 11119 rows are returned. Take a look at the last column of your results and verify for yourself!
-- change the date value a few times; see how quickly the results respond?


/*
2) Write the code to return StudentFname, StudentLname and StudentBirth from tblSTUDENT to determine the students who have StudentPermState in either ‘Texas, TX’ or ‘Idaho, ID’.
-- Question #2 is very similar to Question #1; in fact the only thing that will change is the WHERE clause.
-- A little trick to save some keystrokes is to use keyword IN
-- Highlight and execute the following code:
*/

SELECT StudentFname, StudentLname, StudentBirth
FROM tblSTUDENT
WHERE StudentPermState IN ('Texas, TX', 'Idaho, ID') 

-- 31461 rows should be returned by the above query 
-- the UNIVERSITY database has state abbreviations included in the name of each state (a little bit odd and will take getting used to)
-- please experiment with minor alterations of the WHERE clause by changing the values of the states in parentheses (do not forget to include the 2 character abbreviation!)


/*
3) Write the SQL query to return the building names as well as YearOpened from tblBUILDING for all buildings that opened before 1960.
-- Question #3 is not a whole lot different than the first two questions in structure 
-- You will be drawing data from tblBUILDING as opposed to tblSTUDENT
-- Please note that YearOpened does not require a full MM/DD/YYYY date format, just a year.
-- Highlight and execute the following code:
*/

SELECT BuildingName, YearOpened
FROM tblBUILDING
WHERE YearOpened < '1969'
-- 59 rows should be returned by the above query
-- please experiment with minor alterations of the WHERE clause by changing the value or the operator '>' 




/*
4) Write the SQL query to determine the type classrooms that are available in buildings around campus that have a seating capacity greater than 15. 
-- This query is getting a bit more complex! The data requested from this question requires a couple of JOIN commands to connect multiple tables together.
-- take a look at the UNIVERSITY data model and locate tblCLASSROOM, tblCLASSROOM_TYPE and tblBUILDING. You will need to connect these three tables together in question #4
-- Be sure to connect tables together via primary key - foreign key relationships!
-- Also, be comfortable substituting aliases for tablenames to reduce the amount of typing required (these are often just single letters in place of entire names)
-- Highlight and execute the following code:
*/
SELECT B.BuildingName, CT.ClassroomTypeName
FROM tblBUILDING B
	JOIN tblCLASSROOM CM ON B.BuildingID = CM.BuildingID
	JOIN tblCLASSROOM_TYPE CT ON CM.ClassroomTypeID = CT.ClassroomTypeID
WHERE CT.SeatingCapacity > 15

-- 1339 rows should be returned by the query above
-- please experiment with minor alterations of the WHERE clause by changing the number value or the operator '>' to '<' or '='



/*
5) Write the SQL query to list the CourseName, CourseNumber and Credits from tblCOURSE for all courses that are greater than 1 credit.
-- This question is back to a single table to answer the entire query (no JOIN required)
-- Highlight and execute the following code:
*/
SELECT CourseName, CourseNumber, Credits
FROM tblCOURSE
WHERE Credits > 1

-- 10014 rows should be returned
-- please experiment with minor alterations of the WHERE clause by changing the number value or the operator '>' to '<' or '='


