# SQL formatter

https://www.freeformatter.com/sql-formatter.html#ad-output

# table data types

> NUMERIC TYPES:

INT, SMALLINT, TINYINT, MEDIUMINT,
BIGINT, DECIMAL, NUMERIC, FLOAT,
DOUBLE, BIT

> STRING TYPES:

CHAR, VARCHAR(n-length), BINARY, VARBINARY,
BLOB, TINYBLOB, MEDIUMBLOB, LONGBLOB,
TEXT, TINYTEXT, MEDIUMTEXT, LONGTEXT,
ENUM

> DATE TYPES:

DATE, DATETIME, TIMESTAMP, TIME,
YEAR

# SQL aggregate functions

> comment out code

highlight target code and on Mac press: 

CMD + / 

> COUNT will tally <column_name> entries

example will count all enteries from book database

by default COUNT does not filter for unique values, you need DISTINCT to return only rows that have BOTH a unique author_fname and author_lname

```

SELECT COUNT(DISTINCT author_fname, author_lname)
FROM books;

```

> GROUP BY aggregates identical data into single rows

**a common technique is to use GROUP BY with COUNT**

the example will COUNT how many books each author has written via COUNT(*) 

COUNT(*) will count how many rows are grouped under the respective author

```

SELECT author_lname, COUNT(*)
FROM books
	GROUP BY author_lname;

```

**another common use is to use GROUP BY to calculate average**

```



```

> MIN and MAX to find minimum and maximum respectively in a table

```

SELECT MIN(<column_name>)
FROM <database_name>;

SELECT MAX(<column_name>)
FROM <database_name>;

```

**both methods below provide a solution to making sure MIN/MAX query is aligning correctly with respective column.**

**the 1st approach and superior method in terms of performance**

```

SELECT
   * 
FROM
   books 
ORDER BY
   pages ASC LIMIT 1;

```

**The 2nd approach is to use a subquery with an inner SELECT executing first meaning the sequence executes starts in the middle and works it's way out**

**the issue with the subquery approach below is that you are running to seperate SELECT querries which would be an issue in terms of performance for large datasets**

```

SELECT
   title, pages
FROM
   books
WHERE
   pages =
   (
      SELECT
         MAX(pages)
      FROM
         books
   )
;

```

> MIN & MAX with GROUP BY

**ex) find the year each author published their first book**

```

SELECT
   author_fname,
   author_lname,
   MIN(released_year)
FROM
   books
GROUP BY
   author_lname,
   author_fname;

```

**ex) find the longest page count for each author**

```

SELECT
   author_fname,
   author_lname,
   MAX(pages) as 'MAX pages' 
FROM
   books 
GROUP BY
   author_fname,
   author_lname;

```

**ex) find the longest page count for each author using ALIASES and CONCAT**

```

SELECT
   CONCAT_WS(' ', author_fname, author_lname) AS 'author',
	 MAX(pages) AS 'longest book'
FROM
   books
GROUP BY
   author_lname,
   author_fname;

```

> SUM & GROUP BY adds all the subcategory data together


```

SELECT
   CONCAT(author_fname, ' ', author_lname, ' has written a total of ', SUM(pages), ' pages') AS 'author',
   SUM(pages) AS 'sum' 
FROM
   books 
GROUP BY
   author_fname,
   author_lname 
ORDER BY
   2 DESC;

```

