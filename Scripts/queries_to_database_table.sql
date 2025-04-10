-- Код, реализующий проекцию:
-- Позволяет получить имена и номера телефонов пользователей
SELECT name, phone
FROM user_pool;

-- Позволяет получить имена и зарплаты работников
SELECT name, salary
FROM employer;

-- Позволяет получить id курса и место проведения
SELECT id_course, address
FROM course;


-- Код, реализующий селекцию:
-- Позволяет получить информацию о пользователе с ФИО - Иванов Иван Иванович
SELECT *
FROM user_pool
WHERE name = 'Иванов Иван Иванович';

-- Позволяет получить информацию о работниках, зарплата которых выше 30000
SELECT *
FROM employer
WHERE salary > 30000;

-- Позволяет получить информацию о работниках с должностью Сторож
SELECT *
FROM employer
WHERE job_title = 'Сторож';


-- Код, реализующий объединение:
-- Позволяет получить имена всех людей и пользователей и работников
SELECT name
FROM user_pool UNION
SELECT name
FROM employer;

-- Позволяет получить имена и номера всех людей и пользователей,и работников. Отсортировано по имени
SELECT name, phone
FROM user_pool UNION
SELECT name, phone
FROM employer
ORDER BY name;

-- Позволяет получить имена и возраст всех людей и пользователей, и работников. Отсортировано по возрасту
SELECT name, age
FROM user_pool UNION
SELECT name, age
FROM employer
ORDER BY age;

-- Код для оператора, отвечающего за пересечение:
-- Позволяет получить информацию о всех тренерах (тренером
-- является тот чей id_employer есть как в таблице employer, так
-- и в таблице coach)
SELECT *
FROM employer
WHERE id_employer IN (SELECT id_employer
FROM employer INTERSECT
SELECT id_employer
FROM coach);

-- Позволяет получить id пользователей, состоящих в какой-нибудь
-- группе (в группе если id_user есть и в таблице user_pool и в
-- таблице user_pool_our_group)
SELECT id_user
FROM user_pool INTERSECT
SELECT id_user
FROM user_pool_our_group;

-- Позволяет получить id работников, что ведут какую-нибудь
-- группу (ведут группу если есть в таблице employer и
-- our_group)
SELECT id_employer
FROM coach INTERSECT
SELECT id_coach
FROM our_group;

-- Код для оператора, отвечающего за разность:
-- Позволяет получить информацию о всех не тренерах (тренером не
-- является тот чей id_employer есть в таблице employer, но нет
-- в таблице coach)
SELECT *
FROM employer
WHERE id_employer IN (SELECT id_employer
FROM employer EXCEPT
SELECT id_employer
FROM coach);

-- Позволяет получить id пользователей, несостоящих в какой
-- нибудь группе (в группе если id_user есть в таблице
-- user_pool, но нет в таблице user_pool_our_group)
SELECT id_user
FROM user_pool EXCEPT
SELECT id_user
FROM user_pool_our_group;

-- Позволяет получить id работников, что не ведут какую-нибудь
-- группу (не ведут группу если есть в таблице employer, но нет
-- our_group)
SELECT id_employer
FROM coach EXCEPT
SELECT id_coach
FROM our_group;

-- Код для оператора, отвечающего за декартово произведение:
-- Соединяет каждое имя пользователя с каждым id мед карты
SELECT name, mc.id_med_cart
FROM user_pool CROSS JOIN med_cart mc;

-- Соединяет работника с каждым кабинетом
SELECT name, cabinet
FROM employer CROSS JOIN coach;

-- Соединяет каждый курс с каждой группой
SELECT id_course, id_group
FROM course CROSS JOIN our_group;
Код для оператора, отвечающего за соединение:

-- Выдать информацию о пользователе и его мед карте, с id равным 1
SELECT *
FROM user_pool INNER JOIN med_cart ON user_pool.id_med_cart =
med_cart.id_med_cart
WHERE id_user=1;

-- Выдать информацию о работниках и разряд, кабинет, достижения
SELECT *
FROM employer INNER JOIN coach ON employer.id_employer = coach.id_employer;

-- Выдать имя пользователя и время его занятия в группе
SELECT name, time
FROM user_pool INNER JOIN
(SELECT id_user, time
FROM our_group INNER JOIN user_pool_our_group upog on
our_group.id_group = upog.id_group) gr
ON gr.id_user = user_pool.id_user;


-- Код для оператора, отвечающего за группировку:
-- Позволяет получить количество мужчин и женщин пользователей
SELECT sex, COUNT(id_user)
FROM user_pool
GROUP BY sex;

-- Позволяет получить количество пользователей в каждой группе
SELECT id_group, COUNT(id_user)
FROM user_pool_our_group
GROUP BY id_group;

-- Позволяет получить количество работников каждой профессии
-- отсортировано по количеству работников от большего к меньшему
SELECT job_title, COUNT(id_employer)
FROM employer
GROUP BY job_title
ORDER BY COUNT(id_employer) DESC ;