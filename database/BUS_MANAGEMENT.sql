USE [master]
GO

/*******************************************************************************
   Drop database if it exists
********************************************************************************/
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'BUS_SCHOOL_MANAGEMENT')
BEGIN
	ALTER DATABASE BUS_SCHOOL_MANAGEMENT SET OFFLINE WITH ROLLBACK IMMEDIATE;
	ALTER DATABASE BUS_SCHOOL_MANAGEMENT SET ONLINE;
	DROP DATABASE BUS_SCHOOL_MANAGEMENT;
END


GO
Create database BUS_SCHOOL_MANAGEMENT
GO
USE BUS_SCHOOL_MANAGEMENT
GO
-- Bảng Account
CREATE TABLE Account (
    AccountID INT IDENTITY PRIMARY KEY,
    Username VARCHAR(255),
    Password VARCHAR(255),
    Role VARCHAR(50),
	Status VARCHAR(30),
    UNIQUE (AccountID) 
);

-- Bảng Route
CREATE TABLE Route (
    RouteID INT IDENTITY PRIMARY KEY,
    RouteName VARCHAR(255)
);

-- Bảng Bus
CREATE TABLE Bus (
    BusID INT IDENTITY PRIMARY KEY,
    Status VARCHAR(50),
    Issues TEXT,
    LicensePlate VARCHAR(50), 
    RouteID INT UNIQUE,
    FOREIGN KEY (RouteID) REFERENCES Route(RouteID)
);

-- Bảng Stop
CREATE TABLE Stop (
    StopID INT IDENTITY PRIMARY KEY,
    StopOrder INT,
    StopName VARCHAR(255),
    RouteID INT,
    FOREIGN KEY (RouteID) REFERENCES Route(RouteID)
);

-- Bảng Parent
CREATE TABLE Parent (
    ParentID INT IDENTITY PRIMARY KEY,
    Fullname NVARCHAR(255),
    Email VARCHAR(255),
    Phone VARCHAR(15),
    Gender VARCHAR(10),
    DateOfBirth DATE,
    Role VARCHAR(50),
    Image VARCHAR(255),
    AccountID INT,
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

-- Bảng Manager
CREATE TABLE Manager (
    ManagerID INT IDENTITY PRIMARY KEY,
    ManagerName NVARCHAR(255),
    Phone VARCHAR(15),
    Gender VARCHAR(10),
    DateOfBirth DATE,
    Image VARCHAR(255),
    AccountID INT UNIQUE, 
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

-- Bảng Driver
CREATE TABLE Driver (
    DriverID INT IDENTITY PRIMARY KEY,
    DriverName NVARCHAR(255),
    Phone VARCHAR(15),
    Gender VARCHAR(10),
    DateOfBirth DATE, 
    Image VARCHAR(255),
    AccountID INT UNIQUE,
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

-- Bảng Student
CREATE TABLE Student (
    StudentID INT IDENTITY PRIMARY KEY,
    Status VARCHAR(50),
    Image VARCHAR(255),
    StudentName NVARCHAR(255),
    Gender VARCHAR(10), 
    DateOfBirth DATE, 
    Class VARCHAR(50), 
    StopID INT,
    AccountID INT,
    FOREIGN KEY (StopID) REFERENCES Stop(StopID),
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

-- Bảng Trip
CREATE TABLE Trip (
    TripID INT IDENTITY PRIMARY KEY,
    TripDate DATE,
    DepartureTime TIME,
    TimePeriod VARCHAR(255),
    DriverID INT,
    ManagerID INT,
    BusID INT,
    FOREIGN KEY (DriverID) REFERENCES Driver(DriverID),
    FOREIGN KEY (ManagerID) REFERENCES Manager(ManagerID),
    FOREIGN KEY (BusID) REFERENCES Bus(BusID)
);

-- Bảng Attendance
CREATE TABLE Attendance (
    AttendanceID INT IDENTITY PRIMARY KEY,
    AttendanceDate DATE,
	TimePeriod varchar(50),
    PickEstimate TIME,
    DropEstimate TIME,
    Status VARCHAR(50),
    ParentID INT,
	StudentID int,
    FOREIGN KEY (ParentID) REFERENCES Parent(ParentID),
	FOREIGN KEY (StudentID) REFERENCES Student(StudentID)

);


-- Bảng Pick
CREATE TABLE Pick (
    StudentID INT,
    TripID INT,
    StopID INT, 
    PickTime TIME,
    DropTime TIME,
    PRIMARY KEY (StudentID, TripID, StopID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (TripID) REFERENCES Trip(TripID),
    FOREIGN KEY (StopID) REFERENCES Stop(StopID)
);


/*
DROP TABLE Checkin;
DROP TABLE  Pick;
DROP TABLE  Attendance;
DROP TABLE  Trip;
DROP TABLE  Student;
DROP TABLE  Driver;
DROP TABLE  Manager;
DROP TABLE  Parent;
DROP TABLE  Stop;
DROP TABLE Bus;
DROP TABLE  Route;
DROP TABLE  Account;
*/
--insert bảng account
--5 diver / 5 manager / 10 parent: 3 cặp bố mẹ, 2 bố, 2 mẹ
--Admin
-- Account Insert Statements

-- Insert multiple records into Account

-- Admin, Driver, Manager, and Parent
-- Insert multiple records into Account

-- Admin, Driver, Manager, and Parent
insert into Account (Username, Password, Role, Status) values 
    ('admin', '010203', 'Admin', 'Active'),
    ('driver', '010203', 'Driver', 'Active'),
    ('shidderley4', 'oX2XMlP', 'Driver', 'Active'),
    ('bmarchbank8', 'oG1QCUXE', 'Driver', 'Active'),
    ('kcyseleyb', 'kR5UmpowprL', 'Driver', 'Active'),
    ('jchichgarh', 'xW255bf7E1', 'Driver', 'Active'),
    ('manager', '010203', 'Manager', 'Active'),
    ('rcarnalan6', 'xY6ul7V1m', 'Manager', 'Active'),
    ('fkellera', 'fD4rQ5BqNg', 'Manager', 'Active'),
    ('ncutressc', 'tZ01aK', 'Manager', 'Active'),
    ('ldurtnalg', 'nE6dr1u', 'Manager', 'Active'),
    ('parent', '010203', 'Parent', 'Active'),
    ('ggallon3', 'kA57D', 'Parent', 'Active'),
    ('bhowsin5', 'rV3qC3f7', 'Parent', 'Active'),
    ('hstrafford7', 'hQ23CovHSE', 'Parent', 'Active'),
    ('rduplain9', 'eL1pxFILe', 'Parent', 'Active'),
    ('afarged', 'fJ7g4rCdHL', 'Parent', 'Active'),
    ('bcaigf', 'mU57Cf2B', 'Parent', 'Active'),
    ('ckornaliki', 'tY1ejtp2', 'Parent', 'Active'),
    ('dsmith', 'Passw0rd1', 'Parent', 'Active'), 
    ('bwhite', 'Passw0rd2', 'Parent', 'Active');

--insert bảng route
INSERT INTO Route (RouteName) VALUES ('Main Street (City Center to North End)');
INSERT INTO Route (RouteName) VALUES ('Park Avenue (East Side to West Side)');
INSERT INTO Route (RouteName) VALUES ('Broadway (Downtown to Uptown)');
INSERT INTO Route (RouteName) VALUES ('Elm Street (South Park to North Park)');
INSERT INTO Route (RouteName) VALUES ('Maple Avenue (West Side to East Side)');
INSERT INTO Route(RouteName)
VALUES ('Spare vehicle')
INSERT INTO Route(RouteName)
VALUES ('Spare vehicle')
INSERT INTO Route(RouteName)
VALUES ('Spare vehicle')
INSERT INTO Route(RouteName)
VALUES ('Spare vehicle')
INSERT INTO Route(RouteName)
VALUES ('Spare vehicle')


--insert bảng bus
INSERT INTO Bus (Status, Issues, LicensePlate, RouteID)
VALUES 
('Active', 'None', '34A-5678', 1),
('Active', 'None', '56C-9101', 3),
('Active', 'None', '38E-8152', 2),
('Active', 'None', '19F-2002', 4),
('Active', 'None', '45K-3256', 5);	

INSERT INTO Bus (Status, Issues, LicensePlate, RouteID)
VALUES 
('In Active', 'None', '34A-2409	', 6),
('In Active', 'None', '56C-0712', 7),
('In Active', 'None', '38E-0701', 8);


--insert bảng stop
-- Chèn dữ liệu vào bảng Stop cho tuyến Main Street
INSERT INTO Stop (StopOrder, StopName, RouteID) VALUES (1, 'City Center', 1);
INSERT INTO Stop (StopOrder, StopName, RouteID) VALUES (2, 'City Park', 1);
INSERT INTO Stop (StopOrder, StopName, RouteID) VALUES (3, 'Central Library', 1);
INSERT INTO Stop (StopOrder, StopName, RouteID) VALUES (4, 'North End', 1);

-- Chèn dữ liệu vào bảng Stop cho tuyến Park Avenue
INSERT INTO Stop (StopOrder, StopName, RouteID) VALUES (1, 'East Side', 2);
INSERT INTO Stop (StopOrder, StopName, RouteID) VALUES (2, 'East Park', 2);
INSERT INTO Stop (StopOrder, StopName, RouteID) VALUES (3, 'West Plaza', 2);
INSERT INTO Stop (StopOrder, StopName, RouteID) VALUES (4, 'West Side', 2);

-- Chèn dữ liệu vào bảng Stop cho tuyến Broadway
INSERT INTO Stop (StopOrder, StopName, RouteID) VALUES (1, 'Downtown', 3);
INSERT INTO Stop (StopOrder, StopName, RouteID) VALUES (2, 'Theater District', 3);
INSERT INTO Stop (StopOrder, StopName, RouteID) VALUES (3, 'Shopping Mall', 3);
INSERT INTO Stop (StopOrder, StopName, RouteID) VALUES (4, 'Uptown', 3);

-- Chèn dữ liệu vào bảng Stop cho tuyến Elm Street
INSERT INTO Stop (StopOrder, StopName, RouteID) VALUES (1, 'South Park', 4);
INSERT INTO Stop (StopOrder, StopName, RouteID) VALUES (2, 'Community Center', 4);
INSERT INTO Stop (StopOrder, StopName, RouteID) VALUES (3, 'Elm Street Station', 4);
INSERT INTO Stop (StopOrder, StopName, RouteID) VALUES (4, 'North Park', 4);

-- Chèn dữ liệu vào bảng Stop cho tuyến Maple Avenue
INSERT INTO Stop (StopOrder, StopName, RouteID) VALUES (1, 'West Side', 5);
INSERT INTO Stop (StopOrder, StopName, RouteID) VALUES (2, 'Maple Park', 5);
INSERT INTO Stop (StopOrder, StopName, RouteID) VALUES (3, 'Eastside Market', 5);
INSERT INTO Stop (StopOrder, StopName, RouteID) VALUES (4, 'East Side', 5);


--insert bảng parent
-- Cặp 1 (Bố mẹ)
insert into Parent (Fullname, Email, Phone, Gender, DateOfBirth, Role, Image, AccountID) values ('John Smith', 'john.smith@example.com', '0123456789', 'Male', '1980-01-01', 'Parent', 'image/default.jpg', 12);
insert into Parent (Fullname, Email, Phone, Gender, DateOfBirth, Role, Image, AccountID) values ('Jane Doe', 'jane.doe@example.com', '0987654321', 'Female', '1982-02-02', 'Parent', 'image/default.jpg', 12);

-- Cặp 2 (Bố mẹ)
insert into Parent (Fullname, Email, Phone, Gender, DateOfBirth, Role, Image, AccountID) values ('Michael Johnson', 'michael.johnson@example.com', '0112233445', 'Male', '1975-03-03', 'Parent', 'image/default.jpg', 13);
insert into Parent (Fullname, Email, Phone, Gender, DateOfBirth, Role, Image, AccountID) values ('Emily Davis', 'emily.davis@example.com', '0554332211', 'Female', '1978-04-04', 'Parent', 'image/default.jpg', 13);

-- Cặp 3 (Bố mẹ)
insert into Parent (Fullname, Email, Phone, Gender, DateOfBirth, Role, Image, AccountID) values ('David Wilson', 'david.wilson@example.com', '0129876543', 'Male', '1985-05-05', 'Parent', 'image/default.jpg', 14);
insert into Parent (Fullname, Email, Phone, Gender, DateOfBirth, Role, Image, AccountID) values ('Sarah Brown', 'sarah.brown@example.com', '0934567890', 'Female', '1987-06-06', 'Parent', 'image/default.jpg', 14);

-- Cặp 4 (Bố mẹ)
insert into Parent (Fullname, Email, Phone, Gender, DateOfBirth, Role, Image, AccountID) values ('James Anderson', 'james.anderson@example.com', '0112233446', 'Male', '1983-11-11', 'Parent', 'image/default.jpg', 15);
insert into Parent (Fullname, Email, Phone, Gender, DateOfBirth, Role, Image, AccountID) values ('Patricia Jackson', 'patricia.jackson@example.com', '0554332212', 'Female', '1985-12-12', 'Parent', 'image/default.jpg', 15);

-- Cặp 5 (Bố mẹ)
insert into Parent (Fullname, Email, Phone, Gender, DateOfBirth, Role, Image, AccountID) values ('Robert White', 'robert.white@example.com', '0129876544', 'Male', '1987-01-13', 'Parent', 'image/default.jpg', 16);
insert into Parent (Fullname, Email, Phone, Gender, DateOfBirth, Role, Image, AccountID) values ('Jennifer Martin', 'jennifer.martin@example.com', '0934567891', 'Female', '1989-02-14', 'Parent', 'image/default.jpg', 16);

-- Cặp 6 (Bố mẹ)
insert into Parent (Fullname, Email, Phone, Gender, DateOfBirth, Role, Image, AccountID) values ('Charles Thompson', 'charles.thompson@example.com', '0345678913', 'Male', '1990-03-15', 'Parent', 'image/default.jpg', 17);
insert into Parent (Fullname, Email, Phone, Gender, DateOfBirth, Role, Image, AccountID) values ('Elizabeth Garcia', 'elizabeth.garcia@example.com', '0456789124', 'Female', '1992-04-16', 'Parent', 'image/default.jpg', 17);

-- Bố lẻ
insert into Parent (Fullname, Email, Phone, Gender, DateOfBirth, Role, Image, AccountID) values ('Thomas Miller', 'thomas.miller@example.com', '0345678912', 'Male', '1990-07-07', 'Parent', 'image/default.jpg', 18);

-- Bố lẻ
insert into Parent (Fullname, Email, Phone, Gender, DateOfBirth, Role, Image, AccountID) values ('Daniel Harris', 'daniel.harris@example.com', '0678912345', 'Male', '1991-10-10', 'Parent', 'image/default.jpg', 19);

-- Mẹ lẻ
insert into Parent (Fullname, Email, Phone, Gender, DateOfBirth, Role, Image, AccountID) values ('Linda Taylor', 'linda.taylor@example.com', '0567891234', 'Female', '1988-09-09', 'Parent', 'image/default.jpg', 20);

-- Mẹ lẻ
insert into Parent (Fullname, Email, Phone, Gender, DateOfBirth, Role, Image, AccountID) values ('Laura Wilson', 'laura.wilson@example.com', '0456789123', 'Female', '1992-08-08', 'Parent', 'image/default.jpg', 21);




--insert bảng manager

INSERT INTO Manager (ManagerName, Phone, Gender, DateOfBirth, Image, AccountID) VALUES 
    ('James Smith', '0112233447', 'Male', '1980-01-01', 'image/default.jpg', 7),
    ('Linda Johnson', '0123456789', 'Female', '1982-02-02', 'image/default.jpg', 8),
    ('Michael Brown', '0134567890', 'Male', '1985-03-03', 'image/default.jpg', 9),
    ('Patricia Davis', '0145678901', 'Female', '1987-04-04', 'image/default.jpg', 10),
    ('David Wilson', '0156789012', 'Male', '1990-05-05', 'image/default.jpg', 11);

	INSERT INTO Driver (DriverName, Phone, Gender, DateOfBirth, Image, AccountID) VALUES 
    ('Christopher Lee', '0112233448', 'Male', '1980-06-01', 'image/default.jpg', 2),
    ('Emma Wilson', '0123456780', 'Female', '1982-07-02', 'image/default.jpg', 3),
    ('Lucas Taylor', '0134567891', 'Male', '1985-08-03', 'image/default.jpg', 4),
    ('Ava Anderson', '0145678902', 'Female', '1987-09-04', 'image/default.jpg', 5),
    ('Mason Thomas', '0156789013', 'Male', '1990-10-05', 'image/default.jpg', 6);

--insert bảng student
-- Gia đình 1 (John Smith, Jane Doe) - StopID = 3
insert into Student (Status, Image, StudentName, Gender, DateOfBirth, Class, StopID, AccountID) values ('Active', 'image/default.jpg', 'Smith Liam', 'Male', '2008-05-05', '11A', 3, 12);
insert into Student (Status, Image, StudentName, Gender, DateOfBirth, Class, StopID, AccountID) values ('Active', 'image/default.jpg', 'Smith Emma', 'Female', '2009-06-06', '10B', 3, 12);
insert into Student (Status, Image, StudentName, Gender, DateOfBirth, Class, StopID, AccountID) values ('Active', 'image/default.jpg', 'Smith Noah', 'Male', '2007-07-07', '12A', 3, 12);

-- Gia đình 2 (Michael Johnson, Emily Davis) - StopID = 5
insert into Student (Status, Image, StudentName, Gender, DateOfBirth, Class, StopID, AccountID) values ('Active', 'image/default.jpg', 'Johnson Sophia', 'Female', '2011-04-04', '8B', 5, 13);
insert into Student (Status, Image, StudentName, Gender, DateOfBirth, Class, StopID, AccountID) values ('Active', 'image/default.jpg', 'Johnson Ethan', 'Male', '2012-08-08', '7A', 5, 13);

-- Gia đình 3 (David Wilson, Sarah Brown) - StopID = 7
insert into Student (Status, Image, StudentName, Gender, DateOfBirth, Class, StopID, AccountID) values ('Active', 'image/default.jpg', 'Wilson Ava', 'Female', '2007-12-12', '12B', 7, 14);
insert into Student (Status, Image, StudentName, Gender, DateOfBirth, Class, StopID, AccountID) values ('Active', 'image/default.jpg', 'Wilson Elijah', 'Male', '2012-06-06', '7A', 7, 14);
insert into Student (Status, Image, StudentName, Gender, DateOfBirth, Class, StopID, AccountID) values ('Active', 'image/default.jpg', 'Wilson Mia', 'Female', '2009-09-09', '10B', 7, 14);

-- Gia đình 4 (James Anderson, Patricia Jackson) - StopID = 1
insert into Student (Status, Image, StudentName, Gender, DateOfBirth, Class, StopID, AccountID) values ('Active', 'image/default.jpg', 'Anderson Lucas', 'Male', '2008-05-10', '11B', 1, 15);
insert into Student (Status, Image, StudentName, Gender, DateOfBirth, Class, StopID, AccountID) values ('Active', 'image/default.jpg', 'Anderson Olivia', 'Female', '2012-06-12', '7A', 1, 15);
insert into Student (Status, Image, StudentName, Gender, DateOfBirth, Class, StopID, AccountID) values ('Active', 'image/default.jpg', 'Anderson William', 'Male', '2011-01-13', '8A', 1, 15);

-- Gia đình 5 (Robert White, Jennifer Martin) - StopID = 4
insert into Student (Status, Image, StudentName, Gender, DateOfBirth, Class, StopID, AccountID) values ('Active', 'image/default.jpg', 'White Charlotte', 'Female', '2013-02-02', '6A', 4, 16);
insert into Student (Status, Image, StudentName, Gender, DateOfBirth, Class, StopID, AccountID) values ('Active', 'image/default.jpg', 'White Benjamin', 'Male', '2012-07-07', '7A', 4, 16);

-- Gia đình 6 (Charles Thompson, Elizabeth Garcia) - StopID = 9
insert into Student (Status, Image, StudentName, Gender, DateOfBirth, Class, StopID, AccountID) values ('Active', 'image/default.jpg', 'Thompson James', 'Male', '2011-03-03', '8A', 9, 17);
insert into Student (Status, Image, StudentName, Gender, DateOfBirth, Class, StopID, AccountID) values ('Active', 'image/default.jpg', 'Thompson Lily', 'Female', '2010-08-08', '9A', 9, 17);

-- Gia đình 7 (Bố lẻ Thomas Miller) - StopID = 10
insert into Student (Status, Image, StudentName, Gender, DateOfBirth, Class, StopID, AccountID) values ('Active', 'image/default.jpg', 'Miller Sophia', 'Female', '2018-09-09', '1A', 10, 18);

-- Gia đình 8 (Bố lẻ Daniel Harris) - StopID = 6
insert into Student (Status, Image, StudentName, Gender, DateOfBirth, Class, StopID, AccountID) values ('Active', 'image/default.jpg', 'Harris Jack', 'Male', '2017-01-01', '2B', 6, 19);
insert into Student (Status, Image, StudentName, Gender, DateOfBirth, Class, StopID, AccountID) values ('Active', 'image/default.jpg', 'Harris Emma', 'Female', '2016-02-02', '3A', 6, 19);

-- Gia đình 9 (Mẹ lẻ Linda Taylor) - StopID = 15
insert into Student (Status, Image, StudentName, Gender, DateOfBirth, Class, StopID, AccountID) values ('Active', 'image/default.jpg', 'Taylor Daniel', 'Male', '2011-07-07', '4A', 15, 20);

-- Gia đình 10 (Mẹ lẻ Laura Wilson) - StopID = 11
insert into Student (Status, Image, StudentName, Gender, DateOfBirth, Class, StopID, AccountID) values ('Active', 'image/default.jpg', 'Wilson Olivia', 'Female', '2014-05-05', '5B', 11, 21);

--insert bảng trip

-- Chuyến sáng
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-01', '06:00:00', 'AM', 5, 3, 1);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-02', '06:00:00', 'AM', 1, 1, 2);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-03', '06:00:00', 'AM', 4, 4, 3);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-04', '06:00:00', 'AM', 3, 2, 4);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-05', '06:00:00', 'AM', 2, 5, 5);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-06', '06:00:00', 'AM', 5, 3, 1);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-07', '06:00:00', 'AM', 1, 1, 2);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-08', '06:00:00', 'AM', 4, 4, 3);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-09', '06:00:00', 'AM', 3, 2, 4);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-10', '06:00:00', 'AM', 2, 5, 5);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-11', '06:00:00', 'AM', 5, 3, 1);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-12', '06:00:00', 'AM', 1, 1, 2);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-13', '06:00:00', 'AM', 4, 4, 3);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-14', '06:00:00', 'AM', 3, 2, 4);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-15', '06:00:00', 'AM', 2, 5, 5);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-16', '06:00:00', 'AM', 5, 3, 1);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-17', '06:00:00', 'AM', 1, 1, 2);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-18', '06:00:00', 'AM', 4, 4, 3);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-19', '06:00:00', 'AM', 3, 2, 4);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-20', '06:00:00', 'AM', 2, 5, 5);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-21', '06:00:00', 'AM', 5, 3, 1);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-22', '06:00:00', 'AM', 1, 1, 2);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-23', '06:00:00', 'AM', 4, 4, 3);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-24', '06:00:00', 'AM', 3, 2, 4);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-25', '06:00:00', 'AM', 2, 5, 5);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-26', '06:00:00', 'AM', 5, 3, 1);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-27', '06:00:00', 'AM', 1, 1, 2);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-28', '06:00:00', 'AM', 4, 4, 3);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-29', '06:00:00', 'AM', 3, 2, 4);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-30', '06:00:00', 'AM', 2, 5, 5);

