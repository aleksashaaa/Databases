CREATE DATABASE lab10;

CREATE TABLE books(
    book_id INTEGER PRIMARY KEY,
    title VARCHAR(250),
    author VARCHAR(250),
    price DECIMAL,
    quantity INTEGER
);

CREATE TABLE orders(
    order_id INTEGER PRIMARY KEY,
    book_id INTEGER,
    customer_id INTEGER,
    order_date DATE,
    quantity INTEGER,
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

CREATE TABLE customers(
    customer_id INTEGER PRIMARY KEY,
    name VARCHAR(250),
    email VARCHAR(250)
);

INSERT INTO books VALUES
  (1, 'Database 101', 'A. Smith', 40.00, 10),
  (2, 'Learn SQL', 'B. Johnson', 35.00, 15),
  (3, 'Advanced DB', 'C.Lee', 50.00, 5);

INSERT INTO customers VALUES
  (101, 'John Doe', 'johndoe@example.com'),
  (102, 'John Doe', 'johndoe@example.com');

--1
BEGIN TRANSACTION;
INSERT INTO orders VALUES (1, 1, 101, '2024-12-05', 2);
UPDATE books SET quantity = quantity - 2 WHERE book_id = 1;
COMMIT;

--2
BEGIN TRANSACTION;
INSERT INTO orders VALUES (2, 3, 102, '2024-12-15', 10);
DO $$
    BEGIN
    IF (SELECT quantity FROM books WHERE book_id = 3) >= 10
        THEN UPDATE books SET quantity = quantity - 10 WHERE book_id = 3;
    ELSE
        RAISE NOTICE 'unsufficient quantity';
    END IF;
end $$;
ROLLBACK;

--3
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
UPDATE books SET price = 25 WHERE book_id = 2;
COMMIT;

--4
BEGIN TRANSACTION;
UPDATE customers SET email = 'newemail@com' WHERE customer_id = 102;
COMMIT;




