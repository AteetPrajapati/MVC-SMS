CREATE DATABASE AP351AteetPrajapatiTest
USE AP351AteetPrajapatiTest

CREATE TABLE Customer
(
	Id INT IDENTITY (1, 1),
	Name VARCHAR(250),
	UserName VARCHAR(100),
	Password NVARCHAR(100),
	Email VARCHAR(100),
	DOB DATETIME,
	Address NVARCHAR(200),
	ContactNo VARCHAR(10)
);



CREATE TABLE Salesman
(
	Id INT IDENTITY (1, 1),
	Name VARCHAR(250),
	UserName VARCHAR(100),
	Password NVARCHAR(100),
	Email VARCHAR(100),
	DOB DATETIME,
	Address NVARCHAR(200),
	ContactNo VARCHAR(10)
);


CREATE TABLE Category
(
	Id INT IDENTITY (1, 1),
	Name VARCHAR(250)
);

CREATE TABLE Items
(
	Id INT IDENTITY (1, 1),
	Name VARCHAR(250),
	Category INT,
	Rate DECIMAL (10, 2),
	DOM DATETIME,
	DOE DATETIME
);

Create Table ModeOfPayment
(
	Id INT IDENTITY (1, 1),
	Name VARCHAR(250)
);

CREATE TABLE Orders
(
	Id INT IDENTITY (1, 1),
	OrderNo INT,
	Customer INT,
	OrderQty INT,
	Bill DECIMAL(38, 2),
	DOD DATETIME,
	Salesman INT,
	DeliveryAddress NVARCHAR(200),
	City VARCHAR(250),
	ContactNo VARCHAR(10),
	MOP INT,
	OrderStatus BIT DEFAULT 0
	---(By default 0 if I cancel then should be update to 1)
);

Create Table OrderDetails
(
	Id INT IDENTITY (1, 1),
	OrderId INT,
	ItemId INT,
	OrderQty INT,
	OrderAmount DECIMAL(38, 2)
	--(Qty * Rate)
);


--1. After Creating Table , need to update All table with Primary Key , Clustor Key  and Add Identity [5]
ALTER TABLE Customer
ADD CONSTRAINT PK_Customer PRIMARY KEY (Id);

ALTER TABLE Salesman
ADD CONSTRAINT PK_Salesman PRIMARY KEY (Id);

ALTER TABLE Category
ADD CONSTRAINT PK_Category PRIMARY KEY (Id);

ALTER TABLE Items
ADD CONSTRAINT PK_Items PRIMARY KEY (Id);
ALTER TABLE Items
ADD CONSTRAINT FK_Items FOREIGN KEY (Category) REFERENCES Category(Id);

ALTER TABLE ModeOfPayment
ADD CONSTRAINT PK_ModeOfPayment PRIMARY KEY (Id);

ALTER TABLE Orders
ADD CONSTRAINT PK_Orders PRIMARY KEY (Id),
FOREIGN KEY (Customer) REFERENCES Customer(Id);

ALTER TABLE Orders
ADD CONSTRAINT FK_OrdersModeOfPayment FOREIGN KEY (MOP) REFERENCES ModeOfPayment(Id);

ALTER TABLE OrderDetails
ADD CONSTRAINT PK_OrderDetails PRIMARY KEY (Id),
FOREIGN KEY (OrderId) REFERENCES Orders(Id),
FOREIGN KEY (ItemId) REFERENCES Items(Id);

--2. Create a Parameterized Store Procedure to Insert/Update Data in each of tables listed above. 
--	(If Primary key of that table is passed then Update else Insert) [8]
--		E.g : SP_AddEditCustomer (By using this procedure I will be able to insert or update data) condotional parameter pass in store procedure

