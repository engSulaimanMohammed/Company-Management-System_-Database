USE CompanyDB;
GO

DROP TABLE IF EXISTS Works_On;
DROP TABLE IF EXISTS Dependent;
DROP TABLE IF EXISTS Department_Location;
DROP TABLE IF EXISTS Project;

ALTER TABLE Department
DROP CONSTRAINT IF EXISTS FK_Department_Manager;

DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;
GO


CREATE TABLE Department (
    DNumber INT PRIMARY KEY,
    DName VARCHAR(50) NOT NULL,
    Mgr_ssn INT NULL,
    Mgr_start_date DATE
);
GO




CREATE TABLE Employee (
    SSN INT PRIMARY KEY,
    FName VARCHAR(50),
    LName VARCHAR(50),
    BDate DATE,
    Address VARCHAR(100),
    Sex CHAR(1),
    Salary DECIMAL(10,2),
    Super_ssn INT NULL,
    DNo INT,

    FOREIGN KEY (Super_ssn)
        REFERENCES Employee(SSN),

    FOREIGN KEY (DNo)
        REFERENCES Department(DNumber)
);
GO



ALTER TABLE Department
ADD CONSTRAINT FK_Department_Manager
FOREIGN KEY (Mgr_ssn)
REFERENCES Employee(SSN);
GO



CREATE TABLE Department_Location (
    DNumber INT,
    DLocation VARCHAR(50),

    PRIMARY KEY (DNumber, DLocation),

    FOREIGN KEY (DNumber)
        REFERENCES Department(DNumber)
);
GO



CREATE TABLE Project (
    PNumber INT PRIMARY KEY,
    PName VARCHAR(50),
    PLocation VARCHAR(50),
    DNum INT,

    FOREIGN KEY (DNum)
        REFERENCES Department(DNumber)
);
GO



CREATE TABLE Works_On (
    Essn INT,
    PNo INT,
    Hours DECIMAL(5,1),

    PRIMARY KEY (Essn, PNo),

    FOREIGN KEY (Essn)
        REFERENCES Employee(SSN),

    FOREIGN KEY (PNo)
        REFERENCES Project(PNumber)
);
GO




CREATE TABLE Dependent (
    Essn INT,
    Dependent_name VARCHAR(50),
    Sex CHAR(1),
    BDate DATE,
    Relationship VARCHAR(30),

    PRIMARY KEY (Essn, Dependent_name),

    FOREIGN KEY (Essn)
        REFERENCES Employee(SSN)
);
GO



USE CompanyDB;
GO



INSERT INTO Department
(DNumber, DName, Mgr_ssn, Mgr_start_date)
VALUES
(1, 'Headquarters', NULL, NULL),
(2, 'Marketing', NULL, NULL),
(3, 'Finance', NULL, NULL),
(4, 'Administration', NULL, NULL),
(5, 'Research', NULL, NULL);
GO


   

INSERT INTO Employee
(SSN, FName, LName, BDate, Address, Sex, Salary, Super_ssn, DNo)
VALUES
(888665555, 'James', 'Borg', '1937-11-10',
 '450 Stone, Houston TX', 'M', 55000, NULL, 1),

(333445555, 'Franklin', 'Wong', '1955-12-08',
 '638 Voss, Houston TX', 'M', 40000, 888665555, 5),

(987654321, 'Jennifer', 'Wallace', '1941-06-20',
 '291 Berry, Bellaire TX', 'F', 43000, 888665555, 4),

(123456789, 'John', 'Smith', '1965-01-09',
 '731 Fondren, Houston TX', 'M', 30000, 333445555, 5),

(999887777, 'Alicia', 'Zelaya', '1968-07-19',
 '3321 Castle, Spring TX', 'F', 25000, 987654321, 4);
GO



UPDATE Department
SET Mgr_ssn = 888665555,
    Mgr_start_date = '1981-06-19'
WHERE DNumber = 1;

UPDATE Department
SET Mgr_ssn = 987654321,
    Mgr_start_date = '1998-01-01'
