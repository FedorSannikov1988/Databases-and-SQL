-- 1 Найти количество букв о в слове молоко

SELECT(CHAR_LENGTH('молоко') - CHAR_LENGTH(REPLACE('молоко', 'о', ''))) AS RESALT;