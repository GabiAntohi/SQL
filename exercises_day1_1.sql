-- select * will select all columns from the Employees table
SELECT * FROM HR.Employees
-- it is better to specify which columns to select from
SELECT empid, lastname, firstname, title, titleofcourtesy, birthdate, hiredate, address, city, region, postalcode, country, phone, mgrid
FROM HR.Employees
-- you cna order by column number - not advised
SELECT empid, lastname, firstname, city 
FROM HR.Employees
ORDER BY city, firstname
-- you can change the column name in the output, known an an Alias, changes header, can leave out AS
SELECT empid AS number, lastname, firstname, city 
FROM HR.Employees
ORDER BY city, firstname

--descending alphabetical order, default is ascending
SELECT empid AS number, lastname, firstname, city 
FROM HR.Employees
ORDER BY city, firstname DESC

-- insert a space into an identifier []
SELECT empid AS [employee number], lastname, firstname, city 
FROM HR.Employees

--chapter2 

SELECT * FROM HR.Employees

SELECT firstname + ' ' + lastname AS [full name], address + ' ' + city + ' '+ ISNULL(region,'') + ' '+ country AS [full address]
FROM HR.Employees


--full name                       full address
------------------------------- ------------------------------------------------------------------------------------------------------------
--Sara Davis                      7890 - 20th Ave. E., Apt. 2A Seattle WA USA
--Don Funk                        9012 W. Capital Way Tacoma WA USA
--Judy Lew                        2345 Moss Bay Blvd. Kirkland WA USA
--Yael Peled                      5678 Old Redmond Rd. Redmond WA USA
--Sven Buck                       8901 Garrett Hill London  UK
--Paul Suurs                      3456 Coventry House, Miner Rd. London  UK
--Russell King                    6789 Edgeham Hollow, Winchester Way London  UK
--Maria Cameron                   4567 - 11th Ave. N.E. Seattle WA USA
--Zoya Dolgopyatova               1234 Houndstooth Rd. London  UK

--(9 row(s) affected)

SELECT E.titleofcourtesy, E.firstname, E.lastname FROM HR.Employees E 
--E is an alias, another name for the Employees table, everything in the select clause can be prefixed with E

