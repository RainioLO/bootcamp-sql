CREATE DATABASE ORG;

SHOW DATABASES;

USE ORG;

CREATE TABLE worker(
	worker_id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name CHAR(25),
    last_name CHAR(25),
    salary NUMERIC(15),
    joining_date DATETIME,
    department CHAR(25)
);

INSERT INTO worker
	(first_name, last_name, salary, joining_date, department) VALUES
		('Monika','Arora', 100000, '21-02-20 09:00:00','HR'),
        ('Niharika','Verma', 80000, '21-06-11 09:00:00','Admin'),
        ('Vishal','Singhal', 300000, '21-02-20 09:00:00','HR'),
        ('Mohan','Sarah', 300000, '12-03-19 09:00:00','Admin'),
        ('Amitabh','Singh', 500000, '21-02-20 09:00:00','Admin'),
        ('Vivek','Bhati', 490000, '21-06-11 09:00:00','Admin'),
        ('Vipul','Diwan', 200000, '21-06-11 09:00:00','Account'),
        ('Satish','Kumar', 75000, '21-01-20 09:00:00','Account'),
        ('Geetika','Chauhan', 90000, '21-04-11 09:00:00','Account');

CREATE TABLE bonus(
	worker_ref_id INTEGER,
    bonus_amount NUMERIC(10),
    bonus_date DATETIME,
    FOREIGN KEY (worker_ref_id) REFERENCES worker(worker_id)
);

SELECT * FROM BONUS;
SELECT * FROM WORKER;

# Task 1
INSERT INTO BONUS (WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE)
VALUES (6, 32000, str_to_date ("2021-11-02", "%Y-%m-%d"));

INSERT INTO BONUS (WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE)
VALUES (6, 20000, str_to_date ("2022-11-02", "%Y-%m-%d"));

INSERT INTO BONUS (WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE)
VALUES (5, 21000, str_to_date ("2021-11-02", "%Y-%m-%d"));

INSERT INTO BONUS (WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE)
VALUES (9, 30000, str_to_date ("2021-11-02", "%Y-%m-%d"));

INSERT INTO BONUS (WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE)
VALUES (8, 4500, str_to_date ("2022-11-02", "%Y-%m-%d"));

select * from worker;

# Task 2
select Max(salary) as second_highest
from worker 
where salary < (select Max(salary) from worker);

# Task 3
SELECT w1.department, w1.salary AS highest_salary, w2.first_name
FROM (
SELECT department, MAX(salary) AS salary
FROM worker
GROUP BY department
) AS w1
JOIN worker w2 ON w1.department = w2.department AND w1.salary = w2.salary;

# Task 4
select w1.first_name as Employee_1, w2.first_name as Employee_2, w1.salary
from worker w1, worker w2
where w1.salary = w2.salary
and w1.first_name <> w2.first_name;

# Task 5
select w1.first_name, (w1.salary+b.bonus_amount) as total_income
from worker w1, bonus b
where b.worker_ref_id = w1.worker_id
and year(b.bonus_date) =2021;

# Task 6
delete from worker;

# Task 7
drop table worker;
-- contains fk from bonus


