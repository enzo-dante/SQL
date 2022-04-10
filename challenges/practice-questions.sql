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
* ? How can I get the title and released year for the 5 most RECENTLY released books from the books table in the book_shop db?
*
* * schema: 
*       * title
*       * released_year
*/

SELECT
    title,
    released_year
FROM books
ORDER BY released_year DESC
LIMIT 5;

/**
* ? How many books (title as numBooks) has each author has written? 
*
* * schema: 
*       * author_fname
*       * author_lname
*
* ! there are two authors with the same last name
*/

SELECT
    author_fname,
    author_lname,
    COUNT(*) AS numBooks
FROM books
GROUP BY author_lname, author_fname;

/**
* ? How can I get the 3rd through 7th titles from the books table that's in alphabetical order in the book_shop db?
*
* * schema: 
*       * title
*/

SELECT title
FROM books
ORDER BY title
LIMIT 2,6;

/**
* ? How can I get the author's full name, title, & released year for the 4 most recently released Harry Potter books in the books table in the book_shop db? 
*
* * schema: 
*       * author_fname AND author_lname
*       * title
*       * released_year
*/

SELECT
    CONCAT(author_fname, " ", author_lname) AS author,
    title,
    released_year
FROM books
ORDER BY released_year DESC
WHERE title LIKE "%Harry Potter%"
LIMIT 4;
/**
* ? How can I get the author first name & title for the author's whose first names SPECIFICALLY start with 'da' in the books table in the book_shop db? 
*
* ! David & Dan = start with 'da'; Freida != start with 'da'
*
* * schema: 
*       * author_fname 
*       * title
*/

/* 
    * LIKE string is case-insensitive AND '%' symbol represents 'anything'

        "da%" = da{anything}
*/

SELECT 
    author_fname,
    title
FROM books
WHERE author_fname LIKE "da%";

/**
* ? create, inspect, and insert into employees table in pet_store db, review data
* 
* * schema:
*      * id (auto_increment number),
*      * first_name(255 char limit, mandatory), last_name(255 char limit, mandatory),
*      * middle_name (255 char limit, optional), age(number, mandatory),
*      * current_status(text, mandatory, default: employed)
*/

SELECT database();
SHOW DATABASES;

CREATE DATABASE pet_store;
USE pet_store;

CREATE TABLE employees(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    middle_name VARCHAR(255),
    age INT NOT NULL,
    current_status VARCHAR(10) NOT NULL DEFAULT "employed"

);

-- CREATE TABLE employees (
--   id INT AUTO_INCREMENT NOT NULL,
--   first_name VARCHAR(255) NOT NULL,
--   last_name VARCHAR(255) NOT NULL,
--   middle_name VARCHAR(255),
--   age INT NOT NULL,
--   current_status VARCHAR(255) NOT NULL DEFAULT 'employed',
--   PRIMARY KEY(id)
-- );

SHOW TABLES;
DESC employees;

INSERT INTO employees(age, first_name, current_status, last_name)
VALUES (33, "Ben", "terminated", "Riley"), (21, "Gary", "employed", "Silver");

SELECT *
FROM employees;

/**
* ? get all the book titles & respective stock_quantity that have a stock quanity that is 4 digits long from books table in book_shop db
* 
* * schema:
*      * title
*      * stock_quantity
*/

SHOW DATABASES;
SELECT database();
USE book_shop;

/* 
    ! underscores specify how many characters used with WHERE & LIKE
*/
SELECT
    title,
    stock_quantity
FROM books
WHERE stock_quantity LIKE "____";

/**
* ? create cats table, inpsect table, add test cats 
* ? select name, age, and breed of only cat's where cat_id = age
* ? drop table 
*
* * schema:
*      * cat_id (auto_increment), name(255 char limit, default: "MISSING"),
*      * breed(255 char limit, default: "TBD"), age (DEFAULT: 0)
*/

USE pets_db;

CREATE TABLE cats(
    cats_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL DEFAULT "MISSING",
    breed VARCHAR(255) NOT NULL DEFAULT "TBD",
    age INT NOT NULL DEFAULT 0
);

SHOW TABLES;
DESC cats;

INSERT INTO cats(name, age)
VALUES ("Cassy", 3), ("Riley", 5);

SELECT
    name,
    age,
    breed,
FROM cats
WHERE cats_id = age;

DROP TABLE cats;

SHOW TABLES;









