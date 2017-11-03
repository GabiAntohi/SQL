--ex1, page 34

SELECT shipperid, companyname, phone
FROM Sales.Shippers;

SELECT S.shipperid, companyname, phone
FROM Sales.Shippers AS S;

--ex2, page 35

SELECT S.shipperid, companyname, phone AS [phone number]
FROM Sales.Shippers AS S;

SELECT E.firstname AS [First Name],  E.lastname AS [Last Name],  CONVERT(varchar, E.hiredate, 103) AS [Start Date]
FROM HR.Employees AS E
ORDER BY hiredate; 

select GETDATE()
select DATEDIFF(day, '19840210', GETDATE())
select DATEDIFF(day, '20171225', GETDATE())
select DATEDIFF(day, GETDATE(),'20180223')
--date part number
select DATEPART(DAY, GETDATE())	
--string
select DATENAME(YEAR, GETDATE()) + ' good year'

 
SELECT empid, country, region, city,
country +  ', ' + region, + ' ' + city AS fulladdress
FROM HR.Employees;

SELECT empid, country, region, city,
country + COALESCE( ', ' + region, '') + ', ' + city AS fulladdress
FROM HR.Employees;

--DATE AND TIME
select 'Today is '+ DATENAME(MONTH, GETDATE()) + ' ' + DATENAME(DAY, GETDATE()) + ', ' + DATENAME(YEAR, GETDATE()) + ' and the time is ' + DATENAME(HOUR, SYSDATETIME()) +':'+ DATENAME(MINUTE, SYSDATETIME()) +':'+ DATENAME(SECOND, SYSDATETIME());
select CONCAT('Today is '+ DATENAME(MONTH, GETDATE()), + ', ' + DATENAME(DAY, GETDATE()), + ', ' + DATENAME(YEAR, GETDATE()) + ' and the time is ' + DATENAME(HOUR, SYSDATETIME()) +':'+ DATENAME(MINUTE, SYSDATETIME()) +':'+ DATENAME(SECOND, SYSDATETIME()));
SELECT CONCAT('Today is ', DATENAME(MONTH, GETDATE()), ' ', 
			  DATEPART(DAY, GETDATE()), ', and the time is: ',
			  CONVERT(varchar, GETDATE(), 108))  -- 108 = hh:mm:ss 
AS [Date and Time] 

select * FROM Sales.Customers 
select  STUFF (contactname, 1, 50, SUBSTRING (contactname, 1, 1))
FROM Sales.Customers 
select  SUBSTRING(STUFF(contactname, CHARINDEX(',', contactname), 50, SUBSTRING (contactname,  CHARINDEX(' ', contactname), 2)), CHARINDEX(',', contactname), DATALENGTH(contactname) )
FROM Sales.Customers 

--mine

select  STUFF (contactname, 1, 50, SUBSTRING (contactname, 1, 1)) + SUBSTRING(STUFF(contactname, CHARINDEX(',', contactname), 50, 
SUBSTRING (contactname,  CHARINDEX(' ', contactname), 2)), CHARINDEX(',', contactname), DATALENGTH(contactname) )
FROM Sales.Customers 

--Sandra's

SELECT contactname, 
	   CONCAT(LEFT(contactname, 1),					-- first initial
              SUBSTRING(contactname, CHARINDEX(',', contactname) + 2, 1)) -- second initial
AS Initials
FROM Sales.Customers 

-- swap
select  contactname, SUBSTRING(STUFF(contactname, CHARINDEX(',', contactname), 50, 
SUBSTRING (contactname,  CHARINDEX(' ', contactname), 2)), CHARINDEX(',', contactname), DATALENGTH(contactname) ) + STUFF (contactname, 1, 50, SUBSTRING (contactname, 1, 1))
FROM Sales.Customers 

--display in different columns
select  LEFT(contactname, CHARINDEX(', ', contactname)-1) as [first name]
FROM Sales.Customers
select  SUBSTRING(contactname, CHARINDEX(', ', contactname)+1, DATALENGTH(contactname) ) as [last name]
FROM Sales.Customers 
--done
select  LEFT(contactname, CHARINDEX(', ', contactname)-1) as [first name], SUBSTRING(contactname, CHARINDEX(', ', contactname)+1, DATALENGTH(contactname) ) as [last name]
FROM Sales.Customers
ORDER BY [first name], [last name]

--SANDRA'S
SELECT 
LTRIM(SUBSTRING(contactname, CHARINDEX(',', contactname) + 2, 
          DATALENGTH(contactname)))							AS firstname,
SUBSTRING(contactname, 1, CHARINDEX(',', contactname) - 1)	AS lastname
FROM Sales.Customers
ORDER BY firstname, lastname

SELECT *
FROM HR.Employees;
SELECT lastname, firstname, 
case titleofcourtesy
		when 'Ms.' then 'Miss'
		when 'Dr.' then 'Doctor'
		when 'Mr.' then 'Mister'
		when 'Mrs.' then 'Misses'
		else titleofcourtesy 
	end 
	as 'Long Title'		-- column name
	



FROM HR.Employees;