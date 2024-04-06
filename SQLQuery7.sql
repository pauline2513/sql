use [AdventureWorksLT]
go

--1.1--
select *
from SalesLT.Product
ORDER BY ProductModelID;

select ProductID, p.Name AS ProductName, pd.Name AS ModelName, pd.Summary
FROM SalesLT.Product AS p
LEFT JOIN SalesLT.vProductModelCatalogDescription AS pd 
on pd.ProductModelID = p.ProductModelID
ORDER BY ProductID;

--1.2--
DECLARE @Colors AS TABLE (Color varchar(15));

INSERT INTO @Colors
SELECT DISTINCT Color FROM SalesLT.Product;

--select *
--from SalesLT.Product;

select ProductID, Name AS ProductName, p.Color
from SalesLT.Product AS p
where Color in (select * from @Colors);

--1.3--

CREATE TABLE #Size
(Size nvarchar(15));

INSERT INTO #Size
SELECT DISTINCT Size FROM SalesLT.Product;

SELECT ProductID, Name AS ProductName, Size
from SalesLT.Product
where Size IN (select * from #Size)
order by Size DESC;

--1.4--
select ProductID, Name AS ProductName, GAC.ParentProductCategoryName AS ParentCategory, GAC.ProductCategoryName AS Category
from SalesLT.Product AS p
join dbo.ufnGetAllCategories() AS GAC on p.ProductCategoryID = GAC.ProductCategoryID;


--2.1--
select CompanyContact, sum(TotalDue) as Revenue from
(select (CompanyName + ' ('+ FirstName + ' ' + LastName + ')') as CompanyContact, TotalDue from SalesLT.Customer as cus
join SalesLT.SalesOrderHeader as soh
on cus.CustomerID = soh.CustomerID) as cn
group by CompanyContact
order by CompanyContact;



select CompanyName + ' ('+ FirstName + ' ' + LastName + ')' as CompanyContact, sum(TotalDue) as Revenue
from SalesLT.Customer as cus
join SalesLT.SalesOrderHeader as soh
on cus.CustomerID = soh.CustomerID
group by CompanyContact
order by CompanyContact;



--2.2--

with Client (CompanyContact, TotalDue)
as
(select (CompanyName + ' ('+ FirstName + ' ' + LastName + ')') as CompanyContact, soh.TotalDue from SalesLT.Customer as cus
join SalesLT.SalesOrderHeader as soh
on cus.CustomerID = soh.CustomerID)

select CompanyContact, sum(TotalDue) as Revenue from Client
group by CompanyContact
order by CompanyContact;
