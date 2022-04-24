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
    ! order of args is programmer specified, but the new data has to align with provided order of args

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

/*
    !GROUP BY summarizes or aggregates identical data into single rows
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
    CONCAT(
        author_fname, " ", author_lname
        ) AS author,
    title,
    released_year
FROM books
    WHERE title LIKE "%Harry Potter%"
    ORDER BY released_year DESC
        LIMIT 4;

/**
* ? find the title of the longest book from the books table in the book_shop db
*
* ! HINT: use (max with a subquery) || (order by & limit)
*
* * schema:
* *    title
* *    pages
*/

SELECT database();
SHOW DATABASES;
USE book_shop;

-- option 1
SELECT
    title
FROM books
    WHERE pages = (
        SELECT
            MAX(pages)
        FROM books
        );

-- option 2
SELECT
    title
FROM books
    ORDER BY pages
    LIMIT 1;

/**
* ? sum all pages per author & organize by highest-to-lowest in the books table from the book_shop db
*
* * schema:
* *    pages
*/

SELECT database();
SHOW DATABASES;
USE book_shop;

SELECT
    CONCAT(
        author_fname, " ", author_lname
        ) AS "author",
    SUM(pages) AS "sumPages"
FROM books
    GROUP BY author_lname, author_fname
        ORDER BY sumPages DESC;

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
* ? find the year each author published their first book in the books table from the book_shop db
*
* ! HINT: use min with group by
*
* * schema:
* *    released_year
* *    title
* *    author_fname
* *    author_lname
*/

SELECT database();
SHOW DATABASES;
USE book_shop;

SELECT
    CONCAT(
        author_fname, " ", author_lname
        ) AS "author",
    title,
    MIN(released_year) AS "first year published"
FROM books
    GROUP BY author_lname, author_fname;

/**
* ? sum all pages in the books table from the book_shop db
*
* * schema:
* *    pages
*/

SELECT database();
SHOW DATABASES;
USE book_shop;

SELECT
    SUM(pages) AS "total pages"
FROM books;

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

/**
* ? update cats table
* ?    remember to always SELECT first before UPDATE
*
* ? than update Jackson's name to Jack
*
* * schema: cat_id, name, breed, age
*/

SELECT *
FROM cats
    WHERE name = "Jackson"

UPDATE cats
    SET name = "Jack"
        WHERE name = "Jackson"

/**
* ? update cats table
* ?    remember to always SELECT first before UPDATE
*
* ? than update Ringo's breed to "British Shorthair"
*
* * schema: cat_id, name, breed, age
*/

SELECT *
FROM cats
    WHERE name = "Ringo"

UPDATE cats
    SET breed = "British Shorthair"
        WHERE name = "Ringo"

/**
* ? update cats table
* ?    remember to always SELECT first before UPDATE
*
* ? than update both Maine Coons' ages to 12
*
* * schema: cat_id, name, breed, age
*/

SELECT *
FROM cats
    WHERE breed = "Maine Coons"

UPDATE cats
    SET age = 12
        WHERE breed = "Maine Coons"

/**
* ? delete all 4 year old cats
* ? delete all cats whose age is the same as their cat_id
* ? delete all cats
*
* ! remember to always SELECT first before DELETE
* * schema: cat_id, name, breed, age
*/

SELECT *
FROM cats
    WHERE age = 4;

DELETE FROM cats
    WHERE age = 4;

SELECT *
FROM cats
WHERE age = cat_id;

DELETE FROM cats
    WHERE age = cat_id;

SELECT *
FROM cats;

DELETE * FROM cats;

/**
 * ? CRUD challenge:
 * ?    create db, use db, create table shirts,
 * ?    and insert test data
 *
 * * schema:
 * *    shirt_id (auto_increment),
 * *    article(max 100 char),
 * *    color(max 100 char),
 * *    shirt_size(max 4 char), last_worn(int default 0)
 */

SELECT database();
SHOW DATABASES;

CREATE DATABASE shirts_db;
USE shirts_db;

CREATE TABLE shirts(
    shirt_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    article VARCHAR(100),
    color VARCHAR(100),
    shirt_size VARCHAR(4),
    last_worn INT NOT NULL DEFAULT 0
);

