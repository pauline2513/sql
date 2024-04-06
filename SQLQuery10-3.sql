use [AdventureWorksLT]
go

declare @avgBikesLastPrice int;
set @avgBikesLastPrice = 
(select avg(ListPrice) from SalesLT.Product 
where ProductCategoryID in 
(select ProductCategoryID from SalesLT.vGetAllCategories where ParentProductCategoryName = 'Bikes'))

print @avgBikesLastPrice;

declare @MaxPrice int 

while (@avgBikesLastPrice < 2000 OR @MaxPrice < 5000)
begin
    update SalesLT.Product 
	set ListPrice = ListPrice * 1.1 
	where ProductCategoryID IN (select ProductCategoryID 
								from SalesLT.vGetAllCategories 
								where ParentProductCategoryName LIKE 'Bikes')
    set @avgBikesLastPrice = (select avg(ListPrice) from SalesLT.Product 
							  where ProductCategoryID in 
							 (select ProductCategoryID from SalesLT.vGetAllCategories where ParentProductCategoryName = 'Bikes'))
    set @MaxPrice = (select top(1) ListPrice from SalesLT.Product as P join SalesLT.vGetAllCategories as vGAC 
                     on P.ProductCategoryID = vGAC.ProductCategoryID and vGAC.ParentProductCategoryName = 'Bikes'
                     order by ListPrice desc)
end;

print @avgBikesLastPrice
print @MaxPrice

