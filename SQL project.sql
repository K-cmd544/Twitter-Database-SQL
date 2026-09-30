CREATE DATABASE Twitter;
USE Twitter;

CREATE TABLE Users
(
userID INT AUTO_INCREMENT PRIMARY KEY,
email VARCHAR(100) NOT NULL UNIQUE,
password BINARY(64) NOT NULL,
createdAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Profiles
(
profileID INT AUTO_INCREMENT PRIMARY KEY,
userID INT NOT NULL UNIQUE,
username VARCHAR(50) NOT NULL UNIQUE,
bio VARCHAR(225),

FOREIGN KEY (userID)
REFERENCES Users(userID)
);

CREATE TABLE Tweets
(
tweetID INT AUTO_INCREMENT PRIMARY KEY,
userID INT NOT NULL,
content TEXT NOT NULL,
createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,

FOREIGN KEY (userID)
REFERENCES Users(userID)
);

CREATE TABLE Follows
(
followID INT AUTO_INCREMENT PRIMARY KEY,
followerID INT NOT NULL,
followingID INT NOT NULL,
followedAt DATETIME DEFAULT CURRENT_TIMESTAMP,

FOREIGN KEY(followerID)
REFERENCES Users(userID),
FOREIGN KEY (followingID)
REFERENCES Users(followingID),

UNIQUE (followerID, followingID)
);

CREATE TABLE Likes
(
likeID INT AUTO_INCREMENT PRIMARY KEY,
userID INT NOT NULL,
tweetID INT NOT NULL,
likedAt DATETIME DEFAULT CURRENT_TIMESTAMP,

FOREIGN KEY (userID)
REFERENCES Users(userID),
FOREIGN KEY (tweetID)
REFERENCES Tweets(tweetID),

UNIQUE (userID, tweetID)
);

SHOW TABLES;


INSERT INTO Users (email, password)
VALUES
('khaled@gmail.com', UNHEX(MD5('Khaled123'))),
('ahmad@gmail.com', UNHEX(MD5('Ahmad123'))),
('omar@gmail.com', UNHEX(MD5('Omar123'))),
('mohammad@gmail.com', UNHEX(MD5('Mohammad123'))),
('ali@gmail.com', UNHEX(MD5('Ali123')));
SELECT * FROM Users;


INSERT INTO Profiles (userID, username, bio)
VALUES
(1, 'Khaled_AI', 'Data Science and AI Student'),
(2, 'AhmadTech', 'Software Developer'),
(3, 'Omar_Data', 'Data Analyst'),
(4, 'MohammadDev', 'Web Developer'),
(5, 'Ali_AI', 'AI Enthusiast');
SELECT * FROM Profiles;


INSERT INTO Tweets (userID, content)
VALUES
(1, 'Learning SQL and building my first database project!'),
(1, 'Today I started learning Data Science.'),
(2, 'I love programming and software development.'),
(3, 'Data is the new oil!'),
(4, 'Building a new web application.'),
(5, 'Artificial Intelligence is changing the world.');
SELECT * FROM Tweets;


INSERT INTO Follows (FollowerID, FollowingID)
VALUES
(1, 2),
(1, 3),
(2, 1),
(3, 5),
(5, 1);
SELECT * FROM Follows;


INSERT INTO Likes(userID, TweetID)
VALUES
(2, 1),
(3, 1),
(4, 1),
(1, 3),
(5, 3),
(1, 4),
(2, 6);
SELECT * FROM Likes;


SELECT 
Profiles.username,
Tweets.content,
Tweets.createdAt
FROM Tweets
JOIN Profiles
ON Tweets.userID = Profiles.userID;


DELIMITER //
CREATE PROCEDURE createAccount
(
IN p_Email VARCHAR(100),
IN p_Password VARCHAR(100),
IN p_Username VARCHAR(100),
IN p_Bio VARCHAR(100)
)
BEGIN
INSERT INTO Users (email, password)
VALUES (
p_Email,
UNHEX(MD5(p_Password))
);
INSERT INTO Profiles (userID, username, bio)
VALUES(
LAST_INSERT_ID(),
p_Username,
p_Bio
);
END //


CALL createAccount(
    'sara@gmail.com',
    'Sara123',
    'Sara_AI',
    'AI and Data Science Student'
);


DELIMITER //

CREATE PROCEDURE User_Follow(
IN p_FollowerUsername VARCHAR(50),
IN p_FollowingUsername VARCHAR(50)
)
BEGIN

DECLARE v_FollowerID INT;
DECLARE v_FollowingID INT;

SELECT UserID
INTO v_FollowerID
FROM Profiles
WHERE Username = p_FollowerUsername;

SELECT UserID
INTO v_FollowingID
FROM Profiles
WHERE Username = p_FollowingUsername;

INSERT INTO Follows (FollowerID, FollowingID)
VALUES (v_FollowerID, v_FollowingID);

END //


SELECT
Follower.Username AS Follower,
Following.Username AS Following,
Follows.FollowedAt
FROM Follows
JOIN Profiles AS Follower
ON Follows.FollowerID = Follower.UserID
JOIN Profiles AS Following
ON Follows.FollowingID = Following.UserID;
    
SELECT
Profiles.Username,
COUNT(Tweets.TweetID) AS TweetCount
FROM Profiles
LEFT JOIN Tweets
ON Profiles.UserID = Tweets.UserID
WHERE Profiles.Username = 'Khaled_AI'
GROUP BY Profiles.Username;