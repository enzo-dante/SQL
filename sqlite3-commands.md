# SQL formatter

https://www.dpriver.com/pp/sqlformat.htm

# sqlite3

in terminal, to access if installed, execute:

sqlite3

to exit sqlite3 shell

ctl+d

.quit

> to list out all tables and respective structure (like DESC table), execute:

.schema

> to list out all tables, execute:

.tables

to list out commands need to create current state of db as a transaction, execute:

.dump

to list out headers of columns in sql shell, execute:

.headers on

to clear log, execute:

ctl+ l

to backup current db, execute:

.backup {back_db_name}

to restore db to previous state, execute:

.restore {back_db_name}

# IF NOT EXISTS

when creating a table, you can add a IF NOT EXISTS to the SQL command to prevent errors

# SQLite 3 concat

s1 || s2

ex: 

SELECT 'this is a ' || 'test' # 'this is a test'

# SQLite 3 documentation

https://www.sqlite.org/docs.html

# storage and data types

Each value stored in an SQLite database (or manipulated by the database engine) has one of the following storage classes:

NULL. The value is a NULL value.

INTEGER. The value is a signed integer, stored in 1, 2, 3, 4, 6, or 8 bytes depending on the magnitude of the value.

REAL. The value is a floating point value, stored as an 8-byte IEEE floating point number.

TEXT. The value is a text string, stored using the database encoding (UTF-8, UTF-16BE or UTF-16LE).

BLOB. The value is a blob of data, stored exactly as it was input.

A storage class is more general than a datatype. The INTEGER storage class, for example, includes 6 different integer datatypes of different lengths. This makes a difference on disk. But as soon as INTEGER values are read off of disk and into memory for processing, they are converted to the most general datatype (8-byte signed integer). And so for the most part, "storage class" is indistinguishable from "datatype" and the two terms can be used interchangeably.

Any column in an SQLite version 3 database, except an INTEGER PRIMARY KEY column, may be used to store a value of any storage class.

All values in SQL statements, whether they are literals embedded in SQL statement text or parameters bound to precompiled SQL statements have an implicit storage class. Under circumstances described below, the database engine may convert values between numeric storage classes (INTEGER and REAL) and TEXT during query execution.

# general rules

always end the command line with a semicolon or the code won't execute

when creating a db, use a plural name

# SQLite transactions

all committed changes to a database are known as a transaction

# SQLite transaction commands 

BEGIN TRANSACTION - manually start a transaction

END TRANSACTION - ending a transaction automatically commits any changes to a db

COMMIT - commit changes to a db, also ending it

ROLLBACK - this rollsback any uncommitted changes and ends the transaction since the last commit

# SQL commands

> Comment Out Code

highlight target code and on Mac press: 

CMD + / 

> COLLATE {arg}

BINARY - Compares string data using memcmp(), regardless of text encoding.

NOCASE - It is almost same as binary, except the 26 upper case characters of ASCII are folded to their lower case equivalents before the comparison is performed.

RTRIM - The same as binary, except that trailing space characters, are ignored.

> CREATE DATABASE <plural_name>
>
> the sql commands don't have to be capatalized, but it helps distinguish

CREATE DATABASE <database_name>;

SHOW DATABASES;

> when dropping a db, check with SELECT that data is not essential
>
> if you delete a database use you are currently using, the SELECT database(); command will return NULL

DROP DATABASE <database_name>;

> USE = tells mysql which database we want to work with

USE <database_name>; 

> SELECT = tell currently used database

SELECT database();

> CREATE TABLE IF NOT EXISTS = instantiate a table in easy to read multi-line composition

CREATE TABLE IF NOT EXISTS <tablename_in_plural_form>
	(
		column_name data_type, 
		column_name data_type
	);

ex:

CREATE TABLE IF NOT EXISTS pastries
    (
        name VARCHAR(50), 
        quantity INT
    );

ex 2:

'note that SIZE is a reserved SQL keyword so do not use it'


