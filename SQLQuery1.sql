USE [AdventureWorksLT] 
GO

SELECT * 
FROM SalesLT.Customer;

SELECT Title, FirstName, MiddleName, LastName, Suffix
FROM SalesLT.Customer;

--SELECT SalesPerson, Title + ' ' + LastName AS CustomerName, Phone
--FROM SalesLT.Customer;

SELECT SalesPerson,
	CASE
		WHEN Title IS NULL THEN LastName
		ELSE Title + ' ' + LastName
	END AS CustomerName, Phone
FROM SalesLT.Customer;


-- 2

SELECT CAST(CustomerID AS varchar(5)) + ': ' + CompanyName AS CustomerCompany
FROM SalesLT.Customer;

--SELECT *
--FROM SalesLT.SalesOrderHeader;

SELECT CAST(SalesOrderID AS varchar) + ' (' + CAST(RevisionNumber AS varchar) + ')' AS OrderRevision, CONVERT(nvarchar, OrderDate, 102) AS OrderDate
FROM SalesLT.SalesOrderHeader;

--3

SELECT
	CASE
		WHEN MiddleName IS NULL THEN FirstName + ' ' + LastName
		ELSE FirstName + ' ' + MiddleName + ' ' + LastName
	END AS CustomerName	
FROM SalesLT.Customer;

UPDATE SalesLT.Customer
SET EmailAddress = NULL
WHERE CustomerID % 7 = 1;

SELECT CustomerID, 
	CASE 
		WHEN EmailAddress IS NULL THEN Phone
		ELSE EmailAddress
	END AS PrimaryContact
FROM SalesLT.Customer;

UPDATE SalesLT.SalesOrderHeader
SET ShipDate = NULL
WHERE SalesOrderID > 71899;

SELECT SalesOrderID, 
	CASE 
		WHEN ShipDate IS NULL THEN 'Awaiting Shipment'
		ELSE 'Shipped'
	END AS PrimaryContact
FROM SalesLT.SalesOrderHeader;