# 🚀 SQL Practice & Problem Solving Guide

This repository contains a comprehensive collection of SQL problems designed to strengthen your querying skills through a **learn-by-doing** approach.

---

# 📘 Table of Contents

1. Introductory Problems (From SQL Practice Problems Book)
2. Intermediate Problems
3. Advanced Problems
4. Custom Vehicle Database Problems (1 → 80)

---

# 🟢 Introductory Problems

### 1. Which shippers do we have?
Return all fields from the `Shippers` table.

### 2. Certain fields from Categories
In the Categories table, selecting all the fields using this SQL:
Select * from Categories
…will return 4 columns. We only want to see two columns,
CategoryName and Description.

### 3. Sales Representatives
We’d like to see just the FirstName, LastName, and HireDate of all the
employees with the Title of Sales Representative. Write a SQL
statement that returns only those employees.

### 4. Sales Representatives in the United States
Now we’d like to see the same columns as above, but only for those
employees that both have the title of Sales Representative, and also are
in the United States.

### 5. Orders placed by specific EmployeeID
Show all the orders placed by a specific employee. The EmployeeID for
this Employee (Steven Buchanan) is 5.

### 6. Suppliers and ContactTitles
In the Suppliers table, show the SupplierID, ContactName, and
ContactTitle for those Suppliers whose ContactTitle is not Marketing
Manager.

### 7. Products with “queso” in ProductName
In the products table, we’d like to see the ProductID and ProductName
for those products where the ProductName includes the string “queso”.

### 8. Orders shipping to France or Belgium
Looking at the Orders table, there’s a field called ShipCountry. Write a
query that shows the OrderID, CustomerID, and ShipCountry for the
orders where the ShipCountry is either France or Belgium.

### 9. Orders shipping to any country in Latin America
Now, instead of just wanting to return all the orders from France of
Belgium, we want to show all the orders from any Latin American
country. But we don’t have a list of Latin American countries in a table
in the Northwind database. So, we’re going to just use this list of Latin
American countries that happen to be in the Orders table:
Brazil
Mexico
Argentina
Venezuela
It doesn’t make sense to use multiple Or statements anymore, it would
get too convoluted. Use the In statement.

### 10. Employees, in order of age
For all the employees in the Employees table, show the FirstName,
LastName, Title, and BirthDate. Order the results by BirthDate, so we
have the oldest employees first.

### 11. Showing only the Date with a DateTime field
In the output of the query above, showing the Employees in order of
BirthDate, we see the time of the BirthDate field, which we don’t want.
Show only the date portion of the BirthDate field.

### 12. Employees full name
Show the FirstName and LastName columns from the Employees table,
and then create a new column called FullName, showing FirstName and
LastName joined together in one column, with a space in-between.

### 13. OrderDetails amount per line item
In the OrderDetails table, we have the fields UnitPrice and Quantity.
Create a new field, TotalPrice, that multiplies these two together. We’ll
ignore the Discount field for now.
In addition, show the OrderID, ProductID, UnitPrice, and Quantity.
Order by OrderID and ProductID.

### 14. How many customers?
How many customers do we have in the Customers table? Show one
value only, and don’t rely on getting the recordcount at the end of a
resultset.

### 15. When was the first order?
Show the date of the first order ever made in the Orders table.

### 16. Countries where there are customers
Show a list of countries where the Northwind company has customers.

### 17. Contact titles for customers
Show a list of all the different values in the Customers table for
ContactTitles. Also include a count for each ContactTitle.
This is similar in concept to the previous question “Countries where
there are customers”, except we now want a count for each ContactTitle.

### 18. Products with associated supplier names
We’d like to show, for each product, the associated Supplier. Show the
ProductID, ProductName, and the CompanyName of the Supplier. Sort
by ProductID.
This question will introduce what may be a new concept, the Join clause
in SQL. The Join clause is used to join two or more relational database
tables together in a logical way.
Here’s a data model of the relationship between Products and Suppliers.

