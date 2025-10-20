USE LAB6;

CREATE TABLE Books(
BookId INT PRIMARY KEY,
Title VARCHAR(50) NOT NULL,
Author VARCHAR(50) NOT NULL,
Category VARCHAR(50) NOT NULL,
Price INT NOT NULL,
Quality INT NOT NULL
);

CREATE TABLE Users(
UserId INT PRIMARY KEY,
UserName VARCHAR(50) NOT NULL,
Email VARCHAR(50) NOT NULL,
City VARCHAR(50),
Membership_status VARCHAR(50) NOT NULL
);

CREATE TABLE Transcations(
TranscationId INT PRIMARY KEY,
BookId INT NOT NULL,
BorrowId INT NOT NULL,
Borrow_date DATE NOT NULL,
Return_date DATE,
TStatus VARCHAR(50) NOT NULL
);



INSERT INTO Books
VALUES
	(1, 'Harry Potter', 'J.K Rowling', 'Fiction', 899, 4),
    (2, 'Data Science 101', 'John Smith', 'Eduaction', 50, 12),
    (3, 'The Great Gatsby', 'F.Scott', 'Classic', 599, 3),
    (4, '1984', 'George', 'Ficition', 700, 12),
    (5, 'Alice Adventure', 'Lewis', 'Young Adult', 350, 19),
    (6, 'Catcher in the rye', 'Salinger', 'Fiction', 699, 20),
    (7, 'Good Girl Guide to Murder', 'Holly Jackson', 'Young Adult', 1299, 34),
    (8, 'Good Girl Bad Blood', 'Holly Jackson', 'Young Adult', 1099, 24),
    (9, 'As Good As Dead', 'Holly Jackson', 'Young Adult', 999, 16),
    (10, 'Anna Karenina', 'Leo', 'Classic', 200, 1);
    
INSERT INTO Users
VALUES 
	(101, 'Alice Brown', 'broali99@gmail.com', 'New York', 'Active'),
    (102, 'Bob Green', 'bobgreen@gmail.com', 'Chicago', 'Active'),
	(103, 'Charlie Lee', 'charlie122@gmail.com', NULL, 'Inactive'),
	(104, 'Abdul Rafay', 'rafaydaddy@gmail.com', 'Islamabad', 'Active'),
	(105, 'Ali Ahmad', 'holiali@gmail.com', 'Rawalpindi', 'Inactive'),
	(106, 'Muhammad Hayyab', 'zorog@gmail.com', 'Wah Cantt', 'Active'),
	(107, 'Kamil Saeed', 'hunter28@gmail.com', 'Rawalpindi', 'Inactive'),
	(108, 'Charles Lechlre', 'ferraricharles@gmail.com', 'Monacco', 'Active'),
	(109, 'Max Verstappen', 'redbullmax@gmail.com', 'Amsterdam', 'Inactive'),
	(110, 'Lewis Hamilton', 'flewis@gmail.com', 'London', 'Active');

INSERT INTO Transcations
VALUES
	(1, 1, 101, '2025-01-10', '2025-02-20', 'Returned'),
	(2, 3, 102, '2024-12-22', NULL, 'Overdue'),
	(3, 3, 101, '2025-02-15', NULL, 'Borrowed'),
	(4, 5, 103, '2025-03-01', '2025-03-20', 'Returned'),
	(5, 2, 104, '2025-03-05', NULL, 'Borrowed'),
	(6, 6, 101, '2025-03-10', NULL, 'Overdue'),
	(7, 4, 105, '2025-03-12', '2025-03-25', 'Returned'),
	(8, 7, 106, '2025-03-15', NULL, 'Borrowed'),
	(9, 8, 102, '2025-03-18', NULL, 'Borrowed'),
	(10, 9, 107, '2025-03-20', NULL, 'Overdue');
    
    
    
SELECT * FROM Books;
SELECT * FROM Users;
SELECT * FROM Transcations;


SET sql_safe_updates = 0;


#Task 1
UPDATE Books
SET Category = 'Poetry'
WHERE BookId = 2;


#Task 2
SELECT UserId, UserName
FROM Users
WHERE City IS NULL;


#Task 3
UPDATE Transcations
SET TStatus = 'Overdue'
WHERE Return_date IS NULL AND DATEDIFF(NOW(),Borrow_date) > 7;

SET SQL_SAFE_UPDATES = 0;

#Task 4
SELECT BookId
FROM Transactions
WHERE Return_date IS NULL
ORDER BY BookId DESC;


#Task 5
SELECT *
FROM Books
WHERE Price > 250 AND Quality < 5;


#Task 6
SELECT TranscationId, TStatus
FROM Transcations
ORDER BY Borrow_date DESC
LIMIT 3;


#Task 7
SELECT DISTINCT Category
FROM Books;


#Task 8
UPDATE Books
SET Price = Price * 0.9
WHERE Category = 'Education';


#Task 9
SELECT *
FROM Books 
WHERE Price < 50 OR Quantity BETWEEN 5 AND 10;


#Task 10
SELECT Titles
FROM Books
WHERE Title NOT LIKE '__w%' AND Quantity = 0;


#Task 11
SELECT *
FROM Books
WHERE Title LIKE '%data%' AND NOT Category = 'Fiction';


#Task 12
SELECT *
FROM Users
WHERE City IN ('New York', 'Chicago', 'Seattle');


#Task 13
SELECT *
FROM User
WHERE Email NOT LIKE '%@%';


#Task 14
CREATE TABLE ArchivedMembers (
    ArchivedUserId INT PRIMARY KEY,
    AName VARCHAR(100),
    Email VARCHAR(100),
    City VARCHAR(50)
);

INSERT INTO ArchivedMembers (ArchivedUserId, AName, Email, City)
SELECT UserId, UserName, Email, City
FROM Users
WHERE Membership_status = 'Inactive';


#Task 15
DELETE FROM Users
WHERE Membership_status = 'Inactive';