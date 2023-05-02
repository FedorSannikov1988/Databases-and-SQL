DROP DATABASE IF EXISTS homework_six;

CREATE DATABASE homework_six;

USE homework_six;

/*
1. Создайте таблицу users_old, аналогичную таблице users. 
Создайте процедуру,  с помощью которой можно переместить любого (одного) 
пользователя из таблицы users в таблицу users_old. 
(использование транзакции с выбором commit или rollback – обязательно).
*/

-- пользователи

DROP TABLE IF EXISTS users;

CREATE TABLE users (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамилия',
    email VARCHAR(120) UNIQUE
);

INSERT INTO users (id, firstname, lastname, email) VALUES
(1, 'Reuben', 'Nienow', 'arlo50@example.org'),
(2, 'Frederik', 'Upton', 'terrence.cartwright@example.org'),
(3, 'Unique', 'Windler', 'rupert55@example.org'),
(4, 'Norene', 'West', 'rebekah29@example.net'),
(5, 'Frederick', 'Effertz', 'von.bridget@example.net'),
(6, 'Victoria', 'Medhurst', 'sstehr@example.net'),
(7, 'Austyn', 'Braun', 'itzel.beahan@example.com'),
(8, 'Jaida', 'Kilback', 'johnathan.wisozk@example.com'),
(9, 'Mireya', 'Orn', 'missouri87@example.org'),
(10, 'Jordyn', 'Jerde', 'edach@example.com');

-- проверяю заполнение таблицы

SELECT * FROM `users`;

-- создаем таблицу users_old, аналогичную таблице users 

DROP TABLE IF EXISTS users_old;

CREATE TABLE users_old (
	id SERIAL PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    email VARCHAR(120) UNIQUE
);

-- проверяю заполнение таблицы

SELECT * FROM `users_old`;

-- создаю процедуру

DELIMITER //
DROP PROCEDURE IF EXISTS human_teleportation//
CREATE PROCEDURE human_teleportation (IN firstname_t_h VARCHAR(50), IN lastname_t_h VARCHAR(50))
-- старт процедуры
BEGIN
	DECLARE flag_start_transaction BOOLEAN DEFAULT false;
	SET flag_start_transaction = EXISTS(SELECT `firstname`, `lastname` FROM `users` WHERE `firstname`=firstname_t_h AND `lastname`=lastname_t_h);
	IF(flag_start_transaction) THEN
		-- старт транзакции
		START TRANSACTION;
        
			-- копируем данные из таблицы users в users_old
			INSERT INTO `users_old` (`id`, `firstname`, `lastname`, `email`)
			SELECT `id`, `firstname`, `lastname`, `email`
			FROM `users`
			WHERE `firstname`=firstname_t_h AND `lastname`=lastname_t_h;
			
            -- удаляем скопированные данные из таблицы users
			DELETE FROM `users` WHERE `firstname`=firstname_t_h AND `lastname`=lastname_t_h;
		
        -- конец транзакции
		COMMIT;
        
	ELSE SELECT ('Пользователя с таким именем и фамилией нет в таблице users !') AS 'ATTENTION';
	END IF;
-- конец процедуры
END //
DELIMITER ;

-- или

DELIMITER //
DROP PROCEDURE IF EXISTS human_teleportation_v2//
CREATE PROCEDURE human_teleportation_v2 (IN firstname_t_h VARCHAR(50), IN lastname_t_h VARCHAR(50), IN direction VARCHAR(8))
-- старт процедуры
BEGIN
	DECLARE flag_start_transaction BOOLEAN DEFAULT false;
	SET flag_start_transaction = EXISTS(SELECT `firstname`, `lastname` FROM `users` WHERE `firstname`=firstname_t_h AND `lastname`=lastname_t_h);
	IF(flag_start_transaction) THEN
		-- старт транзакции
		START TRANSACTION;
        
			-- копируем данные из таблицы users в users_old
			INSERT INTO `users_old` (`id`, `firstname`, `lastname`, `email`)
			SELECT `id`, `firstname`, `lastname`, `email`
			FROM `users`
			WHERE `firstname`=firstname_t_h AND `lastname`=lastname_t_h;
			
            -- удаляем скопированные данные из таблицы users
			DELETE FROM `users` WHERE `firstname`=firstname_t_h AND `lastname`=lastname_t_h;
		
        -- конец транзакции
        IF (direction = 'COMMIT') THEN 
        SELECT ('Выполнен COMMIT') 
        COMMIT;
        ELSEIF (direction = 'ROLLBACK') THEN
        SELECT ('Выполнен ROLLBACK')
        ROLLBACK;
        ELSE SELECT ('Введите в качестве 3-ого параметра COMMIT или ROLLBACK') AS 'ATTENTION';
		END IF;
        
	ELSE SELECT ('Пользователя с таким именем и фамилией нет в таблице users !') AS 'ATTENTION';
	END IF;
