-- Task 1. Проанализировать какие запросы могут выполняться наиболее часто в процессе работы приложения и добавить необходимые индексы.
-- Пока не совсем понимаю как проанализировать и что может понадобиться. Создала индекс для сообщений
USE vk;

DESC messages;

CREATE INDEX messages_from_user_idx ON messages(from_user_id);

-- Task 2.

DESC communities;
DESC communities_users;
DESC profiles;


SELECT 
	DISTINCT communities.name as name, 
    COUNT(communities_users.user_id) OVER(PARTITION BY communities_users.community_id) AS users_in_community,
    -- SUM(COUNT(communities_users.user_id)) OVER(PARTITION BY communities_users.community_id) AS average,
    COUNT(communities_users.user_id) OVER() AS total_users,
	SUM(communities_users.user_id) OVER(PARTITION BY communities_users.community_id) / COUNT(communities_users.user_id) OVER() * 100 AS "%%",
    MIN(profiles.birthdate) OVER(PARTITION BY communities_users.community_id) AS youngest_user,
    MAX(profiles.birthdate) OVER(PARTITION BY communities_users.community_id) AS oldest_user
FROM communities
	JOIN communities_users
        ON communities.id = communities_users.community_id
	JOIN profiles
		ON profiles.user_id = communities_users.user_id
	;


