# SQL vs mySQL

*SQL is a query language, whereas MySQL is a relational database that uses SQL to query a database

a database, like a MySQL database, is just a bunch of tables aka a relational database

databases hold data tables: a collection of columns (headers) and rows (data)

# database table data types

*when creating tables, admin must specify what type of data is allowed in that column

INTs, FLOATs, and BIGINTs are most common numeric data type

VARCHAR, not CHAR which requires a fixed length, is most common string data type

"sql-format-date-time.md" 228L, 3821B written
# SQL formatter

https://www.freeformatter.com/sql-formatter.html#ad-output

# table data types

> NUMERIC TYPES:

**for accounting, use DECIMAL() as default**

INT, SMALLINT, TINYINT, MEDIUMINT, BIGINT,
DECIMAL(total_num_digits, digits_after_decimal),
NUMERIC,
FLOAT,
DOUBLE,
BIT

> STRING TYPES:

CHAR,
VARCHAR(n-length),
BINARY,
VARBINARY,
BLOB, TINYBLOB, MEDIUMBLOB, LONGBLOB,
TEXT, TINYTEXT, MEDIUMTEXT, LONGTEXT,
ENUM

> DATE TYPES:

DATETIME = DATE and TIME,
DATE = 'YYYY-MM-DD' format,

NOW() = give current date time,
TIME = 'HH:MM:SS',
CURDATE() = give current date,
CURTIME() = give current time,

TIMESTAMP = only works in range 2038-1970,
YEAR

# mySQL Documentation

> mySQL string commands

https://dev.mysql.com/doc/refman/8.0/en/string-functions.html

> mySQL date and time functions

https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-format

# general rules

*the sql commands don't have to be capatalized, but it helps distinguish

always end the command line with a semicolon or the code won't execute

when creating a db, use a plural name


