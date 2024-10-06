--1
CREATE DATABASE lab4;

--2
CREATE TABLE warehouses (
    code SERIAL,
    location VARCHAR(255),
    capacity INTEGER
);

CREATE TABLE boxes (
    code CHAR(4),
    contents VARCHAR(255),
    value REAL,
    warehouse INTEGER
);

--3
INSERT INTO warehouses(location, capacity)
 VALUES ('Chicago', 3),
        ('Chicago', 4),
        ('New York', 7),
        ('Los Angeles', 2),
        ('San Francisco', 8);

INSERT INTO boxes
 VALUES ('0MN7', 'Rocks', 180, 3),
        ('4H8P', 'Rocks', 250, 1),
        ('4RT3', 'Scissors', 190, 4),
        ('7G3H', 'Rocks', 200, 1),
        ('8JN6', 'Papers', 75, 1),
        ('8Y6U', 'Papers', 50, 3),
        ('9J6F', 'Papers', 175, 2),
        ('LL08', 'Rocks', 140, 4),
        ('P0H6', 'Scissors', 125, 1),
        ('P2T6', 'Scissors', 150, 2),
        ('TU55', 'Papers', 90, 5);

--4
SELECT * FROM warehouses;

--5
SELECT * FROM boxes
 WHERE value > 150;

--6
SELECT DISTINCT ON(contents) * FROM boxes;

--7
SELECT warehouse, count(*)
 FROM boxes
  GROUP BY warehouse;

--8
SELECT warehouse, count(*)
 FROM boxes
  GROUP BY warehouse
  HAVING count(*) > 2;

--9
INSERT INTO warehouses(location, capacity)
 VALUES ('New York', 3);

--10
INSERT INTO boxes
 VALUES ('H5RT', 'Papers', 200, 2);

--11
UPDATE boxes
 SET value = value * 0.85
  WHERE value = (SELECT DISTINCT ON(value) value
                    FROM boxes ORDER BY value DESC
                        OFFSET 2 LIMIT 1);

--12
DELETE FROM boxes WHERE value < 150
 RETURNING *;

--13
DELETE FROM boxes
 WHERE warehouse IN (SELECT code FROM warehouses
                                 WHERE location = 'New York')
RETURNING *;

--or
DELETE FROM boxes
USING warehouses
 WHERE boxes.warehouse = warehouses.code
  AND warehouses.location = 'New York'
RETURNING boxes.*;