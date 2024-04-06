insert into Booking(RoomID, CustomerID, DateStart, PaymentStatus)
values
(1, 1, '12-12-22', 'paid')

insert into Booking(RoomID, CustomerID, DateStart, PaymentStatus)
values
(4, 3, '21-12-22', 'not paid')

insert into Booking(RoomID, CustomerID, DateStart, PaymentStatus)
values
(8, 7, '10-12-22', 'paid')

insert into Booking(RoomID, CustomerID, DateStart, DateEnd, PaymentStatus)
values
(2, 2, '13-12-22', '23-12-22 ', 'paid')

insert into Booking(RoomID, CustomerID, DateStart, DateEnd, PaymentStatus)
values
(5, 6, '24-12-22', '21-12-22 ', 'paid')


delete from Booking
DBCC CHECKIDENT('Booking', reseed, 0)

select * from Booking;


select * from ServiceOrder
select * from Service
select * from RoomFullDescription

select * from Room
insert ServiceOrder(ServiceID, BookingID, EmployeeID, Date, Notes)
values
(1, 1, 3, '13-12-22', null),
(4, 2, 6, '23-12-22', null),
(5, 2, 4, '21-12-22', 'По дороге была сделана остановка')

insert ServiceOrder(ServiceID, BookingID, EmployeeID, Date, Notes)
values
(3, 3, 7, '11-12-22', null),
(6, 3, 5, '11-12-22', null)

select * from RoomFullDescription;

declare @id int
exec @id = FindPersonByPassport '0000000000'
print @id

select * from FindByDate('12-12-22', '22-12-22')

insert into Customer(FirstName, SecondName, PhoneNumber, PassportNumber)
values
('Мария', 'Антонова', '89514507272', '765нн567890')

select * from Customer
exec ChangePhoneNumber '5647867536', '89514746554'

/* @RoomNumber int,
  @FirstName varchar(max),
  @SecondName varchar(max),
  @PhoneNumber varchar(max),
  @EmailAddress varchar(max),
  @PassportNumber varchar(max),
  @Datestart date, 
  @dateend date,
  @Paymentstatus varchar(50) */


exec InsertBookingAndCustomer 401, 'a', 'b', '89657465532', null, '1234536907', '23-12-22', null, 'paid'

select * from FreeRoomsForTodayAndTomorrow()