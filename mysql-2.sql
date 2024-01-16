use db_bc2311_1;

show databases;

create table monster(
    id integer not null,
    mon_Name varchar(50)not null, -- need to define at least the size
    monster_HP integer not null,
    monster_ATK integer not null,
    monster_DEF integer not null,
    monster_SPD integer not null
);

select * from monster;

insert into monster (id, mon_Name, monster_HP, monster_ATK, monster_DEF, monster_SPD) values (1, 'Yufio', 99, 12, 45, 23); 
insert into monster values(2, 'Tefiivo', 19, 32, 85, 3); 
insert into monster values(3, 'Ouiivo', 69, 42, 35, 39); 
insert into monster values(4, 'Feivc', 109, 322, 85, 32); 
insert into monster values(5, 'Reivc', 69, 62, 25, 42); 

alter table monster add created_date datetime;

update monster set created_date = str_to_date ("1990 01 10", "%Y %m %d") where id = 2;
update monster set created_date = str_to_date ("2024-01-10", "%Y-%m-%d") where id = 1;
update monster set created_date = str_to_date ("2022-01-10", "%Y-%m-%d") where id = 3;
update monster set created_date = str_to_date ("2023-01-10", "%Y-%m-%d") where id = 4;
update monster set created_date = str_to_date ("2024-01-10", "%Y-%m-%d") where id = 5;


select * from monster order by created_date asc;



