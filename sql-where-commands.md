__IN functionality can be achieved using OR, but not as efficient__


SELECT title,
       author_lname
FROM   books
WHERE  author_lname = 'Carver'
        OR author_lname = 'Lahiri'
        OR author_lname = 'Smith';


> NOT IN = return set of values NOT IN provided column

__using NOT IN is superior to OR with long comma seperated values__

example only returns odd released years after 2000


SELECT title,
       released_year
FROM   books
WHERE  released_year >= 2000
       AND released_year NOT IN ( 2000, 2002, 2004, 2006,
                                  2008, 2010, 2012, 2014, 2016 );

> % = MODULO or remainder operator
>
> % allows you to test is something is even

if you divide value by 2 and there is no remainder, it is even


SELECT title,
       released_year
FROM   books
WHERE  released_year >= 2000
       AND released_year % 2 != 0
ORDER  BY released_year DESC;

> CASE STATEMENTS = if expression asserts true execute case functionality

__use AS when using CASE__

SELECT title,
       released_year,
       CASE
         WHEN released_year >= 2000 THEN 'Modern Lit'
         ELSE '20th Century Lit'
       END AS GENRE
FROM   books;


__if multiple WHEN, don't use commas__


SELECT title,
       stock_quantity,
       CASE
         WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'
         WHEN stock_quantity BETWEEN 51 AND 100 THEN '**'
         ELSE '***'
       END AS 'STOCK'
FROM   books;

__using GROUP BY, COUNT, CONCAT, ORDER BY with CASE__

SELECT title,
       author_lname,
       CASE
         WHEN Count(title) >= 2 THEN Concat_ws(' ', Count(title), 'books')
         ELSE Concat_ws(' ', Count(title), 'book')
       END AS 'COUNT'
FROM   books
GROUP  BY author_lname,
          author_fname
ORDER  BY 3 DESC;

