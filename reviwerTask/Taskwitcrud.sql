CREATE DATABASE SAMPLE5
USE	SAMPLE5

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    AuthorID INT,
    PublisherID INT,
    YearPublished DATE
);

CREATE PROCEDURE BookOperation
    @Action VARCHAR(10),        
    @BookID INT = NULL,
    @Title VARCHAR(100) = NULL,
    @AuthorID INT = NULL,
    @PublisherID INT = NULL,
    @YearPublished DATE = NULL
AS
BEGIN
   
    IF @Action = 'ADD'
    BEGIN
        INSERT INTO Books (BookID, Title, AuthorID, PublisherID, YearPublished)
        VALUES (@BookID, @Title, @AuthorID, @PublisherID, @YearPublished);
    END

 
    ELSE IF @Action = 'GETALL'
    BEGIN
        SELECT * FROM Books;
    END

    ELSE IF @Action = 'GETBYID'
    BEGIN
        SELECT * FROM Books WHERE BookID = @BookID;
    END

    
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Books
        SET Title = @Title,
            AuthorID = @AuthorID,
            PublisherID = @PublisherID,
            YearPublished = @YearPublished
        WHERE BookID = @BookID;
    END

    
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Books WHERE BookID = @BookID;
    END
END;
GO

EXEC BookOperation 
    @Action = 'ADD',
    @BookID = 1,
    @Title = 'Dan Brown',
    @AuthorID = 1,
    @PublisherID = 2,
    @YearPublished = '2024-01-01';

EXEC BookOperation
    @Action = "ADD",
	@BookID = 2,
	@Title = 'Alachamist',
	@AuthorID = 2,
	@PublisherID = 2,
	@YearPublished = '2023-05-15';

EXEC BookOperation @Action = 'GETALL';

EXEC BookOperation @Action = 'GETBYID', @BookID = 1;

EXEC BookOperation 
    @Action = 'UPDATE',
    @BookID = 10,
    @Title = 'Simple SQL - Updated',
    @AuthorID = 2,
    @PublisherID = 1,
    @YearPublished = '2025-01-01';

EXEC BookOperation @Action = 'DELETE', @BookID = 1;