CREATE DATABASE Homework3;
GO
USE Homework3;
GO
CREATE TABLE Books
(
    Id INT IDENTITY PRIMARY KEY,
    BookName NVARCHAR(30) NOT NULL,
    Author NVARCHAR(20) NOT NULL,
    BookCount INT DEFAULT 0
);
CREATE TABLE Customers
(
    Id INT IDENTITY PRIMARY KEY,
    FirstName NVARCHAR(30) NOT NULL
);
CREATE TABLE Orders
(
    Id INT IDENTITY PRIMARY KEY,
    BookId INT NOT NULL REFERENCES Books(Id) ON DELETE CASCADE,
    CustomerId INT NOT NULL REFERENCES Customers(Id) ON DELETE CASCADE,
    IssuedAt DATE NOT NULL,
	ReturnedAt DATE NOT NULL,
    BookCount INT DEFAULT 1
);
INSERT INTO Books 
VALUES ('BookOne', 'AuthorOne', 2),
('BookTwo', 'AuthorTwo', 4),
('BookThree', 'AuthorThree', 7),
('BookFour', 'AuthorFour', 3),
('BookFive', 'AuthorFive', 1),
('BookSix', 'AuthorSix', 4)
INSERT INTO Customers VALUES ('Jack'), ('Hanna'),('Samuel')
INSERT INTO Orders 
VALUES
( 
    (SELECT Id FROM Books WHERE BookName='BookOne'), 
    (SELECT Id FROM Customers WHERE FirstName='Jack'),
    '2018-08-11',
	'2018-10-20', 
    2
),
( 
    (SELECT Id FROM Books WHERE BookName='BookTwo'), 
    (SELECT Id FROM Customers WHERE FirstName='Hanna'),
    '2017-06-12', 
	'2017-07-12', 
    1
),
( 
    (SELECT Id FROM Books WHERE BookName='BookThree'), 
    (SELECT Id FROM Customers WHERE FirstName='Samuel'),
    '2020-02-05', 
	'2017-03-15', 
    1
)

SELECT Customers.FirstName, Books.BookName, Books.Author, Orders.IssuedAt, Orders.ReturnedAt, Orders.BookCount 
FROM Orders 
LEFT JOIN Customers ON Orders.CustomerId = Customers.Id
LEFT JOIN Books ON Orders.BookId = Books.Id

