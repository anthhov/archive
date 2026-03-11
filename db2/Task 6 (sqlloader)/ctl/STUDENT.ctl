-- STUDENTS.csv: идем построчно, значения разделены ';'

-- Начиная со второй строки (в первой строке заголовок):
-- Первое значение кладем в STUDENT->Group_code
-- Второе значение кладем в STUDENT->Student_ID

OPTIONS (SKIP=1)
LOAD DATA CHARACTERSET UTF8
INFILE 'csv/STUDENTS.CSV'
TRUNCATE
INTO TABLE STUDENT_DB.STUDENT
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
  Group_code,
  Student_ID,
  void1 FILLER,
  void2 FILLER,
  void3 FILLER,
  void4 FILLER,
  void5 FILLER,
  void6 FILLER,
  void7 FILLER,
  void8 FILLER,
  void9 FILLER,
  void10 FILLER,
  void11 FILLER,
  void12 FILLER,
  void13 FILLER,
  void14 FILLER,
  void15 FILLER,
  void16 FILLER
)
