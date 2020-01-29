USE vk; 

-- 2. Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался 
-- с нашим пользователем.


SELECT IF(from_user_id = 3, to_user_id, from_user_id) AS friend, 
    COUNT(*) AS messages_total
    FROM messages
      WHERE (from_user_id = 3 OR to_user_id = 3)
    GROUP BY friend
    LIMIT 1;
    
-- 3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

SELECT 
	target_id AS user,
	COUNT(*) AS likes, 
	(SELECT TIMESTAMPDIFF(YEAR, birthdate, NOW())  FROM profiles 
		WHERE user_id = target_id) AS age
	FROM likes 
    WHERE target_type_id = (SELECT id FROM target_types WHERE name = 'users')
GROUP BY target_id
ORDER BY age 
LIMIT 10;

-- 4. Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT 
	COUNT(*) AS likes, 
	(SELECT 
		CASE (sex)
		  WHEN 'm' THEN 'man'
		  WHEN 'f' THEN 'women'
		END
		FROM profiles WHERE profiles.user_id = likes.user_id) AS sex
	FROM likes 
GROUP BY sex
;

-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании 
-- социальной сети.

SELECT 
	user_id AS user, 
    COUNT(*) AS likes    
FROM likes 
GROUP BY user
LIMIT 10;

