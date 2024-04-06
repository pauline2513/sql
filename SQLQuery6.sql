USE [AdventureWorksLT] 
GO

SELECT *
FROM SalesLT.SalesOrderHeader;

SELECT *
FROM SalesLT.Address;

--1--
SELECT ProductID, Name, ListPrice
from SalesLT.Product
where ListPrice > (select AVG(UnitPrice) from SalesLT.SalesOrderDetail)
order by ProductID;

--2--
SELECT ProductID, Name, ListPrice
from SalesLT.Product
where ListPrice >= 100 and ProductID in (select ProductID from SalesLT.SalesOrderDetail where UnitPrice < 100)
order by ProductID;

--3--
SELECT ProductID, Name, StandardCost, ListPrice,
(select AVG(UnitPrice) from SalesLT.SalesOrderDetail) as AvgSellingPrice
from SalesLT.Product
order by ProductID;

--4--
SELECT ProductID, Name, StandardCost, ListPrice,
(select AVG(UnitPrice) from SalesLT.SalesOrderDetail) as AvgSellingPrice
from SalesLT.Product
where (select AVG(UnitPrice) from SalesLT.SalesOrderDetail) < StandardCost
order by ProductID;

--1--
SELECT GCI.CustomerID, SalesOrderID, FirstName, LastName FROM SalesLT.SalesOrderHeader AS SOH
CROSS APPLY dbo.ufnGetCustomerInformation(SOH.CustomerID) GCI
ORDER BY SOH.SalesOrderID;
--2--
SELECT GCI.CustomerID, FirstName, LastName, AddressLine1, City FROM SalesLT.CustomerAddress AS SOH
CROSS APPLY dbo.ufnGetCustomerInformation(SOH.CustomerID) GCI
JOIN SalesLT.Address ON SalesLT.Address.AddressID = SOH.AddressID
ORDER BY SOH.CustomerID;

