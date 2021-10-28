// in goormIDE terminal from project directory, execute: 
// node app.js

// SQL formatter
// https://www.dpriver.com/pp/sqlformat.htm

const users_schema = `
CREATE TABLE users(
  email VARCHAR(255),
  created_at TIMESTAMP DEFAULT NOW()
);
`;

/**
 * ? What is the earliest date a user joined in the bulk dataset?
 * * need clean dataset using CREATE TABLE users
 */

// // solution 1
// const q = `
// SELECT DATE_FORMAT(created_at, '%M %D %Y') AS earliest_date
// FROM   users
// ORDER  BY created_at
// LIMIT 1;
// `;

// // solution 2
// const q = `
// SELECT DATE_FORMAT(MIN(created_at), '%M %D %Y') AS earliest_date 
// FROM users;
// `;

// connection.query(q, function(err, results, fields){
//   if(err) throw err;
//   console.log(results[0]);
// });

// connection.end();

/**
 * ? What is the email of the earliest user in the bulk dataset?
 * * need clean dataset using CREATE TABLE users
 */

// // solution 1
// const q = `
// SELECT email,
// FROM   users
// ORDER  BY created_at
// LIMIT  1; 
// `;

// // solution 2
// const q = `
// SELECT email
// FROM   users
// WHERE  created_at = (SELECT Min(created_at)
//                      FROM   users); 
// `;

// connection.query(q, function(err, results, fields){
//   if(err) throw err;
//   console.log(results[0]);
// });

// connection.end();

/**
 * ? create table according to the month they joined
 * * need clean dataset using CREATE TABLE users
 */

// // solution 1
// const q = `
// SELECT Date_format(created_at, '%M') AS month,
//        Count(*)                      AS count
// FROM   users
// GROUP  BY month
// ORDER  BY count DESC; 
// `;

// // solution 2
// const q = `
// SELECT Monthname(created_at) AS month,
//        Count(*)              AS count
// FROM   users
// GROUP  BY month
// ORDER  BY count DESC; 
// `;

// connection.query(q, function(err, results, args){
//   if(err) throw err;
//   console.log(results);
// });

// connection.end();

/**
 * ? what is the number of users with yahoo emails?
 * * need clean dataset using CREATE TABLE users
 */

// const q = `
// SELECT Count(*) AS yahoo_users
// FROM   users
// WHERE  email LIKE '%@yahoo.com'; 
// `;

// connection.query(q, function(err, results, args) {
//   if(err) throw err;
//   console.log(results);
// });

// connection.end();

/**
 * ? what is the total number of users for each email host?
 * * need clean dataset using CREATE TABLE users
 */

// const q = `
// SELECT CASE
//          WHEN email LIKE '%gmail.com' THEN 'gmail'
//          WHEN email LIKE '%yahoo.com' THEN 'yahoo'
//          WHEN email LIKE '%hotmail.com' THEN 'hotmail'
//          ELSE 'other'
//        END      AS provider,
//        Count(*) AS total_users
// FROM   users
// GROUP  BY provider
// ORDER  BY total_users DESC; 
// `;

// connection.query(q, function(err, results, args){
//   if(err) throw err;
//   console.log(results);
// });

// connection.end();

/**
 * ? create a tweets table
 * * structure: username(15 max char), content(140 max char), num_favorites
 */

// CREATE TABLE tweets(
//   username VARCHAR(15),
//   content VARCHAR(140),
//   favorites INT
// );

/**
 * ? create, describe, and delete pastries table
 * * structure: name(50 max), quantity
 */

// CREATE TABLE pastries(
//   name VARCHAR(50),
//   quantity INT
// );

// SHOW TABLES;

// DESC pastries;

// DROP TABLE pastries;

/**
 * ? create people table, insert into people table, verify new data
 * * structure: first_name(20 char limit), last_name(20 char limit), age
 * * new data: Tina Belcher 13
 */

// CREATE TABLE people(
//   first_name VARCHAR(20),
//   last_name VARCHAR(20),
//   age INT
// );

// INSERT INTO people(first_name, last_name, age)
// VALUES ('Tina', 'Belcher', 13), ('Bob', 'Belcher', 42);

// // order of args is user defined, but new data has to align with provided order of args
// INSERT INTO people(age, first_name, last_name)
// VALUES (70, 'Calvin', 'Fish'), (38, 'Philip', 'Frond');

// SELECT *
// FROM people;

/**
 * ? create, view, and insert into employees table
 * * structure: id (auto_increment number), first_name(255 char limit, mandatory), last_name(255 char limit, mandatory), 
 * * middle_name (255 char limit, optional), age(number, mandatory), current_status(text, mandatory, defaults: employed)
 */

