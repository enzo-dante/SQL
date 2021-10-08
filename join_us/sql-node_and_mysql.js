// in goormIDE terminal from project directory, execute: 
// node app.js

// SQL formatter
// https://www.dpriver.com/pp/sqlformat.htm

const { create } = require('domain');
const { fake } = require('faker');
const faker = require('faker'); // create fake data  
const { connect } = require('http2');
const mysql = require('mysql'); // communicates with mysql db

// establish connection to mysql db
const connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  database : 'join_us'
});

/**
 * ! define SELECT test SQL query
 */

// const q = 'SELECT CURDATE() AS solution';

// // connect to mySQL db and execute provided SQL query on callback
// connection.query(q, function(error, results, fields) {
// 	if(error) throw error;
	
// 	// alias must match in SQL query and in JS expression
// 	// ex) solution
	
// 	console.log(`The solution is: ${results[0].solution}`);
// });

// // end connection from mySQL db after callback SQL query is executed
// connection.end();

/**
 * ! define SELECT test SQL query FROM users table
 */

// const q = 'SELECT * FROM users'

// connection.query(q, function(error, results, fields){
// 	if(error) throw error;
// 	console.log(results);
// });

// connection.end();

/**
 * ! define SELECT test SQL query FROM users table that COUNT number of users
 * * COUNT(*) in SQL query > results.length in JS
 * * SQL will call and return 1 response instead of calling and returning multiple responses
 */

// const q = 'SELECT COUNT(*) AS num_users FROM users';

// connection.query(q, function(error, results, fields) {
// 	if(error) throw error;
// 	console.log(results);
// });

// connection.end();

/**
 * ! define INSERT test SQL query
 */

// const person = {email: 'jake647@gmail.com'};
// let table = 'users'

// // node mysql special INSERT configuration
// const insert_query = `INSERT INTO ${table} SET ?`;

// connection.query(insert_query, person, function(error, results){
//  if(error) throw error;
//  console.log(results);
// });

// connection.end();

/**
 * ! define INSERT test SQL query using faker node package
 */

// const person = {
// 	email: faker.internet.email()
// };
// const table = 'users';
// const insert_query = `INSERT INTO ${table} SET ?`;

// connection.query(insert_query, person, function(err, res){
// 	if(err) throw err;
// 	console.log(res);
// });

// connection.end();

/**
 * ! define INSERT test SQL query using faker date
 * * since SQL and JS handle dates differently, just define date using faker package in INSERT command
 */

// const person = {
//   email: faker.internet.email(),
//   created_at: faker.date.past()
// };

// const table = 'users';
// const insert_query = `INSERT INTO ${table} SET ?`;

// // can save SQL response to a variable
// const end_result = connection.query(insert_query, person, function(err, res){
//   if(err) throw err;
//   console.log(res);
// });

// connection.end();

// // if you log out the saved SQL variable with 'sql' option, it will return mySQL JS command
// console.log(end_result.sql);

/**
 * ! define INSERT bulk SQL query using faker package
 * * per faker documentation, bulk entries should be formatted as an array of an array
 * * each entry is itself an array
 * TODO: to reset dataset, code below requires imported packages
 */

// const data = [];

// // loop 500 times to create dataset
// // new variables are pushed to end of data array
// for(let i = 0; i < 500; i++) {
//   data.push([
//     faker.internet.email(),
//     faker.date.past()
//   ]);
// };

// const table = 'users (email, created_at)';
// const q = `INSERT INTO ${table} VALUES ?`;

// // data array is within an array; entire structure is a matrix (arrays of arrays)
// connection.query(q, [data], function(err, res){
//   if(err) throw err;
//   console.log(res);
// });

// connection.end();

/**
 * ? What is the earliest date a user joined in the bulk dataset?
 * * need clean dataset using CREATE TABLE users
 */

// const q = `
// SELECT DATE_FORMAT(created_at, '%M %D %Y') AS earliest_date
// FROM   users
// ORDER  BY created_at
// LIMIT 1;
// `;

// connection.query(q, function(err, res, fields){
//   if(err) throw err;
//   console.log(res[0]);
// });

// connection.end();

/**
 * ? What is the email of the earliest user in the bulk dataset?
 * * need clean dataset using CREATE TABLE users
 */

// const q = `
// SELECT email,
//        created_at
// FROM   users
// ORDER  BY created_at
// LIMIT  1; 
// `;

// connection.query(q, function(err, res, fields){
//   if(err) throw err;
//   console.log(res[0]);
// });

// connection.end();

/**
 * ? create table according to the month they joined
 * * need clean dataset using CREATE TABLE users
 */

// const q = `
// SELECT Date_format(created_at, '%M') AS month,
//        Count(*)                      AS count
// FROM   users
// GROUP  BY month
// ORDER  BY count DESC; 
// `;

// connection.query(q, function(err, res, args){
//   if(err) throw err;
//   console.log(res);
// });

// connection.end();

/**
 * ? what is the number of users with yahoo emails?
 * * need clean dataset using CREATE TABLE users
 */

// const q = `
// SELECT Count(*) AS yahoo_users
// FROM   users
// WHERE  email LIKE '%yahoo.com'; 
// `;

// connection.query(q, function(err, res, args) {
//   if(err) throw err;
//   console.log(res);
// });

// connection.end();

/**
 * ? what is the total number of users for each email host?
 * * need clean dataset using CREATE TABLE users
 */

const q = `
SELECT CASE
         WHEN email LIKE '%gmail.com' THEN 'gmail'
         WHEN email LIKE '%yahoo.com' THEN 'yahoo'
         WHEN email LIKE '%hotmail.com' THEN 'hotmail'
         ELSE 'other'
       END      AS provider,
       Count(*) AS total_users
FROM   users
GROUP  BY provider
ORDER  BY total_users DESC; 
`;

connection.query(q, function(err, res, args){
  if(err) throw err;
  console.log(res);
});

connection.end();
