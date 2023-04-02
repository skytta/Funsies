USE UNIVERSITY
/*

1) Write the SQL query to determine the departments that held fewer than 230 classes in buildings on Stevens Way 
between 2011 and 2016 that also generated more than $16.5 million from registration fees in the 1990's that also 
had more than 400 distinct (!!) students complete a 400-level course in the 1980's
*/
-- departments that held fewer than 230 classes in buildings on Stevens Way 
SELECT C.CollegeID, D.DeptName, COUNT(CS.ClassID) AS NumClassesStevensWay
FROM tblCOLLEGE C
	JOIN tblDEPARTMENT D ON C.CollegeID = D.CollegeID
	JOIN tblCOURSE CR ON D.DeptID = CR.DeptID
	JOIN tblCLASS CS ON CR.CourseID = CS.CourseID
	JOIN tblCLASSROOM CM ON CS.ClassroomID = CM.ClassroomID
	JOIN tblBuilding B ON CM.BuildingID = B.BuildingID
	JOIN tblLOCATION L ON B.LocationID = L.LocationID
WHERE CS.[YEAR] BETWEEN '2011' AND '2016'
	AND L.LocationName = 'Stevens Way'
GROUP BY C.CollegeID, D.DeptName
HAVING COUNT(CS.ClassID) < 230
-- generated more than $16.5 million from registration fees in the 1990's
SELECT C.CollegeID, D.DeptName, SUM(CL.RegistrationFee) AS TotalRegFee_1990s
FROM tblCOLLEGE C
	JOIN tblDEPARTMENT D ON C.CollegeID = D.CollegeID
	JOIN tblCOURSE CR ON D.DeptID = CR.DeptID
	JOIN tblCLASS CS ON CR.CourseID = CS.CourseID
	JOIN tblCLASS_LIST CL ON CS.ClassID = CL.ClassID
WHERE CS.[YEAR] LIKE '199%'
GROUP BY C.CollegeID, D.DeptName
HAVING SUM(CL.RegistrationFee) > 16500000
-- more than 400 students complete a 400-level course in the 1980's
SELECT C.CollegeID, D.DeptName, COUNT(DISTINCT CL.StudentID) AS TotalStudents_400_Level
FROM tblCOLLEGE C
	JOIN tblDEPARTMENT D ON C.CollegeID = D.CollegeID
	JOIN tblCOURSE CR ON D. DeptID = CR.DeptID
	JOIN tblCLASS CS ON CR.CourseID = CS.CourseID
	JOIN tblCLASS_LIST CL ON CS.ClassID = CL.ClassID
WHERE CS.[YEAR] LIKE '198%'
	AND CR.CourseNumber LIKE '4%'
GROUP BY C.CollegeId, D.DeptName
HAVING COUNT(DISTINCT CL.StudentID) > 400


--hooking everything together with a WRAPPER

SELECT A.CollegeID, A.DeptName, A.NumClassesStevensWay, B.TotalRegFee_1990s, C.TotalStudents_400_Level
FROM
(SELECT C.CollegeID, D.DeptName, COUNT(CS.ClassID) AS NumClassesStevensWay
FROM tblCOLLEGE C
	JOIN tblDEPARTMENT D ON C.CollegeID = D.CollegeID
	JOIN tblCOURSE CR ON D. DeptID = CR.DeptID
	JOIN tblCLASS CS ON CR.CourseID = CS.CourseID
	JOIN tblCLASSROOM CM ON CS.ClassroomID = CM.ClassroomID
	JOIN tblBUILDING B ON CM.BuildingID = B.BuildingID
	JOIN tblLOCATION L ON B. LocationID = L.LocationID
WHERE CS.[YEAR] BETWEEN '2011' AND '2016'
	AND L.LocationName = 'Stevens Way'
GROUP BY C.CollegeID, D.DeptName
HAVING COUNT(CS.CLassID) < 230) A,

(SELECT C.CollegeId, D.DeptName, SUM(CL.RegistrationFee) AS TotalRegFee_1990s
FROM tblCOLLEGE C
	JOIN tblDEPARTMENT D ON C.CollegeID = D.CollegeID
	JOIN tblCOURSE CR ON D. DeptID = CR.DeptID
	JOIN tblCLASS CS ON CR.CourseID = CS.CourseID
	JOIN tblCLASS_LIST CL ON CS.ClassID = CL.ClassID
WHERE CS.[YEAR] LIKE '199%'
GROUP BY C.CollegeID, D.DeptName
HAVING SUM(CL.RegistrationFee) > 16500000) B,

(SELECT C. CollegeID, D.DeptName, COUNT(DISTINCT CL.StudentID) AS TotalStudents_400_Level
FROM tblCOLLEGE C
	JOIN tblDEPARTMENT D ON C.CollegeID = D.CollegeID
	JOIN tblCOURSE CR ON D. DeptID = CR.DeptID
	JOIN tblCLASS CS ON CR.CourseID = CS.CourseID
	JOIN tblCLASS_LIST CL ON CS.ClassID = CL.ClassID
WHERE CS.[YEAR] LIKE '198%'
	AND CR.CourseNumber LIKE '4%'
GROUP BY C.CollegeID, D.DeptName
HAVING COUNT(DISTINCT CL.StudentID) >400) C

