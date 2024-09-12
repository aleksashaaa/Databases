--1
CREATE DATABASE LAB1;

--2
CREATE TABLE users (
    id SERIAL,
    firstname VARCHAR(50),
    lastname VARCHAR(50)
);

--3
ALTER TABLE users
ADD isadmin INTEGER;

--4
ALTER TABLE users
ALTER COLUMN isadmin TYPE BOOLEAN
USING isadmin::boolean;

--5
ALTER TABLE users ALTER COLUMN isadmin SET DEFAULT false;

--6
ALTER TABLE users
ADD CONSTRAINT id_pkey PRIMARY KEY (id);

--7
CREATE TABLE tasks (
    id SERIAL,
    name VARCHAR(50),
    user_id INTEGER, CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES users(id)
);

--8
DROP TABLE IF EXISTS tasks;
DROP TABLE IF EXISTS users;

--9
DROP DATABASE IF EXISTS LAB1;