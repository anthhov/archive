-- Работаем в Oracle APEX

-- Task 1.1

-- (1)
select * from user_tables
/

select * from all_tables where all_tables.TABLE_NAME not in (select TABLE_NAME from user_tables) and rownum <= 10
/

-- (2)
select * from SYSTEM_PRIVILEGE_MAP where rownum <= 10
/

-- (3)
create table mytable (
    column1 char,
    column2 varchar2(200),
    column3 number(10,0),
    column4 date,
    column5 timestamp
)
/

select * from user_tables
/

drop table mytable
/

-- Task 1.2

-- (1)
create table car_deal (
    deal_id      number(10,0),
    customer_id  number(10,0),
    deal_date    date,
    car_model    varchar2(200),
    price        number(12,2)
)
/

create table customer (
    customer_id     number(10,0)  unique,
    customer_name   varchar2(200)  not null,
    birth_date      date
)
/

alter table car_deal
    add constraint pk primary key (deal_id)
/

alter table car_deal
    add constraint FK_customer_id foreign key (customer_id) references customer(customer_id)
/

alter table car_deal
    add constraint check_date check (deal_date > TO_DATE('31/12/2010', 'DD/MM/YYYY'))
/

-- Add customers
insert into customer values (1, 'Anton Rez', TO_DATE('24/03/1997', 'DD/MM/YYYY'))
/
insert into customer values (2, 'Igor Petrov', TO_DATE('26/05/2004', 'DD/MM/YYYY'))
/
insert into customer values (3, 'John Rey', TO_DATE('04/03/1986', 'DD/MM/YYYY'))
/
insert into customer values (4, 'Lee', TO_DATE('15/01/1975', 'DD/MM/YYYY'))
/

-- These 2 should fail
insert into customer values (3, 'Bug Bug', TO_DATE('07/04/2000', 'DD/MM/YYYY'))
/
insert into customer values (5, '', TO_DATE('09/09/1999', 'DD/MM/YYYY'))
/

-- Add car deals
insert into car_deal values (1, 1, current_date, 'Fiesta', 1000000)
/
insert into car_deal values (2, 3, current_date, 'Kuga', 2000000)
/
insert into car_deal values (3, 4, current_date, 'Mustang', 15000000)
/
insert into car_deal values (4, 4, current_date, 'Mondeo', 4000000)
/

-- These 2 should fail
insert into car_deal values (1, 1, current_date, 'Fusion', 10000)
/
insert into car_deal values (5, 1, TO_DATE('01/01/2005', 'DD/MM/YYYY'), 'Ka', 20000)
/

-- (2)
select count(constraint_name) from user_constraints where TABLE_NAME = 'CAR_DEAL' or TABLE_NAME = 'CUSTOMER' 
/

select count(constraint_name) from user_constraints
/

drop table car_deal
/

drop table customer
/

-- (3)
-- Добавить правило целостности без явного именования
alter table EMP add check (SAL >= 500 and SAL <= 5000)
/

-- Убедимя, что оно отображается - выведем имя этого правила целостности
select constraint_name from user_constraints
    where table_name = 'EMP' and SEARCH_CONDITION_VC = 'SAL >= 500 and SAL <= 5000'
/

-- (4)
-- Удалим это правило целостности

-- Создаем процедуру, которая удалит CHECK с неизвестным именем
CREATE OR REPLACE PROCEDURE removecheck
IS
    emp_count NUMBER;
    dep_count NUMBER;
    jobs_count NUMBER;
    sal_sum NUMBER;
BEGIN
    FOR cn IN (
        select constraint_name 
        from user_constraints 
        where table_name = 'EMP'
        and SEARCH_CONDITION_VC = 'SAL >= 500 and SAL <= 5000'
    )
    LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE EMP DROP CONSTRAINT ' || cn.constraint_name;
    END LOOP;
END removecheck;
/

-- Вызов процедуры removecheck
BEGIN
    removecheck;
END;
/

-- Убедимя, что CHECK удалился
select constraint_name from user_constraints
    where table_name = 'EMP' and SEARCH_CONDITION_VC = 'SAL >= 500 and SAL <= 5000'
/

-- Удалим процедуру stats
DROP PROCEDURE removecheck;
/

-- (5)
-- Добавим это же правило целостности с явным именованием
alter table EMP add constraint MY_CONSTRAINT check (SAL >= 500 and SAL <= 5000)
/

-- Посмотрим на него
select * from user_constraints where constraint_name = 'MY_CONSTRAINT'
/

-- Удалим
alter table EMP drop constraint MY_CONSTRAINT
/

-- Проверим, что удалилось
select * from user_constraints where constraint_name = 'MY_CONSTRAINT'
/

-- Task 1.3
-- (1)
select * from user_indexes where rownum <= 10
/

select * from all_indexes where rownum <= 10
/

-- (2)
select count(index_name) from user_indexes
/

-- (3)
create table DEPT1 (
    "DEPTNO1"  number(2,0) not null enable,
    "DNAME1"   varchar2(50), 
    "LOC1"     varchar2(50),
    constraint "DEPT_PK1" primary key ("DEPTNO1")
) organization index
/

insert into DEPT1
    select * from dept
/

select * from DEPT1
/

drop table DEPT1
/
