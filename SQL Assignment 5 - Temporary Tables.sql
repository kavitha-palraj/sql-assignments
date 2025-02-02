/* 1. Display the details of the software developed in dBase by male programmers
who belong to the institute with the most number of programmers. */

CREATE TABLE #DBASESOFTWARE (
    COUNT INT,
    INSTITUTE VARCHAR(20)
)

INSERT INTO #DBASESOFTWARE
SELECT COUNT(PNAME), INSTITUTE
FROM STUDIES
GROUP BY INSTITUTE;

SELECT S.*
FROM SOFTWARE s
INNER JOIN PROGRAMMER p ON s.PNAME = p.PNAME
INNER JOIN STUDIES st ON s.PNAME = st.PNAME
WHERE s.DEVELOPIN = 'DBASE' AND p.GENDER = 'M'
AND st.INSTITUTE = (SELECT INSTITUTE FROM #DBASESOFTWARE WHERE COUNT IN (SELECT MAX(COUNT) FROM #DBASESOFTWARE));

/* 2. In which language are most of the programmerís proficient? */

CREATE TABLE #PROFICIENCY (
    LANGUAGE VARCHAR(20),
)

INSERT INTO #PROFICIENCY
SELECT PROF1
FROM PROGRAMMER
UNION ALL
SELECT PROF2
FROM PROGRAMMER;

CREATE TABLE #PROFICIENCYCOUNT (
    LANGUAGE VARCHAR(20),
    COUNT INT
)

INSERT INTO #PROFICIENCYCOUNT
SELECT LANGUAGE, COUNT(LANGUAGE)
FROM #PROFICIENCY
GROUP BY LANGUAGE;

SELECT LANGUAGE, COUNT
FROM #PROFICIENCYCOUNT
WHERE COUNT = (SELECT MAX(COUNT) FROM #PROFICIENCYCOUNT);

/* 3. In which month did the most number of programmers join? */

CREATE TABLE #JOINDATE (
    MONTH VARCHAR(20),
    NOOFMONTHS int
)

INSERT INTO #JOINDATE
SELECT DATENAME(month, DOJ), COUNT(DATENAME(month, DOJ))
FROM PROGRAMMER
GROUP BY DATENAME(month, DOJ);

SELECT MONTH
FROM #JOINDATE
WHERE NOOFMONTHS = (SELECT MAX(NOOFMONTHS) FROM #JOINDATE);

/* 4. In which year the most number of programmers were born? */

CREATE TABLE #BIRTHYEAR (
    YEAR int,
    NOOFYEARS int
)

INSERT INTO #BIRTHYEAR
SELECT YEAR(DOB), COUNT(YEAR(DOB))
FROM PROGRAMMER
GROUP BY YEAR(DOB);

SELECT YEAR
FROM #BIRTHYEAR
WHERE NOOFYEARS = (SELECT MAX(NOOFYEARS) FROM #BIRTHYEAR);

/* 5. Which programmer has developed the highest number of packages? */

CREATE TABLE #PACKAGES (
    PNAME VARCHAR(20),
    NOOFPACKAGES int
)

INSERT INTO #PACKAGES
SELECT PNAME, COUNT(TITLE)
FROM SOFTWARE
GROUP BY PNAME;

SELECT PNAME
FROM #PACKAGES
WHERE NOOFPACKAGES = (SELECT MAX(NOOFPACKAGES) FROM #PACKAGES);

/* 6. Which language was used to develop the most number of packages? */

CREATE TABLE #PACKAGESLANGUAGE (
    DEVELOPIN VARCHAR(20),
    NOOFPACKAGES int
)

INSERT INTO #PACKAGESLANGUAGE
SELECT DEVELOPIN, COUNT(TITLE)
FROM SOFTWARE
GROUP BY DEVELOPIN;

SELECT DEVELOPIN
FROM #PACKAGESLANGUAGE
WHERE NOOFPACKAGES = (SELECT MAX(NOOFPACKAGES) FROM #PACKAGESLANGUAGE);

/* 7. Which course has below average number of students? */

CREATE TABLE #COURSESTUDENTS (
    COURSE VARCHAR(20),
    NOOFSTUDENTS int
)

INSERT INTO #COURSESTUDENTS
SELECT COURSE, COUNT(PNAME)
FROM STUDIES
GROUP BY COURSE;

SELECT COURSE
FROM #COURSESTUDENTS
WHERE NOOFSTUDENTS <= (SELECT AVG(NOOFSTUDENTS) FROM #COURSESTUDENTS);

/* 8. Which course has been done by the most of the students? */

SELECT COURSE
FROM #COURSESTUDENTS
WHERE NOOFSTUDENTS = (SELECT MAX(NOOFSTUDENTS) FROM #COURSESTUDENTS);

/* 9. Which institute has the most number of students? */

CREATE TABLE #INSTITUTESTUDENTS (
    INSTITUTE VARCHAR(20),
    NOOFSTUDENTS int
)

INSERT INTO #INSTITUTESTUDENTS
SELECT INSTITUTE, COUNT(PNAME)
FROM STUDIES
GROUP BY INSTITUTE;

SELECT INSTITUTE
FROM #INSTITUTESTUDENTS
WHERE NOOFSTUDENTS = (SELECT MAX(NOOFSTUDENTS) FROM #INSTITUTESTUDENTS);

/* 10. Who is the above programmer referred to in 50 ? */

SELECT PNAME
FROM PROGRAMMER
WHERE PNAME = 'MARY';

/* 11. Display the names of the highest paid programmers for each language. */

CREATE TABLE #HIGHESTPAID (
    PNAME VARCHAR(20),
    PROF VARCHAR(20),
    SALARY INT
)

INSERT INTO #HIGHESTPAID
SELECT PNAME, PROF1, SALARY
FROM PROGRAMMER
UNION ALL
SELECT PNAME, PROF2, SALARY
FROM PROGRAMMER;

SELECT h1.SALARY, h1.PNAME, h1.LANGUAGE
FROM HIGHESTPAID h1
WHERE SALARY = (SELECT MAX(SALARY) FROM HIGHESTPAID h2 WHERE h1.LANGUAGE = h2.LANGUAGE)
ORDER BY h1.LANGUAGE;


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