DESC shirts;

INSERT INTO shirts(article, color, shirt_size, last_worn)
VALUES ("polo", "red", "M", 10), ("polo", "blue", "S", 2);

SELECT * FROM shirts;

/**
* ? read all shirts but print only article and color
*
* * schema:
* *    shirt_id (auto_increment),
* *    article(max 100 char),
* *    color(max 100 char),
* *    shirt_size(max 4 char), last_worn(int default 0)
*/

SELECT
    article,
    color
FROM shirts

/**
* ? read only medium shirts, print everything but print shirt_id
*
* * schema:
* *    shirt_id (auto_increment),
* *    article(max 100 char),
* *    color(max 100 char),
* *    shirt_size(max 4 char), last_worn(int default 0)
*/

SELECT
    article,
    color,
    shirt_size,
    last_worn
FROM shirts
    WHERE shirt_size = "M";

/**
* ? select titles that contain 'stories' and order by descending
*
* * schema:
* *    author_fname, author_lname,
* *    pages, title, released_year, stock_quantity
*/

SELECT
    title
FROM books
    WHERE title LIKE "%stories%"
    ORDER BY title DESC;

/**
* ? find the longest book: print out the title and page count
*
* * schema:
* *    author_fname, author_lname,
* *    pages, title, released_year, stock_quantity
*/

SELECT
    title,
    pages
FROM books
    ORDER BY pages DESC 
    LIMIT 1;


/**
* ? print summary containing the title and released_year,
* ? for the 3 most recent books
*
* * Mad Men-2013
*
* * schema:
* *    author_fname, author_lname,
* *    pages, title, released_year, stock_quantity
*/

SELECT
    CONCAT(title, "-", released_year) AS "summary"
FROM books
ORDER BY released_year DESC
LIMIT 3;

/**
* ? find all the books (print only title and the author_lname) from books table in book_shop db
* ? that has an author_lname that contains a space (" ") and order by title descending
*
* * books table schema:
* *    title, author_fname, author_lname,
* *    released_year, stock_quantity
*/

SHOW DATABASES;
SELECT database();
USE book_shop;

SELECT
    title,
    author_lname
FROM books
    WHERE author_lname LIKE "% %"
    ORDER BY title DESC;


/**
* ? print the title, author_lname from books table in book_shop
* ?    sorted by author_lname and then by title
*
* * books table schema:
* *    title, author_fname, author_lname,
* *    released_year, stock_quantity
*/

SHOW DATABASES;
SELECT database();
USE book_shop;

SELECT
    title,
    author_lname
FROM books
    ORDER BY author_lname, title;

/**
* ? sort alphabetically by last name from books table in book_shop db
* ?    labeled as yell:
*
* !      'MY FAVORITE AUTHOR IS {author_fname} {author_lname}!'
*
* * books table schema:
* *    title, author_fname, author_lname,
* *    released_year, stock_quantity
*/

SHOW DATABASES;
SELECT database();
USE book_shop;

SELECT
    UPPER(
        CONCAT(
            "my favorite author is ",
            author_fname,
            " ",
            author_lname,
            "!"
        )
    ) AS "yell"
FROM books
    ORDER BY author_lname;

/**
* ? sum all pages by each author fullname has written in books table in book_shop db
* ? order by highest-to-lowest page count and limit it to 5
*
* * books table schema:
* *    title, author_fname, author_lname,
* *    released_year, stock_quantity
*/

SHOW DATABASES;
SELECT database();
USE book_shop;

SELECT
    CONCAT(
        author_fname, " ", author_lname
    ) AS "author",
    SUM(pages) AS "totalPages"
FROM books
    GROUP BY author_lname, author_fname
    ORDER BY "totalPages"
        LIMIT 5;

/**
 * ? find the 3 books with the lowest stock in books table from book_shop db
 * ?    print title, released_year, and stock
*
* * books table schema:
* *    title, author_fname, author_lname,
* *    released_year, stock_quantity
*/

SHOW DATABASES;
SELECT database();
USE book_shop;

SELECT
    title,
    released_year,
    stock_quantity
FROM books
    ORDER BY stock_quantity
        LIMIT 3;