-- For Table Customer
Go
CREATE OR ALTER PROCEDURE SP_AddEditCustomer
	@table_PK INT = NULL,
	@Name VARCHAR(250),
	@UserName VARCHAR(100),
	@Password NVARCHAR(100),
	@Email VARCHAR(100),
	@DOB DATETIME,
	@Address NVARCHAR(200),
	@ContactNo VARCHAR(10)
AS
BEGIN
	if (@table_PK IS NULL)
BEGIN
		INSERT INTO Customer
			(Name,UserName,Password,Email,DOB,Address,ContactNo)
		VALUES
			(@Name, @UserName, @Password, @Email, @DOB, @Address, @ContactNo)
	END
ELSE
BEGIN
		BEGIN TRANSACTION
		UPDATE Customer SET 
		Name = @Name,
		UserName = @UserName,
		Password=@Password,
		Email=@Email,
		DOB=@DOB,
		Address=@Address,
		ContactNo=@ContactNo
	WHERE Id = @table_PK
		COMMIT
	END
END

EXECUTE SP_AddEditCustomer null, 'Ateet', 'ARP67', 'AP123','AP@gmail.com', '2002-07-06', '142, akhndand surat', 9328409012
EXECUTE SP_AddEditCustomer null, 'Ayush', 'ARP35', 'AP345','AP35@gmail.com', '2002-03-05', '142, akhndand surat', 7383906424

EXECUTE SP_AddEditCustomer 1, 'Mahesus', 'ARP35', 'AP345','AP35@gmail.com', '2002-03-05', '142, akhndand surat', 7383906424

SELECT *
FROM Customer


-- For Salesman
Go
CREATE OR ALTER PROCEDURE SP_AddEditSalesman
	@table_PK INT = NULL,
	@Name VARCHAR(250),
	@UserName VARCHAR(100),
	@Password NVARCHAR(100),
	@Email VARCHAR(100),
	@DOB DATETIME,
	@Address NVARCHAR(200),
	@ContactNo VARCHAR(10)
AS
BEGIN
	if (@table_PK IS NULL)
BEGIN
		INSERT INTO Salesman
			(Name,UserName,Password,Email,DOB,Address,ContactNo)
		VALUES
			(@Name, @UserName, @Password, @Email, @DOB, @Address, @ContactNo)
	END
ELSE
BEGIN
		BEGIN TRANSACTION
		UPDATE Salesman SET 
		Name = @Name,
		UserName = @UserName,
		Password=@Password,
		Email=@Email,
		DOB=@DOB,
		Address=@Address,
		ContactNo=@ContactNo
	WHERE Id = @table_PK
		COMMIT
	END
END

EXECUTE SP_AddEditSalesman null, 'APElectronic', 'electronic', 'electric123','electronic@gmail.com', '2012-07-06', 'Dabholi surat', 1234567897
EXECUTE SP_AddEditSalesman 1, 'APElectronic', 'electronic', 'electric123','electronic@gmail.com', '2012-07-06', 'Dabholi surat', 1234567897

SELECT *
FROM Salesman

--- For Category
Go
CREATE PROCEDURE SP_AddEditCategory
	@table_PK INT = NULL,
	@Name VARCHAR(250)
AS
BEGIN
	if (@table_PK IS NULL)
BEGIN
		INSERT INTO Category
			(Name)
		VALUES
			(@Name)
	END
ELSE
BEGIN
		BEGIN TRANSACTION
		UPDATE Category SET 
		Name = @Name
	WHERE Id = @table_PK
		COMMIT
	END
END


EXECUTE SP_AddEditCategory null , 'Electronic'
EXECUTE SP_AddEditCategory 1 , 'Electronic Expo'

SELECT *
FROM Category


-- For Items
Go
CREATE OR ALTER PROCEDURE SP_AddEditItems
	@table_PK INT = NULL,
	@Name VARCHAR(250),
	@Category INT,
	@Rate DECIMAL (10, 2),
	@DOM DATETIME,
	@DOE DATETIME
AS
BEGIN
	if (@table_PK IS NULL)
