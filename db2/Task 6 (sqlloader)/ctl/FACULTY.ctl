-- FACULTIES.csv: идем построчно, значения разделены ';'

-- Первое значение кладем в FACULTY->Faculty_Letter
-- Второе значение кладем в FACULTY->Faculty_Name_Ru

LOAD DATA CHARACTERSET UTF8
INFILE 'csv/FACULTIES.CSV'
TRUNCATE
INTO TABLE STUDENT_DB.FACULTY
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
  Faculty_Letter,
  Faculty_Name_Ru
)