-- Chuyến chiều

insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-01', '13:00:00', 'PM', 2, 5, 1);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-02', '13:00:00', 'PM', 1, 2, 2);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-03', '13:00:00', 'PM', 3, 3, 3);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-04', '13:00:00', 'PM', 5, 4, 4);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-05', '13:00:00', 'PM', 4, 1, 5);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-06', '13:00:00', 'PM', 2, 5, 1);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-07', '13:00:00', 'PM', 1, 2, 2);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-08', '13:00:00', 'PM', 3, 3, 3);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-09', '13:00:00', 'PM', 5, 4, 4);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-10', '13:00:00', 'PM', 4, 1, 5);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-11', '13:00:00', 'PM', 2, 5, 1);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-12', '13:00:00', 'PM', 1, 2, 2);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-13', '13:00:00', 'PM', 3, 3, 3);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-14', '13:00:00', 'PM', 5, 4, 4);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-15', '13:00:00', 'PM', 4, 1, 5);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-16', '13:00:00', 'PM', 2, 5, 1);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-17', '13:00:00', 'PM', 1, 2, 2);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-18', '13:00:00', 'PM', 3, 3, 3);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-19', '13:00:00', 'PM', 5, 4, 4);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-20', '13:00:00', 'PM', 4, 1, 5);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-21', '13:00:00', 'PM', 2, 5, 1);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-22', '13:00:00', 'PM', 1, 2, 2);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-23', '13:00:00', 'PM', 3, 3, 3);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-24', '13:00:00', 'PM', 5, 4, 4);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-25', '13:00:00', 'PM', 4, 1, 5);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-26', '13:00:00', 'PM', 2, 5, 1);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-27', '13:00:00', 'PM', 1, 2, 2);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-28', '13:00:00', 'PM', 3, 3, 3);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-29', '13:00:00', 'PM', 5, 4, 4);
insert into Trip (TripDate, DepartureTime, TimePeriod, DriverID, ManagerID, BusID) values ('2024-09-30', '13:00:00', 'PM', 4, 1, 5);





--insert bảng pick

INSERT INTO Pick (StudentID, TripID, StopID, PickTime, DropTime) VALUES
--tg xe bus khởi hành từ trg 6h và 13 h

(1, 1, 3, '06:45:00', '11:45:00'),
(1, 2, 3, '06:45:00', '11:45:00'),
(1, 3, 3, '06:45:00', '11:45:00'),
(1, 4, 3, '06:45:00', '11:45:00'),
(1, 5, 3, '06:45:00', '11:45:00'),
(1, 6, 3, '06:45:00', '11:45:00'),
(1, 7, 3, '06:45:00', '11:45:00'),
(1, 8, 3, '06:45:00', '11:45:00'),
(1, 9, 3, '06:45:00', '11:45:00'),
(1, 10, 3, '06:45:00', '11:45:00'),
(1, 11, 3, '06:45:00', '11:45:00'),
(1, 12, 3, '06:45:00', '11:45:00'),
(1, 13, 3, '06:45:00', '11:45:00'),
(1, 14, 3, '06:45:00', '11:45:00'),
(1, 15, 3, '06:45:00', '11:45:00'),
(1, 16, 3, '06:45:00', '11:45:00'),
(1, 17, 3, '06:45:00', '11:45:00'),
(1, 18, 3, '06:45:00', '11:45:00'),
(1, 19, 3, '06:45:00', '11:45:00'),
(1, 20, 3, '06:45:00', '11:45:00'),
(1, 21, 3, '06:45:00', '11:45:00'),
(1, 22, 3, '06:45:00', '11:45:00'),
(1, 23, 3, '06:45:00', '11:45:00'),
(1, 24, 3, '06:45:00', '11:45:00'),
(1, 25, 3, '06:45:00', '11:45:00'),
(1, 26, 3, '06:45:00', '11:45:00'),
(1, 27, 3, '06:45:00', '11:45:00'),
(1, 28, 3, '06:45:00', '11:45:00'),
(1, 29, 3, '06:45:00', '11:45:00'),
(1, 30, 3, '06:45:00', '11:45:00'),


(2, 1, 3, '06:45:00', '11:45:00'),
(2, 2, 3, '06:45:00', '11:45:00'),
(2, 3, 3, '06:45:00', '11:45:00'),
(2, 4, 3, '06:45:00', '11:45:00'),
(2, 5, 3, '06:45:00', '11:45:00'),
(2, 6, 3, '06:45:00', '11:45:00'),
(2, 7, 3, '06:45:00', '11:45:00'),
(2, 8, 3, '06:45:00', '11:45:00'),
(2, 9, 3, '06:45:00', '11:45:00'),
(2, 10, 3, '06:45:00', '11:45:00'),
(2, 11, 3, '06:45:00', '11:45:00'),
(2, 12, 3, '06:45:00', '11:45:00'),
(2, 13, 3, '06:45:00', '11:45:00'),
(2, 14, 3, '06:45:00', '11:45:00'),
(2, 15, 3, '06:45:00', '11:45:00'),
(2, 16, 3, '06:45:00', '11:45:00'),
(2, 17, 3, '06:45:00', '11:45:00'),
(2, 18, 3, '06:45:00', '11:45:00'),
(2, 19, 3, '06:45:00', '11:45:00'),
(2, 20, 3, '06:45:00', '11:45:00'),
(2, 21, 3, '06:45:00', '11:45:00'),
(2, 22, 3, '06:45:00', '11:45:00'),
(2, 23, 3, '06:45:00', '11:45:00'),
(2, 24, 3, '06:45:00', '11:45:00'),
(2, 25, 3, '06:45:00', '11:45:00'),
(2, 26, 3, '06:45:00', '11:45:00'),
(2, 27, 3, '06:45:00', '11:45:00'),
(2, 28, 3, '06:45:00', '11:45:00'),
(2, 29, 3, '06:45:00', '11:45:00'),
(2, 30, 3, '06:45:00', '11:45:00'),

