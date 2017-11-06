--exercises page 54
--1
SELECT empid AS [ID], firstname + lastname AS [Last Name],
YEAR(birthdate) AS [Birth Year]
FROM HR.Employees;
--2
SELECT EOMONTH(SYSDATETIME()) AS [End of month]
SELECT DATENAME(YEAR, GETDATE()) AS [Year], 12 AS [Month], 31 AS [Day]
SELECT CONCAT(DATENAME(YEAR, GETDATE()), '-', 12, '-',  31) AS [End of year]
SELECT DATEFROMPARTS(YEAR(SYSDATETIME()), 12, 31) AS [End of year]

SELECT productid, CONCAT(REPLICATE('0', 8), 
case 
     when DATALENGTH(productid) = 1 then Concat('0', productid)
     when DATALENGTH(productid) = 2 then productid
		 else productid 
	end 	
)  AS PRODID 
FROM Production.Products
SELECT productid, FORMAT(productid, 'd10') AS PRODID
FROM Production.Products


--1
SELECT *
FROM Production.Products

SELECT productid, productname, supplierid, categoryid, unitprice,
case 
     when unitprice < 10 then 'cheap'
     when unitprice < 21 then 'reasonable'
	 when unitprice < 55 then 'dear'
	 else 'very expensive'
	end AS [appreciation]
FROM Production.Products
--2
SELECT empid, firstname, lastname, city,
IIF(city= 'London', 'fired', 'safe') as 'STATUS'
FROM HR.Employees;
--3
SELECT orderid, CHOOSE(shipperid, 'Shipper One','Shipper Two','Shipper Three') AS [Shipper], shipcity, shipcountry 
FROM Sales.Orders

--chapter 3
SELECT *
FROM Sales.Customers
WHERE country = 'Ireland'

 -- = EXACT MATCH
 -- LIKE - PUT IN WILDCARDS
 -- <> - NOT EQUALS
SELECT *
FROM Sales.Customers
WHERE country LIKE 'BR%'


-- Exercises: 
-- 1. From the Orders table, select the orderid, orderdate, custid and empid 
--		for all orders placed in June 2007.

SELECT *
FROM Sales.Orders
select orderid, orderdate, custid, empid from Sales.Orders
where orderdate between '20070601' and '20070630'

-- 2. From the Orders table, select the orderid, orderdate, custid and empid 
--		for all orders placed on the last day of the month.

SELECT DATEADD(MONTH,1,orderdate)- day(DATEADD(MONTH,1,orderdate)), orderid, orderdate, custid, empid from Sales.Orders

-- 3. From the Customers table, display the custid, contactname and contacttitle 
--		of all employees whose name starts with A, B or C.

select custid, contactname, contacttitle from Sales.Customers
where contactname between 'A%' and 'D%'

-- 4. From the OrderDetails table, print all orders with total value (quantity * 
--		unitprice) greater than 10,000. (14 rows)

select * FROM Sales.OrderDetails

select orderid, productid, qty, discount, unitprice FROM Sales.OrderDetails
where (qty*unitprice)>10000

-- 5. Print out all discounted products (the column 'discounted' will be 1).
SELECT orderid, productid, qty, unitprice, discount, 
case 
when discount > 0 then '1'
else '0' 	
end 
as 'yes/no'
FROM Sales.OrderDetails

-- 6. From the Suppliers table, print out the supplierid, comanyname, country
--		and fax but only those who are in France or Germany and have a fax
--		number (i.e. it's not null).  (3 rows).

select * from Production.Suppliers
select supplierid, companyname, country, fax
from Production.Suppliers
WHERE country IN ('France', 'Germany') and fax IS NOT NULL

-- 7. Select the employees who are over 50 years old (4 rows).

select * FROM HR.Employees
select empid, lastname, firstname, title, birthdate, hiredate, address, city, phone
FROM HR.Employees
where DATEDIFF(year, birthdate, GETDATE()) > 50
