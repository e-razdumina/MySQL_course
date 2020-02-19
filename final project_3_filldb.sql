-- дорабатываем тестовые данные


USE geek;

UPDATE users SET updated_at = created_at WHERE updated_at < created_at;


CREATE TABLE sex (
  id INT UNSIGNED NOT NULL PRIMARY KEY,
  name VARCHAR(10)
);

INSERT INTO sex 
	VALUES 
	(1, 'мужской'),
    (2, 'женский'); 

       
UPDATE profiles SET sex = FLOOR(1 + (RAND() * 2));

DROP TABLE IF EXISTS faculties;

CREATE TABLE faculties (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  next_group_start DATETIME
);

INSERT INTO `faculties` (`id`, `name`, `next_group_start`) 
	VALUES 
		(1, 'data science', '2020-07-01'),
		(2, 'python', '2020-09-27'),
		(3, 'java script', '2020-12-11'),
		(4, 'design', '2020-03-04'),
		(5, 'marketing', '2020-08-27');

DROP TABLE IF EXISTS courses;
CREATE TABLE courses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  teacher_id INT UNSIGNED,
  faculty_id INT UNSIGNED,
  start_date DATETIME
);

INSERT INTO `courses` (`id`, `name`, `teacher_id`, `faculty_id`, `start_date`) 
	VALUES 
		(1, 'Основы HTML', 4, 1, '2020-12-24'),
		(2, 'Продвинутый дизайн', 10, 2, '2020-09-26'),
		(3, 'Машинное обучение', 11, 3, '2020-07-28'),
		(4, 'Java Script интенсив', 14, 4, '2019-05-09'),
		(5, 'Python', 25, 5, '2020-05-27'),
		(6, 'Adobe', 28, 1, '2020-02-07'),
		(7, 'Основы маркетинга', 34, 2, '2020-11-04'),
		(8, 'Искусственный интеллект', 41, 3, '2020-01-10'),
		(9, 'Веб разработка', 46, 4, '2020-08-07'),
		(10, 'Системная аналитика', 53, 5, '2020-02-28'),
		(11, 'Java', 56, 1, '2019-07-01'),
		(12, 'IOS', 73, 2, '2020-09-30'),
		(13, 'Тестирование ПО', 78, 3, '2020-08-06'),
		(14, 'Продакт менеджмент', 81, 4, '2019-04-30'),
		(15, 'Дизайн интерфейсов', 82, 5, '2019-10-27'),
		(16, 'C++', 86, 1, '2019-04-13'),
		(17, 'SMM', 94, 2, '2019-06-05'),
		(18, 'Информационная безопасность', 96, 3, '2019-03-11'),
		(19, 'Администрирование', 68, 4, '2020-09-16'),
		(20, 'SEO', 61, 5, '2019-12-14');


DROP TABLE IF EXISTS events;
CREATE TABLE events (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  teacher_id INT UNSIGNED,
  faculty_id INT UNSIGNED,
  date DATETIME
);

INSERT INTO `events` (`id`, `name`, `teacher_id`, `faculty_id`, `date`) 
	VALUES 
		(1, 'Как учиться эффективно', 113, 1, '2020-07-25'),
		(2, 'Основы языка Python', 116, 2, '2020-11-27'),
		(3, 'Введение в Linux и облачные вычисления', 120, 3, '2020-12-26'),
		(4, 'Базы данных', 124, 4, '2020-06-12'),
		(5, 'Теория вероятностей', 131, 5, '2021-09-16'),
		(6, 'Методы оптимизации', 136, 1, '2021-12-18'),
		(7, 'Линейная алгебра', 140, 2, '2021-04-25'),
		(8, 'Рекомендательные системы', 138, 3, '2021-08-13'),
		(9, 'Введение в нейронные сети', 146, 4, '2020-10-30'),
		(10, 'Введение в компьютерное зрение', 148, 5, '2020-12-02'),
		(11, 'Спортивный анализ данных. ', 149, 1, '2021-12-26'),
		(12, 'Как студенту найти свою первую работу?', 156, 2, '2021-06-10'),
		(13, 'Введение в Git', 13, 3, '2021-07-03'),
		(14, 'Введение в тестирование', 14, 4, '2020-06-24'),
		(15, 'Linux. Рабочая станция', 25, 5, '2020-03-15'),
		(16, 'ООП в Java', 16, 1, '2020-12-08'),
		(17, 'Командная работа', 28, 2, '2020-03-16'),
		(18, 'Компьютерные сети', 34, 3, '2021-11-09'),
		(19, 'Email-маркетинг от Unisender', 38, 4, '2021-10-20'),
		(20, 'Медийная реклама', 39, 5, '2021-11-15');


UPDATE events SET faculty_id = FLOOR(1 + (RAND() * 5));


DROP TABLE IF EXISTS tests;
CREATE TABLE tests (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  course_id INT UNSIGNED 
  );
 
 
INSERT INTO `tests` (`id`, `name`, `course_id`) 
	VALUES 
		(1, 'Основы программирования', 1),
		(2, 'Дизайн-мышление', 2),
		(3, 'Основы визуального восприятия', 3),
		(4, 'Python. Уровень 1', 4),
		(5, 'C#. Уровень 1', 5),
		(6, 'Java EE', 6),
		(7, 'C#. Уровень 1', 7),
		(8, 'Photoshop', 8),
		(9, 'Веб-дизайн', 9),
		(10, 'ИК С ++', 10),
		(11, 'Android. Material Design', 11),
		(12, 'Objective C', 12),
		(13, 'Linux', 13),
		(14, 'Ruby on Rails', 14),
		(15, 'Tarantool', 15),
		(16, 'Основы языка Swift', 16),
		(17, 'Введение в IOS-разработку ', 17),
		(18, 'MySql', 18),
		(19, 'Алгоритмы и структуры данных на PHP', 19),
		(20, 'Spring Framework', 20);

UPDATE tests SET course_id = FLOOR(1 + (RAND() * 20));

UPDATE messages SET from_user_id = FLOOR(1 + (RAND() * 200));
UPDATE messages SET to_user_id = FLOOR(1 + (RAND() * 200));

UPDATE likes SET from_user_id = FLOOR(1 + (RAND() * 200));
UPDATE likes SET to_user_id = FLOOR(1 + (RAND() * 200));




