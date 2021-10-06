// in goormIDE terminal from project directory, execute: 
// node app.js

const faker = require('faker'); // create fake data  
const mysql = require('mysql'); // communicates with mysql db

// establish connection to mysql db
const connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  database : 'join_us'
});

// define test SQL query
const q = 'SELECT CURDATE() AS solution';

// connect to mySQL db and execute provided SQL query on callback
connection.query(q, function(error, results, fields) {
	if(error) throw error;
	
	// alias must match in SQL query and in JS expression
	// ex) solution
	
	console.log(`The solution is: ${results[0].solution}`);
});

// end connection from mySQL db after callback SQL query is executed
connection.end();




