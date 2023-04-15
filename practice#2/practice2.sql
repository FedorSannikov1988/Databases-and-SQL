CREATE TABLE movies (id INT PRIMARY KEY AUTO_INCREMENT,
						title VARCHAR(50) NOT NULL UNIQUE,
                        title_eng VARCHAR(50),
                        year_movie YEAR NOT NULL,
                        count_min INT,
                        storyline TEXT);
INSERT INTO movies (title, title_eng, year_movie, count_min, storyline) VALUES ('Игры разума', 'A Beautiful Mind', 
											2001, 135, 
                                            'От всемирной известности до греховных глубин — все это познал на своей шкуре Джон Форбс Нэш-младший.
                                            Математический гений, он на заре своей карьеры сделал титаническую работу в области теории игр, 
                                            которая перевернула этот раздел математики и практически принесла ему международную известность. 
                                            Однако буквально в то же время заносчивый и пользующийся успехом у женщин Нэш получает удар судьбы, 
                                            который переворачивает уже его собственную жизнь.'),
											('Форрест Гамп', 'Forrest Gump', 1994, 142, 'Сидя на автобусной остановке, Форрест Гамп — не очень умный, 
                                            но добрый и открытый парень — рассказывает случайным встречным историю своей необыкновенной жизни. 
                                            С самого малолетства парень страдал от заболевания ног, соседские мальчишки дразнили его, 
                                            но в один прекрасный день Форрест открыл в себе невероятные способности к бегу. 
                                            Подруга детства Дженни всегда его поддерживала и защищала, но вскоре дороги их разошлись.'),
											('Иван Васильевич меняет профессию', NULL, 1998, 128,'Инженер-изобретатель Тимофеев сконструировал 
                                            машину времени, которая соединила его квартиру с далеким шестнадцатым веком - точнее, 
                                            с палатами государя Ивана Грозного. Туда-то и попадают тезка царя пенсионер-общественник 
                                            Иван Васильевич Бунша и квартирный вор Жорж Милославский. На их место в двадцатом веке «переселяется» 
                                            великий государь. Поломка машины приводит ко множеству неожиданных и забавных событий...'),
											('Назад в будущее', 'Back to the Future', 1985, 116, 'Подросток Марти с помощью машины времени,
                                            сооружённой его другом-профессором доком Брауном, попадает из 80-х в далекие 50-е. 
                                            Там он встречается со своими будущими родителями, ещё подростками, и другом-профессором, совсем молодым.'),
											('Криминальное чтиво', 'Pulp Fiction', 1994, 154, NULL);
SELECT * from movies;

RENAME TABLE movies TO cinema;

ALTER TABLE cinema ADD COLUMN `status_active` BOOLEAN AFTER `storyline`;

ALTER TABLE cinema ADD COLUMN `ganre_id` INT;

ALTER TABLE cinema DROP COLUMN status_active;

CREATE TABLE ganre (id INT PRIMARY KEY AUTO_INCREMENT, ganre_name VARCHAR(20) NOT NULL);

INSERT INTO ganre (ganre_name) VALUES ("Боевик"), ("Комедия"), ("Мелодрама"), ("Фантастика");

SELECT * FROM ganre;

ALTER TABLE cinema ADD FOREIGN KEY (ganre_id) REFERENCES ganre(id);

UPDATE cinema SET ganre_id = 3 WHERE id = 1;
UPDATE cinema SET ganre_id = 3 WHERE id = 2;
UPDATE cinema SET ganre_id = 2 WHERE id = 3;
UPDATE cinema SET ganre_id = 4 WHERE id = 4;
UPDATE cinema SET ganre_id = 1 WHERE id = 5;

SELECT * FROM cinema;

DROP TABLE ganre; /*Фиг вам, пока есть FK!!!*/

ALTER TABLE cinema DROP FOREIGN KEY `cinema_ibfk_1`;

DROP TABLE ganre;

ALTER TABLE cinema ADD CONSTRAINT `ganre_id` FOREIGN KEY (ganre_id) REFERENCES ganre(id) ON DELETE SET NULL ON UPDATE SET NULL;

DELETE FROM ganre WHERE id = 3;

TRUNCATE TABLE ganre; /*конец первой серии*/
/*----------------------------------------------------------*/
ALTER TABLE cinema ADD COLUMN `category` VARCHAR(20);

UPDATE cinema SET category = "Подростковый" WHERE id = 1;
UPDATE cinema SET category = "Сопливый" WHERE id = 2;
UPDATE cinema SET category = NULL WHERE id = 3;
UPDATE cinema SET category = "Мощный" WHERE id = 4;
UPDATE cinema SET category = "Взрослый" WHERE id = 5;

SELECT title, title_eng, 
CASE
WHEN category = "Подростковый" then "Для детей 16+"
WHEN category = "Сопливый" then "Для сопливых"
WHEN category = "Мощный" or category = "Взрослый" then "Нормальное кино"
ELSE "Кино не для Вас!"
END AS SOVIET
from cinema;

SELECT title, title_eng, 
CASE category
WHEN "Подростковый" then "Для детей 16+"
WHEN "Сопливый" then "Для сопливых"
WHEN "Мощный" or "Взрослый" then "Нормальное кино"
ELSE "Кино не для Вас!"
END AS SOVIET
from cinema;

INSERT INTO cinema (title, title_eng, year_movie, count_min, storyline) VALUES ('Короткометражка немецкая', 'Short film', 
											1972, 25, 
                                            'Актерский дебют Силвестера Сталлоне');


SELECT title, title_eng, ganre_name,
IF (count_min > 0 and count_min <= 60, "Короткометражный", IF (count_min > 60, "Полный метр", "Не снят")) AS Length
FROM cinema
LEFT JOIN ganre ON cinema.ganre_id = ganre.id;

SELECT title, title_eng, ganre_name,
CASE 
WHEN count_min <= 50 THEN "Короткометражный фильм"
WHEN count_min > 50 AND count_min <= 150 THEN "Среднеметражный фильм"
WHEN count_min > 150 THEN "Зовите Скорсезе"
ELSE "Не могу посчитать минуты!"
END AS Length
FROM cinema 
LEFT JOIN ganre ON cinema.ganre_id = ganre.id; 
