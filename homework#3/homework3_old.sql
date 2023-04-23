DROP DATABASE IF EXISTS homework_three_old;

CREATE DATABASE homework_three_old;

USE homework_three_old;

DROP TABLE IF EXISTS `staff`;

CREATE TABLE `staff`
(
`id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(20),
`surname` VARCHAR(20),
`specialty` VARCHAR(10),
`seniority` INT UNSIGNED,
`salary` DECIMAL(10,2),
`age` INT UNSIGNED
);

INSERT INTO `staff` (`name`, `surname`, `specialty`, `seniority`, `salary`, `age`)
VALUES
('Вася', 'Васькин', 'Начальник', '40', 100000, 60),
('Петя', 'Петькин', 'Начальник', '8', 70000, 30),
('Катя', 'Катина', 'Инженер', '2', 70000, 25),
('Саша', 'Сашкин', 'Инженер', '12', 50000, 35),
('Иван', 'Иванов', 'Рабочий', '40', 30000, 59),
('Петр', 'Петров', 'Рабочий', '20', 25000, 40),
('Сидр', 'Сидоров', 'Рабочий', '10', 20000, 35),
('Антон', 'Антонов', 'Рабочий', '8', 19000, 28),
('Юрий', 'Юрков', 'Рабочий', '5', 15000, 25),
('Максим', 'Воронин', 'Рабочий', '2', 11000, 22),
('Юра', 'Галкин', 'Рабочий', '3', 12000, 24),
('Люся', 'Люськина', 'Уборщик', '10', 10000, 49);

SELECT *
FROM `staff`;

/*
1. Отсортируйте поле "сумма" в порядке убывания и возрастания.
*/

-- убывание
SELECT *
FROM `staff`
ORDER BY `salary` DESC;

-- возрастание
SELECT *
FROM `staff`
ORDER BY `salary` ASC;

/*
2. Отсортируйте по возрастанию поле "Зарплата" и выведите 5 строк 
с наибольшей заработной платой.
*/

SELECT `salary` AS list_five_max_salary
FROM `staff`
GROUP BY list_five_max_salary
ORDER BY list_five_max_salary DESC
LIMIT 5 OFFSET 0;

/*
3. Выполните группировку всех сотрудников по специальности 
"рабочий", зарплата которых превышает 20000.
*/

SELECT `salary`
FROM `staff`
WHERE (`specialty` = 'Рабочий') AND (`salary` > 20000)
GROUP BY `salary`;