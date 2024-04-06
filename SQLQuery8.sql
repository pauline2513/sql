use [AdventureWorksLT]
go

--1.1--
SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
INNER JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
INNER JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
INNER JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY
Grouping sets (a.CountryRegion, (a.CountryRegion, a.StateProvince), ())
ORDER BY a.CountryRegion, a.StateProvince;

--1.2--
SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue, 
case
when GROUPING_ID(a.CountryRegion, a.StateProvince) = 0 then (a.StateProvince + ' subtotal')
when GROUPING_ID(a.CountryRegion, a.StateProvince) = 1 then (a.CountryRegion + ' subtotal')
when GROUPING_ID(a.CountryRegion, a.StateProvince) = 3 then ('total')
end as Level
FROM SalesLT.Address AS a
INNER JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
INNER JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
INNER JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY
Grouping sets (a.CountryRegion, (a.CountryRegion, a.StateProvince), ())
ORDER BY a.CountryRegion, a.StateProvince;

--1.3--
SELECT a.CountryRegion, a.StateProvince, a.City, SUM(soh.TotalDue) AS Revenue, 
case
when GROUPING_ID(a.CountryRegion, a.StateProvince, a.City) = 7 then 'total'
when GROUPING_ID(a.CountryRegion, a.StateProvince, a.City) = 3 then a.CountryRegion + ' subtotal'
when GROUPING_ID(a.CountryRegion, a.StateProvince, a.City) = 1 then a.StateProvince + ' subtotal'
when GROUPING_ID(a.CountryRegion, a.StateProvince, a.City) = 0 then a.City + ' subtotal'
end as Level
FROM SalesLT.Address AS a
INNER JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
INNER JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
INNER JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY
Grouping sets (a.CountryRegion, (a.CountryRegion, a.StateProvince), (a.CountryRegion, a.StateProvince, a.City), ())
ORDER BY a.CountryRegion, a.StateProvince, a.City;

--2.1--
select * from SalesLT.vGetAllCategories;
select CompanyName, Bikes, Accessories, Clothing
from
(select c.CompanyName as CompanyName, sum(sod.LineTotal) as Sum, v.ParentProductCategoryName as Category 
from SalesLT.Customer as c
join SalesLT.SalesOrderHeader as soh on c.CustomerID = soh.CustomerID
join SalesLT.SalesOrderDetail as sod on soh.SalesOrderID = sod.SalesOrderID
join SalesLT.Product as p on sod.ProductID = p.ProductID
join SalesLT.vGetAllCategories as v on p.ProductCategoryID = v.ProductCategoryID
group by  v.ParentProductCategoryName, c.CompanyName) 
AS sales
PIVOT (SUM(Sum) FOR Category IN([Bikes], [Accessories], [Clothing])) AS pvt