BEGIN
		INSERT INTO Items
			(Name,Category,Rate,DOM,DOE)
		VALUES
			(@Name, @Category, @Rate, @DOM, @DOE)
	END
ELSE
BEGIN
		BEGIN TRANSACTION
		UPDATE Items SET 
		Name=@Name,
		Category = @Category,
		Rate=@Rate,
		DOM=@DOM,
		DOE=@DOE
	WHERE Id = @table_PK
		COMMIT
	END
END

EXECUTE SP_AddEditItems null , 'Keyboard', 1, 4.5, '2019-12-07', '2080-01-01'
EXECUTE SP_AddEditItems 1 , 'Phone', 1, 4.5, '2019-12-07', '2080-01-01'

SELECT *
FROM Items

--- For ModeOfPayment
Go
CREATE PROCEDURE SP_AddEditModeOfPayment
	@table_PK INT = NULL,
	@Name VARCHAR(250)
AS
BEGIN
	if (@table_PK IS NULL)
BEGIN
		INSERT INTO ModeOfPayment
			(Name)
		VALUES
			(@Name)
	END
ELSE
BEGIN
		BEGIN TRANSACTION
		UPDATE ModeOfPayment SET 
		Name = @Name
	WHERE Id = @table_PK
		COMMIT
	END
END


EXECUTE SP_AddEditModeOfPayment null, 'COD'
EXECUTE SP_AddEditModeOfPayment 1, 'Cash On Delivery'

SELECT *
FROM ModeOfPayment


--- For Orders

Go
CREATE OR ALTER PROCEDURE SP_AddEditOrders
	@table_PK INT = NULL,
	@OrderNo INT,
	@Customer INT,
	@OrderQty INT,
	@Bill DECIMAL(38, 2),
	@DOD DATETIME,
	@Salesman INT,
	@DeliveryAddress NVARCHAR(200),
	@City VARCHAR(250),
	@ContactNo VARCHAR(10),
	@MOP INT,
	@OrderStatus BIT = 0
AS
BEGIN
	if (@table_PK IS NULL)
BEGIN
		INSERT INTO Orders
			(OrderNo,Customer,OrderQty,Bill,DOD,Salesman,DeliveryAddress ,City,ContactNo,MOP)
		VALUES
			(@OrderNo, @Customer, @OrderQty, @Bill, @DOD, @Salesman, @DeliveryAddress, @City, @ContactNo, @MOP)
	END
ELSE
BEGIN
		BEGIN TRANSACTION
		UPDATE Orders SET 
		OrderNo=@OrderNo,
		Customer=@Customer,
		OrderQty=@OrderQty,
		Bill=@Bill,
		DOD=@DOD,
		Salesman=@Salesman,
		DeliveryAddress=@DeliveryAddress,
		City=@City,
		ContactNo=@ContactNo,
		MOP=@MOP,
		OrderStatus=@OrderStatus
	WHERE Id = @table_PK
		COMMIT
	END
END

EXECUTE SP_AddEditOrders null, 123 , 1, 2, 299 , '2022-12-15', 1, '142 AkhandSociety', 'Surat', '9328409012', 1, 0
EXECUTE SP_AddEditOrders 3, 123 , 1, 2, 399 , '2022-12-15', 1, '142 AkhandSociety', 'Surat', '9328409012', 1,0

SELECT *
FROM Orders


-- For OrderDetails

Go
CREATE OR ALTER PROCEDURE SP_AddEditOrderDetails
	@table_PK INT = NULL,
	@OrderId INT,
	@ItemId INT
AS
BEGIN
	DECLARE @OrderQty INT = 0
	DECLARE @OrderAmount DECIMAL(38, 2) = 0

	SET @OrderQty = (SELECT OrderQty
	FROM Orders
	WHERE Id = @OrderId)
	SET @OrderAmount = @OrderQty * (SELECT Rate
	FROM Items
	WHERE Id = @ItemId)
	if (@table_PK IS NULL)
