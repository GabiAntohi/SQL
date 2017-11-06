--Exercises, chapter 5
--ex 1 aggregate info about customer orders

SELECT C.custid, c.city, COUNT(*) as numorders
FROM Sales.Customers C
INNER JOIN Sales.Orders O
ON C.custid = O.custid
WHERE C.country = N'Spain'
GROUP BY C.custid, C.city;


--ex 2 define multiple grouping sets

SELECT ISNULL (CONVERT(varchar(10), c.custid), 'all cust') as 'custid', ISNULL (CONVERT(varchar(10), c.city), 'all cities') as 'city', COUNT(*) as numorders
FROM Sales.Customers C
INNER JOIN Sales.Orders O
ON C.custid = O.custid
WHERE C.country = N'Spain'
GROUP BY GROUPING SETS ((C.custid, C.city), ())
ORDER BY GROUPING(C.custid);

-- ex 1, p 169/  pivoting data by using a table expression

WITH PivotData AS 
( 
SELECT YEAR (orderdate) AS orderyear, shipperid, shippeddate 
FROM Sales.Orders
)
SELECT orderyear, [1], [2], [3]
FROM PivotData
PIVOT (MAX(shippeddate)FOR shipperid IN ([1], [2], [3])) AS p
ORDER BY orderyear;

-- ex 2 pivot data and compute counts

WITH PivotData AS 
( 
SELECT
 custid,
 shipperid,
 1 AS aggcol
FROM Sales.Orders
)
SELECT custid, [1], [2], [3]
FROM PivotData
PIVOT (COUNT(aggcol) FOR shipperid IN ([1], [2], [3])) AS p
ORDER BY custid;

-- ex 1, page 180/ using window functions

SELECT custid, orderid, orderdate, val,
AVG(val)
OVER (PARTITION by custid
ORDER by orderdate, orderid
ROWS BETWEEN 2 PRECEDING 
             AND CURRENT ROW) AS movingavg
FROM Sales.OrderValues;

-- ex 2 use window ranking and offset functions
 
 WITH C AS 
 (
 SELECT shipperid, orderid, freight, ROW_NUMBER() over (PARTITION BY shipperid
 ORDER BY freight desc, orderid) AS rownum FROM Sales.Orders
 )
 SELECT shipperid, orderid, freight
 FROM c 
 WHERE rownum <=3
 ORDER BY shipperid, rownum; 
 SELECT custid, orderid, orderdate, val,
val-LAG(val) OVER (PARTITION BY custid
                     ORDER BY orderdate, orderid) AS diffprev,
val - LEAD(val) OVER (PARTITION BY custid
                     ORDER BY orderdate, orderid) AS diffnext
					 FROM Sales.OrderValues;





 )