-- конец процедуры
END //
DELIMITER ;

-- или

DELIMITER //
DROP PROCEDURE IF EXISTS human_teleportation_v3//
CREATE PROCEDURE human_teleportation_v3 (IN firstname_t_h VARCHAR(50), IN lastname_t_h VARCHAR(50))
-- старт процедуры
BEGIN
	DECLARE flag_start_transaction BOOLEAN DEFAULT false;
    DECLARE flag_departure_check BOOLEAN DEFAULT false;
    DECLARE flag_arrival_check BOOLEAN DEFAULT false;
	SET flag_start_transaction = EXISTS(SELECT `firstname`, `lastname` FROM `users` WHERE `firstname`=firstname_t_h AND `lastname`=lastname_t_h);
	IF(flag_start_transaction) THEN
		-- старт транзакции
		START TRANSACTION;
        
			-- копируем данные из таблицы users в users_old
			INSERT INTO `users_old` (`id`, `firstname`, `lastname`, `email`)
			SELECT `id`, `firstname`, `lastname`, `email`
			FROM `users`
			WHERE `firstname`=firstname_t_h AND `lastname`=lastname_t_h;
			
            -- удаляем скопированные данные из таблицы users
			DELETE FROM `users` WHERE `firstname`=firstname_t_h AND `lastname`=lastname_t_h;
            
            SET flag_departure_check = EXISTS(SELECT * FROM `users` WHERE `firstname`=firstname_t_h AND `lastname`=lastname_t_h);
            SET flag_arrival_check = EXISTS(SELECT * FROM `users_old` WHERE `firstname`=firstname_t_h AND `lastname`=lastname_t_h);
		
        -- конец транзакции
        IF ((flag_departure_check = FALSE) AND ( flag_arrival_check = TRUE)) THEN 
        SELECT ('Выполнен COMMIT') AS 'MESSAGE FOR USER';
        COMMIT; 
        ELSE
        SELECT ('Выполнен ROLLBACK') AS 'ATTENTION';
        ROLLBACK;
		END IF;
        
	ELSE SELECT ('Пользователя с таким именем и фамилией нет в таблице users !') AS 'ATTENTION';
	END IF;
-- конец процедуры
END //
DELIMITER ;

-- проверяем создали процедуру или нет

SHOW PROCEDURE STATUS;

-- удаляем созданную процедуру (если это нужно)

DROP PROCEDURE human_teleportation;

-- вызываю созданую процедуру

CALL human_teleportation('Reuben', 'Nienow');

-- или
	
CALL human_teleportation_v2('Reuben', 'Nienow', 'COMMIT');

CALL human_teleportation_v2('Frederick', 'Effertz', 'COMMIT');

CALL human_teleportation_v2('Norene', 'West', 'ROLLBACK');
	
CALL human_teleportation_v2('Unique', 'Windler', 'Х');

-- или

CALL human_teleportation_v3('Reuben', 'Nienow');

CALL human_teleportation_v3('Frederick', 'Effertz');

CALL human_teleportation_v3('Norene', 'West');
	
CALL human_teleportation_v3('X', 'X');

-- проверяем что все получилось 

SELECT * FROM `users_old`;

SELECT * FROM `users`;

