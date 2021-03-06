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
* ? sum all pages per author full name & organize by highest-to-lowest in the books table from the book_shop db
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
* ? get "short title" of first 10 characters with "..." amended on the end, author fullname, and "{quantity} in stock"
*
* * schema:
*       * title
*       * author_fname
*       * author_lname
*       * quantity
*/

SELECT
    CONCAT(
        SUBSTRING(
            title,
            1,
            10
        ),
        "..."
    ) AS "Short Title",
    CONCAT(author_fname, " ", author_lname),
    CONCAT(quan)


/**
* ? replaces all instances of "e" in every book title with "3" in books table
* ? print only first 10 characters in title & label query "STRANGE STRING"
*
* * HINT: start at center & solution is case-sensitive
*
* * schema:
*       * title
*/

SELECT
    SUBSTRING(
        REPLACE(title, "e", "3"),
        1,
        10
    ) AS UPPER("strange string")
FROM books;

/**
* ? print out the sentance using each author last name and number of characters in last name
* ? label the resulting table as "Last Name Length" & ordered highest-to-lowest
*
* !         "{author last name} is {author last name length} characters long"
*
* * schema:
*       * author_lname
*/

SELECT
    CONCAT(
        author_lname,
        " is ",
        CHAR_LENGTH(author_lname)
        " characters long"
    ) AS "Last Name Length"
FROM books
ORDER BY "Last Name Length";


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
* ! query one-to-many table from created customers and orders table that uses prep data for respective table
*
* ? create linked tables customers & orders in the shop_db & validate
*
* * schema:
* *     customers(id, first_name (100 characters), last_name (100 characters), email (100 characters))
* *     orders(id, order_date(date & time), amount(decimal, max 999,999.99), customer_id)
*/

SHOW DATABASES;
SELECT database();

CREATE DATABASE shop_db;
USE shop_db;

CREATE TABLE customers(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);

SHOW TABLES;
DESC customers;

CREATE TABLE orders(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_date DATETIME,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY(customer_id)
        REFERENCES customers(id)
        ON DELETE CASCADE
);

SHOW TABLES;
DESC orders;

INSERT INTO customers(first_name, last_name, email)
VALUES("Test First 1", "Test Last 1", "one@gmail.com"),
    ("Test First 2", "Test Last 2", "two@gmail.com");

SELECT *
FROM customers;

INSERT INTO orders(order_date, amount, customer_id)
VALUES("12-04-22", 50212.33, 1)

SELECT *
FROM ORDERS;

/**
* ? DATETIME challenges:
*/

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

-- select before UPDATE
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

SHOW DATABASES;
SELECT database();
USE shirts;

-- select data before UPDATE
SELECT *
FROM shirts
    WHERE color = "white";

UPDATE shirts
    SET
        shirt_size = UPPER("xs"),
        color = "off white"
    WHERE color = "white";

/**
* ? delete all old shirts that were last_worn 200 days ago
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

-- select data before DELETE
SELECT *
FROM shirts
    WHERE last_worn = 200;

DELETE FROM shirts
    WHERE last_worn = 200;

/**
* ? create table items with the shop_db with a price column that accepts decimal values
* ? insert data into the new table and review it
*
* * schema:
* *   price (decimal value format: xxx.xx)
*/

SHOW DATABASES;
CREATE DATABASE shop_db;
SELECT database();
USE shop_db;

CREATE TABLE items(
    price DECIMAL(5, 2)
);

SHOW TABLES;
DESC items;

INSERT INTO items(price)
    VALUES (7), (8.99999), (123.4);

SELECT *
FROM items;

/**
* ? delete all tank tops
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

-- select data before DELETE
SELECT *
FROM shirts
    WHERE article = "tank top";

DELETE FROM shirts
    WHERE article = "tank top";

/**
* ? delete all shirts but keep table
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
USE shirts;

-- select data before DELETE
SELECT *
FROM shirts;

DELETE FROM shirts;

/**
* ? drop shirts table in shirts_db
*
* * schema:
* *    shirt_id (auto_increment),
* *    article(max 100 char),
* *    color(max 100 char),
* *    shirt_size(max 4 char),
* *    last_worn(int default 0)
*/

DROP TABLE shirts;
SHOW TABLES;

/**
* ! use DECIMAL, instead of DOUBLE or FLOAT for percision
*
* ? create sale table, insert double values, and review
*
* * schema:
* *     price DOUBLE
*/

CREATE TABLE sale(
    price DOUBLE
);

DESC sale;

INSERT INTO sale(price)
    VALUES (23), (100.68), (1.9999);

SELECT * FROM sale;

/**
* ? print short title (first 10 chars and ...),
* ?    author (author_lname, author_fname),
* ?    quantity ({num_in_stock} in stock)
* ?         in books table from book_shop db
*
* * books table schema:
* *    title, author_fname, author_lname,
* *    released_year, stock_quantity
*/

SELECT
    CONCAT(
        SUBSTRING(title, 1, 10),
        "..."
        ) AS "short title",
    CONCAT(
        author_fname, " ", author_lname
    ) AS "author",
    CONCAT(
        stock_quantity,
        " in stock"
    ) AS "quantity"
FROM books;

/**
* ? print title and alias character count as the length of each title
* ?         in books table from book_shop db
*
* * books table schema:
* *    title, author_fname, author_lname,
* *    released_year, stock_quantity
*/

SELECT
    title,
    CHAR_LENGTH(title) AS "title character count"
FROM books;

