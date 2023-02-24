/*							
							SQL Project Name : Resort Management Systems 
							    Trainee Name : Nur Mohammad Nurullah   
						    	  Trainee ID : 1269549       
								    Batch ID : ESAD-CS/PNTL-A/51/01 

																															*/
--=====================================   START OF DML SCRIPT   =======================================--

/* Insert data into tbl_customer table */

INSERT INTO tbl_Customer VALUES 
(1,'MD. AL-AMIN','DHAKA',01236547852,'MALE',1992565852123,NULL),
(2,'MD. SHAON KHALIFA','NARAYANGANJ',01236547852,'MALE',1991235852123,'shaoon@gmail.com'),
(3,'MRS. RAHIMA KHATUN','GAZIPUR',01222547852,'FEMALE',1995555852123,'rahima@gmail.com'),
(4,'MD. MAHBUR RAHMAN','CUMILLA',01266547852,'MALE',1996886585212,NULL),
(5,'MD. FARUQ HOSSAIN','BARISHAL',01299547852,'MALE',1993333852123,'mdfaruq@gmail.com'),
(6,'MRS. FAIZA ','RAJSHAHI',01236999952,'FEMALE',1998555852123,'msfaiza@gmail.com'),
(7,'MD. RAKIBUL HASIB','NOAKHALI',01288547852,'MALE',1994445852123,NULL),
(8,'MD GOLAM KIBRIYA','JESSORE',01256256233,'MALE',1997565452233,NULL)
GO

SELECT * FROM tbl_Customer
GO

/* Insert data into tbl_Booking table */

INSERT INTO tbl_Booking VALUES
('2022-03-01',1,'2022-03-03','2022-03-05','OUT',1),
('2022-03-02',2,'2022-03-03','2022-03-07','OUT',2),
('2022-03-03',3,'2022-03-03','2022-03-08','OUT',3),
('2022-04-04',4,'2022-04-06','2022-04-09','OUT',4),
('2022-05-05',5,'2022-05-06','2022-05-11','OUT',5),
('2022-06-01',6,'2022-06-03',NULL,'IN',2),
('2022-06-02',7,'2022-06-05',NULL,'IN',5),
('2022-06-03',3,'2022-06-06',NULL,'IN',3)
GO

SELECT* FROM tbl_Booking
GO

/* Insert data into tbl_Employee table */

INSERT INTO tbl_Employee VALUES
(1,'MD. RASHIDUL HASAN','MANAGER','1988-07-05','2021-08-06',1988659865982,'NATORE',01255476910),
(2,'MD. SHORIF HASAN','RECEPTIONIST','1990-10-15','2021-12-02',1990659665982,'CUMILLA',01299476910),
(3,'MD. ROBIUL ISLAM','ACCOUNTANT','1991-12-05','2022-02-01',1991659865982,'DHAKA',01256666910),
(4,'MD. ABBAS ALI','ROOM ATTENDENT','1995-03-11','2021-08-06',1995659833982,'RAJSHAHI',01255473330),
(5,'BELAL HOSSAIN','CHEF','1996-07-05','2020-08-06',1996159865982,'DHAKA',01266666910),
(6,'MD. NAHIM','WAITER','1999-07-05','2021-08-06',1999659865982,'GAZIPUR',01255555550),
(7,'MD. GOFUR ALI','CLEANER','1988-11-11','2022-01-01',1985659865982,'NATORE',01257776910)
GO

SELECT * FROM tbl_Employee
GO

/* Insert data into tbl_Payment table */

INSERT INTO tbl_Payment VALUES
(1001,1,1,1,'CASH',2000.00,'2022-03-05'),
(1002,2,2,2,'CARD',10000.00,'2022-03-07'),
(1003,3,3,3,'CASH',10000.00,'2022-03-08'),
(1004,4,4,4,'CARD',13500.00,'2022-03-05'),
(1005,5,5,5,'CASH',50000.00,'2022-03-05')
GO

SELECT * FROM tbl_Payment
GO

/* Insert data into tbl_Room table */

INSERT INTO tbl_Room VALUES 
(121,1,101,'Non AC North Face Room'),
(122,3,102,'Non AC Double North Face Room'),
(123,2,201,'AC south face'),
(124,4,202,'Double, AC, South Face Room'),
(125,5,301,'VIP, Sea View Penthouse ')
GO

SELECT * FROM tbl_Room
GO

/* Insert data into tbl_RoomType table */

