-- FACULTIES_EN.csv: идем построчно, значения разделены ';'

-- Используем вспомогательную таблицу FACULTY_RU_EN
-- Первое значение кладем в FACULTY_RU_EN->Faculty_Name_Ru
-- Второе значение кладем в FACULTY_RU_EN->Faculty_Name_En

LOAD DATA CHARACTERSET UTF8
INFILE 'csv/FACULTIES_EN.CSV'
TRUNCATE
INTO TABLE STUDENT_DB.FACULTY_RU_EN
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
  Faculty_Name_Ru,
  Faculty_Name_En
)
