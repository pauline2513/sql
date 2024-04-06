select * from EmployeesWithTitles

select * from LastFiveOrders

select * from RoomFullDescription

select * from FindByDate('12-12-22', '22-12-22')

select * from GetFreeRoomForPeopleAmount(3)

select * from FreeRoomsForTodayAndTomorrow()


select * from Customer

declare @id int
exec @id = FindPersonByPassport '0000000000'
print @id

exec InsertBookingAndCustomer 401, 'alica', 'Chernyshova', '89657465532', null, '1234536907', '23-12-22', null, 'paid'

exec ChangePhoneNumber '5647867536', '89514746554'


select * from Booking

insert into Booking(RoomID, CustomerID, DateStart, DateEnd, PaymentStatus)
values
(5, 6, '24-12-22', '21-12-22 ', 'paid')

insert into Booking(RoomID, CustomerID, DateStart, PaymentStatus)
values
(1, 8, '23-12-22', 'paid')

insert into Customer(FirstName, SecondName, PhoneNumber, PassportNumber)
values
('Мария', 'Антонова', '89514507272', '765нн567890')

insert into Customer(FirstName, SecondName, PhoneNumber, PassportNumber)
values
('Карина', 'Васильева', '8951ц457272', '1234567890')
