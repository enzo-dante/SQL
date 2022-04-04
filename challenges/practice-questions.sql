/*
  in goormIDE terminal from project directory, execute:
  
      node app.js

  SQL formatter:

    https://www.dpriver.com/pp/sqlformat.htm
*/

/**
 * ? create a tweets table for twitter_db
 * 
 * * schema: username(15 max char), content(140 max char), num_favorites
 */

SELECT database();
SHOW DATABASES;

CREATE DATABASE twitter_db;
USE twitter_db;
SELECT database();

SHOW TABLES;

CREATE TABLE tweets(
    username VARCHAR(15),
    content VARCHAR(140),
    num_favorites INT
);

DESC tweets;

/**
 * ? create, describe, and delete pastries table for food_db
 * 
 * * schema: name(50 max), quantity
 */

SELECT database();
SHOW DATABASES;

CREATE DATABASE food_db;
USE food_db;
SELECT database();

SHOW TABLES;

CREATE TABLE pastries(
    name VARCHAR(50),
    quantity INT
);

DESC patries;

DROP TABLE pastries;

SHOW TABLES;

DROP DATABASE food_db;

/**
 * ? create people table for population_db, insert into people table, verify new data
 * 
 * * schema:
 *      * first_name(20 char limit), last_name(20 char limit), age
 *      
 * * new data:
 *      * (Tina, Belcher, 13)
 */

SELECT database();
CREATE DATABASE population_db;
USE population_db;

SHOW TABLES;

CREATE TABLE people(
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    age INT
);

SHOW TABLES;
DESC people;

/* 
    order of args is programmer specified, but the new data has to align with provided order of args

        example: 

            (last_name, age, first_name)
*/
INSERT INTO people(last_name, age, first_name)
VALUES ("Belcher", 13, "Tina");

SELECT *
FROM people;

/**
* ? get unique author full names ordered by author_lname descending from pre-existing books db
*
* * schema:
*       * author_fname, 
*       * author_lname
*/

SELECT database();
USE books_db;

SELECT DISTNICT
    author_fname,
    author_lname
FROM books
ORDER BY author_lname DESC;


/**
* ? how many books are in the pre-existing book_shop db 
*
* * label query: 'number of books'
*/

SELECT database();
USE book_shop;

/*
    ! COUNT(*) = count every row in the given table
*/
SELECT
    COUNT(*) AS "number of books"
FROM book_shop;

/**
* ? how many unique author first names are in the books table of the pre-existing book_shop db 
*
* * schema: author_fname
*/

SHOW DATABASES;
SELECT database();
USE book_shop;

/*
    ! COUNT(DISTINCT column_a) = only count rows where column_a values are unique (no duplicates) 
*/
SELECT 
    COUNT(
        DISTINCT author_fname
    ) AS "author first names"
FROM books;

/**
* ? how many unique author full names (don't use concat) are in the books table of the pre-existing book_shop db 
*
* * schema: 
*       * author_fname,
*       * author_lname
*/

SHOW DATABASES;
SELECT database();
USE book_shop;

/*
    ! COUNT(DISTINCT column_b, column_a) = only count rows where column_a AND column_b are unique (no duplicate full names)
*/
SELECT
    COUNT(
        DISTINCT 
            author_lname, 
            author_fname
    ) AS "unique author full names"
FROM books;

/**
* ? how many titles contain 'the' keyword in the books table of the pre-existing book_shop db 
*
* * schema: title
*/

SHOW DATABASES;
SELECT database();
USE book_shop;

/*
    logic = select all rows from books table, where title is like '{anything}the{anything}'
*/
SELECT
    COUNT(*) AS "num_titles with 'the' keyword" 
FROM books
WHERE title LIKE "%the%"

/**
* ? LIMIT
*
* * schema: 
*/


/**
* ? GROUP BY
*
* * schema: 
*/






