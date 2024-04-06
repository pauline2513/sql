/*триггер для проверки занятости комнаты или ее изменения*/

create trigger room_occupied
on Booking
for insert
as
declare @Free varchar(max) = (select IsFree from Room as r
inner join inserted as o on o.RoomID = r.RoomID)
if @Free = 'occupied'
begin
	raiserror ('Комната уже занята', 16, 10) 
	rollback transaction
end
else
begin
	declare @Room int = (select RoomID from inserted)
	update Room set IsFree = 'occupied' 
	where RoomID = @Room
end

drop trigger room_occupied

/*триггер для проверки дат*/
create trigger check_date
on Booking
for update, insert
as
if (update(DateEnd) or update(DateStart))
begin
	if(select DateEnd from inserted) < (select DateStart from inserted)
	begin
		raiserror ('Дата выезда раньше даты заезда', 16, 10) 
		rollback tran
	end
end

drop trigger check_date

/*Триггер на неправильный ввод паспортных данных*/
create trigger check_passport
on Customer
for update, insert
as
declare @pass_num varchar(max) = (select PassportNumber from inserted)
if (len(@pass_num) <> 10 or @pass_num like '%[a-z]%' or @pass_num like '%[а-я]%')
begin
	raiserror ('Неправильные пасспортные данные', 16, 10) 
	rollback tran
end

create trigger check_phone
on Customer
for update, insert
as
declare @phone_num varchar(max) = (select PhoneNumber from inserted)
if (len(@phone_num) <> 11 or @phone_num like '%[a-z]%' or @phone_num like '%[а-я]%')
begin
	raiserror ('Неправильный номер телефона', 16, 10) 
	rollback tran
end
drop trigger check_passport