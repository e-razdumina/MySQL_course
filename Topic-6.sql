USE vk; 

-- 2. Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался 
-- с нашим пользователем.
-- Поправила сортировку и добавила критерий про друзей. Доработала свой вариант, чтобы 
-- не повторять вариант из урока

SELECT IF(from_user_id = 5, to_user_id, from_user_id) AS friend, 
    COUNT(*) AS messages_total
    FROM messages
      WHERE (from_user_id = 5 AND to_user_id IN (
        SELECT friend_id AS id FROM friendship WHERE user_id = to_user_id
        UNION
        SELECT user_id AS id FROM friendship WHERE friend_id = to_user_id    
        )
      OR to_user_id = 5 AND from_user_id IN (
        SELECT friend_id AS id FROM friendship WHERE user_id = to_user_id
        UNION
        SELECT user_id AS id FROM friendship WHERE friend_id = to_user_id    
        ))
    GROUP BY friend
    ORDER BY messages_total DESC
    LIMIT 1;
    
    
-- 3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.
-- Не нашла способа улучшить вариант, который разобрали

SELECT SUM(likes_per_user) AS likes_total FROM ( 
  SELECT COUNT(*) AS likes_per_user 
    FROM likes 
      WHERE target_type_id = 2
        AND target_id IN (
          SELECT * FROM (
            SELECT user_id FROM profiles ORDER BY birthdate DESC LIMIT 10
          ) AS sorted_profiles 
        ) 
      GROUP BY target_id
) AS counted_likes;

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
-- Сортировку добавила

SELECT 
	user_id AS user, 
    COUNT(*) AS likes    
FROM likes 
GROUP BY user
ORDER BY likes
LIMIT 10;

