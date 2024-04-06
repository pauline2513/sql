USE [AdventureWorksLT] 
GO

SELECT DISTINCT City, StateProvince
FROM SalesLT.Address;

SELECT TOP 10 PERCENT Name, Weight
FROM SalesLT.Product ORDER BY Weight DESC;

SELECT Name, Weight 
FROM SalesLT.Product ORDER BY Weight DESC OFFSET 10 ROWS FETCH FIRST 100 ROWS ONLY;

--2

SELECT * FROM SalesLT.Product;

SELECT Name, Color, Size 
FROM SalesLT.Product WHERE ProductModelID = 1;

SELECT ProductNumber, Name 
FROM SalesLT.Product WHERE Color IN ('Red', 'Black', 'White') AND Size IN ('M', 'S');

SELECT ProductNumber, Name, ListPrice 
FROM SalesLT.Product WHERE ProductNumber LIKE 'BK%';

SELECT ProductNumber, Name, ListPrice 
FROM SalesLT.Product WHERE ProductNumber LIKE 'BK-[^R]%-[0-9][0-9]';


--3

SELECT Name, ListPrice 
FROM SalesLT.Product WHERE Name LIKE 'HL%[0-5][0-9]';