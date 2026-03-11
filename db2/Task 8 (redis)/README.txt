Работаем в try.redis.io

----------------
-- Схема базы
----------------
1. students - множество имен студентов (они будут хэшами):

"Anton Ostrouhhov"
"Ivan Petrov"
"Olga Prokhorova"
"Kiril Ivanov"
"Olesya Kotova"

2. courses - упорядоченный список дисциплин по порядку:

"English" -- "Mathematics" -- "Databases" -- "Cloud Computing" -- "Computer Networks"

----------------
-- Создание и заполнение базы
----------------

RPUSH courses "English" "Mathematics" "Databases" "Cloud Computing" "Computer Networks"
SADD students "Anton Ostrouhhov" "Ivan Petrov" "Olga Prokhorova" "Kiril Ivanov" "Olesya Kotova"

-- HSET 'ключ' 'поле' 'значение'
-- В хэше с названием 'ключ' задать 'полю' 'значение'

HSET "Anton Ostrouhhov" "English" 5
HSET "Anton Ostrouhhov" "Mathematics" 4
HSET "Anton Ostrouhhov" "Databases" 4
HSET "Anton Ostrouhhov" "Cloud Computing" 5
HSET "Anton Ostrouhhov" "Computer Networks" 5

HSET "Ivan Petrov" "English" 4
HSET "Ivan Petrov" "Mathematics" 3
HSET "Ivan Petrov" "Databases" 2
HSET "Ivan Petrov" "Cloud Computing" 4
HSET "Ivan Petrov" "Computer Networks" 5

HSET "Olga Prokhorova" "English" 5
HSET "Olga Prokhorova" "Mathematics" 5
HSET "Olga Prokhorova" "Databases" 5
HSET "Olga Prokhorova" "Cloud Computing" 5
HSET "Olga Prokhorova" "Computer Networks" 5

HSET "Kiril Ivanov" "English" 4
HSET "Kiril Ivanov" "Mathematics" 2
HSET "Kiril Ivanov" "Cloud Computing" 3
HSET "Kiril Ivanov" "Computer Networks" 4

HSET "Olesya Kotova" "English" 5
HSET "Olesya Kotova" "Mathematics" 4
HSET "Olesya Kotova" "Databases" 5
HSET "Olesya Kotova" "Cloud Computing" 4
HSET "Olesya Kotova" "Computer Networks" 5

-- Для удобства работы с данными заведем для каждой дисциплины
--   множество с элементами типа "студент - оценка" (ведомость).
-- При работе с Redis в каком-нибудь языке программирования
--   можно заводить эти множества автоматизированно.

-- ZADD 'ключ' 'очки' 'участник' 'очки' 'участник' 'очки' 'участник' ...
-- Добавить всех 'участников' с их 'очками' в отсортированое множество с названием 'ключ'

ZADD "English" 5 "Anton Ostrouhhov" 4 "Ivan Petrov" 5 "Olga Prokhorova" 4 "Kiril Ivanov" 5 "Olesya Kotova"
ZADD "Mathematics" 4 "Anton Ostrouhhov" 3 "Ivan Petrov" 5 "Olga Prokhorova" 2 "Kiril Ivanov" 4 "Olesya Kotova"
ZADD "Databases" 4 "Anton Ostrouhhov" 2 "Ivan Petrov" 5 "Olga Prokhorova" 5 "Olesya Kotova"
ZADD "Cloud Computing" 5 "Anton Ostrouhhov" 4 "Ivan Petrov" 5 "Olga Prokhorova" 3 "Kiril Ivanov" 4 "Olesya Kotova"
ZADD "Computer Networks" 5 "Anton Ostrouhhov" 5 "Ivan Petrov" 5 "Olga Prokhorova" 4 "Kiril Ivanov" 5 "Olesya Kotova"

----------------
-- Работа с созданной базой
----------------

-- Получить количество экзаменов
LLEN courses

-- Получить название второго экзамена
LINDEX courses 2

-- Получить название последнего экзамена
LINDEX courses -1

-- Посмотрим все дисциплины
LRANGE courses 0 -1

-- Посмотрим всех студентов
SMEMBERS students

-- Проверить, есть ли у Антона оценка за "Mathematics" в профиле
HEXISTS "Anton Ostrouhhov" "Mathematics"

-- Проверить оценку Ольги по "Computer Networks" в профиле
HGET "Olga Prokhorova" "Computer Networks"

-- Получить все оценки Ивана из профиля
HGETALL "Ivan Petrov"

-- Получить количество студентов, записанных на "Databases" (по ведомости)
ZCOUNT "Databases" -inf +inf

-- Посмотрим на этих студентов и их оценки
ZRANGEBYSCORE "Databases" -inf inf WITHSCORES

-- Проверить, есть ли у Кирила оценка за "Databases" в профиле
HEXISTS "Kiril Ivanov" "Databases"

-- Посмотрим на студентов, которые получили оценку >2
ZRANGEBYSCORE "Databases" (2 +inf WITHSCORES

-- Получить оценку Кирилла за "English" из его профиля
HGET "Kiril Ivanov" "English"

-- Получить оценку Кирилла за "English" из ведомости
ZSCORE "English" "Kiril Ivanov"

-- Получить все оценки Олеси
HGETALL "Olesya Kotova"

-- Хранить информацию об Олесе еще 10 секунд
EXPIRE "Olesya Kotova" 5

-- Проверить, сколько ещё будет храниться Олеся
TTL "Olesya Kotova"

-- Проверить, сколько ещё будет храниться Антон
TTL "Anton Ostrouhhov"

-- Снова попробовать получить все оценки Олеси
HGETALL "Olesya Kotova"
