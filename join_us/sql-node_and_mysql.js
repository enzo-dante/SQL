// in goormIDE terminal from project directory, execute: 
// node app.js

// SQL formatter
// https://www.dpriver.com/pp/sqlformat.htm

const faker = require('faker'); // create fake data  
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

const person = {
	email: faker.internet.email()
};
const table = 'users';
const insert_query = `INSERT INTO ${table} SET ?`;

connection.query(insert_query, person, function(err, res){
	if(err) throw err;
	console.log(res);
});

connection.end();