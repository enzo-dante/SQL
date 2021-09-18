# SQL formatter

https://www.dpriver.com/pp/sqlformat.htm

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

# SQL commands

> Comment Out Code

highlight target code and on Mac press: 

CMD + / 

> when creating a db, use a plural name

```

CREATE DATABASE <database_name>;

SHOW DATABASES;

```
> when dropping a db, check with SELECT that data is not essential

*if you delete a database use you are currently using, the SELECT database(); command will return NULL

```

DROP DATABASE <database_name>;


```

> tells mysql which database we want to work with

```

USE <database_name>; 

```

> tell currently used database

```

SELECT database();

```

> create a table in easy to read multi-line composition

```

CREATE TABLE <tablename_in_plural_form>
	(
		column_name data_type, 
		column_name data_type
	);

```

ex:

CREATE TABLE pastries
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

> when in target db, show tables in current db

```

SHOW TABLES;

```

> when in target db, describe/show column structure from target table

```

DESC <table_name>;

```

SHOW COLUMNS FROM <table_name>;

> when in target db, remove target table

```

DROP TABLE <table_name>;

```

> insert data into a table in a target db

*each value has to correspond to the column data type

*order of column arguments has to match value arguments

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

> insert multiple values into a table in a target db

```

INSERT INTO <table_name>
	(
		column_name,
		column_name
	)
VALUES
	(value, value),
  (value, value);

```

ex:

INSERT INTO verbs(
        name,
        age
    )
    VALUES
        ('Peanut', 4),
        ('Butter', 10),
        ('Jelly', 7);

> select the data for viewing in a table when in a target db

```

SELECT * FROM <table_name>;

```

> If you're wondering how to insert a string (VARCHAR) value that contains quotations, then here's how.

__escape the quotes with a backslash:__
"This text has \"quotes\" in it" or 'This text has \'quotes\' in it'

__alternate single and double quotes:__
"This text has 'quotes' in it" or 'This text has "quotes" in it'

> mysql warnings

__if you encounter an error instead of a warning, the solution is to run the following command in your mysql shell__

__if a VARCHAR(5) column, has a string that exceeds 5 characters__

```

set sql_mode='';

SHOW WARNINGS;

```

> null means value is unknown

*null DOES NOT mean zero

*to enforce NOT NULL when creating a table, use NOT NULL

ex:

```

CREATE TABLE cats2
	(
		name VARCHAR(100) NOT NULL,
		age INT NOT NULL
	);

```

> default values 

*to set a default value, set DEFAULT and value when creating a table

ex:

```

CREATE TABLE cats3
	(
		name VARCHAR(100) DEFAULT 'unnamed',
		age INT DEFAULT 99
	);

```

> using both DEFAULT VALUES and NOT NULL

__This is not redundant because this prevents the user from manually inserting a NULL value__

__Below ex would insert a NULL value:__

```
INSERT INTO cats3(name, age) VALUES('Montana', NULL);
```

__below ex would prevent a NULL value and have a default value when creating a table:__

```
CREATE TABLE cats5
	(
		name VARCHAR(4) NOT NULL DEFAULT 'unnamed',
		age INT NOT NULL DEFAULT 99
	);
```

*below ex would return an ERROR:

```
INSERT INTO cats5
    (
        name,
        age
    )
    VALUES
    ('Cali', NULL);
```
> primary Keys are used as unique IDs for organizing data in a table

__when DESC a table, the key column would list PRI instead of empty__

__if you attempt to add data that has a duplicate primary value, will return ERROR__

ex:

```
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
```

> AUTO_INCREMENT PRIMARY KEY removes manual input for Primary Keys

ex:

```
CREATE TABLE cats7
	(
		cat_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
		name VARCHAR(100),
		age INT,
	);
```

> CRUD = create, read, update, delete

__read = SELECT and * = return all columns__

ex:

```
SELECT * FROM cats;
```

__can target single or multiple columns with a comma seperated list__

__list order matters because it determine presentation__

ex:

```
SELECT cat_id, name FROM cats;
```

ex:

```
SELECT name, age FROM cats;
```

> WHERE = specific filtering commands