CREATE TABLE shirts(
    shirt_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    article VARCHAR(100),
    color VARCHAR(100),
    shirt_size VARCHAR(1),
    last_worn INT NOT NULL DEFAULT 0
);

> SHOW TABLES = when in target db, show tables in current db

SHOW TABLES;

> DESC = when in target db, describe/show column structure from target table

DESC <table_name>;

SHOW COLUMNS FROM <table_name>;

> when in target db, remove target table

DROP TABLE IF EXISTS <table_name>;

> insert data into a table in a target db

__each value has to correspond to the column data type__

__order of column arguments has to match value arguments__

INSERT INTO <table_name>
	(
		column_name,
		column_name
	)
VALUES
	(
		value,
		value
	);

> INSERT INTO = insert multiple values into a table in a target db

INSERT INTO <table_name>
	(
		column_name,
		column_name
	)
VALUES
	(value, value),
  (value, value);

ex:

INSERT INTO verbs(
        name,
        age
    )
    VALUES
        ('Peanut', 4),
        ('Butter', 10),
        ('Jelly', 7);

> SELECT = select the data for viewing in a table when in a target db

SELECT * FROM <table_name>;

> If you're wondering how to insert a string (VARCHAR) value that contains quotations, then here's how.

__escape the quotes with a backslash:__
"This text has \"quotes\" in it" or 'This text has \'quotes\' in it'

__alternate single and double quotes:__
"This text has 'quotes' in it" or 'This text has "quotes" in it'

> mysql warnings

__if you encounter an error instead of a warning, the solution is to run the following command in your mysql shell__

__if a VARCHAR(5) column, has a string that exceeds 5 characters__

set sql_mode='';

SHOW WARNINGS;

> null means value is unknown

__null DOES NOT mean zero__

__to enforce NOT NULL when creating a table, use NOT NULL__

ex:

CREATE TABLE cats2
	(
		name VARCHAR(100) NOT NULL,
		age INT NOT NULL
	);

> default values 

__to set a default value, set DEFAULT and value when creating a table__

ex:

CREATE TABLE cats3
	(
		name VARCHAR(100) DEFAULT 'unnamed',
		age INT DEFAULT 99
	);

> using both DEFAULT VALUES and NOT NULL

__This is not redundant because this prevents the user from manually inserting a NULL value__

__Below ex would insert a NULL value:__

INSERT INTO cats3(name, age) VALUES('Montana', NULL);

__below ex would prevent a NULL value and have a default value when creating a table:__


CREATE TABLE cats5
	(
		name VARCHAR(4) NOT NULL DEFAULT 'unnamed',
		age INT NOT NULL DEFAULT 99
	);

__below ex would return an ERROR:__

INSERT INTO cats5
    (
        name,
        age
    )
    VALUES
    ('Cali', NULL);

> primary Keys are used as unique IDs for organizing data in a table

__when DESC a table, the key column would list PRI instead of empty__

__if you attempt to add data that has a duplicate primary value, will return ERROR__

ex:

CREATE TABLE cats6
	(
		cat_id INT NOT NULL PRIMARY KEY,
		name VARCHAR(100),
		age INT,
	);

INSERT INTO cats6
    (cat_id, name, age)
    VALUES
    (1, 'fred', 33);

> AUTO_INCREMENT PRIMARY KEY removes manual input for Primary Keys

ex:

CREATE TABLE cats7
	(
		cat_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
		name VARCHAR(100),
		age INT,
	);

> CRUD = create, read, update, delete

__read = SELECT and * = return all columns__

ex:

SELECT * FROM cats;

__can target single or multiple columns with a comma seperated list__

__list order matters because it determine presentation__

ex:

SELECT cat_id, name FROM cats;

ex:

SELECT name, age FROM cats;

> WHERE = specific filtering commands

__below selects all columns from cats table where age is 4__

SELECT * FROM cats WHERE age=4;

__below selects all columns from cats table where name is Egg__
- case insensitive

SELECT * FROM cats WHERE name='Egg';

