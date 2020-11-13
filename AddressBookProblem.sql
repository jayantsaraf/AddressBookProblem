--Create AddressBook database
create database Address_Book_Database;
-- Use Database
use Address_Book_Database;
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
insert into Address_Book values
('Jayant','Saraf','Chinar Park','Kolkata','WB','700157','8017126325','saraf24@gmail.com','Friend');
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
/*Retrieve Data City and state wise*/
select * from Address_Book
where City = 'Kolkata' or State = 'WB';
/*Count contacts by city and state*/
select COUNT(City), City, State from Address_Book
group by State, City;
/*Sort contacts alphabetically for a city*/
select * from Address_Book
where City = 'Kolkata'
order by FirstName asc;
-- Add Contact Type - Friends or Family
alter table Address_Book add Contact_Type varchar(10)
-- Count contacts by type of contact
update Address_Book set Contact_Type = 'Family' where FirstName = 'Jayant' 
update Address_Book set Contact_Type = 'Friend' where FirstName = 'Ajay' 
update Address_Book set Contact_Type = 'Friend' where FirstName = 'Mayank' 
select Contact_Type, COUNT(Contact_Type) from Address_Book
group by Contact_Type

alter table Address_Book
add Book_Name varchar(20)
--Update Contacts for book_name
update Address_Book set  Book_Name ='Office' where FirstName in ( 'Jayant','Ajay');
update Address_Book set  Book_Name ='Home' where FirstName in ('Mayank');
select * from Address_Book;

--Count contacts by contact type
select Contact_Type, COUNT(Contact_Type) from Address_Book
group by Contact_Type
--Adding contact bill to family also
insert into Address_Book values
('Jayant','Saraf','Chinar Park','Kolkata','WB','700157','8017126325','saraf24@gmail.com','Friend','office');
--Create table Contact_Info
create table Contact_Info
(
FirstName varchar(25) not null primary key,
LastName varchar(25) not null,
Address varchar(60) not null,
City varchar(15) not null,
State varchar(20) not null,
Zipcode varchar(6) not null,
PhoneNumber varchar(12) not null,
Email varchar(20) not null
);
--Insert into Contact_Info
insert into Contact_Info values
('Jayant','Saraf','Chinar Park','Kolkata','WB','700157','8017126325','saraf24@gmail.com'),
('Ajay','Kapoor','New Market','Kolkata','WB','754874','123456789','ak@gmail.com'),
('Mayank','Saraf','central','kolkata','WB','745688','7894561237','mayank@gmail.com');
insert into Contact_Info values
('Bill','Jones','Street 4','Mumbai','Maharashtra','452856','9856985696','billjones@gmail.com');
--ContactType table added
create table Contact_Type
(
FirstName varchar(25) not null foreign key references Contact_Info(FirstName),
Contact_Type varchar(20) not null
);
--Add enteries to contact_type
insert into Contact_Type values
('Jayant','Family'),
('Ajay','Friend'),
('Mayank','Friend'),
('Bill','Family');
insert into Contact_Type values
('Jayant','Friend');
--View Contact_type
select * from Contact_Type
--Join contact_info and contact_type
select * from Contact_Info contact inner join Contact_Type type
on (contact.FirstName = type.FirstName) 
