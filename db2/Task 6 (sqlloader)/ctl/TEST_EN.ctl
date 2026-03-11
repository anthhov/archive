-- TEST_EN.csv: идем построчно, значения разделены ';'

-- Используем вспомогательную таблицу TEST_RU_EN
-- Первое значение кладем в FACULTY_RU_EN->Faculty_Name_Ru
-- Второе значение кладем в FACULTY_RU_EN->Faculty_Name_En

LOAD DATA CHARACTERSET UTF8
INFILE 'csv/TESTS_EN.csv'
TRUNCATE
INTO TABLE STUDENT_DB.TEST_RU_EN
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
  Test_Name_Ru,
  Test_Name_En
)
