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
 * ! create an artist_list as a view that prints
 *
 * ?    artists.name, albums.name,
 * ?    and songs.track from a single query
 * ?    using multiple tables and order by artist, album, and then songs
 */

CREATE VIEW artist_list(

);

SELECT
    artists.name,
    albums.name,
    songs.track
FROM songs
INNER JOIN albums
    ON songs.ablum = albums.id
        ON DELETE CASCADE
INNER JOIN artists
    ON albums.artist = artists.id
        ON DELETE CASCADE
ORDER BY artists.name, albums.name, songs.track;

/**
 * ? remove arist_list
 */

DROP VIEW artist_list;

/**
 * ? get the titles of all the songs on the album forbidden
 */

SELECT titles
FROM songs
INNER JOIN albums
    ON songs.album = albums.id
WHERE album.name = "forbidden";

/**
 * ? print the titles of all the songs on the album forbidden
 * ? but display in track order and include track number for verification
 */

SELECT songs.track, songs.title
FROM songs
INNER JOIN albums ON songs.album = albums._id
WHERE albums.name = 'Forbidden'
ORDER BY songs.track;

/**
 * ? display all tracks and respective songs by the band 'Deep Purple'
 */

SELECT songs.title
FROM songs
INNER JOIN albums
  ON songs.album = albums._id
INNER JOIN artists
  ON albums.artist = artists._id
WHERE artist.name = 'Deep Purple';

/**
 * ? rename band 'Mehitabel' to 'One Kitten' and verify
 */

SELECT *
FROM artists
WHERE name = 'Mehitabel';

UPDATE artists
  SET name = 'One Kitten'
  WHERE name = 'Mehitabel';

SELECT *
FROM artists
WHERE name = 'One Kitten';

/**
 * ? GET song titles by Aerosmith in alphabetical order, only print title
 */

SELECT song.titles
FROM songs
INNER JOIN albums ON songs.album = albums._id
INNER JOIN artists ON albums.artist = artists._id
WHERE artist.name = 'Aerosmith'
ORDER BY songs.title ASC;

/**
 * ? GET count of song titles by Aerosmith
 * ? only print the count as count
 */

SELECT
    COUNT(DISTINCT songs.title) AS "count"
FROM songs
INNER JOIN albums
    ON songs.album = albums._id
INNER JOIN artists
    ON albums.artist = artists._id
GROUP BY artists._id
WHERE artists.name = "Aerosmith";

/**
 * ? search the internet on how to make query without duplicates for below:
 * ? print titles by Aerosmith in alphabetical order, only print title
 */

SELECT DISTINCT songs.titles
FROM songs
INNER JOIN albums
    ON songs.album = albums._id
INNER JOIN artists
    ON albums.artist = artists._id
WHERE artists.name = "Aerosmith"
ORDER BY songs.title DESC;

/**
 * ? search the internet on how to make query without duplicates for below:
 * ? GET count of titles by Aerosmith
 */

SELECT
    COUNT(DISTINCT songs.title) AS "count"
FROM songs
INNER JOIN albums
    ON songs.album = albums._id
INNER JOIN artists
    ON albums.artist = albums._id
GROUP BY artists._id
WHERE artist.name = "Aerosmith"

/**
 * ? find the number of unique albums by artist
 */

SELECT
    artist.name,
    COUNT(DISTINCT albums.title) AS "album count"
FROM songs
INNER JOIN albums
    ON songs.album = albums._id
INNER JOIN artists
    ON albums.artist = artists._id
GROUP BY artists._id
ORDER BY "album count" DESC;

/**
 * ? create many-to-many tables from instagram project
 *
 * * schema:
 * *   users: id, username mandatory, created_at *timestamp now
 * *   photos: id, image_url mandatory, user_id mandatory *foreign key, created_at
 * *   comments: id, comment_text, photo_id *foreign key, user_id *foreign key, created_at *timestamp now
 * *   likes: user_id *foreign key, photo_id *foreign key, created_at, primary key
 * *   follows: follow_id *foreign key, followee_id *foreign key, created_at *timestamp now, primary key
 * *   tags: id, tag_name, created_at *timestamp now
 * *   photo_tags: photo_id *foreign key, tag_id *foreign key, primary key
 */

SELECT database();
CREATE DATABASE instagram_db;
USE instagram_db;

CREATE TABLE users(
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  created_at DATETIME DEFAULT NOW
);

DESC users;

CREATE TABLE photos(
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  image_url VARCHAR(100) NOT NULL,
  created_at DATETIME DEFAULT NOW,
  user_id INT NOT NULL,
  FOREIGN KEY(user_id) REFERENCES users(id)
);

DESC photos;

CREATE TABLE comments(
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  comment_text VARCHAR(500),
  created_at DATETIME DEFAULT NOW,
  photo_id INT NOT NULL,
  user_id INT NOT NULL,
  FOREIGN KEY(photo_id) REFERENCES photos(id),
  FOREIGN KEY(user_id) REFERENCES users(id)
);

DESC comments;
SHOW TABLES;

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
 *
 * * need clean dataset using CREATE TABLE users
 */

// solution 1

// const q = `
// SELECT DATE_FORMAT(created_at, '%M %D %Y') AS earliest_date
// FROM   users
// ORDER  BY created_at
// LIMIT 1;
// `;

// solution 2

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

// solution 1

// const q = `
// SELECT email,
// FROM   users
// ORDER  BY created_at
// LIMIT  1;
// `;

// solution 2

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

// solution 1

// const q = `
// SELECT Date_format(created_at, '%M') AS month,
//        Count(*)                      AS count
// FROM   users
// GROUP  BY month
// ORDER  BY count DESC;
// `;

// solution 2

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
