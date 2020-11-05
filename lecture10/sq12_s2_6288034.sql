/* --------------------------------------------------------------
--   Student ID: 6288034
--   Fullname: Pranungfun Prapaenee
--   Section: 2
------------------------------------------------------------- */

-- part II
INSERT INTO professor
VALUES 	(101, "Charles", "Xavier", "1975-05-04 00:00:00 PM", "CIS", NULL),
		(702, "Stephen", "Strange", "1988-07-04 00:00:00 PM", "BIOS", 7702);

INSERT INTO student
VALUES	(773355, "Pranungfun", "Prapaenee", "2000-12-27 00:00:00 PM", 2, NULL, "CIS","702");

UPDATE student
SET EMP_NUM = 101 WHERE STU_NUM = 773355;

UPDATE professor
SET PROF_EXTENSION = 0077 WHERE EMP_NUM = 101;

DELETE FROM professor
WHERE EMP_NUM = 702; -- remove Dr.Strange

-- part III

SELECT * FROM student;

SELECT EMP_FNAME, EMP_LNAME, DEPT_CODE
FROM professor WHERE DEPT_CODE = "CIS";

SELECT EMP_FNAME, EMP_LNAME
FROM professor
WHERE EMP_FNAME LIKE "%m%" AND EMP_LNAME LIKE "%m%";

SELECT STU_FNAME, STU_LNAME, DEPT_CODE
FROM student
WHERE DEPT_CODE IN ("ENG", "ART", "SOC", "HIST")
ORDER BY DEPT_CODE ASC ;

SELECT COURSE_CODE, COURSE_NAME, (CRS_CREDIT*250) AS "tuition free",
DEPT_CODE FROM course WHERE COURSE_NAME LIKE "Intro.%"
ORDER BY DEPT_CODE;

SELECT DISTINCT COURSE_CODE, CLASS_ROOM
FROM class
WHERE CLASS_ROOM LIKE "KLR%" AND CLASS_CODE BETWEEN 20000 AND 30000 ;