__below selects all columns from cats table where age is 4__

```
SELECT * FROM cats WHERE age=4;
```

__below selects all columns from cats table where name is Egg__
- case insensitive

```
SELECT * FROM cats WHERE name='Egg';
```

__below allows you to compare columns__

```
SELECT cat_id, age FROM cats WHERE cat_id=age;
```

> WHERE <column_name> != <variable> 

__filters WHERE query that does not equal variable__

```
SELECT title FROM books WHERE released_year != 2017;
 
SELECT title, author_lname FROM books WHERE author_lname != 'Harris';
```

> WHERE <column_name> LIKE WILDCARDS for better search filtering for approximation

__wildcards are used in LIKE to indicate anything before or after the approximator string a la: %da%__

__wildcards are optional & represent anything before or after for pattern matching__

```
SELECT author_fname, title
FROM books
    WHERE author_fname LIKE '%da%'
    ORDER BY author_fname;

SELECT author_fname, title
FROM books
    WHERE author_fname LIKE 'da%'
    ORDER BY author_fname;

SELECT author_fname, title
FROM books
    WHERE author_fname LIKE '%da'
    ORDER BY author_fname;
```

__using "_" to specify number of characters in WHERE LIKE query__

__the example below filters for values of 4 index value length__

```
SELECT title, stock_quantity
FROM books
    WHERE stock_quantity
        LIKE '____'
```

to use an actual % or _ symbol and the special character, than use an escape: \

anything%anything = '%\%%'

anything_anything = '%\_%'

```
SELECT title
FROM books
    WHERE title LIKE '%\%%';

SELECT title
FROM books
    WHERE title LIKE '%\_%';
```

> WHERE <column_name> NOT LIKE 'WILDCARD'

__use NOT LIKE to filter for everything that is NOT LIKE the provided wildcard__

```
SELECT title FROM books WHERE title NOT LIKE 'W%';
```

> WHERE <column_name> >= <variable>
>
> WHERE <column_name> <= <variable>

__you can use the greater than (>) or less than (<) in WHERE queries__

__you can use the greater than (>=) or eqal to; less than (<=) or equal to in WHERE queries__

__if you SELECT number > number; SQL will return a boolean: 1(true) or 0(false)__

```
SELECT title, released_year FROM books 
WHERE released_year >= 2000 ORDER BY released_year;

SELECT title, released_year FROM books
WHERE released_year <= 2000;
```

__avoid string comparisons since it varies by programming language__

__SQL does not recognize upper or lowercase as different__

```
SELECT 'A' > 'a';
```

> WHERE <column_name> >= <variable> 
> AND <column_name> = <variable>
> AND <column_name> LIKE '%WILDCARD';

__using AND or && (depricated) will allow you to chain multiple logical operators in a single WHERE__

__generally, you shouldn't use more than 3 logical operators, otherwise the table should be restructured__

```
SELECT *
FROM books
WHERE author_lname='Eggers'
    AND released_year > 2010
    AND title LIKE '%novel%';
```

> OR = logical or this 

__using AND or || (depricated) will allow you to chain multiple logical operators in a single WHERE__

__only 1 part of the expression has to be true for the output to be true__

__generally, you shouldn't use more than 3 logical operators, otherwise the table should be restructured__

```
SELECT title,
       author_lname,
       released_year,
       stock_quantity
FROM   books
WHERE  author_lname = 'Eggers'
        OR released_year > 2010
        OR stock_quantity > 100;
```

> CAST() = convert 1 data type to another data type

```
SELECT CAST('2017-05-02' AS DATETIME);
```

> BETWEEN = SELECT data in an upper AND lower range 
>
> BETWEEN x AND y

```
SELECT title,
       released_year
FROM   books
WHERE  released_year BETWEEN 2004 AND 2015; 
```

__BETWEEN x AND y are commonly used with CAST()__

```
SELECT
    name,
    birthdt
FROM people
WHERE
    birthdt BETWEEN CAST('1980-01-01' AS DATETIME)
    AND CAST('2000-01-01' AS DATETIME);
```

__BETWEEN is a more efficient use of AND with greater than or less than__

