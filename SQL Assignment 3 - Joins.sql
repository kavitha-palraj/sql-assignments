/* 1. How many Programmers Don't know PASCAL and C */
SELECT COUNT(PNAME) AS NOOFPROGRAMMERS
FROM PROGRAMMER
WHERE PROF1 NOT IN ('PASCAL' , 'C') AND PROF2 NOT IN ( 'PASCAL', 'C');

/* 2. Display the details of those who don’t know Clipper, COBOL or PASCAL. */
SELECT *
FROM PROGRAMMER
WHERE PROF1 NOT IN ('Clipper', 'COBOL', 'PASCAL') AND PROF2 NOT IN ('Clipper', 'COBOL', 'PASCAL')

/* 3. Display each language name with AVG Development Cost, AVG Selling Cost and AVG Price per Copy. */
SELECT DEVELOPIN, AVG(DCOST) AS AVGDCOST, AVG(SCOST) AS AVGSCOST, AVG(SCOST) AS AVGPRICEPERCOPY 
FROM SOFTWARE
GROUP BY (DEVELOPIN);

/* 4. List the programmer names (from the programmer table) and No. Of Packages each has developed. */
SELECT p.PNAME,  COUNT(s.TITLE) as NOOFPACKAGES
FROM PROGRAMMER p
INNER JOIN SOFTWARE s ON p.PNAME = s.PNAME
GROUP BY p.PNAME;

/* 5. List each PROFIT with the number of Programmers having that PROF and the number of the packages in that PROF. */
SELECT COUNT(PNAME) AS NOOFPROGRAMMERS, COUNT(TITLE) AS NOOFPACKAGES, SUM(SCOST*SOLD - DCOST) AS PROFIT
FROM SOFTWARE
WHERE DEVELOPIN IN (SELECT PROF1 FROM PROGRAMMER) AND DEVELOPIN IN (SELECT PROF2 FROM PROGRAMMER) AND ((SCOST*SOLD - DCOST) > 0)
GROUP BY PNAME;

/* 6. How many packages are developed by the most experienced programmer form BDPS. */
SELECT COUNT(s.TITLE) AS NOOFPACKAGES
FROM SOFTWARE s
INNER JOIN PROGRAMMER p ON p.PNAME = s.PNAME
INNER JOIN STUDIES st ON st.PNAME = s.PNAME
WHERE st.INSTITUTE = 'BDPS' AND p.DOJ= (SELECT MIN(DOJ) FROM PROGRAMMER p INNER JOIN STUDIES st ON p.PNAME = st.PNAME  WHERE st.INSTITUTE = 'BDPS');

/* 7. How many packages were developed by the female programmers earning more than the highest paid male programmer? */
SELECT COUNT(s.TITLE) AS NOOFPACKAGES
FROM SOFTWARE s
INNER JOIN PROGRAMMER p ON p.PNAME =  s.PNAME
WHERE p.GENDER ='F' AND p.SALARY > (SELECT MAX(SALARY) FROM PROGRAMMER WHERE GENDER = 'M');

/* 8. How much does the person who developed the highest selling package earn and what course did HE/SHE undergo. */
SELECT (s.SCOST*s.SOLD)AS HIGHESTSELLING, st.COURSE
FROM SOFTWARE S
INNER JOIN STUDIES st ON st.PNAME = s.PNAME
WHERE (s.SCOST*s.SOLD)= (SELECT MAX(s.SCOST*s.SOLD) FROM SOFTWARE s);

/* 9. In which institute did the person who developed the costliest package study? */
SELECT st.INSTITUTE
FROM STUDIES st
INNER JOIN SOFTWARE s ON  s.PNAME = st. PNAME 
WHERE s.DCOST = (SELECT MAX(DCOST) FROM SOFTWARE);

/* 10. Display the names of the programmers who have not developed any packages. */
SELECT PNAME
FROM PROGRAMMER
WHERE PNAME NOT IN (SELECT PNAME FROM SOFTWARE);

/* 11. Display the details of the software that has developed in the language which is neither the first nor the second proficiency */
SELECT s.*
FROM SOFTWARE s
INNER JOIN PROGRAMMER p ON  p.PNAME = s.PNAME
WHERE s.DEVELOPIN <> p.PROF1 AND s.DEVELOPIN <> p.PROF2;

/* 12. Display the details of the software Developed by the male programmers Born before 1965 and female programmers born after 1975 */
SELECT s.*
FROM SOFTWARE s
INNER JOIN PROGRAMMER p ON p.PNAME = s.PNAME
WHERE (p.GENDER = 'F' AND YEAR(p.DOB) > 1975) OR (p.GENDER= 'M' AND YEAR(p.DOB) < 1965);

