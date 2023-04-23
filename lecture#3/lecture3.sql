DROP DATABASE IF EXISTS lecture_three;

CREATE DATABASE lecture_three;

USE lecture_three;

DROP TABLE IF EXISTS catalogs;

CREATE TABLE catalogs (
	id INT UNSIGNED,
	name VARCHAR(255) COMMENT 'Название раздела'
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs (name) VALUES ('Процессоры');
INSERT INTO catalogs VALUES (0, 'Мат.платы');
INSERT INTO catalogs VALUES (NULL, 'Видеокарты');

DROP TABLE IF EXISTS rubrics;

CREATE TABLE rubrics (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Название раздела'
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO rubrics
VALUES
	(NULL, 'Видеокарты'),
	(NULL, 'Память');

SELECT *
FROM `catalogs`;

SELECT *
FROM `rubrics`;

SELECT name FROM catalogs
UNION
SELECT name FROM rubrics;

SELECT name FROM catalogs
UNION ALL
SELECT name FROM rubrics;

DROP TABLE IF EXISTS catalog;

CREATE TABLE catalog (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalog (name)
VALUES
  ('Процессоры'), -- id = 1
  ('Материнские платы'),-- id = 2
  ('Видеокарты'),--  id = 3
  ('Жесткие диски'), -- id = 4
  ('Оперативная память');-- id = 5
  
DROP TABLE IF EXISTS product;

CREATE TABLE product (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) COMMENT 'Название',
  description TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY  (catalog_id) REFERENCES catalog(id)
) COMMENT = 'Товарные позиции';

SELECT * FROM catalog;

INSERT  product(name, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);
  
  SELECT * FROM product;
  
SELECT *,
	(SELECT MAX(price) FROM product ) AS 'max_price'
FROM product;

/*CROSS JOIN*/

CREATE TABLE fst(
	value VARCHAR(255)
);

INSERT INTO fst
VALUES
	('fst1'),
	('fst2'), 
	('fst3');

CREATE TABLE snd(
	value VARCHAR(255)
);

INSERT INTO snd
VALUES 
	('snd1'), 
	('snd2'), 
	('snd3');
    
SELECT * FROM fst;
  
SELECT * FROM snd;

SELECT * FROM snd
CROSS JOIN fst;

/*INNER JOIN*/

DROP TABLE IF EXISTS catalog;

CREATE TABLE catalog (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalog (name)
VALUES
  ('Процессоры'), -- id = 1
  ('Материнские платы'),-- id = 2
  ('Видеокарты'),--  id = 3
  ('Жесткие диски'), -- id = 4
  ('Оперативная память');-- id = 5
  
DROP TABLE IF EXISTS product;

CREATE TABLE product (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) COMMENT 'Название',
  description TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY  (catalog_id) REFERENCES catalog(id)
) COMMENT = 'Товарные позиции';

SELECT * FROM catalog;

INSERT  product(name, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);
  
SELECT * FROM product;

SELECT p.`name`, 
	   p.`price`,
	   c.`name`
FROM catalog AS c
JOIN product AS p
ON c.id = p.catalog_id;

-- а если так 

SELECT p.`name`, 
	   p.`price`,
	   c.`name`
FROM product AS p
JOIN catalog AS c
ON c.id = p.catalog_id;

-- без разницы 

/*LEFT JOIN*/

SELECT * FROM catalog;

SELECT * FROM product;

SELECT
	p.`name`,
	p.`price`,
	c.`name`
FROM catalog AS c 		-- Берется левая таблица и совпадения из правой
LEFT JOIN product AS p 	-- Правая таблица
ON c.id = p.catalog_id; -- Условие для совпадения (область пересечения 2 множеств)

-- а если так то избавимся от NULL

SELECT
	p.`name`,
	p.`price`,
	c.`name`
FROM product AS p 
LEFT JOIN catalog AS c 
ON c.id = p.catalog_id;

/*RIGHT JOIN*/

SELECT
	p.`name`,
	p.`price`,
	c.`name`
FROM catalog AS c 		-- Левая таблица
RIGHT JOIN product AS p -- Правая таблица
ON c.id = p.catalog_id; -- Условие для совпадения (область пересечения 2-х множеств)

-- сделаем NULL

SELECT
	p.`name`,
	p.`price`,
	c.`name`
FROM product AS p
RIGHT JOIN catalog AS c
ON c.id = p.catalog_id;

/*FULL JOIN*/

SELECT p.name, p.price, c.name
FROM catalog AS c
LEFT JOIN product AS p
ON c.id = p.catalog_id

UNION -- Удалили дубликаты

SELECT p.name, p.price, c.name
FROM catalog AS c
RIGHT JOIN product AS p
ON c.id = p.catalog_id;