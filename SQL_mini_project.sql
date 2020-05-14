
-- 1.1
SELECT c.CustomerID, c.CompanyName, c.Address
FROM Customers c
WHERE City IN ('Paris', 'London')
-- 1.2
SELECT p.ProductName
FROM Products p
WHERE p.QuantityPerUnit LIKE '%bottles%'
-- 1.3
SELECT p.ProductName, s.CompanyName AS "Supplier Name", s.Country
FROM Products p INNER JOIN Suppliers s ON p.SupplierID=s.SupplierID
WHERE p.QuantityPerUnit LIKE '%bottles%'
-- 1.4
SELECT COUNT(p.CategoryID) AS "Number of Products", c.CategoryName
FROM Products p INNER JOIN Categories c ON p.CategoryID=c.CategoryID
GROUP BY p.CategoryID, c.CategoryName
ORDER BY "Number of Products" DESC
-- 1.5
SELECT e.TitleOfCourtesy + ' ' + e.FirstName + ' ' + e.LastName AS "Name", e.City
FROM Employees e
WHERE e.Country = 'UK'
-- 1.6
SELECT ROUND(SUM(d.UnitPrice*d.Quantity*(1-d.Discount)), 2) AS "Sales Total", RegionID
FROM [Order Details] d  
INNER JOIN Orders o ON d.OrderID=o.OrderID
INNER JOIN Employees e ON o.EmployeeID=e.EmployeeID
INNER JOIN EmployeeTerritories et ON e.EmployeeID=et.EmployeeID
INNER JOIN Territories t ON et.TerritoryID=t.TerritoryID
GROUP BY RegionID
HAVING SUM(d.UnitPrice*d.Quantity*(1-d.Discount))>1000000


-- 1.7

SELECT COUNT(o.Freight) AS "Freights over 100 to UK/US"
FROM Orders o 
WHERE o.Freight > 100 AND o.ShipCountry IN ('USA', 'UK')


-- 1.8

SELECT TOP 2 od.OrderID AS "Order Number", od.UnitPrice, od.Quantity, od.Discount, 
    MAX(od.UnitPrice*od.Quantity*(od.Discount)) AS "Highest Amount of Discount Applied"
FROM [Order Details] od 
GROUP BY od.OrderID, od.Discount, od.UnitPrice, od.Quantity
ORDER BY "Highest Amount of Discount Applied" DESC




-- 2.1
CREATE TABLE spartan_table
(
    spartanID INT PRIMARY KEY IDENTITY(1,1),
    title VARCHAR(5),
    firstname VARCHAR(20),
    lastname VARCHAR(20),
    university VARCHAR(max),
    uni_course VARCHAR(max),
    grade VARCHAR(max),
    age INT
)

-- 2.2
INSERT INTO spartan_table
(title, firstname, lastname, university, uni_course, grade, age)
VALUES
('Mr.', 'Stefan', 'Okolo', 'University of Birmingham', 'Mechanical Engineering MEng', '1st Class', 23 )


-- 3.1
SELECT (e.TitleOfCourtesy+ ' ' +e.FirstName+ ' ' +e.LastName) AS "Full Name", e.ReportsTo
FROM Employees e 

-- 3.2
SELECT s.CompanyName, ROUND(SUM(od.UnitPrice*od.Quantity*(1-od.Discount)), 2) AS "Total Sales"
FROM Suppliers s 
INNER JOIN Products p ON s.SupplierID=p.SupplierID
INNER JOIN [Order Details] od ON p.ProductID=od.ProductID
GROUP BY s.CompanyName
HAVING SUM(od.UnitPrice*od.Quantity*(1-od.Discount))>10000
ORDER BY "Total Sales" DESC

-- 3.3
SELECT TOP 10 c.ContactName, ROUND(SUM((UnitPrice*Quantity*(1-Discount))), 2) AS "Total Value of Orders"
FROM Orders o 
INNER JOIN Customers c ON o.CustomerID=c.CustomerID
INNER JOIN [Order Details] od ON o.OrderID=od.OrderID
WHERE o.ShippedDate BETWEEN '1998-01-01' AND '1998-05-06' 
GROUP BY c.ContactName
ORDER BY "Total Value of Orders" DESC

-- 3.4

SELECT AVG(DATEDIFF(dd, o.OrderDate, o.ShippedDate)) AS "Delivery Time (Days)", 
    FORMAT(o.ShippedDate, 'MM-yy') AS "Ship Month-Year"
FROM Orders o 
GROUP BY FORMAT(o.ShippedDate, 'MM-yy')
ORDER BY FORMAT(o.ShippedDate, 'MM-yy') DESC

