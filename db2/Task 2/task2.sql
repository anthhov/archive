-- Работаем в Oracle APEX

--
-- Задание 2.1
--

-- Создадим представление с номерами и именами сотрудников, которых принимали на работу зимой
CREATE VIEW winter_hire AS SELECT EMPNO, ENAME, HIREDATE FROM EMP WHERE extract(MONTH FROM HIREDATE) IN (11, 12, 1);

-- Проверяем
SELECT * FROM winter_hire;

-- Создадим представление c именами сотрудников, которые являются непосредственными начальниками >=3 подчиненных
CREATE VIEW big_managers
AS SELECT MIN(MGR_EMP.ENAME) AS MGR_NAME
FROM EMP JOIN EMP MGR_EMP
    ON EMP.MGR = MGR_EMP.EMPNO
    GROUP BY EMP.MGR
    HAVING COUNT(*) >= 3;

-- Проверяем
SELECT * FROM big_managers;

-- Увидем созданные представление среди системных
SELECT * FROM USER_VIEWS WHERE ROWNUM <= 10;

-- Удалим представления
DROP VIEW winter_hire;
DROP VIEW big_managers;

--
-- Задание 2.2
--

-- Создадим и заполним таблицу DEPT1
CREATE TABLE DEPT1 (
    "DEPTNO"  number(4,0) NOT NULL,
    "DNAME"   varchar2(50),
    "LOC"     varchar2(50),
    CONSTRAINT "DEPT_PK1" PRIMARY KEY ("DEPTNO")
);

INSERT INTO DEPT1 SELECT * FROM DEPT;

-- Посмотрим на DEPT1, чтобы придумать подхходящуюю секвенцию
SELECT * FROM DEPT1;

-- Сделаем секвенцию для DEPTNO, которая начинается с 50 и имеет шаг 10. Кэш 20.
CREATE SEQUENCE DEPT1_DEPTNO_SEQ
    START WITH 50 INCREMENT BY 10 CACHE 20;

-- Сгенерируем 10 значения используя секвенции
insert into DEPT1 values (DEPT1_DEPTNO_SEQ.NEXTVAL, 'SOME DEPARTMENT', 'SOME CITY');
insert into DEPT1 values (DEPT1_DEPTNO_SEQ.NEXTVAL, 'SOME DEPARTMENT', 'SOME CITY');
insert into DEPT1 values (DEPT1_DEPTNO_SEQ.NEXTVAL, 'SOME DEPARTMENT', 'SOME CITY');
insert into DEPT1 values (DEPT1_DEPTNO_SEQ.NEXTVAL, 'SOME DEPARTMENT', 'SOME CITY');
insert into DEPT1 values (DEPT1_DEPTNO_SEQ.NEXTVAL, 'SOME DEPARTMENT', 'SOME CITY');
insert into DEPT1 values (DEPT1_DEPTNO_SEQ.NEXTVAL, 'SOME DEPARTMENT', 'SOME CITY');
insert into DEPT1 values (DEPT1_DEPTNO_SEQ.NEXTVAL, 'SOME DEPARTMENT', 'SOME CITY');
insert into DEPT1 values (DEPT1_DEPTNO_SEQ.NEXTVAL, 'SOME DEPARTMENT', 'SOME CITY');
insert into DEPT1 values (DEPT1_DEPTNO_SEQ.NEXTVAL, 'SOME DEPARTMENT', 'SOME CITY');
insert into DEPT1 values (DEPT1_DEPTNO_SEQ.NEXTVAL, 'SOME DEPARTMENT', 'SOME CITY');

-- Убедимся, что секвенция работает
SELECT * FROM DEPT1;

-- Смотрим на секвенцию в системном представлении ALL_SEQUENCES
 SELECT * FROM USER_SEQUENCES WHERE SEQUENCE_NAME = 'DEPT1_DEPTNO_SEQ';

-- Удаляем секвенцию
DROP SEQUENCE DEPT1_DEPTNO_SEQ;

-- Удаляем таблицу DEPT1
DROP TABLE DEPT1;

--
-- Задание 2.3 (TODO)
--

-- Создаем функцию, вычисляющую факториал
CREATE OR REPLACE FUNCTION factorial(n IN NUMBER)
RETURN NUMBER
IS
    fact NUMBER;
BEGIN
    fact := 1;
    FOR i IN 2..n LOOP
        fact := fact * i;
    END LOOP;

    RETURN fact;
END factorial;
/

-- Проверим функцию факториала
SELECT factorial(7) FROM DUAL;

-- Удалим функцию факториала
DROP FUNCTION factorial;

--
-- Задание 2.4
--

-- Создаем процедуру, которая пишет всевозможную статистику по сотрудникам и департаментам
CREATE OR REPLACE PROCEDURE stats
IS
    emp_count NUMBER;
    dep_count NUMBER;
    jobs_count NUMBER;
    sal_sum NUMBER;
BEGIN
    SELECT COUNT(*) INTO emp_count FROM emp;
    SELECT COUNT(*) INTO dep_count FROM dept;
    SELECT COUNT(DISTINCT job) INTO jobs_count FROM emp;
    SELECT SUM(sal) INTO sal_sum FROM emp;
    dbms_output.put_line('Amount of employees = ' || emp_count);
    dbms_output.put_line('Amount of departaments = ' || dep_count);
    dbms_output.put_line('Amount of different job positions = ' || jobs_count);
    dbms_output.put_line('Sum of all employees salaries = ' || sal_sum);
END stats;
/

-- Вызов процедуры stats
BEGIN
    stats;
END;
/

-- Удалим процедуру stats
DROP PROCEDURE stats;

--
-- Задание 2.5
--

-- Создаем таблицу debug_log
CREATE TABLE debug_log(
    id NUMBER NOT NULL,
    LogTime DATE NOT NULL,
    Message LONG,
    inSource VARCHAR2(300)
);

-- Создаем секвенцию для id в debug_log.
CREATE SEQUENCE debug_log_seq
    START WITH 1 INCREMENT BY 1 CACHE 100;

-- Создаем процедуру, определяющую даты приема на работу
--     1. сотрудника, который работает дольше всех и
--     2. сотрудника, который работает меньше всех.
-- Результаты работы процедуры зафиксируем в debug_log
CREATE OR REPLACE PROCEDURE MinAndMaxExperience(
    MinExp OUT DATE,
    MaxExp OUT DATE)
IS
BEGIN
    SELECT MAX(HIREDATE) INTO MinExp FROM EMP;
    SELECT MIN(HIREDATE) INTO MaxExp FROM EMP;
END MinAndMaxExperience;
/

-- Вызываем процедуру MinAndMaxExperience и сохраняем результат в debug_log
DECLARE
    MinExp DATE;
    MaxExp DATE;
BEGIN
    MinAndMaxExperience(MinExp, MaxExp);
    INSERT INTO debug_log(id, LogTime, Message, inSource)
        VALUES(debug_log_seq.NEXTVAL, sysdate, 'Last Recruitment Date = ' || MinExp || ' Oldest Recruitment Date = ' || MaxExp, 'MinAndMaxExperience');
END;
/

-- Посмотрим содержимое debug_log
SELECT * FROM debug_log;

-- Удалим таблицу debug_log
DROP TABLE debug_log;

-- Удаляем секвенцию debug_log_seq
DROP SEQUENCE debug_log_seq;

-- Удалим процедуру MinAndMaxExperience
DROP PROCEDURE MinAndMaxExperience;

--
-- Задание 2.6 (TODO)
--
