/* --------------------------------------------------------------
--   Please fill in your information in this comment block --  
--   Student ID: 6288034
--   Fullname: Pranungfun Prapaenee
--   Section: 2
------------------------------------------------------------- */
DROP DATABASE IF EXISTS tinycompany; 
CREATE DATABASE IF NOT EXISTS tinycompany;
USE tinycompany;
-- Department Table 
CREATE TABLE department(
	dnumber		INT 		 PRIMARY KEY,  -- dnumber is a primary key
	dname		VARCHAR(20)  NOT NULL,
	location	VARCHAR(100), -- location is nullable 
	CONSTRAINT chk_dnumber CHECK (dnumber >= 1 AND dnumber <=20 ) -- dnumber range from 1 to 20
);

-- Project Table 
CREATE TABLE project(
	pnumber		INT 		 PRIMARY KEY,  -- dnumber is a primary key
	pname		VARCHAR(50)  NOT NULL,
	dept_no	 	INT 		 NOT NULL,
	CONSTRAINT FK_deptProj FOREIGN KEY (dept_no) REFERENCES department(dnumber)
);

-- Write your DDL for employee and assignment here 
-- Hint: Review the CREATE sequence, i.e., which tables should be created first

CREATE TABLE employee(
	fname		VARCHAR(20) NOT NULL,
    lname		VARCHAR(20) NOT NULL,
    ssn			VARCHAR(9), -- PK
    bdate		DATE,
    sex			VARCHAR(1),
    salary		decimal(12,2),
    dept_no		int,        -- FK
	PRIMARY KEY (ssn),
    CONSTRAINT FK_EmpDept FOREIGN KEY (dept_no) REFERENCES department(dnumber),
    CONSTRAINT chk_sex CHECK (sex = "M" AND sex = "F" )
);

CREATE TABLE assignment(
	essn		varchar(9), -- PK
	projno		int,        -- PK
    hours		decimal(9,2),
    hourlyrate	decimal(9,2),
    primary key (essn, projno),
    CONSTRAINT FK_AsmEmp FOREIGN KEY (essn) REFERENCES employee(ssn),
	CONSTRAINT FK_AsmPrj FOREIGN KEY (projno) REFERENCES project(pnumber)
);