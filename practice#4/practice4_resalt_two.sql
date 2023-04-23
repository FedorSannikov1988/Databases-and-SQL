CREATE DATABASE lesson_4;
USE lesson_4;

CREATE TABLE teacher
(
    id      INT NOT NULL PRIMARY KEY,
    surname VARCHAR(45),
    salary  INT
);

INSERT teacher
VALUES (1, "Авдеев", 17000),
       (2, "Гущенко", 27000),
       (3, "Пчелкин", 32000),
       (4, "Питошин", 15000),
       (5, "Вебов", 45000),
       (6, "Шарпов", 30000),
       (7, "Шарпов", 40000),
       (8, "Питошин", 30000);

SELECT *
from teacher;

CREATE TABLE lesson
(
    id         INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    course     VARCHAR(45),
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teacher (id)
);
INSERT INTO lesson(course, teacher_id)
VALUES ("Знакомство с веб-технологиями", 1),
       ("Знакомство с веб-технологиями", 2),
       ("Знакомство с языками программирования", 3),
       ("Базы данных и SQL", 4);

# Получить фамилию учителей и курсы, которые они ведут

SELECT surname, course
FROM teacher
         JOIN lesson;

SELECT surname, course
FROM teacher AS t
         JOIN lesson_4.lesson AS l on t.id = l.teacher_id;

# Выбрать фамилию всех учителей и курсы, которые они ведут. Если учитель не ведет курс, его фамилию все равно необходимо вывести

SELECT surname, course
FROM teacher AS t
         LEFT JOIN lesson_4.lesson AS l on t.id = l.teacher_id;

# Вывести учителей, которые не ведут никакие курсы

SELECT surname, course
FROM teacher AS t
         LEFT JOIN lesson_4.lesson AS l on t.id = l.teacher_id
WHERE course IS null;

# Получите список курсов и учителей , которые их ведут (используя RIGHT JOIN)

SELECT surname, course
FROM teacher AS t
         RIGHT JOIN lesson_4.lesson AS l on t.id = l.teacher_id
WHERE course IS NOT null;

# Получить информацию по учителям , которые ведут курс "Знакомство с веб-технологиями"

SELECT surname, course
FROM teacher AS t
         RIGHT JOIN lesson_4.lesson AS l on t.id = l.teacher_id
WHERE course = 'Знакомство с веб-технологиями';

# 5.1. 	С помощью фильтра “WHERE”, используя “JOIN”

SELECT t.surname, l.course
FROM teacher AS t
         RIGHT JOIN lesson_4.lesson AS l on t.id = l.teacher_id
WHERE l.course = 'Знакомство с веб-технологиями';

# Получить информацию по учителям , которые ведут курс "Знакомство с веб-технологиями"
# 5.2. 	С помощью подзапроса (выборка с помощью с SELECT-a)

SELECT surname
FROM teacher AS t
where t.id in (SELECT l.teacher_id
               FROM lesson AS l
               WHERE l.course = 'Знакомство с веб-технологиями');

SELECT t.surname, l.course
FROM teacher as t,
     lesson as l
where t.id = l.teacher_id
  and l.course = 'Знакомство с веб-технологиями';


create table users
(
    id    int auto_increment primary key,
    login varchar(255) null,
    pass  varchar(255) null,
    male  tinyint      null
);

create table clients
(
    id    int auto_increment primary key,
    login varchar(255) null,
    pass  varchar(255) null,
    male  tinyint      null
);