```
SELECT title,
       released_year
FROM   books
WHERE  released_year >= 2004
       AND released_year <= 2015; 
```

> NOT BETWEEN = SELECT data NOT in the upper AND lower range 

```
SELECT title,
       released_year
FROM   books
WHERE  released_year NOT BETWEEN 2004 AND 2015
ORDER  BY released_year DESC;
```

> IN = return set of values IN provided column

__using IN is superior to OR with long comma seperated values__

```
SELECT title,
       author_lname
FROM   books
WHERE  author_lname IN ( 'Carver', 'Lahiri', 'Smith' ); 
```

__IN functionality can be achieved using OR, but not as efficient__

```
SELECT title,
       author_lname
FROM   books
WHERE  author_lname = 'Carver'
        OR author_lname = 'Lahiri'
        OR author_lname = 'Smith';
```

> NOT IN = return set of values NOT IN provided column

__using NOT IN is superior to OR with long comma seperated values__

example only returns odd released years after 2000

```
SELECT title,
       released_year
FROM   books
WHERE  released_year >= 2000
       AND released_year NOT IN ( 2000, 2002, 2004, 2006,
                                  2008, 2010, 2012, 2014, 2016 );
```

> % = MODULO or remainder operator
>
> % allows you to test is something is even

if you divide value by 2 and there is no remainder, it is even

```
SELECT title,
       released_year
FROM   books
WHERE  released_year >= 2000
       AND released_year % 2 != 0
ORDER  BY released_year DESC;
```

> AS = specify alias for how data is presented from query

ex:

SELECT cat_id AS id, name FROM cats;

ex:

```

SELECT name AS 'cat_name', breed AS 'type_of_cat' FROM cats;

```

> UPDATE = change existing data

*process should be use SELECT to target desired data set before using UPDATE

ex: 

SELECT * FROM cats
	WHERE breed='Tabby';

UPDATE cats 
	SET breed='Shorthair'
		WHERE breed='Tabby';

ex:

```

SELECT * FROM cats
	WHERE color='off white';

UPDATE shirts
    SET shirt_size='XS', color='not white'
    WHERE color='off white';

```

> DELETE = remove existing data

*process should be use SELECT to target desired data set before using DELETE

*when data is deleted and there is an AUTO_INCREMENT PRIMARY KEY, the keys don't shift to compensate for the deleted dataset

ex:

```

SELECT * FROM cats
    WHERE name='Egg';

DELETE FROM cats
    WHERE name='Egg';

SELECT * FROM cats;

```

*delete all enteries in table, but table shell remains

ex:

```

DELETE FROM <table_name>

```

> SELECT DISTINCT only returns unique column values 


```

SELECT DISTINCT <column_name> FROM <table_name>;

```

*the examples below produces the result of unique rows

ex:

```

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

```

> ORDER BY is used to sort results

*ascending by default

```

SELECT 
    <column_name>
FROM <database_name>
    ORDER BY <column_name>;

```

*using a number with ORDER BY is a shortcut to refer to a specific column

```

SELECT
    title
        AS 'column 1',
    author_fname
        AS 'column 2',
    author_lname
        AS 'column 3'
FROM books
    ORDER BY 2;

```

*you can run an initial sort, and then a subsequent sort on the initially sorted return set by adding multiple <column_names> in a comma seperated list

```

SELECT
    title
        AS 'column 1',
    author_fname
        AS 'column 2',
    author_lname
        AS 'column 3'
FROM books
    ORDER BY 2, 3;

```

*the example below will select all distinct last names from books and then ORDER BY descending order

ex:

```
SELECT DISTINCT
    author_lname
FROM books
    ORDER BY author_lname DESC;

```

*the <column_name> and the ORDER BY <column_name> don't have to match

```

SELECT DISTINCT
    title,
    pages
FROM books
    ORDER BY released_year;

```

> LIMIT specifies a number for how many results selected

*the LIMIT and ORDER BY pair are frequently used together

ex:

```

SELECT
    title,
    released_year
FROM books
    ORDER BY released_year DESC
    LIMIT 5;

```

*for pagination, you could use LIMIT to specify start point and how many to count

the example below shows the comparison:

```

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

```
