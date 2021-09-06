# table data types

NUMERIC TYPES:
INT, SMALLINT, TINYINT, MEDIUMINT,
BIGINT, DECIMAL, NUMERIC, FLOAT,
DOUBLE, BIT

STRING TYPES:
CHAR, VARCHAR(n-length), BINARY, VARBINARY,
BLOB, TINYBLOB, MEDIUMBLOB, LONGBLOB,
TEXT, TINYTEXT, MEDIUMTEXT, LONGTEXT,
ENUM

DATE TYPES:
DATE, DATETIME, TIMESTAMP, TIME,
YEAR

# SQL COMMANDS

> when creating a db, use a plural name

CREATE DATABASE <database_name>;

SHOW DATABASES;

> when dropping a db, check with SELECT that data is not essential

> if you delete a database use you are currently using, the SELECT database(); command will return NULL

DROP DATABASE <database_name>;

> tells mysql which database we want to work with

USE <database_name>; 

> tell currently used database

SELECT database();

> create a table in easy to read multi-line composition

CREATE TABLE <tablename_in_plural_form>
	(
		column_name data_type, 
		column_name data_type
	);

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

SHOW TABLES;

> when in target db, describe/show column structure from target table

DESC <table_name>;

SHOW COLUMNS FROM <table_name>;

> when in target db, remove target table

DROP TABLE <table_name>;

> insert data into a table in a target db
> each value has to correspond to the column data type
> order of column arguments has to match value arguments

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

INSERT INTO verbs(
        name,
        age
    )
    VALUES
        ('Peanut', 4),
        ('Butter', 10),
        ('Jelly', 7);

> select the data for viewing in a table when in a target db

SELECT * FROM <table_name>;

> If you're wondering how to insert a string (VARCHAR) value that contains quotations, then here's how.

*escape the quotes with a backslash: 
"This text has \"quotes\" in it" or 'This text has \'quotes\' in it'

*alternate single and double quotes:
"This text has 'quotes' in it" or 'This text has "quotes" in it'

> mysql warnings

> if you encounter an error instead of a warning, the solution is to run the following command in your mysql shell

*if a VARCHAR(5) column, has a string that exceeds 5 characters

set sql_mode='';

SHOW WARNINGS;

> null means value is unknown

*null DOES NOT mean zero

*to enforce NOT NULL when creating a table, use NOT NULL

ex:

CREATE TABLE cats2
	(
		name VARCHAR(100) NOT NULL,
		age INT NOT NULL
	);

> default values 

*to set a default value, set DEFAULT and value when creating a table

ex:

CREATE TABLE cats3
	(
		name VARCHAR(100) DEFAULT 'unnamed',
		age INT DEFAULT 99
	);

> using both DEFAULT VALUES and NOT NULL

*This is not redundant because this prevents the user from manually inserting a NULL value

*Below ex would insert a NULL value:

INSERT INTO cats3(name, age) VALUES('Montana', NULL);

*below ex would prevent a NULL value and have a default value when creating a table:

CREATE TABLE cats5
	(
		name VARCHAR(4) NOT NULL DEFAULT 'unnamed',
		age INT NOT NULL DEFAULT 99
	);

*below ex would return an ERROR:

INSERT INTO cats5
    (
        name,
        age
    )
    VALUES
    ('Cali', NULL);

> primary Keys are used as unique IDs for organizing data in a table

*when DESC a table, the key column would list PRI instead of empty

*if you attempt to add data that has a duplicate primary value, will return ERROR

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

*read = SELECT and * = return all columns

ex:

SELECT * FROM cats;

*can target single or multiple columns with a comma seperated list

*list order matters because it determine presentation

ex:

SELECT cat_id, name FROM cats;

ex:

SELECT name, age FROM cats;

> WHERE = specific filtering commands

*below selects all columns from cats table where age is 4 

SELECT * FROM cats WHERE age=4;

*below selects all columns from cats table where name is Egg
- case insensitive

SELECT * FROM cats WHERE name='Egg';

*below allows you to compare columns

SELECT cat_id, age FROM cats WHERE cat_id=age;

> aliases = specify how data is presented from query

ex:

SELECT cat_id AS id, name FROM cats;

ex:

SELECT name AS 'cat_name', breed AS 'type_of_cat' FROM cats;

> UPDATE = change existing data

*process should be use SELECT to target desired data set before using UPDATE

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

*process should be use SELECT to target desired data set before using DELETE

*when data is deleted and there is an AUTO_INCREMENT PRIMARY KEY, the keys don't shift to compensate for the deleted dataset

ex:

SELECT * FROM cats
    WHERE name='Egg';

DELETE FROM cats
    WHERE name='Egg';

SELECT * FROM cats;

*delete all enteries in table, but table shell remains

ex:

DELETE FROM <table_name>


