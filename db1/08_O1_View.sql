-- Рейтинг клиентов
CREATE VIEW O1_Customer_Rating (Customer_Name, Order_Count)
AS SELECT O1_Customer_ID, count(*) AS Order_Count FROM O1_Deal GROUP BY O1_Customer_ID

-- Примеры использования
SELECT Customer_Name FROM O1_Customer_Rating WHERE Order_Count > 1
SELECT Customer_Name, Order_Count FROM O1_Customer_Rating ORDER BY Order_Count

-- Сделки, которые будут закрыты в этом году, и доход от них
CREATE VIEW O1_This_Year_Deals(Deal_ID, Profit)
SELECT O1_Deal_ID, O1_Car_Price*Quantity AS Profit FROM O1_Deal
WHERE YEAR(Work_Done_Date) = YEAR(getdate())

-- Примеры использования
-- Выбрать продавцов для вручения ежегодной премии (т.е. чьи сделки закрыты в этом году)
SELECT Name, Profit*0.05 AS Award FROM O1_Seller, O1_Deal, O1_This_Year_Deals WHERE
O1_Seller.O1_Seller_ID = O1_Deal.O1_Seller_ID
AND O1_Deal_ID IN  (SELECT O1_This_Year_Deals.Deal_ID FROM O1_This_Year_Deals)
-- Выбрать главные сделки этого года
SELECT TOP 3 * FROM O1_This_Year_Deals

-- Вооружение всех боевых машин + имеющееся на складе оружие
CREATE VIEW O1_Car_Weapon_Connections AS
SELECT O1_BattleCar.O1_BattleCar_ID AS Battle_Car_ID, O1_Weapon.Name AS Weapon
FROM O1_BattleCar
FULL JOIN O1_BattleCar_Equipment ON O1_BattleCar.O1_BattleCar_ID = O1_BattleCar_Equipment.O1_BattleCar_ID
FULL JOIN O1_Weapon ON O1_BattleCar_Equipment.O1_Weapon_ID = O1_Weapon.O1_Weapon_ID

-- Примеры использования
-- Все оружие, стоящее на боевой машине с ИД 1
SELECT Weapon FROM O1_Car_Weapon_Connections WHERE Battle_Car_ID = 1
-- Все боевые машины на которых стоит 'DP Machine Gun' + их количество
SELECT Battle_Car_ID AS BattleCar_With_This_Gun, count(*) AS Amount_Of_These_Guns FROM O1_Car_Weapon_Connections WHERE Weapon = 'DP Machine Gun' GROUP BY Battle_Car_ID
