/**
* ! manage a music db
*
* ? GET count of song titles by Aerosmith
* ? only print the count as count
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