WHERE DNumber = 2;

UPDATE Department
SET Mgr_ssn = 999887777,
    Mgr_start_date = '2005-03-15'
WHERE DNumber = 3;

UPDATE Department
SET Mgr_ssn = 987654321,
    Mgr_start_date = '1995-01-01'
WHERE DNumber = 4;

UPDATE Department
SET Mgr_ssn = 333445555,
    Mgr_start_date = '1988-05-22'
WHERE DNumber = 5;
GO




INSERT INTO Department_Location
(DNumber, DLocation)
VALUES
(1, 'Muscat'),
(2, 'Dubai'),
(3, 'Riyadh'),
(4, 'Manama'),
(5, 'Doha');
GO




INSERT INTO Project
(PNumber, PName, PLocation, DNum)
VALUES
(1, 'ProductX', 'Muscat', 5),
(2, 'ProductY', 'Dubai', 5),
(3, 'ProductZ', 'Riyadh', 5),
(10, 'Computerization', 'Manama', 4),
(20, 'Reorganization', 'Doha', 1);
GO



INSERT INTO Works_On
(Essn, PNo, Hours)
VALUES
(123456789, 1, 32.5),
(123456789, 2, 7.5),
(333445555, 2, 10.0),
(333445555, 3, 10.0),
(999887777, 10, 10.0);
GO




INSERT INTO Dependent
(Essn, Dependent_name, Sex, BDate, Relationship)
VALUES
(333445555, 'Alice', 'F', '1986-04-05', 'Daughter'),
(333445555, 'Theodore', 'M', '1983-10-25', 'Son'),
(333445555, 'Joy', 'F', '1958-05-03', 'Spouse'),
(987654321, 'Abner', 'M', '1942-02-28', 'Spouse'),
(123456789, 'Michael', 'M', '1988-01-04', 'Son');
GO




SELECT * FROM Department;
SELECT * FROM Employee;
SELECT * FROM Department_Location;
SELECT * FROM Project;
SELECT * FROM Works_On;
SELECT * FROM Dependent;
GO




USE CompanyDB;
GO



/* 1. Update Employee Salary */

UPDATE Employee
SET Salary = 32000
WHERE SSN = 123456789;


/* 2. Update Department Name */

UPDATE Department
SET DName = 'Digital Marketing'
WHERE DNumber = 2;


/* 3. Update Project Location */

UPDATE Project
SET PLocation = 'Abu Dhabi'
WHERE PNumber = 2;


/* 4. Update Working Hours */

UPDATE Works_On
SET Hours = 8.0
WHERE Essn = 123456789
AND PNo = 2;


/* 5. Update Dependent Relationship */

UPDATE Dependent
SET Relationship = 'Child'
WHERE Essn = 333445555
AND Dependent_name = 'Alice';


/* 6. Update Department Location */

UPDATE Department_Location
SET DLocation = 'Abu Dhabi'
WHERE DNumber = 2
AND DLocation = 'Dubai';

GO





SELECT * FROM Department;
SELECT * FROM Employee;
SELECT * FROM Department_Location;
SELECT * FROM Project;
SELECT * FROM Works_On;
SELECT * FROM Dependent;

GO


/* 1. Delete one Dependent */

DELETE FROM Dependent
WHERE Essn = 123456789
AND Dependent_name = 'Michael';


/* 2. Delete one Works_On record */

DELETE FROM Works_On
WHERE Essn = 123456789
AND PNo = 1;


/* 3. Delete Project 20
   Project 20 is not used in Works_On
*/

DELETE FROM Project
WHERE PNumber = 20;


/* 4. Delete one Department Location */

DELETE FROM Department_Location
WHERE DNumber = 3
AND DLocation = 'Riyadh';

GO



SELECT * FROM Department;
SELECT * FROM Employee;
SELECT * FROM Department_Location;
SELECT * FROM Project;
SELECT * FROM Works_On;
SELECT * FROM Dependent;

GO




