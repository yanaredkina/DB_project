/* This scripts creates the VIEWS for the VideoRental database */

USE VideoRental
GO

/* If the objects already exist drop them */

IF EXISTS ( SELECT * FROM information_schema.views
            WHERE table_name = 'MoviesCatalogForClients' 
            AND table_schema = 'dbo')
    DROP VIEW MoviesCatalogForClients

IF EXISTS ( SELECT * FROM information_schema.views
            WHERE table_name = 'CostReportForManagement' 
            AND table_schema = 'dbo')
    DROP VIEW CostReportForManagement
    
    
IF EXISTS ( SELECT * FROM information_schema.views
            WHERE table_name = 'ActivityReportForManagement' 
            AND table_schema = 'dbo')
    DROP VIEW ActivityReportForManagement

IF EXISTS ( SELECT * FROM information_schema.views
            WHERE table_name = 'ProposalReportForManagement' 
            AND table_schema = 'dbo')
    DROP VIEW ProposalReportForManagement
    
GO

/* Create view for clients: it contains info about movie (from Movies table), some info about tape (from Tapes table) and info about price (from Tariffs) */

CREATE VIEW dbo.MoviesCatalogForClients
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

/* Create view for management: it contains profit matters about all deals until now: some info about clients (from Clients table), some info about rent price and fine (from Rental table) */ 

CREATE VIEW dbo.CostReportForManagement
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


/* Create view for management: it contains info about most popular films */ 

CREATE VIEW dbo.ActivityReportForManagement
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

/* Create view for management: it contains psoposals for updating movie catalog without those, that has already was added  */ 

CREATE VIEW dbo.ProposalReportForManagement
AS
SELECT
       Proposals.ProposalID
    ,  Proposals.ClientID
    ,  Proposals.NewMovieTitle
    ,  Proposals.DateOfProposal
FROM Proposals
WHERE DateOfAddiction is NULL
GO