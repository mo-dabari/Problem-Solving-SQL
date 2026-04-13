------ Introductory Problems ------

-- Basic Select
-- 1
SELECT *
FROM Shippers

--2
SELECT CategoryName , Description
FROM Categories


--Filtering with WHERE
--1
SELECT FirstName , LastName , HireDate
FROM Employees
WHERE Title = 'Sales Representative' and Country = 'USA'

--2 
SELECT *
FROM Orders
WHERE EmployeeID = 5

--3
SELECT *
FROM Suppliers
WHERE ContactTitle <> 'Marketing Manager'

--4
SELECT *
FROM Products
WHERE ProductName LIKE '%queso%'


--Sorting & Calculations
--1 
SELECT EmployeeID, FirstName, LastName, BirthDate
FROM Employees
ORDER BY BirthDate

--2 
SELECT CONCAT(FirstName , ' ' ,LastName) as FullName
from Employees


--3
SELECT * , (UnitPrice * Quantity) as TotalPrice
FROM [Order Details]

-- Aggregate Functions
--1
SELECT COUNT(CustomerID) as CountCustomer
FROM Customers

--2 
SELECT MIN(OrderDate) as OldOrderDate
FROM Orders

-- Introduction to Joins
--1
SELECT P.ProductID, P.ProductName, Supplier = S.CompanyName , S.ContactName
FROM Products as P
    INNER JOIN Suppliers as S
    ON P.SupplierID = S.SupplierID
ORDER By P.ProductID

--2 
SELECT O.OrderID, OrderDate = convert(date, O.OrderDate),
    S.CompanyName
FROM Orders as O
    INNER JOIN Shippers as S
    ON O.ShipVia = S.ShipperID
WHERE O.OrderID < 10300
ORDER By O.OrderID



-- Groupping
--1 
SELECT Country
FROM Customers
GROUP BY Country

--2 
SELECT ContactTitle , COUNT(ContactTitle) as TotalContactTitle
From Customers
GROUP BY ContactTitle
ORDER BY COUNT(ContactTitle) DESC


------ Intermediate Problems ------

--1  Categories, and the total products in each category
-- For this problem, we’d like to see the total number of products in each
-- category. Sort the results by the total number of products, in descending
-- order.

SELECT C.CategoryName, Count(P.CategoryID) as TotalProducts
From Categories as C
    INNER Join Products as P
    ON C.CategoryID = P.CategoryID
GROUP By C.CategoryName
ORDER By Count(P.CategoryID) DESC


--2 
-- Total customers per country/city
-- In the Customers table, show the total number of customers per Country
-- and City.

SELECT Country, City, COUNT(CustomerID) as TotalCustomer
FROM Customers
GROUP BY Country, City
Order By COUNT(CustomerID) DESC


--3 
-- Products that need reordering
-- What products do we have in our inventory that should be reordered?
-- For now, just use the fields UnitsInStock and ReorderLevel, where
-- UnitsInStock is less than the ReorderLevel, ignoring the fields
-- UnitsOnOrder and Discontinued.
-- Order the results by ProductID.

SELECT ProductID, ProductName, UnitsInStock, ReorderLevel
FROM Products
WHERE UnitsInStock <= ReorderLevel
ORDER By ProductID


--4
-- Products that need reordering, continued
-- Now we need to incorporate these fields—UnitsInStock, UnitsOnOrder,
-- ReorderLevel, Discontinued—into our calculation. We’ll define
-- “products that need reordering” with the following:
-- UnitsInStock plus UnitsOnOrder are less than or equal to
-- ReorderLevel
-- The Discontinued flag is false (0).

SELECT ProductID, ProductName, UnitsInStock, UnitsOnOrder , ReorderLevel, Discontinued
FROM Products
WHERE (UnitsInStock + UnitsOnOrder) <= ReorderLevel
    And Discontinued = 0



--5 
-- Customer list by region
-- A salesperson for Northwind is going on a business trip to visit
-- customers, and would like to see a list of all customers, sorted by
-- region, alphabetically.
-- However, he wants the customers with no region (null in the Region
-- field) to be at the end, instead of at the top, where you’d normally find
-- the null values. Within the same region, companies should be sorted by
-- CustomerI
SELECT CustomerID, CompanyName, Region = COALESCE(Region , 'NULL')
FROM Customers
ORDER BY  Region ,  CustomerID