/**
* ? calculate avg stock_quantity for books released in the year from books table in book_shop db 
* ?     print released_year, count of books, avg 
*
* * books table schema:
* *    title, author_fname, author_lname,
* *    released_year, stock_quantity
*/

SHOW DATABASES;
SELECT database();
USE book_shop;

SELECT
    COUNT(*) AS "total books/year",
    released_year,
    AVG(stock_quantity) AS "Stock/Year"
FROM books
    GROUP BY released_year;

/**
* ? replace spaces in titles with '->' with alias title from books table in book_shop db
*
* * books table schema:
* *    title, author_fname, author_lname,
* *    released_year, stock_quantity
*/

SHOW DATABASES;
SELECT database();
USE book_shop;

SELECT
    REPLACE(
        title,
        " ",
        "->") AS "title"
FROM books;

/**
* ? print out author_lname and backwards author_lname from books table in book_shop db
* ?    in respective columns forward and backwards and order by backwards 
*
* * books table schema:
* *    title, author_fname, author_lname,
* *    released_year, stock_quantity
*/

SHOW DATABASE;
SELECT database();
USE book_shop;

SELECT
    author_lname AS "forwards",
    REVERSE(author_lname) AS "backwards"
FROM books
ORDER BY backwards; 

/**
* ? print out full author name from books table in book_shop db 
* ?    in caps with alias full name in caps
*
* * books table schema:
* *    title, author_fname, author_lname,
* *    released_year, stock_quantity
*/

SHOW DATABASES;
SELECT database();
USE book_shop;

SELECT
    UPPER(
        CONCAT(
            author_fname, author_lname
            )
        ) AS "full name in caps" 
FROM books;

/**
* ? print number of books in books table from book_shop db
*
* * books table schema:
* *    title, author_fname, author_lname,
* *    released_year, stock_quantity
*/

SHOW DATABASES;
SELECT database();
USE book_shop;

SELECT
    COUNT(*) AS "numBooks"
FROM books;

/**
* ? print number of books released in each year in books table from book_shop db
*
* * books table schema:
* *    title, author_fname, author_lname,
* *    released_year, stock_quantity
*/

SHOW DATABASES;
SELECT database();
USE book_shop;

SHOW TABLES;

SELECT
    released_year,
    COUNT(*) AS "books per year"
FROM books
    GROUP BY released_year
    ORDER BY 2 DESC;

/**
* ? print total number of books in stock in books table from book_shop db
*
* * books table schema:
* *    title, author_fname, author_lname,
* *    released_year, stock_quantity
*/

SHOW DATABASES;
SELECT database();
USE book_shop;

SHOW TABLES;

SELECT
    SUM(stock_quantity)
FROM books;

/**
* ? update all articles of polo shirts to size L
* ?     from shirts table in shirts_db
*
* * schema:
* *    shirt_id (auto_increment),
* *    article(max 100 char),
* *    color(max 100 char),
* *    shirt_size(max 4 char),
* *    last_worn(int default 0)
*/

SHOW DATABASES;
SELECT database();
USE shirts_db;

-- select data before update
SELECT
    articles,
    shirt_size
FROM shirts
    WHERE articles = "polo shirts";

UPDATE shirts
    SET shirt_size = "L"
    WHERE articles = "polo shirts";

/**
* ? update the shirt last worn 15 days ago to last_worn = 0
* ?     from shirts table in shirts_db
*
* * schema:
* *    shirt_id (auto_increment),
* *    article(max 100 char),
* *    color(max 100 char),
* *    shirt_size(max 4 char),
* *    last_worn(int default 0)
*/

SHOW DATABASES;
SELECT database();
USE shirts_db;

-- select before update
SELECT *
FROM shirts
WHERE last_worn = 15;

UPDATE shirts
    SET last_worn = 0
    WHERE last_worn = 15;

/**
* ? update multiple fields all white shirts to have
* ?     a shirt_size of 'XS' and
* ?     color of 'off white'
* ?     from shirts table in shirts_db
*
* * schema:
* *    shirt_id (auto_increment),
* *    article(max 100 char),
* *    color(max 100 char),
* *    shirt_size(max 4 char),
* *    last_worn(int default 0)
*/



