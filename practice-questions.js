// in goormIDE terminal from project directory, execute:
// node app.js

// SQL formatter
// https://www.dpriver.com/pp/sqlformat.htm

/**
 * ? create a tweets table
 * 
 * * schema:
 *      * username(15 max char),
 *      * content(140 max char), num_favorites
 */

CREATE TABLE tweets(
  username VARCHAR(15),
  content VARCHAR(140),
  favorites INT
);

/**
 * ? create, describe, and delete pastries table
 * 
 * * schema: name(50 max), quantity
 */

CREATE TABLE pastries(
  name VARCHAR(50),
  quantity INT
);

SHOW TABLES;

DESC pastries;

DROP TABLE pastries;

/**
 * ? create people table, insert into people table, verify new data
 * 
 * * schema:
 *      * first_name(20 char limit), last_name(20 char limit), age
 * * new data: Tina Belcher 13
 */

CREATE TABLE people(
  first_name VARCHAR(20),
  last_name VARCHAR(20),
  age INT
);

INSERT INTO people(first_name, last_name, age)
VALUES ('Tina', 'Belcher', 13);

// order of args is user defined, but new data has to align with provided order of args
INSERT INTO people(age, first_name, last_name)
VALUES (70, 'Calvin', 'Fish'),
     (38, 'Philip', 'Frond');

SELECT *
FROM people;

/**
 * ? create, inspect, and insert into employees table, review data
 * 
 * * schema:
 *      * id (auto_increment number),
 *      * first_name(255 char limit, mandatory), last_name(255 char limit, mandatory),
 *      * middle_name (255 char limit, optional), age(number, mandatory),
 *      * current_status(text, mandatory, default: employed)
 */

// // option 1
CREATE TABLE employees (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  middle_name VARCHAR(255),
  age INT NOT NULL,
  current_status VARCHAR(255) NOT NULL DEFAULT 'employed'
);

// // option 2
CREATE TABLE employees (
  id INT AUTO_INCREMENT NOT NULL,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  middle_name VARCHAR(255),
  age INT NOT NULL,
  current_status VARCHAR(255) NOT NULL DEFAULT 'employed',
  PRIMARY KEY(id)
);

DESC employees;

INSERT INTO employees(first_name, last_name, age) VALUES
('Dora', 'Smith', 58);

SELECT * FROM employees;

/**
 * ? create cats table, inpsect table, select only cat_id(s) and order by ascending,
 * ? select name and breed, select only cat's cat_id & age where cat_id = age
 *
 * * schema:
 *      * cat_id (auto_increment), name(255 char limit, default: "MISSING"),
 *      * breed(255 char limit, default: "TBD"), age (DEFAULT: 0)
 */

CREATE TABLE cats(
  cat_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL DEFAULT 'MISSING',
  breed VARCHAR(255) NOT NULL DEFAULT 'TBD'
  age INT NOT NULL DEFAULT 0,
);

SELECT cat_id
FROM cats
ORDER BY cat_id;

SELECT name, breed
FROM cats;

SELECT name, age
FROM cats
WHERE breed = 'Tabby';

SELECT cat_id, age
FROM cats
WHERE cat_id = age;

/**
 * ? update cats table
 * ?    remember to always SELECT first before UPDATE
 * 
 * * schema: cat_id, name, breed, age
 */

// ? than update Jackson's name to Jack
SELECT *
FROM cats
  WHERE name='Jackson';

UPDATE cats
  SET name='Jack'
    WHERE name='Jackson';

// ? than update Ringo's breed to "British Shorthair"
SELECT *
FROM cats
  WHERE name='Ringo';

UPDATE cats
  SET breed='British Shorthair'
    WHERE name='Ringo';

// ? than update both Maine Coons' ages to 12
SELECT *
FROM cats
  WHERE breed='Maine Coon';

UPDATE cats
  SET age=12
    WHERE breed='Maine Coon';

/**
 * ? delete data from cats table
 * ?    remember to always SELECT first before DELETE
 * 
 * * schema: cat_id, name, breed, age
 */

// delete all 4 year old cats
SELECT *
FROM cats
  WHERE age = 4;

DELETE FROM cats
  WHERE age = 4;

// delete all cats whose age is the same as their cat_id
SELECT *
FROM cats
  WHERE cat_id = age;

DELETE FROM cats
  WHERE cat_id = age;

// delete all cats
SELECT *
FROM cats;

