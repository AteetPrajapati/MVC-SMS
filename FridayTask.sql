--DROP DATABASE AP351AteetPrajapati
CREATE DATABASE AP351AteetPrajapati
USE AP351AteetPrajapati

CREATE TABLE Country (
	Id INT PRIMARY KEY IDENTITY(1,1),
	name VARCHAR(200) NOT NULL,
)

CREATE TABLE State (
	Id INT PRIMARY KEY IDENTITY(1,1),
	name VARCHAR(200) NOT NULL,
	CountryId INT FOREIGN KEY REFERENCES Country(Id),
)

CREATE TABLE City (
	Id INT PRIMARY KEY IDENTITY(1,1),
	name VARCHAR(200) NOT NULL,
	StateID INT FOREIGN KEY REFERENCES State(Id),
	CountryID INT FOREIGN KEY REFERENCES Country(Id)
)

CREATE TABLE [User] (
	Id INT PRIMARY KEY IDENTITY(1,1),
	Username VARCHAR(200) UNIQUE NOT NULL,
	[Password] VARCHAR(200) NOT NULL,
	FirstName VARCHAR(150) NOT NULL,
    LastName VARCHAR(150) NOT NULL,
	Email VARCHAR(200) UNIQUE
)

INSERT INTO [User] (
Username,
Password,
FirstName,
LastName,
Email
) VALUES ('ateet','123456','test','fork', 'test@gmail.com')

CREATE TABLE Student (
	Id INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(150) NOT NULL,
    LastName VARCHAR(150) NOT NULL,
    Email VARCHAR(200) UNIQUE,
    MobileNo VARCHAR(20) NOT NULL,
    [Password] VARCHAR(12) NOT NULL,
    [Address] VARCHAR(MAX) NOT NULL,
    City INT FOREIGN KEY REFERENCES City(Id) NOT NULL,
    [State] INT FOREIGN KEY REFERENCES State(Id) NOT NULL,
    Country INT FOREIGN KEY REFERENCES Country(Id) NOT NULL
)

INSERT INTO Student (
FirstName,
LastName,
Email,
MobileNo,
Password,
Address,
City,
State,
Country,
Edited,
CreatedBy) VALUES ('Ateet', 'Prajapati', 'ateet@gmail.com', '9328409012','arp67', '142 Akhanad Society Dabjoli Road',1,1,1,0,8)

CREATE VIEW DeletedStudents AS SELECT * FROM Student WHERE 1=-1

CREATE TABLE DeletedStudentsId (
	Id INT PRIMARY KEY IDENTITY(1,1),
	StudentID INT NOT NULL
)


ALTER TABLE DeletedStudentsId
ADD CreatedBy INT FOREIGN KEY REFERENCES [User](Id)

ALTER TABLE Student
ADD Edited BIT DEFAULT 0,

ALTER TABLE Student
ADD CreatedBy INT FOREIGN KEY REFERENCES [User](Id)


SELECT * FROM Country
SELECT * FROM State
SELECT * FROM City
SELECT * FROM Student
SELECT * FROM [User]
SELECT * FROM DeletedStudentsId


GO
CREATE OR ALTER PROCEDURE SP_ON_COUNTRY_DELETE
@id INT
AS
BEGIN 
	DELETE State WHERE CountryId = @id
	DELETE City WHERE CountryId = @id
END

GO
CREATE OR ALTER PROCEDURE SP_ON_STATE_DELETE
@id INT
AS
BEGIN 
	DELETE State WHERE Id = @id
	DELETE City WHERE StateID = @id
END

CREATE TABLE Subjects(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name VARCHAR(200) NOT NULL
)

INSERT INTO Subjects VALUES ('PHP'),('JAVA'),('C#'),('JavaScript'),('.NET'),('jQuery'),('React JS'),('Vue.js'),('Angular'),('Node js'),('ECMAScript 6')

