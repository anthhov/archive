-- Работаем в Oracle SQL Developer

alter session set "_ORACLE_SCRIPT"=true;

-- Создадим пользователя developer и дадим ему права (работаем под sys)

-- dropping the user if already exists
declare
    res number;
begin
    select count(1) into res from all_users where upper(username) = upper('developer');
    
    if res <> 0 then
        execute immediate 'drop user developer cascade';
    end if;

end;
/

create user DEVELOPER identified by DEVELOPER;

-- Дадим ему нужные права
grant create session to DEVELOPER;
grant create table to DEVELOPER;
grant unlimited tablespace to DEVELOPER;

-- Подключимся к базе от имени пользователя developer
alter session set CURRENT_SCHEMA = DEVELOPER;

-- Создадим базу с содержимым на двух языках (как студенты разных кафедр сдавали предметы в сессию).
create table FACULTY_RU (
    Faculty_Letter   varchar2(5),
    Faculty_Name  varchar2(200)
);

create table FACULTY_EN (
    Faculty_Letter   varchar2(5),
    Faculty_Name  varchar2(200)
);

create table STUDENT (
    Student_ID   number(10,0),
    Group_code   varchar2(20)
);

create table TEST_RU (
    Test_ID        number(10,0),
    Test_Name   varchar2(200)
);

create table TEST_EN (
    Test_ID        number(10,0),
    Test_Name   varchar2(200)
);

create table STUDENT_TEST (
    Student_ID     number(10,0),
    Test_ID        number(10,0),
    Score          number(3,0)
);

alter table FACULTY_RU
    add constraint PK_Faculty_Ru_Letter primary key (Faculty_Letter);

alter table FACULTY_EN
    add constraint PK_Faculty_En_Letter primary key (Faculty_Letter);

alter table STUDENT
    add constraint PK_Student_ID primary key (Student_ID);

alter table TEST_RU
    add constraint PK_Test_Ru_ID primary key (Test_ID);

alter table TEST_EN
    add constraint PK_Test_En_ID primary key (Test_ID);

alter table STUDENT_TEST
    add constraint FK_Student_ID foreign key (Student_ID) references STUDENT(Student_ID);

-- Заполним базу данными
insert into FACULTY_RU values ('B', 'Прикладной оптики');
insert into FACULTY_RU values ('D', 'Институт международного развития и партнерства');
insert into FACULTY_RU values ('K', 'Инфокоммуникационных технологий');

insert into FACULTY_EN values ('B', 'Applied Optics');
insert into FACULTY_EN values ('D', 'Institute of International Development and Partnership');
insert into FACULTY_EN values ('K', 'Infocommunication Technologies');

insert into STUDENT values (930424, 'B3100');
insert into STUDENT values (950488, 'B3100');
insert into STUDENT values (970774, 'D3110');
insert into STUDENT values (973504, 'D3110');
insert into STUDENT values (948643, 'K3122');
insert into STUDENT values (970489, 'K3122');

insert into TEST_RU values (1, 'Упражнение 1: Упражнение. Архитектура ЭВМ и ОС;Упражнение');
insert into TEST_RU values (2, 'Упражнение 2: Упражнение. Технологии программирования');
insert into TEST_RU values (3, 'Упражнение 3: Упражнение. Сетевые технологии');

insert into TEST_EN values (1, 'Exercise 1: Exercise. Computer architecture and OS');
insert into TEST_EN values (2, 'Exercise 2: Exercise. Programming technologies');
insert into TEST_EN values (3, 'Exercise 3: Exercise. Network technologies');

insert into STUDENT_TEST values (930424, 1, 100);
insert into STUDENT_TEST values (930424, 2, 100);
insert into STUDENT_TEST values (930424, 3, 91);

insert into STUDENT_TEST values (950488, 1, 88);
insert into STUDENT_TEST values (950488, 2, 50);
insert into STUDENT_TEST values (950488, 3, 100);

insert into STUDENT_TEST values (970774, 1, 73);
insert into STUDENT_TEST values (970774, 2, 90);
insert into STUDENT_TEST values (970774, 3, 100);

insert into STUDENT_TEST values (973504, 1, 94);
insert into STUDENT_TEST values (973504, 2, 80);
insert into STUDENT_TEST values (973504, 3, 96);

insert into STUDENT_TEST values (948643, 1, 100);
insert into STUDENT_TEST values (948643, 2, 53);
insert into STUDENT_TEST values (948643, 3, 100);

insert into STUDENT_TEST values (970489, 1, 100);
insert into STUDENT_TEST values (970489, 2, 80);
insert into STUDENT_TEST values (970489, 3, 100);

-- Создадим два пользователя базы:
-- один видит базу на русском языке,
-- второй на английском (пишут одни и те же запросы, а видят разное).
drop user USER_RU cascade;
drop user USER_EN cascade;

create user USER_RU;
grant connect to USER_RU;

create synonym USER_RU.FACULTY for DEVELOPER.FACULTY_RU;
create synonym USER_RU.TEST for DEVELOPER.TEST_RU;

grant select on USER_RU.FACULTY to USER_RU;
grant select on USER_RU.TEST to USER_RU;

create user USER_EN;
grant connect to USER_EN;

create synonym USER_EN.FACULTY for DEVELOPER.FACULTY_EN;
create synonym USER_EN.TEST for DEVELOPER.TEST_EN;

grant select on USER_EN.FACULTY to USER_EN;
grant select on USER_EN.TEST to USER_EN;

alter session set CURRENT_SCHEMA = USER_RU;
select * from USER_RU.FACULTY;
select * from USER_RU.TEST;
alter session set CURRENT_SCHEMA = USER_EN;
select * from USER_EN.FACULTY;
select * from USER_EN.TEST;

alter session set CURRENT_SCHEMA = DEVELOPER;

-- Ограничим пользователей базы ресурсами: не более одного коннекта и не более 30 сек на единичный запрос.
alter session set CURRENT_SCHEMA = DEVELOPER;

drop profile DEF_PROFILE;

create profile DEF_PROFILE 
limit
SESSIONS_PER_USER 1 
CPU_PER_CALL 300;

select * from DBA_PROFILES where PROFILE = 'DEF_PROFILE';

alter user USER_EN profile DEF_PROFILE;
alter user USER_RU profile DEF_PROFILE;
