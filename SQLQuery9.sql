use [AdventureWorksLT]
go

select * from SalesLT.Product
order by ProductID;

--1.1--
insert into SalesLT.Product (Name, ProductNumber, StandardCost, ListPrice, ProductCategoryID, SellStartDate)
values
('LED Lights', 'LT-L123', 2.56, 12.99, 37, GETDATE());

select ProductID from SalesLT.Product order by ProductID DESC;
select IDENT_CURRENT('SalesLT.Product');


select * from SalesLT.Product where Name = 'LED Lights';

--1.2--
select * from SalesLT.ProductCategory;

insert into SalesLT.ProductCategory (ParentProductCategoryID, Name)
values 
(4, 'Bells and Horns')

select IDENT_CURRENT('SalesLT.ProductCategory');

insert into SalesLT.Product (Name, ProductNumber, StandardCost, ListPrice, ProductCategoryID, SellStartDate)
values
('Bicycle Bell', 'BB-RING', 2.47, 4.99, IDENT_CURRENT('SalesLT.ProductCategory'), GETDATE()),
('Bicycle Horn', 'BB-PARP', 1.29, 3.75, IDENT_CURRENT('SalesLT.ProductCategory'), GETDATE())

select p.Name, p.ProductNumber, p.StandardCost, p.ListPrice, p.ProductCategoryID, p.SellStartDate, c.ParentProductCategoryID, c.Name
from SalesLT.Product as p
inner join SalesLT.ProductCategory as c on c.ProductCategoryID = p.ProductCategoryID
where c.Name = 'Bells and Horns';

--2.1--
update SalesLT.Product
set ListPrice = ListPrice * 1.1
from SalesLT.ProductCategory AS c  
where c.ProductCategoryID = SalesLT.Product.ProductCategoryID and c.Name = 'Bells and Horns'; 

--2.2--
update SalesLT.Product
set DiscontinuedDate = GETDATE()
where ProductCategoryID = 37 and ProductNumber != 'LT-L123';

select * from SalesLT.Product order by ProductCategoryID;

--3.1--

select * from SalesLT.Product order by ProductID;


delete from SalesLT.Product
where ProductCategoryID =
(select ProductCategoryID from SalesLT.ProductCategory where Name = 'Bells and Horns');

delete from SalesLT.ProductCategory
where ProductCategoryID =
(select ProductCategoryID from SalesLT.ProductCategory where Name = 'Bells and Horns');