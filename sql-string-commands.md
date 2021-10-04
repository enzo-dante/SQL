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

# mySQL string commands

https://dev.mysql.com/doc/refman/8.0/en/string-functions.html

> SELECT CONCAT_WS() or SELECT CONCAT() combines data for cleaner output

> this does not change original values in the db, purely about printing values in defined table

*defining column names and renaming them is OPTIONAL

*below command will add provided string seperator (like a space) between merged column values and rename columns from target db

SELECT
    <column_name> AS 'x',
        CONCAT_WS('<string_seperator>, <column_name>, <column_name>)
            AS 'z'
FROM books;

*below command will add space with manual entry seperator between merged column values and rename columns from target db


SELECT
    title as 'Title', 
    author_fname AS 'First',
    author_lname AS 'Last',
        CONCAT_WS(' ', title, author_fname, author_lname)
            AS 'Full Name'
FROM books;

*below command will add space with manual entry seperator between merged column values and rename columns from target db

SELECT
    author_fname AS 'First',
    author_lname AS 'Last',
        CONCAT(author_fname, ' ', author_lname)
            AS 'Full Name'
FROM books;

*below command will add space (or whatever string value) between merged values of the columns together

SELECT
    CONCAT(<column_name>,' ', <column_name>)
FROM books;

*below command will literally merge values of the columns together

SELECT
    CONCAT(<column_name>, <column_name>)
FROM books;

> SELECT SUBSTRING() works with parts of strings

*after select, first function is inner most function and works outward

*selects all title from books table, returns only a substring, and then concatenatesa string to all substring titles



ex:



SELECT
    CONCAT(
        SUBSTRING(title, 1, 10),
        '...'
    ) AS 'short title',
    CONCAT_WS(
        ',',
        author_lname,
        author_fname
    ) AS 'author',
    CONCAT(
        stock_quantity,
        ' in stock'
    ) AS 'quantity'
FROM books;

*index starts at 1 in mySQL not 0 like other programming languages

*print out only a sebset of a target string from start_index to end_index

SELECT SUBSTRING(target_string, start_index, end_index);

*print out only a sebset of a target string from start_index to end

SELECT SUBSTRING(target_string, start_index);

*print out only a sebset of a target string starting from end and goes backwards

SELECT SUBSTRING(target_string, negative_number);

> REPLACE() is used to replace parts of string

*print out only a sebset of a target string where defined remove_substring has been replaced by replace_substring in target_string 

*replace is case-sensitive

SELECT
    REPLACE
    (
        target_string,
        remove_substring,
        replace_substring
    );
FROM <table_name>

*function selects all values from table books, next replaces all e in title with 3, then prints only 1-10 characters in string, under title STRANGE STRING

ex:

SELECT
    SUBSTRING(
        REPLACE(title, 'e', '3'),
        1,
        10
    ) AS 'STRANGE STRING'
FROM books;


> SELECT REVERSE() prints out the string backwards

ex:

SELECT REVERSE(target_string);

*below creates a palindrome, a word that reads forward the same as backwards

SELECT 
    CONCAT('woof', REVERSE('woof'))
    AS 'palindrome';

ex:

SELECT
    REVERSE(
        SUBSTRING(
                REPLACE(title, 'e', '3'),
                1,
                10
            )
    ) AS 'SUPER'
FROM books;

> SELECT CHAR_LENGTH() returns number of characters in a target string

ex:

SELECT
    CHAR_LENGTH(target_string)
FROM <table_name>;

*prints out 2 columns, one of the columns being the respective length renamed as 'length' from books table

ex:

SELECT
    author_lname,
    CHAR_LENGTH(author_lname)
        AS 'length'
FROM books;

*prints out a sentance using author last name and number of characters in last name

ex:

SELECT
    CONCAT(
        author_lname,
        ' is ',
        CHAR_LENGTH(author_lname),
        ' characters long'
    ) AS 'Title'
FROM books;

> SELECT UPPER(target_string) = convert to all caps

SELECT UPPER(target_string);

ex:

SELECT
    UPPER(
        CONCAT_WS(' ', author_fname, author_lname)
    ) AS 'full name in caps'
FROM books;

ex:

SELECT
    REVERSE(
            UPPER(
            'Why does my cat look at me with such hatred?'
        )
    ) AS 'Back Up';

> SELECT LOWER(target_string) = convert to all lower cases

SELECT LOWER(target_string);
