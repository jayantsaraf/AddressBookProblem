--Create AddressBook database
create database Address_Book_Database;
-- Use Database
use Address_Book_Database;
Create Table
select DB_NAME()
/*Creating AddressBook table*/
create table Address_Book
(
FirstName varchar(25) not null,
LastName varchar(25) not null,
Address varchar(60) not null,
City varchar(15) not null,
State varchar(20) not null,
Zipcode varchar(6) not null,
PhoneNumber varchar(12) not null,
Email varchar(20) not null
);
/*View table details*/
select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'Address_Book';
/*Add Contacts*/
insert into Address_Book values
('Jayant','Saraf','Chinar Park','Kolkata','WB','700157','8017126325','saraf24@gmail.com'),
('Ajay','Kapoor','New Market','Kolkata','WB','754874','123456789','ak@gmail.com'),
('Mayank','Saraf','central','kolkata','WB','745688','7894561237','mayank@gmail.com');
/*View AddressBook*/
select* from Address_Book;
/*Update existing contact*/
update Address_Book
set Address = 'street 10' where FirstName = 'Bill';
select* from Address_Book;
/*delete contact using person's name*/
delete Address_Book
where FirstName = 'Jayant';
select* from Address_Book;