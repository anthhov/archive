README
----
1. После выполнения задания 6 должна была остаться схема STUDENT_DB со всеми своими таблицами. Создадим дамп этой схемы.

2. Создадим в ФС папку для дампов
```
> mkdir -p \Users\Public\oracle_dump
```

2.1 Создадим логическое отображение на эту папку в БД, проверим результат:
```
> sqlplus / as sysdba
SQL> create or replace directory datapump as 'c:\Users\Public\oracle_dump';
SQL> select * from dba_directories where DIRECTORY_NAME='DATAPUMP';
SQL> exit
```

3. Делаем экспорт (дамп) схемы STUDENT_DB:
```
> expdp \"/ as sysdba\" directory=datapump dumpfile=student_db.dmp schemas='STUDENT_DB'
```

4. Удалим схему, затем создадим ее заново, дадим необходимые права. Это костыль, нужно уметь восстанавливать дамп без создания схемы и выдачи прав.
```
> sqlplus / as sysdba
SQL> alter session set “_oracle_script“=true;
SQL> drop user STUDENT_DB cascade;
SQL> create user STUDENT_DB identified by STUDENT_DB;
SQL> grant create session to STUDENT_DB;
SQL> grant unlimited tablespace to STUDENT_DB;
SQL> grant create table to STUDENT_DB;
SQL> exit
```

5. Делаем импорт дампа схемы STUDENT_DB:
```
impdp \"/ as sysdba\" directory=datapump dumpfile=student_db.dmp remap_schema='STUDENT_DB:STUDENT_DB'
```