__below allows you to compare columns__

SELECT cat_id, age FROM cats WHERE cat_id=age;

> WHERE <column_name> != <variable> 

__filters WHERE query that does not equal variable__

SELECT title FROM books WHERE released_year != 2017;
 
SELECT title, author_lname FROM books WHERE author_lname != 'Harris';


> CAST() = convert 1 data type to another data type

SELECT CAST('2017-05-02' AS DATETIME);

> AS = specify alias for how data is presented from query

ex:

SELECT cat_id AS id, name FROM cats;

ex:

SELECT name AS 'cat_name', breed AS 'type_of_cat' FROM cats;

> UPDATE = change existing data

__process should be use SELECT to target desired data set before using UPDATE__

ex: 

SELECT * FROM cats
	WHERE breed='Tabby';

UPDATE cats 
	SET breed='Shorthair'
		WHERE breed='Tabby';

ex:

SELECT * FROM cats
	WHERE color='off white';

UPDATE shirts
    SET shirt_size='XS', color='not white'
    WHERE color='off white';

> DELETE = remove existing data

__process should be use SELECT to target desired data set before using DELETE__

__when data is deleted and there is an AUTO_INCREMENT PRIMARY KEY, the keys don't shift to compensate for the deleted dataset__

ex:

SELECT * FROM cats
    WHERE name='Egg';

DELETE FROM cats
    WHERE name='Egg';

SELECT * FROM cats;

__delete all enteries in table, but table shell remains__

ex:

DELETE FROM <table_name>

> SELECT DISTINCT only returns unique column values 

SELECT DISTINCT <column_name> FROM <table_name>;

__the examples below produces the result of unique rows__

SELECT DISTINCT
    CONCAT_WS(
        ' ',
        author_fname,
        author_lname
    ) AS 'authors full name'
FROM books;

SELECT DISTINCT
    author_fname,
    author_lname
FROM books;

> ORDER BY is used to sort results

__ascending by default__

SELECT 
    <column_name>
FROM <database_name>
    ORDER BY <column_name>;

__using a number with ORDER BY is a shortcut to refer to a specific column__

SELECT
    title
        AS 'column 1',
    author_fname
        AS 'column 2',
    author_lname
        AS 'column 3'
FROM books
    ORDER BY 2;

__you can run an initial sort, and then a subsequent sort on the initially sorted return set by adding multiple <column_names> in a comma seperated list__

SELECT
    title
        AS 'column 1',
    author_fname
        AS 'column 2',
    author_lname
        AS 'column 3'
FROM books
    ORDER BY 2, 3;


__the example below will select all distinct last names from books and then ORDER BY descending order__

SELECT DISTINCT
    author_lname
FROM books
    ORDER BY author_lname DESC;

__the <column_name> and the ORDER BY <column_name> don't have to match__

SELECT DISTINCT
    title,
    pages
FROM books
    ORDER BY released_year;


> LIMIT specifies a number for how many results selected

__the LIMIT and ORDER BY pair are frequently used together__

ex:

SELECT
    title,
    released_year
FROM books
    ORDER BY released_year DESC
    LIMIT 5;

__for pagination, you could use LIMIT to specify start point and how many to count__

the example below shows the comparison:

SELECT
    title,
    released_year
FROM books
    ORDER BY 2 DESC
    LIMIT 5;

SELECT
    title,
    released_year
FROM books
    ORDER BY released_year DESC
    LIMIT 4, 5;

# CREATE VIEW {view_name} AS {query}= a view is a named query stored in the database catalog.

> MySQL creates the view and stores it in the database.

CREATE VIEW customerPayments
AS
SELECT
    customerName,
    checkNumber,
    paymentDate,
    amount
FROM
    customers
INNER JOIN
    payments USING (customerNumber);

> Now, you can reference the view as a table in SQL statements. For example, you can query data from the customerPayments view using the SELECT statement:

SELECT * FROM customerPayments;

# DROP VIEW {view_name} = removes view but not refereced data
