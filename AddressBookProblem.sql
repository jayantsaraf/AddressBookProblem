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
ContactId int identity(1,1) not null primary key,
FirstName varchar(25) not null,
LastName varchar(25) not null,
PhoneNumber varchar(12) not null,
Email varchar(20) not null
);
select * from Contact_Info
--Insert into Contact_Info
insert into Contact_Info values
('Jayant','Saraf','8017126325','saraf24@gmail.com'),
('Ajay','Kapoor','123456789','ak@gmail.com'),
('Mayank','Saraf','7894561237','mayank@gmail.com');
insert into Contact_Info values
('Bill','Jones','9856985696','billjones@gmail.com');
select * from Contact_Info
--ContactType table added
create table Contact_Type
(
ContactId int not null foreign key references Contact_Info(ContactId) on delete cascade,
Contact_Type varchar(20) not null
);
select* from Contact_Type
--Add enteries to contact_type
insert into Contact_Type values
('1','Family'),
('2','Friend'),
('3','Friend'),
('4','Family');
insert into Contact_Type values
('5','Friend');

create table Address
(
ContactId int foreign key references Contact_Info(ContactId) on delete cascade,
Address varchar(60) not null,
City varchar(15) not null,
State varchar(20) not null,
Zipcode varchar(6) not null
);
--Insert into Address table
insert into Address values
(1,'Chinar Park','Kolkata','WB','700157'),
(2,'New Market','Kolkata','WB','754874'),
(3,'central','kolkata','WB','745688'),
(4,'Street 4','Mumbai','Maharashtra','452856'),
(5,'Chinar Park','Kolkata','WB','700157');
--View Contact_type
select * from Contact_Type
--Join contact_info and contact_type
select * from (Contact_Info contact inner join Contact_Type type
on (contact.ContactId = type.ContactId)) inner join Address address on address.ContactId = contact.ContactId
--Count contact by type
select type.Contact_Type, COUNT(contact.FirstName) from Contact_Info contact inner join Contact_Type type
on (contact.ContactId = type.ContactId)
Group by type.Contact_Type; 
--Add DateAdded field to the contact_info
Alter table Contact_Info
Add DateAdded datetime
--Add DateAdded
Update Contact_Info set 
DateAdded = '2019-05-31' where ContactId = 1
Update Contact_Info set 
DateAdded = '2020-05-06' where ContactId = 2
Update Contact_Info set 
DateAdded = '2019-04-01' where ContactId = 3
Update Contact_Info set 
DateAdded = '2018-03-09' where ContactId = 4
Update Contact_Info set 
DateAdded = '2019-08-07' where ContactId = 5
Update Contact_Info set 
DateAdded = '2020-09-30' where ContactId = 6
create procedure SpAddContactDetails
(
@FirstName varchar(255),
@LastName varchar(255),
@PhoneNumber varchar(255),
@Email varchar(255),
@DateAdded DateTime,
@Contact_Type varchar(255),
@Address varchar(255),
@City varchar(255),
@State varchar(255),
@Zipcode varchar(255)
)
as
begin
insert into Contact_Info values
(
@FirstName,@LastName, @PhoneNumber, @Email, @DateAdded
);
insert into Contact_Type values
(
@@IDENTITY, @Contact_Type
)
Declare @CustId int
select @CustId = ContactId from Contact_Info where Email = @Email
insert into Address values
(
@CustId, @Address, @City, @State, @Zipcode
)