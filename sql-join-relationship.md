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

# 1-to-MANY relationship

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

