---------------------------------------------------------------
-- Создание таблиц и PK
---------------------------------------------------------------
CREATE TABLE O1_Customer(
    O1_Customer_ID         INTEGER        NOT NULL,
    Name                   VARCHAR(50)    NOT NULL,
    Encrypted_Phone        VARCHAR(30)    NOT NULL,
    Encrypted_Address      VARCHAR(150)
CONSTRAINT O1_Customer_PK PRIMARY KEY (O1_Customer_ID)
)
;
CREATE TABLE O1_Seller(
    O1_Seller_ID           INTEGER        NOT NULL,
    Name                   VARCHAR(50)    NOT NULL,
CONSTRAINT O1_Seller_PK PRIMARY KEY (O1_Seller_ID)
)
;
CREATE TABLE O1_Deal(
    O1_Deal_ID             INTEGER        NOT NULL,
    O1_Seller_ID           INTEGER        NOT NULL,
    O1_Customer_ID         INTEGER        NOT NULL,
    Work_Start_Date        DATE           NOT NULL,
    Work_Done_Date         DATE           NOT NULL,
    O1_BattleCar_ID        INTEGER        NOT NULL,
    O1_Car_Price           INTEGER        NOT NULL,
    Quantity               INTEGER        NOT NULL,
CONSTRAINT O1_Deal_PK PRIMARY KEY (O1_Deal_ID)
)
;
CREATE TABLE O1_BattleCar(
    O1_BattleCar_ID        INTEGER        NOT NULL,
    O1_Car_ID              INTEGER        NOT NULL,
CONSTRAINT O1_BattleCar_PK PRIMARY KEY (O1_BattleCar_ID)
)
;
CREATE TABLE O1_Car(
    O1_Car_ID              INTEGER        NOT NULL,
    Name                   VARCHAR(50)    NOT NULL,
    Type                   VARCHAR(50)    NOT NULL,
    Quantity_In_Stock      INTEGER        NOT NULL,
    Characteristics        VARCHAR(500)   NOT NULL,
CONSTRAINT O1_Car_PK PRIMARY KEY (O1_Car_ID)
)
;
CREATE TABLE O1_Weapon(
    O1_Weapon_ID           INTEGER        NOT NULL,
    Name                   VARCHAR(50)    NOT NULL,
    Quantity_In_Stock      INTEGER        NOT NULL,
    Characteristics        VARCHAR(500)   NOT NULL,
CONSTRAINT O1_Weapon_PK PRIMARY KEY (O1_Weapon_ID)
)
;
CREATE TABLE O1_BattleCar_Equipment(
    O1_BattleCar_ID        INTEGER        NOT NULL,
    O1_Weapon_ID           INTEGER        NOT NULL
)
;

---------------------------------------------------------------
-- Создание FK 
---------------------------------------------------------------
ALTER TABLE O1_Deal ADD CONSTRAINT FK_O1_Deal_O1_Customer
    FOREIGN KEY (O1_Customer_ID)
    REFERENCES O1_Customer(O1_Customer_ID)
;
ALTER TABLE O1_Deal ADD CONSTRAINT FK_O1_Deal_O1_Seller
    FOREIGN KEY (O1_Seller_ID)
    REFERENCES O1_Seller(O1_Seller_ID)
;
ALTER TABLE O1_Deal ADD CONSTRAINT FK_O1_Deal_O1_BattleCar
    FOREIGN KEY (O1_BattleCar_ID)
    REFERENCES O1_BattleCar(O1_BattleCar_ID)
;
ALTER TABLE O1_BattleCar ADD CONSTRAINT FK_O1_Car
    FOREIGN KEY (O1_Car_ID)
    REFERENCES O1_Car(O1_Car_ID)
;
ALTER TABLE O1_BattleCar_Equipment ADD CONSTRAINT FK_BattleCar_Equipment_O1_BattleCar
    FOREIGN KEY (O1_BattleCar_ID)
    REFERENCES O1_BattleCar(O1_BattleCar_ID)
;
ALTER TABLE O1_BattleCar_Equipment ADD CONSTRAINT FK_BattleCar_Equipment_O1_Weapon
    FOREIGN KEY (O1_Weapon_ID)
    REFERENCES O1_Weapon(O1_Weapon_ID)
;

