/* 1. What is the cost of the costliest software development in Basic? */
SELECT MAX(DCOST) AS COSTLIESTSOFTWARE
FROM SOFTWARE
WHERE DEVELOPIN = 'BASIC';

/* 2. Display details of Packages whose sales crossed the 2000 Mark. */
SELECT * 
FROM SOFTWARE
WHERE (SCOST * SOLD) > 2000;

/* 3. Who are the Programmers who celebrate their Birthdays during the Current Month? */
SELECT PNAME
FROM PROGRAMMER
WHERE MONTH(DOB) = (SELECT MONTH(GETDATE()));

/* 4. Display the Cost of Package Developed By each Programmer. */
SELECT SUM(DCOST) AS COSTOFPACKAGE, PNAME
FROM SOFTWARE
GROUP BY PNAME;

/* 5. Display the sales values of the Packages Developed by each Programmer. */
SELECT SUM(SCOST * SOLD) AS SALESVALUE, PNAME
FROM SOFTWARE
GROUP BY PNAME;

/* 6. Display the Number of Packages sold by Each Programmer. */
SELECT COUNT(TITLE) AS NOOFPACKAGES, PNAME
FROM SOFTWARE
GROUP BY PNAME

/* 7. Display each programmer’s name, costliest and cheapest Packages Developed by him or her. */
SELECT PNAME, MAX(DCOST) AS COSTLIEST, MIN(DCOST) AS CHEAPEST
FROM SOFTWARE
GROUP BY PNAME

/* 8. Display each institute name with the number of Courses, Average Cost per Course. */
SELECT INSTITUTE, COUNT(COURSE) AS NOOFCOURSES, AVG(COURSEFEE) AS AVGCOURSEFEE
FROM STUDIES
GROUP BY INSTITUTE;

/* 9. Display each institute Name with Number of Students. */
SELECT INSTITUTE, COUNT(PNAME) AS NOOFSTUDENTS
FROM STUDIES
GROUP BY INSTITUTE;

/* 10. List the programmers (form the software table) and the institutes they studied. */
SELECT DISTINCT(s.PNAME), st.INSTITUTE
FROM SOFTWARE s
INNER JOIN STUDIES st ON st.PNAME = s.PNAME
ORDER BY s.PNAME;

/* 11. How many packages were developed by students, who studied in institute that charge the lowest course fee? */
SELECT COUNT(s.TITLE) AS NOOFPACKAGES, st.INSTITUTE
FROM SOFTWARE s
INNER JOIN STUDIES st ON st.PNAME = s.PNAME
WHERE st.COURSEFEE = (SELECT MIN(COURSEFEE) FROM STUDIES)
GROUP BY st.INSTITUTE;

/* 12. What is the AVG salary for those whose software sales is more than 50,000? */
SELECT AVG(p.SALARY) AS AVERAGESALARY
FROM PROGRAMMER p
INNER JOIN SOFTWARE s ON s.PNAME = p.PNAME
WHERE (s.SCOST*s.SOLD) > 50000;

/* 13. Which language listed in prof1, prof2 has not been used to develop any package. */
SELECT PROF1 AS NOTIN
FROM PROGRAMMER
WHERE PROF1 NOT IN (SELECT DEVELOPIN FROM SOFTWARE)
UNION
SELECT PROF2 
FROM PROGRAMMER
WHERE PROF2 NOT IN (SELECT DEVELOPIN FROM SOFTWARE)

/* 14. Display the total sales value of the software, institute wise. */
SELECT SUM(s.SCOST * s.SOLD) AS SALESVALUE, st.INSTITUTE
FROM SOFTWARE s
INNER JOIN STUDIES st ON s.PNAME = st.PNAME
GROUP BY st.INSTITUTE

