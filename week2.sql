-- 1
CREATE DATABASE LAB2;

-- 2
CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR,
    region_id INTEGER,
    population INTEGER
);

-- 3
INSERT INTO countries VALUES (
        default, 'Kazakhstan', 1, 19000000);

-- 4
INSERT INTO countries VALUES (
        default, 'Japan');

-- 5
INSERT INTO countries
VALUES (default,'Mexico', NULL, 130000000);

--6
INSERT INTO countries (country_name, region_id, population)
VALUES
('China', 1, 1411000000),
('France', 2, 6000000),
('Sweden', 2, 10000000);

--7
ALTER TABLE countries ALTER COLUMN country_name
    SET DEFAULT 'Kazakhstan';

--8
INSERT INTO countries (region_id, population)
VALUES (1, 10000);

--9
INSERT INTO countries DEFAULT VALUES;

--10
CREATE TABLE countries_new (LIKE countries);

--11
INSERT INTO countries_new  SELECT * FROM countries;

--12
UPDATE countries_new SET region_id=1
WHERE region_id IS NULL;

--13
SELECT country_name, (population * 1.1) AS "New Population"
FROM countries;

--14
DELETE FROM countries WHERE population < 100000 RETURNING *;

--15
DELETE FROM countries_new
USING countries
WHERE countries_new.country_id = countries.country_id
RETURNING *;

--16
DELETE FROM countries RETURNING *;


--DROP TABLE countries_new;
--DROP TABLE countries;
