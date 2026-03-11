-- Список всех боевых машин, количесвто которых на складе больше 20 (по убыванию количества)
SELECT Name, Quantity_In_Stock FROM O1_Car WHERE Quantity_In_Stock > 20 ORDER BY Quantity_In_Stock DESC

-- Все покупатели с непустым адресом
SELECT Name FROM O1_Customer WHERE Encrypted_Address IS NOT NULL AND Encrypted_Address != ''

-- Все покупатели у которых в имени есть 'John'
SELECT * FROM O1_Customer WHERE Name LIKE 'John%';

-- Продавцы, у которых есть сделка со стоимостью боевой машины от 50000 до 150000 $
SELECT DISTINCT O1_Seller_ID FROM O1_Deal WHERE O1_Car_Price BETWEEN 50000 AND 150000 ORDER BY O1_Seller_ID

-- Количество всех типов танков на складе (поименно)
SELECT Name, Quantity_In_Stock FROM O1_Car WHERE Type IN ('Light Tank', 'Main Battle Tank');

-- Количество всех сделок
SELECT COUNT (O1_Deal_ID) FROM O1_Deal
