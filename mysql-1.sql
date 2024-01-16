show databases;
create database db_bc2311_1;
use db_bc2311_1;
CREATE USER 'vincentlau'@'localhost' IDENTIFIED BY 'yourpassword';
ALTER USER 'vincentlau'@'localhost' IDENTIFIED BY 'yournewpassword';
GRANT CREATE, ALTER, DROP, INSERT, UPDATE, SELECT, REFERENCES, RELOAD on *.* TO 'vincentlau'@'localhost' WITH GRANT OPTION;

create table customer(
    id integer not null,
    cust_name varchar(50) not null,
    cust_email_addr varchar(30),
    cust_phone varchar(50)
);

-- Drop the table
DROP TABLE customer;
DROP TABLE country;
DROP TABLE employee;

-- delete all data (without where)
delete from customer;

insert into customer(id, cust_name, cust_email_addr, cust_phone) values (6, 'dummy', 'dummyu@gmail.com' , 'dummy');
delete from customer where cust_NAME = 'dummy';
select * from customer order by id asc;


insert into customer(id, cust_name, cust_email_addr, cust_phone) values (1, 'John Lau', 'joinlau@gmail.com' , '12345678');
insert into customer(id, cust_name, cust_email_addr, cust_phone) values (2, 'Sunny Wong', 'sunnywong@gmail.com' , '123445678');
insert into customer(id, cust_name, cust_email_addr, cust_phone) values (3, 'CHristy Cheung' , null , null);
insert into customer(id, cust_name, cust_email_addr, cust_phone) values (4, 'Mary Lau' , 'marylau@yahoo.com.hk', '1234567890');


delete from customer where id = 3;

-- where
select * from customer where id = 4;
select * from customer where cust_name = 'John Lau' and cust_phone = '12345678';
select * from customer where cust_name = ('John Lau' or cust_email_addr = 'sunnywong@gmail.com') and cust_email_addr = 'joinlau@gmail.com';

-- where + order by
-- desc (descending order)
-- asc (ascending order)
select * from customer where cust_name = 'John Lau' or cust_email_addr = 'sunnywong@gmail.com' order by id desc;
select * from customer where cust_name = 'John Lau' or cust_email_addr = 'sunnywong@gmail.com' order by cust_name desc;
select * from customer where cust_name = 'John Lau' or cust_email_addr = 'sunnywong@gmail.com' order by cust_name; -- asc by default

insert into customer(id, cust_name, cust_email_addr, cust_phone) values (5, 'Sunny Wong' , 'sunnywong@yahoo.com.hk', '87654321');
select * from customer where cust_name = 'John Lau' or cust_name = 'Sunny Wong' order by cust_phone asc, cust_name desc;

-- where -> like
-- % means any character(s) or no character
insert into customer(id, cust_name, cust_email_addr, cust_phone) values (7, 'Tommy Lau' , 'tommylau@yahoo.com.hk', '1234');

select * from customer where cust_name like '%Lau';
select * from customer where cust_name like '%Lau%'; -- return John Lau, Mary Lau
select * from customer where cust_name like 'Sunny%'; -- return John Lau, Mary Lau
select * from customer where cust_name like '%Sunny%'; -- Sunny Wong, Sunny Wong
select * from customer where cust_email_addr like '%@%' or cust_email_addr is null order by id asc; -- Sunny Wong, Sunny Wong

select * from customer;

select * from customer order by id asc;

-- alter table add/modify/ drop

-- add a new column
alter table customer add join_date date;

select * from customer;

-- update --String Method
update customer set join_date = str_to_date ("1990-01-01", "%Y-%m-%d"); -- set all column to this with the format
update customer set join_date = str_to_date ("1990 01 01", "%Y %m %d");

update customer set join_date = str_to_date ("1990 01 10", "%Y %m %d") where id = 2;

-- VARCHAR, INTEGER, DATE, DECIMAL, DATETIME
alter table customer add score decimal(5,2); -- 3 digits for integer, 2 digits for deciaml places, max value 99.999

