/* This scripts creates all Procedures for the VideoRental database */

USE VideoRental
GO


/* If the objects already exist drop them */

IF EXISTS ( SELECT name FROM sysobjects
            WHERE type = 'P' and name = 'IsRegularClient' )
    DROP PROCEDURE IsRegularClient

IF EXISTS ( SELECT name FROM sysobjects
            WHERE type = 'P' and name = 'RentTape' )
    DROP PROCEDURE RentTape

IF EXISTS ( SELECT name FROM sysobjects
            WHERE type = 'P' and name = 'ReturnTape' )
    DROP PROCEDURE ReturnTape

IF EXISTS ( SELECT name FROM sysobjects
            WHERE type = 'P' and name = 'AddProposal' )
    DROP PROCEDURE AddProposal

IF EXISTS ( SELECT name FROM sysobjects
            WHERE type = 'P' and name = 'AddTape' )
    DROP PROCEDURE AddTape

IF EXISTS ( SELECT name FROM sysobjects
            WHERE type = 'P' and name = 'RemoveTape' )
    DROP PROCEDURE RemoveTape

IF EXISTS ( SELECT name FROM sysobjects
            WHERE type = 'P' and name = 'PlanningReturnDate' )
    DROP PROCEDURE PlanningReturnDate

IF EXISTS ( SELECT name FROM sysobjects
            WHERE type = 'P' and name = 'FindMovie' )
    DROP PROCEDURE FindMovie
GO




/* Procedure IsRegularClient: cheking if the client is regular */

CREATE PROCEDURE IsRegularClient
      @ClientID int
AS
    IF (SELECT COUNT(*) FROM Rental WHERE ClientID = @ClientID) >= 5
    BEGIN
        PRINT 'Client is regular'
        RETURN
    END

    PRINT 'Client is not regular'
    RETURN
GO




/* Procedure PlanningReturnDate: return date of tape search request */

CREATE PROCEDURE  PlanningReturnDate
     @TapeID int
AS
    SELECT TapeID, DueDate
    FROM Rental
    WHERE TapeID = @TapeID AND ReturnDate IS NULL 
GO





/* Procedure FindMovie: search for a movie and variants of tapes on which it was recorded  */

CREATE PROCEDURE FindMovie
    @Title nvarchar(50)
AS
    SELECT Movies.MovieID, Movies.Title, Tapes.TapeID, Tapes.Type, Tapes.Available
    FROM Movies
    INNER JOIN Tapes
    ON Movies.MovieID = Tapes.MovieID
    WHERE Movies.Title = @Title
GO





/* Procedure RentTape: execution of the rent operation (insert row in Rental table with calculation of price) */

CREATE PROCEDURE RentTape
       @ClientID      int
    ,  @TapeID        int
    ,  @OutDate       date
    ,  @DueDate       date
AS  
    IF  (SELECT Tapes.Available FROM Tapes WHERE TapeID = @TapeID) = '0'
    BEGIN
        PRINT 'The Tape is not available'
        RETURN
    END
    
    DECLARE @RentPrice money
    SELECT @RentPrice = DATEDIFF(day, @OutDate, @DueDate) * Tariffs.PricePerDay
    FROM Tapes
    INNER JOIN Tariffs
    ON Tariffs.TariffID = Tapes.TariffID
    WHERE Tapes.TapeID = @TapeID
    
    DECLARE @RentDiscount real
	SELECT @RentDiscount = Clients.Discount FROM Clients WHERE ClientID = @ClientID
	IF  @RentDiscount > 0 
        SELECT @RentPrice = @RentPrice - @RentPrice * @RentDiscount
    
    BEGIN TRANSACTION
    INSERT Rental
        (ClientID,  TapeID,  OutDate,  DueDate,  Deposit,  RentPrice,  ReturnDate, Fine)
      VALUES    
        (@ClientID, @TapeID, @OutDate , @DueDate, '1', @RentPrice, NULL, NULL)

    IF @@error <> 0
	BEGIN
        PRINT 'Operation failed'
		ROLLBACK TRAN
		RETURN
	END
    
    PRINT 'Operation succeeded'
    COMMIT TRANSACTION
    RETURN

GO





