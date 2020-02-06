-- Task 1
-- Добавить необходимые внешние ключи для всех таблиц базы данных vk (приложить команды).

USE vk;

-- Добавляем внешние ключи в БД vk
-- Для таблицы профилей

-- Смотрим структуру таблицы
DESC profiles;

-- Добавляем внешние ключи
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT profiles_photo_id_fk
    FOREIGN KEY (photo_id) REFERENCES media(id)
      ON DELETE SET NULL,
   ADD CONSTRAINT profiles_family_status_id_fk
    FOREIGN KEY (family_status_id) REFERENCES family_statuses(id)
      ON DELETE SET NULL;

      
-- Для таблицы сообщений

-- Смотрим структуру таблицы
DESC messages;

-- Добавляем внешние ключи
ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id)
    ON DELETE SET NULL,
  ADD CONSTRAINT messages_to_user_id_fk 
    FOREIGN KEY (to_user_id) REFERENCES users(id)
    ON DELETE SET NULL;

DESC communities_users;

ALTER TABLE communities_users
  ADD CONSTRAINT communities_users_community_id_fk 
    FOREIGN KEY (community_id) REFERENCES communities(id)
    ON DELETE SET NULL,
  ADD CONSTRAINT communities_users_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE SET NULL;
   
UPDATE communities_users SET community_id = FLOOR(1 + (RAND() * 30));

DESC friendship;
 
ALTER TABLE friendship
  ADD CONSTRAINT friendship_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE CASCADE,
  ADD CONSTRAINT friendship_friend_id_fk 
    FOREIGN KEY (friend_id) REFERENCES users(id)
    ON DELETE CASCADE,
  ADD CONSTRAINT friendship_status_id_fk 
    FOREIGN KEY (status_id) REFERENCES friendship_statuses(id)
    ON DELETE SET NULL;

 ALTER TABLE friendship MODIFY COLUMN status_id INT(10) UNSIGNED;

DESC media;

ALTER TABLE media MODIFY COLUMN media_type_id INT(10) UNSIGNED;
ALTER TABLE media MODIFY COLUMN user_id INT(10) UNSIGNED;

ALTER TABLE media
  ADD CONSTRAINT media_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE SET NULL,
  ADD CONSTRAINT media_media_type_id_fk 
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
    ON DELETE SET NULL;

DESC likes;

ALTER TABLE likes MODIFY COLUMN user_id INT(10) UNSIGNED;
ALTER TABLE likes MODIFY COLUMN target_id INT(10) UNSIGNED;
ALTER TABLE likes MODIFY COLUMN target_type_id INT(10) UNSIGNED;

ALTER TABLE likes
  ADD CONSTRAINT likes_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE SET NULL,
  ADD CONSTRAINT likes_target_type_id_fk 
    FOREIGN KEY (target_type_id) REFERENCES target_types(id)
    ON DELETE SET NULL;
   
   
-- Task 2
-- По созданным связям создать ER диаграмму, используя Dbeaver (приложить графический файл к ДЗ).

-- Task 3
-- Переписать запросы, заданые к ДЗ урока 6 с использованием JOIN (четыре запроса).

-- Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

  
 SELECT 
   users.id AS user_id, 
   IF(friendship.user_id = users.id, friendship.friend_id, friendship.user_id) AS friend_id,
   COUNT(*) AS messages_total
   FROM users 
   	 JOIN friendship
   		ON users.id = friendship.friend_id 
   			OR users.id = friendship.user_id 
   	RIGHT JOIN messages
   		ON users.id = messages.to_user_id 
   WHERE users.id = 5
   GROUP BY user_id, friend_id
   ORDER BY messages_total DESC
   LIMIT 1
  ;
 
-- Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

 SELECT  
 	likes.target_id AS user_id,
 	profiles.birthdate AS user_birthdate,
 	COUNT(*) AS likes_per_user
    	FROM likes 
    		JOIN profiles
    			ON likes.target_id = profiles.user_id 
    WHERE target_type_id = 2
    GROUP BY user_id, user_birthdate
    ORDER BY birthdate DESC
    LIMIT 10
   ;
 
   
-- Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT 
	CASE(profiles.sex)
		WHEN 'm' THEN 'man'
		WHEN 'f' THEN 'woman'
	END AS sex, 
	COUNT(*) as likes_count 
	  FROM profiles 
	  	JOIN likes
	  		ON profiles.user_id = likes.user_id
	 GROUP BY sex
	  		;
	  
	  

-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

SELECT 
	users.id AS user_id,
	CONCAT(users.first_name, ' ', users.last_name) AS user_name, 
	COUNT(*) AS media_activity
	FROM users
		JOIN media 
			ON media.user_id = users.id
	GROUP BY user_id, user_name
	ORDER BY media_activity
	LIMIT 10;
 
