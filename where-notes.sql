"""
    SQL formatter

        https://www.dpriver.com/pp/sqlformat.htm

    NUMERIC TYPES:

        INT, SMALLINT, TINYINT, MEDIUMINT, BIGINT

        DECIMAL(total_num_digits, digits_after_decimal),
            for accounting, use DECIMAL() as default

        NUMERIC

        FLOAT

        DOUBLE

        BIT

    STRING TYPES:

        CHAR

        VARCHAR(n-length)

        BINARY

        VARBINARY

        BLOB, TINYBLOB, MEDIUMBLOB, LONGBLOB

        TEXT, TINYTEXT, MEDIUMTEXT, LONGTEXT

        ENUM

    DATE TYPES:

        DATETIME = DATE and TIME

        DATE = 'YYYY-MM-DD' format

        NOW() = give current date time

        TIME = 'HH:MM:SS'

        CURDATE() = give current date

        CURTIME() = give current time

        TIMESTAMP = only works in range 2038-1970

        YEAR

    mySQL string commands

        https://dev.mysql.com/doc/refman/8.0/en/string-functions.html

    mySQL date and time functions

        https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-format
"""

-- ! WHERE equality

--      case-insensitive, specific filtering commands

SELECT * FROM cats WHERE age=4;

SELECT * FROM cats WHERE name='Egg';

-- ! WHERE column comparisons 

--      filters WHERE column variables equal each other

SELECT
    cat_id,
    age
FROM cats
WHERE cat_id=age;

-- ! WHERE inequality

--      filters WHERE query that does NOT equal column variable

SELECT title
FROM books
WHERE released_year != 2017;

SELECT
    title,
    author_lname
FROM books
WHERE author_lname != "Harris";