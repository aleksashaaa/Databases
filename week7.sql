--1
SELECT * FROM countries WHERE name = 'string';
CREATE INDEX countries_name_index ON countries(name);

--2
SELECT * FROM employees WHERE name = 'string'
AND surname = 'string';
CREATE INDEX employees_name_surname_index ON employees(name, surname);

--3
SELECT * FROM employees WHERE salary < value1
AND salary > value2;
CREATE UNIQUE INDEX employees_salary_index ON employees(salary);

--4
SELECT * FROM employees WHERE substring(name
from 1 for 4) = 'abcd';
CREATE INDEX employees_name_substr_index
ON employees((substring(name from 1 for 4)));

--5
SELECT * FROM employees e JOIN departments d
ON d.department_id = e.department_id WHERE
d.budget > value2 AND e.salary < value2;

CREATE INDEX employees_department_index ON employees(department_id, salary);
CREATE INDEX department_budget_index ON employees(department_id, budget);