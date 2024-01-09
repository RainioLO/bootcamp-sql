show databases;
create database db_bc2311_1;
use db_bc2311_1;
CREATE USER 'vincentlau'@'localhost' IDENTIFIED BY 'yourpassword';
ALTER USER 'vincentlau'@'localhost' IDENTIFIED BY 'yournewpassword';
GRANT CREATE, ALTER, DROP, INSERT, UPDATE, SELECT, REFERENCES, RELOAD on *.* TO 'vincentlau'@'localhost' WITH GRANT OPTION;
