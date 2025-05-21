CREATE DATABASE SAMPLE2

-- Create Authors table
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(50),
    Country VARCHAR(50)
);

-- Create Publishers table
CREATE TABLE Publishers (
    PublisherID INT PRIMARY KEY,
    PublisherName VARCHAR(50),
    Location VARCHAR(50)
);

-- Create Books table with Foreign Keys and CASCADE rules
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    AuthorID INT,
    PublisherID INT,
    YearPublished DATE,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (PublisherID) REFERENCES Publishers(PublisherID) ON DELETE CASCADE ON UPDATE CASCADE
);
-- Insert Authors
INSERT INTO Authors VALUES
(1, 'J.K. Rowling', 'UK'),
(2, 'George Orwell', 'UK'),
(3, 'Dan Brown', 'USA');

-- Insert Publishers
INSERT INTO Publishers VALUES
(1, 'Penguin Books', 'New York'),
(2, 'Bloomsbury', 'London');

-- Insert Books
INSERT INTO Books VALUES
(1, '1984', 2, 1, '1949-06-08'),
(2, 'Harry Potter', 1, 2, '1997-06-26'),
(3, 'Inferno', 3, 1, '2013-05-14');


CREATE TABLE Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    BookID INT,
    SaleDate DATE,
    SaleAmount DECIMAL(10, 2),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)	
);
  INSERT INTO Sales (BookID, SaleDate, SaleAmount)
VALUES
(1, '2025-01-15', 250.00),
(1, '2025-02-10', 300.00),
(2, '2025-03-05', 180.00),
(2, '2025-03-15', 220.00),
(3, '2024-12-20', 150.00);

GO
CREATE PROCEDURE GetTotalSalesByTitle
    @Title VARCHAR(100)
AS
BEGIN
    SELECT 
        B.Title,
        SUM(S.SaleAmount) AS TotalSales
    FROM Books B
    JOIN Sales S ON B.BookID = S.BookID
    WHERE B.Title = @Title
    GROUP BY B.Title;
END;
GO
EXEC GetTotalSalesByTitle '1984';
GO
CREATE FUNCTION GetAverageSaleAmount()
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @Avg DECIMAL(10, 2);

    SELECT @Avg = AVG(SaleAmount)
    FROM Sales;

    RETURN @Avg;
END;
   GO
SELECT * FROM Sales;
SELECT BookID, SUM (SaleAmount) AS TotalSales FROM Sales GROUP BY BookID;
SELECT BookID,
YEAR(SaleDate) AS SaleYear,
SUM(SaleAmount) AS TotalSales FROM Sales GROUP BY BookID, YEAR(SaleDate);

SELECT 
    BookID,
    SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY BookID
HAVING SUM(SaleAmount) > 400;