DELETE *
FROM cats;

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

// view, create and use shirts db
SELECT database();

CREATE DATABASE shirts_db;
USE shirts_db;
SELECT database();

// create table
CREATE TABLE shirts(
  shirt_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  article VARCHAR(100),
  color VARCHAR(100),
  shirt_size CHAR(4),
  last_worn INT NOT NULL DEFAULT 0
);

DESC shirts;

INSERT INTO shirts(article, color, shirt_size, last_worn)
VALUES('t-shirt', 'white', 'S', 10);

SELECT *
FROM shirts;

/**
 * ? CRUD challenge: read data from shirts table
 * 
 * * schema:
 * *    shirt_id (auto_increment),
 * *    article(max 100 char),
 * *    color(max 100 char),
 * *    shirt_size(max 4 char), last_worn(int default 0)
 */

// read all shirts but print only article and color
SELECT article, color
FROM shirts;

// read only medium shirts, print everything but print shirt_id
SELECT article, color, shirt_size, last_worn
FROM shirts
WHERE shirt_size = 'M';

/**
 * ? CRUD challenge: update data from shirts table in shirts_db
 * 
 * * schema:
 * *    shirt_id (auto_increment),
 * *    article(max 100 char),
 * *    color(max 100 char),
 * *    shirt_size(max 4 char), last_worn(int default 0)
 */

// update all articles of polo shirts to size L
SELECT *
FROM shirts
WHERE shirt_size = 'L';

UPDATE shirts
  SET shirt_size = 'L'
  WHERE article = 'polo shirt';

// update the shirt last worn 15 days ago to last_worn = 0
SELECT *
FROM shirts
WHERE last_worn = 15;

UPDATE shirts
  SET last_worn = 0
  WHERE last_worn = 15;

// update multiple fields all white shirts to have 
//    a shirt_size of 'XS' and 
//    color of 'off white'

SELECT *
FROM shirts
WHERE color = 'white';

UPDATE shirts
  SET shirt_size = 'XS', color = 'off white'
  WHERE color = 'white';

/**
 * ? CRUD challenge: delete data from shirts table
 * 
 * * schema: 
 * *    shirt_id (auto_increment), article(max 100 char), 
 * *    color(max 100 char), shirt_size(max 4 char), 
 * *    last_worn(int default 0)
 */

// ? delete all old shirts that were last_worn 200 days ago

SELECT *
FROM shirts
WHERE last_worn = 200;

DELETE FROM shirts
WHERE last_worn = 200;

// ? delete all tank tops

SELECT *
FROM shirts
WHERE article='tank top';

DELETE FROM shirts
WHERE article = 'tank top';

// ? delete all shirts but keep table

SELECT *
FROM shirts;

DELETE FROM shirts;

// ? delete table

DROP TABLE shirts;
SHOW TABLES;

// ? reverse and uppercase the following sentence
// *    "Why does my cat look at me with such hatred?"

SELECT 
  REVERSE(
    UPPER('Why does my cat look at me with such hatred?')
    );

// ? what does the below SQL query do?

SELECT
    REPLACE(
        CONCAT(
            "I", " ", "like", " ", "cats"
        ),
        " ",
        "_"
    );

// ! it concatenates the multiple strings together and replaces the spaces with underscores

// output: 
//    I_like_cats

/**
 * ? string challenges
 * 
 * * books table schema: 
 * *    title, author_fname, author_lname,
 * *    released_year, stock_quantity
 */

// ? replace spaces in titles with '->' with alias title

SELECT
  REPLACE(
    title, 
    ' ', 
    '->') AS title
FROM books;

// ? print out author_lname and backwards author_lname 
// ?    in respective columns forward and backwards

SELECT
  author_lname AS forwards,
  REVERSE(author_lname) AS backwards
FROM books;

// ? print out full author name (author_fname, author_lname) 
// ?    in caps with alias full name in caps

SELECT
  UPPER(
    CONCAT_WS(' ', author_fname, author_lname)
  ) AS 'full name in caps'
FROM books;

// ? print alias blurb with row: 
// ?    {title} was released in {released_year}

SELECT
  CONCAT(
    title, ' was released in ', released_year
  ) AS blurb
FROM books;

// ? print title and alias character count as the length of each title

SELECT
  title,
  CHAR_LENGTH(title) AS 'character count'
FROM books;

// ? print short title (first 10 chars and ...), 
// ?    author (author_lname, author_fname), 
// ?    quantity ({num_in_stock} in stock)