(3, 1, 3, '06:45:00', '11:45:00'),
(3, 2, 3, '06:45:00', '11:45:00'),
(3, 3, 3, '06:45:00', '11:45:00'),
(3, 4, 3, '06:45:00', '11:45:00'),
(3, 5, 3, '06:45:00', '11:45:00'),
(3, 6, 3, '06:45:00', '11:45:00'),
(3, 7, 3, '06:45:00', '11:45:00'),
(3, 8, 3, '06:45:00', '11:45:00'),
(3, 9, 3, '06:45:00', '11:45:00'),
(3, 10, 3, '06:45:00', '11:45:00'),
(3, 11, 3, '06:45:00', '11:45:00'),
(3, 12, 3, '06:45:00', '11:45:00'),
(3, 13, 3, '06:45:00', '11:45:00'),
(3, 14, 3, '06:45:00', '11:45:00'),
(3, 15, 3, '06:45:00', '11:45:00'),
(3, 16, 3, '06:45:00', '11:45:00'),
(3, 17, 3, '06:45:00', '11:45:00'),
(3, 18, 3, '06:45:00', '11:45:00'),
(3, 19, 3, '06:45:00', '11:45:00'),
(3, 20, 3, '06:45:00', '11:45:00'),
(3, 21, 3, '06:45:00', '11:45:00'),
(3, 22, 3, '06:45:00', '11:45:00'),
(3, 23, 3, '06:45:00', '11:45:00'),
(3, 24, 3, '06:45:00', '11:45:00'),
(3, 25, 3, '06:45:00', '11:45:00'),
(3, 26, 3, '06:45:00', '11:45:00'),
(3, 27, 3, '06:45:00', '11:45:00'),
(3, 28, 3, '06:45:00', '11:45:00'),
(3, 29, 3, '06:45:00', '11:45:00'),
(3, 30, 3, '06:45:00', '11:45:00'),


(4, 1, 5, '06:15:00', '11:15:00'),
(4, 2, 5, '06:15:00', '11:15:00'),
(4, 3, 5, '06:15:00', '11:15:00'),
(4, 4, 5, '06:15:00', '11:15:00'),
(4, 5, 5, '06:15:00', '11:15:00'),
(4, 6, 5, '06:15:00', '11:15:00'),
(4, 7, 5, '06:15:00', '11:15:00'),
(4, 8, 5, '06:15:00', '11:15:00'),
(4, 9, 5, '06:15:00', '11:15:00'),
(4, 10,5, '06:15:00', '11:15:00'),
(4, 11,5, '06:15:00', '11:15:00'),
(4, 12,5, '06:15:00', '11:15:00'),
(4, 13,5, '06:15:00', '11:15:00'),
(4, 14,5, '06:15:00', '11:15:00'),
(4, 15,5, '06:15:00', '11:15:00'),
(4, 16,5, '06:15:00', '11:15:00'),
(4, 17,5, '06:15:00', '11:15:00'),
(4, 18,5, '06:15:00', '11:15:00'),
(4, 19,5, '06:15:00', '11:15:00'),
(4, 20,5, '06:15:00', '11:15:00'),
(4, 21,5, '06:15:00', '11:15:00'),
(4, 22,5, '06:15:00', '11:15:00'),
(4, 23,5, '06:15:00', '11:15:00'),
(4, 24,5, '06:15:00', '11:15:00'),
(4, 25,5, '06:15:00', '11:15:00'),
(4, 26,5, '06:15:00', '11:15:00'),
(4, 27,5, '06:15:00', '11:15:00'),
(4, 28,5, '06:15:00', '11:15:00'),
(4, 29,5, '06:15:00', '11:15:00'),
(4, 30,5, '06:15:00', '11:15:00'),


(5, 1, 5, '06:15:00', '11:15:00'),
(5, 2, 5, '06:15:00', '11:15:00'),
(5, 3, 5, '06:15:00', '11:15:00'),
(5, 4, 5, '06:15:00', '11:15:00'),
(5, 5, 5, '06:15:00', '11:15:00'),
(5, 6, 5, '06:15:00', '11:15:00'),
(5, 7, 5, '06:15:00', '11:15:00'),
(5, 8, 5, '06:15:00', '11:15:00'),
(5, 9, 5, '06:15:00', '11:15:00'),
(5, 10,5, '06:15:00', '11:15:00'),
(5, 11,5, '06:15:00', '11:15:00'),
(5, 12,5, '06:15:00', '11:15:00'),
(5, 13,5, '06:15:00', '11:15:00'),
(5, 14,5, '06:15:00', '11:15:00'),
(5, 15,5, '06:15:00', '11:15:00'),
(5, 16,5, '06:15:00', '11:15:00'),
(5, 17,5, '06:15:00', '11:15:00'),
(5, 18,5, '06:15:00', '11:15:00'),
(5, 19,5, '06:15:00', '11:15:00'),
(5, 20,5, '06:15:00', '11:15:00'),
(5, 21,5, '06:15:00', '11:15:00'),
(5, 22,5, '06:15:00', '11:15:00'),
(5, 23,5, '06:15:00', '11:15:00'),
(5, 24,5, '06:15:00', '11:15:00'),
(5, 25,5, '06:15:00', '11:15:00'),
(5, 26,5, '06:15:00', '11:15:00'),
(5, 27,5, '06:15:00', '11:15:00'),
(5, 28,5, '06:15:00', '11:15:00'),
(5, 29,5, '06:15:00', '11:15:00'),
(5, 30,5, '06:15:00', '11:15:00'),

(6, 1, 7, '06:45:00', '11:45:00'),
(6, 2, 7, '06:45:00', '11:45:00'),
(6, 3, 7, '06:45:00', '11:45:00'),
(6, 4, 7, '06:45:00', '11:45:00'),
(6, 5, 7, '06:45:00', '11:45:00'),
(6, 6, 7, '06:45:00', '11:45:00'),
(6, 7, 7, '06:45:00', '11:45:00'),
(6, 8, 7, '06:45:00', '11:45:00'),
(6, 9, 7, '06:45:00', '11:45:00'),
(6, 10,7, '06:45:00', '11:45:00'),
(6, 11,7, '06:45:00', '11:45:00'),
(6, 12,7, '06:45:00', '11:45:00'),
(6, 13,7, '06:45:00', '11:45:00'),
(6, 14,7, '06:45:00', '11:45:00'),
(6, 15,7, '06:45:00', '11:45:00'),
(6, 16,7, '06:45:00', '11:45:00'),
(6, 17,7, '06:45:00', '11:45:00'),
(6, 18,7, '06:45:00', '11:45:00'),
(6, 19,7, '06:45:00', '11:45:00'),
(6, 20,7, '06:45:00', '11:45:00'),
(6, 21,7, '06:45:00', '11:45:00'),
(6, 22,7, '06:45:00', '11:45:00'),
(6, 23,7, '06:45:00', '11:45:00'),
(6, 24,7, '06:45:00', '11:45:00'),
(6, 25,7, '06:45:00', '11:45:00'),
(6, 26,7, '06:45:00', '11:45:00'),
(6, 27,7, '06:45:00', '11:45:00'),
(6, 28,7, '06:45:00', '11:45:00'),
(6, 29,7, '06:45:00', '11:45:00'),
(6, 30,7, '06:45:00', '11:45:00'),

(7, 1, 7, '06:45:00', '11:45:00'),
(7, 2, 7, '06:45:00', '11:45:00'),
(7, 3, 7, '06:45:00', '11:45:00'),
(7, 4, 7, '06:45:00', '11:45:00'),
(7, 5, 7, '06:45:00', '11:45:00'),
(7, 6, 7, '06:45:00', '11:45:00'),
(7, 7, 7, '06:45:00', '11:45:00'),
(7, 8, 7, '06:45:00', '11:45:00'),
(7, 9, 7, '06:45:00', '11:45:00'),
(7, 10,7, '06:45:00', '11:45:00'),
(7, 11,7, '06:45:00', '11:45:00'),
(7, 12,7, '06:45:00', '11:45:00'),
(7, 13,7, '06:45:00', '11:45:00'),
(7, 14,7, '06:45:00', '11:45:00'),
(7, 15,7, '06:45:00', '11:45:00'),
(7, 16,7, '06:45:00', '11:45:00'),
(7, 17,7, '06:45:00', '11:45:00'),
(7, 18,7, '06:45:00', '11:45:00'),
(7, 19,7, '06:45:00', '11:45:00'),
(7, 20,7, '06:45:00', '11:45:00'),
(7, 21,7, '06:45:00', '11:45:00'),
(7, 22,7, '06:45:00', '11:45:00'),
(7, 23,7, '06:45:00', '11:45:00'),
(7, 24,7, '06:45:00', '11:45:00'),
(7, 25,7, '06:45:00', '11:45:00'),
(7, 26,7, '06:45:00', '11:45:00'),
(7, 27,7, '06:45:00', '11:45:00'),
(7, 28,7, '06:45:00', '11:45:00'),
(7, 29,7, '06:45:00', '11:45:00'),
(7, 30,7, '06:45:00', '11:45:00'),


(8, 1, 7, '06:45:00', '11:45:00'),
(8, 2, 7, '06:45:00', '11:45:00'),
(8, 3, 7, '06:45:00', '11:45:00'),
(8, 4, 7, '06:45:00', '11:45:00'),
(8, 5, 7, '06:45:00', '11:45:00'),
(8, 6, 7, '06:45:00', '11:45:00'),
(8, 7, 7, '06:45:00', '11:45:00'),
(8, 8, 7, '06:45:00', '11:45:00'),
(8, 9, 7, '06:45:00', '11:45:00'),
(8, 10,7, '06:45:00', '11:45:00'),
(8, 11,7, '06:45:00', '11:45:00'),
(8, 12,7, '06:45:00', '11:45:00'),
(8, 13,7, '06:45:00', '11:45:00'),
(8, 14,7, '06:45:00', '11:45:00'),
(8, 15,7, '06:45:00', '11:45:00'),
(8, 16,7, '06:45:00', '11:45:00'),
(8, 17,7, '06:45:00', '11:45:00'),
(8, 18,7, '06:45:00', '11:45:00'),
(8, 19,7, '06:45:00', '11:45:00'),
(8, 20,7, '06:45:00', '11:45:00'),
(8, 21,7, '06:45:00', '11:45:00'),
(8, 22,7, '06:45:00', '11:45:00'),
(8, 23,7, '06:45:00', '11:45:00'),
(8, 24,7, '06:45:00', '11:45:00'),
(8, 25,7, '06:45:00', '11:45:00'),
(8, 26,7, '06:45:00', '11:45:00'),
(8, 27,7, '06:45:00', '11:45:00'),
(8, 28,7, '06:45:00', '11:45:00'),
(8, 29,7, '06:45:00', '11:45:00'),
(8, 30,7, '06:45:00', '11:45:00'),


(9, 1, 1, '06:15:00', '11:15:00'),
(9, 2, 1, '06:15:00', '11:15:00'),
(9, 3, 1, '06:15:00', '11:15:00'),
(9, 4, 1, '06:15:00', '11:15:00'),
(9, 5, 1, '06:15:00', '11:15:00'),
(9, 6, 1, '06:15:00', '11:15:00'),
(9, 7, 1, '06:15:00', '11:15:00'),
(9, 8, 1, '06:15:00', '11:15:00'),
(9, 9, 1, '06:15:00', '11:15:00'),
(9, 10,1, '06:15:00', '11:15:00'),
(9, 11,1, '06:15:00', '11:15:00'),
(9, 12,1, '06:15:00', '11:15:00'),
(9, 13,1, '06:15:00', '11:15:00'),
(9, 14,1, '06:15:00', '11:15:00'),
(9, 15,1, '06:15:00', '11:15:00'),
(9, 16,1, '06:15:00', '11:15:00'),
(9, 17,1, '06:15:00', '11:15:00'),
(9, 18,1, '06:15:00', '11:15:00'),
(9, 19,1, '06:15:00', '11:15:00'),
(9, 20,1, '06:15:00', '11:15:00'),
(9, 21,1, '06:15:00', '11:15:00'),
(9, 22,1, '06:15:00', '11:15:00'),
(9, 23,1, '06:15:00', '11:15:00'),
(9, 24,1, '06:15:00', '11:15:00'),
(9, 25,1, '06:15:00', '11:15:00'),
(9, 26,1, '06:15:00', '11:15:00'),
(9, 27,1, '06:15:00', '11:15:00'),
(9, 28,1, '06:15:00', '11:15:00'),
(9, 29,1, '06:15:00', '11:15:00'),
(9, 30,1, '06:15:00', '11:15:00'),

(10, 1, 1, '06:15:00', '11:15:00'),
(10, 2, 1, '06:15:00', '11:15:00'),
(10, 3, 1, '06:15:00', '11:15:00'),
(10, 4, 1, '06:15:00', '11:15:00'),
(10, 5, 1, '06:15:00', '11:15:00'),
(10, 6, 1, '06:15:00', '11:15:00'),
(10, 7, 1, '06:15:00', '11:15:00'),
(10, 8, 1, '06:15:00', '11:15:00'),
(10, 9, 1, '06:15:00', '11:15:00'),
(10, 10,1, '06:15:00', '11:15:00'),
(10, 11,1, '06:15:00', '11:15:00'),
(10, 12,1, '06:15:00', '11:15:00'),
(10, 13,1, '06:15:00', '11:15:00'),
(10, 14,1, '06:15:00', '11:15:00'),
(10, 15,1, '06:15:00', '11:15:00'),
(10, 16,1, '06:15:00', '11:15:00'),
(10, 17,1, '06:15:00', '11:15:00'),
(10, 18,1, '06:15:00', '11:15:00'),
(10, 19,1, '06:15:00', '11:15:00'),
(10, 20,1, '06:15:00', '11:15:00'),
(10, 21,1, '06:15:00', '11:15:00'),
(10, 22,1, '06:15:00', '11:15:00'),
(10, 23,1, '06:15:00', '11:15:00'),
(10, 24,1, '06:15:00', '11:15:00'),
(10, 25,1, '06:15:00', '11:15:00'),
(10, 26,1, '06:15:00', '11:15:00'),
(10, 27,1, '06:15:00', '11:15:00'),
(10, 28,1, '06:15:00', '11:15:00'),
(10, 29,1, '06:15:00', '11:15:00'),
(10, 30,1, '06:15:00', '11:15:00'),

(11, 31, 1, '13:15:00', '16:45:00'),
(11, 32, 1, '13:15:00', '16:45:00'),
(11, 33, 1, '13:15:00', '16:45:00'),
(11, 34, 1, '13:15:00', '16:45:00'),
(11, 35, 1, '13:15:00', '16:45:00'),
(11, 36, 1, '13:15:00', '16:45:00'),
(11, 37, 1, '13:15:00', '16:45:00'),
(11, 38, 1, '13:15:00', '16:45:00'),
(11, 39, 1, '13:15:00', '16:45:00'),
(11, 40,1, '13:15:00', '16:45:00'),
(11, 41,1, '13:15:00', '16:45:00'),
(11, 42,1, '13:15:00', '16:45:00'),
(11, 43,1, '13:15:00', '16:45:00'),
(11, 44,1, '13:15:00', '16:45:00'),
(11, 45,1, '13:15:00', '16:45:00'),
(11, 46,1, '13:15:00', '16:45:00'),
(11, 47,1, '13:15:00', '16:45:00'),
(11, 48,1, '13:15:00', '16:45:00'),
(11, 49,1, '13:15:00', '16:45:00'),
(11, 50,1, '13:15:00', '16:45:00'),
(11, 51,1, '13:15:00', '16:45:00'),
(11, 52,1, '13:15:00', '16:45:00'),
(11, 53,1, '13:15:00', '16:45:00'),
(11, 54,1, '13:15:00', '16:45:00'),
(11, 55,1, '13:15:00', '16:45:00'),
(11, 56,1, '13:15:00', '16:45:00'),
(11, 57,1, '13:15:00', '16:45:00'),
(11, 58,1, '13:15:00', '16:45:00'),
(11, 59,1, '13:15:00', '16:45:00'),
(11, 60,1, '13:15:00', '16:45:00'),

