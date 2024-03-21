
--List all the student details studying in the fourth semester ‘C’ section.

SELECT S.*, SS.SEM, SS.SEC
FROM STUDENT S, SEMSEC SS, CLASS C
WHERE S.USN = C.USN AND
SS.SSID = C.SSID AND
SS.SEM = 4 AND SS.SEC='C';

----------------------------------------

--Compute the total number of male and female students in each semester and each section.

SELECT SS.SEM, SS.SEC, S.GENDER, COUNT(S.GENDER) AS COUNT
FROM STUDENT S, SEMSEC SS, CLASS C
WHERE S.USN = C.USN AND
SS.SSID = C.SSID
GROUP BY SS.SEM, SS.SEC, S.GENDER
ORDER BY SEM;

----------------------------------------

--Create a view of Test1 marks of student USN ‘1BI15CS101’ in all Courses.

CREATE VIEW STUDENT_TEST1_MARKS_V
AS
SELECT TEST1, SUBCODE
FROM IAMARKS
WHERE USN = '1BI15CS101';

SELECT * FROM STUDENT_TEST1_MARKS_V;

----------------------------------------

--Calculate the FinalIA (average of best two test marks) and update the corresponding table for all students.


UPDATE IAMARKS
	SET FINALIA=(TEST1+TEST2+TEST3 - LEAST(TEST1,TEST2,TEST3))/2;

SELECT * FROM IAMARKS;

--------------------------------------------

-- Categorize students based on the following criterion:
-- If FinalIA = 17 to 20 then CAT = ‘Outstanding’
-- If FinalIA = 12 to 16 then CAT = ‘Average’
-- If FinalIA< 12 then CAT = ‘Weak’
-- Give these details only for 8th semester A, B, and C section students.

SELECT S.USN,S.SNAME,S.ADDRESS,S.PHONE,S.GENDER, IA.SUBCODE,
(CASE
WHEN IA.FINALIA BETWEEN 17 AND 20 THEN 'OUTSTANDING'
WHEN IA.FINALIA BETWEEN 12 AND 16 THEN 'AVERAGE'
ELSE 'WEAK'
END) AS CAT
	
FROM STUDENT S, SEMSEC SS, IAMARKS IA, SUBJECT SUB
WHERE S.USN = IA.USN AND
SS.SSID = IA.SSID AND
SUB.SUBCODE = IA.SUBCODE AND
SUB.SEM = 8;