/**
* ? print alias blurb with row:
* ?    {title} was released in {released_year}
*
* * books table schema:
* *    title, author_fname, author_lname,
* *    released_year, stock_quantity
*/

SELECT
    CONCAT(
        title,
        " was released in ",
        released_year
    ) AS "blurb"
FROM books;

/**
* ? reverse and uppercase the following sentence
* ?    "Why does my cat look at me with such hatred?"
*
* * books table schema:
* *    title, author_fname, author_lname,
* *    released_year, stock_quantity
*/

SELECT
    REVERSE(
        UPPER("Why does my cat look at me with such hatred?")
    ) AS "blurb";

/**
* ! query one-to-many table from created students and papers table that uses prep data for respective table
*
* ? create students and papers table in school_db
*
* * schema:
* *    students(primary key(id), first_name)
* *    papers(title 100 max chars, grade INT, student_id INT, foreign key (student_id))
*/

CREATE DATABASE school_db;
SHOW DATABASES;
USE school_db;

CREATE TABLE students(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL DEFAULT "MISSING"
);

DESC student;

CREATE TABLE papers(
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    title VARCHAR(100),
    grade INT NOT NULL DEFAULT 0,
    student_id INT,
    FOREIGN KEY(student_id)
        REFERENCES students(id)
        ON DELETE CASCADE
);

DESC papers;

SHOW TABLES;

/**
* ! query one-to-many table from created students and papers table that uses prep data for respective table
*
* ? populate the students and papers(student_id, title, grade) tables with 2 starter data
*
* * schema:
* *    students(primary key(id), first_name)
* *    papers(title 100 max chars, grade INT, student_id INT, foreign key (student_id))
*/

INSERT INTO students(first_name)
VALUES
    ('Caleb'),
    ('Samantha'),
    ('Raj'),
    ('Carlos'),
    ('Lisa');

INSERT INTO papers(title, grade, student_id)
VALUES
    (1, 'My First Book Report', 60),
    (1, 'My Second Book Report', 75),
    (2, 'Russian Lit Through The Ages', 94),
    (2, 'De Montaigne and The Art of The Essay', 98),
    (4, 'Borges and Magical Realism', 89);

/**
* ! query one-to-many table from created students and papers table that uses prep data for respective table
*
* ? get the student first_name, paper title, paper grade,
* ?    and student id of the respective paper
* ?    and order by paper's grade DESC
*
* * schema:
* *    students(primary key(id), first_name)
* *    papers(title 100 max chars, grade INT, student_id INT, foreign key (student_id))
*/

SELECT
    students.id,
    students.first_name,
    papers.title,
    papers.grade
FROM students
INNER JOIN papers
    ON students.id = papers.student_id
    ORDER BY papers.grade DESC;

/**
* ! query one-to-many table from created students and papers table that uses prep data for respective table
*
* ? get first_name, title, and grade of ALL students
* ?    and not just students that submitted a paper
* !    READ: return NULL for student's that didn't submit a paper
*
* * schema:
* *    students(primary key(id), first_name)
* *    papers(title 100 max chars, grade INT, student_id INT, foreign key (student_id))
*/

SELECT
    students.first_name,
    papers.title,
    papers.grade
FROM students
LEFT JOIN papers
    ON students.id = papers.student_id;

/**
* ! query one-to-many table from created students and papers table that uses prep data for respective table
*
* ? get first_name, title, and grade of ALL students
* ?    and not just students that submitted a paper
* !         READ: return NULL for student's that didn't submit a paper
* ?    AND mark any missing papers as "MISSING"
* ?    and 0 for paper's title and grade, respectively
* ?    order by grade first than student name
*
* * schema:
* *    students(primary key(id), first_name)
* *    papers(title 100 max chars, grade INT, student_id INT, foreign key (student_id))
*/

SELECT
    students.first_name,
    IFNULL(papers.title, UPPER("missing")) AS "title",
    IFNULL(papers.grade, 0) AS "grade"
FROM students
LEFT JOIN papers
    ON students.id = papers.student_id
ORDER BY "grade", students.first_name DESC;

/**
* ! query one-to-many table from created students and papers table that uses prep data for respective table
*
* ? describe the students table
* ?    print the name and each and every student's average paper grade,
* ?    even if the student didn't submit a paper
* !         READ: return NULL for student's that didn't submit a paper
* ?    round the avg by 4 decimal positions and if missing, 0
* ?    than rank from highest to lowest
*
* * schema:
* *    students(primary key(id), first_name)
* *    papers(title 100 max chars, grade INT, student_id INT, foreign key (student_id))
*/

SHOW TABLES;
DESC students;

SELECT
    students.first_name AS "first name",
    IFNULL(
        ROUND(AVG(papers.grade), 4),
        0) AS "avg"
FROM students
LEFT JOIN papers
    ON students.id = papers.student_id
GROUP BY students.id
    ORDER BY "avg" DESC;

/**
* ! query one-to-many table from created students and papers table that uses prep data for respective table
*
* ? describe the students table
* ?    get each and every student's average paper grade of their paper grades,
* ?    even if the student didn't submit a paper
* !         READ: return NULL for student's that didn't submit a paper
* ?    than rank from highest to lowest,
* ?    finally mark their 'passing status' as 'PASSING' or 'FAILING' based on their average
* ?      passing if grade >= 75, failing if grade < 75, if null failing
*
* * schema:
* *    students(primary key(id), first_name)
* *    papers(title 100 max chars, grade INT, student_id INT, foreign key (student_id))
*/