(12, 31, 4, '14:00:00', '17:30:00'),
(12, 32, 4, '14:00:00', '17:30:00'),
(12, 33, 4, '14:00:00', '17:30:00'),
(12, 34, 4, '14:00:00', '17:30:00'),
(12, 35, 4, '14:00:00', '17:30:00'),
(12, 36, 4, '14:00:00', '17:30:00'),
(12, 37, 4, '14:00:00', '17:30:00'),
(12, 38, 4, '14:00:00', '17:30:00'),
(12, 39, 4, '14:00:00', '17:30:00'),
(12, 40,4, '14:00:00', '17:30:00'),
(12, 41,4, '14:00:00', '17:30:00'),
(12, 42,4, '14:00:00', '17:30:00'),
(12, 43,4, '14:00:00', '17:30:00'),
(12, 44,4, '14:00:00', '17:30:00'),
(12, 45,4, '14:00:00', '17:30:00'),
(12, 46,4, '14:00:00', '17:30:00'),
(12, 47,4, '14:00:00', '17:30:00'),
(12, 48,4, '14:00:00', '17:30:00'),
(12, 49,4, '14:00:00', '17:30:00'),
(12, 50,4, '14:00:00', '17:30:00'),
(12, 51,4, '14:00:00', '17:30:00'),
(12, 52,4, '14:00:00', '17:30:00'),
(12, 53,4, '14:00:00', '17:30:00'),
(12, 54,4, '14:00:00', '17:30:00'),
(12, 55,4, '14:00:00', '17:30:00'),
(12, 56,4, '14:00:00', '17:30:00'),
(12, 57,4, '14:00:00', '17:30:00'),
(12, 58,4, '14:00:00', '17:30:00'),
(12, 59,4, '14:00:00', '17:30:00'),
(12, 60,4, '14:00:00', '17:30:00'),


(13, 31, 4, '14:00:00', '17:30:00'),
(13, 32, 4, '14:00:00', '17:30:00'),
(13, 33, 4, '14:00:00', '17:30:00'),
(13, 34, 4, '14:00:00', '17:30:00'),
(13, 35, 4, '14:00:00', '17:30:00'),
(13, 36, 4, '14:00:00', '17:30:00'),
(13, 37, 4, '14:00:00', '17:30:00'),
(13, 38, 4, '14:00:00', '17:30:00'),
(13, 39, 4, '14:00:00', '17:30:00'),
(13, 40,4, '14:00:00', '17:30:00'),
(13, 41,4, '14:00:00', '17:30:00'),
(13, 42,4, '14:00:00', '17:30:00'),
(13, 43,4, '14:00:00', '17:30:00'),
(13, 44,4, '14:00:00', '17:30:00'),
(13, 45,4, '14:00:00', '17:30:00'),
(13, 46,4, '14:00:00', '17:30:00'),
(13, 47,4, '14:00:00', '17:30:00'),
(13, 48,4, '14:00:00', '17:30:00'),
(13, 49,4, '14:00:00', '17:30:00'),
(13, 50,4, '14:00:00', '17:30:00'),
(13, 51,4, '14:00:00', '17:30:00'),
(13, 52,4, '14:00:00', '17:30:00'),
(13, 53,4, '14:00:00', '17:30:00'),
(13, 54,4, '14:00:00', '17:30:00'),
(13, 55,4, '14:00:00', '17:30:00'),
(13, 56,4, '14:00:00', '17:30:00'),
(13, 57,4, '14:00:00', '17:30:00'),
(13, 58,4, '14:00:00', '17:30:00'),
(13, 59,4, '14:00:00', '17:30:00'),
(13, 60,4, '14:00:00', '17:30:00'),

(14, 31, 9, '13:15:00', '16:45:00'),
(14, 32, 9, '13:15:00', '16:45:00'),
(14, 33, 9, '13:15:00', '16:45:00'),
(14, 34, 9, '13:15:00', '16:45:00'),
(14, 35, 9, '13:15:00', '16:45:00'),
(14, 36, 9, '13:15:00', '16:45:00'),
(14, 37, 9, '13:15:00', '16:45:00'),
(14, 38, 9, '13:15:00', '16:45:00'),
(14, 39, 9, '13:15:00', '16:45:00'),
(14, 40,9, '13:15:00', '16:45:00'),
(14, 41,9, '13:15:00', '16:45:00'),
(14, 42,9, '13:15:00', '16:45:00'),
(14, 43,9, '13:15:00', '16:45:00'),
(14, 44,9, '13:15:00', '16:45:00'),
(14, 45,9, '13:15:00', '16:45:00'),
(14, 46,9, '13:15:00', '16:45:00'),
(14, 47,9, '13:15:00', '16:45:00'),
(14, 48,9, '13:15:00', '16:45:00'),
(14, 49,9, '13:15:00', '16:45:00'),
(14, 50,9, '13:15:00', '16:45:00'),
(14, 51,9, '13:15:00', '16:45:00'),
(14, 52,9, '13:15:00', '16:45:00'),
(14, 53,9, '13:15:00', '16:45:00'),
(14, 54,9, '13:15:00', '16:45:00'),
(14, 55,9, '13:15:00', '16:45:00'),
(14, 56,9, '13:15:00', '16:45:00'),
(14, 57,9, '13:15:00', '16:45:00'),
(14, 58,9, '13:15:00', '16:45:00'),
(14, 59,9, '13:15:00', '16:45:00'),
(14, 60,9, '13:15:00', '16:45:00'),

(15, 31, 9, '13:15:00', '16:45:00'),
(15, 32, 9, '13:15:00', '16:45:00'),
(15, 33, 9, '13:15:00', '16:45:00'),
(15, 34, 9, '13:15:00', '16:45:00'),
(15, 35, 9, '13:15:00', '16:45:00'),
(15, 36, 9, '13:15:00', '16:45:00'),
(15, 37, 9, '13:15:00', '16:45:00'),
(15, 38, 9, '13:15:00', '16:45:00'),
(15, 39, 9, '13:15:00', '16:45:00'),
(15, 40,9, '13:15:00', '16:45:00'),
(15, 41,9, '13:15:00', '16:45:00'),
(15, 42,9, '13:15:00', '16:45:00'),
(15, 43,9, '13:15:00', '16:45:00'),
(15, 44,9, '13:15:00', '16:45:00'),
(15, 45,9, '13:15:00', '16:45:00'),
(15, 46,9, '13:15:00', '16:45:00'),
(15, 47,9, '13:15:00', '16:45:00'),
(15, 48,9, '13:15:00', '16:45:00'),
(15, 49,9, '13:15:00', '16:45:00'),
(15, 50,9, '13:15:00', '16:45:00'),
(15, 51,9, '13:15:00', '16:45:00'),
(15, 52,9, '13:15:00', '16:45:00'),
(15, 53,9, '13:15:00', '16:45:00'),
(15, 54,9, '13:15:00', '16:45:00'),
(15, 55,9, '13:15:00', '16:45:00'),
(15, 56,9, '13:15:00', '16:45:00'),
(15, 57,9, '13:15:00', '16:45:00'),
(15, 58,9, '13:15:00', '16:45:00'),
(15, 59,9, '13:15:00', '16:45:00'),
(15, 60,9, '13:15:00', '16:45:00'),

(16, 31, 10, '13:30:00', '17:00:00'),
(16, 32, 10, '13:30:00', '17:00:00'),
(16, 33, 10, '13:30:00', '17:00:00'),
(16, 34, 10, '13:30:00', '17:00:00'),
(16, 35, 10, '13:30:00', '17:00:00'),
(16, 36, 10, '13:30:00', '17:00:00'),
(16, 37, 10, '13:30:00', '17:00:00'),
(16, 38, 10, '13:30:00', '17:00:00'),
(16, 39, 10, '13:30:00', '17:00:00'),
(16, 40,10, '13:30:00', '17:00:00'),
(16, 41,10, '13:30:00', '17:00:00'),
(16, 42,10, '13:30:00', '17:00:00'),
(16, 43,10, '13:30:00', '17:00:00'),
(16, 44,10, '13:30:00', '17:00:00'),
(16, 45,10, '13:30:00', '17:00:00'),
(16, 46,10, '13:30:00', '17:00:00'),
(16, 47,10, '13:30:00', '17:00:00'),
(16, 48,10, '13:30:00', '17:00:00'),
(16, 49,10, '13:30:00', '17:00:00'),
(16, 50,10, '13:30:00', '17:00:00'),
(16, 51,10, '13:30:00', '17:00:00'),
(16, 52,10, '13:30:00', '17:00:00'),
(16, 53,10, '13:30:00', '17:00:00'),
(16, 54,10, '13:30:00', '17:00:00'),
(16, 55,10, '13:30:00', '17:00:00'),
(16, 56,10, '13:30:00', '17:00:00'),
(16, 57,10, '13:30:00', '17:00:00'),
(16, 58,10, '13:30:00', '17:00:00'),
(16, 59,10, '13:30:00', '17:00:00'),
(16, 60,10, '13:30:00', '17:00:00'),

(17, 31, 6, '13:30:00', '17:00:00'),
(17, 32, 6, '13:30:00', '17:00:00'),
(17, 33, 6, '13:30:00', '17:00:00'),
(17, 34, 6, '13:30:00', '17:00:00'),
(17, 35, 6, '13:30:00', '17:00:00'),
(17, 36, 6, '13:30:00', '17:00:00'),
(17, 37, 6, '13:30:00', '17:00:00'),
(17, 38, 6, '13:30:00', '17:00:00'),
(17, 39, 6, '13:30:00', '17:00:00'),
(17, 40,6, '13:30:00', '17:00:00'),
(17, 41,6, '13:30:00', '17:00:00'),
(17, 42,6, '13:30:00', '17:00:00'),
(17, 43,6, '13:30:00', '17:00:00'),
(17, 44,6, '13:30:00', '17:00:00'),
(17, 45,6, '13:30:00', '17:00:00'),
(17, 46,6, '13:30:00', '17:00:00'),
(17, 47,6, '13:30:00', '17:00:00'),
(17, 48,6, '13:30:00', '17:00:00'),
(17, 49,6, '13:30:00', '17:00:00'),
(17, 50,6, '13:30:00', '17:00:00'),
(17, 51,6, '13:30:00', '17:00:00'),
(17, 52,6, '13:30:00', '17:00:00'),
(17, 53,6, '13:30:00', '17:00:00'),
(17, 54,6, '13:30:00', '17:00:00'),
(17, 55,6, '13:30:00', '17:00:00'),
(17, 56,6, '13:30:00', '17:00:00'),
(17, 57,6, '13:30:00', '17:00:00'),
(17, 58,6, '13:30:00', '17:00:00'),
(17, 59,6, '13:30:00', '17:00:00'),
(17, 60,6, '13:30:00', '17:00:00'),

(18, 31, 6, '13:30:00', '17:00:00'),
(18, 32, 6, '13:30:00', '17:00:00'),
(18, 33, 6, '13:30:00', '17:00:00'),
(18, 34, 6, '13:30:00', '17:00:00'),
(18, 35, 6, '13:30:00', '17:00:00'),
(18, 36, 6, '13:30:00', '17:00:00'),
(18, 37, 6, '13:30:00', '17:00:00'),
(18, 38, 6, '13:30:00', '17:00:00'),
(18, 39, 6, '13:30:00', '17:00:00'),
(18, 40,6, '13:30:00', '17:00:00'),
(18, 41,6, '13:30:00', '17:00:00'),
(18, 42,6, '13:30:00', '17:00:00'),
(18, 43,6, '13:30:00', '17:00:00'),
(18, 44,6, '13:30:00', '17:00:00'),
(18, 45,6, '13:30:00', '17:00:00'),
(18, 46,6, '13:30:00', '17:00:00'),
(18, 47,6, '13:30:00', '17:00:00'),
(18, 48,6, '13:30:00', '17:00:00'),
(18, 49,6, '13:30:00', '17:00:00'),
(18, 50,6, '13:30:00', '17:00:00'),
(18, 51,6, '13:30:00', '17:00:00'),
(18, 52,6, '13:30:00', '17:00:00'),
(18, 53,6, '13:30:00', '17:00:00'),
(18, 54,6, '13:30:00', '17:00:00'),
(18, 55,6, '13:30:00', '17:00:00'),
(18, 56,6, '13:30:00', '17:00:00'),
(18, 57,6, '13:30:00', '17:00:00'),
(18, 58,6, '13:30:00', '17:00:00'),
(18, 59,6, '13:30:00', '17:00:00'),
(18, 60,6, '13:30:00', '17:00:00'),

(19, 31, 15, '13:45:00', '17:15:00'),
(19, 32, 15, '13:45:00', '17:15:00'),
(19, 33, 15, '13:45:00', '17:15:00'),
(19, 34, 15, '13:45:00', '17:15:00'),
(19, 35, 15, '13:45:00', '17:15:00'),
(19, 36, 15, '13:45:00', '17:15:00'),
(19, 37, 15, '13:45:00', '17:15:00'),
(19, 38, 15, '13:45:00', '17:15:00'),
(19, 39, 15, '13:45:00', '17:15:00'),
(19, 40,15, '13:45:00', '17:15:00'),
(19, 41,15, '13:45:00', '17:15:00'),
(19, 42,15, '13:45:00', '17:15:00'),
(19, 43,15, '13:45:00', '17:15:00'),
(19, 44,15, '13:45:00', '17:15:00'),
(19, 45,15, '13:45:00', '17:15:00'),
(19, 46,15, '13:45:00', '17:15:00'),
(19, 47,15, '13:45:00', '17:15:00'),
(19, 48,15, '13:45:00', '17:15:00'),
(19, 49,15, '13:45:00', '17:15:00'),
(19, 50,15, '13:45:00', '17:15:00'),
(19, 51,15, '13:45:00', '17:15:00'),
(19, 52,15, '13:45:00', '17:15:00'),
(19, 53,15, '13:45:00', '17:15:00'),
(19, 54,15, '13:45:00', '17:15:00'),
(19, 55,15, '13:45:00', '17:15:00'),
(19, 56,15, '13:45:00', '17:15:00'),
(19, 57,15, '13:45:00', '17:15:00'),
(19, 58,15, '13:45:00', '17:15:00'),
(19, 59,15, '13:45:00', '17:15:00'),
(19, 60,15, '13:45:00', '17:15:00'),

