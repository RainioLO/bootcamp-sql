
create table book (
    id serial primary key, -- auto-increment integer
    author_id integer,
	book_name VARCHAR(50) not null,
	constraint fk_author_id foreign key (author_id) references author(id)
	-- fk_author_id common in whole script can't duplicate
);

insert into book (author_id, book_name) values (1, 'ABC');
insert into book (author_id, book_name) values (1, 'CDC');
insert into book (author_id, book_name) values (2, 'WALKING DEAD');
select * from book;

create table author(
    id serial primary key, -- auto-increment integer
    author_name VARCHAR(50) not null,
	nat_code VARCHAR(2) not null,
	constraint fk_nat_code foreign key (nat_code) references nationality (nat_code)
);
select * from author;

insert into author (author_name, nat_code) values ('JOHN WONG', 'SG');
insert into author (author_name, nat_code) values ('Lee', 'HK');

create table nationality(
    id serial primary key, -- auto-increment integer
    nat_code VARCHAR(2) unique not null,
    nat_desc VARCHAR(50) not null
);

insert into nationality (nat_code, nat_desc) values ('HK', 'HONG KONG');
insert into nationality (nat_code, nat_desc) values ('SG', 'SINGAPORE');
select * from nationality;

create table users(
    id serial primary key,
    user_name VARCHAR(50) not null
);

insert into users (user_name) values ('Johnson Wong');
insert into users (user_name) values ('Amy Lau');
select * from users;

create table user_contact(
    id serial primary key,
    user_id integer unique, -- unique + fk (one to one)
	user_phone varchar(100) not null,
	user_email varchar(100),
	constraint fk_user_id foreign key (user_id) references users(id)
);
insert into user_contact (user_id, user_phone, user_email)
values (1, '64759366', 'dhff@gmail.com');
insert into user_contact (user_id, user_phone, user_email)
values (2, '46759366', 'amylau@gmail.com');
select * from user_contact;

-- Many to many
create table borrow_history(
    id serial primary key,
    user_id integer not null,
	book_id integer not null,
	borrow_date timestamp not null,
	constraint fk_history_user_id foreign key (user_id) references users(id),
	constraint fk_history_book_id foreign key (book_id) references book(id)
);

insert into borrow_history (user_id, book_id, borrow_date)
values(1, 2, '2022-01-15 12:30:00');
insert into borrow_history (user_id, book_id, borrow_date)
values(3, 1, '2022-02-15 10:33:00');
insert into borrow_history (user_id, book_id, borrow_date)
values(2, 1, '2022-01-15 17:30:00');
insert into borrow_history (user_id, book_id, borrow_date)
values(2, 2, '2022-02-15 14:30:00');
insert into borrow_history (user_id, book_id, borrow_date)
values(2, 3, '2023-02-15 14:30:00');

select * from borrow_history;

-- One to one
create table return_history(
    id serial primary key,
	borrow_id integer unique not null,
	return_date timestamp not null,
	constraint fk_return_book_id foreign key (borrow_id) references borrow_history(id)
);

insert into return_history (borrow_id, return_date)
values(1, '2022-01-16 12:30:00');
insert into return_history (borrow_id, return_date)
values(2, '2022-03-18 12:30:00');
insert into return_history (borrow_id, return_date)
values(3, '2022-01-20 12:30:00');
insert into return_history (borrow_id, return_date)
values(4, '2023-01-20 12:30:00');
insert into return_history (borrow_id, return_date)
values(5, '2025-01-20 12:30:00');



select * from return_history;

-- Find the user (uner_name), who has the longest total book borrowing time (no of days)



select bh.borrow_date, b.book_name, u.user_name, a.author_name, n.nat_code, n.nat_desc, rh.return_date
from borrow_history bh, book b, users u, author a, nationality n, return_history rh
where bh.book_id = b.id
and bh.user_id = u.id
and b.author_id = a.id
and a.nat_code = n.nat_code
and bh.id = rh.borrow_id
order by bh.borrow_date desc
;

select bh.borrow_date, b.book_name, u.user_name, a.author_name, n.nat_code, n.nat_desc, rh.return_date
from borrow_history bh, book b, users u, author a, nationality n, return_history rh
where bh.book_id = b.id
and bh.user_id = u.id
and b.author_id = a.id
and a.nat_code = n.nat_code
and bh.id = rh.borrow_id
order by bh.borrow_date desc
;

select bh.user_id, sum(EXTRACT(DAY FROM(rh.return_date - bh.borrow_date))) as borrow_days
from borrow_history bh, return_history rh, users u
where u.id = bh.user_id
and bh.id = rh.borrow_id
group by bh.user_id
;


with borrow_days_per_users as (
    select bh.user_id, sum(EXTRACT(DAY FROM(rh.return_date - bh.borrow_date))) as borrow_days
    from borrow_history bh, return_history rh, users u
    where u.id = bh.user_id
    and bh.id = rh.borrow_id
	group by bh.user_id
)
select bd.user_id, u.user_name, bd borrow_days
from borrow_days_per_users bd, users u
where borrow_days in (select max(borrow_days) from borrow_days_per_users)
and bd.user_id = u.id
;

-- Find the user(s) who has not ever borrow a book
insert into users (user_name) values ('Peter Chan');

SELECT u.id, u.user_name, bh.user_id
FROM users u
LEFT JOIN borrow_history bh ON u.id = bh.user_id -- user_id not yet created for id 3 
WHERE bh.user_id IS NULL;

select * 
from users u
where not exist (select 1 from borrow_history bh where bh.user_id = u.id);


-- Find the book(s), which has no borrow history
insert into book(author_id, book_name) values ('1', 'XYZ Book');

select * from book;
select * from borrow_history;

SELECT b.id, b.book_name, b.* , bh.*
FROM book b
LEFT JOIN borrow_history bh ON b.id = bh.book_id
WHERE bh.book_id IS NULL;

select b.id, b.book_name
from book b, borrow_history bh
where b.id = bh.book_id
and bh.book_id is null
;

-- Find all users and books, no matter the user or book has borrow history
-- Result Set:
-- 'John' 'ABC Book'


