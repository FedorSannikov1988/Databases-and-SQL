/*
1 Создайте таблицу с мобильными телефонами (mobile_phones), используя графический интерфейс. 
Заполните БД данными. Добавьте скриншот на платформу в качестве ответа на ДЗ.
P.S.: Без графичекого интерфэйса интереснее.
*/

CREATE SCHEMA `homework_one`;

USE homework_one;

CREATE TABLE `mobile_phones` (`mobile_phones_id` INT PRIMARY KEY AUTO_INCREMENT,
							  `product_name` VARCHAR(20),
							  `manufacturer` VARCHAR(20),
							  `product_count` INT,
                              `price` DOUBLE NOT NULL
                              );
                              
/*
`price` DOUBLE NOT NULL - цена не должна быть равна нулю
*/

INSERT INTO `mobile_phones` (`product_name`, `manufacturer`, `product_count`, `price`)
VALUES ('iPhone X', 'Apple', '3', '76000'),
	   ('iPhone 8', 'Apple', '2', '51000'),
       ('Galaxy S9', 'Samsung', '2', '56000'),
	   ('Galaxy S8', 'Samsung', '1', '41000'),
	   ('P20 Pro', 'Huawei', '5', '36000');

/*
2 Выведите название, производителя и цену для товаров, количество которых превышает 2.
*/

SELECT product_name, manufacturer, price 
FROM mobile_phones
WHERE product_count > 2;

/*
3 Выведите весь ассортимент товаров марки/производителя Samsung”.
*/

SELECT product_name, price 
FROM mobile_phones
WHERE manufacturer = 'Samsung';

/*
4 С помощью регулярных выражений найти:
4.1 Товары, в которых есть упоминание "Iphone"
*/

SELECT product_name, manufacturer, price 
FROM mobile_phones 
WHERE product_name like '%iphone%';

/*
или
*/

SELECT product_name, manufacturer, price 
FROM mobile_phones 
WHERE product_name like '%iphone%'  or 
	  manufacturer like '%iphone%';

/*
or и || - или
*/

/*
4.2 Товары, в которых есть упоминание "Samsung"
*/

SELECT product_name, manufacturer, price 
FROM mobile_phones 
WHERE manufacturer like '%samsung%';

/*
или
*/

SELECT product_name, manufacturer, price 
FROM mobile_phones 
WHERE product_name like '%samsung%'  ||
	  manufacturer like '%samsung%';

/*
4.3  Товары, в полях которых product_name и manufacturer есть ЦИФРЫ.
Смысла смотреть другие поля нет .
*/

SELECT product_name, manufacturer
FROM mobile_phones
WHERE product_name rlike '[0-9]' OR
	  manufacturer rlike '[0-9]';
      
/*
или
*/

SELECT product_name, manufacturer
FROM mobile_phones
WHERE product_name rlike '[:digit:]' OR
	  manufacturer rlike '[:digit:]';

/*
Возможно имелось в виду просмотр поля product_name тогда:
*/

SELECT product_name, manufacturer
FROM mobile_phones
WHERE product_name rlike '[:digit:]';

/*
4.3.1 Товары, в поле которых product_name НЕТ ЦИФР.
Логическое продолжение задания 4.3
*/

SELECT product_name, manufacturer
FROM mobile_phones
WHERE product_name NOT RLIKE '[0-9]';

/*
4.4 Товары, в полях которых product_name и manufacturer есть ЦИФРА "8".
Смысла смотреть другие поля нет .
*/

SELECT product_name, manufacturer
FROM mobile_phones
WHERE product_name LIKE '%8%' OR
	  manufacturer LIKE '%8%';
      
/*
4.4.1 Товары, в которых есть ЦИФРА "8"
Смотрим все поля (не уверен что это нужно)
*/

SELECT product_name, manufacturer
FROM mobile_phones
WHERE product_name like '%8%' or
	  manufacturer like '%8%' or
	  product_count like '%8%' or
      price like '%8%';