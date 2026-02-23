SET ECHO ON

DROP TABLE StudentCourseRecord CASCADE CONSTRAINTS;
DROP TABLE Instructor_Courses CASCADE CONSTRAINTS;
DROP TABLE StudentCredential CASCADE CONSTRAINTS;
DROP TABLE CredentialCourse CASCADE CONSTRAINTS;
DROP TABLE ScheduledCourse CASCADE CONSTRAINTS;
DROP TABLE Semester CASCADE CONSTRAINTS;
DROP TABLE Course CASCADE CONSTRAINTS;
DROP TABLE Instructor CASCADE CONSTRAINTS;
DROP TABLE Student CASCADE CONSTRAINTS;
DROP TABLE Credential CASCADE CONSTRAINTS;


-- now create table in reverse order

CREATE TABLE Credential (
    CredentialID NUMBER(10) NOT NULL,
    School VARCHAR2(50) NOT NULL,
    Name VARCHAR2(50) NOT NULL,
    Type CHAR(2) NOT NULL,
    CONSTRAINT credential_pk PRIMARY KEY (CredentialID),
    CONSTRAINT credential_type_ck CHECK (Type IN ('MI','FT','CT','DP','AD','D'))
);



CREATE TABLE Student (
   StudentID NUMBER(10) NOT NULL,
   FirstName VARCHAR2(50) NOT NULL,
   LastName VARCHAR(50) NOT NULL,
   Status VARCHAR2(2) NOT NULL,
   StatusDate Date NOT NULL,
   Phone VARCHAR2(10) NOT NULL,
   Email VARCHAR2(50) NOT NULL,
   constraint student_pk PRIMARY KEY (StudentID),
   constraint student_status_ck CHECK (Status IN ('A','AP','S','E')),
   constraint student_email_uk UNIQUE (Email)
);