// import dependencies
const express = require('express');
const app = express();
const mysql = require('mysql');

// connect express and mysql
const connection = mysql.createConnection({
	host: 'localhost',
	user: 'root',
	database: 'tribe_called_sql'
});

// define GET root endpoint 
app.get('/', function(req, res) {
	const q = `
	SELECT COUNT(*) AS count
	FROM users;
	`;
	
	connection.query(q, function(err, results){
		if(err) throw err;
		const count = results[0].count;
		res.send(`Home page count: ${count}`);
	});
});

// define GET joke endpoint
app.get('/joke', function(req, res) {
	const joke = 'Where in the world are the best french fries cooked? In Greece.';
	res.send(joke);
});

// define GET random number generator endpoint
app.get('/random_num', function(req, res) {
	const random_num = Math.floor(Math.random() * 10) + 1;
	res.send(`your random number is ${random_num}`);
});

// define port to request and receive responses from server
app.listen(3000, function(req, res){
	console.log('app listening on port 3000');
});
