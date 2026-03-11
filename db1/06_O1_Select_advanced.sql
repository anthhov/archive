-- Показать всех клиентов, обслуживающихся теме же продавцами, что и клиент 'Lee'
SELECT DISTINCT O1_Customer.Name
FROM O1_Deal
JOIN O1_Customer ON O1_Deal.O1_Customer_ID = O1_Customer.O1_Customer_ID
WHERE O1_Seller_ID IN
    (SELECT O1_Seller_ID FROM O1_Deal WHERE O1_Customer_ID = 4)

-- Боевые машины с установленным оружием 'KPV 14.5×114 mm machine gun'
SELECT O1_BattleCar.O1_BattleCar_ID
FROM O1_BattleCar
WHERE 'KPV 14.5×114 mm machine gun' = ANY (SELECT O1_Weapon.Name
FROM O1_BattleCar_Equipment, O1_Weapon WHERE
O1_BattleCar.O1_BattleCar_ID = O1_BattleCar_Equipment.O1_BattleCar_ID AND
O1_Weapon.O1_Weapon_ID = O1_BattleCar_Equipment.O1_Weapon_ID)

-- Список зашифрованных номеров телефонов покупателей, которые заключили хотя бы одну сделку с продавцом 'Daisy Stanley'
SELECT Customer_Name, O1_Customer.Encrypted_Phone
FROM O1_Customer, (SELECT O1_Seller.Name AS Seller_Name, O1_Customer.Name AS Customer_Name
FROM O1_Deal, O1_Seller, O1_Customer
WHERE O1_Deal.O1_Seller_ID = O1_Seller.O1_Seller_ID
AND O1_Deal.O1_Customer_ID = O1_Customer.O1_Customer_ID
AND O1_Seller.Name = 'Daisy Stanley') temp1
WHERE O1_Customer.Name = temp1.Customer_Name

-- Список всех задействованных в бизнесе людей
SELECT O1_Customer.Name
FROM O1_Customer
UNION ALL
SELECT O1_Seller.Name
FROM O1_Seller
ORDER BY Name