SELECT
  CONCAT(
    SUNSTRING(title, 1, 10),
    '...'
  ) AS 'short title',
  CONCAT_WS(',', author_lname, author_fname) AS author,
  CONCAT(stock_quantity, ' in stock'
  ) AS quantity
FROM books;

/**
 * ? Refining SELECT query for books db
 * * schema: 
 * *    author_fname, author_lname, 
 * *    pages, title, released_year, stock_quantity
 */

/**
 * ? select titles that contain 'stories' and order by descending
 */

SELECT title
FROM   books
WHERE  title LIKE '%stories%'
ORDER  BY title DESC;

/**
 * ? find the longest book: print out the title and page count
 */

SELECT title, pages
FROM books
ORDER BY pages DESC
LIMIT 1;

/**
 * ? print summary containing the title and released_year, 
 * ? for the 3 most recent books
 * 
 * * Mad Men-2013
 */

SELECT
  CONCAT_WS(
    ' - ', title, released_year
  ) AS 'summary'
FROM books
ORDER BY released_year DESC
LIMIT 3;

/**
 * ? find all the books (print only title and the author_lname)
 * ? that has an author_lname that contains a space (" ") and order by title descending
 */

SELECT title, author_lname
FROM books
WHERE author_lname LIKE '% %'
ORDER BY title DESC;

/**
 * ? find the 3 books with the lowest stock: 
 * ?    print title, released_year, and stock
 */

SELECT
  title,
  released_year,
  stock_quantity
FROM books
ORDER BY stock_quantity
LIMIT 3;

/**
 * ? print the title, author_lname: 
 * ?    sorted by author_lname and then by title
 */

SELECT
  title,
  author_lname
FROM books
ORDER BY author_lname, title;

/**
 * ? sort alphabetically by last name
 * ?    labeled as yell: 
 * *      'MY FAVORITE AUTHOR IS {author_fname} {author_lname}!'
 */

SELECT
    UPPER(
      CONCAT(
        'my favorite author is ',
        author_fname, 
        ' ', 
        author_lname, 
        '!'
      )
    ) AS 'yell'
FROM books
ORDER BY author_lname;

/**
 * ? query one-to-many table from created students and papers table that uses prep data for respective table
 */

/**
 * ? create student and papers table 
 * 
 * * schema:
 * *    students(primary key(id), first_name)
 * *    papers(title 100 max chars, grade INT, student_id INT, foreign key (student_id))
 */

CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100)
);

CREATE TABLE papers (
    title VARCHAR(100),
    grade INT,
    student_id INT,
    FOREIGN KEY (student_id)
        REFERENCES students(id)
        ON DELETE CASCADE
);

/**
 * ? populate the students and papers(student_id, title, grade) tables with 2 starter data
 * 
 * * schema:
 * *    students(primary key(id), first_name)
 * *    papers(title 100 max chars, grade INT, student_id INT, foreign key (student_id))
 */

INSERT INTO students (first_name) VALUES
('Caleb'),
('Samantha'),
('Raj'),
('Carlos'),
('Lisa');

INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

/**
 * ? EXERCISE 1: 
 * ? get the student first_name, paper title, paper grade, 
 * ?    and student id of the respective paper and order by paper's grade DESC
 */

SELECT students.first_name, papers.title, papers.grade
FROM students
INNER JOIN papers
    ON students.id = papers.student_id
ORDER BY grade DESC;

/**
 * * EXERCISE 1 ALT SOLUTION
 */

SELECT students.first_name, papers.title, papers.grade
FROM students
RIGHT JOIN papers
    ON students.id = papers.student_id
ORDER BY grade DESC;

/**
 * ? EXERCISE 2: get first_name, title, and grade of ALL students
 * ?    and not just students that submitted a paper
 */

SELECT students.first_name, papers.title, papers.grade
FROM students
LEFT JOIN papers
    ON students.id = papers.student_id;

/**
 * ? EXERCISE 3: get first_name, title, and grade of ALL students 
 * ?    and not just students that submitted a paper 
 * ?    AND mark any missing papers as "MISSING" 
 * ?    and 0 for paper's title and grade, respectively
 * ?    order by grade first than student name
 */

SELECT
      students.first_name AS first_name,
      IFNULL(papers.title, UPPER('missing')) AS papers,
      IFNULL(papers.grade, 0) AS grade