---------------------------------------------------------------
-- Тестовые данные
---------------------------------------------------------------
INSERT INTO O1_Customer(O1_Customer_ID, Name, Encrypted_Phone, Encrypted_Address) VALUES (1, 'John Romero', 'LCFGxE9KaTIrEN02J8fZ', '');
INSERT INTO O1_Customer(O1_Customer_ID, Name, Encrypted_Phone) VALUES (2, 'Lee', 'M8sHrIxSt22c92Ow4b06');
INSERT INTO O1_Customer(O1_Customer_ID, Name, Encrypted_Phone, Encrypted_Address) VALUES (3, 'Spider', 'HZREc5roa6r4FzUI0ysk', 'GlagKHyvPhGef77K7mmrxb7Z66MrwD6JmNXUXfoT');
INSERT INTO O1_Customer(O1_Customer_ID, Name, Encrypted_Phone, Encrypted_Address) VALUES (4, 'John_Carmack', 'GmVFr3mYGKNm8v9WQIRi', 'y4lJG318tgLOevbNMa5Xr7goV2Fg8JJNq4whljUO');
INSERT INTO O1_Customer(O1_Customer_ID, Name, Encrypted_Phone, Encrypted_Address) VALUES (5, 'Terror', 'VSrTi1WqMr2TKXLaSVHb', 'r5sUZcK5PKQvHoMEHnNA4O0jFzEz0OglytCxqO3V');
INSERT INTO O1_Customer(O1_Customer_ID, Name, Encrypted_Phone, Encrypted_Address) VALUES (6, 'Mad Max', 'fP42Q39jTOihyTejL8MY', 'F5vccbTRbS7EbkPGzwgDPH9giHbbCq7Hv2577PgC');
INSERT INTO O1_Customer(O1_Customer_ID, Name, Encrypted_Phone, Encrypted_Address) VALUES (7, 'Stone', '5hTwS1Cez7PIIa9IIRsv', 'BV7jVF4gPTIc2Vjl4BgYQfG9yw6Gvnka1X6SBAlg');

INSERT INTO O1_Seller(O1_Seller_ID, Name) VALUES (1, 'Derrick Gutierrez');
INSERT INTO O1_Seller(O1_Seller_ID, Name) VALUES (2, 'Jo Spencer');
INSERT INTO O1_Seller(O1_Seller_ID, Name) VALUES (3, 'Heidi Pittman');
INSERT INTO O1_Seller(O1_Seller_ID, Name) VALUES (4, 'Daisy Stanley');
INSERT INTO O1_Seller(O1_Seller_ID, Name) VALUES (5, 'Alex Tur');