--6
-- High freight charges
-- Some of the countries we ship to have very high freight charges. We'd
-- like to investigate some more shipping options for our customers, to be
-- able to offer them lower freight charges. Return the three ship countries
-- with the highest average freight overall, in descending order by average
-- freight.

SELECT ShipCountry , AVG(Freight) as AverageFreight
FROM Orders
GROUP By (ShipCountry)
ORDER By AverageFreight DESC
OFFSET 0 ROWS FETCH FIRST 3 ROWS ONLY

--7 
-- High freight charges - 2015
-- We're continuing on the question above on high freight charges. Now,
-- instead of using all the orders we have, we only want to see orders from
-- the year 2015.

SELECT ShipCountry , AVG(Freight) as AverageFreight
FROM Orders
WHERE OrderDate BETWEEN  '2015-01-01' and '2015-12-31'
GROUP By (ShipCountry)
ORDER By AverageFreight DESC
OFFSET 0 ROWS FETCH FIRST 3 ROWS ONLY


--8 
-- High freight charges - last year
-- We're continuing to work on high freight charges. We now want to get
-- the three ship countries with the highest average freight charges. But
-- instead of filtering for a particular year, we want to use the last 12
-- months of order data, using as the end date the last OrderDate in Orders.

SELECT ShipCountry , AVG(Freight) as AverageFreight
FROM Orders
WHERE OrderDate >= (Select DATEADD(YEAR, -1, MAX(OrderDate))
From Orders)
GROUP By (ShipCountry)
ORDER By AverageFreight DESC
OFFSET 0 ROWS FETCH FIRST 3 ROWS ONLY

--9 
-- Inventory list
-- We're doing inventory, and need to show information like the below, for
-- all orders. Sort by OrderID and Product ID.


SELECT E.EmployeeID, E.LastName, O.OrderID, ProductName , OD.Quantity
From Employees as E
    INNER Join Orders as O
    ON O.EmployeeID = E.EmployeeID

    INNER JOIN [Order Details] as OD
    ON Od.OrderID = O.OrderID

    INNER Join Products as P
    ON Od.ProductID = P.ProductID
ORDER BY O.OrderID , P.ProductID

--10
-- Customers with no orders
-- There are some customers who have never actually placed an order.
-- Show these customers.

SELECT C.CustomerID , O.CustomerID
FROM Customers as C
    LEFT JOIN Orders as O
    ON C.CustomerID = O.CustomerID
Where O.CustomerID Is NULL

--11
--Customers with no orders for EmployeeID 4
--One employee (Margaret Peacock, EmployeeID 4) has placed the most
--orders. However, there are some customers who've never placed an order
--with her. Show only those customers who have never placed an order
--with her.

SELECT C.CustomerID , C.ContactName
FROM Customers as C
WHERE  NOT EXISTS (Select O.CustomerID
From Orders as O
Where O.CustomerID = C.CustomerID and O.EmployeeID = 4 )


------ Advanced Problems ------
--1 
-- High-value customers
-- We want to send all of our high-value customers a special VIP gift.
-- We're defining high-value customers as those who've made at least 1
-- order with a total value (not including the discount) equal to $10,000 or
-- more. We only want to consider orders made in the year 2016.

Select
    C.CustomerID,
    C.CompanyName,
    O.OrderID,
    TotalOrderAmount = Sum(OD.Quantity * OD.UnitPrice)

From [Order Details] as OD

    INNER Join Orders as O
    ON OD.OrderID = O.OrderID

    INNER Join Customers as C
    ON O.CustomerID = C.CustomerID

WHERE O.OrderDate BETWEEN '01-01-2016' and '01-01-2017'
    And OD.Discount = 0

GROUP By 
    C.CustomerID,
    C.CompanyName,
    O.OrderID

HAVING Sum(Od.Quantity * OD.UnitPrice) >= 10000

Order By TotalOrderAmount DESC


--2
-- High-value customers - total orders
-- The manager has changed his mind. Instead of requiring that customers
-- have at least one individual orders totaling $10,000 or more, he wants to
-- define high-value customers as those who have orders totaling $15,000
-- or more in 2016. How would you change the answer to the problem
-- above

