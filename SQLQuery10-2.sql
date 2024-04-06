use [AdventureWorksLT]
go


create procedure AddNewProduct @SalesOrderID int, @ProductID int, @Quantity int, @UnitPrice money
as
begin
	if (exists(select SalesOrderID from SalesLT.SalesOrderHeader where SalesOrderID = @SalesOrderID))
		insert into SalesLT.SalesOrderDetail(SalesOrderID, OrderQty, ProductID, UnitPrice)
		values
		(@SalesOrderID, @Quantity, @ProductID, @UnitPrice)
	else
		print 'Заказ не существует'
end;

declare @soID int = ((select max(SalesOrderID) from SalesLT.SalesOrderHeader where CustomerID = 1))
declare @pID int = 760
declare @q int = 1
declare @up money = 782.99
set @soID = 0

exec AddNewProduct @soID, @pID, @q, @up
