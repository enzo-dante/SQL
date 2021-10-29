# java database connectivity (jdbc)

JDBC acts like the middleman between a java application and the data source
- JDBC works with databases, flat files, and spreadsheets

to work with sqlite 3, JDBC needs the sqlite driver

switching between drivers like SQLite and mySQL drivers is relatively easy

# DB Browser for SQLite

it is a GUI for handling a SQLite DB which is compatible with JDBC

when you are using the GUI, the app will lock the DB file and wont be able to access the db from a java application
- solution: open file drown down and select 'close database' to release lock

# Intelli J

__steps to connect SQLite 3 driver to JDBC__

1. download sqlite-jdbc driver from github
2. download DB Browser for SQLite from sqlite.org
3. create a new Intelli J java project with the command line template
4. open file drown down -> project structure -> Libraries -> plus symbol -> java
5. open sqlite-jdbc driver from saved location -> OK