(20, 31, 11, '13:45:00', '17:15:00'),
(20, 32, 11, '13:45:00', '17:15:00'),
(20, 33, 11, '13:45:00', '17:15:00'),
(20, 34, 11, '13:45:00', '17:15:00'),
(20, 35, 11, '13:45:00', '17:15:00'),
(20, 36, 11, '13:45:00', '17:15:00'),
(20, 37, 11, '13:45:00', '17:15:00'),
(20, 38, 11, '13:45:00', '17:15:00'),
(20, 39, 11, '13:45:00', '17:15:00'),
(20, 40,11, '13:45:00', '17:15:00'),
(20, 41,11, '13:45:00', '17:15:00'),
(20, 42,11, '13:45:00', '17:15:00'),
(20, 43,11, '13:45:00', '17:15:00'),
(20, 44,11, '13:45:00', '17:15:00'),
(20, 45,11, '13:45:00', '17:15:00'),
(20, 46,11, '13:45:00', '17:15:00'),
(20, 47,11, '13:45:00', '17:15:00'),
(20, 48,11, '13:45:00', '17:15:00'),
(20, 49,11, '13:45:00', '17:15:00'),
(20, 50,11, '13:45:00', '17:15:00'),
(20, 51,11, '13:45:00', '17:15:00'),
(20, 52,11, '13:45:00', '17:15:00'),
(20, 53,11, '13:45:00', '17:15:00'),
(20, 54,11, '13:45:00', '17:15:00'),
(20, 55,11, '13:45:00', '17:15:00'),
(20, 56,11, '13:45:00', '17:15:00'),
(20, 57,11, '13:45:00', '17:15:00'),
(20, 58,11, '13:45:00', '17:15:00'),
(20, 59,11, '13:45:00', '17:15:00'),
(20, 60,11, '13:45:00', '17:15:00');


--insert bảng attendance
-- Chèn dữ liệu vào bảng Attendance
INSERT INTO Attendance (AttendanceDate, TimePeriod, PickEstimate, DropEstimate, Status, StudentID, ParentID) VALUES 
('2024-09-01', 'AM', '06:45:00', '11:45:00', 'Absent', 1, 1), 
('2024-09-02', 'AM', '06:45:00', '11:45:00', 'Present', 1, 1), 
('2024-09-03', 'AM', '06:45:00', '11:45:00', 'Present', 1, 1), 
('2024-09-04', 'AM', '06:45:00', '11:45:00', 'Present', 1, 1), 
('2024-09-05', 'AM', '06:45:00', '11:45:00', 'Present', 1, 1), 
('2024-09-06', 'AM', '06:45:00', '11:45:00', 'Present', 1, 1), 
('2024-09-07', 'AM', '06:45:00', '11:45:00', 'Absent', 1, 1), 
('2024-09-08', 'AM', '06:45:00', '11:45:00', 'Absent', 1, 1), 
('2024-09-09', 'AM', '06:45:00', '11:45:00', 'Present', 1, 1), 
('2024-09-10', 'AM', '06:45:00', '11:45:00', 'Present', 1, 1), 
('2024-09-11', 'AM', '06:45:00', '11:45:00', 'Present', 1, 1), 
('2024-09-12', 'AM', '06:45:00', '11:45:00', 'Present', 1, 1), 
('2024-09-13', 'AM', '06:45:00', '11:45:00', 'Present', 1, 1), 
('2024-09-14', 'AM', '06:45:00', '11:45:00', 'Absent', 1, 1), 
('2024-09-15', 'AM', '06:45:00', '11:45:00', 'Absent', 1, 1), 
('2024-09-16', 'AM', '06:45:00', '11:45:00', 'Present', 1, 1), 
('2024-09-17', 'AM', '06:45:00', '11:45:00', 'Present', 1, 1), 
('2024-09-18', 'AM', '06:45:00', '11:45:00', 'Present', 1, 1), 
('2024-09-19', 'AM', '06:45:00', '11:45:00', 'Present', 1, 1), 
('2024-09-20', 'AM', '06:45:00', '11:45:00', 'Present', 1, 1), 
('2024-09-21', 'AM', '06:45:00', '11:45:00', 'Absent', 1, 1), 
('2024-09-22', 'AM', '06:45:00', '11:45:00', 'Absent', 1, 1), 
('2024-09-23', 'AM', '06:45:00', '11:45:00', 'Present', 1, 1), 
('2024-09-24', 'AM', '06:45:00', '11:45:00', 'Present', 1, 1), 
('2024-09-25', 'AM', '06:45:00', '11:45:00', 'Present', 1, 1), 
('2024-09-26', 'AM', '06:45:00', '11:45:00', 'Present', 1, 1), 
('2024-09-27', 'AM', '06:45:00', '11:45:00', 'Present', 1, 1), 
('2024-09-28', 'AM', '06:45:00', '11:45:00', 'Absent', 1, 1), 
('2024-09-29', 'AM', '06:45:00', '11:45:00', 'Absent', 1, 1), 
('2024-09-30', 'AM', '06:45:00', '11:45:00', 'Present', 1, 1),

('2024-09-01','AM' ,'06:45:00', '11:45:00', 'Absent', 2,2), 
('2024-09-02','AM' ,'06:45:00', '11:45:00', 'Present', 2,2), 
('2024-09-03','AM' ,'06:45:00', '11:45:00', 'Present', 2,2), 
('2024-09-04','AM' ,'06:45:00', '11:45:00', 'Present', 2,2), 
('2024-09-05','AM' ,'06:45:00', '11:45:00', 'Present', 2,2), 
('2024-09-06','AM' ,'06:45:00', '11:45:00', 'Present', 2,2), 
('2024-09-07','AM' ,'06:45:00', '11:45:00', 'Absent', 2,2), 
('2024-09-08','AM' ,'06:45:00', '11:45:00', 'Absent', 2,2), 
('2024-09-09','AM' ,'06:45:00', '11:45:00', 'Present', 2,2), 
('2024-09-10','AM' ,'06:45:00', '11:45:00', 'Present', 2,2), 
('2024-09-11','AM' ,'06:45:00', '11:45:00', 'Present', 2,2), 
('2024-09-12','AM' ,'06:45:00', '11:45:00', 'Present', 2,2), 
('2024-09-13','AM' ,'06:45:00', '11:45:00', 'Present', 2,2), 
('2024-09-14','AM' ,'06:45:00', '11:45:00', 'Absent', 2,2), 
('2024-09-15','AM' ,'06:45:00', '11:45:00', 'Absent', 2,2), 
('2024-09-16','AM' ,'06:45:00', '11:45:00', 'Present', 2,2), 
('2024-09-17','AM' ,'06:45:00', '11:45:00', 'Present', 2,2), 
('2024-09-18','AM' ,'06:45:00', '11:45:00', 'Present', 2,2), 
('2024-09-19','AM' ,'06:45:00', '11:45:00', 'Present', 2,2), 
('2024-09-20','AM' ,'06:45:00', '11:45:00', 'Present', 2,2), 
('2024-09-21','AM' ,'06:45:00', '11:45:00', 'Absent', 2,2), 
('2024-09-22','AM' ,'06:45:00', '11:45:00', 'Absent', 2,2), 
('2024-09-23','AM' ,'06:45:00', '11:45:00', 'Present', 2,2), 
('2024-09-24','AM' ,'06:45:00', '11:45:00', 'Present', 2,2), 
('2024-09-25','AM' ,'06:45:00', '11:45:00', 'Present', 2,2), 
('2024-09-26','AM' ,'06:45:00', '11:45:00', 'Present', 2,2), 
('2024-09-27','AM' ,'06:45:00', '11:45:00', 'Present', 2,2), 
('2024-09-28','AM' ,'06:45:00', '11:45:00', 'Absent', 2,2), 
('2024-09-29','AM' ,'06:45:00', '11:45:00', 'Absent', 2,2), 
('2024-09-30','AM' ,'06:45:00', '11:45:00', 'Present', 2,2), 

('2024-09-01','AM' ,'06:15:00', '11:15:00', 'Absent', 3,2), 
('2024-09-02','AM' ,'06:15:00', '11:15:00', 'Present', 3,2), 
('2024-09-03','AM' ,'06:15:00', '11:15:00', 'Present', 3,2), 
('2024-09-04','AM' ,'06:15:00', '11:15:00', 'Present', 3,2), 
('2024-09-05','AM' ,'06:15:00', '11:15:00', 'Present', 3,2), 
('2024-09-06','AM' ,'06:15:00', '11:15:00', 'Present', 3,2), 
('2024-09-07','AM' ,'06:15:00', '11:15:00', 'Absent', 3,2), 
('2024-09-08','AM' ,'06:15:00', '11:15:00', 'Absent', 3,2), 
('2024-09-09','AM' ,'06:15:00', '11:15:00', 'Present', 3,2), 
('2024-09-10','AM' ,'06:15:00', '11:15:00', 'Present', 3,2), 
('2024-09-11','AM' ,'06:15:00', '11:15:00', 'Present', 3,2), 
('2024-09-12','AM' ,'06:15:00', '11:15:00', 'Present', 3,2), 
('2024-09-13','AM' ,'06:15:00', '11:15:00', 'Present', 3,2), 
('2024-09-14','AM' ,'06:15:00', '11:15:00', 'Absent', 3,2), 
('2024-09-15','AM' ,'06:15:00', '11:15:00', 'Absent', 3,2), 
('2024-09-16','AM' ,'06:15:00', '11:15:00', 'Present', 3,2), 
('2024-09-17','AM' ,'06:15:00', '11:15:00', 'Present', 3,2), 
('2024-09-18','AM' ,'06:15:00', '11:15:00', 'Present', 3,2), 
('2024-09-19','AM' ,'06:15:00', '11:15:00', 'Present', 3,2), 
('2024-09-20','AM' ,'06:15:00', '11:15:00', 'Present', 3,2), 
('2024-09-21','AM' ,'06:15:00', '11:15:00', 'Absent', 3,2), 
('2024-09-22','AM' ,'06:15:00', '11:15:00', 'Absent', 3,2), 
('2024-09-23','AM' ,'06:15:00', '11:15:00', 'Present', 3,2), 
('2024-09-24','AM' ,'06:15:00', '11:15:00', 'Present', 3,2), 
('2024-09-25','AM' ,'06:15:00', '11:15:00', 'Present', 3,2), 
('2024-09-26','AM' ,'06:15:00', '11:15:00', 'Present', 3,2), 
('2024-09-27','AM' ,'06:15:00', '11:15:00', 'Present', 3,2), 
('2024-09-28','AM' ,'06:15:00', '11:15:00', 'Absent', 3,2), 
('2024-09-29','AM' ,'06:15:00', '11:15:00', 'Absent', 3,2), 
('2024-09-30','AM' ,'06:15:00', '11:15:00', 'Present', 3,2), 

('2024-09-01','AM' ,'06:15:00', '11:15:00', 'Absent', 4,3), 
('2024-09-02','AM' ,'06:15:00', '11:15:00', 'Present', 4,3), 
('2024-09-03','AM' ,'06:15:00', '11:15:00', 'Present', 4,3), 
('2024-09-04','AM' ,'06:15:00', '11:15:00', 'Present', 4,3), 
('2024-09-05','AM' ,'06:15:00', '11:15:00', 'Present', 4,3), 
('2024-09-06','AM' ,'06:15:00', '11:15:00', 'Present', 4,3), 
('2024-09-07','AM' ,'06:15:00', '11:15:00', 'Absent', 4,3), 
('2024-09-08','AM' ,'06:15:00', '11:15:00', 'Absent', 4,3), 
('2024-09-09','AM' ,'06:15:00', '11:15:00', 'Present', 4,3), 
('2024-09-10','AM' ,'06:15:00', '11:15:00', 'Present', 4,3), 
('2024-09-11','AM' ,'06:15:00', '11:15:00', 'Present', 4,3), 
('2024-09-12','AM' ,'06:15:00', '11:15:00', 'Present', 4,3), 
('2024-09-13','AM' ,'06:15:00', '11:15:00', 'Present', 4,3), 
('2024-09-14','AM' ,'06:15:00', '11:15:00', 'Absent', 4,3), 
('2024-09-15','AM' ,'06:15:00', '11:15:00', 'Absent', 4,3), 
('2024-09-16','AM' ,'06:15:00', '11:15:00', 'Present', 4,3), 
('2024-09-17','AM' ,'06:15:00', '11:15:00', 'Present', 4,3), 
('2024-09-18','AM' ,'06:15:00', '11:15:00', 'Present', 4,3), 
('2024-09-19','AM' ,'06:15:00', '11:15:00', 'Present', 4,3), 
('2024-09-20','AM' ,'06:15:00', '11:15:00', 'Present', 4,3), 
('2024-09-21','AM' ,'06:15:00', '11:15:00', 'Absent', 4,3), 
('2024-09-22','AM' ,'06:15:00', '11:15:00', 'Absent', 4,3), 
('2024-09-23','AM' ,'06:15:00', '11:15:00', 'Present', 4,3), 
('2024-09-24','AM' ,'06:15:00', '11:15:00', 'Present', 4,3), 
('2024-09-25','AM' ,'06:15:00', '11:15:00', 'Present', 4,3), 
('2024-09-26','AM' ,'06:15:00', '11:15:00', 'Present', 4,3), 
('2024-09-27','AM' ,'06:15:00', '11:15:00', 'Present', 4,3), 
('2024-09-28','AM' ,'06:15:00', '11:15:00', 'Absent', 4,3), 
('2024-09-29','AM' ,'06:15:00', '11:15:00', 'Absent', 4,3), 
('2024-09-30','AM' ,'06:15:00', '11:15:00', 'Present', 4,3), 
 

