create database DemoApp

use DemoApp

create table People(
Id int primary key identity(1,1),
Name nvarchar(20) not null,
Surname nvarchar(20) not null,
PhoneNumber int not null,
Email nvarchar not null,
BirthDate date not null,
Gender nvarchar(10) not null,
HasCitizenship bit
)

create table Countries(
Id int primary key identity(1,1),
Name nvarchar(30) unique,
Area decimal(20,5) not null
) 

INSERT INTO Countries (Name, Area)
VALUES ('Turkey', 783562.00),
       ('France', 551695.00),
       ('Germany', 357022.00),
       ('Italy', 301340.00),
       ('Spain', 505992.00),
       ('United Kingdom', 243610.00),
       ('Greece', 131957.00),
       ('Sweden', 450295.00),
       ('Norway', 323802.00);
 
create table Cities(
Id int primary key identity(1,1),
Name nvarchar(30) not null,
Area decimal(20,4),
   CountryId INT,
    CONSTRAINT FK_Cities_CountryId FOREIGN KEY (CountryId) REFERENCES Countries(Id)
)

INSERT INTO Cities (Name, Area, CountryId)
VALUES ('Istanbul', 5343.00, 1), 
       ('Lyon', 47.87, 2),   
       ('Izmir', 1180.00, 1),    
       ('Antalya', 1979.00, 1),
	   ('Milan', 181.76, 4),
	   ('Munich', 310.43, 3),
	   ('Athens', 412.05, 7);

	   UPDATE Cities
SET  Population = CASE
    WHEN Name = 'Lyon' THEN 518635 
    WHEN Name = 'Izmir' THEN 4320519 
    WHEN Name = 'Antalya' THEN 2511700 
    WHEN Name = 'Milan' THEN 1404239 
    WHEN Name = 'Munich' THEN 1484226 
    WHEN Name = 'Athens' THEN 664046 
	 WHEN Name = 'Istanbul' THEN 15460000
    ELSE 0 
    END;
	   
SELECT * FROM Countries;

SELECT * FROM Cities;

ALTER TABLE People
ADD CityId INT;

ALTER TABLE Cities
ADD Population INT;


CREATE VIEW PersonLocations AS
SELECT p.Id AS PersonId, p.Name AS PersonName, p.Surname, p.PhoneNumber, p.Email,
       p.BirthDate, p.Gender, p.HasCitizenship,
       c.Name AS CountryName, ci.Name AS CityName
FROM People p
INNER JOIN Cities ci ON p.CityId = ci.Id
INNER JOIN Countries c ON ci.CountryId = c.Id;


 SELECT * FROM Countries
ORDER BY Area ASC;

SELECT * FROM Cities
ORDER BY Name DESC;

SELECT COUNT (*) FROM Countries
WHERE Area > 400000;


SELECT TOP 1 * FROM Countries
WHERE Name LIKE 'İ%'
ORDER BY Area DESC;


SELECT Name AS 'Place Name'
FROM Countries
UNION
SELECT Name AS 'Place Name'
FROM Cities;


SELECT ci.Name AS CityName,COUNT(p.Id) AS PersonCount
FROM Cities ci
LEFT JOIN People p ON ci.Id = p.CityId
GROUP BY ci.Name;




SELECT * FROM Cities
WHERE Population > 50000






