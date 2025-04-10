-- Создание таблицы employer
CREATE TABLE employer(
id_employer SERIAL PRIMARY KEY,
name VARCHAR(30) NOT NULL,
salary INT NOT NULL,
job_title VARCHAR(50) NOT NULL,
experience DECIMAL(4, 2) NOT NULL,
phone VARCHAR(12) NOT NULL,
age INT NOT NULL,
med_book INT NOT
);

-- Создание таблицы course
CREATE TABLE course(
id_course SERIAL PRIMARY KEY,
id_coach INT NOT REFERENCES employer(id_employer),
name VARCHAR(30) NOT NULL,
address VARCHAR(50) NOT NULL,
time_start TIME NOT NULL,
time_end TIME NOT
);

-- Создание таблицы our_group
CREATE TABLE our_group(
id_group SERIAL PRIMARY KEY,
id_coach INT NOT REFERENCES employer(id_employer),
time TIME NOT
);

-- Создание таблицы coach
CREATE TABLE coach(
id_employer INT NOT REFERENCES employer,
category VARCHAR(30) NOT NULL,
cabinet INT NOT NULL,
awards VARCHAR(30)
);

-- Создание таблицы med_cart
CREATE TABLE med_cart(
id_med_cart SERIAL PRIMARY KEY,
health_comment VARCHAR(50) NOT NULL,
conclusion VARCHAR(50) NOT NULL,
status VARCHAR(50) NOT
);

-- Создание таблицы menu
CREATE TABLE menu(
id_menu SERIAL PRIMARY KEY,
name VARCHAR(30),
table_number INT NOT
);

-- Создание таблицы user_pool
CREATE TABLE user_pool(
id_user SERIAL PRIMARY KEY,
name VARCHAR(30) NOT NULL,
sex VARCHAR(3) NOT NULL,
phone VARCHAR(12) NOT NULL,
id_med_cart INT REFERENCES med_cart(id_med_cart) ON DELETE
CASCADE,
pass_info VARCHAR(15),address VARCHAR(30),
id_menu INT NOT REFERENCES menu(id_menu),
age INT NOT
);

-- Создание таблицы user_pool_our_group
CREATE TABLE user_pool_our_group(
id SERIAL PRIMARY KEY,
id_group INT NOT REFERENCES our_group,
id_user INT NOT REFERENCES user_pool,
);

-- Создание таблицы our_group_course
CREATE TABLE our_group_course(
id SERIAL PRIMARY KEY,
id_group INT NOT REFERENCES our_group,
id_course INT NOT REFERENCES course
);

-- Создание таблицы user_pool_audit
CREATE TABLE user_pool_audit(
operation char(1) NOT NULL,
userid text NOT NULL,
stamp timestamp NOT
);