BEGIN
		INSERT INTO OrderDetails
			(OrderId,ItemId,OrderQty,OrderAmount)
		VALUES
			(@OrderId, @ItemId, @OrderQty, @OrderAmount)
	END
ELSE
BEGIN
		BEGIN TRANSACTION
		UPDATE OrderDetails SET 
		OrderId=@OrderId,
		ItemId=@ItemId,
		OrderQty=@OrderQty,
		OrderAmount=@OrderAmount
	WHERE Id = @table_PK
		COMMIT
	END
END

EXECUTE SP_AddEditOrderDetails 1,2,1

SELECT *
FROM OrderDetails

--3. Create a Parameterized Store Procedure to retrive all the OrderDetails as per Customer 
--(If CustomerId not passed then retrive all the orders) ( Make sure to Add Everything in Single Procedure) [8]
--	Information I want : 
--		--CustomerName
--		--ItemName
--		--Item Rate
--		--Qty
--		--OrderAmount (Qty * ItemRate)
Go
CREATE OR ALTER PROCEDURE SP_GetOrderDetails
	@CustomerId INT = NULL
AS
BEGIN
	if (@CustomerId IS NULL)
BEGIN
		SELECT C.Name, I.Name, I.Rate, OD.OrderQty, OD.OrderAmount
		FROM OrderDetails OD
			JOIN Orders O ON OD.OrderId  = O.Id
			JOIN Customer C ON O.Customer = C.ID
			JOIN Items I ON I.Id = OD.ItemId

	END
ELSE
BEGIN
		SELECT C.Name, I.Name, I.Rate, OD.OrderQty, OD.OrderAmount
		FROM OrderDetails OD
			JOIN Orders O ON OD.OrderId  = O.Id
			JOIN Customer C ON O.Customer = C.ID
			JOIN Items I ON I.Id = OD.ItemId
		WHERE C.Id = @CustomerId
	END
END

EXECUTE SP_GetOrderDetails null


--4. Create a User Defined Function that will retrive TotalOrderAmount from the OrderDetails Table as per Customer. [8]
--	I just want total amount as per customerid I Passed.

CREATE OR ALTER FUNCTION TotalOrderAmount (
	@CustomerId INT
)
RETURNS DECIMAL(10, 2)
AS 
BEGIN
	RETURN (SELECT SUM(O.Bill) as TotalOrderAmount
	FROM OrderDetails OD
		JOIN Orders O ON O.Id = OD.OrderId
	WHERE O.Customer = @CustomerId)
END

SELECT dbo.TotalOrderAmount(1);


--5. Create a prameterized Store Procedure to retrive all the Order Information as per Customer. 
--(If CustomerId not passed then retrive all the orders) [8]
--	Information I want : 
--		--CustomerName
--		--OrderNo
--		--OrderQty (Total Qty of all the Items) (Using Function)
--		--OrderAmount (Total Amount of Order) (Using Function)
--		--SalesmanName
--		--Address
--		--City
--		--ContactNo
--		--MOP Name
--		--DOD

Go
CREATE OR ALTER PROCEDURE SP_GetOrderDetails
	@CustomerId INT = NULL
AS
BEGIN
	if (@CustomerId IS NULL)
BEGIN
		SELECT C.Name, O.OrderNo, OD.OrderQty, OD.OrderAmount, S.Name, O.DeliveryAddress, O.City, O.ContactNo, O.MOP, O.DOD
		FROM OrderDetails OD
			JOIN Orders O ON OD.OrderId  = O.Id
			JOIN Customer C ON O.Customer = C.ID
			JOIN Items I ON I.Id = OD.ItemId
			JOIN Salesman S ON S.Id = O.Salesman

	END