INSERT INTO tbl_RoomType VALUES
(1,'SINGLE Non AC',1000.00,'Genereal Category Room'),
(2,'SINGLE AC',2500.00,'Premium Category Room'),
(3,'DOUBLE Non AC',2000.00,'Double size bed'),
(4,'DOUBLE AC',4500.00,'Double bed,Premium Category'),
(5,'Penthouse',10000.00,'VIP SPECIAL ROOM')
GO

SELECT * FROM tbl_RoomType
GO

/* Insert data into tbl_Order table */

INSERT INTO tbl_Order VALUES
(1,'2022-03-03',1,6,'Set Menu 1',250,2,.10),
(2,'2022-03-05',2,6,'Set Menu 3',450,3,.15),
(3,'2022-04-05',4,6,'Dinner Menu 2',635,2,.10),
(4,'2022-05-06',5,6,'Lunch Menu 1',350,2,.15)
GO

SELECT * FROM tbl_Order
GO


/* TEST (View, Trigger, Function, Transaction)*/

--Test View
SELECT * FROM Vtbl_Order
GO

--Inserting data using view
INSERT INTO Vwtbl_Booking VALUES
('2022-05-11',8,'2022-05-13','2022-05-15','Out',1)
GO

--(Viewing order Information through Vtbl_Order)
EXEC sp_helptext 'Vtbl_Order1'
GO

--Test Romm INFO using Store Procedure

EXEC spRoomAll

--TEST STORED PROCEDURE FOR QUERY  DATA For Male customer

EXEC spTblCustomers

--Create a Stored Procedure for inserting DATA
EXEC spInsertCustomers 9,'MD ASHRAFUL','SYLHET',12365222133,MALE,1997458565251,NULL
EXEC spInsertCustomers 10,'MRS JINIYA SULTANA','GAZIPUR',12365244443,FEMALE,1999458565251,NULL
EXEC spInsertCustomers 11,'MRS AFRIN JAHAN','NATORE',12365253658,FEMALE,19988565251,NULL
EXEC spInsertCustomers 12,'MRS NOURIN','DHAKA',12665222133,FEMALE,1994558565251,NULL
EXEC spInsertCustomers 13,'MD SOUROV AHMED','NORAIL',12252522133,MALE,1997452265251,NULL

--TEST Stored procedure for deleting data 
EXEC sp_deleteCustomers 'MD ASHRAFUL'
EXEC sp_deleteCustomers 'MD SOUROV AHMED'


--Test Procedure sp_InsertEmployeesWithReturn with data insert
EXEC sp_InsertEmployeesWithReturn 10,'MD. SALAM','Kitchen Helper','1995-02-10','2021-10-01',1245368885123,'Dhaka',01770020011
GO


DECLARE @count INT;

EXEC sp_InsertEmployeeWithOutPutParameter    ////////////////////////////////////////////////////////////////////
    @employeeId = 7,
    @employeeName = @count OUTPUT;

SELECT @count AS 'Number of customers';

--- test IN LINE TABLE VALUED FUNCTION
SELECT * FROM  dbo.fnSalesSummaryOfMonth(2022,03)
GO

-- TEST Multi-Statement table-valued function(More than one statement)

SELECT * FROM dbo.fnSalesDetails(2022,03)
GO

-- JOIN Query
SELECT b.bookingId,b.customerId,b.bookingDate,c.customerName,rt.roomType FROM tbl_Booking b
JOIN tbl_roomType rt ON b.roomTypeId=rt.roomTypeId
JOIN tbl_Customer c ON b.customerId=c.customerId
GO



--subquery
--01
SELECT c.customerId,c.address FROM (SELECT * FROM tbl_Customer) as c
GO

--02
SELECT customerId,customerName FROM tbl_Customer
WHERE customerId NOT IN (SELECT DISTINCT customerId FROM tbl_Order)
GO

--Correlated subquery
--01
SELECT r.roomId,r.roomNumber,r.description FROM tbl_Room r
WHERE r.roomTypeId=(SELECT MIN(rt.roomCost) FROM tbl_RoomType rt WHERE r.roomTypeId=rt.roomTypeId)
ORDER BY r.roomId
GO

--Using CASE
SELECT roomTypeId,roomType,
	CASE
		WHEN roomTypeId=1 THEN 'One Star Room'
		WHEN roomTypeId=2 THEN 'Two Star Room'
		WHEN roomTypeId=3 THEN 'Three Star Room'
		WHEN roomTypeId=4 THEN 'Four Star Room'
		ELSE 'First Class Room'
	END AS status
FROM tbl_RoomType
GO

