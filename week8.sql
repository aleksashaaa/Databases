--1
CREATE DATABASE lab8;

--2
CREATE TABLE salesman(
    salesman_id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    city VARCHAR(255),
    commission DECIMAL(3, 2)
);

INSERT INTO salesman
VALUES (5001, 'James Hoog', 'New York', 0.15),
       (5002, 'Nail Knite', 'Paris', 0.13),
       (5005, 'Pit Alex', 'London', 0.11),
       (5006, 'Mc Lyon', 'Paris', 0.14),
       (5003, 'Lauson Hen', default, 0.12),
       (5007, 'Paul Adam', 'Rome', 0.13);

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    cust_name VARCHAR(255),
    city VARCHAR(255),
    grade INTEGER,
    salesman_id INTEGER,
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

INSERT INTO customers
VALUES (3002, 'Nick Rimando', 'New York', 100, 5001),
       (3005, 'Graham Zusi', 'California', 200, 5002),
       (3001, 'Brad Guzan', 'London', default, 5005),
       (3004, 'Fabian Johns', 'Paris', 300, 5006),
       (3007, 'Brad Davis', 'New York', 200, 5001),
       (3009, 'Geoff Camero', 'Berlin', 100, 5003),
       (3008, 'Julian Green', 'London', 300, 5002);

CREATE TABLE orders(
    ord_no INTEGER PRIMARY KEY,
    purch_amt DECIMAL(10, 2),
    ord_date DATE,
    customer_id INTEGER,
    salesman_id INTEGER,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);


INSERT INTO orders
VALUES (70001, 150.5, '2012-10-05', 3005, 5002),
       (70009, 270.65, '2012-09-10', 3001, 5005),
       (70002, 65.26, '2012-10-05', 3002, 5001),
       (70004, 110.5, '2012-08-17', 3009, 5003),
       (70007, 948.5, '2012-09-10', 3005, 5002),
       (70005, 2400.6, '2012-07-27', 3007, 5001),
       (70008, 5760, '2012-09-10', 3002, 5001);

--3
CREATE ROLE junior_dev LOGIN;

--4
CREATE VIEW ny_salesman AS
    SELECT * FROM salesman
    WHERE city = 'New York';
SELECT * FROM ny_salesman;

--5
CREATE VIEW order_by_name AS
    SELECT o.ord_no, o.purch_amt, o.ord_date, c.cust_name, s.name
    FROM orders o
    JOIN salesman s ON o.salesman_id=s.salesman_id
    JOIN customers c ON o.customer_id = c.customer_id;
SELECT * FROM order_by_name;

GRANT ALL PRIVILEGES ON order_by_name TO junior_dev;
--6
CREATE VIEW high_grade_customers AS
    SELECT * FROM customers
             WHERE grade = (SELECT max(grade) FROM customers);
SELECT * FROM high_grade_customers;

GRANT SELECT ON high_grade_customers TO junior_dev;

--7
CREATE VIEW salesmans_in_cities AS
    SELECT count(*), city FROM salesman GROUP BY city;
SELECT * FROM salesmans_in_cities;

--8
CREATE VIEW salesman_with_multiple_cust AS
    SELECT s.salesman_id, s.name, count(c.salesman_id) FROM salesman s
    JOIN customers c on s.salesman_id = c.salesman_id
    GROUP BY s.salesman_id, s.name
HAVING count(c.customer_id) > 1;
drop view salesman_with_multiple_cust;
SELECT * FROM salesman_with_multiple_cust;

--9
CREATE ROLE intern;
GRANT junior_dev TO intern;