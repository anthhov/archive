-- Таблица описывающая модель и тип транспорта, являющегося основой боевой машины
SELECT O1_BattleCar_ID AS Battle_Car_Number, O1_Car.Name AS Model, O1_Car.Type AS Type
FROM O1_BattleCar, O1_Car
WHERE O1_BattleCar.O1_Car_ID = O1_Car.O1_Car_ID

-- Таблица всех моделей транспорта и соответствующих каждой модели боевых машин
SELECT O1_BattleCar_ID AS Battle_Car_ID, O1_Car.Name AS Model, O1_Car.Type AS Type
FROM O1_BattleCar
RIGHT JOIN O1_Car ON O1_BattleCar.O1_Car_ID = O1_Car.O1_Car_ID

-- Таблица всех сделок со связью продавец-покупатель у каждой
SELECT DISTINCT O1_Deal_ID, O1_Seller.Name AS Seller, O1_Customer.Name AS Customer
FROM O1_Deal, O1_Seller, O1_Customer
WHERE O1_Deal.O1_Seller_ID = O1_Seller.O1_Seller_ID AND
O1_Deal.O1_Customer_ID = O1_Customer.O1_Customer_ID

-- Выводит количество проданных в сделке боевых машин и количество оставшихся на складе машин такой марки (боевая машина = обычная машина какой-то макри + набор разного оружия на ней или его отсутсвие)
SELECT DISTINCT O1_Deal.O1_Deal_ID AS Deal, O1_Deal.Quantity AS Selled_Quantity, O1_Car.Quantity_In_Stock AS Actual_Quantity
FROM O1_Deal, O1_Car, O1_BattleCar
WHERE O1_Deal.O1_BattleCar_ID = O1_BattleCar.O1_BattleCar_ID AND
O1_BattleCar.O1_Car_ID = O1_Car.O1_Car_ID

-- Таблица описывающая вооружение каждой боевой машины + имеющееся на складе оружие, которое нигде не задействованно
SELECT O1_BattleCar.O1_BattleCar_ID AS Battle_Car_ID, O1_Weapon.Name AS Weapon
FROM O1_BattleCar
FULL JOIN O1_BattleCar_Equipment ON O1_BattleCar.O1_BattleCar_ID = O1_BattleCar_Equipment.O1_BattleCar_ID
FULL JOIN O1_Weapon ON O1_BattleCar_Equipment.O1_Weapon_ID = O1_Weapon.O1_Weapon_ID
