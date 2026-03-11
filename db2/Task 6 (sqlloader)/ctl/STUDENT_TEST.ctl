-- STUDENTS.csv: идем построчно, значения разделены ';'

-- Начинаем со второй строки (в первой строке заголовок)

-- Первое значение пропускаем (это номер группы студента)
-- Второе значение это Student_ID, а значения с третьего по восемнадцатое - это Score студента за каждый из 16-ти тестов
-- Нам известно, что тесты имеют Test_ID c 1-го по 16-ый в порядке их расположения в файле STUDENTS.csv (потому-что так мы заполняли таблицу TEST)

-- Следовательно, для каждой записи (record) сделаем 16 вставок в таблицу STUDENT_TEST:
-- Второе значение кладем в STUDENT_TEST->Student_ID
-- N-ое значение (где N=3...18) кладем в STUDENT_TEST->Score
-- В STUDENT_TEST->Test_ID кладем константу, равную N-2

-- Мы делаем несколько вставок с использованием всех полей в рамках одной строки из STUDENTS.csv
-- Поэтому, перед каждой вставкой переносим указатель sqlloader-а на начало строки (конкретнее, на начало Student_ID - POSITION(7), так как voidGroupID нас не интересует)

OPTIONS (SKIP=1)
LOAD DATA CHARACTERSET UTF8
INFILE 'csv/STUDENTS.CSV'
TRUNCATE
INTO TABLE STUDENT_DB.STUDENT_TEST
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
  voidGroupID FILLER,
  Student_ID POSITION(7) INTEGER EXTERNAL TERMINATED BY ';' ,
  Score,
  voidScoreTest2 FILLER,
  voidScoreTest3 FILLER,
  voidScoreTest4 FILLER,
  voidScoreTest5 FILLER,
  voidScoreTest6 FILLER,
  voidScoreTest7 FILLER,
  voidScoreTest8 FILLER,
  voidScoreTest9 FILLER,
  voidScoreTest10 FILLER,
  voidScoreTest11 FILLER,
  voidScoreTest12 FILLER,
  voidScoreTest13 FILLER,
  voidScoreTest14 FILLER,
  voidScoreTest15 FILLER,
  voidScoreTest16 FILLER,
  Test_ID CONSTANT 1
)
INTO TABLE STUDENT_DB.STUDENT_TEST
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
  voidGroupID FILLER,
  Student_ID POSITION(7) INTEGER EXTERNAL TERMINATED BY ';' ,
  voidScoreTest1 FILLER,
  Score,
  voidScoreTest3 FILLER,
  voidScoreTest4 FILLER,
  voidScoreTest5 FILLER,
  voidScoreTest6 FILLER,
  voidScoreTest7 FILLER,
  voidScoreTest8 FILLER,
  voidScoreTest9 FILLER,
  voidScoreTest10 FILLER,
  voidScoreTest11 FILLER,
  voidScoreTest12 FILLER,
  voidScoreTest13 FILLER,
  voidScoreTest14 FILLER,
  voidScoreTest15 FILLER,
  voidScoreTest16 FILLER,
  Test_ID CONSTANT 2
)
INTO TABLE STUDENT_DB.STUDENT_TEST
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
  voidGroupID FILLER,
  Student_ID POSITION(7) INTEGER EXTERNAL TERMINATED BY ';' ,
  voidScoreTest1 FILLER,
  voidScoreTest2 FILLER,
  Score,
  voidScoreTest4 FILLER,
  voidScoreTest5 FILLER,
  voidScoreTest6 FILLER,
  voidScoreTest7 FILLER,
  voidScoreTest8 FILLER,
  voidScoreTest9 FILLER,
  voidScoreTest10 FILLER,
  voidScoreTest11 FILLER,
  voidScoreTest12 FILLER,
  voidScoreTest13 FILLER,
  voidScoreTest14 FILLER,
  voidScoreTest15 FILLER,
  voidScoreTest16 FILLER,
  Test_ID CONSTANT 3
)
INTO TABLE STUDENT_DB.STUDENT_TEST
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
  voidGroupID FILLER,
  Student_ID POSITION(7) INTEGER EXTERNAL TERMINATED BY ';' ,
  voidScoreTest1 FILLER,
  voidScoreTest2 FILLER,
  voidScoreTest3 FILLER,
  Score,
  voidScoreTest5 FILLER,
  voidScoreTest6 FILLER,
  voidScoreTest7 FILLER,
  voidScoreTest8 FILLER,
  voidScoreTest9 FILLER,
  voidScoreTest10 FILLER,
  voidScoreTest11 FILLER,
  voidScoreTest12 FILLER,
  voidScoreTest13 FILLER,
  voidScoreTest14 FILLER,
  voidScoreTest15 FILLER,
  voidScoreTest16 FILLER,
  Test_ID CONSTANT 4
)
INTO TABLE STUDENT_DB.STUDENT_TEST
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
  voidGroupID FILLER,
  Student_ID POSITION(7) INTEGER EXTERNAL TERMINATED BY ';' ,
  voidScoreTest1 FILLER,
  voidScoreTest2 FILLER,
  voidScoreTest3 FILLER,
  voidScoreTest4 FILLER,
  Score,
  voidScoreTest6 FILLER,
  voidScoreTest7 FILLER,
  voidScoreTest8 FILLER,
  voidScoreTest9 FILLER,
  voidScoreTest10 FILLER,
  voidScoreTest11 FILLER,
  voidScoreTest12 FILLER,
  voidScoreTest13 FILLER,
  voidScoreTest14 FILLER,
  voidScoreTest15 FILLER,
  voidScoreTest16 FILLER,
  Test_ID CONSTANT 5
)
INTO TABLE STUDENT_DB.STUDENT_TEST
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
  voidGroupID FILLER,
  Student_ID POSITION(7) INTEGER EXTERNAL TERMINATED BY ';' ,
  voidScoreTest1 FILLER,
  voidScoreTest2 FILLER,
  voidScoreTest3 FILLER,
  voidScoreTest4 FILLER,
  voidScoreTest5 FILLER,
  Score,
  voidScoreTest7 FILLER,
  voidScoreTest8 FILLER,
  voidScoreTest9 FILLER,
  voidScoreTest10 FILLER,
  voidScoreTest11 FILLER,
  voidScoreTest12 FILLER,
  voidScoreTest13 FILLER,
  voidScoreTest14 FILLER,
  voidScoreTest15 FILLER,
  voidScoreTest16 FILLER,
  Test_ID CONSTANT 6
)
INTO TABLE STUDENT_DB.STUDENT_TEST
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
  voidGroupID FILLER,
  Student_ID POSITION(7) INTEGER EXTERNAL TERMINATED BY ';' ,
  voidScoreTest1 FILLER,
  voidScoreTest2 FILLER,
  voidScoreTest3 FILLER,
  voidScoreTest4 FILLER,
  voidScoreTest5 FILLER,
  voidScoreTest6 FILLER,
  Score,
  voidScoreTest8 FILLER,
  voidScoreTest9 FILLER,
  voidScoreTest10 FILLER,
  voidScoreTest11 FILLER,
  voidScoreTest12 FILLER,
  voidScoreTest13 FILLER,
  voidScoreTest14 FILLER,
  voidScoreTest15 FILLER,
  voidScoreTest16 FILLER,
  Test_ID CONSTANT 7
)
INTO TABLE STUDENT_DB.STUDENT_TEST
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
  voidGroupID FILLER,
  Student_ID POSITION(7) INTEGER EXTERNAL TERMINATED BY ';' ,
  voidScoreTest1 FILLER,
  voidScoreTest2 FILLER,
  voidScoreTest3 FILLER,
  voidScoreTest4 FILLER,
  voidScoreTest5 FILLER,
  voidScoreTest6 FILLER,
  voidScoreTest7 FILLER,
  Score,
  voidScoreTest9 FILLER,
  voidScoreTest10 FILLER,
  voidScoreTest11 FILLER,
  voidScoreTest12 FILLER,
  voidScoreTest13 FILLER,
  voidScoreTest14 FILLER,
  voidScoreTest15 FILLER,
  voidScoreTest16 FILLER,
  Test_ID CONSTANT 8
)
INTO TABLE STUDENT_DB.STUDENT_TEST
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
  voidGroupID FILLER,
  Student_ID POSITION(7) INTEGER EXTERNAL TERMINATED BY ';' ,
  voidScoreTest1 FILLER,
  voidScoreTest2 FILLER,
  voidScoreTest3 FILLER,
  voidScoreTest4 FILLER,
  voidScoreTest5 FILLER,
  voidScoreTest6 FILLER,
  voidScoreTest7 FILLER,
  voidScoreTest8 FILLER,
  Score,
  voidScoreTest10 FILLER,
  voidScoreTest11 FILLER,
  voidScoreTest12 FILLER,
  voidScoreTest13 FILLER,
  voidScoreTest14 FILLER,
  voidScoreTest15 FILLER,
  voidScoreTest16 FILLER,
  Test_ID CONSTANT 9
)
INTO TABLE STUDENT_DB.STUDENT_TEST
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
  voidGroupID FILLER,
  Student_ID POSITION(7) INTEGER EXTERNAL TERMINATED BY ';' ,
  voidScoreTest1 FILLER,
  voidScoreTest2 FILLER,
  voidScoreTest3 FILLER,
  voidScoreTest4 FILLER,
  voidScoreTest5 FILLER,
  voidScoreTest6 FILLER,
  voidScoreTest7 FILLER,
  voidScoreTest8 FILLER,
  voidScoreTest9 FILLER,
  Score,
  voidScoreTest11 FILLER,
  voidScoreTest12 FILLER,
  voidScoreTest13 FILLER,
  voidScoreTest14 FILLER,
  voidScoreTest15 FILLER,
  voidScoreTest16 FILLER,
  Test_ID CONSTANT 10
)
INTO TABLE STUDENT_DB.STUDENT_TEST
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
  voidGroupID FILLER,
  Student_ID POSITION(7) INTEGER EXTERNAL TERMINATED BY ';' ,
  voidScoreTest1 FILLER,
  voidScoreTest2 FILLER,
  voidScoreTest3 FILLER,
  voidScoreTest4 FILLER,
  voidScoreTest5 FILLER,
  voidScoreTest6 FILLER,
  voidScoreTest7 FILLER,
  voidScoreTest8 FILLER,
  voidScoreTest9 FILLER,
  voidScoreTest10 FILLER,
  Score,
  voidScoreTest12 FILLER,
  voidScoreTest13 FILLER,
  voidScoreTest14 FILLER,
  voidScoreTest15 FILLER,
  voidScoreTest16 FILLER,
  Test_ID CONSTANT 11
)
INTO TABLE STUDENT_DB.STUDENT_TEST
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
  voidGroupID FILLER,
  Student_ID POSITION(7) INTEGER EXTERNAL TERMINATED BY ';' ,
  voidScoreTest1 FILLER,
  voidScoreTest2 FILLER,
  voidScoreTest3 FILLER,
  voidScoreTest4 FILLER,
  voidScoreTest5 FILLER,
  voidScoreTest6 FILLER,
  voidScoreTest7 FILLER,
  voidScoreTest8 FILLER,
  voidScoreTest9 FILLER,
  voidScoreTest10 FILLER,
  voidScoreTest11 FILLER,
  Score,
  voidScoreTest13 FILLER,
  voidScoreTest14 FILLER,
  voidScoreTest15 FILLER,
  voidScoreTest16 FILLER,
  Test_ID CONSTANT 12
)
INTO TABLE STUDENT_DB.STUDENT_TEST
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
  voidGroupID FILLER,
  Student_ID POSITION(7) INTEGER EXTERNAL TERMINATED BY ';' ,
  voidScoreTest1 FILLER,
  voidScoreTest2 FILLER,
  voidScoreTest3 FILLER,
  voidScoreTest4 FILLER,
  voidScoreTest5 FILLER,
  voidScoreTest6 FILLER,
  voidScoreTest7 FILLER,
  voidScoreTest8 FILLER,
  voidScoreTest9 FILLER,
  voidScoreTest10 FILLER,
  voidScoreTest11 FILLER,
  voidScoreTest12 FILLER,
  Score,
  voidScoreTest14 FILLER,
  voidScoreTest15 FILLER,
  voidScoreTest16 FILLER,
  Test_ID CONSTANT 13
)
INTO TABLE STUDENT_DB.STUDENT_TEST
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
  voidGroupID FILLER,
  Student_ID POSITION(7) INTEGER EXTERNAL TERMINATED BY ';' ,
  voidScoreTest1 FILLER,
  voidScoreTest2 FILLER,
  voidScoreTest3 FILLER,
  voidScoreTest4 FILLER,
  voidScoreTest5 FILLER,
  voidScoreTest6 FILLER,
  voidScoreTest7 FILLER,
  voidScoreTest8 FILLER,
  voidScoreTest9 FILLER,
  voidScoreTest10 FILLER,
  voidScoreTest11 FILLER,
  voidScoreTest12 FILLER,
  voidScoreTest13 FILLER,
  Score,
  voidScoreTest15 FILLER,
  voidScoreTest16 FILLER,
  Test_ID CONSTANT 14
)
INTO TABLE STUDENT_DB.STUDENT_TEST
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
  voidGroupID FILLER,
  Student_ID POSITION(7) INTEGER EXTERNAL TERMINATED BY ';' ,
  voidScoreTest1 FILLER,
  voidScoreTest2 FILLER,
  voidScoreTest3 FILLER,
  voidScoreTest4 FILLER,
  voidScoreTest5 FILLER,
  voidScoreTest6 FILLER,
  voidScoreTest7 FILLER,
  voidScoreTest8 FILLER,
  voidScoreTest9 FILLER,
  voidScoreTest10 FILLER,
  voidScoreTest11 FILLER,
  voidScoreTest12 FILLER,
  voidScoreTest13 FILLER,
  voidScoreTest14 FILLER,
  Score,
  voidScoreTest16 FILLER,
  Test_ID CONSTANT 15
)
INTO TABLE STUDENT_DB.STUDENT_TEST
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
  voidGroupID FILLER,
  Student_ID POSITION(7) INTEGER EXTERNAL TERMINATED BY ';' ,
  voidScoreTest1 FILLER,
  voidScoreTest2 FILLER,
  voidScoreTest3 FILLER,
  voidScoreTest4 FILLER,
  voidScoreTest5 FILLER,
  voidScoreTest6 FILLER,
  voidScoreTest7 FILLER,
  voidScoreTest8 FILLER,
  voidScoreTest9 FILLER,
  voidScoreTest10 FILLER,
  voidScoreTest11 FILLER,
  voidScoreTest12 FILLER,
  voidScoreTest13 FILLER,
  voidScoreTest14 FILLER,
  Score,
  Test_ID CONSTANT 16
)