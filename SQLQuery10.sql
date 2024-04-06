use [AdventureWorksLT]
go

--1.1--

create procedure AddNewHeader (@OrderDate DATETIME, @DueDate DATETIME, @CustomerID int)
as
begin
	declare @SalesOrderID int = next value for SalesLT.SalesOrderNumber
	insert into SalesLT.SalesOrderHeader (SalesOrderID, OrderDate, DueDate, CustomerID, ShipMethod)
	values 
	(@SalesOrderID, @OrderDate, @DueDate, @CustomerID, 'CARGO TRANSPORT 5')
	print @SalesOrderID
end;

declare @date1 DATETIME = Convert(datetime, getdate());
declare @date2 DATETIME = dateadd(day, 7, getdate());
declare @cID INT= 1;

exec AddNewHeader @date1, @date2, @cID;
select * from SalesLT.SalesOrderHeader order by CustomerID;
