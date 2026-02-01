-- Creating a datatabase called Testing --
CREATE DATABASE Testing;
-- Selecting the database to be used --
USE Testing;


-- Q1)  List all suppliers in the UK
-- Selecting all Suplliers whose country is UK
SELECT * 
FROM Supplier 
WHERE Country = 'UK';

-- Q2)  List the first name, last name, and city for all customers. Concatenate the first and last name separated by a space and a comma as a single column
-- Concatenating first name and last name with a space in between, followed by the city, seperated by a comma.
SELECT
CONCAT(FirstName, ' ', LastName, ' , ', City) AS [Full Details]
FROM Customer;

-- Q3) List all customers in Sweden
-- Spooling out all customers whose country is Sweden
SELECT *
FROM Customer
WHERE Country = 'Sweden';

-- Q4) List all suppliers in alphabetical order
-- Selecting all suppliers and arrange them by their name in ascending (alphabetical) order
SELECT *
FROM Supplier
ORDER BY ContactName ASC;

-- Q5) List all suppliers with their products
-- Spooling out all suppliers with their products by joining suppliers table and product table.
	
	--s is alias for Suppliers table
	--p is the alias for Product table
	------------------------- Common Column in tables
	-- s.Id, p.SupplierId

SELECT
	s.ContactName,
	p.ProductName
FROM Supplier s
INNER JOIN [Product] p on s.Id = p.SupplierId;

-- Q6) List all orders with customers information
-- Spooling out all orders with customers information by joining Order table and Customer table

	--o is alias for Order table
	--c is alias for Customer table
		------------------------- Common Column in tables
	-- o.CustomerId, c.Id

SELECT
	o.CustomerID,
	o.OrderDate,
	c.Id,
	c.FirstName,
	c.LastName,
	c.City,
	c.Country,
	c.Phone
FROM [Order] o
INNER JOIN Customer c ON o.CustomerId = c.Id;

-- Q7) List all orders with product name, quantity, and price, sorted by order number
-- List all orders with product name, quantity, and price, sorted by order number by joining Order table, OrderItem table and Product table

	--o is alias for Order table
	--oi is alias for OrderItem table
	--p is alias for Product table
		------------------------- Common Column in tables
	-- o.Id, oi.OrderId, p.SupplierId

SELECT
	o.Id,
	p.ProductName,
	oi.UnitPrice,
	oi.Quantity
FROM [Order] o
INNER JOIN OrderItem oi ON o.Id = oi.OrderId
INNER JOIN [Product] p ON oi.ProductId = p.SupplierId
ORDER BY o.Id;

-- Q8) Using a case statement, list all the availability of products. When 0 then not available, else available
-- Using a case statement to display availability status based on UnitInStock. When 0 then not available, else available

SELECT
	Id,
	ProductName,
	CASE
		WHEN IsDiscontinued = 0 THEN 'Not Available'
		ELSE 'Available'
	END AS Availability
FROM [Product];

-- Q9) Using case statement, list all the suppliers and the language they speak. The language they speak should be their country E.g if UK, then English
-- Using CASE to map country to language spoken

SELECT
	Id,
	CompanyName,
	Country,
	CASE
		WHEN Country = 'UK' THEN 'English'
		WHEN Country = 'USA' THEN 'English'
		WHEN Country = 'Germany' THEN 'German'
		WHEN Country = 'France' THEN 'French'
		WHEN Country = 'Spain' THEN 'Spanish'
		WHEN Country = 'Brazil' THEN 'Spanish'
		WHEN Country = 'Canada' THEN 'English'
		WHEN Country = 'Japan' THEN 'Japanese'
		WHEN Country = 'Australia' THEN 'English'
		WHEN Country = 'Denmark' THEN 'Danish'
		WHEN Country = 'Finland' THEN 'Finnish and Swedish'
		WHEN Country = 'Sweden' THEN 'Swedish'
		WHEN Country = 'Netherlands' THEN 'Dutch'
		WHEN Country = 'Norway' THEN 'Norwegian'
		WHEN Country = 'Italy' THEN 'Italian'
		WHEN Country = 'Singapore' THEN 'English, Mandarin Chinese, Malay and Tamil'
		ELSE 'Other'
	END AS [Language Spoken]
FROM Supplier;

-- Q10) List all products that are packaged in Jars
-- Spooling out all products that are packaged in jars form Product table

SELECT *
FROM [Product]
WHERE Package LIKE '%Jars%';

-- Q11) List procucts name, unitprice and packages for products that starts with Ca
-- Filtring out products where ProductName starts with letter 'Ca'

SELECT
	ProductName,
	UnitPrice,
	Package
FROM [Product]
WHERE ProductName LIKE 'Ca%'

-- Q12) List the number of products for each supplier, sorted high to low
-- Spooling out the number of products for each supplier and sorted from high to low from Supplier table and Product table

	--s is alias for Supplier table
	--p is alias for Product table
		------------------------- Common Column in tables
	-- s.Id, p.SupplierId

SELECT
	s.ContactName,
	COUNT(p.SupplierId) AS [Number of Product]
FROM Supplier s
INNER JOIN [Product] p ON s.Id = p.SupplierId
GROUP BY s.ContactName
ORDER BY [Number of Product] DESC;

-- Q13) List the number of customers in each country.
-- Listing from Customer table the number of customers in each Country

