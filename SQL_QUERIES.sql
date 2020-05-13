-- selects all data for employees from london or who are doctors
SELECT * 
FROM Employees
WHERE City = 'London' OR TitleOfCourtesy = 'Dr.';

-- counts how many instances for EmployeeID
SELECT COUNT(EmployeeID) AS total_employees
FROM Employees;

-- counts how many instances of Products which are Discontinued
SELECT COUNT(Discontinued) AS 'Total discontinued products'
FROM Products
WHERE Discontinued = 1;
-- QUALITY GATE WILL NOT ACCEPT SINGLE QUOTES AS NAMING CONVENTION

--  SINGLE QUOTES MUST BE USED FOR VARCHAR STATEMENTS
SELECT CompanyName, City, Country, Region
FROM Customers
WHERE Region = 'BC';

--  selects first 100 results
SELECT TOP 100 CompanyName
FROM Customers;

-- selects only one instance of required countries which have 'e' as the 2nd letter
SELECT DISTINCT Country
FROM Customers
WHERE ContactTitle = 'Owner' AND Country LIKE '_e%';

-- [charlist]. shows countries which start with M or S
SELECT DISTINCT Country
FROM Customers
WHERE Country LIKE '[MS]%';

-- [^charlist]. shows countries which don't start with M or S
SELECT DISTINCT Country
FROM Customers
WHERE Country LIKE '[^MS]%';

-- like using the OR key in the WHERE Condition >>> "WHERE Region = 'WA' OR Region = 'SP' "
SELECT *
FROM Customers
WHERE Region IN ('WA', 'SP');

-- EXERCIES
-- 1) selects product name & ID where price is less than 5
SELECT ProductName, ProductID
FROM Products
WHERE UnitPrice < 5;
-- 2) selects categories with names that start with B or S
SELECT CategoryName
FROM Categories
WHERE CategoryName LIKE '[BS]%';
-- 3} counts total number of orders associated with empl.id 5 & 7
SELECT COUNT(OrderID) AS "EMPL.ID 5 & 7 TOTAL ORDERS"
FROM Orders
WHERE EmployeeID IN (5, 7);
-- BONUS ROUND! Divides the result of previous command into individual rows
SELECT EmployeeID, COUNT(OrderID) AS "Number of Orders"
FROM Orders
GROUP BY EmployeeID
HAVING EmployeeID IN (5, 7);

-- concatenates 'City' and 'Country' joined by a comma.
SELECT CompanyName, City + ', ' + Country AS "City"
FROM Customers
-- concatenates 'FirstName' and 'LastName', joined by a space
SELECT FirstName + ' ' + LastName AS "Full Name"
FROM Employees
-- selects specific countries where 'Region' is not Null
SELECT DISTINCT Country
FROM Customers
WHERE Region IS NOT NULL

--Homework--->Reading JOINS-INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN