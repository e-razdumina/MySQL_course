-- cоздаем таблицы и триггеры


DROP DATABASE IF EXISTS geek;
CREATE DATABASE geek; 

USE geek;


DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  is_teacher BOOLEAN,
  email VARCHAR(120) NOT NULL UNIQUE,
  phone VARCHAR(15) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY,
  birthdate DATE,
  sex CHAR(1),
  hometown VARCHAR(100),
  country VARCHAR(100)
);



DROP TABLE IF EXISTS faculties;
CREATE TABLE faculties (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  next_group_start DATETIME
);

DROP TABLE IF EXISTS courses;
CREATE TABLE courses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  teacher_id INT UNSIGNED,
  faculty_id INT UNSIGNED,
  start_date DATETIME
);

      
DROP TABLE IF EXISTS faculties_courses;
CREATE TABLE faculties_courses (
  faculty_id INT UNSIGNED NOT NULL,
  course_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (faculty_id, course_id)
);



DROP TABLE IF EXISTS users_courses;
CREATE TABLE users_courses (
  course_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  is_finished BOOLEAN, 
  PRIMARY KEY (course_id, user_id)
);



DROP TABLE IF EXISTS events;
CREATE TABLE events (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  teacher_id INT UNSIGNED,
  faculty_id INT UNSIGNED,
  date DATETIME
);



DROP TABLE IF EXISTS users_events;
CREATE TABLE users_events (
  event_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  is_watched BOOLEAN,
  PRIMARY KEY (event_id, user_id)
);



DROP TABLE IF EXISTS tests;
CREATE TABLE tests (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  course_id INT UNSIGNED 
  );
  
  

DROP TABLE IF EXISTS users_tests;
CREATE TABLE users_tests (
  test_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  passed BOOLEAN,
  date DATETIME,
  PRIMARY KEY (test_id, user_id)
);



DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  from_user_id INT UNSIGNED,
  to_user_id INT UNSIGNED,
  body TEXT NOT NULL,
  is_important BOOLEAN,
  is_delivered BOOLEAN,
  created_at DATETIME DEFAULT NOW()
);



DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  from_user_id INT UNSIGNED,
  to_user_id INT UNSIGNED,
  created_at DATETIME DEFAULT NOW()
);



DROP TABLE IF EXISTS logs;
CREATE TABLE logs ( 
	date DATETIME, 
	table_name VARCHAR(255), 
	operation VARCHAR(255),
	key_id INT,
	name VARCHAR(255)
)  ENGINE=Archive
;

-- триггеры на заполнение таблицы logs

DROP TRIGGER IF EXISTS insert_log_courses;

DELIMITER //
CREATE TRIGGER insert_log_courses AFTER INSERT ON courses
FOR EACH ROW BEGIN
  INSERT INTO logs values (NOW(), "courses", "insert", NEW.id, NEW.name);
END//

DELIMITER ;

DROP TRIGGER IF EXISTS delete_log_courses;

DELIMITER //
CREATE TRIGGER delete_log_courses AFTER DELETE ON courses
FOR EACH ROW BEGIN
  INSERT INTO logs values (NOW(), "courses", "delete", OLD.id, OLD.name);
END//

DELIMITER ;

DROP TRIGGER IF EXISTS insert_log_users;

DELIMITER //
CREATE TRIGGER insert_log_users AFTER INSERT ON users
FOR EACH ROW BEGIN
  INSERT INTO logs values (NOW(), "users", "insert", NEW.id, NEW.last_name);
END//

DELIMITER ;

DROP TRIGGER IF EXISTS delete_log_users;

DELIMITER //
CREATE TRIGGER delete_log_users BEFORE DELETE ON users
FOR EACH ROW BEGIN
  INSERT INTO logs values (NOW(), "users", "delete", users.id, users.last_name);
END//

DELIMITER ;


DROP TRIGGER IF EXISTS insert_log_faculties;

DELIMITER //
CREATE TRIGGER insert_log_faculties AFTER INSERT ON faculties
FOR EACH ROW BEGIN
  INSERT INTO logs values (NOW(), "faculties", "insert", NEW.id, NEW.name);
END//

DELIMITER ;

DROP TRIGGER IF EXISTS delete_log_faculties;

DELIMITER //
CREATE TRIGGER delete_log_faculties BEFORE DELETE ON faculties
FOR EACH ROW BEGIN
  INSERT INTO logs values (NOW(), "faculties", "delete", faculties.id, faculties.name);
END//

DELIMITER ;

DROP TRIGGER IF EXISTS insert_log_courses;

DELIMITER //
CREATE TRIGGER insert_log_courses AFTER INSERT ON courses
FOR EACH ROW BEGIN
  INSERT INTO logs values (NOW(), "courses", "insert", NEW.id, NEW.name);
END//

DELIMITER ;

DROP TRIGGER IF EXISTS delete_log_courses;

DELIMITER //
CREATE TRIGGER delete_log_courses BEFORE DELETE ON courses
FOR EACH ROW BEGIN
  INSERT INTO logs values (NOW(), "courses", "delete", courses.id, courses.name);
END//

DELIMITER ;

DROP TRIGGER IF EXISTS insert_log_events;

DELIMITER //
CREATE TRIGGER insert_log_events AFTER INSERT ON events
FOR EACH ROW BEGIN
  INSERT INTO logs values (NOW(), "events", "insert", NEW.id, NEW.name);
END//

DELIMITER ;

DROP TRIGGER IF EXISTS delete_log_events;

DELIMITER //
CREATE TRIGGER delete_log_events BEFORE DELETE ON events
FOR EACH ROW BEGIN
  INSERT INTO logs values (NOW(), "events", "delete", events.id, events.name);
END//

DELIMITER ;