FROM students
LEFT JOIN papers
      ON students.id = papers.student_id
ORDER BY paper.grade, students.first_name;

/**
 * ? EXERCISE 4: describe the students table
 * ?    print the name and each and every student's average paper grade, 
 * ?    even if the student didn't submit a paper 
 * ?    round the avg by 4 decimal positions and if missing, 0
 * ?    than rank from highest to lowest
 */

DESC students;

SELECT
      students.first_name AS first_name,
      IFNULL(
        AVG(ROUND(papers.grade), 4),
      0) AS average
FROM students
LEFT JOIN papers
      ON students.id = papers.student_id
GROUP BY students.id
ORDER BY average DESC;

/**
 * ? EXERCISE 5: describe the students table 
 * ?    get each and every student's average paper grade of their paper grades,
 * ?    even if the student didn't submit a paper than rank from highest to lowest,
 * ?    finally mark their 'passing status' as 'PASSING' or 'FAILING' based on their average
 * ?      passing if grade >= 75, failing if grade < 75, if null failing
 */

SHOW TABLES;
DESC students;

SELECT
      students.first_name AS first_name,
      IFNULL(
        AVG(
          ROUND(papers.grade), 4),
        0) AS average,
      WHEN
        CASE AVG(papers.grade) IS NULL
          THEN UPPER('failing')
        CASE AVG(papers.grade) >= 75
          THEN UPPER('passing')
        CASE AVG(papers.grade) < 75
          THEN UPPER('failing')
        ELSE
          UPPER('failing')
      END AS passing_status
FROM students
LEFT JOIN papers
      ON students.id = papers.student_id
GROUP BY student.id
ORDER BY average DESC;

/**
 * ? query many-to-many table from created reviewers, series, review tables that uses prep data for respective table
 * * schema:
 * *    reviewers(id, first_name default 'MISSING', last_name default 'MISSING')
 * *    series(id, title default "MISSING", released_year 4-digit mandatory, genre)
 * *    reviews(id, rating MIN 0.0 to MAX 9.9, series_id, reviewer_id)
 * 
 * * on delete cascade for relevant fields and tables
 */