/* Procedure ReturnTape: execution of the return operation (update row in Rental table with calculation of fine if needed) */

CREATE PROCEDURE ReturnTape
       @RentalID      int
    ,  @ReturnDate    date
AS  

    DECLARE @Fine money
    SELECT @Fine = DATEDIFF(day, Rental.DueDate, @ReturnDate) * Tariffs.FinePerDay
    FROM Rental 
    INNER JOIN Tapes
    ON Tapes.TapeID = Rental.TapeID
    INNER JOIN Tariffs
    ON Tariffs.TariffID = Tapes.TariffID
    WHERE Rental.RentalID = @RentalID
   
    BEGIN TRANSACTION
    UPDATE Rental
    SET ReturnDate = @ReturnDate, Deposit = '0', Fine = @Fine
    WHERE RentalID = @RentalID

    IF @@error <> 0
	BEGIN
        PRINT 'Operation failed'
		ROLLBACK TRAN
		RETURN
	END
    
    PRINT 'Operation succeeded'
    COMMIT TRANSACTION
    RETURN
GO





/* Procedure AddProposal: registering new proposal to update movie catalog */

CREATE PROCEDURE AddProposal
       @ClientID      int
    ,  @NewMovieTitle nvarchar(50)
AS
    IF (SELECT COUNT(*) FROM Rental WHERE ClientID = @ClientID) < 5
    BEGIN
        PRINT 'Client is not allowed to make a request'
        RETURN
    END
    
    BEGIN TRANSACTION
        INSERT Proposals
            (ClientID, NewMovieTitle, DateOfProposal, DateOfAddiction, MovieID)
        VALUES
            (@ClientID, @NewMovieTitle, CONVERT (date, GETDATE()), NULL, NULL)
    
    IF @@error <> 0
	BEGIN
        PRINT 'Operation failed'
		ROLLBACK TRAN
		RETURN
	END

    PRINT 'Operation succeeded'
    COMMIT TRANSACTION
    RETURN
GO




/* Procedure AddTape: adding tape with new movie from proposal list */

CREATE PROCEDURE AddTape
       @Title           nvarchar(50)
    ,  @Genre           nvarchar(50)
    ,  @ReleaseDate     date
    ,  @Duration        time
    ,  @Discription     nvarchar(250)
    ,  @Type            nvarchar(10)
    ,  @DateManufacture date
    ,  @TariffID        nvarchar(20)
AS  
    IF EXISTS (SELECT Title FROM Movies WHERE Title = @Title) 
    BEGIN
        PRINT 'Movie is already in catalog'
        RETURN
    END
        
    DECLARE @nNewID int
    
    BEGIN TRANSACTION
    INSERT MOVIES
        (Title, Genre, ReleaseDate, Duration, Discription)
    VALUES
        (@Title, @Genre, @ReleaseDate, @Duration, @Discription)
    
    SELECT @nNewID = @@IDENTITY
    
    INSERT Tapes
        (MovieID, Type, DateManufacture, TariffID, Available)
    VALUES
        (@nNewID, @Type, @DateManufacture, @TariffID, '1')
        
    UPDATE Proposals
    SET DateOfAddiction = CONVERT (date, GETDATE()), MovieID = @nNewID
    WHERE NewMovieTitle = @Title
    
    IF @@error <> 0
	BEGIN
        PRINT 'Operation failed'
		ROLLBACK TRAN
		RETURN
	END

    PRINT 'Operation succeeded'
    COMMIT TRANSACTION
    RETURN
GO
    
    
    
    
/* Procedure RemoveTape: if tape is damaged after rent it is removed from the catalog and deposit is not returned */

CREATE PROCEDURE RemoveTape
       @TapeID int
    ,  @ClientID int
AS  
    BEGIN TRANSACTION
    UPDATE Rental
    SET Deposit = '1'
    WHERE TapeID = @TapeID AND ClientID = @ClientID
    
    DELETE Tapes
    WHERE TapeID = @TapeID
    
    IF @@error <> 0
	BEGIN
        PRINT 'Operation failed'
		ROLLBACK TRAN
		RETURN
	END

    PRINT 'Operation succeeded'
    COMMIT TRANSACTION
    RETURN
GO