/*
разбирался как работает ROLLBACK и COMMIT
*/
/*
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
	id INT PRIMARY KEY AUTO_INCREMENT,
	user_id INT,
	total DECIMAL (11,2) COMMENT 'Счет',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Счета пользователей и интернет магазина';
INSERT INTO accounts (user_id, total) 
VALUES
	(4, 5000.00),
	(3, 0.00),
	(2, 200.00),
	(NULL, 25000.00);

SELECT * FROM `accounts`;

START TRANSACTION;
-- Далее выполняем команды, входящие в транзакцию:
	SELECT total FROM accounts WHERE user_id = 4;
	-- Убеждаемся, что на счету пользователя достаточно средств:
	UPDATE accounts SET total = total - 2000 WHERE user_id = 4;
	-- Снимаем средства со счета пользователя:
	UPDATE accounts SET total = total + 2000 WHERE user_id IS NULL;
-- Чтобы изменения вступили в
-- силу, мы должны выполнить команду COMMIT
ROLLBACK;
COMMIT;

SELECT * FROM accounts;
*/

/*
2. Создайте функцию hello(), которая будет возвращать приветствие, 
в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна 
возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать 
фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
*/

-- с использованием IF

DROP FUNCTION IF EXISTS hello_v1;
DELIMITER //
CREATE FUNCTION hello_v1()
RETURNS VARCHAR(12) NO SQL
BEGIN
	DECLARE time_is_right_now VARCHAR(8);
    DECLARE ansver VARCHAR(12);
    SET time_is_right_now = CURTIME();
		IF (time_is_right_now BETWEEN '06:00:00' AND '12:00:00') THEN SET ansver='Доброе утро';
			ELSEIF (time_is_right_now BETWEEN '12:00:00' AND '18:00:00') THEN SET ansver='Добрый день';
			ELSEIF (time_is_right_now BETWEEN '18:00:00' AND '24:00:00') THEN SET ansver='Добрый вечер';
			ELSE SET ansver='Доброй ночи';
		END IF;
    RETURN ansver;
END//
DELIMITER ;

SELECT hello_v1();

-- с использованием CASE

DROP FUNCTION IF EXISTS hello_v2;
DELIMITER //
CREATE FUNCTION hello_v2()
-- RETURNS VARCHAR(12) NO SQL
RETURNS VARCHAR(12) DETERMINISTIC 
BEGIN
	DECLARE time_is_right_now VARCHAR(8);
    DECLARE ansver VARCHAR(12);
    SET time_is_right_now = CURTIME();
    CASE
        WHEN time_is_right_now BETWEEN '06:00:00' AND '12:00:00' THEN SET ansver='Доброе утро';
        WHEN time_is_right_now BETWEEN '12:00:00' AND '18:00:00' THEN SET ansver='Добрый день';
        WHEN time_is_right_now BETWEEN '18:00:00' AND '24:00:00' THEN SET ansver='Добрый вечер';
        ELSE SET ansver='Доброй ночи';
    END CASE;
    RETURN ansver;
END//
DELIMITER ;

SELECT hello_v2();

/*
3. Создайте процедуру, которая выведет id пользователя 
и коэффициент популярности 
для всех пользователей из таблицы users.
*/

/*
Для решения задачи №3 необходимо:
Создать функцию, вычисляющей коэффициент популярности 
пользователя (по заявкам на дружбу – таблица friend_requests) 
(коэффициент высчитывается по следующему правилу:
 количество_входных_заявок / количество_исходных_заявок )
*/

-- заявки на дружбу
DROP TABLE IF EXISTS friend_requests;