SHOW TABLES;
DESC students;

SELECT
    students.first_name AS "first name"
    IFNULL(
        ROUND(
            AVG(papers.grade),
            4),
        0
    ) AS "avg grade",
    WHEN
        CASE "avg grade" IS NULL
            THEN UPPER("failing")
        CASE "avg grade" >= 75
            THEN UPPER("passing")
        ELSE
            UPPER("failing")
    END AS "passing status"
FROM students
LEFT JOIN papers
    ON students.id = papers.student_id
GROUP BY students.id
    ORDER BY "avg grade" DESC;

/**
* ! query many-to-many table from created reviewers, series, review tables that uses prep data for respective table
*
* ? in imdb database, create reviewer, series, and reviews tables with the many-to-many connections for the review table
* ?     on delete cascade for relevant fields and tables
*
* * schema:
* *    reviewers(id, first_name default 'MISSING', last_name default 'MISSING')
* *    series(id, title default "MISSING", released_year 4-digit mandatory, genre)
* *    reviews(id, rating MIN 0.0 to MAX 9.9, series_id, reviewer_id)
*/

SHOW DATABASES;
SELECT database();

CREATE DATABASE imbd;
USE imdb;

CREATE TABLE reviewers(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL DEFAULT "MISSING",
    last_name VARCHAR(100) NOT NULL DEFAULT "MISSING",
);

DESC reviewers;

CREATE TABLE series(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL DEFAULT "MISSING",
    released_year YEAR(4) NOT NULL,
    genre VARCHAR(100)
);

DESC series;

CREATE TABLE reviews(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    rating DECIMAL(2, 1),
    series_id INT,
    reviewer_id INT,
    FOREIGN KEY(series_id)
        REFERENCES series(id)
            ON DELETE CASCADE,
    FOREIGN KEY(reviewer_id)
        REFERENCES reviewers(id)
            ON DELETE CASCADE
);

DESC reviews;
SHOW TABLES;

/**
* ? query many-to-many table from created reviewers, series, review tables that uses prep data for respective table
*
* ! insert test data into tables and inspect data in reviews
*
* * schema:
* *    reviewers(id, first_name default 'MISSING', last_name default 'MISSING')
* *    series(id, title default "MISSING", released_year 4-digit mandatory, genre)
* *    reviews(id, rating MIN 0.0 to MAX 9.9, series_id, reviewer_id)
*
* * on delete cascade for relevant fields and tables
*/

USE imdb;

INSERT INTO reviewers(first_name, last_name)
VALUES("Ben", "Silver"), ("Lisa", "Newman");

SELECT *
FROM reviewers;

INSERT INTO series(title, released_year, genre)
VALUES ("Breaking Bad", 2007, "drama"), ("Game of Thrones", 2011, "comedy");

SELECT *
FROM series;

INSERT INTO reviews(rating, series_id, reviewer_id)
VALUES (8.0, 1, 1), (6.5, 2, 1), (9.3, 1, 2);

SELECT *
FROM reviews;

/**
* ? query many-to-many table from created reviewers, series, review tables that uses prep data for respective table
*
* ! challenge 1: reproduce the table below (no nulls):

      title | rating

      archer | 8.0
      archer | 7.5
      arrested development | 8.9
      arrested development | 9.9
*
* * schema:
* *    reviewers(id, first_name default 'MISSING', last_name default 'MISSING')
* *    series(id, title default "MISSING", released_year 4-digit mandatory, genre)
* *    reviews(id, rating MIN 0.0 to MAX 9.9, series_id, reviewer_id)
*
* * on delete cascade for relevant fields and tables
*/

SELECT
    series.title AS "title",
    reviews.rating AS "rating"
FROM series
INNER JOIN reviews
    ON series.id = reviews.series_id
ORDER BY series.title;

/**
* ? query many-to-many table from created reviewers, series, review tables that uses prep data for respective table
*
* ! challenge 2: reproduce the table below (no nulls):

    title | avg_rating

    General Hospital | 5.38
    Fargo | 9.40
    Halt and Catch Fire | 9.90
*
* * schema:
* *    reviewers(id, first_name default 'MISSING', last_name default 'MISSING')
* *    series(id, title default "MISSING", released_year 4-digit mandatory, genre)
* *    reviews(id, rating MIN 0.0 to MAX 9.9, series_id, reviewer_id)
*
* * on delete cascade for relevant fields and tables
*/

SELECT
    series.title AS "title",
    ROUND(AVG(reviews.rating), 3) AS "avg_rating"
FROM series
INNER JOIN reviews
    ON series.id = reviews.series_id
GROUP BY series.id
    ORDER BY "avg_rating";

/**
* ? query many-to-many table from created reviewers, series, review tables that uses prep data for respective table
*
* ! challenge 3: reproduce the table below (no nulls):

  first_name | last_name | rating

  Thomas | Stoneman | 8.0
  Wyat | Skaggs | 8.5
  Wyat | Skaggs | 7.5
  Wyat | Skaggs | 9.3
  Kimbra | Masters | 7.1
*
* * schema:
* *    reviewers(id, first_name default 'MISSING', last_name default 'MISSING')
* *    series(id, title default "MISSING", released_year 4-digit mandatory, genre)
* *    reviews(id, rating MIN 0.0 to MAX 9.9, series_id, reviewer_id)
*
* * on delete cascade for relevant fields and tables
*/

SELECT
    reviewers.first_name,
    reviewers.last_name,
    reviews.rating