ELSE
BEGIN
		SELECT C.Name, O.OrderNo, OD.OrderQty, OD.OrderAmount, S.Name, O.DeliveryAddress, O.City, O.ContactNo, O.MOP, O.DOD
		FROM OrderDetails OD
			JOIN Orders O ON OD.OrderId  = O.Id
			JOIN Customer C ON O.Customer = C.ID
			JOIN Items I ON I.Id = OD.ItemId
			JOIN Salesman S ON S.Id = O.Salesman
		WHERE C.Id = @CustomerId
	END
END

EXECUTE SP_GetOrderDetails 1



--6. Create a Parameterized Store Procedure to Cancel Order as per OrderNo (If I pass wrong orderno then message should be there) [8]

Go
CREATE OR ALTER PROCEDURE SP_CancelOrder
	@orderno INT = null
AS
BEGIN
	if (@orderno IS NULL)
BEGIN
		PRINT 'PLEASE PROVIDE ORDER NO.'
	END
ELSE
BEGIN
		DECLARE @Oflag INT = 0
		SET @Oflag = (SELECT O.OrderNo
		FROM Orders O
		WHERE O.OrderNo = @orderno)
		IF (@Oflag = 0)
	BEGIN
			PRINT 'PLEASE PROVIDE VALID ORDER NO.'
		END
	ELSE
	BEGIN
			UPDATE Orders SET OrderStatus=1 WHERE OrderNo = @orderno
		END
	END
END

EXECUTE SP_CancelOrder 123

--7. Create a Parameterized Store Procedure for Login as per Customer/Salesman EmailId and Password.  [10]
--	(If credentials matched then show "Login Successfull" then "Invalid User Input" , 
--	If EmailId  is not having in the Table then Create Emaild with Password( Random) ).

Go
CREATE OR ALTER PROCEDURE SP_Login
	@email VARCHAR(250) = null,
	@psw NVARCHAR(100) = null,
	@type VARCHAR(100) = null
AS
BEGIN
	DECLARE @Password VARCHAR(20) = (SELECT substring(replace(convert(varchar(100), NEWID()), '-', ''), 1, 10) AS Rand_Value)
	if (@type =  'Customer')
		BEGIN
		DECLARE @loginFlag INT = 0
		DECLARE @loginEmailCheck INT = 0
		SET @loginEmailCheck = (SELECT Id
		FROM Customer
		WHERE Email = @email)
		IF (@loginEmailCheck > 0)
				BEGIN
			SET @loginFlag = (SELECT Id
			FROM Customer
			WHERE Email = @email AND Password = @psw)
			IF (@loginFlag > 0)
						BEGIN
				PRINT 'Login Successfull Customer'
			END
						ELSE
						BEGIN
				PRINT 'Invalid User Credentials.'
			END
		END
			ELSE
				BEGIN
			PRINT 'User Not Exists'
			PRINT 'Creating New User...'
			EXECUTE SP_AddEditCustomer null, 'Ateet', 'ARP67', @Password,@email, '2002-07-06', '142, akhndand surat', 9328409012
			PRINT 'New User Email Is : ' + @email
			PRINT 'New User Password Is : '  + @Password
		END
	END
	ELSE
		BEGIN
		DECLARE @loginFlagSales INT = 0
		DECLARE @loginSalesEmailCheck INT = (SELECT Id
		FROM Salesman
		WHERE Email = @email)
		IF (@loginSalesEmailCheck > 0)
				BEGIN
			SET @loginFlagSales = (SELECT Id
			FROM Salesman
			WHERE Email = @email AND Password = @psw)
			IF (@loginFlagSales > 0)
						BEGIN
				PRINT 'Login Successfull Salesman'
			END
						ELSE
						BEGIN
				PRINT 'Invalid User Credentials.'
			END
		END
			ELSE
				BEGIN
			PRINT 'User Not Exists'
			PRINT 'Creating New User...'
			EXECUTE SP_AddEditSalesman null, 'APElectronic', 'electronic', @Password,@email, '2012-07-06', 'Dabholi surat', 1234567897
			PRINT 'New User Email Is : ' + @email
			PRINT 'New User Password Is : '  + @Password
		END
	END
