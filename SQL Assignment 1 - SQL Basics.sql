/* 1. Find out the selling cost AVG for packages developed in Pascal. */
SELECT AVG(SCOST) AS AVG_PACKAGE 
FROM SOFTWARE
WHERE DEVELOPIN = 'PASCAL';

/* 2. Display Names, Ages of all Programmers. */
SELECT PNAME                    
FROM PROGRAMMER;

/* 3. Display the Names of those who have done the DAP Course. */
SELECT PNAME  
FROM STUDIES
WHERE COURSE= 'DAP';

/* 4. Display the Names and Date of Births of all Programmers Born in January. */
SELECT PNAME
FROM PROGRAMMER
WHERE MONTH(DOB) = 1;

/* 5. Display the Details of the Software Developed by Ramesh. */
SELECT *
FROM SOFTWARE
WHERE PNAME = 'RAMESH';

/* 6. Display the Details of Packages for which Development Cost have been recovered. */
SELECT *
FROM SOFTWARE
WHERE DCOST < (SCOST*SOLD);

/* 7. Display the details of the Programmers Knowing C. */
SELECT *
FROM PROGRAMMER
WHERE PROF1= 'C' OR PROF2= 'C';

/* 8. What are the Languages studied by Male Programmers? */
SELECT PROF1, PROF2
FROM PROGRAMMER
WHERE GENDER = 'M';

/* 9. Display the details of the Programmers who joined before 1990. */
SELECT * 
FROM PROGRAMMER
WHERE YEAR(DOJ) < 1990;

/* 10. Who are the authors of the Packages, which have recovered more
than double the Development cost? */
SELECT PNAME
FROM SOFTWARE
WHERE (SCOST*SOLD) > (2*DCOST);


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