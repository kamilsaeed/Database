USE LAB7;

CREATE TABLE Books(
BookId INT PRIMARY KEY,
Title VARCHAR(255) NOT NULL,
Genre VARCHAR(100) NOT NULL,
PublicationYear INT NOT NULL CHECK (PublicationYear > 1000 AND PublicationYear <= YEAR('2025-10-06')),
Price DECIMAL(10,2) NOT NULL CHECK (Price > 0)
);

CREATE TABLE Members(
MemberId INT PRIMARY KEY,
FullName VARCHAR(255) NOT NULL,
JoinDate DATE NOT NULL DEFAULT '2025-10-06'
);

CREATE TABLE Borrowings(
BorrowId INT PRIMARY KEY,
MemberId INT,
BookId INT,
FOREIGN KEY (MemberId) REFERENCES Members(MemberId) ON DELETE CASCADE,
FOREIGN KEY (BookId) REFERENCES Books(BookId) ON DELETE CASCADE,
BorrowDate DATE NOT NULL DEFAULT '2025-10-06',
ReturnDate DATE NULL,
BStatus VARCHAR(50) NOT NULL DEFAULT 'Borrowed' CHECK (BStatus IN ('Borrowed', 'Returned'))
);

INSERT INTO Books (BookId, Title, Genre, PublicationYear, Price)
VALUES
    (1, 'Harry Potter', 'Fiction', 1997, 8.99),
    (2, 'Data Science 101', 'Education', 2020, 50.00),
    (3, 'The Great Gatsby', 'Classic', 1925, 5.99),
    (4, '1984', 'Fiction', 1949, 7.00),
    (5, 'Alice Adventure', 'Young Adult', 1865, 3.50),
    (6, 'Catcher in the Rye', 'Fiction', 1951, 6.99),
    (7, 'Good Girl Guide to Murder', 'Young Adult', 2018, 12.99),
    (8, 'Good Girl Bad Blood', 'Young Adult', 2019, 10.99),
    (9, 'As Good As Dead', 'Young Adult', 2020, 9.99),
    (10, 'Anna Karenina', 'Classic', 1878, 2.00);
    
INSERT INTO Members (MemberId, FullName, JoinDate)
VALUES
    (101, 'Alice Brown', '2025-01-01'),
    (102, 'Bob Green', '2025-02-01'),
    (103, 'Charlie Lee', '2025-03-01'),
    (104, 'Abdul Rafay', '2025-04-01'),
    (105, 'Ali Ahmad', '2025-05-01'),
    (106, 'Muhammad Hayyab', '2025-06-01'),
    (107, 'Kamil Saeed', '2025-07-01'),
    (108, 'Charles Lechlre', '2025-08-01'),
    (109, 'Max Verstappen', '2025-09-01'),
    (110, 'Lewis Hamilton', '2025-10-01');

INSERT INTO Borrowings (BorrowId, MemberId, BookId, BorrowDate, ReturnDate, BStatus)
VALUES
    (1, 101, 1, '2025-01-10', '2025-02-20', 'Returned'),
    (2, 102, 3, '2024-12-22', NULL, 'Borrowed'),  
    (3, 101, 3, '2025-02-15', NULL, 'Borrowed'),
    (4, 103, 5, '2025-03-01', '2025-03-20', 'Returned'),
    (5, 104, 2, '2025-03-05', NULL, 'Borrowed'),
    (6, 101, 6, '2025-03-10', NULL, 'Borrowed'),
    (7, 105, 4, '2025-03-12', '2025-03-25', 'Returned'),
    (8, 106, 7, '2025-03-15', NULL, 'Borrowed'),
    (9, 102, 8, '2025-03-18', NULL, 'Borrowed'),
    (10, 107, 9, '2025-03-20', NULL, 'Borrowed');
    
    
SELECT * FROM Books;
SELECT * FROM Members;
SELECT * FROM Borrowings;

#Task1
SELECT *
FROM Books
WHERE PublicationYear < 2000
Order By PublicationYear DESC;

#Task2
SELECT Title, Price
From Books
WHERE Price = (SELECT MIN(Price) FROM Books) OR Price = (SELECT MAX(Price) FROM Books);

#Task3
SELECT DISTINCT Left(Title, 3)
FROM Books;

#Task4
SELECT UPPER(Title)
FROM Books
Order By Length(Title) DESC;

#Task5
SELECT ROUND(SUM(Price), 2)
FROM Books;

#Task6
SELECT Title, (YEAR('2025-10-06') - PublicationYear)
FROM Books;

#Task7
SELECT *
FROM Books
Where (YEAR('2025-10-06') - PublicationYear) < 10
Order BY PublicationYear DESC;

#Task8
SELECT ABS(MAX(Price) - MIN(Price)) AS PriceDifference
FROM Books
