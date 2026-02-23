   SET ECHO ON

drop table studentcourserecord cascade constraints;
drop table instructor_courses cascade constraints;
drop table studentcredential cascade constraints;
drop table credentialcourse cascade constraints;
drop table scheduledcourse cascade constraints;
drop table semester cascade constraints;
drop table course cascade constraints;
drop table instructor cascade constraints;
drop table student cascade constraints;
drop table credential cascade constraints;

-- mnow create table in reverse order

create table credential (
   credentialid number(10) not null,
   school       varchar2(50) not null,
   name         varchar2(50) not null,
   type         char(2) not null,
   constraint credential_pk primary key ( credentialid ),
   constraint credential_type_ck
      check ( type in ( 'MI',
                        'FT',
                        'CT',
                        'DP',
                        'AD',
                        'D' ) )
);