# SQL vs mySQL

- SQL is a query language, whereas MySQL is a relational database that uses SQL to query a database

- a database, like a MySQL database, is just a bunch of tables aka a relational database

- databases hold data tables: a collection of columns (headers) and rows (data)

# SQL formatter

https://www.dpriver.com/pp/sqlformat.htm

# table data types

> NUMERIC TYPES:
>
> for accounting, use DECIMAL() as default
> INTs, FLOATs, and BIGINTs are most common numeric data type

INT, SMALLINT, TINYINT, MEDIUMINT, BIGINT,

DECIMAL(total_num_digits, digits_after_decimal),

NUMERIC,
FLOAT,
DOUBLE,
BIT

> STRING TYPES:
>
> VARCHAR, not CHAR which requires a fixed length, is most common string data type

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

# general rules

always end the command line with a semicolon or the code won't execute

when creating a db, use a plural name

# mySQL Documentation

> mySQL string commands

https://dev.mysql.com/doc/refman/8.0/en/string-functions.html

> mySQL date and time functions

https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-format

# db transactions integrity

database transactions must be ACID-compliant

Atomicity = if a series of SQL statements change a db, either all of them are committed or none of them are committed

Consistency = before and after a transaction, the database is in a valid functional state

Isolation = until the changes are commited, the changes won't be visible to other connections: transactions cannot depend on each other

Durability = once the changes performed by a transaction are committed to the database, they are permanent. if a db crashes and rebooted the transactions are still there once it comes back up.

# SQL commands

> Comment Out Code

highlight target code and on Mac press: 

CMD + / 

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
>

when creating a table, you can add a IF NOT EXISTS to the SQL command to prevent errors

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

DROP VIEW artist_list;
