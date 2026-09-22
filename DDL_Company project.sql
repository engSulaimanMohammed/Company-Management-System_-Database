CREATE DATABASE CompanyDB;
GO

USE CompanyDB;
GO



CREATE TABLE Department (
    DNum INT PRIMARY KEY,
    DName VARCHAR(50) NOT NULL UNIQUE,
    ManagerSSN INT NULL,
    HireDate DATE NULL
);



CREATE TABLE Employee (
    SSN INT PRIMARY KEY,
    FName VARCHAR(50) NOT NULL,
    LName VARCHAR(50) NOT NULL,
    Gender CHAR(1),
    BirthDate DATE,

    DNum INT NOT NULL,
    SupervisorSSN INT NULL,

    FOREIGN KEY (DNum)
        REFERENCES Department(DNum),

    FOREIGN KEY (SupervisorSSN)
        REFERENCES Employee(SSN)
);




ALTER TABLE Department
ADD CONSTRAINT FK_Department_Manager
FOREIGN KEY (ManagerSSN)
REFERENCES Employee(SSN);




CREATE TABLE Project (
    PNumber INT PRIMARY KEY,
    PName VARCHAR(50) NOT NULL,
    Location VARCHAR(50),
    City VARCHAR(50),

    DNum INT NOT NULL,

    FOREIGN KEY (DNum)
        REFERENCES Department(DNum)
);


CREATE TABLE Works_On (
    SSN INT,
    PNumber INT,
    WorkingHours DECIMAL(5,2),

    PRIMARY KEY (SSN, PNumber),

    FOREIGN KEY (SSN)
        REFERENCES Employee(SSN),

    FOREIGN KEY (PNumber)
        REFERENCES Project(PNumber)
);




CREATE TABLE Dependent (
    SSN INT,
    DependentName VARCHAR(50),
    Gender CHAR(1),
    BirthDate DATE,

    PRIMARY KEY (SSN, DependentName),

    FOREIGN KEY (SSN)
        REFERENCES Employee(SSN)
);



CREATE TABLE Department_Location (
    DNum INT,
    Location VARCHAR(50),

    PRIMARY KEY (DNum, Location),

    FOREIGN KEY (DNum)
        REFERENCES Department(DNum)
);