SET ECHO ON
SPOOL projectpt4.lst

DROP TABLE StudentCourseRecord CASCADE CONSTRAINTS;
DROP TABLE InstructorCourses CASCADE CONSTRAINTS;
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
   CourseCode VARCHAR2(7) NOT NULL,
   preReqCourseCode VARCHAR2(7),
   Name VARCHAR2(20) NOT NULL,
   NumOfCredits NUMBER(1) NOT NULL,
   CONSTRAINT course_pk PRIMARY KEY (CourseCode),
   CONSTRAINT course_uk UNIQUE (Name)
);

ALTER TABLE Course
ADD CONSTRAINT course_prereq_fk --adds in a foreign key to add in an alter table method
    FOREIGN KEY (preReqCourseCode)
    REFERENCES Course (CourseCode);

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
   CourseCode VARCHAR2(7) NOT NULL,
   CredentialID NUMBER(10) NOT NULL,
   TypeFlag VARCHAR2(20)
);

ALTER TABLE CredentialCourse
ADD CONSTRAINT credentialCourse_pk
PRIMARY KEY (CredentialID, CourseCode);

ALTER TABLE CredentialCourse
ADD CONSTRAINT credentialCourse_cred_fk
FOREIGN KEY (CredentialID)
REFERENCES Credential(CredentialID);

ALTER TABLE CredentialCourse
ADD CONSTRAINT credentialCourse_course_fk
FOREIGN KEY (CourseCode)
REFERENCES Course(CourseCode);


CREATE TABLE StudentCredential (
    StudentID NUMBER(10) NOT NULL,
    CredentialID NUMBER(10) NOT NULL,
    StartDate DATE NOT NULL,
    CompletionDate DATE NOT NULL,
    CredentialStatus CHAR(1) NOT NULL,
    GPA NUMBER(3) NOT NULL,
    CONSTRAINT studentCredential_pk PRIMARY KEY (StudentID, CredentialID),
    CONSTRAINT studentCredential_student_fk FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    CONSTRAINT studentCredential_credential_fk FOREIGN KEY (CredentialID) REFERENCES Credential(CredentialID)
);
CREATE TABLE InstructorCourses (
    SemesterCode VARCHAR2(6) NOT NULL,
    InstructorID NUMBER(10) NOT NULL,
    CRN NUMBER(5) NOT NULL,
    CONSTRAINT instructorCourses_pk PRIMARY KEY (SemesterCode, InstructorID, CRN),
    CONSTRAINT instructorCourses_instructor_fk FOREIGN KEY (InstructorID) REFERENCES Instructor (InstructorID),
    CONSTRAINT instructorCourses_crn_fk FOREIGN KEY (CRN) REFERENCES ScheduledCourse (CRN)
);
CREATE TABLE StudentCourseRecord (
    StudentID NUMBER(10) NOT NULL,
    CRN NUMBER(5) NOT NULL,
    SemesterCode VARCHAR2(6) NOT NULL,
    CredentialID NUMBER(10) NOT NULL,
    LetterGrade CHAR(1) NOT NULL,
    CONSTRAINT studentCourseRecord_pk PRIMARY KEY (StudentID, CRN, SemesterCode),
    CONSTRAINT scr_student_fk FOREIGN KEY (StudentID) REFERENCES Student (StudentID),
    CONSTRAINT scr_crn_fk FOREIGN KEY (CRN) REFERENCES ScheduledCourse (CRN),
    CONSTRAINT scr_cred_fk FOREIGN KEY (CredentialID) REFERENCES Credential (CredentialID)
);
SPOOL OFF;