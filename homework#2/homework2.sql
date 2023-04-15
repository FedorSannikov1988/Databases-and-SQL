/*
1. Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными
*/

-- создаем базу данных
CREATE DATABASE homework_two;

-- подключаемся к базе данных
USE homework_two;

-- создаем таблицу
CREATE TABLE `sales`
(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`order_date` DATE NOT NULL,
`count_product` INT NOT NULL
);

/*
Пояснение к выбранным типам данных в таблице `sales`:
DATE NOT NULL - если заказ создан, он не может быть без даты создания
`count_product` INT NOT NULL  - если заказ создан, количество товара
в заказе не может "не сущесвовать"
*/

-- заполняем таблицу данными
INSERT INTO `sales` (`order_date`, `count_product`)
VALUES
('2022-01-01', '156'),
('2022-01-02', '180'),
('2022-01-03', '21'),
('2022-01-04', '124'),
('2022-01-05', '341');

/*
добавим 1-ну запись с текущей датой
используем CURRENT_DATE()
*/

-- добавлям в таблицу значение с 'сегодняшней датой':
INSERT INTO `sales` (`order_date`, `count_product`)
VALUES 
(CURRENT_DATE(), '500');

-- смотрим что получилось:
SELECT * 
FROM `sales`;

/*
2. Для данных таблицы “sales” укажите тип заказа в зависимости от кол-ва : 
меньше 100	-		Маленький заказ
от 100 до 300	-	Средний заказ
больше 300		-	Большой заказ
*/

SELECT id,
CASE 
WHEN count_product < 100 then "Маленький заказ"
WHEN count_product >= 100 AND count_product <= 300 then "Средний заказ"
WHEN count_product > 300 then "Большой заказ"
END AS "Тип заказа"
FROM `sales`;

/*
или более информативно (выводим больше полей):
*/

SELECT id, order_date, count_product,
CASE 
WHEN count_product < 100 then "Маленький заказ"
WHEN count_product >= 100 AND count_product <= 300 then "Средний заказ"
WHEN count_product > 300 then "Большой заказ"
END AS "Тип заказа"
FROM `sales`;

/*
3. Создайте таблицу “orders”, заполните ее значениями.
Выберите все заказы. В зависимости от поля order_status выведите столбец full_order_status:
OPEN – «Order is in open state» ; CLOSED - «Order is closed»; CANCELLED -  «Order is cancelled»
*/

CREATE TABLE `orders`
(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`employee_id` VARCHAR(5) NOT NULL,
`amount` DECIMAL(10,2) NOT NULL,
`order_status` VARCHAR(9) NOT NULL
);

/*
Пояснение к выбранным типам данных в таблице `orders`
`employee_id` VARCHAR(5) NOT NULL - VARCHAR потому что присутсвует буква "е" 5-ть символов для "запаса" максимальное значение будет равно: е9999
`amount` DECIMAL(10, 2) NOT NULL - 10-ть значущих цифр до запятой и 2-е после запятой (исходя из записи в примере больше 2х цифр после запятой не нужно)
`order_status` VARCHAR(9) NOT NULL - VARCHAR(9) потому что 9-ть символов в слове CANCELLED (это самое длинное из трех кодовых слов: "OPEN" , "CLOSED" и "CANCELLED")
*/

INSERT INTO `orders` (`employee_id`, `amount`, `order_status`)
VALUES
('e03', '15.00', 'OPEN'),
('e01', '25.50', 'OPEN'),
('e05', '100.70', 'CLOSED'),
('e02', '22.18', 'OPEN'),
('e04', '9.50', 'CANCELLED');

-- смотрим что получилось
SELECT * 
FROM `orders`;

/*
В зависимости от поля order_status выведите столбец full_order_status:
OPEN – «Order is in open state» ; CLOSED - «Order is closed»; CANCELLED -  «Order is cancelled»
*/

/*
SELECT `id`, `employee_id`, `amount`, `order_status`,
или так
*/
SELECT *,
CASE `order_status`
WHEN 'OPEN' then "Order is in open state"
WHEN 'CLOSED' then "Order is closed"
WHEN 'CANCELLED' then "Order is cancelled"
ELSE "erroneous data !"
END AS "full_order_status"
FROM `orders`;

-- или

SELECT `id`, `employee_id`, `amount`, `order_status`,
IF (`order_status` = 'OPEN', "Order is in open state" , 
IF (`order_status` = 'CLOSED', "Order is closed", "Order is cancelled")) 
AS "full_order_status"
FROM `orders`;

-- или

SELECT `id`, `employee_id`, `amount`, `order_status`,
IF (`order_status` = 'OPEN', "Order is in open state", 
IF (`order_status` = 'CLOSED', "Order is closed", 
IF (`order_status` = 'CANCELLED', "Order is cancelled", "erroneous data !"))) 
AS "full_order_status"
FROM `orders`;

/*
4. Чем 0 отличается от NULL? Напишите ответ в комментарии 
к домашнему заданию на платформе

0 - это конкретное занчение которе может пренаждлежать 
различным типам даннх таких как INT , DOUBLE , FLOAT, VARCHAR(1) и т.д.
Иными словами 0 это всетаки занчение (ячейка таблицы не пуста).

NULL - означает что в ячейке таблицы отсутсвует какое либо значание . 
Буквально некакого значения не задано .
*/