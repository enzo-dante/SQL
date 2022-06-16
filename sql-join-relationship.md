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

# Many-to-Many JOIN

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