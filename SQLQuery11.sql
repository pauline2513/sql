use [AdventureWorksLT]
go 

/* 1.1 */
declare @SalesOrderID int;  
set @SalesOrderID = 1000000000;
declare @ErrorMessage varchar(300) = CONCAT('the order #', @SalesOrderID, ' does not exist')  
if exists(select SalesOrderID from SalesLT.SalesOrderDetail where SalesOrderID = @SalesOrderID)
	begin
		delete from SalesLT.SalesOrderDetail where SalesOrderID = @SalesOrderID 
		delete from SalesLT.SalesOrderHeader where SalesOrderID = @SalesOrderID
	end
else
	throw 50001, @ErrorMessage, 0;

/* 1.2 */
declare @SalesOrderID int; 
set @SalesOrderID = 1000000000;
declare @ErrorMessage varchar(300) = CONCAT('the order #', @SalesOrderID, ' does not exist')  
begin try
	if exists(select SalesOrderID from SalesLT.SalesOrderDetail where SalesOrderID = @SalesOrderID)
		begin
			delete from SalesLT.SalesOrderDetail where SalesOrderID = @SalesOrderID 
			delete from SalesLT.SalesOrderHeader where SalesOrderID = @SalesOrderID
		end
	else
		throw 50001, @ErrorMessage, 0;
end try
begin catch
	print error_message()
end catch;

/*2.1*/
begin try
	begin transaction
		declare @SalesOrderID int;  
		set @SalesOrderID = 1000000000;
		declare @ErrorMessage varchar(300) = CONCAT('the order #', @SalesOrderID, ' does not exist')  
		if exists(select SalesOrderID from SalesLT.SalesOrderDetail where SalesOrderID = @SalesOrderID)
		begin
			delete from SalesLT.SalesOrderDetail where SalesOrderID = @SalesOrderID 
			delete from SalesLT.SalesOrderHeader where SalesOrderID = @SalesOrderID
		end
		else
		throw 50001, @ErrorMessage, 0;
		commit transaction
end try
begin catch
	if @@TRANCOUNT != 0
	begin
		rollback transaction
		print error_message()
	end
end catch;