
/*ѕроцедура ищет айди человека в таблице клиентов по номеру пасспорта и возвращает 0, 
если человека с таким паспортом в базе данных нет и айди, если есть.
ћожет понадобитьс€ при добавлении записи о клиенте в бд и просто найти информацию о человеке*/

create procedure FindPersonByPassport
	@PassportNumber varchar(10)
as
declare @id int
declare @passport varchar(10)
declare @found int = 0
declare c1 cursor local fast_forward
for
select CustomerID, PassportNumber from Customer
open c1
while(1=1)
begin
	fetch c1 into @id, @passport
	if @@FETCH_STATUS <> 0 break
	if (@passport = @PassportNumber)
	begin
		set @found = 1
		break
	end
end
close c1
deallocate c1
if (@found = 1)
return @id
else
return 0

drop procedure FindPerson


create procedure InsertBookingAndCustomer
  @RoomNumber int,
  @FirstName varchar(max),
  @SecondName varchar(max),
  @PhoneNumber varchar(11),
  @EmailAddress varchar(max),
  @PassportNumber varchar(10),
  @Datestart date, 
  @dateend date,
  @Paymentstatus varchar(50)
as
declare @RoomID int = (select RoomID from Room where RoomNumber = @RoomNumber)
declare @Customerid int
exec @Customerid = FindPersonByPassport @PassportNumber
if @Customerid = 0
	begin try
		begin tran
		insert into Customer (FirstName, SecondName, PhoneNumber, EmailAddress, PassportNumber)
		values
		(@FirstName, @SecondName, @PhoneNumber, @EmailAddress, @PassportNumber)
		exec @Customerid = FindPersonByPassport @PassportNumber
		insert into Booking(RoomID, CustomerID, DateStart, DateEnd, PaymentStatus)
		values
		(@RoomID, @Customerid, @Datestart, @dateend, @Paymentstatus)
		commit transaction
	end try
	begin catch
		if @@TRANCOUNT != 0
		begin
			rollback transaction
			print error_message()
		end
	end catch;
else
begin
begin try
	insert into Booking(RoomID, CustomerID, DateStart, DateEnd, PaymentStatus)
		values
		(@RoomID, @Customerid, @Datestart, @dateend, @Paymentstatus)
end try
begin catch
	print error_message()
end catch
end

drop procedure InsertBookingAndCustomer

create procedure ChangePhoneNumber @CustomerPassportNumber varchar(max), @NewPhoneNumber varchar(max)
as
declare @id int
exec @id = FindPersonByPassport @CustomerPassportNumber
if (len(@NewPhoneNumber) = 11 and @NewPhoneNumber not like '%[a-z]%' and @NewPhoneNumber not like '%[а-€]%')
begin
	update Customer
	set PhoneNumber = @NewPhoneNumber
	where CustomerID = @id
end
else
	raiserror ('Error during update', 10, 16)



drop procedure ChangePhoneNumber