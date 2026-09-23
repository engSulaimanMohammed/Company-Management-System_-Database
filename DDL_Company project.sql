
create database CompanyDB

use CompanyDB


create table Employee
(
	Fname nvarchar(20) not null,
	Lname nvarchar(20) not null,
	Ssn int primary key,
	Bdate date,
	Gender bit default 0,
	Super_ssn int,
	foreign key (Super_ssn) references Employee(Ssn)
)


create table Department
(
	Dname nvarchar(20) not null,
	Dnumber int primary key,
	Mgr_ssn int,
	Mgr_start_date date not null,
	foreign key (Mgr_ssn) references Employee(Ssn)
)


create table Dept_Location
(
	Dnumber int,
	Dlocation nvarchar(100),
	foreign key (Dnumber) references Department(Dnumber),
	primary key (Dnumber, Dlocation)
)


create table Project
(
	Pname nvarchar(50) not null,
	Pnumber int primary key,
	Plocation nvarchar(100) not null,
	City nvarchar(100),
	Dnum int,
	foreign key (Dnum) references Department(Dnumber)
)


create table Works_on
(
	Essn int,
	Pno int,
	Hrs int not null,
	foreign key (Essn) references Employee(Ssn),
	foreign key (Pno) references Project(Pnumber),
	primary key (Essn, Pno)
)


create table EmployeeDependent
(
	Essn int,
	Dependent_name nvarchar(50) not null,
	Gender bit default 0,
	Bdate date,
	foreign key (Essn) references Employee(Ssn),
	primary key (Essn, Dependent_name)
)


alter table Employee
add Dno int foreign key references Department(Dnumber)