SELECT
	Country,
	COUNT(Id) AS [Number of Customer]
FROM Customer
GROUP BY Country;

-- Q14) List the number of customers in each country, sorted high to low.
-- Listing from Customer table the number of customers in each Country sorted from high to low

SELECT
	Country,
	COUNT(Id) AS [Number of Customer]
FROM Customer
GROUP BY Country
ORDER BY [Number of Customer] DESC;

-- Q15 List the total order amount for each customer, sorted high to low.
-- Listing the total order amount for each customer from Order table, OrderItem table and Customer table

	--o is alias for Order table
	--oi is alias for OrderItem table
	--c is alias for Customer table
		------------------------- Common Column in tables
	-- o.CustomerId, oi.OrderId, c.Id

SELECT
	c.Id,
	c.FirstName + ' ' + c.LastName AS [Customer Name],
	SUM(oi.Quantity * oi.UnitPrice) AS [Total Order Amount]
FROM Customer c
INNER JOIN [Order] o ON c.Id = o.CustomerId
INNER JOIN OrderItem oi ON o.CustomerId = oi.OrderId
GROUP BY c.Id, c.FirstName, c.LastName
ORDER BY [Total Order Amount] DESC;

-- Q16) List all countries with more than 2 suppliers
-- Listing all countries with more than two (2) suppliers by grouping countries and filtering out those with more than 2 suppliers

SELECT
	Country,
	COUNT(Id) AS [Number of Suppliers]
FROM Supplier
GROUP BY Country
HAVING COUNT(Id) > 2;

-- Q17) List the number of customers in each country. Only include countries with more than 10 customers
-- Counting customers by country, only including countries with more than 10 customers

SELECT
	Country,
	COUNT(Id) AS [Number of Customers]
FROM Customer
GROUP BY Country
HAVING COUNT(Id) > 10;

-- Q18) List the number of customers in each country, except the USA, sorted high to low. Only include countries with 9 or more customers
-- Excluding USA, Listing countries with 9 or more customers, and sorted in descending order

SELECT
	Country,
	COUNT(Id) AS [Number of Customers]
FROM Customer
WHERE Country <> 'USA'
GROUP BY Country
HAVING COUNT(Id) > 10
ORDER BY [Number of Customers] DESC;

-- Q19) List customer with average orders between $1000 and $1200
-- Calculating  average order amount per customer, filtering out for amounts between $1000 and $1200 using Customer table, Order table and OderItem table

	--oi is alias for OrderItem table
	--c is alias for Customer table
		------------------------- Common Column in tables
	-- oi.OrderId, c.Id

SELECT
	c.Id,
	CONCAT(c.FirstName, ' ', c.LastName) AS [Customer Name],
	AVG(oi.UnitPrice * oi.Quantity) AS [Average Order Amount]
FROM Customer c
INNER JOIN [Order] o ON c.Id = o.CustomerId
INNER JOIN OrderItem oi ON o.CustomerId = oi.OrderId
--Grouping by customer details
GROUP BY c.Id, c.FirstName, c.LastName
-- Using HAVING to filter based on average order amount
HAVING AVG(oi.UnitPrice * oi.Quantity) BETWEEN 1000 AND 1200;

-- And this shows that theirs no customer with average order between 1000 and 1200

-- Q20) Get the number of orders and total amount sold between Jan 1, 2013 and Jan 31, 2013
-- Counting order and summing total amount for order within Jan 1, 2013 and Jan 31, 2013

SELECT
	COUNT(o.Id) AS [Total Orders],
	SUM(oi.Quantity * oi.UnitPrice) AS [Total Amount Sold]
FROM [Order] o
INNER JOIN OrderItem oi ON o.Id = oi.OrderId
WHERE o.OrderDate BETWEEN '2013-01-01' AND '2013-01-31';

CREATE INDEX idx_Customer_Id ON Customer(Id);
CREATE INDEX idx_Order_Id ON [Order](Id);
CREATE INDEX idx_OrderItem_Id ON Customer(Id);


-- Key Insights

[Q1 This Shows that there are only 2 suppliers from UK.
 Q2 This Shows we have 91 Customers.
 Q3 There are only 2 Customers from Sweden.
 Q8 This shows that Id 53,42,28,29,24,17,9 and 5 Product Name are available.
 Q10 Shows that 8 out of all Product are packaged in jars.
 Q11 Also out of all the Products only 2 starts with alphabet 'Ca'.
 Q12 This shows that Supplier Ian Deving and Martin Bein has the highest number of product 5 followed by Peter Wilson and Shelley Burke has 4 while Sven Peterson, Marie Delemare and Carlos Diaz has the lowest number of product with 1 each.
 Q14 Shows that USA has the highest number of customers with 13 and France and Germany both has 11 while Norway, Poland, Ireland all have the lowes cutomer with 1 each.
 Q15 Shows that Roland Mendel with Id 20 has the highest Total Order Amount 120,930.00, Christina Berglund with Id 5 has the second highest 67,140.00 while Dominique Perrier with Id 74 Has the lowest Total Order Amount of 576.00.
 Q16 Shows that France, Germany and USA has 3,3 and 4 number of suppliers respectively.
 Q19 Shows that there is no Customer with Average Order Amount between 1000 to 1200.]