SET ECHO ON

DROP TABLE StudentCourseRecord CASCADE CONSTRAINTS;
DROP TABLE Instructor_Courses CASCADE CONSTRAINTS;
DROP TABLE StudentCredential CASCADE CONSTRAINTS;
DROP TABLE CredentialCourse CASCADE CONSTRAINTS;
DROP TABLE ScheduledCourse CASCADE CONSTRAINTS;
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
   CONSTRAINT student_pk PRIMARY KEY (StudentID),
   CONSTRAINT student_status_ck CHECK (Status IN ('A','AP','S','E')),
   CONSTRAINT student_email_uk UNIQUE (Email)
);

CREATE TABLE Instructor (
   InstructorID NUMBER(10) NOT NULL,
   FirstName VARCHAR2(50) NOT NULL,
   LastName VARCHAR2(50) NOT NULL,
   Address VARCHAR2(100) NOT NULL,
   City VARCHAR2(40) NOT NULL,
   Province CHAR(2) NOT NULL,
   PostalCode VARCHAR(6) NOT NULL,
   PhoneNumber NUMBER(10) NOT NULL,
   Email VARCHAR2(100) NOT NULL,
   CONSTRAINT instructor_pk PRIMARY KEY (InstructorID),
   CONSTRAINT instructor_province_ck CHECK(Province IN ('AB','BC','SK','MB','ON','QC','NB','NS','PE','NL','YT','NT','NU'))
);

CREATE TABLE Course (
   CourseCode VARCHAR(7) NOT NULL,
   preReqCourseCode VARCHAR2(7) NOT NULL,
   Name VARCHAR2(20) NOT NULL,
   NumOfCredits number(1) NOT NULL,
   CONSTRAINT course_pk PRIMARY KEY (CourseCode, SemesterCode),
   CONSTRAINT course_uk UNIQUE (Name),
   CONSTRAINT course_preReqCourseCode_uk FOREIGN KEY (preReqCourseCode) REFERENCES Course (CourseCode)
);

CREATE TABLE ScheduledCourse (
   CRN NUMBER(5) NOT NULL, 
   SemesterCode VARCHAR2(6) NOT NULL,
   CourseCode VARCHAR2(7) NOT NULL,
   SectionCode CHAR(1) NOT NULL,
   CONSTRAINT scheduledCourse_pk PRIMARY KEY (CRN),
   CONSTRAINT scheduledCourse_uk UNIQUE (CourseCode),
   CONSTRAINT course_scheduledCourse_fk FOREIGN KEY (CourseCode) REFERENCES Course (CourseCode)
);
CREATE TABLE CredentialCourse (
   CourseCode VARCHAR2(10) NOT NULL,
   CredentialID VARCHAR2(10) NOT NULL,
   TypeFlag VARCHAR2(20),
   CONSTRAINT credentialCourse_pk PRIMARY KEY (CredentialID, CourseCode),
   CONSTRAINT credentialCourse_fk FOREIGN KEY (CredentialID) REFERENCES Credential(credentialID),
   CONSTRAINT credentialCourse_fk FOREIGN KEY (CourseCode) REFERENCES Course(CourseCode)

);