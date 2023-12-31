USE [master]
GO
/****** Object:  Database [VideoRental]    Script Date: 12/22/2021 9:09:48 PM ******/
CREATE DATABASE [VideoRental]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'VideoRental', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\VideoRental.mdf' , SIZE = 50MB , MAXSIZE = 70MB, FILEGROWTH = 10% )
 LOG ON 
( NAME = N'VideoRental_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\VideoRental_log.ldf' , SIZE = 15MB , MAXSIZE = 20MB , FILEGROWTH = 10%)
GO
ALTER DATABASE [VideoRental] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [VideoRental].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [VideoRental] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [VideoRental] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [VideoRental] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [VideoRental] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [VideoRental] SET ARITHABORT OFF 
GO
ALTER DATABASE [VideoRental] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [VideoRental] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [VideoRental] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [VideoRental] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [VideoRental] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [VideoRental] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [VideoRental] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [VideoRental] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [VideoRental] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [VideoRental] SET  DISABLE_BROKER 
GO
ALTER DATABASE [VideoRental] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [VideoRental] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [VideoRental] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [VideoRental] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [VideoRental] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [VideoRental] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [VideoRental] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [VideoRental] SET RECOVERY FULL 
GO
ALTER DATABASE [VideoRental] SET  MULTI_USER 
GO
ALTER DATABASE [VideoRental] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [VideoRental] SET DB_CHAINING OFF 
GO
ALTER DATABASE [VideoRental] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [VideoRental] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [VideoRental] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'VideoRental', N'ON'
GO
USE [VideoRental]
GO
/****** Object:  Table [dbo].[Clients]    Script Date: 12/22/2021 9:09:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Clients](
	[ClientID] [int] IDENTITY(1,1) NOT NULL,
	[LastName] [nvarchar](20) NOT NULL,
	[FirstName] [nvarchar](10) NOT NULL,
	[Address] [nvarchar](60) NOT NULL,
	[Phone_no] [char](12) NOT NULL,
	[Discount] [real] NOT NULL,
	[Balance] [money] NOT NULL,
 CONSTRAINT [PK_Clients] PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Movies]    Script Date: 12/22/2021 9:09:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movies](
	[MovieID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Genre] [nvarchar](50) NOT NULL,
	[ReleaseDate] [date] NOT NULL,
	[Duration] [time](7) NOT NULL,
	[Discription] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_Movies] PRIMARY KEY CLUSTERED 
(
	[MovieID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Proposals]    Script Date: 12/22/2021 9:09:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proposals](
	[ProposalID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NOT NULL,
	[NewMovieTitle] [nvarchar](50) NOT NULL,
	[DateOfProposal] [date] NOT NULL,
	[DateOfAddiction] [date] NULL,
	[MovieID] [int] NULL,
 CONSTRAINT [PK_Proposals] PRIMARY KEY CLUSTERED 
(
	[ProposalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Rental]    Script Date: 12/22/2021 9:09:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Rental](
	[RentalID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NOT NULL,
	[TapeID] [int] NULL,
	[OutDate] [date] NOT NULL,
	[DueDate] [date] NOT NULL,
	[Deposit] [char](1) NOT NULL,
	[RentPrice] [money] NOT NULL,
	[ReturnDate] [date] NULL,
	[Fine] [money] NULL,
 CONSTRAINT [PK_Rental] PRIMARY KEY CLUSTERED 
(
	[RentalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tapes]    Script Date: 12/22/2021 9:09:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tapes](
	[TapeID] [int] IDENTITY(1,1) NOT NULL,
	[MovieID] [int] NOT NULL,
	[Type] [nvarchar](10) NOT NULL,
	[DateManufacture] [date] NOT NULL,
	[TariffID] [nvarchar](20) NOT NULL,
	[Available] [char](1) NOT NULL,
 CONSTRAINT [PK_Tapes] PRIMARY KEY CLUSTERED 
(
	[TapeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tariffs]    Script Date: 12/22/2021 9:09:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tariffs](
	[TariffID] [nvarchar](20) NOT NULL,
	[PricePerDay] [money] NOT NULL,
	[DepositAmount] [money] NOT NULL,
	[FinePerDay] [money] NOT NULL,
 CONSTRAINT [PK_Tariffs] PRIMARY KEY CLUSTERED 
(
	[TariffID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[ActivityReportForManagement]    Script Date: 12/22/2021 9:09:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[ActivityReportForManagement]
AS
SELECT TOP 5
       Movies.MovieID
    ,  Movies.Title
    ,  Count(Rental.TapeID) AS RentCount
FROM Movies
INNER JOIN Tapes
ON Tapes.MovieID = Movies.MovieID
INNER JOIN Rental
ON Rental.TapeID = Tapes.TapeID
GROUP BY Movies.MovieID, Movies.Title
ORDER BY RentCount Desc

GO
/****** Object:  View [dbo].[CostReportForManagement]    Script Date: 12/22/2021 9:09:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[CostReportForManagement]
AS
SELECT
       Clients.ClientID
    ,  Clients.FirstName
    ,  Clients.LastName
    ,  Clients.Discount
    ,  SUM(Rental.RentPrice) AS TotalRentCost 
    ,  SUM(Rental.Fine) AS TotalFineCost
    ,  Clients.Balance
FROM Clients
INNER JOIN Rental
ON Clients.ClientID = Rental.ClientID
GROUP BY Clients.ClientID, Clients.LastName, Clients.FirstName, Clients.Discount, Clients.Balance

GO
/****** Object:  View [dbo].[MoviesCatalogForClients]    Script Date: 12/22/2021 9:09:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[MoviesCatalogForClients]
AS
SELECT	
       Movies.MovieID
    ,  Movies.Title
    ,  Movies.Genre
    ,  Movies.ReleaseDate
    ,  Movies.Duration
    ,  Movies.Discription
    ,  Tapes.TapeID
    ,  Tapes.Type
    ,  Tapes.Available
    ,  Tariffs.PricePerDay
    ,  Tariffs.DepositAmount
    ,  Tariffs.FinePerDay
FROM Movies
INNER JOIN Tapes
ON Tapes.MovieID = Movies.MovieID
INNER JOIN Tariffs
ON Tariffs.TariffID = Tapes.TariffID

GO
/****** Object:  View [dbo].[ProposalReportForManagement]    Script Date: 12/22/2021 9:09:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[ProposalReportForManagement]
AS
SELECT
       Proposals.ProposalID
    ,  Proposals.ClientID
    ,  Proposals.NewMovieTitle
    ,  Proposals.DateOfProposal
FROM Proposals
WHERE DateOfAddiction is NULL

GO
ALTER TABLE [dbo].[Clients] ADD  CONSTRAINT [DF_Clients_Discount]  DEFAULT ((0)) FOR [Discount]
GO
ALTER TABLE [dbo].[Clients] ADD  CONSTRAINT [DF_Clients_Balance]  DEFAULT ((0)) FOR [Balance]
GO
ALTER TABLE [dbo].[Tapes] ADD  CONSTRAINT [DF_Tapes]  DEFAULT ('1') FOR [Available]
GO
ALTER TABLE [dbo].[Proposals]  WITH NOCHECK ADD  CONSTRAINT [FK_Proposals_Clients] FOREIGN KEY([ClientID])
REFERENCES [dbo].[Clients] ([ClientID])
GO
ALTER TABLE [dbo].[Proposals] CHECK CONSTRAINT [FK_Proposals_Clients]
GO
ALTER TABLE [dbo].[Proposals]  WITH NOCHECK ADD  CONSTRAINT [FK_Proposals_Movies] FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movies] ([MovieID])
GO
ALTER TABLE [dbo].[Proposals] CHECK CONSTRAINT [FK_Proposals_Movies]
GO
ALTER TABLE [dbo].[Rental]  WITH NOCHECK ADD  CONSTRAINT [FK_Rental_Clients] FOREIGN KEY([ClientID])
REFERENCES [dbo].[Clients] ([ClientID])
GO
ALTER TABLE [dbo].[Rental] CHECK CONSTRAINT [FK_Rental_Clients]
GO
ALTER TABLE [dbo].[Rental]  WITH NOCHECK ADD  CONSTRAINT [FK_Rental_Tapes] FOREIGN KEY([TapeID])
REFERENCES [dbo].[Tapes] ([TapeID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Rental] CHECK CONSTRAINT [FK_Rental_Tapes]
GO
ALTER TABLE [dbo].[Tapes]  WITH NOCHECK ADD  CONSTRAINT [FK_Tapes_Movies] FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movies] ([MovieID])
GO
ALTER TABLE [dbo].[Tapes] CHECK CONSTRAINT [FK_Tapes_Movies]
GO
ALTER TABLE [dbo].[Tapes]  WITH NOCHECK ADD  CONSTRAINT [FK_Tapes_Tariffs] FOREIGN KEY([TariffID])
REFERENCES [dbo].[Tariffs] ([TariffID])
GO
ALTER TABLE [dbo].[Tapes] CHECK CONSTRAINT [FK_Tapes_Tariffs]
GO
ALTER TABLE [dbo].[Clients]  WITH NOCHECK ADD  CONSTRAINT [CK_phone] CHECK  (([Phone_no] like '+7[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[Clients] CHECK CONSTRAINT [CK_phone]
GO
ALTER TABLE [dbo].[Rental]  WITH NOCHECK ADD  CONSTRAINT [CK_Rental_DueDate] CHECK  (([DueDate]>[OutDate]))
GO
ALTER TABLE [dbo].[Rental] CHECK CONSTRAINT [CK_Rental_DueDate]
GO
ALTER TABLE [dbo].[Rental]  WITH NOCHECK ADD  CONSTRAINT [CK_Rental_Price] CHECK  (([RentPrice]>(0)))
GO
ALTER TABLE [dbo].[Rental] CHECK CONSTRAINT [CK_Rental_Price]
GO
ALTER TABLE [dbo].[Rental]  WITH NOCHECK ADD  CONSTRAINT [CK_Rental_ReturnDate] CHECK  (([ReturnDate]>[OutDate]))
GO
ALTER TABLE [dbo].[Rental] CHECK CONSTRAINT [CK_Rental_ReturnDate]
GO
ALTER TABLE [dbo].[Tariffs]  WITH NOCHECK ADD  CONSTRAINT [CK_Tariffs] CHECK  (([FinePerDay]<[PricePerDay]))
GO
ALTER TABLE [dbo].[Tariffs] CHECK CONSTRAINT [CK_Tariffs]
GO
/****** Object:  StoredProcedure [dbo].[AddProposal]    Script Date: 12/22/2021 9:09:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[AddProposal]
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
/****** Object:  StoredProcedure [dbo].[AddTape]    Script Date: 12/22/2021 9:09:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddTape]
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
/****** Object:  StoredProcedure [dbo].[FindMovie]    Script Date: 12/22/2021 9:09:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FindMovie]
    @Title nvarchar(50)
AS
    SELECT Movies.MovieID, Movies.Title, Tapes.TapeID, Tapes.Type, Tapes.Available
    FROM Movies
    INNER JOIN Tapes
    ON Movies.MovieID = Tapes.MovieID
    WHERE Movies.Title = @Title

GO
/****** Object:  StoredProcedure [dbo].[IsRegularClient]    Script Date: 12/22/2021 9:09:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IsRegularClient]
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
/****** Object:  StoredProcedure [dbo].[PlanningReturnDate]    Script Date: 12/22/2021 9:09:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[PlanningReturnDate]
     @TapeID int
AS
    SELECT TapeID, DueDate
    FROM Rental
    WHERE TapeID = @TapeID AND ReturnDate IS NULL 

GO
/****** Object:  StoredProcedure [dbo].[RemoveTape]    Script Date: 12/22/2021 9:09:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[RemoveTape]
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
/****** Object:  StoredProcedure [dbo].[RentTape]    Script Date: 12/22/2021 9:09:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[RentTape]
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
/****** Object:  StoredProcedure [dbo].[ReturnTape]    Script Date: 12/22/2021 9:09:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ReturnTape]
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


/****** Object:  Trigger [dbo].[TR_Client_Balance_credit]    Script Date: 12/22/2021 9:09:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[TR_Client_Balance_credit]
  ON [dbo].[Rental]
  AFTER INSERT
AS
  UPDATE C SET C.Balance = C.Balance - R.RentPrice
  FROM Clients AS C INNER JOIN Rental AS R
  ON C.ClientID = R.ClientID
  WHERE R.RentalID = @@IDENTITY
GO
ALTER TABLE [dbo].[Rental] ENABLE TRIGGER [TR_Client_Balance_credit]
GO
/****** Object:  Trigger [dbo].[TR_Client_Balance_debit]    Script Date: 12/22/2021 9:09:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[TR_Client_Balance_debit]
  ON [dbo].[Rental]
  AFTER UPDATE
AS
    IF (UPDATE (ReturnDate))
BEGIN
    UPDATE C SET C.Balance = C.Balance + I.RentPrice
    FROM Clients AS C INNER JOIN INSERTED AS I
    ON C.ClientID = I.ClientID
END
GO
ALTER TABLE [dbo].[Rental] ENABLE TRIGGER [TR_Client_Balance_debit]
GO
/****** Object:  Trigger [dbo].[TR_Tapes_Available]    Script Date: 12/22/2021 9:09:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   
CREATE TRIGGER [dbo].[TR_Tapes_Available]
  ON [dbo].[Rental]
  AFTER UPDATE
AS
    IF (UPDATE (ReturnDate))
BEGIN
    UPDATE T SET Available = '1'
    FROM Tapes AS T INNER JOIN INSERTED AS I
    ON T.TapeID = I.TapeID
END
GO
ALTER TABLE [dbo].[Rental] ENABLE TRIGGER [TR_Tapes_Available]
GO
/****** Object:  Trigger [dbo].[TR_Tapes_NotAvailable]    Script Date: 12/22/2021 9:09:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[TR_Tapes_NotAvailable]
   ON [dbo].[Rental]
   AFTER INSERT
AS
   UPDATE T SET Available = '0'
   FROM Tapes AS T INNER JOIN Rental AS R
   ON T.TapeID = R.TapeID
   WHERE R.RentalID = @@IDENTITY
GO
ALTER TABLE [dbo].[Rental] ENABLE TRIGGER [TR_Tapes_NotAvailable]
GO

USE [master]
GO
ALTER DATABASE [VideoRental] SET  READ_WRITE 
GO