/* 15. Display the details of the Software Developed in C By female programmers of Pragathi. */
SELECT s.*
FROM SOFTWARE s
INNER JOIN PROGRAMMER p ON s.PNAME = p.PNAME
INNER JOIN STUDIES st ON s.PNAME = st.PNAME
WHERE p.GENDER = 'F' AND st.INSTITUTE = 'PRAGATHI' AND s.DEVELOPIN = 'C';

/* 16. Display the details of the packages developed in Pascal by the Female Programmers. */
SELECT s.* 
FROM SOFTWARE s
INNER JOIN PROGRAMMER p ON s.PNAME = p. PNAME
WHERE s.DEVELOPIN = 'PASCAL' AND p.GENDER = 'F';

/* 17. Which language has been stated as the proficiency by most of the Programmers? */
CREATE VIEW PROFICIENCY AS
    SELECT PROF1, COUNT(PROF1) AS NOOFPROGRAMMERS
    FROM PROGRAMMER
    GROUP BY PROF1
    UNION
    SELECT PROF2, COUNT(PROF2) AS NOOFPROGRAMMERS
    FROM PROGRAMMER
    GROUP BY PROF2;

SELECT PROF1, NOOFPROGRAMMERS
FROM PROFICIENCY
WHERE NOOFPROGRAMMERS = (SELECT MAX(NOOFPROGRAMMERS) FROM PROFICIENCY)

/* 18. Who is the Author of the Costliest Package? */
SELECT PNAME, SCOST
FROM SOFTWARE
WHERE SCOST = (SELECT MAX(SCOST) FROM SOFTWARE)

/* 19. Which package has the Highest Development cost? */  
SELECT TITLE, DCOST
FROM SOFTWARE
WHERE DCOST = (SELECT MAX(DCOST) FROM SOFTWARE)

/* 20. Who is the Highest Paid Female COBOL Programmer? */
SELECT PNAME, SALARY
FROM PROGRAMMER
WHERE GENDER = 'F' AND SALARY = (SELECT MAX(SALARY) FROM PROGRAMMER WHERE GENDER = 'F' AND PROF1 = 'COBOL' OR PROF2 = 'COBOL');

/* 21. Display the Name of Programmers and Their Packages. */
SELECT p.PNAME, s.TITLE
FROM PROGRAMMER p
LEFT JOIN SOFTWARE s ON p.PNAME = s.PNAME;

/* 22. Display the Number of Packages in Each Language Except C and C++. */
SELECT COUNT(TITLE) AS NOOFPACKAGES, DEVELOPIN
FROM SOFTWARE
WHERE DEVELOPIN NOT IN ('C', 'C++')
GROUP BY DEVELOPIN;

/* 23. Display AVG Difference between SCOST, DCOST for Each Package. */
SELECT AVG(SCOST-DCOST) AS AVGDIFFERENCE, TITLE
FROM SOFTWARE
GROUP BY TITLE;

/* 24. Display the total SCOST, DCOST and amount to Be Recovered for each Programmer for Those Whose Cost has not yet been Recovered.*/  
SELECT PNAME, SUM(SCOST) AS TOTALSCOST, SUM(DCOST) AS TOTALDCOST, SUM(DCOST - (SCOST*SOLD)) AS AMOUNTTOBERECOVERED
FROM SOFTWARE
GROUP BY PNAME
HAVING SUM(SCOST*SOLD) < SUM(DCOST)

/* 25. Who is the Highest Paid C Programmers? */
SELECT PNAME
FROM PROGRAMMER
WHERE SALARY = (SELECT MAX(SALARY) FROM PROGRAMMER WHERE PROF1 = 'C' OR PROF2 = 'C');

/* 26. Who is the Highest Paid Female COBOL Programmer? */
SELECT PNAME
FROM PROGRAMMER
WHERE GENDER = 'F' AND SALARY = (SELECT MAX(SALARY) FROM PROGRAMMER WHERE GENDER = 'F' AND (PROF1 = 'COBOL' OR PROF2 = 'COBOL'));


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