README
----
1. Создадим схему:
```
alter session set "_ORACLE_SCRIPT"=true;
drop user STUDENT_DB cascade;
create user STUDENT_DB identified by STUDENT_DB;
grant create session to STUDENT_DB;
grant unlimited tablespace to STUDENT_DB;
grant create table to STUDENT_DB;
```

2. Нужно работать в STUDENT_DB schema. Для этого в SQL Developer заводим новое подключение к базе от имени STUDENT_DB. Далее нужно создать такую базу:
```
create table FACULTY (
    Faculty_Letter   varchar2(5),
    Faculty_Name_Ru  varchar2(200),
    Faculty_Name_En  varchar2(200)
);

create table STUDENT (
    Student_ID   number(10,0),  
    Group_code   varchar2(20)
);

create table TEST (
    Test_ID        number(10,0),
    Test_Name_Ru   varchar2(200),
    Test_Name_En   varchar2(200)
);

create table STUDENT_TEST (
    Student_ID     number(10,0),
    Test_ID        number(10,0),
    Score          number(3,0)
);

alter table FACULTY
    add constraint PK_Faculty_Letter primary key (Faculty_Letter);

alter table STUDENT
    add constraint PK_Student_ID primary key (Student_ID);

alter table TEST
    add constraint PK_Test_ID primary key (Test_ID);

alter table STUDENT_TEST
    add constraint FK_Student_ID foreign key (Student_ID) references STUDENT(Student_ID);

alter table STUDENT_TEST
    add constraint FK_Test_ID foreign key (Test_ID) references TEST(Test_ID);
```

3. Запуск sqlloader в терминале в директории "Task 6 (sqlloader)":
```
> sqlldr STUDENT_DB/STUDENT_DB CONTROL=ctl/FACULTY.ctl
> sqlldr STUDENT_DB/STUDENT_DB CONTROL=ctl/STUDENT.ctl
> sqlldr STUDENT_DB/STUDENT_DB CONTROL=ctl/TEST.ctl
> sqlldr STUDENT_DB/STUDENT_DB CONTROL=ctl/STUDENT_TEST.ctl
```

4. Добавляем английские названия факультетов и тестов (их нет в изначальных данных).

4.1 Сначала создадим вспомогательные таблицы в базе:
```
create table FACULTY_RU_EN (
    Faculty_Name_Ru  varchar2(200),
    Faculty_Name_En  varchar2(200)
);

create table TEST_RU_EN (
    Test_Name_Ru  varchar2(200),
    Test_Name_En  varchar2(200)
);
```

4.2 Теперь заполним эти таблицы данными перевода:
```
> sqlldr STUDENT_DB/STUDENT_DB CONTROL=ctl/FACULTY_EN.ctl
> sqlldr STUDENT_DB/STUDENT_DB CONTROL=ctl/TEST_EN.ctl
```

4.3 И обновим исходные таблицы в базе (дополним английскими названиями):
```
update FACULTY
set Faculty_Name_En = (select FACULTY_RU_EN.Faculty_Name_En
            from FACULTY_RU_EN
            where FACULTY_RU_EN.Faculty_Name_Ru = FACULTY.Faculty_Name_Ru);

update TEST
set Test_Name_En = (select TEST_RU_EN.Test_Name_En
            from TEST_RU_EN
            where TEST_RU_EN.Test_Name_Ru = TEST.Test_Name_Ru);
```

4.4 Удалим вспомогательные таблицы:
```
DROP TABLE FACULTY_RU_EN;
DROP TABLE TEST_RU_EN;
```
