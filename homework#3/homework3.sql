DROP DATABASE IF EXISTS homework_three;

CREATE DATABASE homework_three;

USE homework_three;

DROP TABLE IF EXISTS `staff`;

CREATE TABLE `staff`
(
`id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
`firstname` VARCHAR(20),
`lastname` VARCHAR(20),
`post` VARCHAR(10),
`seniority` INT UNSIGNED,
`salary` DECIMAL(10,2),
`age` INT UNSIGNED
);

INSERT INTO `staff` (`firstname`, `lastname`, `post`, `seniority`, `salary`, `age`)
VALUES
('Вася', 'Петров', 'Начальник', '40', 100000, 60),
('Петр', 'Власов', 'Начальник', '8', 70000, 30),
('Катя', 'Катина', 'Инженер', '2', 70000, 25),
('Саша', 'Сасин', 'Инженер', '12', 50000, 35),
('Иван', 'Иванов', 'Рабочий', '40', 30000, 59),
('Петр', 'Петров', 'Рабочий', '20', 25000, 40),
('Сидр', 'Сидоров', 'Рабочий', '10', 20000, 35),
('Антон', 'Антонов', 'Рабочий', '8', 19000, 28),
('Юрий', 'Юрков', 'Рабочий', '5', 15000, 25),
('Максим', 'Максимов', 'Рабочий', '2', 11000, 22),
('Юрий', 'Галкин', 'Рабочий', '3', 12000, 24),
('Людмила', 'Маркина', 'Уборщик', '10', 10000, 49);

SELECT *
FROM `staff`;

/*
1. Отсортируйте данные по полю заработная плата (salary) 
в порядке убывания.
*/

SELECT *
FROM `staff`
ORDER BY `salary` DESC;

/*
2. Отсортируйте данные по полю заработная плата (salary) 
в порядке возрастания.
*/

SELECT *
FROM `staff`
ORDER BY `salary` ASC;

-- или

SELECT `salary`
FROM `staff`
ORDER BY `salary`;

/*
3. Выведите 5 максимальных заработных плат (salary)
*/

SELECT `salary` AS list_five_max_salary
FROM `staff`
GROUP BY list_five_max_salary
ORDER BY list_five_max_salary DESC
LIMIT 5 OFFSET 0;

/*
4. Посчитайте суммарную зарплату (salary) по каждой специальности (роst)
*/

SELECT `post`, SUM(`salary`) AS "post_salary"
FROM `staff`
GROUP BY `post`;

/*
5. Найдите кол-во сотрудников с специальностью (post) «Рабочий» в
 возрасте от 24 до 49 лет включительно.​
*/

SELECT `post`, COUNT(*) AS "quantity post between 24 and 49 age"
FROM `staff`
WHERE (`post` = "Рабочий") AND (`age` BETWEEN 24 AND 49);
-- WHERE (`post` = "Рабочий") AND (`age` >= 24 AND `age` <= 49);

/*
6. Найдите количество уникальных специальностей​.
*/

-- имею два варианта решения:
 
-- вариант №1 (считаем сколько специальностей (начальник, инженер и т.д.) упоминуется в таблице):

SELECT COUNT(DISTINCT (`post`)) AS quantity_post 
FROM `staff`;

-- вариант №2.1 (показываем только ту специальность которая упоминается в таблице один раз (тоесть "Уборщик"):

SELECT `post`, COUNT(*) AS quantity_post
FROM `staff`
GROUP BY `post`
HAVING quantity_post = 1;

-- вариант №2.2:

SELECT COUNT(*) AS quantity_post
FROM `staff`
GROUP BY `post`
HAVING quantity_post = 1;

/*
7. Выведите специальности, у которых средний возраст
сотрудников меньше 30 лет
*/

-- выводим средний возраст для каждой специальности

SELECT `post`, AVG(`age`) AS middle_age
FROM `staff`
GROUP BY `post`;

-- выводим специальности, у которых средний возраст сотрудников меньше 30 лет 

SELECT `post`, AVG(`age`) AS middle_age
FROM `staff`
GROUP BY `post`
HAVING middle_age < 30;

/*
Что бы хоть что-то было выведено так как не одна из записей в таблице 
не соответсвует условию: "Выведите специальности, у которых средний возраст 
сотрудников меньше 30 лет"
*/

SELECT `post`, AVG(`age`) AS middle_age
FROM `staff`
GROUP BY `post`
HAVING middle_age <= 30;