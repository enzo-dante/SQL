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

# relationship types

__always compartmentalize dataset into seperate tables and then join if necessary byshared relationship__

Relationships are the different ways two or multiple tables (entities) are related

1. one-to-one relationship (not very common)

ex: 1 customer-to-1 customer details relationship

2. one-to-many relationship (most common)

ex: 1 book-to-many reviews relationship

3. many-to-many relationship (relatively common)

ex: many authors-to-many books relationship (a book can have mulitple authors)

# 1-to-MANY relationship

> PRIMARY KEY AUTO_INCREMENT ensures one column that is always unique for joined relationships

an example of 1-to-many relationship: 1 book-to-many reviews relationship

> FOREIGN KEY are references to another table within a given table
>
> explicitely using a FOREIGN KEY protects from bad data input

__STEPS__
1. Define foreign key column: <external_table_name>_id
2. on final CREATE TABLE line: FOREIGN KEY(column_name_in_CREATE_TABLE) REFERENCES <existing_table_name>(existing_table_primary_key)

ex) 

1 customers table (that has PRIMARY KEY customer_id column) AND

1 orders table (that has a PRIMARY KEY order_id but also has a customer_id column that is a reference to the customers table PRIMARY KEY customer_id)

> JOIN = take data from multiple tables and temporarily consolidate them in a meaningful way

__The main difference between a LEFT/RIGHT JOIN and INNER JOIN is that LEFT/RIGHT joins will also show you where there IS NOT overlap while INNER JOIN only shows the overlap of a venn diagram__

CREATE TABLE customers
  (
     id         INT NOT NULL auto_increment PRIMARY KEY,
     first_name VARCHAR(100),
     last_name  VARCHAR(100),
     email      VARCHAR(100)
  );

CREATE TABLE orders
  (
     id          INT NOT NULL auto_increment PRIMARY KEY,
     order_date  DATE,
     amount      DECIMAL(8, 2) DEFAULT 0 NOT NULL,
     customer_id INT,
     FOREIGN KEY(customer_id) REFERENCES customers(id)
  );


__logic for LEFT AND RIGHT JOIN(two most common types of JOIN):__
https://dataschool.com/how-to-teach-people-sql/left-right-join-animated/

__The main difference between a LEFT/RIGHT JOIN and INNER JOIN is that LEFT/RIGHT joins will also show you where there IS NOT overlap while INNER JOIN only shows the overlap of a venn diagram__

__the below examples show how "flipping" LEFT and RIGHT JOIN would produce identical return tables if you just change the order__

ex)

SELECT * FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id;

SELECT * FROM orders
RIGHT JOIN customers
    ON customers.id = orders.customer_id;

ex)

SELECT * FROM orders
LEFT JOIN customers
    ON customers.id = orders.customer_id;

SELECT * FROM customers
RIGHT JOIN orders
    ON customers.id = orders.customer_id;

> cross join 

__an implicit/cross join does not consolidate data in any meaninfulway;
it simply adds each row in 1 table to each row in another table, effectively cross multiplying the total number of rows__

__the created tables from a join operate like a normal table that can use normal table functions__

SELECT * FROM customers, orders

> INNER JOIN = select all records from A and B where the JOIN condition is met
>
> the single most shared space between multiple circles in a Venn Diagram

https://dataschool.com/how-to-teach-people-sql/inner-join-animated/

__The main difference between a LEFT/RIGHT JOIN and INNER JOIN is that LEFT/RIGHT joins will also show you where there IS NOT overlap while INNER JOIN only shows the overlap of a venn diagram__

__explicit INNER JOIN, if you leave off INNER it will be implied that the JOIN is INNER__

SELECT first_name,
       last_name,
       order_date,
       amount
FROM   customers
       JOIN orders
         ON customers.id = orders.customer_id
ORDER BY amount;


__this implicit inner JOIN is inferior to an explicit inner JOIN__ 

be explicit in defining which column belongs to which table in a WHERE clause


SELECT first_name,
       last_name,
       order_date,
       amount
FROM   customers,
       orders
WHERE  customers.id = orders.customer_id
ORDER BY amount;

> again, an INNER JOIN would reperesent the middle section of a Venn Diagram with 2 intersecting circles

SELECT first_name,
       title,
       grade
FROM   students
       INNER JOIN papers
               ON students.id = papers.student_id
ORDER  BY grade DESC;

> ON DELETE CASCADE = allow the removal of an entire records that are shared by a FOREIGN key
>

__when CREATE TABLE and defining a FOREIGN KEY, if a record in table a is deleted, the corresponding record in table b will be deleted thus deleting entire record and preventing a thrown error__


CREATE TABLE orders
  (
     id          INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
     order_date  DATE,
     amount      DECIMAL(8, 2),
     customer_id INT,
     FOREIGN KEY(customer_id) REFERENCES customers(id) ON DELETE CASCADE
  );


> IFNULL(argument_to_validated, replacement_value_if_valid)


SELECT first_name,
       Ifnull(Avg(grade), 0) AS 'average'
FROM   students
       LEFT JOIN papers
              ON students.id = papers.student_id
GROUP  BY students.id, first_name
ORDER BY 2 DESC; 



IFNULL(SUM(amount), 0) AS total_spent


> LEFT JOIN = select everything from table A, along with any matching records in table B
>
> in a Venn Diagram, the entire LEFT circle, including the shared section, would be included

__The main difference between a LEFT/RIGHT JOIN and INNER JOIN is that LEFT/RIGHT joins will also show you where there IS NOT overlap while INNER JOIN only shows the overlap of a venn diagram__

__LEFT JOIN logic:__
https://dataschool.com/how-to-teach-people-sql/left-right-join-animated/

SELECT first_name,
       last_name,
       IFNULL(SUM(amount), 0) AS total_spent
FROM   customers
       LEFT JOIN orders
              ON customers.id = orders.customer_id
GROUP  BY customers.id
ORDER  BY total_spent; 

> RIGHT JOIN = select everything from table B, along with any matching records in table A
>
> in a Venn Diagram, the entire RIGHT circle, including the shared section, would be included

__RIGHT JOIN logic:__
https://dataschool.com/how-to-teach-people-sql/left-right-join-animated/

__The main difference between a LEFT/RIGHT JOIN and INNER JOIN is that LEFT/RIGHT joins will also show you where there IS NOT overlap while INNER JOIN only shows the overlap of a venn diagram__

SELECT first_name,
       last_name,
       IFNULL(SUM(amount), 0) AS total_spent
FROM   customers
       RIGHT JOIN orders
              ON customers.id = orders.customer_id
GROUP  BY customers.id
ORDER  BY total_spent; 

> CASE STATEMENTS, IFNULL, and JOIN

__first case statement checks if value returns null and not 0__

SELECT first_name,
       Ifnull(Avg(grade), 0) AS 'average',
       CASE
         WHEN Avg(grade) IS NULL THEN Upper('failing')
         WHEN Avg(grade) >= 75 THEN Upper('passing')
         ELSE Upper('failing')
       END                   AS 'passing_status'
FROM   students
       LEFT JOIN papers
              ON students.id = papers.student_id
GROUP  BY students.id,
          first_name
ORDER  BY 2 DESC;

# Many-to-Many JOIN

> JOIN/union tables = third external table that connect two other seperate tables in a many-to-many relationship

ex) 
reviewers table and series table are connected to each other by a review table
- the tables are "connected" via JOIN using unique row id in reviewers and series tables


CREATE TABLE reviewers
  (
     id         INT NOT NULL auto_increment PRIMARY KEY,
     first_name VARCHAR(100),
     last_name  VARCHAR(100)
  );

CREATE TABLE series
  (
     id            INT NOT NULL auto_increment PRIMARY KEY,
     title         VARCHAR(100),
     released_year YEAR(4),
     genre         VARCHAR(100)
  );

CREATE TABLE reviews
  (
     id          INT NOT NULL auto_increment PRIMARY KEY,
     rating      DECIMAL(2, 1),
     series_id   INT,
     reviewer_id INT,
     FOREIGN KEY(series_id) REFERENCES series(id) ON DELETE CASCADE,
     FOREIGN KEY(reviewer_id) REFERENCES reviewers(id) ON DELETE CASCADE
  );