CREATE TABLE Teacher (
	Id INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(150) NOT NULL,
    LastName VARCHAR(150) NOT NULL,
    Email VARCHAR(200) UNIQUE,
	Geneder VARCHAR(100) NOT NULL,
    MobileNo VARCHAR(20) NOT NULL,
    [Address] VARCHAR(MAX) NOT NULL,
    City INT FOREIGN KEY REFERENCES City(Id) NOT NULL,
    [State] INT FOREIGN KEY REFERENCES State(Id) NOT NULL,
    Country INT FOREIGN KEY REFERENCES Country(Id) NOT NULL
)

ALTER TABLE Teacher

ALTER TABLE Teacher
ADD Subjects INT FOREIGN KEY REFERENCES State(Id) NOT NULL

ALTER TABLE Teacher
ADD Pincode INT

CREATE TABLE TeacherSubjects (
	Id INT PRIMARY KEY IDENTITY(1,1),
	TeacherId INT FOREIGN KEY REFERENCES Teacher(Id) NOT NULL,
	SubjectId INT FOREIGN KEY REFERENCES Subjects(Id) NOT NULL
)

CREATE TABLE StudentTeachers (
	Id INT PRIMARY KEY IDENTITY(1,1),
	TeacherId INT FOREIGN KEY REFERENCES Teacher(Id) NOT NULL,
	StudentId INT FOREIGN KEY REFERENCES Student(Id) NOT NULL
)


INSERT INTO Teacher
(FirstName,
LastName,
Email,
Geneder,
MobileNo,
Address,
City,
State,
Country) VALUES ('Neha','Mistri','neha@gmail.com', 'Female', '5478523654', 'Wellington Rajshree Banglows', 3,3,2),
			('Viral','Pansariya','viral@gmail.com', 'Male', '93281889476', 'Rajkot near PANTALOONS', 1,1,1),
		 ('Adesh','Panchal','adesh@gmail.com', 'Male', '7389346487', 'Mahesana chokadi KALOL', 1,1,1)

INSERT INTO TeacherSubjects VALUES (3,1),(3,9),(2,5),(2,4),(2,7),(2,10),(2,11), (1,1),(1,3),(1,6),(1,8)

INSERT INTO StudentTeachers (TeacherId, StudentId) VALUES (1,26),(3,26)

CREATE TABLE StudentTeachersSubjects (
	Id INT PRIMARY KEY IDENTITY(1,1),
	StudentId INT FOREIGN KEY REFERENCES Student(Id) NOT NULL,
	TeacherId INT FOREIGN KEY REFERENCES Teacher(Id) NOT NULL,
	TeacherSubjectsId INT FOREIGN KEY REFERENCES TeacherSubjects(Id) NOT NULL
)

INSERT INTO StudentTeachersSubjects (StudentId, TeacherId, TeacherSubjectsId) VALUES (26,1,1),(26,1,6),(26,3,9)


SELECT * FROM Teacher
SELECT * FROM Student

SELECT * FROM Teacher T 
		JOIN TeacherSubjects TS ON T.Id = TS.TeacherId		
		JOIN Subjects S ON S.Id = TS.SubjectId


SELECT * FROM StudentTeachersSubjects STS
JOIN TeacherSubjects TS ON TS.Id = STS.TeacherSubjectsId
JOIN Teacher T ON T.Id = STS.TeacherId
JOIN Student S ON S.Id = STS.StudentId
JOIN Subjects Sub ON Sub.Id = TS.SubjectId


SELECT * FROM  StudentTeachersSubjects STS
JOIN Teacher T ON T.Id = STS.Id
JOIN Subjects Sub ON Sub.Id = STS.TeacherSubjectsId

GO
CREATE OR ALTER PROCEDURE SP_GET_TeacherWithSubject
AS
BEGIN 
	SELECT * FROM Teacher T 
		JOIN TeacherSubjects TS ON T.Id = TS.TeacherId		
		JOIN Subjects S ON S.Id = TS.SubjectId
END


ALTER TABLE StudentTeachersSubjects
DROP CONSTRAINT FK__StudentTe__Teach__5AEE82B9		