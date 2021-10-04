# exercise 1
# who are our 5 oldest members so we can reward them for their loyalty?

SELECT *
FROM   users
ORDER  BY created_at
LIMIT  5;

# exercise 2
# what day of the week do most users register on to figure out when to schedule. anad campaign?

SELECT Date_format(created_at, '%W') AS 'Day of the Week',
       Count(*)                      AS 'Day Total'
FROM   users
GROUP  BY Date_format(created_at, '%W')
ORDER  BY 2 DESC
LIMIT  1; 

# alternative solution
SELECT Dayname(created_at) AS 'day',
       Count(*)            AS 'total'
FROM   users
GROUP  BY day
ORDER  BY total DESC
LIMIT  1; 

# exercise 3
# identify inactive users (users with no photos)

SELECT users.id,
       username
FROM   users
       LEFT JOIN photos
              ON users.id = photos.user_id
WHERE  image_url IS NULL
ORDER  BY users.id; 

# alternative RIGHT JOIN solution
SELECT users.id,
       username
FROM   photos
       RIGHT JOIN users
               ON photos.user_id = users.id
WHERE  image_url IS NULL
ORDER  BY users.id; 

# exercise 4
# identify most popular photo with most likes and the user who created it

SELECT username,
       likes.photo_id,
       photos.image_url,
       Count(likes.photo_id) AS 'total'
FROM   users
       INNER JOIN photos
               ON users.id = photos.user_id
       INNER JOIN likes
               ON photos.id = likes.photo_id
GROUP  BY likes.photo_id
ORDER  BY total DESC
LIMIT  1; 

# alternative solution
SELECT username,
       photos.id AS 'photo_id',
       photos.image_url,
       Count(*)  AS 'total'
FROM   photos
       INNER JOIN likes
               ON likes.photo_id = photos.id
       INNER JOIN users
               ON photos.user_id = users.id
GROUP  BY photos.id
ORDER  BY total DESC
LIMIT  1; 

# exercise 5
# 