exercise 1) join series and reviews

SELECT *
FROM   series;

SELECT *
FROM   reviews;

SELECT title,
       rating
FROM   series
       INNNER JOIN reviews
         ON series.id = reviews.series_id;

exercise 2) join series and reviews that are GROUP BY series id

SELECT title,
       Avg(rating) AS 'avg_rating'
FROM   series
       INNER JOIN reviews
         ON series.id = reviews.series_id
GROUP  BY series.id
ORDER  BY avg_rating;

exercise 3)

SELECT *
FROM   reviewers
       INNER JOIN reviews
         ON reviewers.id = reviews.reviewer_id;

SELECT first_name,
       last_name,
       rating
FROM   reviewers
       INNER JOIN reviews
         ON reviewers.id = reviews.reviewer_id;

exercise 4) find unreviewed series

__The main difference between a LEFT/RIGHT JOIN and INNER JOIN is that LEFT/RIGHT joins will also show you where there IS NOT overlap while INNER JOIN only shows the overlap of a venn diagram__

__since you need series without reviews, you need to use a LEFT JOIN (entire left circle including center of a venn diagram) and not an INNER JOIN (center of a venn diagram)__

__also in the WHERE clause, to validate NULL use "rating IS NULL" because you CANNOT use "rating = NULL"__


SELECT title AS 'unreviewed series'
FROM   series
       LEFT JOIN reviews
              ON series.id = reviews.series_id
WHERE  rating IS NULL; 

exercise 5) ROUND(input, number_of_decimal_positions)

SELECT genre,
       Round(Avg(rating), 2) AS 'avg_rating'
FROM   series
       INNER JOIN reviews
               ON series.id = reviews.series_id
GROUP  BY genre
ORDER  BY genre;

exercise 6) you can use CASE statements or IF()

option 1

SELECT first_name,
       last_name,
       Ifnull(Count(reviews.id), 0)                         AS 'COUNT',
       Ifnull(Min(reviews.rating), 0)                       AS 'MIN',
       Ifnull(Max(reviews.rating), 0)                       AS 'MAX',
       Ifnull(Round(Avg(reviews.rating), 1), 0)             AS 'AVG',
       IF(Count(reviews.rating) >= 1, UPPER('active'), UPPER('inactive')) AS 'STATUS'
FROM   reviewers
       left join reviews
              ON reviewers.id = reviews.reviewer_id
GROUP  BY reviewers.id
ORDER  BY 6 DESC; 

option 2

SELECT first_name,
       last_name,
       Ifnull(Count(reviews.id), 0)   AS 'COUNT',
       Ifnull(Min(reviews.rating), 0) AS 'MIN',
       Ifnull(Max(reviews.rating), 0) AS 'MAX',
       Ifnull(ROUND(Avg(reviews.rating), 1), 0) AS 'AVG',
       CASE
         WHEN reviews.id IS NULL THEN Upper('inactive')
         WHEN COUNT(reviews.rating) >= 1 THEN UPPER('active')
         ELSE Upper('active')
       END                            AS 'STATUS'
FROM   reviewers
       LEFT JOIN reviews
              ON reviewers.id = reviews.reviewer_id
GROUP  BY reviewers.id
ORDER BY 6 DESC;

exercise 7) INNER JOIN more than 2+ tables

SELECT title,
       rating,
       Concat_ws(' ', first_name, last_name) AS 'reviewer'
FROM   reviewers
       INNER JOIN reviews
               ON reviewers.id = reviews.reviewer_id
       INNER JOIN series
               ON series.id = reviews.series_id
ORDER  BY title;


# do not hardcode, use subqueries for dynamic updating

SELECT users.username AS 'users that liked every photo',
       Count(*) AS 'total_likes'
FROM   users
       INNER JOIN likes
               ON users.id = likes.user_id
GROUP  BY likes.user_id
HAVING total_likes = (SELECT Count(*)
                      FROM   photos)
ORDER  BY users.username;