// // option 1 
// CREATE TABLE employees (
//   id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
//   first_name VARCHAR(255) NOT NULL,
//   last_name VARCHAR(255) NOT NULL,
//   middle_name VARCHAR(255),
//   age INT NOT NULL,
//   current_status VARCHAR(255) NOT NULL DEFAULT 'employed'
// );

// // option 2
// CREATE TABLE employees (
//   id INT AUTO_INCREMENT NOT NULL,
//   first_name VARCHAR(255) NOT NULL,
//   last_name VARCHAR(255) NOT NULL,
//   middle_name VARCHAR(255),
//   age INT NOT NULL,
//   current_status VARCHAR(255) NOT NULL DEFAULT 'employed',
//   PRIMARY KEY(id)
// );

// DESC employees;

// INSERT INTO employees(first_name, last_name, age) VALUES
// ('Dora', 'Smith', 58);

/**
 * ? create cats table, select only cat_id(s), select name and breed, select cats where cat_id = age
 * * structure: cat_id (auto_increment), name(255 char limit), breed(255 char limit), age
 */

// CREATE TABLE cats(
//   cat_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
//   name VARCHAR(255) NOT NULL DEFAULT 'MISSING',
//   breed VARCHAR(255) NOT NULL DEFAULT 'TBD'
//   age INT NOT NULL DEFAULT 0,
// );

// SELECT cat_id
// FROM cats
// ORDER BY cat_id;

// SELECT name, breed
// FROM cats;

// SELECT name, age
// FROM cats
// WHERE breed = 'Tabby';

// SELECT cat_id, age
// FROM cats
// WHERE cat_id = age;

/**
 * ? update cats table
 * * structure: cat_id, name, breed, age
 */

// view data first, than update Jackson's name to Jack
// SELECT *
// FROM cats
//   WHERE name='Jackson';

// UPDATE cats
//   SET name='Jack'
//     WHERE name='Jackson';

// // view data first, than update Ringo's breed to British Shorthair
// SELECT *
// FROM cats
//   WHERE name='Ringo';

// UPDATE cats
//   SET breed='British Shorthair'
//     WHERE name='Ringo';

// // view data first, than update both Maine Coons' ages to 12
// SELECT *
// FROM cats
//   WHERE breed='Maine Coon';

// UPDATE cats
//   SET age=12
//     WHERE breed='Maine Coon';

/**
 * ? delete data from cats table
 * * structure: cat_id, name, breed, age
 */

// // delete all 4 year old cats
// SELECT *
// FROM cats
//   WHERE age = 4;

// DELETE FROM cats
//   WHERE age = 4;

// // delete all cats whose age is the same as their cat_id
// SELECT *
// FROM cats
//   WHERE cat_id = age;

// DELETE FROM cats
//   WHERE cat_id = age;

// // delete all cats
// SELECT *
// FROM cats;

// DELETE *
// FROM cats;

/**
 * ? CRUD challenge: create db, use db, create table shirts, and test insert data
 * * structure: shirt_id (auto_increment), article(max 100 char), color(max 100 char), shirt_size(max 4 char), last_worn(int default 0)
 */

// // create and use shirts db
// SELECT database();

// CREATE DATABASE shirts_db;
// USE shirts_db;
// SELECT database();

// // create table
// CREATE TABLE shirts(
//   shirt_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
//   article VARCHAR(100) NOT NULL,
//   color VARCHAR(100) NOT NULL,
//   shirt_size CHAR(4) NOT NULL,
//   last_worn INT DEFAULT 0
// );

// DESC shirts;

// INSERT INTO shirts(article, color, shirt_size, last_worn)
// VALUES('t-shirt', 'white', 'S', 10);

// SELECT *
// FROM shirts;

/**
 * ? CRUD challenge: read data from shirts table
 * * structure: shirt_id (auto_increment), article(max 100 char), color(max 100 char), shirt_size(max 4 char), last_worn(int default 0)
 */

// // read all shirts but print only article and color
// SELECT article, color
// FROM shirts;

// // read only medium shirts, print everything but print shirt_id
// SELECT article, color, shirt_size, last_worn
// FROM shirts
// WHERE shirt_size = 'M';

/**
 * ? CRUD challenge: update data from shirts table
 * * structure: shirt_id (auto_increment), article(max 100 char), color(max 100 char), shirt_size(max 4 char), last_worn(int default 0)
 */

// // update all articles of polo shirts to size L
// SELECT *
// FROM shirts
// WHERE shirt_size = 'L';

// UPDATE shirts
//   SET shirt_size = 'L'
//   WHERE article = 'polo shirt';

