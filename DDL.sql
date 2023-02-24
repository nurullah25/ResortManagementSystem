/*							
							SQL Project Name : Resort Management Systems 
							    Trainee Name : Nur Mohammad Nurullah   
						    	  Trainee ID : 1269549       
								    Batch ID : ESAD-CS/PNTL-A/51/01 

																															*/
--=====================================   START OF DDL SCRIPT   =======================================--

USE master
GO

DROP DATABASE IF EXISTS resortManagementDB
GO

CREATE DATABASE resortManagementDB
ON
(
	NAME= resortManagementDB_data,
	FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\resortManagementDB_data.mdf',
	SIZE=50MB,
	MAXSIZE=100MB,
	FILEGROWTH=10MB
)
LOG ON
(
	NAME= resortManagementDB_log,
	FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\resortManagementDB_log.ldf',
	SIZE=15MB,
	MAXSIZE=50MB,
	FILEGROWTH=5%
)
GO

USE resortManagementDB
GO

CREATE TABLE tbl_Customer
(
	customerId INT PRIMARY KEY,
	customerName VARCHAR(40) NOT NULL,
	[address] NVARCHAR(50) NOT NULL,
	contactNo CHAR(11) NOT NULL,
	gender CHAR(6) NOT NULL,
	nId CHAR(13) NOT NULL UNIQUE CHECK(NID LIKE'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	eMail VARCHAR(20) NULL
)
GO


CREATE TABLE tbl_Booking
(
	bookingId INT IDENTITY PRIMARY KEY,
	bookingDate DATETIME DEFAULT GETDATE(),
	customerId INT REFERENCES tbl_customer(customerId),
	checkIn DATETIME NOT NULL,
	checkOut DATETIME NULL,
	[status] VARCHAR(30) NULL,
	roomTypeId INT REFERENCES tbl_RoomType(roomTypeId)
)
GO


CREATE TABLE tbl_Employee
(
	employeeId INT PRIMARY KEY,
	employeeName VARCHAR(30) NOT NULL,
	employeeType VARCHAR(20) NOT NULL,
	dob DATETIME NOT NULL,
	hireDate DATETIME NOT NULL,
	nId CHAR(13) NOT NULL,
	[address] VARCHAR(30) NOT NULL,
	phone CHAR(11) NOT NULL
)
GO



CREATE TABLE tbl_Payment
(
	paymentId INT PRIMARY KEY,
	customerId INT REFERENCES tbl_Customer(customerId),
	bookingId INT REFERENCES tbl_Booking(bookingId),
	roomTypeId INT REFERENCES tbl_RoomType(roomTypeId),
	paymentType VARCHAR(20) NOT NULL,
	amount MONEY NOT NULL,
	paymentDate DATETIME DEFAULT GETDATE()
)
GO



CREATE TABLE tbl_Room
(
	roomId INT PRIMARY KEY,
	roomTypeId INT REFERENCES tbl_RoomType(roomTypeId),
	roomNumber INT NOT NULL,
	[description] NVARCHAR(30)
)
GO


CREATE TABLE tbl_RoomType
(
	roomTypeId INT PRIMARY KEY,
	roomType VARCHAR(20),
	roomCost MONEY NOT NULL DEFAULT 1000,
	[description] NVARCHAR(30)
)
GO



CREATE TABLE tbl_Order
(
	orderId INT NOT NULL,
	orderDate DATETIME NOT NULL,
	customerId INT REFERENCES tbl_Customer(customerId),
	employeeId INT REFERENCES tbl_Employee(employeeId),
	itemName VARCHAR(20) NOT NULL,
	unitPrice FLOAT NOT NULL,
	quantity INT NOT NULL,
	discount FLOAT NULL,
	total AS unitPrice*Quantity
)
GO



CREATE TABLE tbl_Item
(
	itemId INT ,
	itemName VARCHAR(20),
	details VARCHAR(30)
)
GO

---------------------------ALTER TABLE (Change Nullability,ADD, DELETE COLUMN, DROP COLUMN)------------------------
--Change Nullability
ALTER TABLE tbl_Order
ALTER COLUMN discount FLOAT NOT NULL
GO

--ALTER COLUMN
ALTER TABLE tbl_Order
ALTER COLUMN itemName VARCHAR(30)
GO

-- ADD COLUMN TO AN EXISTING TABLE

ALTER TABLE tbl_RoomType
ADD [status] VARCHAR(20) NOT NULL DEFAULT 'N/A'
GO

--DELETE COLUMN FROM AN EXISTING TABLE
ALTER TABLE tbl_RoomType
DROP COLUMN [status]
GO

--DROP A TABLE
IF OBJECT_ID('tbl_Item') IS NOT NULL
DROP TABLE tbl_Item
GO

--------- CREATING INDEX, VIEW, STORED PROCEDURE, FUNTIONS, TRIGGERS  -----------


--*************************************   001 INDEX   *************************************--


--CREATING A NON-CLUSTERED INDEX FOR CUSTOMER TABLE
CREATE UNIQUE NONCLUSTERED INDEX IX_tbl_Order
ON tbl_order(orderId)
GO

--CREATING A CLUSTERED INDEX
CREATE CLUSTERED INDEX IX_tbl_Item
ON tbl_Item(itemId)
GO


--********************************  002 VIEW   ****************************************


CREATE VIEW Vwtbl_Booking
AS
SELECT * FROM tbl_Booking
GO


SELECT * FROM Vwtbl_Booking
GO

--as booking is referenced to others table, we can not delete it using view.
-- but I am writing the syntax of deleting data using view
DELETE FROM Vwtbl_Booking
WHERE bookingId=1
GO


--Creating a view to find out customers who have ordered more than 500 tk

CREATE VIEW Vtbl_Order1

AS
SELECT TOP 5 PERCENT O.OrderId,c.customerId,O.Quantity,O.UnitPrice 
FROM tbl_Order O
JOIN tbl_Customer c ON O.CustomerId=c.customerId
WHERE (UnitPrice*Quantity) >=500
WITH CHECK OPTION
GO


--********************************     003 STORED PROCEDURE   ********************************--
--A store procedure to see all room info
CREATE PROC spRoomAll
AS
SELECT roomId,roomNumber,roomType FROM tbl_Room r
JOIN tbl_RoomType rt ON r.roomTypeId=rt.roomTypeId
GO


--A STORED PROCEDURE FOR QUERY  DATA

CREATE PROC spTblCustomers
WITH ENCRYPTION
AS
SELECT * FROM tbl_Customer
WHERE gender='MALE'
GO

--Create a Stored Procedure for inserting DATA
CREATE PROC spInsertCustomers
							@customerId INT,
							@customerName VARCHAR(40),
							@address NVARCHAR(50),
							@contactNo CHAR(11),
							@gender CHAR(6),
							@nId CHAR(13),
							@eMail VARCHAR(20)

AS
BEGIN
	INSERT INTO tbl_Customer(customerId,customerName,[address],contactNo,gender,nId,eMail)
	VALUES(@customerId,@customerName,@address,@contactNo,@gender,@nId,@eMail)
END
GO

--A Stored procedure for deleting data 
CREATE PROC sp_deleteCustomers
								@customerName VARCHAR(40)
AS 
	DELETE FROM tbl_Customer WHERE customerName=@customerName
GO

--A Stored procedure for inserting data with return values
CREATE PROC sp_InsertEmployeesWithReturn
						@employeeId INT,
						@employeeName VARCHAR(30),
						@employeeType VARCHAR(20),
						@dob DATETIME,
						@hiredate DATETIME,
						@nId CHAR(13),
						@address VARCHAR(30),
						@phone CHAR(11)
AS
DECLARE @id INT 
INSERT INTO tbl_Employee VALUES(@employeeId,@employeeName,@employeeType,@dob,@hiredate,@nId,@address,@phone)
SELECT @id=@employeeId
RETURN @id
GO




--A Stored procedure for inserting data with output parameter
CREATE PROC sp_InsertEmployeeWithOutPutParameter
						@employeeId INT,
						@employeeName VARCHAR(30),
						@employeeType VARCHAR(20),
						@dob DATETIME,
						@hiredate DATETIME,
						@nID CHAR(13),
						@address VARCHAR(30),
						@phone CHAR(11)
						
AS
INSERT INTO tbl_Employee VALUES(@employeeid,@employeeName,@employeeType,@dob,@hiredate,@nID,@address,@phone)
SELECT @employeeId=IDENT_CURRENT('tbl_Employee')
GO


-- Count Total Employee Through Output Parameters in Stored Procedure

CREATE PROC spCountEmployee (@CountEmployee INT OUTPUT)
AS
BEGIN
    SELECT @CountEmployee = COUNT(employeeId) FROM tbl_Employee
END
GO

-- DECLARE THE Above Stored Procedure --

DECLARE @TotalEmployee INT 
    EXEC dbo.spCountEmployee @TotalEmployee OUTPUT
    PRINT @TotalEmployee
GO

--==================================================   FUNCTIONS   =========================================================--


--functions
/*
There are three types of user defined functions(UDF) in sql.
				1.Scalar valued function
				2.Single-Statement table valued function
				3.Multi-Statement table valued function

I have used all three UDF in my project
*/
--1. Scalar valued function for calculating the total sales amount

CREATE FUNCTION fn_OrdersDetails (@month int,@year int)
RETURNS INT
AS
	BEGIN
		DECLARE @amount MONEY
		SELECT @amount=SUM(unitPrice*quantity) FROM tbl_Order
		WHERE YEAR(OrderDate)=@year AND MONTH(OrderDate)=@month
		RETURN @amount
	END	
GO

--- IN LINE TABLE VALUED FUNCTION(as single statement we won't use BEGIN END block)
CREATE FUNCTION fnSalesSummaryOfMonth(@year INT,@month INT)
RETURNS TABLE
AS 
RETURN
(
	SELECT 
	SUM(UnitPrice*Quantity) AS 'Total Amount',
	SUM(UnitPrice*Quantity*Discount) AS 'Total Discount',
	SUM(UnitPrice*Quantity*(1-Discount)) AS 'Net Amount'
	FROM tbl_Order O 
	WHERE YEAR([orderDate])=@year AND MONTH([orderDate])=@month
)
GO

--Multi-Statement table-valued function(More than one statement. So we will use BEGIN AND END STATEMENT)

CREATE FUNCTION fnSalesDetails(@year INT, @month INT)
RETURNS @salesDetails TABLE
(
	itemName VARCHAR(30),
	total MONEY,
	discount FLOAT,
	netSales MONEY
)
AS
BEGIN
		 INSERT INTO @salesDetails
	SELECT 
	itemName,
	SUM(unitPrice*quantity),
	SUM(unitPrice*quantity*discount),
	SUM(unitPrice * quantity*(1-discount))
	FROM tbl_Order
	WHERE YEAR([orderDate])=@year AND MONTH([orderDate])=@month
	GROUP BY itemName
	RETURN
END
GO

END
GO





/* Created Trigger*/


--Created a For trigger to restrict update and delete
CREATE TRIGGER trDeleteUpdate
On tbl_Customer
FOR UPDATE,DELETE
AS
BEGIN
	PRINT 'No Update Or Delete Permitted'
	ROLLBACK TRANSACTION
END
GO


--Created table for making Trigger
--For trigger to Insert data
CREATE Table product
(
	productId INT PRIMARY KEY,
	productName VARCHAR(20),
	unitPrice Money,
	stock INT DEFAULT 0
)
GO
INSERT INTO product VALUES
(1,'Rice',1250,0),
(2,'Oil',2700,0),
(3,'Daal',1500,0)
GO
CREATE TABLE Instock
(
	stockId INT PRIMARY KEY,
	[date] DATETIME DEFAULT GETDATE(),
	productId INT REFERENCES product(productId),
	quantity INT
)
GO
CREATE TABLE sales
(
	id INT,
	[date] DATETIME,
	productId INT REFERENCES product(productId),
	sale INT
)
GO
--(Created Trigger to insert data in two or more  table at a time)
CREATE Trigger trStockIn
ON Instock
FOR INSERT
AS
BEGIN
	DECLARE @i INT
	DECLARE @q INT

	SELECT @i=productId,@q=quantity FROM inserted

	UPDATE product SET stock=stock+@q WHERE @i=productId
END
GO




--Instead Of Trigger
--Created a Instead of TRIGGER ON TABLE tbl_Customer
CREATE TRIGGER trRestrict
ON tbl_Customer
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @cn NVARCHAR(40)
	SELECT @cn=customerName FROM inserted
	IF @cn<=1
	BEGIN
		INSERT INTO tbl_Customer
		SELECT customerId,customerName,address,contactNo,gender,nId,eMail FROM inserted
	END
	ELSE
	BEGIN
		RAISERROR ('Entry not Acceptable',10,1)
		ROLLBACK TRANSACTION
	END
END
GO


/*********************************** TRANSACTION***************************************/

-- Created A Transaction Name [PaymentTransfer]
CREATE PROCEDURE spPaymentTransfer  @from INT,
								    @to INT,
								    @payment MONEY
AS
BEGIN TRY
	  BEGIN TRANSACTION
		UPDATE tbl_Payment
		SET amount=amount+@payment
		WHERE paymentId=@to

		UPDATE tbl_Payment
		SET amount=amount-@payment
		WHERE paymentId=@from
		COMMIT TRANSACTION
END TRY
BEGIN CATCH
		RAISERROR('Operation Failed!!!',10,1)
		ROLLBACK TRANSACTION
END CATCH
GO


--========================================== End of DDL ==========================================================--