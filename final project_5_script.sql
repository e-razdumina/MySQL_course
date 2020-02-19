-- характерные выборки

USE geek;

-- календарь вебинаров для пользователя (то на что пользователь уже подписался, но еще не прошел) 
-- (хотела добавить курсы в таблицу но не получилось вывести все в 2 столбца) 

SELECT 
	events.name AS event,
	events.date AS date
	FROM events 
		JOIN users_events
			ON events.id = users_events.event_id
			AND users_events.is_watched = 0
		WHERE users_events.user_id = 75;


-- календарь курсов для пользователя (то на что пользователь уже подписался, но еще не прошел) 

SELECT 
	courses.name AS course,
	courses.start_date AS date
	FROM courses 
		JOIN users_courses
			ON courses.id = users_courses.course_id
			AND users_courses.is_finished = 0
		WHERE users_courses.user_id = 75;



-- представления 

-- профиль (юзер / профиль)

CREATE OR REPLACE VIEW user_full AS
	SELECT users.first_name AS first_name, users.last_name AS last_name,
	profiles.birthdate AS birthday, profiles.sex AS sex
		FROM users
			JOIN profiles 
				ON users.id = profiles.user_id
;

SELECT * FROM user_full LIMIT 10;


-- курсы и вебинары внутри выбранного факультета 

CREATE OR REPLACE VIEW data_science_courses AS
	SELECT courses.name AS course,
		courses.start_date AS start
		FROM courses
			JOIN faculties_courses 
				ON faculties_courses.course_id = courses.id
				AND faculties_courses.faculty_id = 1
;

SELECT * FROM data_science_courses LIMIT 10;



