CREATE DATABASE SAMPLE1
USE SAMPLE1

CREATE TABLE Authors (
AuthorID INT PRIMARY KEY,
AuthorName VARCHAR(50),
Country VARCHAR(50));

CREATE TABLE Publishers(
PublisherID INT PRIMARY KEY,
PublisherName VARCHAR(50),
Location VARCHAR(30) );

CREATE TABLE  BOOK (
BookID INT PRIMARY KEY,
Title VARCHAR(150),
AuthorID INT,
PublisherID INT,
YearPublished Date,
FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID) ON DELETE CASCADE ON UPDATE CASCADE,
);

INSERT INTO Authors VALUES
(1, 'J.K. Rowling', 'UK'),
(2, 'George Orwell', 'UK'),
(3, 'Dan Brown', 'USA');

-- Insert Publishers
INSERT INTO Publishers VALUES
(1, 'Penguin Books', 'New York'),
(2, 'Bloomsbury', 'London');

-- Insert Books
INSERT INTO BOOK VALUES
(1, '1984', 2, 1, '1949-06-08'),
(2, 'Harry Potter', 1, 2, '1997-06-26'),
(3, 'Inferno', 3, 1, '2013-05-14'); 


									  
SELECT 
     b.BookID, b.Title, a.AuthorName, p.PublisherName
	 FROM BOOK  b
	 CROSS JOIN Authors a ON b.AuthorID = a.AuthorID
	 
DELETE FROM Authors WHERE AuthorID=2;	
SELECT Title FROM BOOK
UNION 
SELECT PublisherName FROM  Publishers