FROM reviewers
INNER JOIN reviews
    ON reviewers.id = reviews.reviewer_id
ORDER BY reviewers.last_name DESC;

/**
* ? query many-to-many table from created reviewers, series, review tables that uses prep data for respective table
*
* ! challenge 4: reproduce the table below (there will be nulls):

    unreviewed_series

    Malcolm in the Middle
    Pushing Daisies
*
* * schema:
* *    reviewers(id, first_name default 'MISSING', last_name default 'MISSING')
* *    series(id, title default "MISSING", released_year 4-digit mandatory, genre)
* *    reviews(id, rating MIN 0.0 to MAX 9.9, series_id, reviewer_id)
*
* * on delete cascade for relevant fields and tables
*/

SELECT
    series.title AS "unreviewed_series"
FROM series
LEFT JOIN reviews
    ON series.id = reviews.series_id
WHERE reviews.rating IS NULL
    ORDER BY unreviewed_series;

/**
* ? query many-to-many table from created reviewers, series, review tables that uses prep data for respective table
*
* ! challenge 5: reproduce the table below (there will be nulls):

   genre | avg_rating

   Animation | 7.86
   Comedy | 8.16
   Drama | 8.04
*
* * schema:
* *    reviewers(id, first_name default 'MISSING', last_name default 'MISSING')
* *    series(id, title default "MISSING", released_year 4-digit mandatory, genre)
* *    reviews(id, rating MIN 0.0 to MAX 9.9, series_id, reviewer_id)
*
* * on delete cascade for relevant fields and tables
*/

SELECT
    series.genre,
    ROUND(
        AVG(rating),
        2)
    AS "avg_rating"
FROM reviews
LEFT JOIN series
    ON reviews.series_id = series.id
GROUP BY series.genre
    ORDER BY series.genre, "avg_rating";

/**
* ? query many-to-many table from created reviewers, series, review tables that uses prep data for respective table
*
* ! challenge 6: reproduce the table below (there will be nulls):

   first_name | last_name | COUNT | MIN | MAX | AVG | STATUS

   thomas  | stoneman | 5  | 7.0  | 9.5 | 8.02 | ACTIVE
   wyatt   | skaggs   | 9  | 5.5  | 9.3 | 7.80 | ACTIVE
   colt    | steele   | 10 | 4.5  | 9.9 | 8.77 | POWER USER
   marlon  | crafford | 0  | 0    | 0   | 0.00 | INACTIVE
*
* * schema:
* *    reviewers(id, first_name default 'MISSING', last_name default 'MISSING')
* *    series(id, title default "MISSING", released_year 4-digit mandatory, genre)
* *    reviews(id, rating MIN 0.0 to MAX 9.9, series_id, reviewer_id)
*
* * on delete cascade for relevant fields and tables
*/

SELECT
    reviewers.first_name,
    reviewers.last_name,
    IFNULL(
        COUNT(reviews.id),
        0) AS "COUNT",
    IFNULL(
        ROUND(
            MIN(reviews.rating),
            1),
         0) AS "MIN",
    IFNULL(
        ROUND(
            MAX(reviews.rating),
            1),
         0) AS "MAX",
    IFNULL(
        ROUND(
            AVG(reviews.rating),
            2),
        0.00) AS "AVG"
    CASE
        WHEN COUNT(reviews.rating) >= 10
            THEN UPPER("power user")
        WHEN COUNT(reviews.rating) > 0
            AND COUNT(reviews.rating) < 10
                THEN UPPER("active")
        ELSE
            UPPER("inactive")
    END AS UPPER("status")
FROM reviews
LEFT JOIN reviewers
    ON reviews.reviewer_id = reviewer.id
LEFT JOIN series
    ON reviews.series_id = series.id
GROUP BY reviews.id
    ORDER BY "MIN"

/**
* ? query many-to-many table from created reviewers, series, review tables that uses prep data for respective table
*
* ! challenge 7: reproduce the table below (no nulls):

    title | rating | reviewer

    archer | 8.0 | thomas stoneman
    archer | 7.0 | domingo cortes
    archer | 8.5 | kimbra masters
    arrested development | 8.4 | pinkie petit
    arrested development | 9.9 | colt steele
    bobs burgers | 7.0 | thomas stoneman
*
* * schema:
* *    reviewers(id, first_name default 'MISSING', last_name default 'MISSING')
* *    series(id, title default "MISSING", released_year 4-digit mandatory, genre)
* *    reviews(id, rating MIN 0.0 to MAX 9.9, series_id, reviewer_id)
*
* * on delete cascade for relevant fields and tables
*/

SELECT
    series.title,
    reviews.rating,
    CONCAT(reviewer.first_name, " ", reviewer.last_name) AS "reviewer"
FROM reviews
INNER JOIN series
    ON reviews.series_id = series.id
INNER JOIN reviewers
    ON reviews.reviewer_id = reviewers.id
ORDER BY series.title

/**
* ! manage a music db
*
* ? create a music db and create the 3 linked tables (many-to-many) in the music db
* ?     deleting row structure managed & order of table creation matters
*
* * schema:
*
* *    albums_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *    name VARCHAR NOT NULL, artist INT),
*
* *    artists_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *    name VARCHAR NOT NULL),
*
* *    songs_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *       track INT NOT NULL, title VARCHAR NOT NULL DEFAULT "MISSING",
* *       album INT)
*/

CREATE DATABASE music_db;

SHOW DATABASES;
SELECT database();
USE music_db;