### 19. Orders and the Shipper that was used
We’d like to show a list of the Orders that were made, including the
Shipper that was used. Show the OrderID, OrderDate (date only), and
CompanyName of the Shipper, and sort by OrderID.
In order to not show all the orders (there’s more than 800), show only
those rows with an OrderID of less than 10300.



# 🟡 Intermediate Problems



### 1. Which shippers do we have?
Return all fields from the `Shippers` table.

### 1. Which shippers do we have?
Return all fields from the `Shippers` table.

### 1. Which shippers do we have?
Return all fields from the `Shippers` table.


### 20. Categories, and the total products in each category
For this problem, we’d like to see the total number of products in each
category. Sort the results by the total number of products, in descending
order.

### 21. Total customers per country/city
In the Customers table, show the total number of customers per Country
and City.

### 22. Products that need reordering
What products do we have in our inventory that should be reordered?
For now, just use the fields UnitsInStock and ReorderLevel, where
UnitsInStock is less than the ReorderLevel, ignoring the fields
UnitsOnOrder and Discontinued.
Order the results by ProductID.

### 23. Products that need reordering, continued
Now we need to incorporate these fields—UnitsInStock, UnitsOnOrder,
ReorderLevel, Discontinued—into our calculation. We’ll define
“products that need reordering” with the following:
UnitsInStock plus UnitsOnOrder are less than or equal to
ReorderLevel
The Discontinued flag is false (0).

### 24. Customer list by region
A salesperson for Northwind is going on a business trip to visit
customers, and would like to see a list of all customers, sorted by
region, alphabetically.
However, he wants the customers with no region (null in the Region
field) to be at the end, instead of at the top, where you’d normally find
the null values. Within the same region, companies should be sorted by
CustomerID.

### 25. High freight charges
Some of the countries we ship to have very high freight charges. We'd
like to investigate some more shipping options for our customers, to be
able to offer them lower freight charges. Return the three ship countries
with the highest average freight overall, in descending order by average
freight.

### 26. High freight charges - 2015
We're continuing on the question above on high freight charges. Now,
instead of using all the orders we have, we only want to see orders from
the year 2015.

### 27. High freight charges with between
Another (incorrect) answer to the problem above is this:
```sql
Select Top 3
ShipCountry
,AverageFreight = avg(freight)
From Orders
Where
OrderDate between '1/1/2015' and '12/31/2015'
Group By ShipCountry
Order By AverageFreight desc;
```
Notice when you run this, it gives Sweden as the ShipCountry with the
third highest freight charges. However, this is wrong - it should be
France.
What is th

### 28. High freight charges - last year
We're continuing to work on high freight charges. We now want to get
the three ship countries with the highest average freight charges. But
instead of filtering for a particular year, we want to use the last 12
months of order data, using as the end date the last OrderDate in Orders.

### 29. Inventory list
We're doing inventory, and need to show information like the below, for
all orders. Sort by OrderID and Product ID.


### 30. Customers with no orders
There are some customers who have never actually placed an order.
Show these customers.

### 31. Customers with no orders for EmployeeID 4
One employee (Margaret Peacock, EmployeeID 4) has placed the most
orders. However, there are some customers who've never placed an order
with her. Show only those customers who have never placed an order
with her.





```sql
SELECT * FROM Shippers;

```



### 1. Which shippers do we have?

# 🔴 Advanced Problems

### 1. Which shippers do we have?


## Overview

This repository contains a collection of 80 solved SQL problems, covering a wide range of SQL concepts. The solutions demonstrate best practices in writing efficient and optimized SQL queries.

