-- Триггер, который будет после добавления оружия к машине уменьшать количество этого оружия на складе
CREATE TRIGGER Dec_Stock1 ON O1_BattleCar_Equipment FOR INSERT 
AS
	UPDATE O1_Weapon SET Quantity_In_Stock = Quantity_In_Stock - 1 WHERE O1_Weapon_ID IN
    (SELECT O1_Weapon_ID FROM INSERTED)

-- Проверка
SELECT Quantity_In_Stock FROM O1_Weapon WHERE O1_Weapon_ID = 3
SELECT Weapon FROM O1_Car_Weapon_Connections WHERE Battle_Car_ID = 1
INSERT INTO O1_BattleCar_Equipment(O1_BattleCar_ID, O1_Weapon_ID) VALUES (1, 3);
SELECT Quantity_In_Stock FROM O1_Weapon WHERE O1_Weapon_ID = 3
SELECT Weapon FROM O1_Car_Weapon_Connections WHERE Battle_Car_ID = 1

-- Процедура добавления новых машин и оружия на склад
CREATE PROCEDURE AddToStock
@var_stock as varchar(50),
@var_name as varchar(50),
@var_quantity as integer
AS
BEGIN
	IF @var_stock = 'Car'
			UPDATE O1_Car SET Quantity_In_Stock = Quantity_In_Stock + @var_quantity WHERE O1_Car.Name = @var_name;
	IF @var_stock = 'Weapon'
			UPDATE O1_Weapon SET Quantity_In_Stock = Quantity_In_Stock + @var_quantity WHERE O1_Weapon.Name = @var_name;
END

-- Проверка
SELECT Name, Quantity_In_Stock FROM O1_Car WHERE Name = 'AMC 34'
EXECUTE AddToStock @var_name='AMC 34',@var_quantity='5', @var_stock='Car'

CREATE INDEX idx_deal_participants ON O1_Deal (O1_Seller_ID, O1_Customer_ID)
CREATE UNIQUE INDEX idx_deal_participants ON O1_Customer (Name, Encrypted_Phone)

-- Проверка уникального индекса
INSERT INTO O1_Customer(O1_Customer_ID, Name, Encrypted_Phone) VALUES (8, 'Lee2', 'M8sHrIxSt22c92Ow4b06');
INSERT INTO O1_Customer(O1_Customer_ID, Name, Encrypted_Phone) VALUES (9, 'Lee', 'M8sHrIxSt22c92Ow3465');
INSERT INTO O1_Customer(O1_Customer_ID, Name, Encrypted_Phone) VALUES (10, 'Lee', 'M8sHrIxSt22c92Ow4b06');