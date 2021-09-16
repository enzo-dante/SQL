# SQL formatter

https://www.freeformatter.com/sql-formatter.html#ad-output

# table data types

> NUMERIC TYPES:

**for accounting, use DECIMAL() as default**

INT, SMALLINT, TINYINT, MEDIUMINT, BIGINT,
DECIMAL(total_num_digits, digits_after_decimal),
NUMERIC, 
FLOAT,
DOUBLE, 
BIT

> STRING TYPES:

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

# mySQL Documentation

> mySQL string commands

https://dev.mysql.com/doc/refman/8.0/en/string-functions.html

> mySQL date and time functions

https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-format

# SQL TIMESTAMP

> TIMESTAMP DEFAULT NOW() as a data type in a table

**using TIMESTAMP is only really useful when DEFAULT NOW() is included**

```

CREATE TABLE comments(
    content VARCHAR(100),
    create_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO comments(
        content
    )
    VALUES
    ('I found this offensive'),
    ('Hello whare are you going?'),
    ('This is wild!');

SELECT *
FROM comments
ORDER BY created_at DESC;

```

> TIMESTAMP DEFAULT NOW() ON UPDATE NOW()

**ON UPDATE NOW() will update timestamp with current timestamp for each time a row is updated**

```

CREATE TABLE comments2(
    content VARCHAR(100),
    changed_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW()
);

INSERT INTO comments2(
        content
    )
    VALUES
        ('How weird'),
        ('This cannot be real'),
        ('Birdperson...');

SELECT * FROM comments2;

UPDATE comments2
    SET content='Donkey not Bird'
    WHERE content='Birdperson...';
    
SELECT * 
FROM comments2 
ORDER BY changed_at DESC;

```

# SQL DATE MATH

https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html

> SELECT DATEDIFF() will tell you difference between dates in days

**very common function to use**

```

SELECT
   name,
   birthdate,
   DATEDIFF (NOW(), birthdate) AS 'days old'
FROM
   people
ORDER BY
   3 DESC;

```

> SELECT + INTERVAL adds specified interval to provided date

**have to specify the interval and time type**

```

SELECT * FROM people;

SELECT
    birthdt,
    birthdt + INTERVAL 1 MONTH AS 'adding 1 month'
FROM people;

```

> SELECT - INTERVAL subtracts specified interval to provided date

**have to specify the interval and time type**

```

SELECT * FROM people;

SELECT
    birthdt,
    birthdt - INTERVAL 1 MONTH AS 'subtracting 1 month'
FROM people;

```

> SELECT using both + and -

```

SELECT
    birthdt,
    birthdt - INTERVAL 1 MONTH + INTERVAL 10 HOUR
FROM people;

```

# SQL DATE functions

> Comment Out Code

highlight target code and on Mac press:

CMD + /

> SELECT DATE_FROMAT()

**using DATE_FORMAT is the best way to handle printing dates**

```

SELECT DATE_FORMAT(birthdt, 'Was born on a %W'
FROM people

```

ex:

```

SELECT
DATE_FORMAT(birthdt, '%m/%d/%Y')
FROM people;

```

> Get current date and time, date, or time

SELECT NOW() = give current date time,
SELECT CURDATE() = give current date,
SELECT CURTIME() = give current time,

```

INSERT INTO people(name, birthdate, birthtime, birthdt)
VALUES('Microwave', CURDATE(), CURTIME(), NOW());

```

> SELECT DAY(), DAYNAME(), DAYOFWEEK()

**get day and returns either a number or day from DATETIME or DATE**

```

SELECT name, DAY(<column_name>), DAYNAME(<column_name>), DAYOFWEEK(<column_name>)
FROM <database_name>;

```

> SELECT MONTH(), MONTHNAME()

**extract day and returns either a number or day from DATETIME or DATE**


> SELECT HOUR(), MINUTE(), SECOND()

**extracts requested time interal from TIME data type**