CREATE TABLE artists_table(
    _id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(10) NOT NULL
);

DESC artists_table;

CREATE TABLE albums_table(
    _id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    artist INT NOT NULL,
    FOREIGN KEY(artist)
        REFERENCES artists_table(_id)
        ON DELETE CASCADE
);

DESC albums_table;

CREATE TABLE songs_table(
    _id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    track INT NOT NULL,
    title VARCHAR(20) NOT NULL DEFAULT "MISSING",
    album INT,
    FOREIGN KEY(album)
        REFERENCES albums_table(_id)
        ON DELETE CASCADE
);

DESC songs_table;

SHOW TABLES;

/**
* ! manage a music db
*
* ? create a music db and create the 3 linked tables (many-to-many) in the music db
* ?     deleting row structure managed & order of table creation matters
*
* * schema:
*
* *    albums_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *    name VARCHAR NOT NULL, artist INT),
*
* *    artists_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *    name VARCHAR NOT NULL),
*
* *    songs_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *       track INT NOT NULL, title VARCHAR NOT NULL DEFAULT "MISSING",
* *       album INT)
*/

/**
* ! manage a music db
*
* ? create an artist_list as a view that prints only valid data
*
* ?    artists.name, albums.name,
* ?    and songs.track for a single query
*
* * schema:
*
* *    albums_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *    name VARCHAR NOT NULL, artist INT),
*
* *    artists_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *    name VARCHAR NOT NULL),
*
* *    songs_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *       track INT NOT NULL, title VARCHAR NOT NULL DEFAULT "MISSING",
* *       album INT)
*/

CREATE VIEW
    artist_list AS
SELECT
    artists_table.name AS artist,
    albums_table.name AS album,
    songs_table.track AS track
FROM songs_table
INNER JOIN albums_table
    ON songs_table.album = albums_table._id
INNER JOIN artists_table
    ON albums_table.artist = artists_table._id;

/**
* ! manage a music db
*
* ? get data for artists name, albums name, and songs track
* ?     from artist_list view and order by artists, albums, and then songs
*
* * schema:
*
* *    albums_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *    name VARCHAR NOT NULL, artist INT),
*
* *    artists_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *    name VARCHAR NOT NULL),
*
* *    songs_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *       track INT NOT NULL, title VARCHAR NOT NULL DEFAULT "MISSING",
* *       album INT)
*/

SELECT
    artist,
    album,
    track
FROM artist_list;

/**
* ! manage a music db
*
* ? remove artists_list view
*
* * schema:
*
* *    albums_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *    name VARCHAR NOT NULL, artist INT),
*
* *    artists_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *    name VARCHAR NOT NULL),
*
* *    songs_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *       track INT NOT NULL, title VARCHAR NOT NULL DEFAULT "MISSING",
* *       album INT)
*/

DROP VIEW artists_list;

/**
* ! manage a music db
*
* ? get the valid titles of all the songs on the album forbidden
*
* * schema:
*
* *    albums_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *    name VARCHAR NOT NULL, artist INT),
*
* *    artists_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *    name VARCHAR NOT NULL),
*
* *    songs_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *       track INT NOT NULL, title VARCHAR NOT NULL DEFAULT "MISSING",
* *       album INT)
*/

SELECT
    albums_table.name,
    songs_table.title
FROM songs_table
INNER JOIN albums_table
    ON songs_table.album = albums_table._id
WHERE albums_table.name = "Forbidden";

/**
* ! manage a music db
*
* ? print the valid titles of all the songs on the album forbidden
* ? but display in track order and include track number for verification
*
* * schema:
*
* *    albums_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *    name VARCHAR NOT NULL, artist INT),
*
* *    artists_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *    name VARCHAR NOT NULL),
*
* *    songs_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *       track INT NOT NULL, title VARCHAR NOT NULL DEFAULT "MISSING",
* *       album INT)
*/

SELECT
    albums_table.name,
    songs_table.title,
    songs_table.track
FROM songs_table
INNER JOIN albums_table
    ON songs_table.album = albums_table._id
WHERE albums_table.name = "Forbidden"
    ORDER BY songs_table.track DESC;

/**
* ! manage a music db
*
* ? display all valid tracks and respective songs by the band 'Deep Purple'
* ?     order of query structure matters
*
* * schema:
*
* *    albums_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *    name VARCHAR NOT NULL, artist INT),
*
* *    artists_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *    name VARCHAR NOT NULL),
*
* *    songs_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *       track INT NOT NULL, title VARCHAR NOT NULL DEFAULT "MISSING",
* *       album INT)
*/

SELECT
    artists_table.name AS "artist",
    songs_table.track AS "track",
    songs_table.title AS "title"
FROM songs_table
INNER JOIN albums_table
    ON songs_table.album = albums_table._id
INNER JOIN artists_table
    ON albums_table.artist = artists_table._id
WHERE artists_table.name = "Deep Purple"
    ORDER BY songs_table.track DESC

/**
* ! manage a music db
*
* ? rename band 'Mehitabel' to 'One Kitten' and verify
*
* * HINT: all data needs to be valid
* * BEST PRACTICE: SELECT data first, that UPDATE db
*
* * schema:
*
* *    albums_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *    name VARCHAR NOT NULL, artist INT),
*
* *    artists_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *    name VARCHAR NOT NULL),
*
* *    songs_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *       track INT NOT NULL, title VARCHAR NOT NULL DEFAULT "MISSING",
* *       album INT)
*/

SELECT *
FROM artists_table
    WHERE artists_table.name = "Mehitabel";