/* 13. Display the number of packages, No. of Copies Sold and sales value of each programmer institute wise. */
SELECT COUNT(s.TITLE) AS NOOFPACKAGES, COUNT(s.SOLD) AS NOOFCOPIESSOLD, SUM(s.SCOST * s.SOLD) AS SALESVALUE, st.INSTITUTE
FROM  SOFTWARE s
INNER JOIN STUDIES st ON s.PNAME = st. PNAME
GROUP BY st.INSTITUTE;

/* 14. Display the details of the Software Developed by the Male Programmers Earning More than 3000 */ 
SELECT  s.*
FROM SOFTWARE s
INNER JOIN PROGRAMMER p ON p.PNAME = s.PNAME
WHERE p.GENDER = 'M' AND p.SALARY > 3000;

/* 15. Who are the Female Programmers earning more than the Highest Paid male? */
SELECT PNAME
FROM PROGRAMMER 
WHERE GENDER ='F' AND SALARY > (SELECT MAX(SALARY) FROM PROGRAMMER WHERE GENDER = 'M');

/* 16. Who are the male programmers earning below the AVG salary of Female Programmers? */
SELECT PNAME
FROM PROGRAMMER
WHERE GENDER = 'M' AND SALARY < (SELECT AVG(SALARY) FROM PROGRAMMER WHERE GENDER = 'F');

/* 17. Display the language used by each programmer to develop the Highest Selling and Lowest-selling package. */
SELECT DEVELOPIN, PNAME, SOLD
FROM SOFTWARE
WHERE SOLD IN (SELECT MIN(SOLD) FROM SOFTWARE GROUP BY PNAME) OR SOLD IN (SELECT MAX(SOLD) FROM SOFTWARE GROUP BY PNAME);

/* 18. Display the names of the packages, which have sold less than the AVG number of copies. */
SELECT TITLE
FROM SOFTWARE
WHERE SOLD < (SELECT AVG(SOLD) FROM SOFTWARE);

/* 19. Which is the costliest package developed in PASCAL. */
SELECT TITLE
FROM SOFTWARE
WHERE DEVELOPIN = 'PASCAL' AND DCOST = (SELECT MAX(DCOST) FROM SOFTWARE WHERE DEVELOPIN = 'PASCAL');

/* 20. How many copies of the package that has the least difference between development and selling cost were sold. */
SELECT TITLE, SOLD, (DCOST-SCOST) AS LEASTDIFFERENCE
FROM SOFTWARE
WHERE (DCOST - SCOST) = (SELECT MIN(DCOST-SCOST) FROM SOFTWARE);

/* 21. Which language has been used to develop the package, which has the highest sales amount? */
SELECT DEVELOPIN
FROM SOFTWARE
WHERE SCOST = (SELECT MAX(SCOST) FROM SOFTWARE);

/* 22. Who Developed the Package that has sold the least number of copies? */
SELECT PNAME
FROM SOFTWARE
WHERE SOLD = (SELECT MIN(SOLD) FROM SOFTWARE);

/* 23. Display the names of the courses whose fees are within 1000 (+ or -) of the Average Fee */
SELECT DISTINCT(COURSE)
FROM STUDIES
WHERE COURSEFEE <= (SELECT AVG(COURSEFEE) + 1000 FROM STUDIES) OR COURSEFEE >= (SELECT AVG(COURSEFEE) - 1000 FROM STUDIES)

/* 24. Display the name of the Institute and Course, which has below AVG course fee. */
SELECT INSTITUTE, COURSE
FROM STUDIES
WHERE COURSEFEE < (SELECT AVG(COURSEFEE) FROM STUDIES);

/* 25. Which Institute conducts costliest course. */
SELECT INSTITUTE
FROM STUDIES
WHERE COURSEFEE = (SELECT MAX(COURSEFEE) FROM STUDIES);

/* 26. What is the Costliest course? */
SELECT COURSE
FROM STUDIES
WHERE COURSEFEE = (SELECT MAX(COURSEFEE) FROM STUDIES);


CREATE TABLE STUDIES 
    (PNAME VARCHAR(20) PRIMARY KEY,
    INSTITUTE VARCHAR(20),
    COURSE VARCHAR(20),
    COURSEFEE INT
    );

