(1)
SELECT CompanyName AS Société, ContactName AS Contact, ContactTitle AS Fonction, Phone AS Téléphone 
FROM customers 
WHERE Country = 'France';

(2)
SELECT ProductName,UnitPrice FROM products 
JOIN suppliers ON suppliers.SupplierID = products.SupplierID
WHERE suppliers.SupplierID = 1;

(3)
SELECT CompanyName, count(ProductID) FROM suppliers 
NATURAL JOIN products
WHERE Country = 'France'
GROUP BY CompanyName
ORDER BY CompanyName DESC;

SELECT CompanyName, COUNT(products.SupplierID) FROM suppliers
NATURAL JOIN products
WHERE Country = 'France' 
GROUP BY CompanyName
ORDER BY count(products.SupplierID) DESC;

(4)
SELECT CompanyName, COUNT(CustomerID) FROM customers
NATURAL JOIN orders
WHERE Country = 'France' 
GROUP BY CompanyName
HAVING COUNT(orders.CustomerID) >10;

(5)
SELECT CompanyName, SUM(UnitPrice*Quantity), Country FROM customers
NATURAL JOIN order_details 
NATURAL JOIN orders
GROUP BY CustomerID 
HAVING SUM(UnitPrice*Quantity) >30000 
ORDER BY SUM(UnitPrice*Quantity) DESC; 

(6)
SELECT customers.Country 
FROM ((customers
INNER JOIN orders ON customers.CustomerID = orders.CustomerID)
INNER JOIN order_details ON orders.OrderID = order_details.OrderID)
WHERE order_details.ProductID IN (
    SELECT products.ProductID
    FROM products
    INNER JOIN suppliers ON products.SupplierID = suppliers.SupplierID
    WHERE suppliers.CompanyName = 'Exotic Liquids'
)
GROUP BY customers.Country;

(7) 
SELECT ROUND(SUM((order_details.UnitPrice * order_details.Quantity) - order_details.Discount), 2) 
FROM order_details
INNER JOIN orders ON order_details.OrderID = orders.OrderID
WHERE YEAR(orders.OrderDate) = 1997;

(8)
SELECT MONTH(orders.OrderDate), ROUND(SUM((order_details.UnitPrice * order_details.Quantity) - order_details.Discount), 2) 
FROM order_details
INNER JOIN orders ON order_details.OrderID = orders.OrderID
WHERE YEAR(orders.OrderDate) = 1997
GROUP BY MONTH(orders.OrderDate);

(9)
SELECT orders.OrderDate 
FROM customers
INNER JOIN orders ON customers.CustomerID = orders.CustomerID
WHERE customers.CompanyName = 'Du monde entier' AND DATEDIFF(CURRENT_TIMESTAMP, orders.OrderDate) = (
    SELECT MIN(DATEDIFF(CURRENT_TIMESTAMP, orders.OrderDate))
    FROM customers
    INNER JOIN orders ON customers.CustomerID = orders.CustomerID
    WHERE customers.CompanyName = 'Du monde entier'
);

(10)
SELECT ROUND(AVG(DATEDIFF(ShippedDate, OrderDate))) 
FROM orders;

