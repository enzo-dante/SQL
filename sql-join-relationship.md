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

__logic for LEFT AND RIGHT JOIN(two most common types of JOIN):__
https://dataschool.com/how-to-teach-people-sql/left-right-join-animated/

__the below examples show how "flipping" LEFT and RIGHT JOIN would produce identical return tables if you just change the order__

ex)
```
SELECT * FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id;

SELECT * FROM orders
RIGHT JOIN customers
    ON customers.id = orders.customer_id;

```

ex)
```
SELECT * FROM orders
LEFT JOIN customers
    ON customers.id = orders.customer_id;

SELECT * FROM customers
RIGHT JOIN orders
    ON customers.id = orders.customer_id;
```

> JOIN = take data from multiple tables and temporarily consolidate them in a meaningful way

__an implicit/cross join does not consolidate data in any meaninfulway;
it simply adds each row in 1 table to each row in another table, effectively cross multiplying the total number of rows__

__the created tables from a join operate like a normal table that can use normal table functions__

```
SELECT * FROM customers, orders
```

> INNER JOIN = select all records from A and B where the JOIN condition is met
>
> the single most shared space between multiple circles in a Venn Diagram

https://dataschool.com/how-to-teach-people-sql/inner-join-animated/

__explicit INNER JOIN, if you leave off INNER it will be implied that the JOIN is INNER__

```
SELECT first_name,
       last_name,
       order_date,
       amount
FROM   customers
       JOIN orders
         ON customers.id = orders.customer_id
ORDER BY amount;
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
WHERE  customers.id = orders.customer_id
ORDER BY amount;
```

> ON DELETE CASCADE = allow the removal of an entire records that are shared by a FOREIGN key
>

__when CREATE TABLE and defining a FOREIGN KEY, if a record in table a is deleted, the corresponding record in table b will be deleted thus deleting entire record and preventing a thrown error__

```
CREATE TABLE orders
  (
     id          INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
     order_date  DATE,
     amount      DECIMAL(8, 2),
     customer_id INT,
     FOREIGN KEY(customer_id) REFERENCES customers(id) ON DELETE CASCADE
  );
```

> IFNULL(argument_to_validated, replacement_value_if_valid)

```
IFNULL(SUM(amount), 0) AS total_spent
```

> LEFT JOIN = select everything from table A, along with any matching records in table B
>
> in a Venn Diagram, the entire LEFT circle, including the shared section, would be included

__LEFT JOIN logic:__

https://dataschool.com/how-to-teach-people-sql/left-right-join-animated/

```
SELECT first_name,
       last_name,
       IFNULL(SUM(amount), 0) AS total_spent
FROM   customers
       LEFT JOIN orders
              ON customers.id = orders.customer_id
GROUP  BY customers.id
ORDER  BY total_spent; 
```

> RIGHT JOIN = select everything from table B, along with any matching records in table A
>
> in a Venn Diagram, the entire RIGHT circle, including the shared section, would be included

__RIGHT JOIN logic:__

https://dataschool.com/how-to-teach-people-sql/left-right-join-animated/

```
SELECT first_name,
       last_name,
       IFNULL(SUM(amount), 0) AS total_spent
FROM   customers
       RIGHT JOIN orders
              ON customers.id = orders.customer_id
GROUP  BY customers.id
ORDER  BY total_spent; 
```
