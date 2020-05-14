-- SUB QUERIES


SELECT c.CompanyName
FROM Customers c 
WHERE c.CustomerID IN
    (SELECT o.CustomerID FROM Orders o) 

-- using sub-query as a COLUMN (best used with Commands that only return one value i.e MAX(Value))
SELECT o.OrderID, o.ProductID, o.UnitPrice, o.Quantity, o.Discount,
(SELECT MAX(UnitPrice) FROM [Order Details]) AS "MAX PRICE"
FROM [Order Details] o

-- using sub-query as ANOTHER TABLE as part of inner join command
SELECT od.ProductID, sq1.totalamt AS "Total Sold for the Product", 
UnitPrice, UnitPrice/totalamt*100 AS "% of Total"
FROM [Order Details] od
INNER JOIN
    (SELECT ProductID, SUM(UnitPrice*Quantity) AS "totalamt"
    FROM [Order Details]
    GROUP BY ProductID) sq1 ON sq1.ProductID=od.ProductID

-- EXAMPLES

SELECT od.*
FROM [Order Details] od
WHERE od.ProductID IN
(SELECT p.ProductID
FROM Products p WHERE p.Discontinued = 1)

-- Exact same solution using JOIN method
SELECT od.*
FROM [Order Details] od INNER JOIN Products p ON od.ProductID=p.ProductID
WHERE p.Discontinued != 0

-- UNION COMMAND

-- combines employee & supplier Ids into one coloumn
SELECT EmployeeID AS "Employee/Supplier"
FROM Employees
UNION 
SELECT SupplierID
FROM Suppliers
-- UNION ALL includes duplicates, UNION removes duplicates.