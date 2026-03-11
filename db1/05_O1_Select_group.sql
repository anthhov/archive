-- Таблица моделей машин с количеством боевых машин собранных на основе каждой модели
SELECT O1_Car.Name AS Car_Model, count(*) AS Quantity_Of_BattleCars
FROM O1_Car
JOIN O1_BattleCar ON O1_Car.O1_Car_ID = O1_BattleCar.O1_Car_ID
GROUP BY O1_Car.Name

-- Таблица описывающая количество установленного оружения на каждой боевой машины
SELECT O1_BattleCar.O1_BattleCar_ID AS Battle_Car_ID, count(*) AS Weapon_Quantity
FROM O1_BattleCar
JOIN O1_BattleCar_Equipment ON O1_BattleCar.O1_BattleCar_ID = O1_BattleCar_Equipment.O1_BattleCar_ID
GROUP BY O1_BattleCar.O1_BattleCar_ID

-- Таблица всех продавцов с количеством уникальных покупателей < 3
SELECT a.Seller , count(*) AS Number_Of_Unique_Customers FROM
(SELECT DISTINCT O1_Seller.Name AS Seller, O1_Customer.Name AS Customer
FROM O1_Deal, O1_Seller, O1_Customer
WHERE O1_Deal.O1_Seller_ID = O1_Seller.O1_Seller_ID AND
O1_Deal.O1_Customer_ID = O1_Customer.O1_Customer_ID) a
GROUP BY a.Seller
HAVING count(*) < 3

-- Таблица первых букв имен всех покупателей и количество покупателей с каждой буквой
SELECT LEFT(O1_Customer.Name, 1) AS CustomerNameFirstLetter, count(*) AS CountOfSuchCustomers
FROM O1_Customer
GROUP BY LEFT(O1_Customer.Name, 1)

-- Все модели автомобилей, которые относятся к танкам (Main Battl Tank Tank, Light Tank, ...) + их общее количество на складе
SELECT RIGHT(Type, 4) AS UnitedTanks, sum(Quantity_In_Stock) AS Quantity
FROM O1_Car
WHERE RIGHT(Type, 4) = 'Tank'
GROUP BY RIGHT(Type, 4)
