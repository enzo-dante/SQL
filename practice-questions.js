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