/**
 * ! create reviewer, series, and review tables with the many-to-many connections for the review table
 */

 SELECT database();
 USE imdb;
 
 SHOW TABLES;
 
 CREATE TABLE reviewers(
     id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
     first_name VARCHAR(100) NOT NULL DEFAULT 'MISSING',
     last_name VARCHAR(100) NOT NULL DEFAULT 'MISSING'
 );
 
 DESC reviewers;
 
 CREATE TABLE series(
     id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
     title VARCHAR(100) NOT NULL DEFAULT "MISSING",
     release_year YEAR(4) NOT NULL,
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


/**
 * ! insert test data into tables and inspect data in reviews
 */

 INSERT INTO reviewers(first_name, last_name)
 VALUES ("Ben", "Silver"), ("Carmen", "West");
 
 INSERT INTO series(title, released_year, genre)
 VALUES ("Breaking Bad", 2007, "drama"), ("Game of Thrones", 2011, "comedy");
 
 INSERT INTO reviews(rating, series_id, reviewer_id)
 VALUES (8.0, 1, 1), (6.5, 2, 1), (9.3, 1, 2);

 SELECT * FROM reviews;

 /**
  * ! challenge 1: reproduce the table below (no nulls):
  
      title | rating

      archer | 8.0
      archer | 7.5
      arrested development | 8.9
      arrested development | 9.9
  */

SELECT
    series.title,
    reviews.rating
FROM series
INNER JOIN reviews
    ON series.id = reviews.series_id
ORDER BY title;

/**
 * ! challenge 2: reproduce the table below (no nulls):
 
    title | avg_rating

    General Hospital | 5.38000
    Fargo | 9.40000
    Halt and Catch Fire | 9.90000

 */

SELECT
    series.title,
    AVG(reviews.rating) AS "avg_rating"
FROM series
INNER JOIN reviews
    ON series.id = reviews.series_id
GROUP BY series.id
ORDER BY avg_rating;

/**
 * ! challenge 3: reproduce the table below (no nulls):

  first_name | last_name | rating

  Thomas | Stoneman | 8.0
  Wyat | Skaggs | 8.5
  Wyat | Skaggs | 7.5
  Wyat | Skaggs | 9.3
  Kimbra | Masters | 7.1

 */

SELECT
  reviewers.first_name,
  reviewers.last_name,
  reviews.rating
FROM reviews
INNER JOIN reviewers
  ON reviews.reviewer_id = reviewers.id
ORDER BY reviewers.last_name DESC;

 /**
 * ! challenge 4: reproduce the table below (there will be nulls):

    unreviewed_series

    Malcolm in the Middle
    Pushing Daisies

 */

SELECT
    series.title AS "unreviewed_series"
FROM series
LEFT JOIN reviews
    ON series.id = reviews.series_id
WHERE reviews.rating IS NULL
ORDER BY unreviewed_series DESC;
 
 /**
 * ! challenge 5: reproduce the table below (there will be nulls):

    genre | avg_rating

    Animation | 7.86
    Comedy | 8.16
    Drama | 8.04

 */

SELECT
    series.genre,
    ROUND(
      AVG(reviews.rating),
      2
    ) AS "avg_rating"
FROM reviews
INNER JOIN series
    ON reviews.series_id = series.id
GROUP BY reviews.id
ORDER BY series.genre, avg_rating;

/**
 * ! challenge 6: reproduce the table below (there will be nulls):

    first_name | last_name | COUNT | MIN | MAX | AVG | STATUS

    thomas  | stoneman | 5  | 7.0  | 9.5 | 8.02 | ACTIVE
    wyatt   | skaggs   | 9  | 5.5  | 9.3 | 7.80 | ACTIVE
    colt    | steele   | 10 | 4.5  | 9.9 | 8.77 | POWER USER
    marlon  | crafford | 0  | 0    | 0   | 0.00 | INACTIVE

  */


SELECT
    reviewers.first_name,
    reviewers.last_name,
    IFNULL(
        COUNT(reviews.rating), 
        0
    ) AS "COUNT",
    IFNULL(
        MIN(reviews.rating),
        0
    ) AS "MIN",
    IFNULL(
        MAX(reviews.rating),
        0
    ) AS "MAX",
    ROUND(
        IFNULL(
            AVG(reviews.rating),
            0
        ),
        2
    ) AS "AVG",
    CASE
        WHEN COUNT(reviews.rating) >= 10
            THEN UPPER("power user") 
        WHEN COUNT(reviews.rating) > 0 AND COUNT(reviews.rating) < 10
            THEN UPPER("active")
        ELSE UPPER("inactive")
    END AS UPPER("status")
FROM reviews
LEFT JOIN reviewers
    ON reviews.reviewer_id = reviewers.id
LEFT JOIN series
    ON reviews.series_id = series.id
GROUP BY reviews.id
ORDER BY "STATUS";

/**
 * ! challenge 7: reproduce the table below (no nulls):
 
          title | rating | reviewer

          archer | 8.0 | thomas stoneman
          archer | 7.0 | domingo cortes
          archer | 8.5 | kimbra masters
          arrested development | 8.4 | pinkie petit
          arrested development | 9.9 | colt steele
          bobs burgers | 7.0 | thomas stoneman 

  */

SELECT
    series.title,
    reviews.rating,
    CONCAT(
        reviewers.first_name,
        " ",
        reviewers.last_name,
    ) AS "reviewer"
FROM reviewers
INNER JOIN reviews
      ON reviewers.id = reviews.reviewer_id
INNER JOIN series
      ON reviews.series_id = series.id
ORDER by series.title;

/**
 * ? manage a music db

 * * schema: 

 * *    albums_table(_id INT AUTO_INCREMENT PRIMARY KEY, 
 * *    name VARCHAR NOT NULL, artist INT), 

 * *    artists_table(_id INT AUTO_INCREMENT PRIMARY KEY, 
 * *    name VARCHAR NOT NULL), 

 * *    songs_table(_id INT AUTO_INCREMENT PRIMARY KEY, 
 * *       track INT NOT NULL, title VARCHAR NOT NULL DEFAULT "MISSING", 
 * *       album INT)
 */

/**
 * ? create a music db and create the 3 linked tables (many-to-many) in the music db
 */

 CREATE DATABASE music_db;
 USE music_db;
 SELECT database();
 
 CREATE TABLE artists_table(
     _id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
     name VARCHAR(100) NOT NULL
 );
 
 DESC artists_table;
 
 CREATE TABLE albums_table(
     _id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
     name VARCHAR(100) NOT NULL,
     artist INT,
     FOREIGN KEY(artist)
         REERENCES artists_table(_id)
         ON DELETE CASCADE
 );
 
 DESC albums_table;
 
 CREATE TABLE songs_table(
     _id INT NOT NULL AUTO_INCREMENT PRIMARY KEY<
     track INT NOT NULL,
     title VARCHAR(100) NOT NULL DEFAULT "MISSING",
     album INT,
     FOREIGN KEY(album)
         REFERENCES albums_table(_id)
         ON DELETE CASCADE
 );
 
 DESC songs_table;
 
 SHOW TABLES;

/**
 * ? create an artist_list as a view that prints 
 * ?    artists.name, albums.name, 
 * ?    and songs.track from a single query 
 * ?    using multiple tables and order by artist, album, and then songs
 */

// SELECT artists.name, albums.name, songs.track FROM songs
// INNER JOIN albums ON songs.album = albums._id
// INNER JOIN artists ON albums.artist = artists._id
// ORDER BY artists.name, albums.name, songs.track;

/**
 * ? remove arist_list
 */

// DROP VIEW artist_list;

/**
 * ? select the titles of all the songs on the album forbidden
 */

// SELECT title
// FROM songs
// INNER JOIN albums ON songs.album = albums._id;

/**
 * ? select the titles of all the songs on the album forbidden but display in track order and include track number for verification
 */

// SELECT songs.track, songs.title
// FROM songs
// INNER JOIN albums ON songs.album = albums._id
// WHERE albums.name = 'Forbidden'
// ORDER BY songs.track;

/**
 * ? display all tracks and respective songs by the band 'Deep Purple'
 */

// SELECT songs.title
// FROM songs
// INNER JOIN albums ON songs.album = albums._id
// INNER JOIN artists ON albums.artist = artists._id
// WHERE artist.name = 'Deep Purple';

/**
 * ? rename band 'Mehitabel' to 'One Kitten' and verify
 */

// SELECT *
// FROM artists
// WHERE name = 'Mehitabel';

// UPDATE artists
//   SET name = 'One Kitten'
//   WHERE name = 'Mehitabel';

// SELECT *
// FROM artists
// WHERE name = 'One Kitten';

/**
 * ? select titles by Aerosmith in alphabetical order, only print title
 */

// SELECT song.titles
// FROM songs
// INNER JOIN albums ON songs.album = albums._id
// INNER JOIN artists ON albums.artist = artists._id
// WHERE artist.name = 'Aerosmith'
// ORDER BY songs.title ASC;

/**
 * ? GET count of song titles by Aerosmith in alphabetical order, only print the count
 */

// SELECT COUNT(*) AS 'count'
// FROM songs
// INNER JOIN ablums ON songs.album = albums._id
// INNER JOIN artists ON albums.artist = artists._id
// WHERE artists.name = 'Aerosmith'

/**
 * ? search the internet on how to make query without duplicates for below:
 * ? select titles by Aerosmith in alphabetical order, only print title
 */

// SELECT DISTINCT songs.title AS 'count'
// FROM songs
// INNER JOIN ablums ON songs.album = albums._id
// INNER JOIN artists ON albums.artist = artists._id
// WHERE artists.name = 'Aerosmith'
// ORDER BY songs.title;

/**
 * ? search the internet on how to make query without duplicates for below:
 * ? GET count of titles by Aerosmith
 */

// SELECT COUNT(DISTINCT title) AS 'count'
// FROM songs
// INNER JOIN ablums ON songs.album = albums._id
// INNER JOIN artists ON albums.artist = artists._id
// WHERE artists.name = 'Aerosmith';

/**
 * ? find number of unique albums by artist
 * ? hint: group by artist and name
 */

// SELECT
//   COUNT(DISTINCT album) AS 'artist count',
// FROM songs
// INNER JOIN ablums ON songs.album = albums._id
// INNER JOIN artists ON albums.artist = artists._id
// WHERE artists.name = 'Aerosmith';

/**
 * ? query one-to-many table from created students and papers table that uses prep data for respective table
 * * schema:
 * *    students(id, first_name)
 * *    papers(title, grade INT, student_id, foreign key (student_id))
 */


/**
 * ! SQL with JS practice problems
 *
 * SQL formatter
 * https://www.dpriver.com/pp/sqlformat.htm
 *
 */

// const users_schema = `
// CREATE TABLE users(
//   email VARCHAR(255),
//   created_at TIMESTAMP DEFAULT NOW()
// );
// `;

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
