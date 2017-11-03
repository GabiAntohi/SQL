-- Exercise:
-- Print the Product names and unit price for all Products in the Seafood category 
-- You will need to access the categoryname in the Categories table.
SeLECT*
FROM Production.Products AS P
SeLECT*
FROM Production.Categories AS C

SELECT	P.productname, P.unitprice, P.productid,
		C.categoryid, C.categoryname, C.description
FROM Production.Products AS P
INNER JOIN Production.Categories AS C
ON P.categoryid = C.categoryid		-- Join the 2 tables based ON this condition
WHERE C.categoryname = N'Seafood';	

-- 2. Using the Customers and Orders tables. Show all orderd place by 'Ray, Mike'. 
--		Show the Orderid, custid, orderdate and contactname.

SELECT*
FROM Sales.Customers AS SC
SELECT	*
FROM Sales.Orders AS SO

SELECT	SO.Orderid, SC.custid, SO.orderdate, SC.contactname
FROM Sales.Customers AS SC
INNER JOIN Sales.Orders AS SO
ON SO.custid = SC.custid		-- Join the 2 tables based ON this condition
WHERE contactname = N'Ray, Mike';

	-- 3. Count how many orders (SELECT COUNT(*)) placed by Employess who work in 
--		Kirkland. You will need the Orders Table joined to the Employees table. 

SELECT	*
FROM Sales.Orders AS SO
SELECT	*
FROM HR.Employees AS E

SELECT COUNT(*) 
 FROM HR.Employees AS E
INNER JOIN Sales.Orders AS SO
ON E.empid = SO.empid		
WHERE E.city = N'Kirkland';

-- 4. There are 3 Shippers in the database. Do all 3 shippers ship orders to Cork?
--		Display the Shipper's company name, order's shipcity and order's shipcountry. 
--		Don't have repeating rows and display the companyname in alphabetical order.
	
SELECT	*
FROM Sales.Shippers AS SH
SELECT	*
FROM Sales.Orders AS SO

SELECT DISTINCT SH.shipperid,  SH.companyname, SO.shipcountry, SO.shipcity
FROM Sales.Shippers AS SH
INNER JOIN Sales.Orders AS SO
ON SH.shipperid = SO.shipperid	
WHERE SO.shipcity = N'Cork'
ORDER BY SH.companyname;

-- 5. Which city are the Suppliers from who supply 'seafood'. Display the Supplier's
--		companyname and city and the categoryname from the Categories table.  You will
--		need to join to the Products table in the middle. 
SeLECT*
FROM Production.Products AS P
SeLECT*
FROM Production.Categories AS C

SELECT DISTINCT S.companyname, S.city
FROM Production.suppliers S
join Production.Products AS P
on S.supplierid= P.supplierid
inner join Production.Categories as c
ON P.categoryid = C.categoryid
WHERE C.categoryname = N'Seafood';	

SELECT * FROM Teachers T
RIGHT JOIN Kids K
ON T.tID = K.kMyTeachersID

SELECT * FROM Teachers T
RIGHT JOIN Kids K
ON K.kMyTeachersID = T.tID

SELECT * FROM kIDS K	
LEFT JOIN tEACHERS T			
ON T.tID = K.kMyTeachersID

-- Exercise --
-- 1. Print out the ProductNames and the largest Qty sold for each product. In the  
-- Orderdetails table, there might be orders for 1, 2, 5 of each product, etc. Distinct 
-- will made sure that it only gets one row where people ordered 1, 2, 5, etc.
-- You will need to select the Productname and Qty from the OrderDetails table, matched 
-- to the productId column in the Products table. 
-- 77 rows in the answer, some rows from the output: 
-- TIP: The subquery can be used to get the maximum qty for each productId (it will need
-- to reference the productId from the outer query). 
SeLECT*
FROM Production.Products AS P
SeLECT*
FROM Sales.OrderDetails AS D

SELECT DISTINCT p.productname,
(
	SELECT max(qty) FROM Sales.OrderDetails o
	where p.productid = o.productid
	
) Quantity
FROM Production.Products AS P
join Sales.OrderDetails D
ON P.productid = D.productid 

-- 2. Get the employees who handled an order on 1/15/2008
-- You will need to get the empid and name from the Employees table, match the empid
-- to the Orders table and filter the orderdate from there
-- 
SELECT	*
FROM Sales.Orders AS SO
SELECT	*
FROM HR.Employees AS E

SELECT DISTINCT E.empid, E.firstname
 FROM HR.Employees AS E
INNER JOIN Sales.Orders AS SO
ON E.empid = SO.empid		
WHERE SO.orderdate='20080115';

--3. Print out Customers and Employees in the same city
SELECT	*
FROM HR.Employees AS E
SELECT	*
FROM Sales.Customers AS c
SELECT	*
FROM Sales.Orders AS SO

SELECT DISTINCT E.empid, E.firstname, e.city
FROM HR.Employees AS E
INNER JOIN Sales.Orders AS SO
ON E.empid = SO.empid
inner Join Sales.Customers AS C
on SO.custid = c.custid
where c.city=e.city;
		
-- 4. The cheapest product in each category

select* from Production.products
select distinct c.categoryid,
(
	SELECT min(unitprice) FROM Production.products c
	where p.categoryid = c.categoryid
)unitprice
from Production.products p,
Production.categories c
where p.categoryid = c.categoryid

-- 5. Show employees who dont' live in the same city as a customer:

-- OUTPUT: 
--firstname  LastName             EmpID       City
------------ -------------------- ----------- ---------------
--Don        Funk                 2           Tacoma
--Yael       Peled                4           Redmond

SELECT	*
FROM HR.Employees AS E


SELECT DISTINCT E.empid, E.firstname, e.city
FROM HR.Employees AS E
WHERE city not IN 
(
	Select DISTINCT city from Sales.Customers AS C	
) 