('2024-09-01', 'AM', '06:45:00', '11:45:00', 'Absent',  5, 4),
('2024-09-02', 'AM', '06:45:00', '11:45:00', 'Present', 5, 4),
('2024-09-03', 'AM', '06:45:00', '11:45:00', 'Present', 5, 4),
('2024-09-04', 'AM', '06:45:00', '11:45:00', 'Present', 5, 4),
('2024-09-05', 'AM', '06:45:00', '11:45:00', 'Present', 5, 4),
('2024-09-06', 'AM', '06:45:00', '11:45:00', 'Present', 5, 4),
('2024-09-07', 'AM', '06:45:00', '11:45:00', 'Absent',  5, 4),
('2024-09-08', 'AM', '06:45:00', '11:45:00', 'Absent',  5, 4),
('2024-09-09', 'AM', '06:45:00', '11:45:00', 'Present', 5, 4),
('2024-09-10', 'AM', '06:45:00', '11:45:00', 'Present', 5, 4),
('2024-09-11', 'AM', '06:45:00', '11:45:00', 'Present', 5, 4),
('2024-09-12', 'AM', '06:45:00', '11:45:00', 'Present', 5, 4),
('2024-09-13', 'AM', '06:45:00', '11:45:00', 'Present', 5, 4),
('2024-09-14', 'AM', '06:45:00', '11:45:00', 'Absent',  5, 4),
('2024-09-15', 'AM', '06:45:00', '11:45:00', 'Absent',  5, 4),
('2024-09-16', 'AM', '06:45:00', '11:45:00', 'Present', 5, 4),
('2024-09-17', 'AM', '06:45:00', '11:45:00', 'Present', 5, 4),
('2024-09-18', 'AM', '06:45:00', '11:45:00', 'Present', 5, 4),
('2024-09-19', 'AM', '06:45:00', '11:45:00', 'Present', 5, 4),
('2024-09-20', 'AM', '06:45:00', '11:45:00', 'Present', 5, 4),
('2024-09-21', 'AM', '06:45:00', '11:45:00', 'Absent',  5, 4),
('2024-09-22', 'AM', '06:45:00', '11:45:00', 'Absent',  5, 4),
('2024-09-23', 'AM', '06:45:00', '11:45:00', 'Present', 5, 4),
('2024-09-24', 'AM', '06:45:00', '11:45:00', 'Present', 5, 4),
('2024-09-25', 'AM', '06:45:00', '11:45:00', 'Present', 5, 4),
('2024-09-26', 'AM', '06:45:00', '11:45:00', 'Present', 5, 4),
('2024-09-27', 'AM', '06:45:00', '11:45:00', 'Present', 5, 4),
('2024-09-28', 'AM', '06:45:00', '11:45:00', 'Absent',  5, 4),
('2024-09-29', 'AM', '06:45:00', '11:45:00', 'Absent',  5, 4),
('2024-09-30', 'AM', '06:45:00', '11:45:00', 'Present', 5, 4),

('2024-09-01', 'AM', '06:45:00', '11:45:00', 'Absent',  6, 5),
('2024-09-02', 'AM', '06:45:00', '11:45:00', 'Present', 6, 5),
('2024-09-03', 'AM', '06:45:00', '11:45:00', 'Present', 6, 5),
('2024-09-04', 'AM', '06:45:00', '11:45:00', 'Present', 6, 5),
('2024-09-05', 'AM', '06:45:00', '11:45:00', 'Present', 6, 5),
('2024-09-06', 'AM', '06:45:00', '11:45:00', 'Present', 6, 5),
('2024-09-07', 'AM', '06:45:00', '11:45:00', 'Absent',  6, 5),
('2024-09-08', 'AM', '06:45:00', '11:45:00', 'Absent',  6, 5),
('2024-09-09', 'AM', '06:45:00', '11:45:00', 'Present', 6, 5),
('2024-09-10', 'AM', '06:45:00', '11:45:00', 'Present', 6, 5),
('2024-09-11', 'AM', '06:45:00', '11:45:00', 'Present', 6, 5),
('2024-09-12', 'AM', '06:45:00', '11:45:00', 'Present', 6, 5),
('2024-09-13', 'AM', '06:45:00', '11:45:00', 'Present', 6, 5),
('2024-09-14', 'AM', '06:45:00', '11:45:00', 'Absent',  6, 5),
('2024-09-15', 'AM', '06:45:00', '11:45:00', 'Absent',  6, 5),
('2024-09-16', 'AM', '06:45:00', '11:45:00', 'Present', 6, 5),
('2024-09-17', 'AM', '06:45:00', '11:45:00', 'Present', 6, 5),
('2024-09-18', 'AM', '06:45:00', '11:45:00', 'Present', 6, 5),
('2024-09-19', 'AM', '06:45:00', '11:45:00', 'Present', 6, 5),
('2024-09-20', 'AM', '06:45:00', '11:45:00', 'Present', 6, 5),
('2024-09-21', 'AM', '06:45:00', '11:45:00', 'Absent',  6, 5),
('2024-09-22', 'AM', '06:45:00', '11:45:00', 'Absent',  6, 5),
('2024-09-23', 'AM', '06:45:00', '11:45:00', 'Present', 6, 5),
('2024-09-24', 'AM', '06:45:00', '11:45:00', 'Present', 6, 5),
('2024-09-25', 'AM', '06:45:00', '11:45:00', 'Present', 6, 5),
('2024-09-26', 'AM', '06:45:00', '11:45:00', 'Present', 6, 5),
('2024-09-27', 'AM', '06:45:00', '11:45:00', 'Present', 6, 5),
('2024-09-28', 'AM', '06:45:00', '11:45:00', 'Absent',  6, 5),
('2024-09-29', 'AM', '06:45:00', '11:45:00', 'Absent',  6, 5),
('2024-09-30', 'AM', '06:45:00', '11:45:00', 'Present', 6, 5),


('2024-09-01', 'AM', '06:30:00', '11:30:00', 'Absent',  7, 6),
('2024-09-02', 'AM', '06:30:00', '11:30:00', 'Present', 7, 6),
('2024-09-03', 'AM', '06:30:00', '11:30:00', 'Present', 7, 6),
('2024-09-04', 'AM', '06:30:00', '11:30:00', 'Present', 7, 6),
('2024-09-05', 'AM', '06:30:00', '11:30:00', 'Present', 7, 6),
('2024-09-06', 'AM', '06:30:00', '11:30:00', 'Present', 7, 6),
('2024-09-07', 'AM', '06:30:00', '11:30:00', 'Absent',  7, 6),
('2024-09-08', 'AM', '06:30:00', '11:30:00', 'Absent',  7, 6),
('2024-09-09', 'AM', '06:30:00', '11:30:00', 'Present', 7, 6),
('2024-09-10', 'AM', '06:30:00', '11:30:00', 'Present', 7, 6),
('2024-09-11', 'AM', '06:30:00', '11:30:00', 'Present', 7, 6),
('2024-09-12', 'AM', '06:30:00', '11:30:00', 'Present', 7, 6),
('2024-09-13', 'AM', '06:30:00', '11:30:00', 'Present', 7, 6),
('2024-09-14', 'AM', '06:30:00', '11:30:00', 'Absent',  7, 6),
('2024-09-15', 'AM', '06:30:00', '11:30:00', 'Absent',  7, 6),
('2024-09-16', 'AM', '06:30:00', '11:30:00', 'Present', 7, 6),
('2024-09-17', 'AM', '06:30:00', '11:30:00', 'Present', 7, 6),
('2024-09-18', 'AM', '06:30:00', '11:30:00', 'Present', 7, 6),
('2024-09-19', 'AM', '06:30:00', '11:30:00', 'Present', 7, 6),
('2024-09-20', 'AM', '06:30:00', '11:30:00', 'Present', 7, 6),
('2024-09-21', 'AM', '06:30:00', '11:30:00', 'Absent',  7, 6),
('2024-09-22', 'AM', '06:30:00', '11:30:00', 'Absent',  7, 6),
('2024-09-23', 'AM', '06:30:00', '11:30:00', 'Present', 7, 6),
('2024-09-24', 'AM', '06:30:00', '11:30:00', 'Present', 7, 6),
('2024-09-25', 'AM', '06:30:00', '11:30:00', 'Present', 7, 6),
('2024-09-26', 'AM', '06:30:00', '11:30:00', 'Present', 7, 6),
('2024-09-27', 'AM', '06:30:00', '11:30:00', 'Present', 7, 6),
('2024-09-28', 'AM', '06:30:00', '11:30:00', 'Absent',  7, 6),
('2024-09-29', 'AM', '06:30:00', '11:30:00', 'Absent',  7, 6),
('2024-09-30', 'AM', '06:30:00', '11:30:00', 'Present', 7, 6),

('2024-09-01', 'AM', '06:30:00', '11:30:00', 'Absent',  8, 6),
('2024-09-02', 'AM', '06:30:00', '11:30:00', 'Present', 8, 6),
('2024-09-03', 'AM', '06:30:00', '11:30:00', 'Present', 8, 6),
('2024-09-04', 'AM', '06:30:00', '11:30:00', 'Present', 8, 6),
('2024-09-05', 'AM', '06:30:00', '11:30:00', 'Present', 8, 6),
('2024-09-06', 'AM', '06:30:00', '11:30:00', 'Present', 8, 6),
('2024-09-07', 'AM', '06:30:00', '11:30:00', 'Absent',  8, 6),
('2024-09-08', 'AM', '06:30:00', '11:30:00', 'Absent',  8, 6),
('2024-09-09', 'AM', '06:30:00', '11:30:00', 'Present', 8, 6),
('2024-09-10', 'AM', '06:30:00', '11:30:00', 'Present', 8, 6),
('2024-09-11', 'AM', '06:30:00', '11:30:00', 'Present', 8, 6),
('2024-09-12', 'AM', '06:30:00', '11:30:00', 'Present', 8, 6),
('2024-09-13', 'AM', '06:30:00', '11:30:00', 'Present', 8, 6),
('2024-09-14', 'AM', '06:30:00', '11:30:00', 'Absent',  8, 6),
('2024-09-15', 'AM', '06:30:00', '11:30:00', 'Absent',  8, 6),
('2024-09-16', 'AM', '06:30:00', '11:30:00', 'Present', 8, 6),
('2024-09-17', 'AM', '06:30:00', '11:30:00', 'Present', 8, 6),
('2024-09-18', 'AM', '06:30:00', '11:30:00', 'Present', 8, 6),
('2024-09-19', 'AM', '06:30:00', '11:30:00', 'Present', 8, 6),
('2024-09-20', 'AM', '06:30:00', '11:30:00', 'Present', 8, 6),
('2024-09-21', 'AM', '06:30:00', '11:30:00', 'Absent',  8, 6),
('2024-09-22', 'AM', '06:30:00', '11:30:00', 'Absent',  8, 6),
('2024-09-23', 'AM', '06:30:00', '11:30:00', 'Present', 8, 6),
('2024-09-24', 'AM', '06:30:00', '11:30:00', 'Present', 8, 6),
('2024-09-25', 'AM', '06:30:00', '11:30:00', 'Present', 8, 6),
('2024-09-26', 'AM', '06:30:00', '11:30:00', 'Present', 8, 6),
('2024-09-27', 'AM', '06:30:00', '11:30:00', 'Present', 8, 6),
('2024-09-28', 'AM', '06:30:00', '11:30:00', 'Absent',  8, 6),
('2024-09-29', 'AM', '06:30:00', '11:30:00', 'Absent',  8, 6),
('2024-09-30', 'AM', '06:30:00', '11:30:00', 'Present', 8, 6),

('2024-09-01', 'PM', '13:15:00', '16:45:00', 'Absent',  9, 8),
('2024-09-02', 'PM', '13:15:00', '16:45:00', 'Present', 9, 8),
('2024-09-03', 'PM', '13:15:00', '16:45:00', 'Present', 9, 8),
('2024-09-04', 'PM', '13:15:00', '16:45:00', 'Present', 9, 8),
('2024-09-05', 'PM', '13:15:00', '16:45:00', 'Present', 9, 8),
('2024-09-06', 'PM', '13:15:00', '16:45:00', 'Present', 9, 8),
('2024-09-07', 'PM', '13:15:00', '16:45:00', 'Absent',  9, 8),
('2024-09-08', 'PM', '13:15:00', '16:45:00', 'Absent',  9, 8),
('2024-09-09', 'PM', '13:15:00', '16:45:00', 'Present', 9, 8),
('2024-09-10', 'PM', '13:15:00', '16:45:00', 'Present', 9, 8),
('2024-09-11', 'PM', '13:15:00', '16:45:00', 'Present', 9, 8),
('2024-09-12', 'PM', '13:15:00', '16:45:00', 'Present', 9, 8),
('2024-09-13', 'PM', '13:15:00', '16:45:00', 'Present', 9, 8),
('2024-09-14', 'PM', '13:15:00', '16:45:00', 'Absent',  9, 8),
('2024-09-15', 'PM', '13:15:00', '16:45:00', 'Absent',  9, 8),
('2024-09-16', 'PM', '13:15:00', '16:45:00', 'Present', 9, 8),
('2024-09-17', 'PM', '13:15:00', '16:45:00', 'Present', 9, 8),
('2024-09-18', 'PM', '13:15:00', '16:45:00', 'Present', 9, 8),
('2024-09-19', 'PM', '13:15:00', '16:45:00', 'Present', 9, 8),
('2024-09-20', 'PM', '13:15:00', '16:45:00', 'Present', 9, 8),
('2024-09-21', 'PM', '13:15:00', '16:45:00', 'Absent',  9, 8),
('2024-09-22', 'PM', '13:15:00', '16:45:00', 'Absent',  9, 8),
('2024-09-23', 'PM', '13:15:00', '16:45:00', 'Present', 9, 8),
('2024-09-24', 'PM', '13:15:00', '16:45:00', 'Present', 9, 8),
('2024-09-25', 'PM', '13:15:00', '16:45:00', 'Present', 9, 8),
('2024-09-26', 'PM', '13:15:00', '16:45:00', 'Present', 9, 8),
('2024-09-27', 'PM', '13:15:00', '16:45:00', 'Present', 9, 8),
('2024-09-28', 'PM', '13:15:00', '16:45:00', 'Absent',  9, 8),
('2024-09-29', 'PM', '13:15:00', '16:45:00', 'Absent',  9, 8),
('2024-09-30', 'PM', '13:15:00', '16:45:00', 'Present', 9, 8),

('2024-09-01', 'PM', '13:15:00', '16:45:00', 'Absent',  10, 7),
('2024-09-02', 'PM', '13:15:00', '16:45:00', 'Present', 10, 7),
('2024-09-03', 'PM', '13:15:00', '16:45:00', 'Present', 10, 7),
('2024-09-04', 'PM', '13:15:00', '16:45:00', 'Present', 10, 7),
('2024-09-05', 'PM', '13:15:00', '16:45:00', 'Present', 10, 7),
('2024-09-06', 'PM', '13:15:00', '16:45:00', 'Present', 10, 7),
('2024-09-07', 'PM', '13:15:00', '16:45:00', 'Absent',  10, 7),
('2024-09-08', 'PM', '13:15:00', '16:45:00', 'Absent',  10, 7),
('2024-09-09', 'PM', '13:15:00', '16:45:00', 'Present', 10, 7),
('2024-09-10', 'PM', '13:15:00', '16:45:00', 'Present', 10, 7),
('2024-09-11', 'PM', '13:15:00', '16:45:00', 'Present', 10, 7),
('2024-09-12', 'PM', '13:15:00', '16:45:00', 'Present', 10, 7),
('2024-09-13', 'PM', '13:15:00', '16:45:00', 'Present', 10, 7),
('2024-09-14', 'PM', '13:15:00', '16:45:00', 'Absent',  10, 7),
('2024-09-15', 'PM', '13:15:00', '16:45:00', 'Absent',  10, 7),
('2024-09-16', 'PM', '13:15:00', '16:45:00', 'Present', 10, 7),
('2024-09-17', 'PM', '13:15:00', '16:45:00', 'Present', 10, 7),
('2024-09-18', 'PM', '13:15:00', '16:45:00', 'Present', 10, 7),
('2024-09-19', 'PM', '13:15:00', '16:45:00', 'Present', 10, 7),
('2024-09-20', 'PM', '13:15:00', '16:45:00', 'Present', 10, 7),
('2024-09-21', 'PM', '13:15:00', '16:45:00', 'Absent',  10, 7),
('2024-09-22', 'PM', '13:15:00', '16:45:00', 'Absent',  10, 7),
('2024-09-23', 'PM', '13:15:00', '16:45:00', 'Present', 10, 7),
('2024-09-24', 'PM', '13:15:00', '16:45:00', 'Present', 10, 7),
('2024-09-25', 'PM', '13:15:00', '16:45:00', 'Present', 10, 7),
('2024-09-26', 'PM', '13:15:00', '16:45:00', 'Present', 10, 7),
('2024-09-27', 'PM', '13:15:00', '16:45:00', 'Present', 10, 7),
('2024-09-28', 'PM', '13:15:00', '16:45:00', 'Absent',  10, 7),
('2024-09-29', 'PM', '13:15:00', '16:45:00', 'Absent',  10, 7),
('2024-09-30', 'PM', '13:15:00', '16:45:00', 'Present', 10, 7),