---Merge
-- creating table for merge
CREATE TABLE Candidate
(
    id INT PRIMARY KEY IDENTITY NOT NULL,
    [name] NVARCHAR (30) NOT NULL
)
GO

CREATE TABLE Person
(
    id INT PRIMARY KEY IDENTITY NOT NULL,
    [name] NVARCHAR (30) NOT NULL,
    age INT,
   
)
GO

-- merge as student

MERGE Person AS TARGET 
USING Candidate  AS Student  
ON Student.id = TARGET.id
WHEN NOT MATCHED BY TARGET THEN 
    INSERT (id, [name])   
    VALUES (Student.id, Student.name);
GO


--Using CTE

WITH CTE_ItemCost(orderId,itemName,Total_Price)
AS
(
SELECT o.orderId, o.itemName, o.quantity * o.unitPrice AS Total_Price 
FROM tbl_Order o
)
SELECT orderId,itemName, Total_Price 
FROM CTE_ItemCost 


--**************Using(Grouping Sets,Rollup,Cube)

--***********Rollup
SELECT COALESCE(customerName,'Total Customer') AS 'Client Name',
COUNT(customerId) AS TOTAL
FROM tbl_Customer
GROUP BY ROLLUP (customerName)
GO

--****************Cube
SELECT COALESCE(customerName,'Total Customer') AS 'Client Name',
COUNT(customerId) AS TOTAL
FROM tbl_Customer
GROUP BY CUBE (customerName)
GO

--***************Grouping Sets
SELECT orderId,COALESCE(itemName,'TOTAL') AS itemName,SUM(unitPrice*quantity) FROM tbl_Order
GROUP BY GROUPING SETS(orderId,itemName,(orderId,itemName),())
GO


--************************Using Cast and Convert*************************
--********cast
SELECT CAST('07-june-2022 10:00 AM' AS DATE) AS 'date'
GO
--***********convert
DECLARE @dateTime DATETIME
SET @dateTime='07-june-2022 10:00 AM'
SELECT CONVERT(varchar,@dateTime,8) AS 'time'
GO

--Using IF ELSE
DECLARE @roomCost MONEY
SET @roomCost=3500

IF @roomCost>2500
	PRINT 'VIP Customer'
ELSE
BEGIN
	IF @roomCost>2500
	PRINT 'General Customer'
ELSE
	PRINT 'Normal Customer'
END
GO

--Using loop
DECLARE @orderId INT=10
WHILE @orderId>=1
	BEGIN
	PRINT @orderId
	IF @orderId=(5)
		BREAK
	SET @orderId=@orderId-1
	END
GO

--Using Try Catch
BEGIN TRY
	DECLARE @val INT=1
WHILE @val<=10
	BEGIN
	PRINT @val
	IF @val=(5)
		BREAK
	SET @val=@val/0
	END
END TRY
BEGIN CATCH
	PRINT 'Error Occured'
END CATCH
GO

--Using GOTO
DECLARE @order MONEY
SET @order=250

If @order>=250
	GOTO premium
If @order<250
	GOTO general
Premium:
	PRINT 'This is a Premium Customer'
RETURN
General:
	PRINT 'This is a General Customer'
RETURN
GO

--Using Waitfor
SELECT GETDATE() TODAY
Waitfor delay '00:00:05'
SELECT GETDATE() TODAY
GO

--Using Like Operator
SELECT * FROM tbl_Customer Where customerName LIKE 'A%'
SELECT * from tbl_Employee Where employeeName LIKE '%A'

--Using Between and Operator
SELECT bookingId,bookingDate FROM tbl_Booking
WHERE bookingDate Between '2022-03-03' AND '2022-06-4'
ORDER BY bookingId DESC
GO

--Using many type of Built in Function 
--01
SELECT STR(7)+STR(3) As 'value'
GO

--02
DECLARE @n INT=80
SELECT 'I GOT'+STR(@n)
GO


--03
SELECT RTRIM('Nur                              ')+' Mohammad'
GO


--04
SELECT SUBSTRING('Nur Mohammad',1,9)
GO


--05
SELECT GETDATE() 'Today'
GO

--06
SELECT YEAR(GETDATE()) 'Year'
GO

--07
SELECT MONTH(GETDATE()) 'month'
GO

--08
SELECT DAY(GETDATE()) 'Day'
GO

--09
SELECT DATEDIFF (MONTH,'19-12-1974',GETDATE())
GO

--10
SELECT DATEADD (MONTH,7,GETDATE())
GO