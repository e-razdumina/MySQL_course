DROP DATABASE shop;
CREATE DATABASE shop;
USE shop;

DROP TABLE users;

CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- task 1.1

ALTER TABLE users DROP COLUMN created_at;
ALTER TABLE users DROP COLUMN updated_at;

SELECT * FROM users LIMIT 10;

ALTER TABLE users ADD COLUMN created_at DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE users ADD COLUMN updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

UPDATE users SET created_at = CURRENT_TIMESTAMP;
UPDATE users SET updated_at = CURRENT_TIMESTAMP;

-- task 1.2

ALTER TABLE users DROP COLUMN created_at;
ALTER TABLE users DROP COLUMN updated_at;

SELECT * FROM users LIMIT 10;

ALTER TABLE users ADD COLUMN created_at VARCHAR(100);
ALTER TABLE users ADD COLUMN updated_at VARCHAR(100);

INSERT INTO users VALUES
  (DEFAULT, 'Катя', 'Иванова', '2014.02.28 09', '2014.02.28 09')
;

UPDATE users SET 
  created_at = STR_TO_DATE(created_at, '%Y.%m.%d %h'),
  updated_at = STR_TO_DATE(updated_at, '%Y.%m.%d %h')
  ;
 
ALTER TABLE users MODIFY COLUMN created_at DATETIME; 
ALTER TABLE users MODIFY COLUMN updated_at DATETIME; 

DESC users;

-- task 1.3
-- не разобралась как вынести вниз нулевые значения. предложенный ниже вариант выдает ошибку

DROP TABLE storehouses_products;

CREATE TABLE storehouses_products (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  product VARCHAR(100) NOT NULL,
  value INT UNSIGNED
);


INSERT INTO storehouses_products VALUES
  (DEFAULT, 'материнская плата', 5),
  (DEFAULT, 'монитор', 0),
  (DEFAULT, 'бесперебойник', 20),
  (DEFAULT, 'камера', 35)
;


SELECT * FROM storehouses_products ORDER BY CASE WHEN value > 1 END;


-- task 2.1

DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');

SELECT AVG (FLOOR ((TO_DAYS(NOW()) - TO_DAYS(birthday_at)) / 365.25)) AS average_age FROM users;


-- task 2.2

SELECT id, name, DAYOFWEEK(DATE_FORMAT(birthday_at, '%d.%m.%2020')) AS day, 
DAYNAME(DATE_FORMAT(birthday_at, '%d.%m.%2020')) as dayname FROM users;

SELECT COUNT(*), DAYNAME(DATE_FORMAT(birthday_at, '%d.%m.%2020')) as dayname FROM users GROUP BY dayname;