INSERT INTO users (login, pass, male)
VALUES ('alex', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO users (login, pass, male)
VALUES ('Mikle', '$ws$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO users (login, pass, male)
VALUES ('Olia', '$2y$10$88zbBCKLJklStIgTqBKIluijJUnbeZ5WqJI4RJgkksnFZon5kH14y', 2);
INSERT INTO users (login, pass, male)
VALUES ('Tom', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH20y', 1);
INSERT INTO users (login, pass, male)
VALUES ('Margaret', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ4wqIu4RJgkksnFZon5kH20y', 2);
INSERT INTO users (login, pass, male)
VALUES ('alex', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);

INSERT INTO clients (login, pass, male)
VALUES ('alexander', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO clients (login, pass, male)
VALUES ('Mikle', '$ws$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO clients (login, pass, male)
VALUES ('Olia', '$2y$10$88zbBCKLJklStIgTqBKIluijJUnbeZ5WqJI4RJgkksnFZon5kH14y', 2);
INSERT INTO clients (login, pass, male)
VALUES ('Dmitry', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH20y', 1);
INSERT INTO clients (login, pass, male)
VALUES ('Margaret', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ4wqIu4RJgkksnFZon5kH20y', 2);
INSERT INTO clients (login, pass, male)
VALUES ('Leonid', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO clients (login, pass, male)
VALUES ('Mikle', '$ws$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO clients (login, pass, male)
VALUES ('Olga', '$2y$10$88zbBCKLJklStIgTqBKIluijJUnbeZ5WqJI4RJgkksnFZon5kH14y', 2);
INSERT INTO clients (login, pass, male)
VALUES ('Tom', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH20y', 1);
INSERT INTO clients (login, pass, male)
VALUES ('Masha', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ4wqIu4RJgkksnFZon5kH20y', 2);
INSERT INTO clients (login, pass, male)
VALUES ('alex', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);


-- Задание на EXISTS
CREATE TABLE Employee
(
    Id         INT PRIMARY KEY,
    Name       VARCHAR(45) NOT NULL,
    Department VARCHAR(45) NOT NULL,
    Salary     FLOAT       NOT NULL,
    Gender     VARCHAR(45) NOT NULL,
    Age        INT         NOT NULL,
    City       VARCHAR(45) NOT NULL
);
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City)
VALUES (1001, 'John Doe', 'IT', 35000, 'Male', 25, 'London');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City)
VALUES (1002, 'Mary Smith', 'HR', 45000, 'Female', 27, 'London');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City)
VALUES (1003, 'James Brown', 'Finance', 50000, 'Male', 28, 'London');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City)
VALUES (1004, 'Mike Walker', 'Finance', 50000, 'Male', 28, 'London');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City)
VALUES (1005, 'Linda Jones', 'HR', 75000, 'Female', 26, 'London');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City)
VALUES (1006, 'Anurag Mohanty', 'IT', 35000, 'Male', 25, 'Mumbai');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City)
VALUES (1007, 'Priyanla Dewangan', 'HR', 45000, 'Female', 27, 'Mumbai');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City)
VALUES (1008, 'Sambit Mohanty', 'IT', 50000, 'Male', 28, 'Mumbai');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City)
VALUES (1009, 'Pranaya Kumar', 'IT', 50000, 'Male', 28, 'Mumbai');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City)
VALUES (1010, 'Hina Sharma', 'HR', 75000, 'Female', 26, 'Mumbai');
CREATE TABLE Projects
(
    ProjectId  INT PRIMARY KEY AUTO_INCREMENT,
    Title      VARCHAR(200) NOT NULL,
    ClientId   INT,
    EmployeeId INT,
    StartDate  DATETIME,
    EndDate    DATETIME
);
INSERT INTO Projects (Title, ClientId, EmployeeId, StartDate, EndDate)
VALUES ('Develop ecommerse website from scratch', 1, 1003, NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY)),
       ('WordPress website for our company', 1, 1002, NOW(), DATE_ADD(NOW(), INTERVAL 45 DAY)),
       ('Manage our company servers', 2, 1007, NOW(), DATE_ADD(NOW(), INTERVAL 45 DAY)),
       ('Hosting account is not working', 3, 1009, NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY)),
       ('MySQL database from my desktop application', 4, 1010, NOW(), DATE_ADD(NOW(), INTERVAL 15 DAY)),
       ('Develop new WordPress plugin for my business website', 2, NULL, NOW(), DATE_ADD(NOW(), INTERVAL 10 DAY)),
       ('Migrate web application and database to new server', 2, NULL, NOW(), DATE_ADD(NOW(), INTERVAL 5 DAY)),
       ('Android Application development', 4, 1004, NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY));

# Задание:
# 1.	Получить список пользователей и клиентов, удалив одинаковых клиентов и пользователей

SELECT C.login
FROM clients AS C
UNION
SELECT U.login
FROM users AS U;

# 2.	Получить список пользователей и клиентов. Дубликаты удалять не нужно

SELECT C.login
FROM clients AS C
UNION ALL
SELECT U.login
FROM users AS U;

# Проверьте, присутствует ли буква “А” в последовательности 'A', 'B', 'C', 'D'

SELECT 'A' IN ('A', 'A', 'C', 'D');

# Во временной таблице считаем количество букв А
CREATE TEMPORARY TABLE MyTable AS
SELECT ('A'), ('B'), ('C'), ('D');
INSERT INTO MyTable
VALUES ('A', 'A', 'C', 'D');
SELECT COUNT('A')
FROM MyTable;

# Как поместить значения правда или лож
SELECT IF('A' IN ('A', 'A', 'C', 'D'), 'True', 'FALSE') AS Answer;


# Проверьте, присутствует ли буква “Z” в последовательности 'A', 'B', 'C', 'D'
SELECT IF('Z' IN ('A', 'A', 'C', 'D'), 'True', 'FALSE') AS Answer;

# Получить столбцы из таблицы “clients” , в которых первое имя является набором значений.

SELECT *
FROM clients
WHERE login IN ('Olia', 'Mikle');

# Выберите все логины из таблицы “users”, кроме “Mikle”.

SELECT *
FROM clients
WHERE login NOT IN ('Mikle');