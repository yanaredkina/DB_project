/* This script creates triggers for Rental Table of the VideoRental database */

/*  If the objects already exist - drop them */

USE VideoRental
GO

IF EXISTS ( SELECT name FROM sysobjects WHERE type = 'TR' AND name = 'TR_Tapes_NotAvailable' )
    DROP TRIGGER TR_Tapes_NotAvailable
IF EXISTS ( SELECT name FROM sysobjects WHERE type = 'TR' AND name = 'TR_Tapes_Available' )
    DROP TRIGGER TR_Tapes_Available
    
IF EXISTS ( SELECT name FROM sysobjects WHERE type = 'TR' AND name = 'TR_Client_Balance_credit' )
    DROP TRIGGER TR_Client_Balance_credit
IF EXISTS ( SELECT name FROM sysobjects WHERE type = 'TR' AND name = 'TR_Client_Balance_debit' )
    DROP TRIGGER TR_Client_Balance_debit
GO


/* Create trigger:
When a rent is issued for a certain tape, the available status of this tape in the Tapes table changes to unavailable = '0'
*/

CREATE TRIGGER TR_Tapes_NotAvailable
   ON Rental
   AFTER INSERT
AS
   UPDATE T SET Available = '0'
   FROM Tapes AS T INNER JOIN Rental AS R
   ON T.TapeID = R.TapeID
   WHERE R.RentalID = @@IDENTITY 
GO   
   
/* Create trigger:
When a rent is issued for a certain client, his balance in the Clients table is credited for the amount of RentPrice (with minus)
*/

CREATE TRIGGER TR_Client_Balance_credit
  ON Rental
  AFTER INSERT
AS
  UPDATE C SET C.Balance = C.Balance - R.RentPrice
  FROM Clients AS C INNER JOIN Rental AS R
  ON C.ClientID = R.ClientID
  WHERE R.RentalID = @@IDENTITY 
GO
   
/* Create trigger:
When tape is returned, the available status of this tape in the Tapes table changes to available = '1'
*/  
   
CREATE TRIGGER TR_Tapes_Available
  ON Rental
  AFTER UPDATE
AS
    IF (UPDATE (ReturnDate))
BEGIN
    UPDATE T SET Available = '1'
    FROM Tapes AS T INNER JOIN INSERTED AS I
    ON T.TapeID = I.TapeID
END
GO

/* Create trigger:
When tape is returned and client paid the debt, his balance in the Clients table is debited to zero
*/  

CREATE TRIGGER TR_Client_Balance_debit
  ON Rental
  AFTER UPDATE
AS
    IF (UPDATE (ReturnDate))
BEGIN
    UPDATE C SET C.Balance = C.Balance + I.RentPrice
    FROM Clients AS C INNER JOIN INSERTED AS I
    ON C.ClientID = I.ClientID
END
GO