Select
    C.CustomerID,
    C.CompanyName,
    TotalOrderAmount = Sum(OD.Quantity * OD.UnitPrice)

From [Order Details] as OD

    INNER Join Orders as O
    ON OD.OrderID = O.OrderID

    INNER Join Customers as C
    ON O.CustomerID = C.CustomerID

WHERE O.OrderDate BETWEEN '01-01-2016' and '01-01-2017'
    And OD.Discount = 0

GROUP By 
    C.CustomerID,
    C.CompanyName

HAVING Sum(Od.Quantity * OD.UnitPrice) > 15000

Order By TotalOrderAmount DESC


--3
-- High-value customers - with discount
-- Change the above query to use the discount when calculating high-value
-- customers. Order by the total amount which includes the discount.
Select
    C.CustomerID,
    C.CompanyName,
    TotalsWithoutDiscount = Sum(OD.Quantity * OD.UnitPrice) ,
    TotalsWithDiscount =  Sum(OD.Quantity * OD.UnitPrice * (1 - Od.Discount))

From [Order Details] as OD

    INNER Join Orders as O
    ON OD.OrderID = O.OrderID

    INNER Join Customers as C
    ON O.CustomerID = C.CustomerID

WHERE O.OrderDate BETWEEN '01-01-2016' and '01-01-2017'

GROUP By 
    C.CustomerID,
    C.CompanyName

HAVING Sum(OD.Quantity * OD.UnitPrice * (1 - Od.Discount)) > 10000

Order By TotalsWithDiscount DESC


--4
-- Month-end orders
-- At the end of the month, salespeople are likely to try much harder to get
-- orders, to meet their month-end quotas. Show all orders made on the last
-- day of the month. Order by EmployeeID and OrderID

SELECT O.EmployeeID , O.OrderID , O.OrderDate
FROM Orders as O
WHERE OrderDate = EOMONTH(O.OrderDate)
ORDER By O.EmployeeID , O.OrderID


--5 
-- Orders with many line items
-- The Northwind mobile app developers are testing an app that customers
-- will use to show orders. In order to make sure that even the largest
-- orders will show up correctly on the app, they'd like some samples of
-- orders that have lots of individual line items. Show the 10 orders with
-- the most line items, in order of total line items.

-- Result 10 Rows
SELECT Top(10)
    OD.OrderID , Count(OD.OrderID) as CountItemLine
FROM [Order Details] as OD
GROUP BY OD.OrderID
ORDER BY CountItemLine DESC


-- Result 37 Rows With Key Word (With Ties)
SELECT Top(10) With Ties
    OD.OrderID , Count(OD.OrderID) as CountItemLine
FROM [Order Details] as OD
GROUP BY OD.OrderID
ORDER BY CountItemLine DESC


--6 
-- Orders - random assortment
-- The Northwind mobile app developers would now like to just get a
-- random assortment of orders for beta testing on their app. Show a
-- random set of 2% of all orders.

SELECT top(2) PERCENT
    OrderID
From Orders
ORDER By NewID()


--7 
-- Orders - accidental double-entry
-- Janet Leverling, one of the salespeople, has come to you with a request.
-- She thinks that she accidentally double-entered a line item on an order,
-- with a different ProductID, but the same quantity. She remembers that
-- the quantity was 60 or more. Show all the OrderIDs with line items that
-- match this, in order of OrderID


SELECT OD.OrderID
From [Order Details] as OD
Where OD.Quantity >= 60
GROUP By OD.OrderID, OD.Quantity
Having COUNT(*) > 1
Order By OD.OrderID


--8 
-- Orders - accidental double-entry details
-- Based on the previous question, we now want to show details of the
-- order, for orders that match the above criteria.


SELECT Ood.OrderID, Ood.ProductID, Ood.UnitPrice, Ood.Quantity, Ood.Discount
FROM [Order Details] as Ood
WHERE Ood.OrderID IN (SELECT OD.OrderID
From [Order Details] as OD
Where OD.Quantity >= 60
GROUP By OD.OrderID, OD.Quantity
Having COUNT(*) > 1
)

Order By Ood.OrderID ,  Ood.Quantity