INSERT INTO STUDIES VALUES ('ANAND', 'SABHARI', 'PGDCA', 4500),
                            ('ALTAF', 'COIT', 'DCA', 7200),
                            ('JULIANA', 'BDPS', 'MCA', 22000),
                            ('KAMALA', 'PRAGATHI', 'DCA', 5000),
                            ('MARY', 'SABHARI', 'PGDCA', 4500),
                            ('NELSON', 'PRAGATHI', 'DAP', 6200),
                            ('PATRICK', 'PRAGATHI', 'DCAP', 5200),
                            ('QADIR', 'APPLE', 'HDCA', 14000),
                            ('RAMESH', 'SABHARI', 'PGDCA', 4500),
                            ('REBECCA', 'BRILLIANT', 'DCAP', 11000),
                            ('REMITHA', 'BDPS', 'DCS', 6000),
                            ('REVATHI', 'SABHARI', 'DAP', 5000),
                            ('VIJAYA', 'BDPS', 'DCA', 48000);

CREATE TABLE SOFTWARE 
    (PNAME VARCHAR(20),
    TITLE VARCHAR(20),
    DEVELOPIN VARCHAR(20),
    SCOST INT,
    DCOST INT,
    SOLD INT
    );

INSERT INTO SOFTWARE VALUES ('MARY', 'README', 'CPP', 300, 1200, 84),
                            ('ANAND', 'PARACHUTES', 'BASIC', 399.95, 6000, 43),
                            ('ANAND', 'VIDEO TITLING', 'PASCAL', 7500, 16000, 9),
                            ('JULIANA', 'INVENTORY', 'COBOL', 3000, 3500, 0),
                            ('KAMALA', 'PAYROLL PKG.', 'DBASE', 9000, 20000, 7),
                            ('MARY', 'FINANCIAL ACCT.', 'ORACLE', 18000, 85000, 4),
                            ('MARY', 'CODE GENERATOR', 'C', 4500, 20000, 23),
                            ('PATTRICK', 'README', 'CPP', 300, 1200, 84),
                            ('QADIR', 'BOMBS AWAY', 'ASSEMBLY', 750, 3000, 11),
                            ('QADIR', 'VACCINES', 'C', 1900, 3100, 21),
                            ('RAMESH', 'HOTEL MGMT.', 'DBASE', 13000, 35000, 4),
                            ('RAMESH', 'DEAD LEE', 'PASCAL', 599.95, 4500, 73),
                            ('REMITHA', 'PC UTILITIES', 'C', 725, 5000, 51),
                            ('REMITHA', 'TSR HELP PKG.', 'ASSEMBLY', 2500, 6000, 7),
                            ('REVATHI', 'HOSPITAL MGMT.', 'PASCAL', 1100, 75000, 2),
                            ('VIJAYA', 'TSR EDITOR', 'C', 900, 700, 6);

CREATE TABLE PROGRAMMER 
    (PNAME VARCHAR(20),
    DOB VARCHAR(20),
    DOJ VARCHAR(20),
    GENDER CHAR(1),
    PROF1 VARCHAR(20),
    PROF2 VARCHAR(20),
    SALARY INT
    );

INSERT INTO PROGRAMMER VALUES ('ANAND', '1966-04-12', '1992-04-21', 'M', 'PASCAL', 'BASIC', 3200),
                                ('ALTAF', '1964-07-02', '1990-11-13', 'M', 'CLIPPER', 'COBOL', 2800),
                                ('JULIANA', '1960-01-31','1990-04-21', 'F', 'COBOL', 'DBASE', 3000),
                                ('KAMALA', '1968-10-30', '1992-01-02', 'F', 'C', 'DBASE', 2900),
                                ('MARY', '1970-06-24', '1991-02-01', 'F', 'CPP', 'ORACLE', 4500),
                                ('NELSON', '1985-09-11', '1989-10-11', 'M', 'COBOL', 'DBASE', 2500),
                                ('PATTRICK', '1965-11-10', '1990-04-21', 'M', 'PASCAL', 'CLIPPER', 2800),
                                ('QADIR', '1965-08-31', '1991-04-21', 'M', 'ASSEMBLY', 'C', 3000),
                                ('RAMESH', '1967-05-03', '1991-02-28', 'M', 'PASCAL', 'DBASE', 3200),
                                ('REBECCA', '1967-01-01', '1990-12-01', 'F', 'BASIC', 'COBOL', 2500),
                                ('REMITHA', '1970-04-19', '1993-04-20', 'F', 'C', 'ASSEMBLY', 3600),
                                ('REVATHI', '1969-12-02', '1992-01-02', 'F', 'PASCAL', 'BASIC', 3700),
                                ('VIJAYA', '1965-12-14', '1992-05-02', 'F', 'FOXPRO', 'C', 3500);