INSERT INTO O1_Car(O1_Car_ID, Name, Type, Quantity_In_Stock, Characteristics) VALUES (1, 'AMC 34', 'Light Tank', 10, 'Weight: 9.7 tonnes
Length: 3.98 m
Width: 2.07 m
Height: variable according to turret type;
Crew: two with the APX1 turret; three with the APX2
Armor: 20 mm
Engine: 7.125 litre V-8 120 hp
Speed: 40 km/h');
INSERT INTO O1_Car(O1_Car_ID, Name, Type, Quantity_In_Stock, Characteristics) VALUES (2, 'Petit Véhicule Protégé', 'Armoured 4-wheel drive vehicle', 20, 'Weight: 4,390 kg
Length: 4,599 mm
Width: 2,277 mm
Height: 2,170 mm
Crew: 2 to 4');
INSERT INTO O1_Car(O1_Car_ID, Name, Type, Quantity_In_Stock, Characteristics) VALUES (3, 'C1 Ariete', 'Main Battle Tank', 30, 'Weight: 54 tonnes
Length: 9.52 m
Width: 3.61 m
Height: 2.45 m
Crew: 4
Armor: Classified, laminated steel/composite
Speed: 70 km/h');
INSERT INTO O1_Car(O1_Car_ID, Name, Type, Quantity_In_Stock, Characteristics) VALUES (4, 'Eland Mk7', 'Armoured Car', 24, 'Weight: 6 tonnes
Length: 5.12 m
Width: 2.01 m
Height: 2.5 m
Crew: 3 (commander, driver, gunner
Engine: Chevrolet 153 2.5 l (150 in3) inline 4-cylinder water-cooled petrol
Transmission: 6-speed manual constant mesh[8]
Speed: 100 km/h');
INSERT INTO O1_Car(O1_Car_ID, Name, Type, Quantity_In_Stock, Characteristics) VALUES (5, 'GAZ-3937', 'Infantry Mobility Vehicle', 45, 'Weight: 7,500 kg
Length: 5.8 m
Width: 2.6 m
Height: 2.6 m
Crew: 2
Armor: withstands small arms fire and enemy mines and shells shrapnel
Engine: diesel 175 hp
Speed: 120 km/h');

INSERT INTO O1_Weapon(O1_Weapon_ID, Name, Quantity_In_Stock, Characteristics) VALUES (1, 'KPV 14.5×114 mm machine gun', 2, 'Weight: 49 kg
Length: 1,980 mm
Barrel length: 1,346 mm
Width: 162mm
Height: 225mm
O1_Cartridge: 14.5×114 mm
Caliber: 14.5 mm
Action: Short recoil operation
Rate of fire: 600 rpm');
INSERT INTO O1_Weapon(O1_Weapon_ID, Name, Quantity_In_Stock, Characteristics) VALUES (2, 'M2HB heavy machine gun', 10, 'Weight: 38 kg
Length: 1,654 mm
Barrel length: 1,143 mm
O1_Cartridge: .50 BMG (12.7×99mm NATO)
Action: Short recoil-operated
Rate of fire: 450–600 rounds/min');
INSERT INTO O1_Weapon(O1_Weapon_ID, Name, Quantity_In_Stock, Characteristics) VALUES (3, 'DP Machine Gun', 11, 'Weight: 9.12 kg
Length: 1,270 mm
Barrel length: 604 mm
O1_Cartridge: 7.62×54mmR
Caliber: 7.62 mm
Action: Gas-Operated, flapper-locked
Rate of fire: 550 rpm');
INSERT INTO O1_Weapon(O1_Weapon_ID, Name, Quantity_In_Stock, Characteristics) VALUES (4, 'Kjellman machine gun', 10, 'O1_Cartridge: 6.5×55mm
Caliber: 6.5 mm
Action: Recoil operated, cam-locked bolt
Feed system: Hopper
Sights: Iron');

INSERT INTO O1_BattleCar(O1_BattleCar_ID, O1_Car_ID) VALUES (1, 1);
INSERT INTO O1_BattleCar(O1_BattleCar_ID, O1_Car_ID) VALUES (2, 1);
INSERT INTO O1_BattleCar(O1_BattleCar_ID, O1_Car_ID) VALUES (3, 1);
INSERT INTO O1_BattleCar(O1_BattleCar_ID, O1_Car_ID) VALUES (4, 2);
INSERT INTO O1_BattleCar(O1_BattleCar_ID, O1_Car_ID) VALUES (5, 3);
INSERT INTO O1_BattleCar(O1_BattleCar_ID, O1_Car_ID) VALUES (6, 2);
INSERT INTO O1_BattleCar(O1_BattleCar_ID, O1_Car_ID) VALUES (7, 4);
INSERT INTO O1_BattleCar(O1_BattleCar_ID, O1_Car_ID) VALUES (8, 4);
INSERT INTO O1_BattleCar(O1_BattleCar_ID, O1_Car_ID) VALUES (9, 2);

-- Для отладки добавил 1 боевую машину без установленного оружия и 1 оружие, которое не стоит ни на какой боевой машине
INSERT INTO O1_Weapon(O1_Weapon_ID, Name, Quantity_In_Stock, Characteristics) VALUES (5, 'BFG', 4, 'nothing');
INSERT INTO O1_BattleCar(O1_BattleCar_ID, O1_Car_ID) VALUES (10, 1);


INSERT INTO O1_Deal(O1_Deal_ID, O1_Seller_ID, O1_Customer_ID, Work_Start_Date, Work_Done_Date, O1_BattleCar_ID, O1_Car_Price, Quantity) VALUES (1, 4, 2, '2017-12-01', '2017-12-24', 1, 20000, 3);
INSERT INTO O1_Deal(O1_Deal_ID, O1_Seller_ID, O1_Customer_ID, Work_Start_Date, Work_Done_Date, O1_BattleCar_ID, O1_Car_Price, Quantity) VALUES (2, 1, 7, '2018-10-21', '2019-12-15', 8, 40000, 2);
INSERT INTO O1_Deal(O1_Deal_ID, O1_Seller_ID, O1_Customer_ID, Work_Start_Date, Work_Done_Date, O1_BattleCar_ID, O1_Car_Price, Quantity) VALUES (3, 5, 5, '2018-02-28', '2020-01-23', 8, 100000, 20);
INSERT INTO O1_Deal(O1_Deal_ID, O1_Seller_ID, O1_Customer_ID, Work_Start_Date, Work_Done_Date, O1_BattleCar_ID, O1_Car_Price, Quantity) VALUES (4, 4, 7, '2017-10-10', '2017-12-09', 9, 2000000, 1);
INSERT INTO O1_Deal(O1_Deal_ID, O1_Seller_ID, O1_Customer_ID, Work_Start_Date, Work_Done_Date, O1_BattleCar_ID, O1_Car_Price, Quantity) VALUES (5, 2, 4, '2018-12-01', '2018-12-16', 7, 450000, 10);
INSERT INTO O1_Deal(O1_Deal_ID, O1_Seller_ID, O1_Customer_ID, Work_Start_Date, Work_Done_Date, O1_BattleCar_ID, O1_Car_Price, Quantity) VALUES (6, 3, 3, '2017-12-01', '2021-05-17', 2, 45000, 4);
INSERT INTO O1_Deal(O1_Deal_ID, O1_Seller_ID, O1_Customer_ID, Work_Start_Date, Work_Done_Date, O1_BattleCar_ID, O1_Car_Price, Quantity) VALUES (7, 3, 4, '2017-12-01', '2022-12-03', 5, 22910, 1);
INSERT INTO O1_Deal(O1_Deal_ID, O1_Seller_ID, O1_Customer_ID, Work_Start_Date, Work_Done_Date, O1_BattleCar_ID, O1_Car_Price, Quantity) VALUES (8, 4, 1, '2018-12-01', '2024-02-25', 6, 20234, 1);
INSERT INTO O1_Deal(O1_Deal_ID, O1_Seller_ID, O1_Customer_ID, Work_Start_Date, Work_Done_Date, O1_BattleCar_ID, O1_Car_Price, Quantity) VALUES (9, 5, 1, '2020-05-11', '2020-12-14', 4, 43532, 2);
INSERT INTO O1_Deal(O1_Deal_ID, O1_Seller_ID, O1_Customer_ID, Work_Start_Date, Work_Done_Date, O1_BattleCar_ID, O1_Car_Price, Quantity) VALUES (10, 2, 6, '2020-02-14', '2021-02-04', 3, 20234, 5);
INSERT INTO O1_Deal(O1_Deal_ID, O1_Seller_ID, O1_Customer_ID, Work_Start_Date, Work_Done_Date, O1_BattleCar_ID, O1_Car_Price, Quantity) VALUES (11, 5, 5, '2017-01-25', '2017-12-24', 7, 60334, 2);
INSERT INTO O1_Deal(O1_Deal_ID, O1_Seller_ID, O1_Customer_ID, Work_Start_Date, Work_Done_Date, O1_BattleCar_ID, O1_Car_Price, Quantity) VALUES (12, 3, 2, '2022-11-11', '2022-12-11', 2, 23430, 1);

INSERT INTO O1_BattleCar_Equipment(O1_BattleCar_ID, O1_Weapon_ID) VALUES (1, 1);
INSERT INTO O1_BattleCar_Equipment(O1_BattleCar_ID, O1_Weapon_ID) VALUES (1, 2);
INSERT INTO O1_BattleCar_Equipment(O1_BattleCar_ID, O1_Weapon_ID) VALUES (2, 3);
INSERT INTO O1_BattleCar_Equipment(O1_BattleCar_ID, O1_Weapon_ID) VALUES (2, 1);
INSERT INTO O1_BattleCar_Equipment(O1_BattleCar_ID, O1_Weapon_ID) VALUES (2, 3);
INSERT INTO O1_BattleCar_Equipment(O1_BattleCar_ID, O1_Weapon_ID) VALUES (3, 4);
INSERT INTO O1_BattleCar_Equipment(O1_BattleCar_ID, O1_Weapon_ID) VALUES (3, 2);
INSERT INTO O1_BattleCar_Equipment(O1_BattleCar_ID, O1_Weapon_ID) VALUES (4, 1);
INSERT INTO O1_BattleCar_Equipment(O1_BattleCar_ID, O1_Weapon_ID) VALUES (5, 2);
INSERT INTO O1_BattleCar_Equipment(O1_BattleCar_ID, O1_Weapon_ID) VALUES (6, 3);
INSERT INTO O1_BattleCar_Equipment(O1_BattleCar_ID, O1_Weapon_ID) VALUES (7, 2);
INSERT INTO O1_BattleCar_Equipment(O1_BattleCar_ID, O1_Weapon_ID) VALUES (8, 2);
INSERT INTO O1_BattleCar_Equipment(O1_BattleCar_ID, O1_Weapon_ID) VALUES (8, 4);
INSERT INTO O1_BattleCar_Equipment(O1_BattleCar_ID, O1_Weapon_ID) VALUES (9, 4);

---------------------------------------------------------------
-- Удаление таблиц 
---------------------------------------------------------------
/*
DROP TABLE O1_Deal;
DROP TABLE O1_Customer;
DROP TABLE O1_Seller;
DROP TABLE O1_BattleCar_Equipment;
DROP TABLE O1_Weapon;
DROP TABLE O1_BattleCar;
DROP TABLE O1_Car;
*/
