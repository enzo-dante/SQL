# SQL vs mySQL

*SQL is a query language, whereas MySQL is a relational database that uses SQL to query a database

a database, like a MySQL database, is just a bunch of tables aka a relational database

databases hold data tables: a collection of columns (headers) and rows (data)

# database table data types

*when creating tables, admin must specify what type of data is allowed in that column

INTs, FLOATs, and BIGINTs are most common numeric data type

VARCHAR, not CHAR which requires a fixed length, is most common string data type

> NUMERIC TYPES:

**for accounting, use DECIMAL() as default**

INT, SMALLINT, TINYINT, MEDIUMINT,
BIGINT,
DECIMAL(total_num_digits, digits_after_decimal),
NUMERIC, FLOAT,
DOUBLE, BIT

> STRING TYPES:

CHAR, VARCHAR(n-length), BINARY, VARBINARY,
BLOB, TINYBLOB, MEDIUMBLOB, LONGBLOB,
TEXT, TINYTEXT, MEDIUMTEXT, LONGTEXT,
ENUM

> DATE TYPES:

DATE = 'YYYY-MM-DD' format,
DATETIME = DATE + TIME,
TIME = 'HH:MM:SS',
CURDATE() = give current date,
CURTIME() = give current time,
NOW() = give current date time,
TIMESTAMP,
YEAR

# general rules

*the sql commands don't have to be capatalized, but it helps distinguish

always end the command line with a semicolon or the code won't execute

when creating a db, use a plural name


