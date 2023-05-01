/*Создайте процедуру, которая выберет для одного пользователя 5 пользователей в случайной комбинации, 
которые удовлетворяют хотя бы одному критерию:
1) из одного города 
2) состоят в одной группе
3) друзья друзей
*/
DELIMITER //
CREATE PROCEDURE SELECT_USERS(user_id int)
BEGIN
WITH friends AS (
	SELECT initiator_user_id AS id
    FROM friend_requests
    WHERE status = 'approved' AND target_user_id = user_id 
    UNION
    SELECT target_user_id 
    FROM friend_requests
    WHERE status = 'approved' AND initiator_user_id = user_id 
)
SELECT p.user_id /*u.firstname, u.lastname, up.hometown*/
FROM 
(SELECT * FROM profiles AS up WHERE up.user_id = user_id) AS up
JOIN profiles as p ON p.hometown = up.hometown AND p.user_id <> user_id
UNION 
SELECT ucom.user_id
FROM users_communities AS uc
JOIN users_communities AS ucom ON ucom.community_id = uc.community_id
WHERE uc.user_id = user_id AND ucom.user_id <> user_id
UNION
SELECT fr.initiator_user_id
    	FROM friends f
        JOIN friend_requests fr ON fr.target_user_id = f.id
	WHERE fr.initiator_user_id != user_id  AND fr.status = 'approved'
    UNION
    	SELECT fr.target_user_id
    	FROM  friends f
        JOIN  friend_requests fr ON fr.initiator_user_id = f.id 
	WHERE fr.target_user_id != user_id  AND status = 'approved'

ORDER BY rand()    
LIMIT 5;
END//
DELIMITER ;
SELECT * FROM friend_requests;
CALL SELECT_USERS(2); 