insert into customer(id, cust_name, cust_email_addr, cust_phone, join_date , score) 
values (5, 'Sunny Wong' , 'sunnywong@yahoo.com.hk', '8765344321', str_to_date ("1990-01-01", "%Y-%m-%d"), 120.56);

insert into customer(id, cust_name, cust_email_addr, cust_phone, join_date , score) 
values (8, 'Sunny chan' , 'sunnychan@yahoo.com.hk', '8765344321', str_to_date ("1990-01-01", "%Y-%m-%d"), 120.56);

insert into customer(id, cust_name, cust_email_addr, cust_phone, join_date , score) 
values (9, 'Amy Kwun' , 'amykwun@yahoo.com.hk', '87653443df1', str_to_date ("1990-01-01", "%Y-%m-%d"), 999.99);

update customer set score = -1000 where id = 9; -- error, 1000 is out of range for deciaml(5,2)

alter table customer add last_transaction_time datetime;

insert into customer(id, cust_name, cust_email_addr, cust_phone, join_date , score, last_transaction_time) 
values (10, 'Gigi Kwun' , 'gigikwun@yahoo.com.hk', '876534dfdf1', str_to_date ("1990-01-01", "%Y-%m-%d"), 999.99, str_to_date('1990-01-01 12:20:21' , '%Y-%m-%d %H:%i:%s'));

select * from customer order by id asc;

-- Some other approaches to insert data
insert into customer(id, cust_name, cust_email_addr, cust_phone, join_date , score, last_transaction_time) 
values (11, 'Jason Kwun' , 'jasonkwun@yahoo.com.hk', '12334dfdf1', str_to_date ("1990-01-01", "%Y-%m-%d"), 99.99, str_to_date('1990-01-10 12:10:21' , '%Y-%m-%d %H:%i:%s'));

-- error, by default you should provide all column values when you skip the column description
-- insert into customer values (11, 'Jason Kwun' , 'jasonkwun@yahoo.com.hk', '12334dfdf1', str_to_date ("1990-01-01", "%Y-%m-%d"), 99.99, str_to_date('1990-01-10 12:10:21' , '%Y-%m-%d %H:%i:%s'));

-- keep part of description
insert into customer(id, cust_name, join_date , score, last_transaction_time) 
values (11, 'Wilson Kwun' ,  str_to_date ("1990-02-01", "%Y-%m-%d"), 99.99, str_to_date('1990-01-10 12:10:21' , '%Y-%m-%d %H:%i:%s'));

-- between and (inclusive)
select * from customer where join_date between str_to_date ("2023-01-01", "%Y-%m-%d") and str_to_date ("2023-12-31", "%Y-%m-%d");
select * from customer where join_date >= str_to_date ("2023-01-01", "%Y-%m-%d") and join_date <= str_to_date ("2023-12-31", "%Y-%m-%d");

-- where: >, < , >=, <=
-- ifnull(x,100) treat null value as another specified value (100) here
select * from customer where score > 0 and score < 1000 and id < 10;
select * from customer where score > 0 and score < 1000 or id < 10 order by id asc;
select * from customer where ifnull(score,100) > 99 and ifnull(score,1000) < 1000;

-- alter table -> drop column
alter table customer add dummy VARCHAR(10);
alter table customer drop dummy;

-- alter table customer -> modify column
-- extend the length of the column
alter table customer modify column cust_email_addr varchar(50); -- extend length from 30 to 50

-- Shorten the length of the column
-- Error because some existing data at the length
alter table customer modify column cust_email_addr varchar(10); -- shorten length from 50 to 10
-- Shorten the length of the column

-- Find the customer with score > 100, and showing the id, cust_name, join_date of result set.
select id, cust_name, join_date, score from customer where score > 100;

-- IS NULL, IS NOT NULL
-- select column
-- where row
select id, score from customer where score is not null;


select * from customer order by id asc;