END

EXECUTE SP_Login 'electronic@gmail.com' ,'electric123', 'Customer'

--8. Create a Parameterized Store Procedure for Delete Customer from the UserName	[5]
--	--All the orders linked to that customer should also be deleted.
Go
CREATE OR ALTER PROCEDURE SP_DeleteCustomer
	@cusId INT = null
AS
BEGIN
	if (@cusId IS NULL)
BEGIN
		PRINT 'PLEASE PROVIDE Customer ID.'
	END
ELSE
BEGIN
		DELETE Customer WHERE Id = @cusId
		DELETE Orders WHERE Customer = @cusId
	END
END

EXEC SP_DeleteCustomer 1

--9. Create a OrderDetails using OrderId of Order in a Single Store Procedure. [10]
Go
CREATE OR ALTER PROCEDURE SP_CreateOrderDetails
	@orderID INT = null
AS
BEGIN
	if (@orderID IS NULL)
BEGIN
		PRINT 'PLEASE PROVIDE Order ID.'
	END
ELSE
BEGIN
		DECLARE @itemID INT
		SET @itemID = (SELECT TOP 1
			Id
		FROM Items
		ORDER BY NEWID())
		EXECUTE SP_AddEditOrderDetails null,@orderID,@itemID
	END
END

EXEC SP_CreateOrderDetails 2


--10. Every Data suppose to be Dynamic (no any Hard Coded) [Addition 25 points] 
--[ Example : Name would be Dynamic , amount would be Dyanmic , Date Would be Dynamic , OrderNo  would be Dynamic , etc... ]

GO
CREATE OR ALTER PROCEDURE SP_DYNAMIC
	@TABLENAME VARCHAR(100) = NULL
AS
BEGIN
	IF (@TABLENAME IS NULL)
BEGIN
		PRINT 'PLEASE PROVIDE TABLE NAME.'
	END
ELSE
BEGIN
		DECLARE @QUERY NVARCHAR(MAX);
		DECLARE @PASWORD NVARCHAR(MAX);
		DECLARE @ORDERNO NVARCHAR(MAX);
		DECLARE @ALPHABET VARCHAR(36) = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
		DECLARE @NAME VARCHAR(100);
		DECLARE @EMAIL VARCHAR(100);
		DECLARE @DOB DATE;
		DECLARE @CONTACTNO NVARCHAR(MAX)
		SET @PASWORD = (SELECT LEFT( NEWID(), 5 ))
		SET @ORDERNO = (SELECT LEFT( NEWID(), 5 ))
		SET @NAME = (SELECT
			SUBSTRING(@ALPHABET, CONVERT(INT, RAND()*36 + 4), 1) +
			SUBSTRING(@ALPHABET, CONVERT(INT, RAND()*36 + 4), 1) +
			SUBSTRING(@ALPHABET, CONVERT(INT, RAND()*36 + 4), 1) +
			SUBSTRING(@ALPHABET, CONVERT(INT, RAND()*36 + 4), 1) +
			SUBSTRING(@ALPHABET, CONVERT(INT, RAND()*36 + 4), 1))
		SET @EMAIL = @NAME + '@gmail.com'
		SET @DOB = (SELECT DATEADD(DAY, -(ABS(CHECKSUM(NEWID()) % 36500 )), GETDATE()))
		SET @CONTACTNO = (SELECT ABS(CHECKSUM(NEWID())))

		SELECT @QUERY = CASE
                        WHEN (@TABLENAME = 'Customer' OR @TABLENAME = 'Salesman') 
						THEN 'EXECUTE SP_ADDEDIT' + @TABLENAME + ' NULL, "' + @NAME + '","' + @ORDERNO + '","' + @PASWORD + '","'+ @EMAIL + '","' + CONVERT(VARCHAR(25), @DOB, 120)  + '","'  + '142, akhndand surat' + '","' + @CONTACTNO + '"'
                        WHEN (@TABLENAME = 'Category' OR @TABLENAME = 'ModeOfPayment')
						THEN 'EXECUTE SP_ADDEDIT' + @TABLENAME + ' NULL, "' + @NAME + '"'
                     END
		EXEC SP_EXECUTESQL @QUERY
	END
