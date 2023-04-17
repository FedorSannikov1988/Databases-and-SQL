-- 1 Найти количество букв о в слове молоко
SELECT (LENGTH("молоко") - LENGTH(REPLACE("молоко", "о",""))) / 2 as 'Количество букв о';

-- 2 выбрать код , название города и популяцию , код , города и популяцию где код города больше текущего кода города на 2
select * from city c left join city c1 on c.citycode +2= c1.citycode;

-- 3. Вывести марку авто - а так же сколько авто такой марки в таблице , вывести записи где количество авто такой марки больше 2, записи на должны дублироваться
select mark, count(1) from auto a group by mark having count(1)>1;


-- 4. Вывести Марку и цвет автомобиля - имя и фамилию покупателя, для всех покупателей, которые живут в городе с населением больше 1 млн человек.
select mark, color, firstname, lastname from auto a inner join man m on m.phonenum = a.phonenum where m.citycode in (select citycode from city c where c.peoples> 1000000 );

-- 5. Вывести на экран людей которые живут в городах с населением больше 1000000 , если людей с таким же именем нет в таблице MAN
select * from man m where m.citycode in (select citycode from city where peoples > 1000000) and not exists 
(select * from man m1 where m.firstname = m1.firstname  and m.phonenum <> m1.phonenum );

-- 6. Вывести на экран города если в таблице нет города который начинается на такую же букву
select * from city c where substr(c.cityname,1,1) not in (select substr(c1.cityname,1,1) from city c1 where c1.citycode<> c.citycode);


-- 7. Вывести на экран сколько машин каждого цвета  для машин марок BMW и LADA
select color, mark, count(1) from auto where mark in ('BMW','LADA') group by color, mark;

-- 8. Подсчитать количество BMW в AUTO
select count(1) as countbmw from auto where mark = 'BMW';


-- 9. вывести на экран марку авто и количество AUTO не этой марки.
select distinct mark, (select count(1) from auto a1 where a1.mark != a.mark) as c from auto a;