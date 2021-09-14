# SQL formatter

https://www.freeformatter.com/sql-formatter.html#ad-output

# table data types

> NUMERIC TYPES:

**for accounting, use DECIMAL() as default**

INT, SMALLINT, TINYINT, MEDIUMINT,
BIGINT,
DECIMAL(total_num_digits, digits_after_decimal),
NUMERIC, FLOAT,
DOUBLE, BIT

> STRING TYPES:

CHAR, VARCHAR(n-length), BINARY, VARBINARY,
BLOB, TINYBLOB, MEDIUMBLOB, LONGBLOB,
TEXT, TINYTEXT, MEDIUMTEXT, LONGTEXT,
ENUM

> DATE TYPES:

DATE = 'YYYY-MM-DD' format,
DATETIME = DATE + TIME,
TIME = 'HH:MM:SS',
CURDATE() = give current date,
CURTIME() = give current time,
NOW() = give current date time,
TIMESTAMP,
YEAR

# SQL DATE MATH

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

> SELECT DATETIME, DATE, TIME

NOW() = give current date time,
CURDATE() = give current date,
CURTIME() = give current time,

```

INSERT INTO people(name, birthdate, birthtime, birthdt)
VALUES('Microwave', CURDATE(), CURTIME(), NOW());

```

> SELECT DAY(), DAYNAME(), DAYOFWEEK()

**extract day and returns either a number or day from DATETIME or DATE**

```

SELECT name, DAY(<column_name>), DAYNAME(<column_name>), DAYOFWEEK(<column_name>)
FROM <database_name>;

```

> SELECT MONTH(), MONTHNAME()

**extract day and returns either a number or day from DATETIME or DATE**


> SELECT HOUR(), MINUTE(), SECOND()

**extracts requested time interal from TIME data type**

