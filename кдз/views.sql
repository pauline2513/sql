create view EmployeesWithTitles
as
select FirstName, SecondName, TitleName from Employee as e
inner join EmployeeTitle as t 
on e.TitleID = t.TitleID

create view LastFiveOrders
as
select top 5 ServiceName, (c.FirstName + ' ' + c.SecondName) as Customer, Date from ServiceOrder as so
inner join Service as s on s.ServiceID = so.ServiceID
inner join Booking as b on b.BookingID = so.BookingID
inner join Customer as c on c.CustomerID = b.CustomerID
order by so.Date desc


drop view LastFiveOrders

create view RoomFullDescription
as
select r.RoomNumber, bt.TypeName as BadType, rt.TypeName as RoomType, bt.Description as BedDescription, rt.Description as RoomTypeDescription from Room as r
inner join BedType as bt on bt.BedTypeID = r.BedTypeID
inner join RoomType as rt on rt.TypeOfRoomID = r.TypeOfRoomID

drop view RoomFullDescription
