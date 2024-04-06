USE [AdventureWorksLT] 
GO


SELECT * FROM SalesLT.SalesOrderHeader;
SELECT * FROM SalesLT.Address;
SELECT * FROM SalesLT.CustomerAddress ORDER BY CustomerID DESC;
SELECT * FROM SalesLT.Customer;
/*первое*/
SELECT CompanyName, SalesOrderID, TotalDue
FROM SalesLT.Customer
INNER JOIN SalesLT.SalesOrderHeader
ON SalesLT.Customer.CustomerID = SalesLT.SalesOrderHeader.CustomerID;

/*второе*/
SELECT * FROM SalesLT.Address;
SELECT * FROM SalesLT.CustomerAddress ORDER BY CustomerID DESC;

SELECT AddressLine1, AddressLine2, City, StateProvince, PostalCode, CountryRegion
FROM SalesLT.Address
INNER JOIN SalesLT.CustomerAddress
ON SalesLT.CustomerAddress.AddressID = SalesLT.Address.AddressID
WHERE AddressType = 'Main Office';

SELECT c.CompanyName, oh.SalesOrderID, oh.TotalDue, ad.AddressLine1, ad.AddressLine2, ad.City, ad.StateProvince, ad.PostalCode, ad.CountryRegion
FROM SalesLT.Customer AS c
JOIN SalesLT.SalesOrderHeader AS oh
ON c.CustomerID = oh.CustomerID
JOIN SalesLT.CustomerAddress AS ca
ON oh.CustomerID = ca.CustomerID
JOIN SalesLT.Address AS ad
ON ad.AddressID = ca.AddressID
WHERE ca.AddressType = 'Main Office';

/*2.1*/
SELECT CompanyName, SalesOrderID, TotalDue, FirstName, LastName
FROM SalesLT.Customer
LEFT JOIN SalesLT.SalesOrderHeader
ON SalesLT.Customer.CustomerID = SalesLT.SalesOrderHeader.CustomerID
ORDER BY TotalDue DESC;


/*2.2*/
SELECT c.CustomerID, CompanyName, FirstName, LastName, Phone
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.CustomerAddress AS ca
ON c.CustomerID = ca.CustomerID
WHERE AddressID IS NULL ORDER BY c.CustomerID;


/*2.3*/
SELECT * FROM SalesLT.Product;

SELECT c.CustomerID, od.ProductID
FROM SalesLT.Customer AS c
FULL JOIN SalesLT.SalesOrderHeader AS oh 
ON c.CustomerID = oh.CustomerID
FULL JOIN SalesLT.SalesOrderDetail AS od
ON oh.SalesOrderID = od.SalesOrderID
WHERE oh.CustomerID IS NULL OR od.ProductID IS NULL;