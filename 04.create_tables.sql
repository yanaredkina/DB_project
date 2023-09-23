/*
This script file creates all of the tables for the VideoRental database.
There are a total of 6 tables.
Tables are dropped first in case this is a re-creation.
*/

USE VideoRental

If OBJECT_ID('dbo.Clients') IS NOT NULL
	DROP TABLE dbo.Clients
If OBJECT_ID('dbo.Rental') IS NOT NULL
	DROP TABLE dbo.Rental
If OBJECT_ID('dbo.Movies') IS NOT NULL
	DROP TABLE dbo.Movies
If OBJECT_ID('dbo.Tapes') IS NOT NULL
	DROP TABLE dbo.Tapes
If OBJECT_ID('dbo.Tariffs') IS NOT NULL
	DROP TABLE dbo.Tariffs
If OBJECT_ID('dbo.Proposals') IS NOT NULL
	DROP TABLE dbo.Proposals
    
    
    
CREATE TABLE Clients
  (
     ClientID      int IDENTITY (1, 1) NOT NULL 
  ,	 LastName      nvarchar (20)       NOT NULL
  ,	 FirstName     nvarchar (10)       NOT NULL
  ,  Address       nvarchar (60)       NOT NULL
  ,  Phone_no      char(12)            NOT NULL
  ,  Discount      real                NOT NULL
  ,  Balance       money               NOT NULL
  )
  ON [PRIMARY]
GO


CREATE TABLE Rental
  (
     RentalID      int IDENTITY (1, 1) NOT NULL 
  ,	 ClientID      int                 NOT NULL
  ,	 TapeID        int                     NULL
  ,  OutDate       date                NOT NULL
  ,  DueDate       date                NOT NULL
  ,  Deposit       char(1)             NOT NULL
  ,  RentPrice     money               NOT NULL
  ,  ReturnDate    date                    NULL
  ,  Fine          money                   NULL
  )
  ON [PRIMARY]
GO


CREATE TABLE Tapes
  (
     TapeID          int IDENTITY (1, 1) NOT NULL 
  ,	 MovieID         int                 NOT NULL
  ,  Type            nvarchar(10)        NOT NULL
  ,  DateManufacture date                NOT NULL
  ,  TariffID        nvarchar(20)        NOT NULL
  ,  Available       char(1)             NOT NULL
  )
  ON [PRIMARY]
GO


CREATE TABLE Movies
  (
     MovieID       int IDENTITY (1, 1) NOT NULL 
  ,	 Title         nvarchar(50)        NOT NULL
  ,	 Genre         nvarchar(50)        NOT NULL
  ,  ReleaseDate   date                NOT NULL
  ,  Duration      time                NOT NULL
  ,  Discription   nvarchar(250)       NOT NULL
  )
  ON [PRIMARY]
GO

CREATE TABLE Tariffs
  (
     TariffID      nvarchar(20)        NOT NULL 
  ,  PricePerDay   money               NOT NULL
  ,  DepositAmount money               NOT NULL
  ,  FinePerDay    money               NOT NULL
  )
  ON [PRIMARY]
GO

CREATE TABLE Proposals
  (
     ProposalID      int IDENTITY (1, 1) NOT NULL 
  ,	 ClientID        int                 NOT NULL
  ,  NewMovieTitle   nvarchar(50)        NOT NULL
  ,  DateOfProposal  date                NOT NULL
  ,  DateOfAddiction date                    NULL
  ,  MovieID         int                     NULL
  )
  ON [PRIMARY]
GO


/* Add a primary key constraint to every table */

USE VideoRental
SET NOCOUNT ON
GO

IF EXISTS 
   (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
    where CONSTRAINT_SCHEMA = 'dbo'
      AND CONSTRAINT_NAME = 'PK_Clients'
      AND CONSTRAINT_TYPE = 'PRIMARY KEY')
  ALTER TABLE Clients
      DROP CONSTRAINT PK_Clients
      
IF EXISTS 
 (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
  where CONSTRAINT_SCHEMA = 'dbo'
    AND CONSTRAINT_NAME = 'PK_Rental'
    AND CONSTRAINT_TYPE = 'PRIMARY KEY')
ALTER TABLE Rental
    DROP CONSTRAINT PK_Rental

IF EXISTS 
 (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
  where CONSTRAINT_SCHEMA = 'dbo'
    AND CONSTRAINT_NAME = 'PK_Tapes'
    AND CONSTRAINT_TYPE = 'PRIMARY KEY')
