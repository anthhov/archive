README
----
Работаем в Oracle APEX

1. Создадим базу (task5.sql)

2. Зарегистрируем схему в ORDS:
```
SQL Workshop -> RESTful Services -> Register Schema with ORDS -> Save Schema Attributes
```

3. Создадим модуль для двуязычного представления тестов:
```
SQL Workshop -> RESTful Services -> Modules -> Create Module
Module Name: 'TESTS'
Base Path: '/TESTS/'
```

3.1 Создадим шаблон для тестов на английском языке:
```
Create Template
URI Template: 'TESTS_EN'
```

3.2 Создадим обработчик для тестов на английском языке:
```
Create Handler
Source Type: 'Query'
Format: 'CSV'
Source: "select Test_Name from TEST_EN"
```
Сохраняем итоговую ссылку.

3.3 Сделаем пункты 3.1 и 3.2 для тестов на русском языке (просто заменяем TESTS_EN на TESTS_RU).

4. Сделаем пункт 3. со всеми подпунктами для представления факультетов.

Результат:
https://apex.oracle.com/pls/apex/aostrouhhov/TESTS/TESTS_EN
https://apex.oracle.com/pls/apex/aostrouhhov/TESTS/TESTS_RU
https://apex.oracle.com/pls/apex/aostrouhhov/FACULTIES/FACULTIES_EN
https://apex.oracle.com/pls/apex/aostrouhhov/FACULTIES/FACULTIES_RU
