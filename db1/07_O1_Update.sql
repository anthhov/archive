-- Добавление новых клиентов (2-мя разными способами), сохраняем последовательность нумерации
INSERT INTO O1_Customer(O1_Customer_ID, Name, Encrypted_Phone) VALUES ((SELECT max(O1_Customer_ID) + 1 FROM O1_Customer), 'Jack', 'Q6hHrIxSt22c578f3fsA7')

INSERT INTO O1_Customer(O1_Customer_ID, Name, Encrypted_Phone) 
	SELECT max(O1_Customer_ID) + 1, 'Bear', 'Q6hHrIxSt22c578f3fsA7)' FROM O1_Customer



-- Изменить на 2025-01-01 дедлайн выполнения всех заказов продавца 'Daisy Stanley'
UPDATE O1_Deal SET Work_Done_Date = '2025-01-01' WHERE O1_Seller_ID IN
	(SELECT O1_Seller_ID FROM O1_Seller WHERE Name = 'Daisy Stanley');



-- Удалить все оружие, которое не используется ни в одной боевой машине
-- Для отладки добавил 1 оружие, которое не стоит ни на какой боевой машине
-- INSERT INTO O1_Weapon(O1_Weapon_ID, Name, Quantity_In_Stock, Characteristics) VALUES (5, 'BFG', 4, 'nothing');
DELETE FROM O1_Weapon
	WHERE O1_Weapon_ID NOT IN
		(SELECT O1_Weapon_ID FROM O1_BattleCar_Equipment)



-- Удалить боевую машину, а вместе с ней и сделки, в которых она присутсвует, и записи о стоящем на этой боевой машине оружии
ALTER TABLE O1_BattleCar_Equipment DROP CONSTRAINT FK_BattleCar_Equipment_O1_BattleCar;
ALTER TABLE O1_BattleCar_Equipment ADD CONSTRAINT FK_BattleCar_Equipment_O1_BattleCar FOREIGN KEY (O1_BattleCar_ID)
    REFERENCES O1_BattleCar(O1_BattleCar_ID) ON DELETE CASCADE; 

ALTER TABLE O1_Deal DROP CONSTRAINT FK_O1_Deal_O1_BattleCar;
ALTER TABLE O1_Deal ADD CONSTRAINT FK_O1_Deal_O1_BattleCar FOREIGN KEY (O1_BattleCar_ID)
    REFERENCES O1_BattleCar(O1_BattleCar_ID) ON DELETE CASCADE;

DELETE FROM O1_BattleCar WHERE O1_BattleCar_ID = 1;

-- Для проверки (нигде не должна появится боевая машина с ID = 1)
-- SELECT O1_Deal_ID FROM O1_Deal
-- SELECT O1_Weapon_ID, O1_BattleCar_ID FROM O1_BattleCar_Equipment 