-- String Function
-- can select the column multiple of time
select upper(c.cust_name) , lower(c.cust_name), c.cust_name from customer;

-- as to change the name of column shown without changing the current table
select upper(c.cust_name) as customer_name_upper_case
, lower(c.cust_name) as customer_name_lower_case
, c.cust_name as customer_name
, length(c.cust_name) as customer_name_length
, substring(c.cust_name, 1,3) as customer_name_prefix
, concat(c.cust_name, ', email address: ', c.cust_email_addr) as customer_info
, replace(c.cust_name, 'Lau', 'Chan') as new_customer_name
,left (c.cust_name, 3) -- get the orignal left to right
,right (c.cust_name,2) 
, trim(c.cust_name) -- remove leading and tail spaces
, replace(c.cust_name, ' ', '')
from customer c;

-- MySQL case-insensitive
select * from customer where cust_name = 'Mary Lau';
select * from customer where cust_name = 'mary Lau'; -- still can return, case-insensitive

-- Like: %, _
select * from customer where cust_name like '_ohn%'; -- There is only one character before 'e'
select * from customer where cust_name like '_John%';-- _ any single character, no result

select * from customer;

select c.* -- additional return result, no change to the original
, 1 as one
, 'dummy value' as dummy_column
, round(c.score, 1) rounded_score
, ceil(c.score) as ceiling_value
, floor(c.score) as floor_value
, abs(c.score) as abs_value
, power(c.score, 2) as power2_score
, date_add(join_date, interval 3 year) as three_year_after_join_date
, date_add(join_date, interval 3 month) as three_month_after_join_date
, date_add(join_date, interval 3 day) as three_day_after_join_date
, join_date + interval 1 day -- correct
, join_date -1 -- wrong syntax in MYSQL
, join_date - interval 1 day -- correct
, datediff('2000-01-01', join_date) as number_of_days_between_joindate_1990_12_31
, datediff(join_date, join_date)
, now() as curr_time
from customer c;

-- select this as ..... from customer c; 

-- CASE
-- select the result from the table
-- set the range
-- end as grade
select cust_name, score,
case
when score < 20 then'Fail'
when score < 100 then 'Pass'
when score < 1000 then 'Excellent'
else 'N/A'
end as grade
from customer;

select * from customer;

-- primary key is one of the constraint: not null, unqiue, index
create table department (
id integer primary key, -- 1,2,3,4
dept_name varchar(50),
dept_code varchar(10) -- HR, IT
);

select * from department;

-- primary key is one of the constraint not null, unique
create table empolyee (
id integer primary key, -- unique and not null , index
staff_id varchar(50),
staff_name varchar(50),
hkid varchar(10) unique, -- not null, unique
dept_id integer, -- link to department table
-- ensure integritity
foreign key (dept_id) references department(id)
); -- this is the info from other table department
-- if no foreign key in the table -> fail

select * from empolyee;

create table empolyee_contact_info (
id integer primary key, 
phone varchar(50),
foreign key (id) references empolyee(id)
); 

insert into empolyee_contact_info values (1, '12345');

alter table empolyee add country_id integer;
alter table empolyee add constraint fk_country_id foreign key (country_id) references country(id);

create table country (
id integer primary key,
country_code varchar(2) unique,
description varchar(50)
);

select * from country;
select * from empolyee;
insert into department values (1, 'Human Resource', 'HR');
insert into department values (2, 'Information Technology', 'IT');

insert into empolyee values (1, '001', 'John Lau', 'A1234567', 2, 1);
insert into empolyee values (2, '002', 'Mary Chan', 'A1234568', 1, 2);
-- insert into empolyee values (3, '003', 'Jenny Wong', 'A1234569', 3); -- error, because dept_id 3 does not exists in table department
insert into empolyee values (3, '003', 'Sunny Lau', 'A1234598', 2, 2);

-- inner join
select*
from empolyee inner join department; -- inner join

