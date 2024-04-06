use [AdventureWorksLT]
go

/*1.1*/
declare @TableName nvarchar(100) = 'Product'
declare @TableSchema nvarchar(100) = (select distinct TABLE_SCHEMA
                    from INFORMATION_SCHEMA.COLUMNS
                    where TABLE_NAME = @TableName AND TABLE_CATALOG = DB_NAME());
declare @ParmDefinition nvarchar(500);
declare @SELECTING nvarchar(MAX) = 
N'SELECT COLUMN_NAME AS ColumnName, DATA_TYPE AS Type
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = ' + '''' + @TableName + '''' +
' AND TABLE_SCHEMA = ' + '''' + @TableSchema + '''' + 
' AND TABLE_CATALOG = DB_NAME()
AND DATA_TYPE IN (''char'', ''nchar'', ''varchar'', ''nvarchar'', ''text'', ''ntext'')'

print @SELECTING

exec(@SELECTING)

/*1.2*/
declare @TableName nvarchar(100) = 'Product'
declare @TableSchema nvarchar(100) = (select distinct TABLE_SCHEMA
                    from INFORMATION_SCHEMA.COLUMNS
                    where TABLE_NAME = @TableName AND TABLE_CATALOG = DB_NAME());
declare @Column nvarchar(max)
declare @CType nvarchar(max)
set @TableName = 'Product'
DECLARE @KeyWord nvarchar(128) = 'Bike';

declare c1 cursor local fast_forward
for
	SELECT COLUMN_NAME AS ColumnName
	FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_NAME = @TableName
	AND TABLE_SCHEMA = @TableSchema
	AND TABLE_CATALOG = DB_NAME()
	AND DATA_TYPE IN ('char', 'nchar', 'varchar', 'nvarchar', 'text', 'ntext')
open c1
while (1=1)
begin
	fetch c1 into @Column
	print @Column
	IF @@FETCH_STATUS <> 0 BREAK
	declare @FindBy nvarchar(max) = N'select ProductID, ' + @Column +  ' from '+ @TableSchema +'.' + @TableName + '  where ' + @Column + ' like ' + '''%' + @KeyWord + '%'''
	print @FindBy
	exec(@FindBy)
end
close c1
deallocate c1

/*2.1*/
use [AdventureWorksLT]
go

create procedure SalesLT.uspFindStringInTable
    @schema sysname,
    @table sysname,
    @stringToFind nvarchar(2000)
as
	declare @count INT = 0
	declare @column AS NVARCHAR(500)
	declare @finding AS NVARCHAR(500)

	declare cursor2 cursor local fast_forward
	for 
		SELECT COLUMN_NAME AS ColumnName
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = @table
		AND TABLE_SCHEMA = @schema
		AND TABLE_CATALOG = DB_NAME()
		AND DATA_TYPE IN ('char', 'nchar', 'varchar', 'nvarchar', 'text', 'ntext')
	open cursor2
	while (1 = 1)
	begin
		fetch cursor2 into @column
		if @@FETCH_STATUS <> 0 break
		set @finding = 'select * from ' + @schema + '.' + @table +
				' where '  + @column + ' like ' + '''%' + @stringToFind + '%''' 
		exec(@finding)
		set @count = @count + @@rowcount
	end
	close cursor2
	deallocate cursor2
	return @count

declare @table1 sysname = 'Product'
declare @schema1 sysname = (select distinct TABLE_SCHEMA
										from INFORMATION_SCHEMA.COLUMNS
										where TABLE_NAME = @table1 AND TABLE_CATALOG = DB_NAME());
declare @Temp INT 
exec @Temp = SalesLT.uspFindStringInTable @schema1, @table1,'Bike'
print @Temp

/*2.2*/
declare @Schema3 nvarchar(500)
declare @Table3 nvarchar(500)
declare @Search3 nvarchar(500) = 'Bike'
declare @Count3 int

declare Cursor3 cursor local fast_forward
for
	select distinct TABLE_SCHEMA, TABLE_NAME from INFORMATION_SCHEMA.COLUMNS
open Cursor3
while (1 = 1)
begin
	fetch Cursor3 into @Schema3, @Table3
	if @@FETCH_STATUS <> 0 break
	begin try
		exec @Count3 = SalesLT.uspFindStringInTable @Schema3, @Table3,@Search3 
	end try
	begin catch
		print 'Возникла ошибка!!!'
		print ERROR_MESSAGE()
	end catch
	if @Count3 <> 0
		print 'В таблице ' + @Schema3 + '.' + @Table3 + ' найдено ' + cast(@Count3 as nvarchar(500)) + ' строк.'
	if @Count3 = 0
		print 'В таблице ' + @Schema3 + '.' + @Table3 + ' не найдено совпадений'
end
close Cursor3
deallocate Cursor3