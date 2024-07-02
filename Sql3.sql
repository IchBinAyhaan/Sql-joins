use DemoApp

CREATE TABLE Sellers (
    Id INT PRIMARY KEY,
    Name NVARCHAR(50),
    Surname NVARCHAR(50),
    City NVARCHAR(50)
);


CREATE TABLE Customers (
    Id INT PRIMARY KEY,
    Name NVARCHAR(50),
    Surname NVARCHAR(50),
    City NVARCHAR(50)
);


CREATE TABLE Orders (
    Id INT PRIMARY KEY,
    OrderDate DATE,
    Amount DECIMAL(10, 2),
    State NVARCHAR(50), 
    CustomerId INT,
    SellerId INT,
    FOREIGN KEY (CustomerId) REFERENCES Customers(Id),
    FOREIGN KEY (SellerId) REFERENCES Sellers(Id)
);

INSERT INTO Sellers (Id, Name, Surname, City)
VALUES (1, 'Ayhan', 'Qasimli', 'Baki'),
       (2, 'Oktay', 'Babayev', 'Gence'),
       (3, 'Messi', 'Lionel', 'Lenkeran');

INSERT INTO Customers (Id, Name, Surname, City)
VALUES (1, 'Behram', 'Bagirzade', 'Gence'),
       (2, 'Qabil', 'Orucov', 'Baki'),
       (3, 'Yusif', 'Bayramli', 'Lenkeran');

INSERT INTO Orders (Id, OrderDate, Amount, State, CustomerId, SellerId)
VALUES (1, '2024-05-15', 120, 'Tamamlanib', 1, 1),
       (2, '2024-06-02', 100, 'Tamamlanib', 2, 2),
       (3, '2024-04-20', 150, 'Tamamlanib', 3, 3),
       (4, '2024-06-10', 1750, 'Tamamlanib', 1, 2),
       (5, '2024-05-28', 20, 'Catdirilmada', 2, 1),
       (6, '2024-06-15', 35, 'Catdirilmada', 3, 3);



SELECT c.Id, c.Name, c.Surname, c.City, SUM(o.Amount) AS 'Total Amount'
FROM Customers c
JOIN Orders o ON c.Id = o.CustomerId
GROUP BY c.Id, c.Name, c.Surname, c.City
HAVING SUM(o.Amount) > 1000;


SELECT c.Id AS CustomerId, c.Name AS CustomerName, c.Surname AS CustomerSurname, c.City AS CustomerCity,
s.Id AS SellerId, s.Name AS SellerName, s.Surname AS SellerSurname, s.City AS SellerCity
FROM Customers c
JOIN Sellers s ON c.City = s.City;

SELECT * FROM Orders
WHERE OrderDate >= '2024-01-04' AND State = 'Tamamlanib';

SELECT s.Id, s.Name, s.Surname, s.City, COUNT(o.Id) AS OrderCount
FROM Sellers s
JOIN Orders o ON s.Id = o.SellerId
WHERE o.State = 'Tamamlanib'
GROUP BY s.Id, s.Name, s.Surname, s.City
HAVING COUNT(o.Id) > 10;

SELECT c.Id, c.Name, c.Surname, c.City, COUNT(o.Id) AS OrderCount
FROM Customers c
JOIN Orders o ON c.Id = o.CustomerId
GROUP BY c.Id, c.Name, c.Surname, c.City
ORDER BY COUNT(o.Id) DESC

SELECT s.Id AS SellerId, s.Name AS SellerName, s.Surname AS SellerSurname,
       s.City AS SellerCity, o.Id AS OrderId, o.OrderDate, o.State
FROM Sellers s
JOIN Orders o ON s.Id = o.SellerId
WHERE o.State = 'Catdirilmada'
ORDER BY o.OrderDate ASC;

SELECT *
FROM Orders
WHERE State = 'Tamamlanib' AND OrderDate >= DATEADD(MONTH, -1, GETDATE());