('2024-09-01', 'PM', '13:15:00', '16:45:00', 'Absent', 11, 8),
('2024-09-02', 'PM', '13:15:00', '16:45:00', 'Present', 11, 8),
('2024-09-03', 'PM', '13:15:00', '16:45:00', 'Present', 11, 8),
('2024-09-04', 'PM', '13:15:00', '16:45:00', 'Present', 11, 8),
('2024-09-05', 'PM', '13:15:00', '16:45:00', 'Present', 11, 8),
('2024-09-06', 'PM', '13:15:00', '16:45:00', 'Present', 11, 8),
('2024-09-07', 'PM', '13:15:00', '16:45:00', 'Absent', 11, 8),
('2024-09-08', 'PM', '13:15:00', '16:45:00', 'Absent', 11, 8),
('2024-09-09', 'PM', '13:15:00', '16:45:00', 'Present', 11, 8),
('2024-09-10', 'PM', '13:15:00', '16:45:00', 'Present', 11, 8),
('2024-09-11', 'PM', '13:15:00', '16:45:00', 'Present', 11, 8),
('2024-09-12', 'PM', '13:15:00', '16:45:00', 'Present', 11, 8),
('2024-09-13', 'PM', '13:15:00', '16:45:00', 'Present', 11, 8),
('2024-09-14', 'PM', '13:15:00', '16:45:00', 'Absent', 11, 8),
('2024-09-15', 'PM', '13:15:00', '16:45:00', 'Absent', 11, 8),
('2024-09-16', 'PM', '13:15:00', '16:45:00', 'Present', 11, 8),
('2024-09-17', 'PM', '13:15:00', '16:45:00', 'Present', 11, 8),
('2024-09-18', 'PM', '13:15:00', '16:45:00', 'Present', 11, 8),
('2024-09-19', 'PM', '13:15:00', '16:45:00', 'Present', 11, 8),
('2024-09-20', 'PM', '13:15:00', '16:45:00', 'Present', 11, 8),
('2024-09-21', 'PM', '13:15:00', '16:45:00', 'Absent', 11, 8),
('2024-09-22', 'PM', '13:15:00', '16:45:00', 'Absent', 11, 8),
('2024-09-23', 'PM', '13:15:00', '16:45:00', 'Present', 11, 8),
('2024-09-24', 'PM', '13:15:00', '16:45:00', 'Present', 11, 8),
('2024-09-25', 'PM', '13:15:00', '16:45:00', 'Present', 11, 8),
('2024-09-26', 'PM', '13:15:00', '16:45:00', 'Present', 11, 8),
('2024-09-27', 'PM', '13:15:00', '16:45:00', 'Present', 11, 8),
('2024-09-28', 'PM', '13:15:00', '16:45:00', 'Absent', 11, 8),
('2024-09-29', 'PM', '13:15:00', '16:45:00', 'Absent', 11, 8),
('2024-09-30', 'PM', '13:15:00', '16:45:00', 'Present', 11, 8);


INSERT INTO Attendance (AttendanceDate, TimePeriod, PickEstimate, DropEstimate, Status,StudentID, ParentID) VALUES 
('2024-09-01', 'PM', '14:00:00', '17:30:00', 'Absent', 12, 9),
('2024-09-02', 'PM', '14:00:00', '17:30:00', 'Present', 12, 9),
('2024-09-03', 'PM', '14:00:00', '17:30:00', 'Present', 12, 9),
('2024-09-04', 'PM', '14:00:00', '17:30:00', 'Present', 12, 9),
('2024-09-05', 'PM', '14:00:00', '17:30:00', 'Present', 12, 9),
('2024-09-06', 'PM', '14:00:00', '17:30:00', 'Present', 12, 9),
('2024-09-07', 'PM', '14:00:00', '17:30:00', 'Absent', 12, 9),
('2024-09-08', 'PM', '14:00:00', '17:30:00', 'Absent', 12, 9),
('2024-09-09', 'PM', '14:00:00', '17:30:00', 'Present', 12, 9),
('2024-09-10', 'PM', '14:00:00', '17:30:00', 'Present', 12, 9),
('2024-09-11', 'PM', '14:00:00', '17:30:00', 'Present', 12, 9),
('2024-09-12', 'PM', '14:00:00', '17:30:00', 'Present', 12, 9),
('2024-09-13', 'PM', '14:00:00', '17:30:00', 'Present', 12, 9),
('2024-09-14', 'PM', '14:00:00', '17:30:00', 'Absent', 12, 9),
('2024-09-15', 'PM', '14:00:00', '17:30:00', 'Absent', 12, 9),
('2024-09-16', 'PM', '14:00:00', '17:30:00', 'Present', 12, 9),
('2024-09-17', 'PM', '14:00:00', '17:30:00', 'Present', 12, 9),
('2024-09-18', 'PM', '14:00:00', '17:30:00', 'Present', 12, 9),
('2024-09-19', 'PM', '14:00:00', '17:30:00', 'Present', 12, 9),
('2024-09-20', 'PM', '14:00:00', '17:30:00', 'Present', 12, 9),
('2024-09-21', 'PM', '14:00:00', '17:30:00', 'Absent', 12, 9),
('2024-09-22', 'PM', '14:00:00', '17:30:00', 'Absent', 12, 9),
('2024-09-23', 'PM', '14:00:00', '17:30:00', 'Present', 12, 9),
('2024-09-24', 'PM', '14:00:00', '17:30:00', 'Present', 12, 9),
('2024-09-25', 'PM', '14:00:00', '17:30:00', 'Present', 12, 9),
('2024-09-26', 'PM', '14:00:00', '17:30:00', 'Present', 12, 9),
('2024-09-27', 'PM', '14:00:00', '17:30:00', 'Present', 12, 9),
('2024-09-28', 'PM', '14:00:00', '17:30:00', 'Absent', 12, 9),
('2024-09-29', 'PM', '14:00:00', '17:30:00', 'Absent', 12, 9),
('2024-09-30', 'PM', '14:00:00', '17:30:00', 'Present', 12, 9),

('2024-09-01', 'PM', '14:00:00', '17:30:00', 'Absent', 13, 10),
('2024-09-02', 'PM', '14:00:00', '17:30:00', 'Present', 13, 10),
('2024-09-03', 'PM', '14:00:00', '17:30:00', 'Present', 13, 10),
('2024-09-04', 'PM', '14:00:00', '17:30:00', 'Present', 13, 10),
('2024-09-05', 'PM', '14:00:00', '17:30:00', 'Present', 13, 10),
('2024-09-06', 'PM', '14:00:00', '17:30:00', 'Present', 13, 10),
('2024-09-07', 'PM', '14:00:00', '17:30:00', 'Absent', 13, 10),
('2024-09-08', 'PM', '14:00:00', '17:30:00', 'Absent', 13, 10),
('2024-09-09', 'PM', '14:00:00', '17:30:00', 'Present', 13, 10),
('2024-09-10', 'PM', '14:00:00', '17:30:00', 'Present', 13, 10),
('2024-09-11', 'PM', '14:00:00', '17:30:00', 'Present', 13, 10),
('2024-09-12', 'PM', '14:00:00', '17:30:00', 'Present', 13, 10),
('2024-09-13', 'PM', '14:00:00', '17:30:00', 'Present', 13, 10),
('2024-09-14', 'PM', '14:00:00', '17:30:00', 'Absent', 13, 10),
('2024-09-15', 'PM', '14:00:00', '17:30:00', 'Absent', 13, 10),
('2024-09-16', 'PM', '14:00:00', '17:30:00', 'Present', 13, 10),
('2024-09-17', 'PM', '14:00:00', '17:30:00', 'Present', 13, 10),
('2024-09-18', 'PM', '14:00:00', '17:30:00', 'Present', 13, 10),
('2024-09-19', 'PM', '14:00:00', '17:30:00', 'Present', 13, 10),
('2024-09-20', 'PM', '14:00:00', '17:30:00', 'Present', 13, 10),
('2024-09-21', 'PM', '14:00:00', '17:30:00', 'Absent', 13, 10),
('2024-09-22', 'PM', '14:00:00', '17:30:00', 'Absent', 13, 10),
('2024-09-23', 'PM', '14:00:00', '17:30:00', 'Present', 13, 10),
('2024-09-24', 'PM', '14:00:00', '17:30:00', 'Present', 13, 10),
('2024-09-25', 'PM', '14:00:00', '17:30:00', 'Present', 13, 10),
('2024-09-26', 'PM', '14:00:00', '17:30:00', 'Present', 13, 10),
('2024-09-27', 'PM', '14:00:00', '17:30:00', 'Present', 13, 10),
('2024-09-28', 'PM', '14:00:00', '17:30:00', 'Absent', 13, 10),
('2024-09-29', 'PM', '14:00:00', '17:30:00', 'Absent', 13, 10),
('2024-09-30', 'PM', '14:00:00', '17:30:00', 'Present', 13, 10),

('2024-09-01', 'AM', '06:15:00', '11:15:00', 'Absent', 14, 11),
('2024-09-02', 'AM', '06:15:00', '11:15:00', 'Present', 14, 11),
('2024-09-03', 'AM', '06:15:00', '11:15:00', 'Present', 14, 11),
('2024-09-04', 'AM', '06:15:00', '11:15:00', 'Present', 14, 11),
('2024-09-05', 'AM', '06:15:00', '11:15:00', 'Present', 14, 11),
('2024-09-06', 'AM', '06:15:00', '11:15:00', 'Present', 14, 11),
('2024-09-07', 'AM', '06:15:00', '11:15:00', 'Absent', 14, 11),
('2024-09-08', 'AM', '06:15:00', '11:15:00', 'Absent', 14, 11),
('2024-09-09', 'AM', '06:15:00', '11:15:00', 'Present', 14, 11),
('2024-09-10', 'AM', '06:15:00', '11:15:00', 'Present', 14, 11),
('2024-09-11', 'AM', '06:15:00', '11:15:00', 'Present', 14, 11),
('2024-09-12', 'AM', '06:15:00', '11:15:00', 'Present', 14, 11),
('2024-09-13', 'AM', '06:15:00', '11:15:00', 'Present', 14, 11),
('2024-09-14', 'AM', '06:15:00', '11:15:00', 'Absent', 14, 11),
('2024-09-15', 'AM', '06:15:00', '11:15:00', 'Absent', 14, 11),
('2024-09-16', 'AM', '06:15:00', '11:15:00', 'Present', 14, 11),
('2024-09-17', 'AM', '06:15:00', '11:15:00', 'Present', 14, 11),
('2024-09-18', 'AM', '06:15:00', '11:15:00', 'Present', 14, 11),
('2024-09-19', 'AM', '06:15:00', '11:15:00', 'Present', 14, 11),
('2024-09-20', 'AM', '06:15:00', '11:15:00', 'Present', 14, 11),
('2024-09-21', 'AM', '06:15:00', '11:15:00', 'Absent', 14, 11),
('2024-09-22', 'AM', '06:15:00', '11:15:00', 'Absent', 14, 11),
('2024-09-23', 'AM', '06:15:00', '11:15:00', 'Present', 14, 11),
('2024-09-24', 'AM', '06:15:00', '11:15:00', 'Present', 14, 11),
('2024-09-25', 'AM', '06:15:00', '11:15:00', 'Present', 14, 11),
('2024-09-26', 'AM', '06:15:00', '11:15:00', 'Present', 14, 11),
('2024-09-27', 'AM', '06:15:00', '11:15:00', 'Present', 14, 11),
('2024-09-28', 'AM', '06:15:00', '11:15:00', 'Absent', 14, 11),
('2024-09-29', 'AM', '06:15:00', '11:15:00', 'Absent', 14, 11),
('2024-09-30', 'AM', '06:15:00', '11:15:00', 'Present', 14, 11),

('2024-09-01', 'PM', '13:15:00', '16:45:00', 'Absent', 15, 12),
('2024-09-02', 'PM', '13:15:00', '16:45:00', 'Present', 15, 12),
('2024-09-03', 'PM', '13:15:00', '16:45:00', 'Present', 15, 12),
('2024-09-04', 'PM', '13:15:00', '16:45:00', 'Present', 15, 12),
('2024-09-05', 'PM', '13:15:00', '16:45:00', 'Present', 15, 12),
('2024-09-06', 'PM', '13:15:00', '16:45:00', 'Present', 15, 12),
('2024-09-07', 'PM', '13:15:00', '16:45:00', 'Absent', 15, 12),
('2024-09-08', 'PM', '13:15:00', '16:45:00', 'Absent', 15, 12),
('2024-09-09', 'PM', '13:15:00', '16:45:00', 'Present', 15, 12),
('2024-09-10', 'PM', '13:15:00', '16:45:00', 'Present', 15, 12),
('2024-09-11', 'PM', '13:15:00', '16:45:00', 'Present', 15, 12),
('2024-09-12', 'PM', '13:15:00', '16:45:00', 'Present', 15, 12),
('2024-09-13', 'PM', '13:15:00', '16:45:00', 'Present', 15, 12),
('2024-09-14', 'PM', '13:15:00', '16:45:00', 'Absent', 15, 12),
('2024-09-15', 'PM', '13:15:00', '16:45:00', 'Absent', 15, 12),
('2024-09-16', 'PM', '13:15:00', '16:45:00', 'Present', 15, 12),
('2024-09-17', 'PM', '13:15:00', '16:45:00', 'Present', 15, 12),
('2024-09-18', 'PM', '13:15:00', '16:45:00', 'Present', 15, 12),
('2024-09-19', 'PM', '13:15:00', '16:45:00', 'Present', 15, 12),
('2024-09-20', 'PM', '13:15:00', '16:45:00', 'Present', 15, 12),
('2024-09-21', 'PM', '13:15:00', '16:45:00', 'Absent', 15, 12),
('2024-09-22', 'PM', '13:15:00', '16:45:00', 'Absent', 15, 12),
('2024-09-23', 'PM', '13:15:00', '16:45:00', 'Present', 15, 12),
('2024-09-24', 'PM', '13:15:00', '16:45:00', 'Present', 15, 12),
('2024-09-25', 'PM', '13:15:00', '16:45:00', 'Present', 15, 12),
('2024-09-26', 'PM', '13:15:00', '16:45:00', 'Present', 15, 12),
('2024-09-27', 'PM', '13:15:00', '16:45:00', 'Present', 15, 12),
('2024-09-28', 'PM', '13:15:00', '16:45:00', 'Absent', 15, 12),
('2024-09-29', 'PM', '13:15:00', '16:45:00', 'Absent', 15, 12),
('2024-09-30', 'PM', '13:15:00', '16:45:00', 'Present', 15, 12),

