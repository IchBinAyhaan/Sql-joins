use DemoApp

CREATE TABLE Movies (
    Id INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    ReleaseDate DATE,
    IMDB DECIMAL(3, 1) 
);

ALTER TABLE Movies
ADD GenreId INT;

CREATE TABLE Actors (
    Id INT PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    Surname NVARCHAR(50) NOT NULL
);

CREATE TABLE Genres (
    Id INT PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL
);

CREATE TABLE MovieActors (
    MovieId INT,
    ActorId INT,
    PRIMARY KEY (MovieId, ActorId),
    FOREIGN KEY (MovieId) REFERENCES Movies(Id),
    FOREIGN KEY (ActorId) REFERENCES Actors(Id)
);

INSERT INTO MovieActors (MovieId, ActorId)
VALUES (1, 1), 
       (1, 2),  
       (2, 1), 
       (2, 3),  
       (3, 1), 
       (3, 4), 
       (4, 1),  
       (5, 5); 




INSERT INTO Movies (Id, Name, ReleaseDate, IMDB)
VALUES (1, 'Inception', '2010-07-16', 8.8),
       (2, 'The Dark Knight', '2008-07-18', 9.0),
       (3, 'Interstellar', '2014-11-07', 8.6),
       (4, 'Pulp Fiction', '1994-10-14', 8.9),
       (5, 'The Shawshank Redemption', '1994-09-23', 9.3);

INSERT INTO Actors (Id, Name, Surname)
VALUES (1, 'Leonardo', 'DiCaprio'),
       (2, 'Tom', 'Hardy'),
       (3, 'Christian', 'Bale'),
       (4, 'Anne', 'Hathaway'),
       (5, 'Brad', 'Pitt');

INSERT INTO Genres (Id, Name)
VALUES (1, 'Action'),
       (2, 'Drama'),
       (3, 'Sci-Fi'),
       (4, 'Crime'),
       (5, 'Adventure');


SELECT a.Id, a.Name, a.Surname, COUNT(*) AS rolecount
FROM Actors a
JOIN MovieActors ma ON a.Id = ma.ActorID
GROUP BY a.Id, a.Name, a.Surname
ORDER BY rolecount DESC;


SELECT g.Name AS Genre, COUNT(m.Id) AS MovieCount
FROM Genres g
LEFT JOIN Movies m ON g.Id = m.GenreId
GROUP BY g.Name;



SELECT m.Name AS MovieName, m.ReleaseDate AS ExpectedReleaseDate
FROM Movies m
WHERE m.ReleaseDate > GETDATE();

SELECT YEAR(m.ReleaseDate) AS ReleaseYear, AVG(m.IMDB) AS AvgIMDB
FROM Movies m
WHERE YEAR(m.ReleaseDate) >= YEAR(GETDATE()) - 5
GROUP BY YEAR(m.ReleaseDate)
ORDER BY ReleaseYear DESC;


SELECT a.Id AS ActorId, a.Name AS ActorName, a.Surname AS ActorSurname,
       COUNT(*) AS MovieCount
FROM Actors a
JOIN MovieActors ma ON a.Id = ma.ActorId
GROUP BY a.Id, a.Name, a.Surname
HAVING COUNT(*) > 1
ORDER BY MovieCount DESC;
