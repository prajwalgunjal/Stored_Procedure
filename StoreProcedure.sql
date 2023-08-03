create database OrderManagementSystem;
use OrderManagementSystem;
create table Customers(
	CustomerId int primary key Identity(1,1),
	FirstName varchar(50),
	LastName varchar(50),
	EmailId varchar(50) unique
)

create table Orders (
	OrderId int Primary key Identity (1,1),
	CustomerId int Foreign key references Customers(CustomerId),
	OrderDate date check (OrderDate >= GetDate()),
	OrderTotal decimal (10,2)
)
drop table Orders


select * from Customers
select * from Orders



Insert into Customers values ('Prajwal','Gunjal','Prajwal@gmail.com')
Insert into Orders values(1,'2023-07-09',600.00)

Insert into Customers values ('Prajkta','Gunjal','Prajkta@gmail.com')
Insert into Orders values(2,'2023-07-09',500.00)




CREATE PROCEDURE GetAllCustomers
AS
BEGIN 
	SELECT * FROM Customers
END


EXEC GetAllCustomers
execute GetAllCustomers
	GetAllCustomers




CREATE PROCEDURE GetOrderDetails
AS
BEGIN
	SELECT FirstName , LastName,OrderDate, OrderTotal FROM Customers As c INNER JOIN Orders AS o ON c.CustomerId = o.CustomerId
END






CREATE PROCEDURE AddOrderNewCustomer
	@FirstName VARCHAR(50),
	@LastName VARCHAR(50),
	@EmailId VARCHAR(50),
	@OrderDate DATE,
	@OrderTotal DECIMAL(10,2)
AS
BEGIN
	
	DECLARE @empId int
	
	INSERT INTO Customers VALUES(@FirstName,@LastName,@EmailId)

	SET @empId = SCOPE_IDENTITY()----- last generated ID

	INSERT INTO Orders VALUES(@empId,@OrderDate,@OrderTotal)
END

EXEC AddOrderNewCustomer @FirstName='Sarika',@LastName='Gunjal',@EmailId='Sarika@gmail.com',@OrderTotal=850.00 ,@OrderDate='2023-07-09'



-- this is wrong syntax error 
CREATE PROCEDURE AddOrderNewCustomerTransactional
	@FirstName VARCHAR(50),
	@LastName VARCHAR(50),
	@EmailId VARCHAR(50),
	@OrderDate DATE,
	@OrderTotal DECIMAL(10,2)
AS
BEGIN TRANSACTION
	BEGIN TRY
	DECLARE @empId int
	
		INSERT INTO Customers VALUES(@FirstName,@LastName,@EmailId)

		SET @empId = SCOPE_IDENTITY()----- last generated ID

		INSERT INTO Orders VALUES(@empId,@OrderDate,@OrderTotal)

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH 
		ROLLBACK TRANSACTION
	END CATCH 
END


EXEC AddOrderNewCustomerTransactional @FirstName='Suranjan',@LastName='Bhosale',@EmailId='Sarika@gmail.com',@OrderTotal=870.00 ,@OrderDate='2023-07-09'
-- this will throw error beacuse duplicae email id 

EXEC AddOrderNewCustomerTransactional @FirstName='Suranjan',@LastName='Bhosale',@EmailId='Suranjan@gmail.com',@OrderTotal=870.00 ,@OrderDate='2023-07-09'

----------------------------------------------------------------------------------------------------------

CREATE PROCEDURE AddOrderNewCustomerTransactionalNew
	@FirstName VARCHAR(50),
	@LastName VARCHAR(50),
	@EmailId VARCHAR(50),
	@OrderDate DATE,
	@OrderTotal DECIMAL(10,2)
AS
BEGIN 
	BEGIN TRANSACTION
	BEGIN TRY
	DECLARE @empId int
	
		INSERT INTO Customers VALUES(@FirstName,@LastName,@EmailId)

		SET @empId = SCOPE_IDENTITY()----- last generated ID

		INSERT INTO Orders VALUES(@empId,@OrderDate,@OrderTotal)

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH 
		ROLLBACK TRANSACTION
	END CATCH 
END

 EXEC AddOrderNewCustomerTransactionalNew @FirstName='Suhas',@LastName='Bhosale',@EmailId='Suhas@gmail.com',@OrderTotal=870.00 ,@OrderDate='2023-07-10'
 EXEC AddOrderNewCustomerTransactionalNew @FirstName='Munna',@LastName='Bhosale',@EmailId='Munna@gmail.com',@OrderTotal=7770.00 ,@OrderDate='2023-07-11'
EXEC AddOrderNewCustomerTransactionalNew @FirstName='Aruna',@LastName='Bhosale',@EmailId='Aruna@gmail.com',@OrderTotal=666.00 ,@OrderDate='2023-07-12'

 select * from Customers
select * from Orders

delete from Customers

CREATE PROCEDURE GetOrderDetails
AS
BEGIN
	SELECT FirstName , LastName,OrderDate, OrderTotal FROM Customers As c INNER JOIN Orders AS o ON c.CustomerId = o.CustomerId
END


EXEC GetOrderDetails











Transaction Management: Stored procedures can be used to group multiple SQL statements within a single transaction, 
ensuring data integrity and consistency.

When you call a stored procedure for the first time, SQL Server creates an execution plan and stores it in the cache. In the subsequent executions of 
the stored procedure, SQL Server reuses the plan to execute the stored procedure very fast with reliable performance.
If any part of the stored procedure fails, the entire transaction can be rolled back, preventing incomplete or inconsistent data changes.
Purpose: Stored procedures are designed to perform specific tasks or operations within a database

Performance: Stored procedures can improve performance by reducing network traffic.
Since the stored procedure resides on the database server, only the procedure name and input parameters 
need to be sent over the network, rather than the entire SQL logic.

Transaction Management: Stored procedures can be used to group multiple SQL statements within a single transaction, 
ensuring data integrity and consistency. If any part of the stored procedure fails, the entire transaction can be rolled back, 
preventing incomplete or inconsistent data changes.