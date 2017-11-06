--ex from page 114, chapter 4
--ex 1 (inner join)
SELECT * FROM Sales.Customers
SELECT C.custid, companyname, address, orderid, orderdate
FROM Sales.Customers C 
INNER JOIN Sales.Orders O 
ON C.custid = O.custid;  
--ex 2.1 (outer join)
SELECT C.custid, companyname, address, orderid, orderdate
FROM Sales.Customers C 
LEFT OUTER JOIN Sales.Orders O 
ON C.custid = O.custid; 
--ex 2.2 (cust without orders)
SELECT C.custid, companyname, address, orderid, orderdate
FROM Sales.Customers C 
LEFT OUTER JOIN Sales.Orders O 
ON C.custid = O.custid 
WHERE O.Orderid IS NULL;
--ex 3 (all customers, orders placed on FEb 2008)
SELECT C.custid, companyname, address, orderid, orderdate
FROM Sales.Customers C 
LEFT OUTER JOIN Sales.Orders O 
ON C.custid = O.custid 
AND o.orderdate >='20080201'
and o.orderdate <'20080301' -- don't use where
--page 132
--ex1 (product with minimum unit price percategory)
select* from Production.products
select distinct c.categoryid,
(
	SELECT min(unitprice) FROM Production.products c
	where p.categoryid = c.categoryid
)unitprice 
from Production.products p,
Production.categories c
where p.categoryid = c.categoryid

SELECT P.categoryid, P.productid, P.productname, p.unitprice
FROM Production.Products P
WHERE p.unitprice = 
(
	SELECT MIN(unitprice) FROM Production.Products PR
	WHERE PR.categoryid = P.categoryid
)


WITH CatMin AS
(
SELECT categoryid, MIN(unitprice) AS mn
FROM Production.Products
GROUP BY categoryid
)
SELECT p.categoryid, P.productid, P.productname, P.unitprice
FROM Production.Products AS P
INNER JOIN CatMin as M
ON P.categoryid = M.categoryid AND P.unitprice = M.mn;
--ex 2 (return n products with lowest unit price per supplier)
--function
IF OBJECT_ID('Production.GetTopProducts', 'IF') IS NOT NULL DROP FUNCTION Production.GetTopProducts;
GO
CREATE FUNCTION Production.GetTopProducts(@Supplierid AS INT, @n AS BIGINT)
RETURNS TABLE
AS
RETURN 
SELECT productid, productname, unitprice
FROM Production.Products
WHERE supplierid = @supplierid
ORDER BY unitprice, productid
OFFSET 0 ROWS FETCH FIRST @n ROWS ONLY;
GO 
SELECT * FROM  Production.GetTopProducts(1,2) AS P;
SELECT S.supplierid, S.companyname AS supplier, A.*
FROM Production.Suppliers AS s
CROSS APPLY Production.GetTopProducts(S.supplierid,2)
AS A
WHERE S.country = N'Japan';
SELECT S.supplierid, S.companyname AS supplier, A.*
FROM Production.Suppliers AS S
OUTER APPLY Production.GetTopProducts(S.supplierid, 2) AS A
WHERE s.country = N'Japan';
IF OBJECT_ID ('Production.GetTopProducts', 'IF') IS NOT NULL DROP FUNCTION Production.GetTopProducts
-- page 141
--ex 1 (use the EXCEPT set operator)
SELECT empid
FROM Sales.Orders
WHERE custid = 1

EXCEPT -- does not return duplicate rows

SELECT empid
FROM Sales.Orders
WHERE custid = 2 
--ex 2 (the INTERSECT set operator)
SELECT empid
FROM Sales.Orders
WHERE custid = 1

INTERSECT 

SELECT empid
FROM Sales.Orders
WHERE custid = 2 