UPDATE artists_table
    SET artists_table.name = "One Kitten"
    WHERE artists_table.name = "Mehitabel";

/**
* ! manage a music db
*
* ? retrieve song titles by Aerosmith in alphabetical order, only print title
*
* * schema:
*
* *    albums_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *    name VARCHAR NOT NULL, artist INT),
*
* *    artists_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *    name VARCHAR NOT NULL),
*
* *    songs_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *       track INT NOT NULL, title VARCHAR NOT NULL DEFAULT "MISSING",
* *       album INT)
*/

SELECT
    songs_table.title
FROM songs_table
INNER JOIN albums_table
    ON songs_table.album = albums_table._id
INNER JOIN artists_table
    ON albums_table.artist = artists_table._id
WHERE artists_table.name = "Aerosmith"
    ORDER BY songs_table.title;

/**
*
* ! manage a music db
*
* ? retrieve the count of song titles by Aerosmith & only print the count as count
*
* * schema:
*
* *    albums_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *    name VARCHAR NOT NULL, artist INT),
*
* *    artists_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *    name VARCHAR NOT NULL),
*
* *    songs_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *       track INT NOT NULL, title VARCHAR NOT NULL DEFAULT "MISSING",
* *       album INT)
*/

-- COUNT(*) = count all data rows
-- COUNT(*) w/ GROUP BY = count all subrows under a collective banner

SELECT
    COUNT(*) AS "count"
FROM songs_table
INNER JOIN albums_table
    ON songs_table.album = albums_table._id
INNER JOIN artists_table
    ON albums_table.artist = artists_table._id
GROUP BY artists_table._id
    WHERE artists_table.name = "Aerosmith";

/**
*
* ! manage a music db
*
* ? your customer only wants titles by Aerosmith in alphabetical order
*
* * search the internet on how to make query without duplicates for below:
*
* * schema:
*
* *    artists_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *                 name VARCHAR NOT NULL)
*
* *    albums_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *                 name VARCHAR NOT NULL,
* *                 artist INT)
*
* *    songs_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *               track INT NOT NULL,
* *               title VARCHAR NOT NULL DEFAULT "MISSING",
* *               album INT)
*/

SELECT
    DISTINCT titles
FROM artists_table
INNER JOIN albums_table
    ON artists_table._id = albums_table.artist
INNER JOIN songs_table
    ON albums_table._id = songs_table.album
WHERE artists_table.name = "Aerosmith"
    ORDER BY songs_table.title DESC;

/**
* ! manage a music db
*
* ? your client wants to know the count of all the titles by Aerosmith; label as "title count"
*
* * search the internet on how to make query without duplicates for below:
*
* * schema:
*
* *    artists_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *                 name VARCHAR NOT NULL)
*
* *    albums_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *                 name VARCHAR NOT NULL,
* *                 artist INT)
*
* *    songs_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *               track INT NOT NULL,
* *               title VARCHAR NOT NULL DEFAULT "MISSING",
* *               album INT)
*/

SELECT
    COUNT(
        DISTINCT songs_table.title
    ) AS "title count"
FROM songs_table
INNER JOIN albums_table
    ON songs_table.album = albums_table._id
INNER JOIN artists_table
    ON albums_table.artist = artists_table._id
GROUP BY artists_table._id
WHERE artists_table.name = "Aerosmith"

/**
*
* ! manage a music db
*
* ? find the number of unique albums by artist & order highest-to-lowest
*
* * search the internet on how to make query without duplicates for below:
*
* * schema:
*
* *    artists_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *                 name VARCHAR NOT NULL)
*
* *    albums_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *                 name VARCHAR NOT NULL,
* *                 artist INT)
*
* *    songs_table(_id INT AUTO_INCREMENT PRIMARY KEY,
* *               track INT NOT NULL,
* *               title VARCHAR NOT NULL DEFAULT "MISSING",
* *               album INT)
*/

SELECT
    artists_table.name,
    COUNT(
        DISTINCT albums_table.name
    ) AS "unique numAlbums"
FROM albums_table
INNER JOIN artists_table
    ON albums_table.artist = artists_table._id
GROUP BY artists_table._id
    ORDER BY 2 DESC;

/**
*
* ! instagram challenges
*
* ? create many-to-many tables for ig_db
*
* * db schema:
*
* *   users:
*       id,
*       username (mandatory & one-of-a-kind),
*       created_at (current date & time)
* *   photos:
*       id,
*       image_url mandatory,
*       created_at,
*       user_id (mandatory & foreign key)
* *   comments:
*       id,
*       comment_text mandatory,
*       photo_id (foreign key),
*       created_at (current date & time),
*       user_id (foreign key),
* *   likes:
*       created_at (current date & time),
*       user_id (foreign key),
*       photo_id (foreign key),
*       primary key order: user_id & photo_id
* *   follows:
*       created_at (current date & time),
*       follow_id *foreign key,
*       followee_id *foreign key,
*       primary key order: user_id & photo_id
* *   tags:
*       id,
*       tag_name unique,
*       created_at (current date time)
* *   photo_tags:
*       photo_id (foreign key),
*       tag_id (foreign key),
*       primary key order: user_id & photo_id
*/

SHOW DATABASES;
SELECT database();

CREATE DATABASE ig_db;
USE ig_db;

CREATE TABLE users(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(20) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT NOW()
);

DESC users;
SHOW TABLES;