('2024-09-01', 'PM', '13:30:00', '17:00:00', 'Absent', 16, 13),
('2024-09-02', 'PM', '13:30:00', '17:00:00', 'Present', 16, 13),
('2024-09-03', 'PM', '13:30:00', '17:00:00', 'Present', 16, 13),
('2024-09-04', 'PM', '13:30:00', '17:00:00', 'Present', 16, 13),
('2024-09-05', 'PM', '13:30:00', '17:00:00', 'Present', 16, 13),
('2024-09-06', 'PM', '13:30:00', '17:00:00', 'Present', 16, 13),
('2024-09-07', 'PM', '13:30:00', '17:00:00', 'Absent', 16, 13),
('2024-09-08', 'PM', '13:30:00', '17:00:00', 'Absent', 16, 13),
('2024-09-09', 'PM', '13:30:00', '17:00:00', 'Present', 16, 13),
('2024-09-10', 'PM', '13:30:00', '17:00:00', 'Present', 16, 13),
('2024-09-11', 'PM', '13:30:00', '17:00:00', 'Present', 16, 13),
('2024-09-12', 'PM', '13:30:00', '17:00:00', 'Present', 16, 13),
('2024-09-13', 'PM', '13:30:00', '17:00:00', 'Present', 16, 13),
('2024-09-14', 'PM', '13:30:00', '17:00:00', 'Absent', 16, 13),
('2024-09-15', 'PM', '13:30:00', '17:00:00', 'Absent', 16, 13),
('2024-09-16', 'PM', '13:30:00', '17:00:00', 'Present', 16, 13),
('2024-09-17', 'PM', '13:30:00', '17:00:00', 'Present', 16, 13),
('2024-09-18', 'PM', '13:30:00', '17:00:00', 'Present', 16, 13),
('2024-09-19', 'PM', '13:30:00', '17:00:00', 'Present', 16, 13),
('2024-09-20', 'PM', '13:30:00', '17:00:00', 'Present', 16, 13),
('2024-09-21', 'PM', '13:30:00', '17:00:00', 'Absent', 16, 13),
('2024-09-22', 'PM', '13:30:00', '17:00:00', 'Absent', 16, 13),
('2024-09-23', 'PM', '13:30:00', '17:00:00', 'Present', 16, 13),
('2024-09-24', 'PM', '13:30:00', '17:00:00', 'Present', 16, 13),
('2024-09-25', 'PM', '13:30:00', '17:00:00', 'Present', 16, 13),
('2024-09-26', 'PM', '13:30:00', '17:00:00', 'Present', 16, 13),
('2024-09-27', 'PM', '13:30:00', '17:00:00', 'Present', 16, 13),
('2024-09-28', 'PM', '13:30:00', '17:00:00', 'Absent', 16, 13),
('2024-09-29', 'PM', '13:30:00', '17:00:00', 'Absent', 16, 13),
('2024-09-30', 'PM', '13:30:00', '17:00:00', 'Present', 16, 13),

('2024-09-01', 'PM', '13:45:00', '17:15:00', 'Absent', 17, 14),
('2024-09-02', 'PM', '13:45:00', '17:15:00', 'Present', 17, 14),
('2024-09-03', 'PM', '13:45:00', '17:15:00', 'Present', 17, 14),
('2024-09-04', 'PM', '13:45:00', '17:15:00', 'Present', 17, 14),
('2024-09-05', 'PM', '13:45:00', '17:15:00', 'Present', 17, 14),
('2024-09-06', 'PM', '13:45:00', '17:15:00', 'Present', 17, 14),
('2024-09-07', 'PM', '13:45:00', '17:15:00', 'Absent', 17, 14),
('2024-09-08', 'PM', '13:45:00', '17:15:00', 'Absent', 17, 14),
('2024-09-09', 'PM', '13:45:00', '17:15:00', 'Present', 17, 14),
('2024-09-10', 'PM', '13:45:00', '17:15:00', 'Present', 17, 14),
('2024-09-11', 'PM', '13:45:00', '17:15:00', 'Present', 17, 14),
('2024-09-12', 'PM', '13:45:00', '17:15:00', 'Present', 17, 14),
('2024-09-13', 'PM', '13:45:00', '17:15:00', 'Present', 17, 14),
('2024-09-14', 'PM', '13:45:00', '17:15:00', 'Absent', 17, 14),
('2024-09-15', 'PM', '13:45:00', '17:15:00', 'Absent', 17, 14),
('2024-09-16', 'PM', '13:45:00', '17:15:00', 'Present', 17, 14),
('2024-09-17', 'PM', '13:45:00', '17:15:00', 'Present', 17, 14),
('2024-09-18', 'PM', '13:45:00', '17:15:00', 'Present', 17, 14),
('2024-09-19', 'PM', '13:45:00', '17:15:00', 'Present', 17, 14),
('2024-09-20', 'PM', '13:45:00', '17:15:00', 'Present', 17, 14),
('2024-09-21', 'PM', '13:45:00', '17:15:00', 'Absent', 17, 14),
('2024-09-22', 'PM', '13:45:00', '17:15:00', 'Absent', 17, 14),
('2024-09-23', 'PM', '13:45:00', '17:15:00', 'Present', 17, 14),
('2024-09-24', 'PM', '13:45:00', '17:15:00', 'Present', 17, 14),
('2024-09-25', 'PM', '13:45:00', '17:15:00', 'Present', 17, 14),
('2024-09-26', 'PM', '13:45:00', '17:15:00', 'Present', 17, 14),
('2024-09-27', 'PM', '13:45:00', '17:15:00', 'Present', 17, 14),
('2024-09-28', 'PM', '13:45:00', '17:15:00', 'Absent', 17, 14),
('2024-09-29', 'PM', '13:45:00', '17:15:00', 'Absent', 17, 14),
('2024-09-30', 'PM', '13:45:00', '17:15:00', 'Present', 17, 14),


('2024-09-01', 'PM', '13:45:00', '17:15:00', 'Absent', 18, 14),
('2024-09-02', 'PM', '13:45:00', '17:15:00', 'Present', 18, 14),
('2024-09-03', 'PM', '13:45:00', '17:15:00', 'Present', 18, 14),
('2024-09-04', 'PM', '13:45:00', '17:15:00', 'Present', 18, 14),
('2024-09-05', 'PM', '13:45:00', '17:15:00', 'Present', 18, 14),
('2024-09-06', 'PM', '13:45:00', '17:15:00', 'Present', 18, 14),
('2024-09-07', 'PM', '13:45:00', '17:15:00', 'Absent', 18, 14),
('2024-09-08', 'PM', '13:45:00', '17:15:00', 'Absent', 18, 14),
('2024-09-09', 'PM', '13:45:00', '17:15:00', 'Present', 18, 14),
('2024-09-10', 'PM', '13:45:00', '17:15:00', 'Present', 18, 14),
('2024-09-11', 'PM', '13:45:00', '17:15:00', 'Present', 18, 14),
('2024-09-12', 'PM', '13:45:00', '17:15:00', 'Present', 18, 14),
('2024-09-13', 'PM', '13:45:00', '17:15:00', 'Present', 18, 14),
('2024-09-14', 'PM', '13:45:00', '17:15:00', 'Absent', 18, 14),
('2024-09-15', 'PM', '13:45:00', '17:15:00', 'Absent', 18, 14),
('2024-09-16', 'PM', '13:45:00', '17:15:00', 'Present', 18, 14),
('2024-09-17', 'PM', '13:45:00', '17:15:00', 'Present', 18, 14),
('2024-09-18', 'PM', '13:45:00', '17:15:00', 'Present', 18, 14),
('2024-09-19', 'PM', '13:45:00', '17:15:00', 'Present', 18, 14),
('2024-09-20', 'PM', '13:45:00', '17:15:00', 'Present', 18, 14),
('2024-09-21', 'PM', '13:45:00', '17:15:00', 'Absent', 18, 14),
('2024-09-22', 'PM', '13:45:00', '17:15:00', 'Absent', 18, 14),
('2024-09-23', 'PM', '13:45:00', '17:15:00', 'Present', 18, 14),
('2024-09-24', 'PM', '13:45:00', '17:15:00', 'Present', 18, 14),
('2024-09-25', 'PM', '13:45:00', '17:15:00', 'Present', 18, 14),
('2024-09-26', 'PM', '13:45:00', '17:15:00', 'Present', 18, 14),
('2024-09-27', 'PM', '13:45:00', '17:15:00', 'Present', 18, 14),
('2024-09-28', 'PM', '13:45:00', '17:15:00', 'Absent', 18, 14),
('2024-09-29', 'PM', '13:45:00', '17:15:00', 'Absent', 18, 14),
('2024-09-30', 'PM', '13:45:00', '17:15:00', 'Present', 18, 14),


('2024-09-01', 'PM', '14:00:00', '17:30:00', 'Absent', 19, 15),
('2024-09-02', 'PM', '14:00:00', '17:30:00', 'Present', 19, 15),
('2024-09-03', 'PM', '14:00:00', '17:30:00', 'Present', 19, 15),
('2024-09-04', 'PM', '14:00:00', '17:30:00', 'Present', 19, 15),
('2024-09-05', 'PM', '14:00:00', '17:30:00', 'Present', 19, 15),
('2024-09-06', 'PM', '14:00:00', '17:30:00', 'Present', 19, 15),
('2024-09-07', 'PM', '14:00:00', '17:30:00', 'Absent', 19, 15),
('2024-09-08', 'PM', '14:00:00', '17:30:00', 'Absent', 19, 15),
('2024-09-09', 'PM', '14:00:00', '17:30:00', 'Present', 19, 15),
('2024-09-10', 'PM', '14:00:00', '17:30:00', 'Present', 19, 15),
('2024-09-11', 'PM', '14:00:00', '17:30:00', 'Present', 19, 15),
('2024-09-12', 'PM', '14:00:00', '17:30:00', 'Present', 19, 15),
('2024-09-13', 'PM', '14:00:00', '17:30:00', 'Present', 19, 15),
('2024-09-14', 'PM', '14:00:00', '17:30:00', 'Absent', 19, 15),
('2024-09-15', 'PM', '14:00:00', '17:30:00', 'Absent', 19, 15),
('2024-09-16', 'PM', '14:00:00', '17:30:00', 'Present', 19, 15),
('2024-09-17', 'PM', '14:00:00', '17:30:00', 'Present', 19, 15),
('2024-09-18', 'PM', '14:00:00', '17:30:00', 'Present', 19, 15),
('2024-09-19', 'PM', '14:00:00', '17:30:00', 'Present', 19, 15),
('2024-09-20', 'PM', '14:00:00', '17:30:00', 'Present', 19, 15),
('2024-09-21', 'PM', '14:00:00', '17:30:00', 'Absent', 19, 15),
('2024-09-22', 'PM', '14:00:00', '17:30:00', 'Absent', 19, 15),
('2024-09-23', 'PM', '14:00:00', '17:30:00', 'Present', 19, 15),
('2024-09-24', 'PM', '14:00:00', '17:30:00', 'Present', 19, 15),
('2024-09-25', 'PM', '14:00:00', '17:30:00', 'Present', 19, 15),
('2024-09-26', 'PM', '14:00:00', '17:30:00', 'Present', 19, 15),
('2024-09-27', 'PM', '14:00:00', '17:30:00', 'Present', 19, 15),
('2024-09-28', 'PM', '14:00:00', '17:30:00', 'Absent', 19, 15),
('2024-09-29', 'PM', '14:00:00', '17:30:00', 'Absent', 19, 15),
('2024-09-30', 'PM', '14:00:00', '17:30:00', 'Present', 19, 15),


('2024-09-01', 'PM', '13:30:00', '17:00:00', 'Absent', 20, 16),
('2024-09-02', 'PM', '13:30:00', '17:00:00', 'Present', 20, 16),
('2024-09-03', 'PM', '13:30:00', '17:00:00', 'Present', 20, 16),
('2024-09-04', 'PM', '13:30:00', '17:00:00', 'Present', 20, 16),
('2024-09-05', 'PM', '13:30:00', '17:00:00', 'Present', 20, 16),
('2024-09-06', 'PM', '13:30:00', '17:00:00', 'Present', 20, 16),
('2024-09-07', 'PM', '13:30:00', '17:00:00', 'Absent', 20, 16),
('2024-09-08', 'PM', '13:30:00', '17:00:00', 'Absent', 20, 16),
('2024-09-09', 'PM', '13:30:00', '17:00:00', 'Present', 20, 16),
('2024-09-10', 'PM', '13:30:00', '17:00:00', 'Present', 20, 16),
('2024-09-11', 'PM', '13:30:00', '17:00:00', 'Present', 20, 16),
('2024-09-12', 'PM', '13:30:00', '17:00:00', 'Present', 20, 16),
('2024-09-13', 'PM', '13:30:00', '17:00:00', 'Present', 20, 16),
('2024-09-14', 'PM', '13:30:00', '17:00:00', 'Absent', 20, 16),
('2024-09-15', 'PM', '13:30:00', '17:00:00', 'Absent', 20, 16),
('2024-09-16', 'PM', '13:30:00', '17:00:00', 'Present', 20, 16),
('2024-09-17', 'PM', '13:30:00', '17:00:00', 'Present', 20, 16),
('2024-09-18', 'PM', '13:30:00', '17:00:00', 'Present', 20, 16),
('2024-09-19', 'PM', '13:30:00', '17:00:00', 'Present', 20, 16),
('2024-09-20', 'PM', '13:30:00', '17:00:00', 'Present', 20, 16),
('2024-09-21', 'PM', '13:30:00', '17:00:00', 'Absent', 20, 16),
('2024-09-22', 'PM', '13:30:00', '17:00:00', 'Absent', 20, 16),
('2024-09-23', 'PM', '13:30:00', '17:00:00', 'Present', 20, 16),
('2024-09-24', 'PM', '13:30:00', '17:00:00', 'Present', 20, 16),
('2024-09-25', 'PM', '13:30:00', '17:00:00', 'Present', 20, 16),
('2024-09-26', 'PM', '13:30:00', '17:00:00', 'Present', 20, 16),
('2024-09-27', 'PM', '13:30:00', '17:00:00', 'Present', 20, 16),
('2024-09-28', 'PM', '13:30:00', '17:00:00', 'Absent', 20, 16),
('2024-09-29', 'PM', '13:30:00', '17:00:00', 'Absent', 20, 16),
('2024-09-30', 'PM', '13:30:00', '17:00:00', 'Present', 20, 16);









