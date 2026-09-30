# Twitter Database - MySQL

## Project Overview

This project is a relational database designed to simulate the core functionality of a social media platform similar to Twitter.

The database manages users, profiles, tweets, followers, and likes while demonstrating relationships between different entities using MySQL.

## Features

* User account management
* User profiles
* Tweet management
* Follow relationships between users
* Tweet likes
* Automatic account creation date
* Auto-increment primary keys
* Foreign key relationships
* Password hashing using MD5
* Stored procedure for creating accounts
* Stored procedure for following users
* Counting tweets for a specific user

## Database Structure

The database contains the following tables:

* `Users`
* `Profiles`
* `Tweets`
* `Follows`
* `Likes`

## Relationships

### Users → Profiles

One user has one profile.

### Users → Tweets

One user can create many tweets.

### Users → Follows

Users can follow many other users, creating a many-to-many relationship through the `Follows` table.

### Users → Likes → Tweets

Users can like tweets, creating a relationship between users and tweets through the `Likes` table.

## Stored Procedures

### createAccount

The `createAccount` procedure creates a new user and automatically creates the associated profile.

Example:

```sql
CALL createAccount(
    'sara@gmail.com',
    'Sara123',
    'Sara_AI',
    'AI and Data Science Student'
);
```

### User_Follow

The `User_Follow` procedure receives two usernames, finds their corresponding User IDs, and creates the follow relationship.

Example:

```sql
CALL User_Follow(
    'Khaled_AI',
    'Sara_AI'
);
```

## Example Query

Count the number of tweets for a specific user:

```sql
SELECT
    Profiles.Username,
    COUNT(Tweets.TweetID) AS TweetCount
FROM Profiles
LEFT JOIN Tweets
    ON Profiles.UserID = Tweets.UserID
WHERE Profiles.Username = 'Khaled_AI'
GROUP BY Profiles.Username;
```

## ER Diagram

The ER diagram is included in:

`ER_Diagram.png`

## Technologies

* MySQL
* SQL
* Relational Database Design
* ER Diagram
* Stored Procedures
* Primary Keys
* Foreign Keys

## Author

Khaled Qteshat

Data Science & Artificial Intelligence Student
