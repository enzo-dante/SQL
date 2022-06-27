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
