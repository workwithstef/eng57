
-- calculates the Gross Total and corresponding Net Total (after discount)
-- then sorts the results in order, highest first.
-- then only the TOP 2 are selected
SELECT TOP 2 UnitPrice, Quantity, Discount, UnitPrice*Quantity AS "Gross Total", 
UnitPrice*Quantity*(1-Discount) AS "Net Total"
FROM [Order Details]
ORDER BY "Net Total" DESC

-- SQL INDEX START FROM "1" NOT "0" !!!

-- STRING FUNCTIONS

-- selects 4 characters, starting from index 2 = 'tefa'
SELECT SUBSTRING('Stefan', 2, 4)

-- used to identify index of specified string within text = 5
CHARINDEX('a', 'Stefan')

-- used to select first/last 3 items of string (LEFT SIDE/RIGHT SIDE) = ste / =fan
SELECT LEFT('Stefan', 3)
SELECT RIGHT('Stefan', 3)

-- Used to remove spaces from the right/left of the string
RTRIM('     STEFAN     ')
LTRIM('     STEFAN     ')

-- replaces string in expression with new string = REY OKOLO
REPLACE('STEFAN OKOLO', 'STEFAN', 'REY')


-- EXAMPLE

-- separating PostCode region (characters before the space) from PostCode 
-- and identifying where space occurs.
SELECT PostalCode AS "Post Code",
LEFT(PostalCode, CHARINDEX(' ',PostalCode)-1) AS "Post Code Region",
    CHARINDEX(' ',PostalCode) AS "Space Found", Country
FROM Customers
WHERE Country='UK'

-- selecting ProductNames which contain an apostrophe
SELECT ProductName 
FROM Products
WHERE CHARINDEX('''', ProductName) != 0
-- "QUOTING" A SINGLE QUOTE; FOUR SINGLE QUOTES, [''''] = ["'"]


-- DATE FUNCTIONS

-- retrieves current date & time
GETDATE()

-- retrieves computer's current date and time
SYSDATETIME()

-- adds 5 days to parameter
DATEADD(d, 5, parameter)

-- returns the difference between date parameters
DATEDIFF(d, parameter1, parameter2)
-- d or dd = day; m or mm = month; yy or yyyy = year

-- returns year, month, and day of selected parameter
SELECT YEAR(parameter), MONTH(parameter), DAY(parameter)

-- calculates age of employees; use leap year concept to get exact age
SELECT FirstName + ' ' + LastName AS "Full Name",
DATEDIFF(dd, BirthDate, GETDATE())/365.25 AS "Age"
FROM Employees

-- if-then statements
SELECT DATEDIFF(d, OrderDate, ShippedDate) AS "Time Taken",
CASE
WHEN DATEDIFF(d, OrderDate, ShippedDate) < 10 THEN 'On Time'
ELSE 'Overdue'
END AS "Status"
FROM Orders


-- AGGREGATE FUNCTIONS

-- grand total, average, smallest value, biggest value, counts number of rows 
SUM(column)
AVG(column)
MIN(column)
MAX(column)
COUNT(column)

-- groups the aggregate values by SupplierID
SELECT SupplierID,
SUM(UnitsOnOrder) AS "Total On Order",
    AVG(UnitsOnOrder) AS "avg on order",
    MAX(UnitsOnOrder) AS "max on order"
FROM Products
GROUP BY SupplierID
HAVING AVG(UnitsOnOrder)>5
-- HAVING is used like WHERE. HAVING must be used with GROUP BY.


-- selects the average reorder level and groups it based on CategoryID
SELECT CategoryID,
    AVG(ReorderLevel) AS "Avg Reorder Level"
FROM Products
GROUP BY CategoryID
ORDER BY AVG(ReorderLevel) DESC
-- WHEN GROUPING, THE GROUP BY clause must match SELECT BY clause (excl. aggregate functions)


--  JOIN FUNCTIONS

-- INNER JOIN. used to combine tables by matching respective columns, (usually id column)
-- then corresponding data from right table is transferred to the Left table,
-- as selected by the ON command
SELECT student.name, course.name
FROM student INNER JOIN course ON student.course = course.id

-- in this case: 'student' table is on Left side of INNER JOIN, hence Left table.
-- student.course = course.id; hence the 'course' column in student will be replaced with corresponding course 'id' values.

-- Examples

SELECT Products.SupplierID, Suppliers.CompanyName, AVG(UnitsOnOrder) AS "Avg Units"
FROM Products INNER JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
GROUP BY Products.SupplierID, Suppliers.CompanyName

-- shorthand version
SELECT p.SupplierID, s.CompanyName, AVG(p.UnitsOnOrder) AS "AVG units order"
FROM Products p INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
GROUP BY p.SupplierID, s.CompanyName 
-- notice how "ON p.SupplierID = s.SupplierID" refers to primary key/foreign key relationship.

-- LEFT JOIN combines everything (every row) from left table + matched rows from right table.
-- RIGHT JOIN combines everything (every row) from right table + matched rows from left table.

-- INNER JOINS can be executed with multiple tables
SELECT p.ProductName, p.UnitPrice, s.CompanyName AS "Supplier",
        c.CategoryName AS "Category"
FROM Products p 
INNER JOIN Suppliers s ON p.SupplierID=s.SupplierID
INNER JOIN Categories c ON p.CategoryID=c.CategoryID
-- in this case Products is the only Left table, while Suppliers and Categories are the right tables.

SELECT o.OrderID, o.OrderDate, o.Freight, c.CompanyName, e.FirstName + ' ' + e.LastName AS "Employee Name"
FROM Orders o 
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID

-- FORMAT used to format the date
SELECT OrderID, FORMAT(OrderDate, 'dd/mm/yyyy') AS "Order Date"
FROM Orders