END

EXEC SP_Dynamic 'Customer'
EXEC SP_Dynamic 'Salesman'
EXEC SP_Dynamic 'Category'
EXEC SP_Dynamic 'ModeOfPayment'

DECLARE @tmp CHAR(1) = CHAR(CAST(RAND()*26 AS int)+97);
SELECT @tmp;


SELECT *,
CASE 
WHEN Id % 2 = 0 THEN 'ODD'
ELSE 'EVEN'
END AS 'TYPE'
FROM OrderDetails

SELECT ABS(RAND())
SELECT *
FROM Items
SELECT *
FROM Orders
SELECT *
FROM Customer
SELECT *
FROM Salesman
SELECT *
FROM Category

GO
CREATE OR ALTER FUNCTION RETRIVETOTALORDERAMOUNT (
@cusTID INT
)
RETURNS DECIMAL(38,2)
AS
BEGIN
	RETURN (SELECT SUM(Bill) FROM OrderDetails OD 
	JOIN Orders O ON O.Id = OD.OrderId
	JOIN Customer C ON C.Id = O.Customer
	WHERE C.Id = @cusTID)
END

SELECT dbo.RETRIVETOTALORDERAMOUNT(1)


GO
CREATE OR ALTER FUNCTION splitIT(
@string VARCHAR(MAX),
@delimeter VARCHAR(MAX)
)
RETURNS @values TABLE (
id INT PRIMARY KEY IDENTITY(1,1),
val VARCHAR(MAX)
)
AS
BEGIN
 WHILE (CHARINDEX(@delimeter ,@string))  > 0
	BEGIN
		INSERT INTO @values VALUES ((LEFT(@string,(CHARINDEX(@delimeter ,@string)))))
		SET @string = (RIGHT(@string, LEN(@string) - (CHARINDEX(@delimeter ,@string))))
	END
 RETURN
END

SELECT * FROM dbo.splitIT('assddsdsddsdd' ,'d')

SELECT * FROM dbo.splitIT('assddsdsdcfdfsgfgfgdsddgfdsggfdddsdd' ,'')

SELECT ROUND(RAND()*100, 0)


GO
CREATE OR ALTER PROCEDURE allTables
@tbname VARCHAR(MAX)
AS
BEGIN
 DECLARE @DynamicSQL VARCHAR(MAX) = 'SELECT * FROM ' + @tbname
EXEC (@DynamicSQL)
END

EXEC ALLTABLES 'CUSTOMER'

GO
CREATE OR ALTER PROCEDURE finalProc
AS
BEGIN
DECLARE @Counter INT 
SET @Counter = 1
WHILE ( @Counter <= (SELECT COUNT(*) FROM (SELECT 'EXEC ALLTABLES ' + name STUFF FROM sys.tables) as T))
BEGIN
	DECLARE @qry NVARCHAR(MAX)
    PRINT 'The counter value is = ' + CONVERT(VARCHAR,@Counter)
	SET @qry = (SELECT STUFF FROM (
	SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS number, 'EXEC ALLTABLES ' + name STUFF FROM sys.tables
	) as innerTable 
	WHERE number = @Counter)
	PRINT @qry
	EXECUTE sp_executesql @qry
    SET @Counter  = @Counter  + 1
END
END

EXECUTE finalProc



SELECT * ,'Customer' as type FROM Customer
UNION
SELECT * ,'Salesman' as type FROM Salesman

SELECT USER_NAME();

SELECT MONTH(GETDATE())