CREATE TABLE photos(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(100) NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    user_id INT NOT NULL,
    FOREIGN KEY(user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
);

DESC photos;

CREATE TABLE comments(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    comment_text VARCHAR(500) NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    photo_id INT NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY(photo_id)
        REFERENCES photos(id)
        ON DELETE CASCADE,
    FOREIGN KEY(user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
);

DESC comments;

CREATE TABLE likes(
    created_at DATETIME DEFAULT NOW(),
    user_id INT NOT NULL,
    photo_id INT NOT NULL,
    FOREIGN KEY(user_id)
        REFERENCES users(id)
        ON DELETE CASCADE,
    FOREIGN KEY(photo_id)
        REFERENCES photos(id)
        ON DELETE CASCADE,
    PRIMARY KEY(user_id, photo_id)
);

DESC likes;

CREATE TABLE follows(
    created_at DATETIME DEFAULT NOW(),
    follower_id INT NOT NULL,
    followee_id INT NOT NULL,
    FOREIGN KEY(follower_id)
        REFERENCES users(id)
        ON DELETE CASCADE,
    FOREIGN KEY(followee_id)
        REFERENCES users(id)
        ON DELETE CASCADE,
    PRIMARY KEY(follower_id, followee_id)
);

DESC follows;

CREATE TABLE tags(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(255) UNIQUE,
    created_at DATETIME DEFAULT NOW()
);

DESC tags;

CREATE TABLE photo_tags(
    photo_id INT NOT NULL,
    tag_id INT NOT NULL,
    FOREIGN KEY(photo_id)
        REFERENCES photos(id)
        ON DELETE CASCADE,
    FOREIGN KEY(tag_id)
        REFERENCES tags(id)
        ON DELETE CASCADE,
    PRIMARY KEY(photo_id, tag_id)
);

DESC photo_tags;
SHOW TABLES;

/**
*
* ! instagram challenges
*
* ? we want to reward our users who have been around the longest, find the 5 oldest users
*
* * db schema:
*
* *   users:
*       id,
*       username (mandatory & one-of-a-kind),
*       created_at (current date & time)
* *   photos:
*       id,
*       image_url mandatory,
*       created_at,
*       user_id (mandatory & foreign key)
* *   comments:
*       id,
*       comment_text mandatory,
*       photo_id (foreign key),
*       created_at (current date & time),
*       user_id (foreign key),
* *   likes:
*       created_at (current date & time),
*       user_id (foreign key),
*       photo_id (foreign key),
*       primary key order: user_id & photo_id
* *   follows:
*       created_at (current date & time),
*       follow_id *foreign key,
*       followee_id *foreign key,
*       primary key order: user_id & photo_id
* *   tags:
*       id,
*       tag_name unique,
*       created_at (current date time)
* *   photo_tags:
*       photo_id (foreign key),
*       tag_id (foreign key),
*       primary key order: user_id & photo_id
*/

SELECT *
FROM users
ORDER BY created_at DESC
    LIMIT 5;

/**
*
* ! instagram challenges
*
* ? what day of the week do most users register on (labeled: most popular registration day),
* ? we need to figure out when to schedule an ad campaign
*
* * HINT: https://www.mssqltips.com/sqlservertip/2655/format-sql-server-dates-with-format-function/
*
* * db schema:
*
* *   users:
*       id,
*       username (mandatory & one-of-a-kind),
*       created_at (current date & time)
* *   photos:
*       id,
*       image_url mandatory,
*       created_at,
*       user_id (mandatory & foreign key)
* *   comments:
*       id,
*       comment_text mandatory,
*       photo_id (foreign key),
*       created_at (current date & time),
*       user_id (foreign key),
* *   likes:
*       created_at (current date & time),
*       user_id (foreign key),
*       photo_id (foreign key),
*       primary key order: user_id & photo_id
* *   follows:
*       created_at (current date & time),
*       follow_id *foreign key,
*       followee_id *foreign key,
*       primary key order: user_id & photo_id
* *   tags:
*       id,
*       tag_name unique,
*       created_at (current date time)
* *   photo_tags:
*       photo_id (foreign key),
*       tag_id (foreign key),
*       primary key order: user_id & photo_id
*/

SELECT
    DAYNAME(created_at) AS "most popular registration day",
    COUNT(*) AS "total count"
FROM users
GROUP BY DAYNAME(created_at)
    ORDER BY "total count" DESC
    LIMIT 1;

/**
*
* ! instagram challenges
*
* ? we want to target our inactive users with an email campaign
* ? find the users who have never posted a photo
*
* * db schema:
*
* *   users:
*       id,
*       username (mandatory & one-of-a-kind),
*       created_at (current date & time)
* *   photos:
*       id,
*       image_url mandatory,
*       created_at,
*       user_id (mandatory & foreign key)
* *   comments:
*       id,
*       comment_text mandatory,
*       photo_id (foreign key),
*       created_at (current date & time),
*       user_id (foreign key),
* *   likes:
*       created_at (current date & time),
*       user_id (foreign key),
*       photo_id (foreign key),
*       primary key order: user_id & photo_id
* *   follows:
*       created_at (current date & time),
*       follow_id *foreign key,
*       followee_id *foreign key,
*       primary key order: user_id & photo_id
* *   tags:
*       id,
*       tag_name unique,
*       created_at (current date time)
* *   photo_tags:
*       photo_id (foreign key),
*       tag_id (foreign key),
*       primary key order: user_id & photo_id
*/

SELECT
    users.username,
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
WHERE photos.id IS NULL;

/**
*
* ! instagram challenges
*
* ? we're running a new contest to see
* ? who can get the most likes on a single photo, which user won?
*
* * db schema:
*
* *   users:
*       id,
*       username (mandatory & one-of-a-kind),
*       created_at (current date & time)
* *   photos:
*       id,
*       image_url mandatory,
*       created_at,
*       user_id (mandatory & foreign key)
* *   comments:
*       id,
*       comment_text mandatory,
*       photo_id (foreign key),
*       created_at (current date & time),
*       user_id (foreign key),
* *   likes:
*       created_at (current date & time),
*       user_id (foreign key),
*       photo_id (foreign key),
*       primary key order: user_id & photo_id
* *   follows:
*       created_at (current date & time),
*       follow_id *foreign key,
*       followee_id *foreign key,
*       primary key order: user_id & photo_id
* *   tags:
*       id,
*       tag_name unique,
*       created_at (current date time)
* *   photo_tags:
*       photo_id (foreign key),
*       tag_id (foreign key),
*       primary key order: user_id & photo_id
*/

SELECT
    users.username,
    photos.image_url,
    COUNT(*) AS "most liked photo"
FROM users
INNER JOIN photos
    ON users.id = photos.user_id
INNER JOIN likes
    ON photos.id = likes.photo_id
GROUP BY photos.id
    ORDER BY "most liked photo" DESC
    LIMIT 1;

/**
*
* ! instagram challenges
*
* ? our investors want to know, how many times does the average user post?
*
* * HINT: calculate avg number of photos per user = totalNumPhotos / totalNumUsers
*
* * db schema:
*
* *   users:
*       id,
*       username (mandatory & one-of-a-kind),
*       created_at (current date & time)
* *   photos:
*       id,
*       image_url mandatory,
*       created_at,
*       user_id (mandatory & foreign key)
* *   comments:
*       id,
*       comment_text mandatory,
*       photo_id (foreign key),
*       created_at (current date & time),
*       user_id (foreign key),
* *   likes:
*       created_at (current date & time),
*       user_id (foreign key),
*       photo_id (foreign key),
*       primary key order: user_id & photo_id
* *   follows:
*       created_at (current date & time),
*       follow_id *foreign key,
*       followee_id *foreign key,
*       primary key order: user_id & photo_id
* *   tags:
*       id,
*       tag_name unique,
*       created_at (current date time)
* *   photo_tags:
*       photo_id (foreign key),
*       tag_id (foreign key),
*       primary key order: user_id & photo_id
*/

SELECT(
    SELECT COUNT(*) FROM photos / SELECT COUNT(*) FROM users
) AS avg;

/**
*
* ! instagram challenges
*
* ? our brand advertisors want to know which hashtags to use in a post,
* ? what are the top 5 most commonly used hashtags (label as 'total')?
*
* * db schema:
*
* *   users:
*       id,
*       username (mandatory & one-of-a-kind),
*       created_at (current date & time)
* *   photos:
*       id,
*       image_url mandatory,
*       created_at,
*       user_id (mandatory & foreign key)
* *   comments:
*       id,
*       comment_text mandatory,
*       photo_id (foreign key),
*       created_at (current date & time),
*       user_id (foreign key),
* *   likes:
*       created_at (current date & time),
*       user_id (foreign key),
*       photo_id (foreign key),
*       primary key order: user_id & photo_id
* *   follows:
*       created_at (current date & time),
*       follow_id *foreign key,
*       followee_id *foreign key,
*       primary key order: user_id & photo_id
* *   tags:
*       id,
*       tag_name unique,
*       created_at (current date time)
* *   photo_tags:
*       photo_id (foreign key),
*       tag_id (foreign key),
*       primary key order: user_id & photo_id
*/

USE ig_db;
DESC tags;

SELECT
    tags.tag_name,
    COUNT(*) AS total
FROM tags
INNER JOIN photo_tags
    ON tags.id = photo_tags.tag_id
GROUP BY tags.id
    ORDER BY total DESC
    LIMIT 5;

/**
*
* ! instagram challenges
*
* ? we have a small problem w/ bots on our site,
* ? find users who have liked every single photo on the site
*
* * HINT: we want overlap only; WHERE does not work bc WHERE goes before GROUP BY
*
* * db schema:
*
* *   users:
*       id,
*       username (mandatory & one-of-a-kind),
*       created_at (current date & time)
* *   photos:
*       id,
*       image_url mandatory,
*       created_at,
*       user_id (mandatory & foreign key)
* *   comments:
*       id,
*       comment_text mandatory,
*       photo_id (foreign key),
*       created_at (current date & time),
*       user_id (foreign key),
* *   likes:
*       created_at (current date & time),
*       user_id (foreign key),
*       photo_id (foreign key),
*       primary key order: user_id & photo_id
* *   follows:
*       created_at (current date & time),
*       follow_id *foreign key,
*       followee_id *foreign key,
*       primary key order: user_id & photo_id
* *   tags:
*       id,
*       tag_name unique,
*       created_at (current date time)
* *   photo_tags:
*       photo_id (foreign key),
*       tag_id (foreign key),
*       primary key order: user_id & photo_id
*/

SELECT
    users.id,
    users.username,
    COUNT(*) AS "num_likes"
FROM users
INNER JOIN likes
    ON users.id = likes.user_id
GROUP BY users.id
    HAVING num_likes = (
        SELECT
            COUNT(*) AS "total_likes"
        FROM likes
            ORDER BY "total_likes" DESC
            LIMIT 1
    );



