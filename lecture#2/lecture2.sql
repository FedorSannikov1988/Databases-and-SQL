/* Отработка материала лекции # 2 */

CREATE DATABASE lesson_two;

/*
в чем разница между двумя командами ?
CREATE SCHEMA `lesson_2`;
и
CREATE DATABASE lesson_2;
*/

SHOW databases;

USE lesson_two;

CREATE TABLE `Buyer`
(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`date_birt` DATE,
`first_name` VARCHAR(20),
`last_name` VARCHAR(20),
`mobile_phone` VARCHAR(20) 
);

CREATE TABLE `Orders`
(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`buyer_id` INT,
`amount` INT,
`count_order` INT,
`manufacter` VARCHAR(45),
-- Устанавливаем внешний ключ
FOREIGN KEY (buyer_id) 
REFERENCES Buyer(id)
);

/*
удаление базы данных:
DROP DATABASE Test;

удаление таблицы:
DROP TABLE Test;
*/

/*
переименование таблицы:
RENAME TABLE buyer TO customer; 
*/

RENAME TABLE buyer TO customer;
RENAME TABLE customer TO buyer;

INSERT Buyer (date_birt, first_name,last_name,mobile_phone)
VALUES
("2023-01-01", "Михаил", "Меркушов", "+7-999-888-77-66"), 	-- id = 1
("2022-12-31", "Сергей", "Сергеев", "60-70-80"),			-- id = 2
("2022-12-30", "Том", "Круз", "80-70-80"), 					-- id = 3
("2022-01-02", "Филл", "Поляков", "+7-999-888-77-55"); 		-- id = 4

/*
или

нужно указывать PRIMARY KEY несмотря на AUTO_INCREMENT !
по другому не получится 
*/

INSERT Buyer
VALUES
(1, "2023-01-01", "Михаил", "Меркушов", "+7-999-888-77-66"), 
(2, "2022-12-31", "Сергей", "Сергеев", "60-70-80"),
(3, "2022-12-30", "Том", "Круз", "80-70-80"),
(4, "2022-01-02", "Филл", "Поляков", "+7-999-888-77-55");

/*
Для понимания какие поля я заполняю:
CREATE TABLE `Orders`
(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`buyer_id` INT,
`amount` INT,
`count_order` INT,
`manufacter` VARCHAR(45),
-- Устанавливаем внешний ключ
FOREIGN KEY (buyer_id) 
REFERENCES Buyer(id)
);
*/

INSERT Orders (buyer_id, amount, count_order, manufacter)
VALUES
(1, 1000, 3, "Ягодки"),		-- Первый заказ из "Покупатели" по id = 1 (Меркушов Михал)
(1, 400 , 2, "Амазон"),		-- Второй заказ из "Покупатели" по id = 2 (Меркушов Михал)
(2, 1200 , 5, "Амазон"),
(3, 2000 , 1, "Ягодки"),
(4, 5000 , 4, "Ягодки");

SELECT *
FROM Orders, Buyer
WHERE Orders.buyer_id = Buyer.id;

SELECT Buyer.first_name, Buyer.last_name, Buyer.id, Orders.buyer_id, Orders.amount, Orders.count_order
FROM Orders, Buyer
WHERE Orders.buyer_id = Buyer.id;

-- Посчитаем чек по заказу. Для этого умножаю количество на цену:
SELECT amount * count_order
FROM Orders;

SELECT amount * count_order AS result -- присвоили псевдоним result 
FROM Orders;

/*
или
*/

SELECT amount * count_order result -- Псевдоним - result 
FROM Orders;

/*
Псевдоним таблицы:
*/

SELECT B.first_name, B.id, O.buyer_id, O.amount
FROM Orders AS O, Buyer AS B
WHERE O.buyer_id = B.id;

/*
или
*/

SELECT B.first_name, B.id, O.buyer_id, O.amount
FROM Orders O, Buyer B
WHERE O.buyer_id = B.id;

UPDATE Orders
SET amount = amount * 0.75;

SELECT amount AS new_amount
FROM Orders;

TRUNCATE Orders; -- Удаляет все записи из таблицы Orders

SELECT *
FROM Orders;

UPDATE Orders
SET amount = amount * 0.50
WHERE count_order >= 4; -- ИЛИ WHERE count_order > 3

SELECT amount new_amount, id
FROM Orders;

INSERT Buyer (date_birt, first_name,last_name,mobile_phone)
VALUES
("2023-01-01", "Тестовый", "Пользователь", "+7-999-888-77-66");
-- Добавили клиента

SELECT *
FROM Buyer;

DELETE FROM Buyer
WHERE first_name='Тестовый';
-- Удалили строчку со значением

SELECT amount, count_order 
FROM Orders
WHERE amount > 1500 AND manufacter = "Ягодки";

ALTER TABLE Orders
ADD COLUMN `status` INT AFTER `count_order`;

SELECT *
FROM Orders;

UPDATE Orders
SET `status` = RAND();

SELECT status, -- Перед "CASE" ставится запятая, после перечисления столбцов
  CASE WHEN status IS TRUE THEN 'заказ оплачен'
  ELSE 'оплатите заказ' 
  END AS message
FROM Orders;

/*
или
*/

SELECT status, -- Перед "CASE" ставится запятая, после перечисления столбцов
  CASE WHEN status = 1 THEN 'заказ оплачен'
  ELSE 'оплатите заказ' 
  END AS message
FROM Orders;

-- Представьте,что мы страхуем заказы со средним чеком от 3000 включительно.
-- Сообщим клиентам о наличии или отсутствии страховки
SELECT status, amount, count_order, manufacter,-- Перед "IF" тоже ставится запятая
    IF(amount * count_order >= 3000, 'Cтраховка включена в стоимость', 'Страховка оплачивается отдельно') AS info_message
FROM Orders;