select e.id, e.staff_id, e.staff_name, d.dept_name, d.dept_code, c.country_code, c.description
from empolyee e inner join department d on e.dept_id = d.id 
inner join country c on e.country_id = c.id;

select * from empolyee;
insert into country values (1, 'HK', 'Hong Kong');
insert into country values (2, 'UK', 'United Kingdom');
update empolyee set country_id = 1; -- if no data in country, cannot update

select e.id, e.staff_id, e.staff_name, d.dept_name, d.dept_code, c.country_code, c.description
from empolyee e 
inner join department d on e.dept_id = d.id -- join this table on this column
inner join country c;

-- inner join without key, all records join (Inner join demo in a wrong way)
select e.id, e.staff_id, e.staff_name, d.dept_name, d.dept_code, c.country_code, c.description
from empolyee e 
inner join department d;
inner join country c;

-- Another approach to perform inner join
select e.id, e.staff_id, e.staff_name, d.dept_name, d.dept_code -- if null not show
from empolyee e, department d
where e.dept_id = d.id -- this two link and this equal this...
and d.dept_code = 'IT'; -- select the specified code

-- Left Join
insert into department values(3, 'Marketing', 'MK');

select d.*, e.*
from department d left join empolyee e on e.dept_id = d.id;

insert into empolyee values (4, '004', 'Peter Lau', 'A12324598', 3, 2);
insert into empolyee values (5, '005', 'Peter Lau', 'Ac23424598', 3, 2);

-- group by
-- group the dept_id and count 

-- count() -> aggregrate
select e.dept_id, count(1) as number_of_employee
from empolyee e
group by e.dept_id;

select * from empolyee;
-- year_of_exp
alter table empolyee add year_of_exp integer;
update empolyee set year_of_exp = 1 where id = 2;
update empolyee set year_of_exp = 10 where id = 3;
update empolyee set year_of_exp = 20 where id = 1;
update empolyee set year_of_exp = 5 where id = 4;
update empolyee set year_of_exp = 5 where id = 5;

-- group by: max(year_of_exp)
select e.dept_id, count(1) as number_of_employee, min(year_of_exp), avg(year_of_exp)         -- e.staff_name error dont know which staff
from empolyee e
group by e.dept_id; -- by group to find the data 
-- if no group by just find the whole table

select avg(year_of_exp) from empolyee;

-- Find the staff name with max year of explain


select *
from empolyee
where year_of_exp = (select max(year_of_exp) from empolyee);

-- CTE
-- the result can be reused
with max_year_of_exp as(
select max(year_of_exp) as max_exp 
from empolyee
) , min_year_of_exp as (
select min(year_of_exp) as min_exp
from empolyee
)

select *
from empolyee e, max_year_of_exp m -- subquery can be reused
where e.year_of_exp = m.max_exp;

-- group by + join
select e.dept_id, count(1) as number_of_empolyee
from empolyee e, department d
where e.dept_id = d.id -- filter the record
and d.dept_code in ('IT', 'MK') -- filter record before group by
group by e.dept_id
having count(1) > 1 -- filter group after group by
;

-- Union & Union All
-- remove duplicated records according to id and name 
select e.id, e.staff_name, 'STAFF' as 'Group'
from empolyee e -- add a group to see belong to which
Union
select c.id, c.cust_name, 'CUSTOMER' as 'Group'
from customer c;

-- remove duplicate according to the name only
select e.staff_name, 'STAFF' as 'Group'
from empolyee e -- add a group to see belong to which
Union
select c.cust_name, 'CUSTOMER' as 'Group'
from customer c;

-- Union All -- show all records from all result set
select e.id, e.staff_name, 'STAFF' as 'Group'
from empolyee e -- add a group to see belong to which
Union All
select c.id, c.cust_name, 'CUSTOMER' as 'Group'
from customer c;

select e.id, e.staff_name as name
from empolyee e 
Union All
select c.id, c.cust_name as name
from customer c
Union All
select e.id, e.staff_name AS name
from empolyee e