// // update the shirt last worn 15 days ago to last_worn = 0
// SELECT *
// FROM shirts
// WHERE last_worn = 15;

// UPDATE shirts
//   SET last_worn = 0
//   WHERE last_worn = 15;

// // update multiple fields with all white shirts to have a shirt_size of 'XS' and color of 'off white'
// SELECT *
// FROM shirts
// WHERE color = 'white';

// UPDATE shirts
//   SET shirt_size = 'XS', color = 'off white'
//   WHERE color = 'white';

/**
 * ? CRUD challenge: delete data from shirts table
 * * structure: shirt_id (auto_increment), article(max 100 char), color(max 100 char), shirt_size(max 4 char), last_worn(int default 0)
 */

// // delete all old shirts that were last_worn 200 days ago
// SELECT *
// FROM shirts
// WHERE last_worn = 200;
// 
// DELETE FROM shirts
// WHERE last_worn = 200;
// 
// // delete all tank tops
// SELECT *
// FROM shirts
// WHERE article='tank top';
// 
// DELETE FROM shirts
// WHERE article = 'tank top';
// 
// // delete all shirts but keep table
// SELECT * 
// FROM shirts;
// 
// DELETE FROM shirts;
// 
// // delete table
// DROP TABLE shirts;
// 
// SHOW TABLES;

/**
 * ? string challenges
 * * structure: title, author_fname, author_lname, released_year, stock_quantity
 */

// // reverse and uppercase the following sentence
// // "Why does my cat look at me with such hatred?"

// SELECT REVSERSE(UPPER('Why does my cat look at me with such hatred?'));

// // what does the below SQL query do?

// SELECT
//   REPLACE(
//     CONCAT('I', ' ','like', ' ', 'cats'), ' ', '_')
//   );

// output: I_like_cats

// // replace spaces in titles with '->' with alias title

// SELECT
//   REPLACE(title, ' ', '->') AS title
// FROM books;

// // print out author_lname and backwards author_lname in respective columns forward and backwards

// SELECT 
//   author_lname AS forwards,
//   REVERSE(author_lname) AS backwards
// FROM books

// // print out full author name (author_fname, author_lname) in caps with alias full name in caps

// SELECT
//   UPPER(
//     CONCAT_WS(' ', author_fname, author_lname)
//   ) AS 'full name in caps'
// FROM books;

// // print alias blurb with row: {title} was released in {released_year}

// SELECT 
//   CONCAT(
//     title, ' was released in ', released_year
//   ) AS blurb
// FROM books;

// // print title and alias character count as the length of each title

// SELECT 
//   title,
//   CHAR_LENGTH(title) AS 'character count'
// FROM books;

// // print short title (first 10 chars and ...), author (author_lname, author_fname), quantity ({num_in_stock} in stock)

// SELECT
//   CONCAT(
//     SUNSTRING(title, 1, 10), 
//     '...'
//   ) AS 'short title',
//   CONCAT_WS(',', author_lname, author_fname) AS author,
//   CONCAT(stock_quantity, ' in stock'
//   ) AS quantity
// FROM books;

/**
 * ? Refining SELECT query for books db
 * * structure: author_fname, author_lname, pages, title, released_year, stock_quantity
 */

// // select all story collections: titles that contain 'stories'

// SELECT title
// FROM   books
// WHERE  title LIKE '%stories%'
// ORDER  BY title DESC; 

// // find the longest book: print out the title and page count

// SELECT title, pages
// FROM books
// ORDER BY pages DESC;
// LIMIT 1;

// // print summary containing the title and released_year, for the 3 most recent books

// SELECT
//   CONCAT_WS(
//     ' - ', title, released_year
//   ) AS 'summary'
// FROM books
// ORDER BY released_year DESC
// LIMIT 3;

// // find all the books (title with an author_lname) that contains a space (" ")

// SELECT title, author_lname
// FROM books
// WHERE author_lname LIKE '% %'
// ORDER BY title DESC;

// // find the 3 books with the lowest stock: select title, released_year, and stock

// SELECT 
//   title, 
//   released_year, 
//   stock_quantity
// FROM books
// ORDER BY stock_quantity
// LIMIT 3;

// // print the title, author_lname: sorted by author_lname and then by title

// SELECT
//   title,
//   author_lname
// FROM books
// ORDER BY author_lname, title;

// // sort alphabetically by last name and labeled as yell: 'MY FAVORITE AUTHOR IS {author_fname} {author_lname}!'

// SELECT
//     UPPER(
//       CONCAT(
//         'my favorite author is ' + author_fname + ' ' + author_lname + '!'
//       )
//     ) AS 'yell'
// FROM books
// ORDER BY author_lname;