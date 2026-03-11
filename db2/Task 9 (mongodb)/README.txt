Работаем в cloud.mongodb.com, подключаемся через mongosh (там есть инструкция)

----------------
-- Заполнение базы документами (коллекции rest и emp создаются автоматически)
----------------

db.rest.insert({"restno": 1, "restname": "Central Perk Cafe", "address": "London"})
db.rest.insert({"restno": 2, "restname": "Rock A Feller Bar and Grill", "address": "Aberdeen"})
db.rest.insert({"restno": 3, "restname": "Empire State Pizza", "address": "Wells"})
db.rest.insert({"restno": 4, "restname": "Pizza Rat's Pizzaria", "address": "York"})

db.emp.insert({"empno": 1, "name": "Anton", "age": 55, "job": "President", "hiredate": "2021-11-17", "salary": 5000, "yearReward": 0, "restno": 1})
db.emp.insert({"empno": 2, "name": "Blake", "age": 32, "job": "Manager", "hiredate": "2021-05-01", "salary": 2850, "yearReward": 0, "restno": 3})
db.emp.insert({"empno": 3, "name": "Clark", "age": 20, "job": "Manager", "hiredate": "2021-06-09", "salary": 2450, "yearReward": 0, "restno": 1})
db.emp.insert({"empno": 4, "name": "Jones", "age": 55, "job": "Manager", "hiredate": "2021-04-02", "salary": 2975, "yearReward": 0, "restno": 2})
db.emp.insert({"empno": 5, "name": "Scott", "age": 23, "job": "Hostess", "hiredate": "2021-04-19", "salary": 3000, "yearReward": 0, "restno": 2})
db.emp.insert({"empno": 6, "name": "Ford", "age": 29, "job": "Hostess", "hiredate": "2021-03-12", "salary": 3000, "yearReward": 0, "restno": 2})
db.emp.insert({"empno": 7, "name": "Smith", "age": 34, "job": "Waitstaff", "hiredate": "2020-12-17", "salary": 800, "yearReward": 0, "restno": 2})
db.emp.insert({"empno": 8, "name": "Allen", "age": 42, "job": "Chef", "hiredate": "2021-02-20", "salary": 1600, "yearReward": 0, "restno": 3})
db.emp.insert({"empno": 9, "name": "Ward", "age": 52, "job": "Chef", "hiredate": "2021-02-22", "salary": 1250, "yearReward": 0, "restno": 3})
db.emp.insert({"empno": 10, "name": "Martin", "age": 37, "job": "Chef", "hiredate": "2021-09-28", "salary": 1250, "yearReward": 0, "restno": 3})
db.emp.insert({"empno": 11, "name": "Turner", "age": 61, "job": "Chef", "hiredate": "2021-09-08", "salary": 1500, "yearReward": 0, "restno": 3})
db.emp.insert({"empno": 12, "name": "Adams", "age": 37, "job": "Waitstaff", "hiredate": "2027-05-23", "salary": 1100, "yearReward": 0, "restno": 2})
db.emp.insert({"empno": 13, "name": "James", "age": 41, "job": "Waitstaff", "hiredate": "2021-03-12", "salary": 950, "yearReward": 0, "restno": 3})
db.emp.insert({"empno": 14, "name": "Miller", "age": 38, "job": "Waitstaff", "hiredate": "2022-01-23", "salary": 1300, "yearReward": 0, "restno": 4})

----------------
-- Работа с созданной базой
----------------

-- Выведем содержимое базы
db.rest.find()
db.emp.find()

-- Выведем только шеф-поваров
db.emp.find({job:"Chef"})

-- Средний возраст сотрудников
db.emp.aggregate({
  "$group": {
    "_id": null,
    "avg_age": {"$avg": "$age"}
  }
})

-- Список всех должностей (уникально)
db.emp.distinct("job")

-- Добавим некоторым работникам поле, показывающее, получит ли работник премию в этом году
-- Рабоник получает премию, если он "Waitstaff" и устроился на работу после начала 2022 года
db.emp.update({$and: [  {"job": "Waitstaff"}, {"hiredate": {$gte : "2022-01-01"}}]}, {$set: {yearReward : 1}}, {multi:true})

-- Посчитаем количество тех, кто получит премию
db.emp.count({yearReward: 1})

-- Проверим вручную - посмотрим всех "Waitstaff"
db.emp.find({"job": "Waitstaff"}, {_id: 0, name: 1, hiredate: 1, yearReward: 1})

-- Все работники, которые работают в ресторане, содержащем в названии "Pizza"
-- Сортировка по имени

--    Вспомогательный массив для возможности вывода только значений имен
var result = []

--   Запрос
db.emp.aggregate([
    {
        $lookup:
        {
            from: "rest",
            localField: "restno",
            foreignField: "restno",
            as: "restaurant"
        }
   },
   {
       $match:
       {
           "restaurant.restname":{$regex:".*Pizza.*"}
       }
    },
    {
        "$project": {
        "_id": 0,
        "name": 1
    }},
    { "$sort": { "name": 1 }
    }
]).forEach(function(u) { result.push(u.name) })

--   Вывести имена, которые попали в вспомогательный массив
result

-- Все работники, имеющие нечетную сумму зарплаты
db.emp.find({"salary": {$not: {$mod: [2,0]}}})

-- Удалим коллекции
db.rest.drop()
db.emp.drop()