WHERE A.CollegeID = B.CollegeID AND B.CollegeID = C.CollegeID


/*
2) Which students with the special need of 'Anxiety' have completed more than 13 credits of 300-level 
Information School classes with a grade less than 3.1 in the last 3 years?
*/
SELECT S.StudentID, S.StudentFname, S.StudentLname, SUM(C.Credits) AS MoreThan13Credits_300Level
FROM tblSPECIAL_NEED SN
    JOIN tblSTUDENT_SPECIAL_NEED SSN ON SN.SpecialNeedID = SSN.SpecialNeedID
    JOIN tblSTUDENT S ON SSN.StudentID = S.StudentID
    JOIN tblSTUDENT_STATUS SS ON S.StudentID = SS.StudentID
    JOIN tblCLASS_LIST CLL ON S.StudentID = CLL.StudentID
    JOIN tblCLASS CL ON CLL.ClassID = CL.ClassID
    JOIN tblCOURSE C ON CL.CourseID = C.CourseID
    JOIN tblDEPARTMENT D ON C.DeptID = D.DeptID
    JOIN tblCOLLEGE CG ON D.CollegeID = CG.CollegeID
WHERE SN.SpecialNeedName = 'Anxiety'
    AND C.CourseNumber LIKE '3%'
    AND CG.CollegeName = 'Information School'
    AND CLL.Grade < 3.1
    AND SS.BeginDate < DATEADD(YEAR, -3,GETDATE())
GROUP BY S.StudentID, S.StudentFname, S.StudentLname
HAVING SUM(C.Credits) > 13
ORDER BY MoreThan13Credits_300Level DESC

/*
3) Write the SQL to determine the top 10 states by number of students who have completed both 15 credits of Arts and Science courses
as well as between 5 and 18 credits of Medicine since 2003.
*/
-- op 10 states by number of students 

SELECT TOP 10 S.StudentPermState, COUNT(*) AS NumStudent
FROM tblSTUDENT S
    JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
    JOIN tblCLASS C ON CL.ClassID = C.ClassID
    JOIN tblCOURSE CO ON C.CourseID = CO.CourseID
    JOIN tblDEPARTMENT D ON CO.DeptID = D.DeptID
    JOIN tblCOLLEGE CG ON D.CollegeID = CG.CollegeID
GROUP BY S.StudentPermState
ORDER BY NumStudent DESC

-- Arts and Sciences Credits

SELECT S.StudentID, S.StudentPermState, SUM(CO.Credits) AS Arts_Sciences_Credits
FROM tblSTUDENT S
    JOIN tblCLASS_LIST CLL ON S.StudentID = CLL.StudentID
    JOIN tblCLASS CL ON CLL.ClassID = CL.ClassID
    JOIN tblCOURSE CO ON CL.CourseID = CO.CourseID
    JOIN tblDEPARTMENT D ON CO.DeptID = D.DeptID
    JOIN tblCOLLEGE CG ON D.CollegeID = CG.CollegeID
WHERE CG.CollegeName = 'Arts and Sciences'
GROUP BY S.StudentID, S.StudentPermState
HAVING SUM(CO.Credits) = 15

-- between 5 and 18 credits of Medicine since 2003

SELECT S.StudentID, S.StudentPermState, SUM(CO.Credits) AS MedCredits_5_18
FROM tblSTUDENT S
    JOIN tblCLASS_LIST CLL ON S.StudentID = CLL.StudentID
    JOIN tblCLASS CL ON CLL.ClassID = CL.ClassID
    JOIN tblCOURSE CO ON CL.CourseID = CO.CourseID
    JOIN tblDEPARTMENT D ON CO.DeptID = D.DeptID
    JOIN tblCOLLEGE CG ON D.CollegeID = CG.CollegeID
WHERE CG.CollegeName = 'Medicine'
    AND CL.[YEAR] >= 2003
GROUP BY S.StudentID, S.StudentPermState
HAVING SUM(CO.Credits) BETWEEN 5 AND 18

