-- Работаем в Oracle APEX

-- Создаю таблицу FILMS с полем Name VARCHAR2(128) и оценкой фильма по 10-бальной шкале (поле STARS, тип NUMBER).
drop table FILMS;

create table FILMS (
    Name varchar2(128),
    stars number(2,0)
);
/

-- Надо ли добавить ограничение на звёзды?
alter table FILMS add check (stars >= 0 and stars <= 10);

-- Заполните эту таблицу несколькими названиями фильмов, которые вы посмотрели за последнее время.
insert into FILMS values ('Крёстный отец', 9);
insert into FILMS values ('Варкрафт', 8);
insert into FILMS values ('Матрица', 9);
insert into FILMS values ('Дюна', 5);
insert into FILMS values ('Титаник', 7);

-- Создайте в своей схеме функцию About_me (без параметров),
--   которая выдает результат типа VARCHAR2
--   с наполнением в виде фамилии и имени владельца схемы и номера группы.
CREATE OR REPLACE FUNCTION About_me
RETURN
    VARCHAR2
IS
    info VARCHAR2(128);
BEGIN
	info := 'Антон Остроухов, 20.М05-мм';
    RETURN info;
END About_me;
/

-- Выдайте привилегию на просмотр таблицы FILMS и функции About_me своим одногруппникам персонально или всем пользователям базы ORACLE (с которой мы работаем).
GRANT SELECT ON FILMS TO PUBLIC;

-- Напишите запрос, который позволит объединить все фильмы из схем одногруппников и информацию о каждом владельце схемы.
-- Почему-то у других "Name" надо в ковычках
select Name, stars, About_me() from FILMS union
select "Name", stars, WKSP_NANITI.About_me() from WKSP_NANITI.FILMS union
select "Name", stars, WKSP_RESTONICH.About_me() from WKSP_RESTONICH.FILMS union
select "NAME", stars, WKSP_UNCERSO.About_me() from WKSP_UNCERSO.FILMS union 
select "NAME", stars, WKSP_DEDSEC256.About_me() from WKSP_DEDSEC256.FILMS;
