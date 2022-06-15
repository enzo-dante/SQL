"""
relationship types

    always compartmentalize dataset into seperate tables
    then join if necessary byshared relationship

Relationships = the different ways two or multiple tables (entities) are related

    1. one-to-one relationship (not very common)

        ex: 1 customer-to-1 customer details relationship

    2. one-to-many relationship (most common)

        ex: 1 book-to-many reviews relationship

    3. many-to-many relationship (relatively common)

        ex: many authors-to-many books relationship (a book can have mulitple authors)

PRIMARY KEY AUTO_INCREMENT 
    
    when creating a table, ensures one column that is always unique for joined relationships

FOREIGN KEY 
    
    when creating a table, references to another table within a given table
    explicitely using a FOREIGN KEY protects from bad data input

JOIN

    when SELECT data, take data from multiple tables and temporarily consolidate them in a meaningful way

    INNER JOIN only shows data overlap (middle of a venn diagram)

    LEFT/RIGHT joins will ALSO shows data overlap + null data pairs (left/right + middle of a venn diagram)

        logic for LEFT AND RIGHT JOIN(two most common types of JOIN):

            https://dataschool.com/how-to-teach-people-sql/left-right-join-animated/
"""

-- ONE-TO-MANY relationship

--      an example of 1-to-many relationship: 1 book-to-many reviews relationship

CREATE TABLE customers(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE orders(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_date DATETIME DEFAULT NOW(),
    amount DECIMAL(8,2) NOT NULL DEFAULT 0,
    customer_id INT,
    FOREIGN KEY(customer_id)
        REFERENCES customers(id)
);

-- "flipping" LEFT and RIGHT JOIN would produce identical return tables if you just change the order

SELECT *
FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id;

SELECT *
FROM orders
RIGHT JOIN customers
    ON orders.customer_id = customers.id

-- SELECT + INNER JOIN 

--      select all records from A and B where the JOIN condition is met
--      INNER JOIN only shows data overlap (middle of a venn diagram)

--      https://dataschool.com/how-to-teach-people-sql/inner-join-animated/

SELECT
    first_name,
    last_name,
    order_date,
    amount
FROM customers
INNER JOIN orders
    ON customers.id = orders.customer_id
ORDER BY amount;

-- ON DELETE CASCADE

--      when creating a table, allow the removal of an entire records that are shared by a FOREIGN key

CREATE TABLE orders(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_date DATETIME DEFAULT NOW(),
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY(customer_id)
        REFERENCES customers(id)
            ON DELETE CASCADE
);

-- LEFT JOIN 

--      LEFT/RIGHT joins will ALSO shows data overlap + null data pairs (left/right + middle of a venn diagram)

SELECT
    AVG(grade) AS average
FROM students
GROUP BY students.id, students.first_name
    ORDER BY average DESC;

-- IFNULL(value, nullDefault)

SELECT
    first_name,
    IFNULL(
        AVG(grade),
        0
    ) AS "average"
FROM students
LEFT JOIN papers
    ON students.id = papers.student_id
GROUP BY students.id, students.first_name
    ORDER BY "average" DESC;

SELECT
    IFNULL(
        SUM(amount),
        0
    ) AS "total spent"
FROM students
LEFT JOIN papers
    ON students.id = papers.student_id
GROUP BY students.id, students.first_name
    ORDER BY "total spent" DESC;

-- RIGHT JOIN 

--      LEFT/RIGHT joins will ALSO shows data overlap + null data pairs (left/right + middle of a venn diagram)

--      The main difference between a LEFT/RIGHT JOIN and INNER JOIN is that LEFT/RIGHT joins will also show you where there IS NOT overlap while INNER JOIN only shows the overlap of a venn diagram

SELECT
    students.first_name,
    students.last_name,
    IFNULL(
        SUM(amount),
        0
    ) AS "total spent"
FROM customers
RIGHT JOIN orders
    ON customers.id = orders.customer_id
GROUP BY customers.id
    ORDER BY "total spent";

-- CASE STATEMENTS, IFNULL, and JOIN