CREATE TABLE friend_requests (
	initiator_user_id BIGINT UNSIGNED NOT NULL,
    target_user_id BIGINT UNSIGNED NOT NULL,
    `status` ENUM('requested', 'approved', 'unfriended', 'declined'),
	requested_at DATETIME DEFAULT NOW(),
	updated_at DATETIME,
    PRIMARY KEY (initiator_user_id, target_user_id),
    FOREIGN KEY (initiator_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE, 
    FOREIGN KEY (target_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO friend_requests (initiator_user_id, target_user_id, `status`, requested_at, updated_at) 
VALUES 
(1, 10, 'approved', '2023-01-05 06:40:37', '2023-01-05 16:28:19'),
(1, 2, 'requested', '2023-01-06 07:33:23', NULL),
(1, 3, 'approved', '2023-01-07 01:53:07', '2023-01-18 16:22:56'),
(4, 1, 'approved', '2023-01-08 15:57:26', '2023-01-15 18:12:00'),
(5, 2, 'approved', '2023-01-08 18:22:00', '2023-01-14 08:25:00'),
(6, 3, 'unfriended', '2023-01-09 17:07:59', '2023-01-09 17:12:45'),
(7, 1, 'requested', '2023-01-09 06:20:23', NULL),
(8, 6, 'unfriended', '2023-01-10 01:50:03', '2023-01-10 06:50:59'),
(9, 7, 'approved', '2023-01-11 22:52:09', NULL),
(10, 6, 'approved', '2023-01-12 00:32:15', '2023-01-12 10:22:15');

SELECT * FROM friend_requests;

/*
Выбор типа BIGINT UNSIGNED обусловлен предположением 
что у нас просто невероятных размеров таблица
(ну и просто побаловаться хочется)
*/

DROP FUNCTION IF EXISTS user_popularity_coefficient;
DELIMITER //
CREATE FUNCTION user_popularity_coefficient(id_researches_user BIGINT UNSIGNED)
RETURNS DOUBLE READS SQL DATA 
BEGIN
	DECLARE to_user BIGINT UNSIGNED; -- количество заявок к пользователю
    DECLARE from_user BIGINT UNSIGNED; -- количество заявок от пользователя
    DECLARE user_popularity_coefficient DOUBLE;
    
    SET to_user = (SELECT COUNT(*) FROM friend_requests WHERE target_user_id = id_researches_user);
    SET from_user = (SELECT COUNT(*) FROM friend_requests WHERE initiator_user_id = id_researches_user);
    
    /* 
		Из-за cтрого режима работы сервера SQL проверпяемого коммандой
        SHOW VARIABLES LIKE 'sql_mode'; или SELECT @@sql_mode;
        ответ на которую:
        ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION
        "STRICT_TRANS_TABLES" - подтверждение что режим строгий
		написал "заплатку" приведенную ниже (не хочу переводить сессию на менее строгий режим работы).
		Исправить режим работы можно коммандой:
        SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
        Источник: http://fkn.ktu10.com/?q=node/7016
    */
    
		IF (from_user = 0) THEN SET user_popularity_coefficient = NULL; 
		ELSE SET user_popularity_coefficient = to_user / from_user ;    
		END IF;
    
    RETURN user_popularity_coefficient ;
END//
DELIMITER ;

-- проверка работоспособности функции

SELECT user_popularity_coefficient(1);
SELECT user_popularity_coefficient(2);
SELECT user_popularity_coefficient(4);

-- создаю процедуру c приминением функции
    
DELIMITER //
DROP PROCEDURE IF EXISTS popularity_table//
CREATE PROCEDURE popularity_table(IN round INT)

BEGIN
    DECLARE id_max_users INT;
	DECLARE count_find INT;
    
    DROP TEMPORARY TABLE IF EXISTS byffer;
    CREATE TEMPORARY TABLE byffer (
    firstname varchar(50),
    lastname varchar(50),
    user_id BIGINT UNSIGNED,
    popularity_coefficient DOUBLE
    );
    
	SET id_max_users = (SELECT MAX(id) FROM `users`);
	
    WHILE (id_max_users > 0) DO
	
		SET count_find = (SELECT COUNT(*) FROM `users` WHERE id = id_max_users); 
        
			IF (count_find = 1) THEN
       
			INSERT INTO byffer (firstname, lastname, user_id, popularity_coefficient) 
			VALUES 
			( (SELECT firstname FROM users WHERE id = id_max_users),
			(SELECT lastname FROM users WHERE id = id_max_users),
			id_max_users, 
			ROUND(user_popularity_coefficient(id_max_users), round) );
            
			ELSEIF (count_find > 1) THEN 
            
            SELECT ('В таблице есть пользователи с повторяющимися Id') AS 'ATTENTION';
        
			ELSEIF (count_find = 0) THEN 
            
            SELECT ('В таблице есть Id не привязанные к пользователю') AS 'ATTENTION';
        
			END IF;
        
		SET id_max_users = id_max_users - 1;

	END WHILE;

    SELECT user_id, popularity_coefficient, firstname, lastname 
    FROM byffer 
    ORDER BY user_id;
    DROP TEMPORARY TABLE IF EXISTS byffer;
    
END //
DELIMITER ;

-- проверяем создали процедуру или нет

SHOW PROCEDURE STATUS;

-- удаляем созданную процедуру (при необходимости)

DROP PROCEDURE popularity_table;

-- вызываю созданую процедуру

CALL popularity_table(5);