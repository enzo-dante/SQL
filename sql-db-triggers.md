# SQL db triggers

SQL statements that are automatically run when a specific table is changed

> triggers make debugging extremly hard, be very careful about using SQL db triggers

# SHOW TRIGGERS;

to see the SQL db triggers in a, execute in mysql:

SHOW TRIGGERS;

# DROP TRIGGER <trigger_name>;

will remove the SQL db trigger

# trigger syntax

trigger_time: BEFORE, AFTER

trigger_event: INSERT, UPDATE, DELETE

ON

table_name: photos, users

# boilerplate db trigger template

DELIMITER $$

CREATE TRIGGER trigger_name
    trigger_time trigger_event ON table_name FOR EACH ROW
    BEGIN
    END;
$$

DELIMITER ;

# controversial SQL db trigger use: logic enforcement

it would be better to simply write valdiation checks on the frontend instead of relying on the db to handle these checks

that said, it is possible to have db validation checks using SQL db triggers

ex:

DROP TABLE IF EXISTS users;

CREATE TABLE users(
    username VARCHAR(100),
    age INT
);

INSERT INTO users(username, age)
VALUES ('bobby', 23);

SELECT *
FROM users;

# DELIMITER 

__multiple line statements require multiple semicolons with arbitrary define DELIMITER__

DELIMITER = signal that indicates end of code line for execution

$$ = arbitrary defined DELIMITER (can be anything like for ex: //)

DELIMITER $$
    <code_block>
$$

__if you change the DELIMITER temporarily, make to change it back to a semicolon with__

DELIMITER ;

# BEFORE validation trigger

> NEW = new data being INSERT
> OLD = pre-existing data for DELETE
> FOR EACH ROW = standard validation syntax
> SQLSTATE = values with message string, common for errors
> 45000 = generic state representing 'unhandled user-defined exception'

ex: check if new user is younger than 18, throw error if true to BEFORE INSERT

__example treats code between $$ as 1 chunk of code__

DELIMITER $$

CREATE TRIGGER must_be_adult
     BEFORE INSERT ON users FOR EACH ROW
     BEGIN
          IF NEW.age < 18
          THEN
              SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Must be an adult!';
          END IF;
     END;
$$

DELIMITER ;

INSERT INTO users(username, age) VALUES('test', 14);

ex 2:

DELIMITER $$

CREATE TRIGGER prevent_self_follow
    BEFORE INSERT ON follows FOR EACH ROW
    BEGIN
        IF NEW.follower_id = NEW.followee_id
        THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'You cannot follow yourself';
        END IF;
    END;
$$

DELIMITER ;

# CREATE new data based on another action

AFTER DELETE, INSERT new row INTO TABLE that does not exist yet

option 1:

DELIMITER $$

CREATE TRIGGER capture_unfollow
    AFTER DELETE ON follows FOR EACH ROW
    BEGIN
        INSERT INTO unfollows(follower_id, followee_id)
        VALUES(OLD.follower_id, OLD.followee_id);
    END;
$$

DELIMITER ;

option 2:

DELIMITER $$

CREATE TRIGGER capture_unfollow
    AFTER DELETE ON follows FOR EACH ROW
    BEGIN
        INSERT INTO unfollows
        SET follower_id = OLD.follower_id,
            followee_id = OLD.followee_id;
    END;
$$

DELIMITER ;

