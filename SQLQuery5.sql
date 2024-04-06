USE [AdventureWorksLT]
GO


SELECT *
FROM SalesLT.Product;


--1--
SELECT ProductID, UPPER(Name) AS ProductName, ROUND(Weight, -1) AS ApproxWeight
FROM SalesLT.Product;

--2--
SELECT ProductID, UPPER(Name) AS ProductName, ROUND(Weight, -1) AS ApproxWeight, YEAR(SellStartDate) AS SellStartYear, DATENAME(MONTH, SellStartDate) AS SellStartMonth
FROM SalesLT.Product;

--3--
SELECT ProductID, SUBSTRING(ProductNumber, 1, 2) AS ProductType, UPPER(Name) AS ProductName, ROUND(Weight, -1) AS ApproxWeight, YEAR(SellStartDate) AS SellStartYear, DATENAME(MONTH, SellStartDate) AS SellStartMonth
FROM SalesLT.Product;

--4--
SELECT ProductID, SUBSTRING(ProductNumber, 1, 2) AS ProductType, UPPER(Name) AS ProductName, ROUND(Weight, -1) AS ApproxWeight, YEAR(SellStartDate) AS SellStartYear, DATENAME(MONTH, SellStartDate) AS SellStartMonth, Size
FROM SalesLT.Product
WHERE ISNUMERIC(Size) = 1;

---1---
SELECT *
FROM SalesLT.Customer;

SELECT CompanyName, TotalDue AS Revenue, RANK () OVER (ORDER BY TotalDue DESC) AS RankByRevenue
FROM SalesLT.Customer
INNER JOIN SalesLT.SalesOrderHeader
ON SalesLT.Customer.CustomerID = SalesLT.SalesOrderHeader.CustomerID;

--1--
SELECT *
FROM SalesLT.SalesOrderDetail;

SELECT *
FROM SalesLT.Product;

SELECT Name, SUM(LineTotal) AS TotalRevenue
FROM SalesLT.Product
INNER JOIN SalesLT.SalesOrderDetail
ON SalesLT.Product.ProductID = SalesLT.SalesOrderDetail.ProductID
GROUP BY Name
ORDER BY TotalRevenue DESC;

--2--
SELECT Name, SUM(LineTotal) AS TotalRevenue
FROM SalesLT.Product
INNER JOIN SalesLT.SalesOrderDetail
ON SalesLT.Product.ProductID = SalesLT.SalesOrderDetail.ProductID
WHERE LineTotal > 1000
GROUP BY Name
ORDER BY TotalRevenue DESC;

--3--
SELECT Name, SUM(LineTotal) AS TotalRevenue
FROM SalesLT.Product
INNER JOIN SalesLT.SalesOrderDetail
ON SalesLT.Product.ProductID = SalesLT.SalesOrderDetail.ProductID
GROUP BY Name
HAVING SUM(LineTotal) > 20000
ORDER BY TotalRevenue DESC;