ALTER TABLE Tapes
    DROP CONSTRAINT PK_Tapes
    
IF EXISTS 
 (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
  where CONSTRAINT_SCHEMA = 'dbo'
    AND CONSTRAINT_NAME = 'PK_Movies'
    AND CONSTRAINT_TYPE = 'PRIMARY KEY')
ALTER TABLE Movies
    DROP CONSTRAINT PK_Movies

IF EXISTS 
 (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
  where CONSTRAINT_SCHEMA = 'dbo'
    AND CONSTRAINT_NAME = 'PK_Tariffs'
    AND CONSTRAINT_TYPE = 'PRIMARY KEY')
ALTER TABLE Tariffs
    DROP CONSTRAINT PK_Tariffs

IF EXISTS 
 (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
  where CONSTRAINT_SCHEMA = 'dbo'
    AND CONSTRAINT_NAME = 'PK_Proposals'
    AND CONSTRAINT_TYPE = 'PRIMARY KEY')
ALTER TABLE Proposals
    DROP CONSTRAINT PK_Proposals
GO

ALTER TABLE Clients
    ADD CONSTRAINT PK_Clients PRIMARY KEY CLUSTERED (ClientID)
  
ALTER TABLE Rental
    ADD CONSTRAINT PK_Rental PRIMARY KEY CLUSTERED (RentalID)

ALTER TABLE Tapes
    ADD CONSTRAINT PK_Tapes PRIMARY KEY CLUSTERED (TapeID)
    
ALTER TABLE Movies
    ADD CONSTRAINT PK_Movies PRIMARY KEY CLUSTERED (MovieID)
    
ALTER TABLE Tariffs
    ADD CONSTRAINT PK_Tariffs PRIMARY KEY CLUSTERED (TariffID)
    
ALTER TABLE Proposals
    ADD CONSTRAINT PK_Proposals PRIMARY KEY CLUSTERED (ProposalID)
GO
        
SET NOCOUNT OFF
GO


/* Add a Chek constraint */


USE VideoRental
SET NOCOUNT ON
GO

IF EXISTS 
    (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
     where CONSTRAINT_SCHEMA = 'dbo'
        AND CONSTRAINT_NAME = 'CK_phone'
        AND CONSTRAINT_TYPE = 'CHECK')
ALTER TABLE Clients
     DROP CONSTRAINT CK_phone
     
IF EXISTS      
    (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
     where CONSTRAINT_SCHEMA = 'dbo'
        AND CONSTRAINT_NAME = 'CK_Rental_DueDate'
        AND CONSTRAINT_TYPE = 'CHECK')
ALTER TABLE Rental
     DROP CONSTRAINT CK_Rental_DueDate

IF EXISTS      
    (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
     where CONSTRAINT_SCHEMA = 'dbo'
        AND CONSTRAINT_NAME = 'CK_Rental_ReturnDate'
        AND CONSTRAINT_TYPE = 'CHECK')
ALTER TABLE Rental
    DROP CONSTRAINT CK_Rental_ReturnDate

IF EXISTS      
  (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
   where CONSTRAINT_SCHEMA = 'dbo'
      AND CONSTRAINT_NAME = 'CK_Rental_Price'
      AND CONSTRAINT_TYPE = 'CHECK')
ALTER TABLE Rental
    DROP CONSTRAINT CK_Rental_Price

IF EXISTS      
  (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
   where CONSTRAINT_SCHEMA = 'dbo'
      AND CONSTRAINT_NAME = 'CK_Tariffs'
      AND CONSTRAINT_TYPE = 'CHECK')
ALTER TABLE Tariffs
    DROP CONSTRAINT CK_Tariffs
GO

ALTER TABLE Clients WITH NOCHECK
   ADD CONSTRAINT CK_phone CHECK (Phone_no LIKE '+7[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
   
ALTER TABLE Rental WITH NOCHECK
    ADD CONSTRAINT CK_Rental_DueDate CHECK (DueDate > OutDate)
    
ALTER TABLE Rental WITH NOCHECK
    ADD CONSTRAINT CK_Rental_ReturnDate CHECK (ReturnDate > OutDate)

ALTER TABLE Rental WITH NOCHECK
    ADD CONSTRAINT CK_Rental_Price CHECK (RentPrice > 0)

ALTER TABLE Tariffs WITH NOCHECK
    ADD CONSTRAINT CK_Tariffs CHECK (FinePerDay < PricePerDay)
GO

SET NOCOUNT OFF
GO

/* Add a Default constraint */

USE VideoRental
SET NOCOUNT ON
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'DF_Clients_Discount')
  ALTER TABLE Clients
    DROP CONSTRAINT DF_Clients_Discount
    
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'DF_Clients_Balance')
  ALTER TABLE Clients
    DROP CONSTRAINT DF_Clients_Balance
    
    
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'DF_Tapes')
  ALTER TABLE Tapes
    DROP CONSTRAINT DF_Tapes
