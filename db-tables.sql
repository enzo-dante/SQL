"""
    SQL formatter

        https://www.dpriver.com/pp/sqlformat.htm

    NUMERIC TYPES:

        INT, SMALLINT, TINYINT, MEDIUMINT, BIGINT

        DECIMAL(total_num_digits, digits_after_decimal),
            for accounting, use DECIMAL() as default

        NUMERIC

        FLOAT

        DOUBLE

        BIT

    STRING TYPES:

        CHAR

        VARCHAR(n-length)

        BINARY

        VARBINARY

        BLOB, TINYBLOB, MEDIUMBLOB, LONGBLOB

        TEXT, TINYTEXT, MEDIUMTEXT, LONGTEXT

        ENUM

    DATE TYPES:

        DATETIME = DATE and TIME

        DATE = 'YYYY-MM-DD' format

        NOW() = give current date time

        TIME = 'HH:MM:SS'

        CURDATE() = give current date

        CURTIME() = give current time

        TIMESTAMP = only works in range 2038-1970

        YEAR

    mySQL date and time functions

        https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-format
"""

-- ! SQL vs mySQL

--      SQL is a query language

--      MySQL is a relational database that uses SQL to query a database
--          databases hold data tables: a collection of columns (headers) and rows (data)

-- ! SQL Rules

--      when creating a db, use a plural name

--      always use a ";" to end a command line 

-- ! db transactions integrity

--      database transactions must be ACID-compliant

--      ? Atomicity 
--          if a series of SQL statements change a db, either all of them are committed or none of them are committed

--      ? Consistency
--          before and after a transaction, the database is in a valid functional state

--      ? Isolation
--          until the changes are committed, the changes won't be visible to other connections: transactions cannot depend on each other

--      ? Durability
--          once the changes performed by a transaction are committed to the database, they are permanent. if a db crashes and rebooted the transactions are still there once it comes back up.

-- ! CREATE DATABASE 

--      create a new title database

CREATE DATABASE book_shop;

-- ! SHOW DATABASES

--      get a list of current databases

SHOW DATABASES;

-- ! USE 

--      identify which database to use

USE book_shop;

-- ! SELECT database();

--      tell currently used database

SELECT database();

-- ! CREATE TABLE IF NOT EXISTS

--      instantiate a table in easy to read multi-line composition

CREATE TABLE IF NOT EXISTS people(
    first_name VARCHAR(20),
    age INT
);

-- ! SHOW TABLES 

--      when in target db, show tables in current db

SHOW TABLES;

-- ! DESC + table 

--      when in target db, describe/show column structure from target table

DESC people;

SHOW COLUMNS FROM people;

-- ! DROP TABLE IF EXISTS

--      first, validate in target db, remove target table

SELECT database();

DROP TABLE IF EXISTS people;

-- ! DROP DATABASE

--      first, validate current database & data with SELECT, then drop db 

SELECT database();

SHOW TABLES; 

DROP DATABASE book_shop;

-- ! INSERT INTO table 

--      in a pre-existing table, each value has to correspond to the column data type

--      order of column arguments has to match value arguments

INSERT INTO people(first_name, age)
VALUES ("Enzo", 20), ("Gary", 45);

-- ? to insert a string (VARCHAR) value that contains quotations: 

-- * escape the quotes with a backslash:

--      "This text has \"quotes\" in it" or 'This text has \'quotes\' in it'

-- * alternate single and double quotes:

--      "This text has 'quotes' in it" or 'This text has "quotes" in it'

-- ! SELECT

--      select the data for viewing in a table when in a target db

SELECT * FROM people;

-- ! WARNINGS

--      when encountering an error instead of a warning

SHOW WARNINGS;

-- ! CREATE TABLE + NOT NULL

--      to enforce an inserting column value is NOT NULL when creating a table 

--      NULL = unknown value NOT zero 

CREATE TABLE cats(
    name VARCHAR(20) NOT NULL,
    age INT NOT NULL
);

-- ! CREATE TABLE + DEFAULT 

--      to set a default value, set DEFAULT and value when creating a table

CREATE TABLE cats(
    name VARCHAR(20) DEFAULT "unnamed",
    age INT DEFAULT 1
);

-- ! CREATE TABLE + DEFAULT + NOT NULL

--      using both DEFAULT + NOT NULL is NOT redundant because this prevents the user from manually inserting a NULL value

-- * ex) would insert a NULL value:

INSERT INTO cats(name, age)
VALUES("Hero", NULL);

-- * ex) PREVENT a NULL value and have a default value when creating a table

CREATE TABLE shows(
    title VARCHAR(20) NOT NULL DEFAULT "missing",
    genre VARCHAR(20) NOT NULL DEFAULT "NOT PROVIDED"
);

-- below would return an ERROR 

INSERT INTO shows(name, age)
VALUES("Breaking Bad", NULL);