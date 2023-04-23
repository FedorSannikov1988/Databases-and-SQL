CREATE TABLE teacher
(	
	id INT NOT NULL PRIMARY KEY,
    surname VARCHAR(45),
    salary INT
);

INSERT teacher
VALUES
	(1,"Авдеев", 17000),
    (2,"Гущенко",27000),
    (3,"Пчелкин",32000),
    (4,"Питошин",15000),
    (5,"Вебов",45000),
    (6,"Шарпов",30000),
    (7,"Шарпов",40000),
    (8,"Питошин",30000);
    
    CREATE TABLE lesson
(	
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    course VARCHAR(45),
    teacher_id INT,
    FOREIGN KEY (teacher_id)  REFERENCES teacher(id)
);

INSERT INTO lesson(course,teacher_id)
VALUES
	("Знакомство с веб-технологиями",1),
    ("Знакомство с веб-технологиями",2),
    ("Знакомство с языками программирования",3),
    ("Базы данных и SQL",4);

SELECT * from teacher;
SELECT * FROM lesson;
/*Получить фамилию учителей и курсы, которые они ведут Выбрать фамилию всех учителей и курсы, которые они ведут.
Если учитель не ведет курс, его фамилию все равно необходимо вывести*/
SELECT t.surname, l.course FROM teacher AS t
LEFT JOIN lesson AS l ON t.id = l.teacher_id;

/*Вывести учителей, которые не ведут никакие курсы*/
SELECT t.surname, l.course FROM teacher AS t
LEFT JOIN lesson AS l ON t.id = l.teacher_id
WHERE l.course IS NULL;

/*Получите список курсов и учителей , которые их ведут (используя RIGHT JOIN)*/
SELECT l.course, t.surname FROM lesson AS l
RIGHT JOIN teacher AS t on l.teacher_id = t.id
WHERE l.course IS NOT NULL;

/*Получить информацию по учителям , которые ведут курс "Знакомство с веб-технологиями"*/
/*5.1. 	С помощью фильтра “WHERE”, используя “JOIN”*/
SELECT l.course, t.surname FROM lesson AS l
RIGHT JOIN teacher AS t on t.id = l.teacher_id 
WHERE l.course = 'Знакомство с веб-технологиями';

/*5.2. 	С помощью подзапроса (выборка с помощью с SELECT-a)*/
SELECT t.surname
FROM teacher as t
WHERE t.id IN 
(SELECT l.teacher_id FROM lesson as l WHERE l.course = 'Знакомство с веб-технологиями');

create table users
(
    id  int auto_increment primary key,
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

INSERT INTO users (login, pass, male) VALUES ('alex', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO users (login, pass, male) VALUES ('Mikle', '$ws$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO users (login, pass, male) VALUES ('Olia', '$2y$10$88zbBCKLJklStIgTqBKIluijJUnbeZ5WqJI4RJgkksnFZon5kH14y', 2);
INSERT INTO users (login, pass, male) VALUES ('Tom', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH20y', 1);
INSERT INTO users (login, pass, male) VALUES ('Margaret', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ4wqIu4RJgkksnFZon5kH20y', 2);
INSERT INTO users (login, pass, male) VALUES ('alex', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);

INSERT INTO clients (login, pass, male) VALUES ('alexander', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO clients (login, pass, male) VALUES ('Mikle', '$ws$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO clients (login, pass, male) VALUES ('Olia', '$2y$10$88zbBCKLJklStIgTqBKIluijJUnbeZ5WqJI4RJgkksnFZon5kH14y', 2);
INSERT INTO clients (login, pass, male) VALUES ('Dmitry', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH20y', 1);
INSERT INTO clients (login, pass, male) VALUES ('Margaret', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ4wqIu4RJgkksnFZon5kH20y', 2);
INSERT INTO clients (login, pass, male) VALUES ('Leonid', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO clients (login, pass, male) VALUES ('Mikle', '$ws$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO clients (login, pass, male) VALUES ('Olga', '$2y$10$88zbBCKLJklStIgTqBKIluijJUnbeZ5WqJI4RJgkksnFZon5kH14y', 2);
INSERT INTO clients (login, pass, male) VALUES ('Tom', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH20y', 1);
INSERT INTO clients (login, pass, male) VALUES ('Masha', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ4wqIu4RJgkksnFZon5kH20y', 2);
INSERT INTO clients (login, pass, male) VALUES ('alex', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);

SELECT * FROM clients;
SELECT * FROM users;

/*Получить список пользователей и клиентов, удалив одинаковых клиентов и пользователей*/
SELECT u.login, u.male FROM users as u
UNION
SELECT c.login, c.male FROM clients as c;

/*Получить список пользователей и клиентов. Дубликаты удалять не нужно*/
SELECT u.login, u.male FROM users as u
UNION ALL
SELECT c.login, c.male FROM clients as c;

/*Проверьте, присутствует ли буква “А” в последовательности 'A', 'B', 'C', 'D'*/
SELECT 'A' IN ('A', 'B', 'C', 'D') AS IS_A;

/*Проверьте, присутствует ли буква “Z” в последовательности 'A', 'B', 'C', 'D'*/
SELECT 'Z' IN ('A', 'B', 'C', 'D') AS IS_Z;

/*Получить столбцы из таблицы “clients” , в которых первое имя является набором значений.*/
SELECT * FROM clients AS c
WHERE c.login IN ('Mikle', 'Alex', 'Rob');

/*Выберите все логины из таблицы “users”, кроме “Mikle”*/
SELECT * FROM clients AS c
WHERE c.login NOT IN ('Mikle');