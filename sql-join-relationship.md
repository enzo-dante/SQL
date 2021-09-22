# SQL formatter

https://www.dpriver.com/pp/sqlformat.htm

# table data types

> NUMERIC TYPES:
>
> for accounting, use DECIMAL() as default
> INTs, FLOATs, and BIGINTs are most common numeric data type

INT, SMALLINT, TINYINT, MEDIUMINT, BIGINT,

DECIMAL(total_num_digits, digits_after_decimal),

NUMERIC,
FLOAT,
DOUBLE,
BIT

> STRING TYPES:
>
> VARCHAR, not CHAR which requires a fixed length, is most common string data type

CHAR,
VARCHAR(n-length),

BINARY,
VARBINARY,
BLOB, TINYBLOB, MEDIUMBLOB, LONGBLOB,
TEXT, TINYTEXT, MEDIUMTEXT, LONGTEXT,
ENUM

> DATE TYPES:

DATETIME = DATE and TIME,

DATE = 'YYYY-MM-DD' format,

NOW() = give current date time,

TIME = 'HH:MM:SS',

CURDATE() = give current date,
CURTIME() = give current time,

TIMESTAMP = only works in range 2038-1970,

YEAR

# relationship types

__always compartmentalize dataset into seperate tables and then join if necessary byshared relationship__

Relationships are the different ways two or multiple tables (entities) are related

1. one-to-one relationship (not very common)

ex: 1 customer-to-1 customer details relationship

2. one-to-many relationship (most common)

ex: 1 book-to-many reviews relationship

3. many-to-many relationship (relatively common)

ex: many authors-to-many books relationship (a book can have mulitple authors)

# 1-to-many relationship

> PRIMARY KEY AUTO_INCREMENT ensures one column that is always unique for joined relationships

an example of 1-to-many relationship: 1 book-to-many reviews relationship

> FOREIGN KEY are references to another table within a given table
>
> explicitely using a FOREIGN KEY protects from bad data input

__STEPS__
1. Define foreign key column: <external_table_name>_id
2. on final CREATE TABLE line: FOREIGN KEY(column_name_in_CREATE_TABLE) REFERENCES <existing_table_name>(existing_table_primary_key)

ex) 

1 customers table (that has PRIMARY KEY customer_id column) AND

1 orders table (that has a PRIMARY KEY order_id but also has a customer_id column that is a reference to the customers table PRIMARY KEY customer_id)

```
CREATE TABLE customers
  (
     id         INT NOT NULL auto_increment PRIMARY KEY,
     first_name VARCHAR(100),
     last_name  VARCHAR(100),
     email      VARCHAR(100)
  );

CREATE TABLE orders
  (
     id          INT NOT NULL auto_increment PRIMARY KEY,
     order_date  DATE,
     amount      DECIMAL(8, 2) DEFAULT 0 NOT NULL,
     customer_id INT,
     FOREIGN KEY(customer_id) REFERENCES customers(id)
  );
```

# JOIN

> JOIN = take data from multiple tables and temporarily consolidate them in a meaningful way

__an implicit/cross join does not consolidate data in any meaninfulway;
it simply adds each row in 1 table to each row in another table, effectively cross multiplying the total number of rows__

```
SELECT * FROM customers, orders
```

> inner JOIN = the single most shared space between multiple circles in a Venn Diagram

https://dataschool.com/how-to-teach-people-sql/inner-join-animated/

__explicit inner JOIN__

```
SELECT first_name,
       last_name,
       order_date,
       amount
FROM   customers
       JOIN orders
         ON customers.id = orders.customer_id
```

__this implicit inner JOIN is inferior to an explicit inner JOIN__ 

be explicit in defining which column belongs to which table in a WHERE clause

```
SELECT first_name,
       last_name,
       order_date,
       amount
FROM   customers,
       orders
WHERE  customers.id = orders.customer_id; 
```