--Now JOIN
SELECT TOP 10 C.StudentPermState, COUNT(*) AS NumStudent
FROM
(SELECT A.StudentID, A.StudentPermState, A.Arts_Sciences_Credits, B.MedCredits_5_18
    FROM

    (SELECT S.StudentID, S.StudentPermState, SUM(CO.Credits) AS Arts_Sciences_Credits
        FROM tblSTUDENT S
            JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
            JOIN tblCLASS C ON CL.ClassID = CL.ClassID
            JOIN tblCOURSE CO ON C.CourseID = CO.CourseID
            JOIN tblDEPARTMENT D ON CO.DeptID = D.DeptID
            JOIN tblCOLLEGE CG ON D.CollegeID = CG.CollegeID
        WHERE CG.CollegeName = 'Arts and Sciences'
        GROUP BY S.StudentID, S.StudentPermState
        HAVING SUM(CO.Credits) = 15) A,

    (SELECT S.StudentID, S.StudentPermState, SUM(CO.Credits) AS MedCredits_5_18
        FROM tblSTUDENT S
            JOIN tblCLASS_LIST CLL ON S.StudentID = CLL.StudentID
            JOIN tblCLASS CL ON CLL.ClassID = CL.ClassID
            JOIN tblCOURSE CO ON CL.CourseID = CO.CourseID
            JOIN tblDEPARTMENT D ON CO.DeptID = D.DeptID
            JOIN tblCOLLEGE CG ON D.CollegeID = CG.CollegeID
        WHERE CG.CollegeName = 'Medicine'
            AND CL.[YEAR] >= 2003
        GROUP BY S.StudentID, S.StudentPermState
        HAVING SUM(CO.Credits) BETWEEN 5 AND 18) B

    WHERE A.StudentID = B.StudentID) C
GROUP BY C.StudentPermState
ORDER BY NumStudent DESC

--
/*
4) Write the SQL to determine the students who are currently assigned a dormroom type 'Triple' on West Campus 
who have paid more than $2,000 in registration fees in the past four years?
*/
--First tbl
SELECT S.StudentID, S.StudentFname, S.StudentLname, L.LocationName
FROM tblLOCATION L
    JOIN tblBUILDING B ON L.LocationID = B.LocationID
    JOIN tblDORMROOM D ON B.BuildingID = D.BuildingID
    JOIN tblDORMROOM_TYPE DT ON D.DormRoomTypeID = DT.DormRoomTypeID
    JOIN tblSTUDENT_DORMROOM SD ON D.DormRoomID = SD.DormRoomID
    JOIN tblSTUDENT S ON SD.StudentID = S.StudentID
    JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
WHERE DT.DormRoomTypeName = 'Triple'
    AND L.LocationName = 'West Campus'
    AND SD.EndDate IS NULL
GROUP BY S.StudentID, S.StudentFname, S.StudentLname, L.LocationName


--who have paid more than $2,000 in registration fees in the past four years?
SELECT S.StudentID, S.StudentFname, S.StudentLname, SUM(CL.RegistrationFee) AS RegFee2k
FROM tblLOCATION L
    JOIN tblBUILDING B ON L.LocationID = B.LocationID
    JOIN tblDORMROOM D ON B.BuildingID = D.BuildingID
    JOIN tblDORMROOM_TYPE DT ON D.DormRoomTypeID = DT.DormRoomTypeID
    JOIN tblSTUDENT_DORMROOM SD ON D.DormRoomID = SD.DormRoomID
    JOIN tblSTUDENT S ON SD.StudentID = S.StudentID
    JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
WHERE SD.BeginDate >= DATEADD(YEAR, -4, GETDATE())
GROUP BY S.StudentID, S.StudentFname, S.StudentLname
HAVING SUM(CL.RegistrationFee) > 2000
ORDER BY SUM( CL.RegistrationFee) DESC

--putting it all together

SELECT S.StudentID, S.StudentFname, S.StudentLname, L.LocationName, subq1.RegFee2k
FROM tblLOCATION L
    JOIN tblBUILDING B ON L.LocationID = B.LocationID
    JOIN tblDORMROOM D ON B.BuildingID = D.BuildingID
    JOIN tblDORMROOM_TYPE DT ON D.DormRoomTypeID = DT.DormRoomTypeID
    JOIN tblSTUDENT_DORMROOM SD ON D.DormRoomID = SD.DormRoomID
    JOIN tblSTUDENT S ON SD.StudentID = S.StudentID
    JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID

    JOIN(SELECT S.StudentID, S.StudentFname, S.StudentLname, SUM(CL.RegistrationFee) AS RegFee2k
            FROM tblLOCATION L
                JOIN tblBUILDING B ON L.LocationID = B.LocationID
                JOIN tblDORMROOM D ON B.BuildingID = D.BuildingID
                JOIN tblDORMROOM_TYPE DT ON D.DormRoomTypeID = DT.DormRoomTypeID
                JOIN tblSTUDENT_DORMROOM SD ON D.DormRoomID = SD.DormRoomID
                JOIN tblSTUDENT S ON SD.StudentID = S.StudentID
                JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
            WHERE SD.BeginDate >= DATEADD(YEAR, -4, GETDATE())
            GROUP BY S.StudentID, S.StudentFname, S.StudentLname
            HAVING SUM(CL.RegistrationFee) > 2000) AS subq1 ON S.StudentID = subq1.StudentID

WHERE DT.DormRoomTypeName = 'Triple'
    AND L.LocationName = 'West Campus'
    AND SD.EndDate IS NULL
GROUP BY S.StudentID, S.StudentFname, S.StudentLname,L.LocationName, subq1.RegFee2k
