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



