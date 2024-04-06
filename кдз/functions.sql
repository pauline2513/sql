create function FindByDate(@StartDate date, @EndDate date)
returns @Table table (FirstName varchar(max), SecondName varchar(max), DateStart date, DateEnd date)
as
begin
insert into @Table 
select FirstName, SecondName, b.DateStart, b.DateEnd from Customer as c 
inner join Booking as b on b.CustomerID = c.CustomerID 
where (b.DateStart >= @StartDate and b.DateStart <= @EndDate) or (b.DateStart <= @StartDate and b.DateEnd >= @StartDate) or (b.DateStart >= @StartDate and b.DateEnd <= @EndDate)
return
end

drop function GetFreeRoomForPeopleAmount
/**/
create function GetFreeRoomForPeopleAmount(@Amount int)
returns @Table table (RoomNumber int, BedType varchar(max))
as
begin
if (@Amount = 1)
begin
	insert into @Table
	select r.RoomNumber, b.TypeName from Room as r
	inner join BedType as b on r.BedTypeID = b.BedTypeID
	where b.TypeName = 'Single Bed' and r.IsFree = 'free'
end
else if (@Amount = 2)
begin
	insert into @Table
	select r.RoomNumber, b.TypeName from Room as r
	inner join BedType b on r.BedTypeID = b.BedTypeID
	where b.TypeName in ('Double Bed', 'Queensize bed', 'Kingsize Bed', 'Twin Beds') and r.IsFree = 'free'
end
else if (@Amount = 3)
begin
	insert into @Table
	select r.RoomNumber, b.TypeName from Room as r
	inner join BedType b on r.BedTypeID = b.BedTypeID
	where b.TypeName in ('Three Single', 'Double + Single') and r.IsFree = 'free'
end
return
end


create function FreeRoomsForTodayAndTomorrow()
returns @Table table (RoomNumber int, BedType varchar(max), RoomType varchar(max))
as
begin
insert into @Table 
select r.RoomNumber, bt.TypeName, rt.TypeName from Room as r
inner join BedType as bt on bt.BedTypeID = r.BedTypeID
inner join RoomType as rt on rt.TypeOfRoomID = r.TypeOfRoomID
inner join Booking as b on b.RoomID = r.RoomID
where b.DateEnd = cast(GETDATE() as date) or b.DateEnd = (DATEADD(day, 1, cast(GETDATE() as date)))
return
end