## Table of Contents
1. [Problem - 01: Create Master View](#problem-01-create-master-view)
2. [Problem - 02: Get all vehicles made between 1950 and 2000](#problem-02-get-all-vehicles-made-between-1950-and-2000)
3. [Problem - 03: Get number of vehicles made between 1950 and 2000](#problem-03-get-number-of-vehicles-made-between-1950-and-2000)
4. [Problem - 04: Get number of vehicles made between 1950 and 2000 per make](#problem-04-get-number-of-vehicles-made-between-1950-and-2000-per-make)
5. [Problem - 05: Get all makes that have manufactured more than 12000 vehicles](#problem-05-get-all-makes-that-have-manufactured-more-than-12000-vehicles)
6. [Problem - 06: Get number of vehicles made between 1950 and 2000 per make with total vehicles](#problem-06-get-number-of-vehicles-made-between-1950-and-2000-per-make-with-total-vehicles)
7. [Problem - 07: Get number of vehicles made between 1950 and 2000 per make with percentage](#problem-07-get-number-of-vehicles-made-between-1950-and-2000-per-make-with-percentage)
8. [Problem - 08: Get make, fuel type, and number of vehicles per fuel type per make](#problem-08-get-make-fuel-type-and-number-of-vehicles-per-fuel-type-per-make)
9. [Problem - 09: Get all vehicles that run with GAS](#problem-09-get-all-vehicles-that-run-with-gas)
10. [Problem - 10: Get all makes that run with GAS](#problem-10-get-all-makes-that-run-with-gas)
11. [Problem - 11: Get total makes that run with GAS](#problem-11-get-total-makes-that-run-with-gas)
12. [Problem - 12: Count vehicles by make and order by number of vehicles](#problem-12-count-vehicles-by-make-and-order-by-number-of-vehicles)
13. [Problem - 13: Get all makes with more than 20K vehicles](#problem-13-get-all-makes-with-more-than-20k-vehicles)
14. [Problem - 14: Get all makes starting with 'B'](#problem-14-get-all-makes-starting-with-b)
15. [Problem - 15: Get all makes ending with 'W'](#problem-15-get-all-makes-ending-with-w)
16. [Problem - 16: Get all makes that manufacture DriveTypeName = FWD](#problem-16-get-all-makes-that-manufacture-drivetypename--fwd)
17. [Problem - 17: Get total makes that manufacture DriveTypeName = FWD](#problem-17-get-total-makes-that-manufacture-drivetypename--fwd)
18. [Problem - 18: Get total vehicles per DriveTypeName per make](#problem-18-get-total-vehicles-per-drivetypename-per-make)
19. [Problem - 19: Get total vehicles per DriveTypeName per make with total > 10,000](#problem-19-get-total-vehicles-per-drivetypename-per-make-with-total--10000)
20. [Problem - 20: Get all vehicles with unspecified number of doors](#problem-20-get-all-vehicles-with-unspecified-number-of-doors)
21. [Problem - 21: Get total vehicles with unspecified number of doors](#problem-21-get-total-vehicles-with-unspecified-number-of-doors)
22. [Problem - 22: Get percentage of vehicles with unspecified number of doors](#problem-22-get-percentage-of-vehicles-with-unspecified-number-of-doors)
23. [Problem - 23: Get MakeID, Make, SubModelName for vehicles with SubModelName 'Elite'](#problem-23-get-makeid-make-submodelname-for-vehicles-with-submodelname-elite)
24. [Problem - 24: Get all vehicles with engines > 3 liters and 2 doors](#problem-24-get-all-vehicles-with-engines--3-liters-and-2-doors)
25. [Problem - 25: Get make and vehicles with engine containing 'OHV' and 4 cylinders](#problem-25-get-make-and-vehicles-with-engine-containing-ohv-and-4-cylinders)
26. [Problem - 26: Get all vehicles with body 'Sport Utility' and year > 2020](#problem-26-get-all-vehicles-with-body-sport-utility-and-year--2020)
27. [Problem - 27: Get all vehicles with body 'Coupe', 'Hatchback', or 'Sedan'](#problem-27-get-all-vehicles-with-body-coupe-hatchback-or-sedan)
28. [Problem - 28: Get all vehicles with body 'Coupe', 'Hatchback', or 'Sedan' and year 2008, 2020, or 2021](#problem-28-get-all-vehicles-with-body-coupe-hatchback-or-sedan-and-year-2008-2020-or-2021)
29. [Problem - 29: Return found=1 if any vehicle is made in year 1950](#problem-29-return-found1-if-any-vehicle-is-made-in-year-1950)
30. [Problem - 30: Get Vehicle_Display_Name, NumDoors, and door description](#problem-30-get-vehicle_display_name-numdoors-and-door-description)
31. [Problem - 31: Get Vehicle_Display_Name, year, and age of the car](#problem-31-get-vehicle_display_name-year-and-age-of-the-car)
32. [Problem - 32: Get Vehicle_Display_Name, year, and age for vehicles aged between 15 and 25 years](#problem-32-get-vehicle_display_name-year-and-age-for-vehicles-aged-between-15-and-25-years)
33. [Problem - 33: Get minimum, maximum, and average Engine CC](#problem-33-get-minimum-maximum-and-average-engine-cc)
34. [Problem - 34: Get all vehicles with the minimum Engine CC](#problem-34-get-all-vehicles-with-the-minimum-engine-cc)
35. [Problem - 35: Get all vehicles with the maximum Engine CC](#problem-35-get-all-vehicles-with-the-maximum-engine-cc)
36. [Problem - 36: Get all vehicles with Engine CC below average](#problem-36-get-all-vehicles-with-engine-cc-below-average)
37. [Problem - 37: Get total vehicles with Engine CC above average](#problem-37-get-total-vehicles-with-engine-cc-above-average)
38. [Problem - 38: Get all unique Engine CC sorted descending](#problem-38-get-all-unique-engine-cc-sorted-descending)
39. [Problem - 39: Get the maximum 3 Engine CC](#problem-39-get-the-maximum-3-engine-cc)
40. [Problem - 40: Get all vehicles with one of the maximum 3 Engine CC](#problem-40-get-all-vehicles-with-one-of-the-maximum-3-engine-cc)
41. [Problem - 41: Get all makes that manufacture one of the maximum 3 Engine CC](#problem-41-get-all-makes-that-manufacture-one-of-the-maximum-3-engine-cc)
42. [Problem - 42: Get a table of unique Engine CC and calculate tax per Engine CC](#problem-42-get-a-table-of-unique-engine-cc-and-calculate-tax-per-engine-cc)
43. [Problem - 43: Get make and total number of doors manufactured per make](#problem-43-get-make-and-total-number-of-doors-manufactured-per-make)
44. [Problem - 44: Get total number of doors manufactured by 'Ford'](#problem-44-get-total-number-of-doors-manufactured-by-ford)
45. [Problem - 45: Get number of models per make and order by number of models descending](#problem-45-get-number-of-models-per-make-and-order-by-number-of-models-descending)
46. [Problem - 46: Get the highest 3 manufacturers that make the highest number of models](#problem-46-get-the-highest-3-manufacturers-that-make-the-highest-number-of-models)
47. [Problem - 47: Get the highest number of models manufactured](#problem-47-get-the-highest-number-of-models-manufactured)
48. [Problem - 48: Get the highest manufacturers that manufactured the highest number of models](#problem-48-get-the-highest-manufacturers-that-manufactured-the-highest-number-of-models)
49. [Problem - 49: Get the lowest manufacturers that manufactured the lowest number of models](#problem-49-get-the-lowest-manufacturers-that-manufactured-the-lowest-number-of-models)
50. [Problem - 50: Get all fuel types in random order](#problem-50-get-all-fuel-types-in-random-order)
51. [Problem - 51: Get all employees that have a manager along with manager's name](#problem-51-get-all-employees-that-have-a-manager-along-with-managers-name)
52. [Problem - 52: Get all employees that have or do not have a manager](#problem-52-get-all-employees-that-have-or-do-not-have-a-manager)
53. [Problem - 53: Get all employees that have or do not have a manager with manager's name](#problem-53-get-all-employees-that-have-or-do-not-have-a-manager-with-managers-name)
54. [Problem - 54: Get all employees managed by 'Mohammed'](#problem-54-get-all-employees-managed-by-mohammed)
55. [Problem - 55: Display all employee data](#problem-55-display-all-employee-data)
56. [Problem - 56: Display employee first name, last name, salary, and department number](#problem-56-display-employee-first-name-last-name-salary-and-department-number)
57. [Problem - 57: Display project names, locations, and responsible department](#problem-57-display-project-names-locations-and-responsible-department)
58. [Problem - 58: Display employee full name and annual commission](#problem-58-display-employee-full-name-and-annual-commission)
59. [Problem - 59: Display employee ID and name who earn more than 1000 LE monthly](#problem-59-display-employee-id-and-name-who-earn-more-than-1000-le-monthly)
60. [Problem - 60: Display employee ID and name who earn more than 10000 LE annually](#problem-60-display-employee-id-and-name-who-earn-more-than-10000-le-annually)
61. [Problem - 61: Display names and salaries of female employees](#problem-61-display-names-and-salaries-of-female-employees)
62. [Problem - 62: Display department ID and name managed by manager with ID 968574](#problem-62-display-department-id-and-name-managed-by-manager-with-id-968574)
63. [Problem - 63: Display project IDs, names, and locations controlled by department 10](#problem-63-display-project-ids-names-and-locations-controlled-by-department-10)
64. [Problem - 64: Get all instructor names without repetition](#problem-64-get-all-instructor-names-without-repetition)
65. [Problem - 65: Display instructor name and department name](#problem-65-display-instructor-name-and-department-name)
66. [Problem - 66: Display student full name and course name](#problem-66-display-student-full-name-and-course-name)
67. [Problem - 67: Display department ID, name, and manager's name](#problem-67-display-department-id-name-and-managers-name)
68. [Problem - 68: Display department name and project name](#problem-68-display-department-name-and-project-name)
69. [Problem - 69: Display full data about dependents](#problem-69-display-full-data-about-dependents)
70. [Problem - 70: Display project ID, name, and location in Cairo or Alex](#problem-70-display-project-id-name-and-location-in-cairo-or-alex)
71. [Problem - 71: Display project data with name starting with 'a'](#problem-71-display-project-data-with-name-starting-with-a)
72. [Problem - 72: Display employees in department 30 with salary between 1000 and 2000 LE](#problem-72-display-employees-in-department-30-with-salary-between-1000-and-2000-le)
73. [Problem - 73: Retrieve employees in department 10 working on 'AL Rabwah' project](#problem-73-retrieve-employees-in-department-10-working-on-al-rabwah-project)
74. [Problem - 74: Retrieve employee names and project names sorted by project name](#problem-74-retrieve-employee-names-and-project-names-sorted-by-project-name)
75. [Problem - 75: Display project number, department name, manager's last name, address, and birthdate for projects in Cairo](#problem-75-display-project-number-department-name-managers-last-name-address-and-birthdate-for-projects-in-cairo)
76. [Problem - 76: Get the max 2 salaries using subquery](#problem-76-get-the-max-2-salaries-using-subquery)
77. [Problem - 77: Display departments with average salary less than the overall average](#problem-77-display-departments-with-average-salary-less-than-the-overall-average)
78. [Problem - 78: List last names of managers with no dependents](#problem-78-list-last-names-of-managers-with-no-dependents)
79. [Problem - 79: Get all employees managed by 'Mohammed'](#problem-79-get-all-employees-managed-by-mohammed)
80. [Problem - 80: Get all employees managed by 'Mohammed'](#problem-80-get-all-employees-managed-by-mohammed)
