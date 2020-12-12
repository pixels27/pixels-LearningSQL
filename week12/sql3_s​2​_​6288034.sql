/* --------------------------------------------------------------
--   Student ID: 6288034
--   Fullname: Pranungfun Prapaenee
--   Section: 2
------------------------------------------------------------- */

use `tinycollege2`;

-- 1.) List the top 10 oldest professors (firstname and last name) and their age at 2020.
-- The result must contain two columns: Name and Age, sorted by the oldest professor to the youngest one.
SELECT CONCAT(EMP_FNAME,' ',EMP_LNAME), 2020 - YEAR(EMP_DOB) AS "AGE"
FROM professor 
ORDER BY YEAR(EMP_DOB) ASC 
LIMIT 10;

-- 2.) Find the average GPA of "CIS" student. The result must have only one column named "Average CIS GPA" 
-- and the average GPA must be rounded into 2 decimal places
SELECT ROUND(AVG(STU_GPA),2) AS "Average CIS GPA" 
FROM student WHERE DEPT_CODE = "CIS";

-- 3.) Find how many 3-credit courses in total offered by "CIS", "MATH", "BIOL" and "ENG". 
-- The result must have only one column named "# of Courses"
-- Hint:​ All 9 courses include ​CIS-220, CIS-320, CIS-370, ENG-210, ENG-220, MATH-120, MATH-243, QM-261,​ and​ SPCH-240
SELECT COUNT(CRS_CREDIT) AS "# of Courses" 
FROM course WHERE CRS_CREDIT = 3 AND DEPT_CODE IN ("CIS","MATH","ENG","BIOL");

-- 4.) Find the total numbers of students of in each of the following departments: "CIS", "MATH", "BIOL" and "ENG" department. 
-- The result must contain two columns: ​dept_code​ and "Total # of Students"
SELECT DEPT_CODE, COUNT(STU_NUM) AS "Total # of Students" 
FROM student WHERE DEPT_CODE IN ("CIS", "MATH", "BIOL", "ENG")
GROUP BY DEPT_CODE ;

-- 5.) List all departments (department code) and the average GPA of their (displayed in 2 decimal places).
-- The result must have two columns: dept_code​ and "Average GPA", ranked from the highest GPA value to the lowest one
SELECT DEPT_CODE, ROUND(AVG(STU_GPA),2) AS  "Average GPA" 
FROM student
GROUP BY DEPT_CODE
ORDER BY ROUND(AVG(STU_GPA),2) DESC;

-- 6.) List all departments (department code) that have the average GPA of their students higher than 3.00.
-- The result must have two columns: ​dept_code and "Average GPA" displayed in 2 decimal places
-- and ranked from the highest value to the lowest one
SELECT DEPT_CODE, ROUND(AVG(STU_GPA),2) AS  "Average GPA" 
FROM student
GROUP BY DEPT_CODE
HAVING ROUND(AVG(STU_GPA),2) > 3.00
ORDER BY ROUND(AVG(STU_GPA),2) DESC;

-- 7.) Find the total numbers of students and the average GPA of students of each class (e.g. 1, 2, 3 and 4). 
-- The result must have three columns: ​stu_class and "Total students" and "Average GPA" displayed in 2 decimal places and ordered by class.
-- Also, the result should exclude the students who do not have the GPA reported from the counting and averaging list.
SELECT STU_CLASS, COUNT(STU_CLASS) AS "Total students", AVG(STU_GPA) AS "Average GPA" 
FROM student WHERE STU_GPA IS NOT NULL
GROUP BY STU_CLASS
ORDER BY ROUND(AVG(STU_GPA),2) ASC;

-- 8.) List all students who have their professor name begin with ​"P"​ or ​"A"​.
-- The result must have three columns: ​stu_num​, "student", (student firstname and lastname) 
-- and "advisor" (professor firstname and lastname), sorted by advisor’s names alphabetically
SELECT STU_NUM, CONCAT(STU_FNAME,' ',STU_LNAME) AS "student", CONCAT(P.EMP_FNAME,' ',P.EMP_LNAME) AS "advisor" 
FROM student INNER JOIN professor AS P 
ON student.EMP_NUM = P.EMP_NUM AND (P.EMP_FNAME LIKE "P%" OR P.EMP_FNAME LIKE "A%")
ORDER BY CONCAT(P.EMP_FNAME,' ',P.EMP_LNAME) ASC;

-- 9.) List all "CIS" professor who teach at least three classes.
-- The result must have four columns: ​emp_num​, ​dept_code​, "professor" (professor firstname and lastname) and "Total classes"
SELECT P.EMP_NUM,P.DEPT_CODE,CONCAT(P.EMP_FNAME," ",P.EMP_LNAME) AS "professor", COUNT(P.EMP_NUM) AS "Total classes" 
FROM professor AS P
JOIN class AS C	ON P.EMP_NUM = C.EMP_NUM
GROUP BY P.EMP_NUM,P.DEPT_CODE
HAVING COUNT(P.EMP_NUM) > 3 AND P.DEPT_CODE = "CIS"
ORDER BY COUNT(P.EMP_NUM) DESC;

-- 10.) Show the grade report of the students who took any courses beginning with "CIS"​.
-- The result must consists of ​stu_fname​, ​stu_lname​, ​class_code​, grade​ and ​course_code​ 
-- and must be sorted by ​course_code​ and then grade​ respectively
SELECT s.STU_FNAME, s.STU_LNAME, c.CLASS_CODE,e.GRADE,c.COURSE_CODE
FROM student as s
JOIN enroll as e on s.STU_NUM = e.STU_NUM
JOIN class as c on e.CLASS_CODE = c.CLASS_CODE
where c.COURSE_CODE like "cis%"
order by c.COURSE_CODE, e.GRADE;