GO

ALTER TABLE Clients
    ADD CONSTRAINT DF_Clients_Discount DEFAULT 0 FOR Discount
  
ALTER TABLE Clients
    ADD CONSTRAINT DF_Clients_Balance DEFAULT 0 FOR Balance

ALTER TABLE Tapes
    ADD CONSTRAINT DF_Tapes DEFAULT '1' FOR Available
GO

SET NOCOUNT OFF
GO

/* Add a Foreign key constraint */

USE VideoRental
SET NOCOUNT ON
GO

IF EXISTS 
   (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
    where CONSTRAINT_SCHEMA = 'dbo'
        AND CONSTRAINT_NAME = 'FK_Rental_Clients'
        AND CONSTRAINT_TYPE = 'FOREIGN KEY')
ALTER TABLE Rental
    DROP CONSTRAINT FK_Rental_Clients
     
IF EXISTS 
    (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
    where CONSTRAINT_SCHEMA = 'dbo'
        AND CONSTRAINT_NAME = 'FK_Rental_Tapes'
        AND CONSTRAINT_TYPE = 'FOREIGN KEY')
ALTER TABLE Rental
    DROP CONSTRAINT FK_Rental_Tapes
    
    
IF EXISTS 
    (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
    where CONSTRAINT_SCHEMA = 'dbo'
        AND CONSTRAINT_NAME = 'FK_Tapes_Movies'
        AND CONSTRAINT_TYPE = 'FOREIGN KEY')
ALTER TABLE Tapes
    DROP CONSTRAINT FK_Tapes_Movies
    
IF EXISTS 
    (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
    where CONSTRAINT_SCHEMA = 'dbo'
        AND CONSTRAINT_NAME = 'FK_Tapes_Tariffs'
        AND CONSTRAINT_TYPE = 'FOREIGN KEY')
ALTER TABLE Tapes
    DROP CONSTRAINT FK_Tapes_Tariffs
    
IF EXISTS 
    (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
    where CONSTRAINT_SCHEMA = 'dbo'
        AND CONSTRAINT_NAME = 'FK_Proposals_Movies'
        AND CONSTRAINT_TYPE = 'FOREIGN KEY')
ALTER TABLE Proposals
    DROP CONSTRAINT FK_Proposals_Movies
GO

IF EXISTS 
    (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
    where CONSTRAINT_SCHEMA = 'dbo'
        AND CONSTRAINT_NAME = 'FK_Proposals_Clients'
        AND CONSTRAINT_TYPE = 'FOREIGN KEY')
ALTER TABLE Proposals
    DROP CONSTRAINT FK_Proposals_Clients
GO

ALTER TABLE Rental WITH NOCHECK
    ADD CONSTRAINT FK_Rental_Clients FOREIGN KEY (ClientID) REFERENCES Clients (ClientID)
   
ALTER TABLE Rental WITH NOCHECK
    ADD CONSTRAINT FK_Rental_Tapes FOREIGN KEY (TapeID) REFERENCES Tapes (TapeID) ON DELETE SET NULL
  
ALTER TABLE Tapes WITH NOCHECK
    ADD CONSTRAINT FK_Tapes_Movies FOREIGN KEY (MovieID) REFERENCES Movies (MovieID)

ALTER TABLE Tapes WITH NOCHECK
    ADD CONSTRAINT FK_Tapes_Tariffs FOREIGN KEY (TariffID) REFERENCES Tariffs (TariffID)
    
ALTER TABLE Proposals WITH NOCHECK
    ADD CONSTRAINT FK_Proposals_Movies FOREIGN KEY (MovieID) REFERENCES Movies (MovieID)

ALTER TABLE Proposals WITH NOCHECK
    ADD CONSTRAINT FK_Proposals_Clients FOREIGN KEY (ClientID) REFERENCES Clients (ClientID)
GO

SET NOCOUNT OFF
GO