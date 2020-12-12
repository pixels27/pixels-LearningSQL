/* --------------------------------------------------------------
--   Student ID: 6288034
--   Fullname: Pranungfun Prapaenee
--   Section: 2
------------------------------------------------------------- */

use `tinycollege3`;

-- 1.) Display class code, course name, professor's first name, professor's last name 
-- and number of students in each class of the class section 3

SELECT class.CLASS_CODE, course.COURSE_CODE, professor.EMP_FNAME, professor.EMP_LNAME, COUNT(*) AS "num_stu" FROM class
JOIN course ON course.COURSE_CODE = class.COURSE_CODE
JOIN professor ON professor.EMP_NUM = class.EMP_NUM
JOIN enroll ON enroll.CLASS_CODE = class.CLASS_CODE
WHERE class.CLASS_SECTION = 3 -- section3
GROUP BY class.CLASS_CODE;

-- 2.) Display class code and course names that have no student enrolled, 
-- e.g. the number of students of those classes is 0. Sort the result by class code.

SELECT class.CLASS_CODE, course.COURSE_NAME FROM class
JOIN course ON class.COURSE_CODE = course.COURSE_CODE
WHERE CLASS_CODE NOT IN (SELECT CLASS_CODE FROM enroll);

-- 3.) List all names (first name and last name) and their ID of students 
-- and professors whose first names begin with "C".

SELECT student.STU_FNAME AS "first name", student.STU_LNAME AS "last name", student.STU_NUM AS "ID" FROM student
WHERE student.STU_FNAME LIKE "C%"
UNION
SELECT professor.EMP_FNAME, professor.EMP_LNAME, professor.EMP_NUM FROM professor
WHERE professor.EMP_FNAME LIKE "C%";

-- 4.) List all course codes that are enrolled by Section 1but not enrolled by Section 2. 
-- Sort the result alphabetically. ​Hint​: There are 25 unique courses enrolled by Section 1 
-- and there are 14 unique courses enrolled by Section 2.

SELECT class.COURSE_CODE FROM class
WHERE class.COURSE_CODE NOT IN (SELECT COURSE_CODE FROM class 
WHERE class_section = 2)
ORDER BY class.COURSE_CODE ASC;

--  5.) List all students' first names that are also the first names of professors. Sort the result alphabetically.

SELECT distinct student.STU_FNAME FROM student
WHERE student.STU_FNAME IN (SELECT EMP_FNAME FROM professor)
ORDER BY student.STU_FNAME ASC;

-- 6.) Find the list of students (first name, last name, and student GPA) 
-- whose their GPAs are higher than the average GPA of "MATH" students. 
-- Sort the result by the highest to lowest GPA. ​Hint:​The average GPA of “MATH” students is 3.32.

SELECT student.STU_FNAME, student.STU_LNAME, student.STU_GPA FROM student
WHERE student.STU_GPA > (SELECT avg(STU_GPA) FROM student 
WHERE dept_code = "MATH")
ORDER BY student.STU_GPA DESC;

-- 7.) Create a view, named "​vw_topstudents​" to store a list of top students 
-- (student number,first name, last name, student GPA, and department code)
-- who have the highest GPA in each department

CREATE VIEW vw_topstudents AS
SELECT student.STU_NUM, student.STU_FNAME, student.STU_LNAME, student.STU_GPA, student.DEPT_CODE FROM student
WHERE student.STU_GPA =  ANY (SELECT Max(STU_GPA) AS STU_GPA FROM student GROUP BY DEPT_CODE)

ORDER BY student.DEPT_CODE ASC;

SELECT * FROM vw_topstudents;