/* 1. Display the names of the highest paid programmers for each Language. */
CREATE VIEW HIGHESTPAID AS
SELECT PNAME, PROF1 AS LANGUAGE, SALARY
FROM PROGRAMMER
UNION ALL
SELECT PNAME, PROF2, SALARY
FROM PROGRAMMER;

SELECT h1.SALARY, h1.PNAME, h1.LANGUAGE
FROM HIGHESTPAID h1
WHERE SALARY = (SELECT MAX(SALARY) FROM HIGHESTPAID h2 WHERE h1.LANGUAGE = h2.LANGUAGE)
ORDER BY h1.LANGUAGE

/* 2. Display the details of those who are drawing the same salary. */
SELECT *
FROM PROGRAMMER
WHERE SALARY IN (SELECT SALARY FROM PROGRAMMER GROUP BY SALARY HAVING COUNT(SALARY) > 1)
ORDER BY SALARY;

/* 3. Who are the programmers who joined on the same day? */  
SELECT PNAME, DOJ
FROM PROGRAMMER
WHERE DOJ IN (SELECT DOJ FROM PROGRAMMER GROUP BY DOJ HAVING COUNT(DOJ) > 1)
ORDER BY DOJ;

/* 4. Who are the programmers who have the same Prof2? */
SELECT PNAME, PROF2
FROM PROGRAMMER
WHERE PROF2 IN (SELECT PROF2 FROM PROGRAMMER GROUP BY PROF2 HAVING COUNT(PROF2) > 1)
ORDER BY PROF2;

/* 5. How many packages were developed by the person who developed the cheapest package, where did he/she study? */
SELECT COUNT(s.TITLE) AS NOOFPACKAGES, st.INSTITUTE
FROM SOFTWARE s
INNER JOIN PROGRAMMER p ON s.PNAME = p.PNAME
INNER JOIN STUDIES st ON s.PNAME = st.PNAME
WHERE DCOST = (SELECT MIN(DCOST) FROM SOFTWARE)
GROUP BY st.INSTITUTE;


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