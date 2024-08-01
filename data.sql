--Drop Tables

DROP TABLE Exchange ;
DROP TABLE Merchandise ;
DROP TABLE HoldActivities ;
DROP TABLE Sponsors ;
DROP TABLE HeadOfficesCountries;
DROP TABLE UserJoins;
DROP TABLE Communities;
DROP TABLE ActivitiyIncludesTopics ;
DROP TABLE Activities;
DROP TABLE FavoritedPosts;
DROP TABLE Comments;
DROP TABLE MediaPosts;
DROP TABLE TextPosts;
DROP TABLE Posts;
DROP TABLE Topics;
DROP TABLE FavoriteLists;
DROP TABLE Accounts;
DROP TABLE LevelRanks;



--Initialize Tables


CREATE TABLE LevelRanks(
                           "level" 		INTEGER	PRIMARY KEY,
                           rank 		VARCHAR(255)	NOT NULL);


CREATE TABLE Accounts (
                          userId 	INTEGER 	PRIMARY KEY,
                          userName 	VARCHAR(255)	NOT NULL,
                          email 		VARCHAR(255)	NOT NULL UNIQUE,
                          points	 	INTEGER	NOT NULL,
                          password 	VARCHAR(255)	NOT NULL,
                          "level" 		INTEGER	NOT NULL,
                          FOREIGN KEY ("level") REFERENCES LevelRanks("level"));


CREATE TABLE FavoriteLists (
                               userId 	INTEGER,
                               listName 	VARCHAR(255)	NOT NULL,
                               description 	VARCHAR(255),
                               PRIMARY KEY (userId, listName),
                               FOREIGN KEY (userId) REFERENCES Accounts (userId)
                                   ON DELETE CASCADE);

CREATE TABLE Topics (
                        topicName 		VARCHAR(255)	PRIMARY KEY,
                        description 		VARCHAR(255)	NOT NULL,
                        startedBy		 INTEGER,
                        FOREIGN KEY (startedBy) REFERENCES Accounts (userId)
                            ON DELETE SET NULL);

CREATE TABLE Posts (
                       postId 		INTEGER	PRIMARY KEY,
                       postDateTime 	TIMESTAMP		NOT NULL,
                       likes 		INTEGER	NOT NULL,
                       postedBy	INTEGER,
                       topic		VARCHAR(255),
                       FOREIGN KEY (postedBy) REFERENCES Accounts(userId)
                           ON DELETE SET NULL,
                       FOREIGN KEY (topic) REFERENCES Topics(topicName)
                           ON DELETE SET NULL);


CREATE TABLE  TextPosts (
                            postId		INTEGER	PRIMARY KEY,
                            content 	VARCHAR(255)	NOT NULL,
                            FOREIGN KEY (postId) REFERENCES Posts(postId)
                                ON DELETE CASCADE);


CREATE TABLE  MediaPosts (
                             postId		INTEGER	PRIMARY KEY,
                             hyperlink	VARCHAR(255)	NOT NULL,
                             FOREIGN KEY (postId) REFERENCES Posts(postId)
                                 ON DELETE CASCADE);


CREATE TABLE Comments (
                          postId			INTEGER,
                          commentId 		INTEGER,
                          commentedBy 	INTEGER,
                          content 		VARCHAR(255)	NOT NULL,
                          postDateTime 		TIMESTAMP		NOT NULL,
                          PRIMARY KEY (postId, commentId),
                          FOREIGN KEY (postId) REFERENCES Posts(postId)
                              ON DELETE CASCADE,
                          FOREIGN KEY (commentedBy) REFERENCES Accounts (userId)
                              ON DELETE SET NULL);


CREATE TABLE FavoritedPosts (
                                userId		 INTEGER,
                                listName 	VARCHAR(255),
                                postId	 	INTEGER,
                                PRIMARY KEY (userId, listName, postId),
                                FOREIGN KEY (postId) REFERENCES Posts(postId)
                                    ON DELETE CASCADE,
                                FOREIGN KEY (userId, listName) REFERENCES FavoriteLists (userId, listName)
                                    ON DELETE CASCADE);


CREATE TABLE Activities (
                            activityName		VARCHAR(255)	PRIMARY KEY,
                            description		VARCHAR(255)	NOT NULL,
                            reward 		INTEGER	NOT NULL,
                            startDate 		DATE		NOT NULL,
                            endDate 		DATE		NOT NULL);


CREATE TABLE ActivitiyIncludesTopics (
                                         topicName 		VARCHAR(255),
                                         activityName 	VARCHAR(255),
                                         PRIMARY KEY (topicName, activityName),
                                         FOREIGN KEY (topicName) REFERENCES Topics (topicName)
                                             ON DELETE CASCADE,
                                         FOREIGN KEY (activityName) REFERENCES Activities (activityName)
                                             ON DELETE CASCADE);


CREATE TABLE Communities (
                             communityName 		VARCHAR(255)	PRIMARY KEY,
                             description 			VARCHAR(255)	NOT NULL,
                             communityGuidelines 	VARCHAR(255));


CREATE TABLE UserJoins (
                           communityName 	VARCHAR(255),
                           userId	 		INTEGER,
                           PRIMARY KEY (communityName, userId),
                           FOREIGN KEY (communityName)	REFERENCES Communities (communityName)
                               ON DELETE CASCADE,
                           FOREIGN KEY (userId) REFERENCES Accounts (userId)
                               ON DELETE CASCADE);


CREATE TABLE HeadOfficesCountries (
                                      headOffice 			VARCHAR(255)	PRIMARY KEY,
                                      country			VARCHAR(255)	NOT NULL);


CREATE TABLE Sponsors (
                          companyName 		VARCHAR(255)	PRIMARY KEY,
                          businessDirections 		VARCHAR(255),
                          contactInformation 		VARCHAR(255)	NOT NULL,
                          headOffice 			VARCHAR(255)	NOT NULL,
                          FOREIGN KEY (headOffice) REFERENCES HeadOfficesCountries(headOffice)
                              ON DELETE CASCADE);


CREATE TABLE HoldActivities (
                                communityName	VARCHAR(255),
                                companyName 	VARCHAR(255),
                                activityName		VARCHAR(255),
                                PRIMARY KEY (communityName, companyName, activityName),
                                FOREIGN KEY (communityName) REFERENCES Communities (communityName)
                                    ON DELETE CASCADE,
                                FOREIGN KEY (companyName) REFERENCES Sponsors (companyName)
                                    ON DELETE CASCADE,
                                FOREIGN KEY (activityName) REFERENCES Activities (activityName)
                                    ON DELETE CASCADE);


CREATE TABLE Merchandise (
                             merchandiseId 	INTEGER	PRIMARY KEY,
                             name 			VARCHAR(255)	NOT NULL,
                             description 		VARCHAR(255),
                             price			INTEGER	NOT NULL,
                             shippedFrom	 	VARCHAR(255)	NOT NULL,
                             freeDelivery		CHAR(1)	NOT NULL,
                             offeredBy 		VARCHAR(255)	NOT NULL,
                             FOREIGN KEY (offeredBy) REFERENCES Sponsors (companyName)
                                 ON DELETE CASCADE);


CREATE TABLE Exchange (
                          merchandiseId		INTEGER	PRIMARY KEY,
                          buyerId		INTEGER,
                          tradeDate		DATE		NOT NULL,
                          buyerAddress	VARCHAR(255)	NOT NULL,
                          FOREIGN KEY (merchandiseId) REFERENCES Merchandise (merchandiseId)
                              ON DELETE CASCADE,
                          FOREIGN KEY (buyerId) REFERENCES Accounts (userId)
                              ON DELETE SET NULL);


--LevelRanks  Table

INSERT
INTO		LevelRanks ("level", rank)
VALUES 	(1, 'Newb');

INSERT
INTO		LevelRanks("level", rank)
VALUES 	(2, 'Newb');

INSERT
INTO		LevelRanks ("level", rank)
VALUES 	(3, 'Newb');

INSERT
INTO		LevelRanks ("level", rank)
VALUES 	(4, 'Experienced');

INSERT
INTO		LevelRanks ("level", rank)
VALUES 	(5, 'Experienced');

INSERT
INTO		LevelRanks ("level", rank)
VALUES 	(6, 'Experienced');

INSERT
INTO		LevelRanks ("level", rank)
VALUES 	(7, 'Experienced');

INSERT
INTO		LevelRanks ("level", rank)
VALUES 	(8, 'Renowned');

INSERT
INTO		LevelRanks ("level", rank)
VALUES 	(9, 'Renowned');

INSERT
INTO		LevelRanks ("level", rank)
VALUES 	(10, 'Renowned');


--Accounts Table

INSERT
INTO		Accounts (userId, userName, email, points, password, "level")
VALUES	(1, 'John', 'John@gmail.com', 10, '1234', 1);

INSERT
INTO		Accounts (userId, userName, email, points, password, "level")
VALUES	(2, 'Jack', 'Jack@gmail.com', 11, '1543', 1);

INSERT
INTO		Accounts (userId, userName, email, points, password, "level")
VALUES	(3, 'Josh', 'Josh@gmail.com', 1000, '2342', 4);

INSERT
INTO		Accounts (userId, userName, email, points, password, "level")
VALUES	(4, 'Joe', 'Joe@gmail.com', 10000, '3934', 9);

INSERT
INTO		Accounts (userId, userName, email, points, password, "level")
VALUES	(5, 'James', 'James@gmail.com', 1343, '9999', 3);


--FavoriteLists Table

INSERT
INTO 		FavoriteLists(userId, listName, description)
VALUES	(1, 'liked', 'favorited items');

INSERT
INTO 		FavoriteLists(userId, listName, description)
VALUES	(2, 'art', 'interesting artworks');

INSERT
INTO 		FavoriteLists(userId, listName, description)
VALUES	(3, 'CPSC', 'project ideas');

INSERT
INTO 		FavoriteLists(userId, listName, description)
VALUES	(4, 'movies', 'favorite movies');

INSERT
INTO 		FavoriteLists(userId, listName, description)
VALUES	(5, 'school', 'class topics');


--Topics Table

INSERT
INTO 		Topics(topicName, description, startedBy)
VALUES 	('CPSC310', 'questions on CPSC310', 1);

INSERT
INTO 		Topics(topicName, description, startedBy)
VALUES 	('CPSC320', 'questions on CPSC320', 2);

INSERT
INTO 		Topics(topicName, description, startedBy)
VALUES 	('CPSC221', 'questions on CPSC221', 3);

INSERT
INTO 		Topics(topicName, description, startedBy)
VALUES 	('CPSC210', 'questions on CPSC210', 4);

INSERT
INTO 		Topics(topicName, description, startedBy)
VALUES 	('CPSC110', 'questions on CPSC110', 5);


--Posts Table

INSERT
INTO 		Posts (postId, postDateTime, likes, postedBy, topic)
VALUES 	(1, TIMESTAMP '2024-07-12 10:23:00', 51, 1, 'CPSC310');

INSERT
INTO 		Posts (postId, postDateTime, likes, postedBy, topic)
VALUES 	(2, TIMESTAMP '2024-08-15 09:25:00', 3, 2, 'CPSC320');

INSERT
INTO 		Posts (postId, postDateTime, likes, postedBy, topic)
VALUES 	(3, TIMESTAMP '2024-01-21 12:34:00', 12, 3, 'CPSC221');

INSERT
INTO 		Posts (postId, postDateTime, likes, postedBy, topic)
VALUES 	(4, TIMESTAMP '2024-12-12 01:59:00', 11, 4, 'CPSC210');

INSERT
INTO 		Posts (postId, postDateTime, likes, postedBy, topic)
VALUES 	(5, TIMESTAMP '2025-05-12 00:01:00', 512, 5, 'CPSC110');


--TextPosts Table

INSERT
INTO 		TextPosts (postId, content)
VALUES	(1, 'hello, I am stuck on question 4 on the midterm practice');

INSERT
INTO 		TextPosts (postId, content)
VALUES	(2, 'Top vacation locations in Canada');

INSERT
INTO 		TextPosts (postId, content)
VALUES	(3, 'How to land internship fall 2024');

INSERT
INTO 		TextPosts (postId, content)
VALUES	(4, 'Best ramen place near UBC');

INSERT
INTO 		TextPosts (postId, content)
VALUES	(5, 'Hello world');


--MediaPosts Table

INSERT
INTO		MediaPosts(postId, hyperlink)
VALUES	(5, 'https://www.CPSC320.com/milestone2.jpg');

INSERT
INTO		MediaPosts(postId, hyperlink)
VALUES	(4, 'https://www.CPSC320.com/milestone2.jpg');

INSERT
INTO		MediaPosts(postId, hyperlink)
VALUES	(3, 'https://www.CPSC320.com/assignment3.jpg');

INSERT
INTO		MediaPosts(postId, hyperlink)
VALUES	(2, 'https://www.ubcea.com/team/players.jpg');

INSERT
INTO		MediaPosts(postId, hyperlink)
VALUES	(1, 'https://www.canvas.ca/profile.jpg');


--Comments Table

INSERT
INTO 		Comments(postId, commentId, commentedBy, content, postDateTime)
VALUES 	(1, 1, 1, 'cool artwork', TIMESTAMP '2024-06-13 12:30:00');

INSERT
INTO 		Comments(postId, commentId, commentedBy, content, postDateTime)
VALUES 	(2, 2, 2, 'good job', TIMESTAMP '2024-12-10 01:24:00');

INSERT
INTO 		Comments(postId, commentId, commentedBy, content, postDateTime)
VALUES 	(3, 3, 3, 'that is amazing', TIMESTAMP '2023-05-17 11:31:00');

INSERT
INTO 		Comments(postId, commentId, commentedBy, content, postDateTime)
VALUES 	(4, 4, 4, 'I can’t solve this question too', TIMESTAMP '2024-03-23 07:56:00');

INSERT
INTO 		Comments(postId, commentId, commentedBy, content, postDateTime)
VALUES 	(5, 5, 5, 'very interesting idea', TIMESTAMP '2024-08-11 08:30:00');


--FavoritedPosts Table

INSERT
INTO 		FavoritedPosts(userId, listName, postId)
VALUES	(1, 'liked', 1);

INSERT
INTO 		FavoritedPosts(userId, listName, postId)
VALUES	(1, 'liked', 2);

INSERT
INTO 		FavoritedPosts(userId, listName, postId)
VALUES	(3, 'CPSC', 3);

INSERT
INTO 		FavoritedPosts(userId, listName, postId)
VALUES	(3, 'CPSC', 1);

INSERT
INTO 		FavoritedPosts(userId, listName, postId)
VALUES	(4, 'movies', 5);


--Activities Table

INSERT
INTO 		Activities(activityName, description, reward, startDate, endDate)
VALUES	('Midterm Practice', 'Mock exam', 100, DATE '2024-07-10', DATE '2024-08-20');

INSERT
INTO 		Activities(activityName, description, reward, startDate, endDate)
VALUES	('Final Practice', 'Mini game on final topics', 500, DATE '2024-08-14', DATE '2024-08-30');

INSERT
INTO 		Activities(activityName, description, reward, startDate, endDate)
VALUES	('Mario Party', 'Last day tournament', 200, DATE '2024-08-30', DATE '2024-08-31');

INSERT
INTO 		Activities(activityName, description, reward, startDate, endDate)
VALUES	('Orientation', 'First day orientation', 10, DATE '2024-09-07', DATE '2024-09-10');

INSERT
INTO 		Activities(activityName, description, reward, startDate, endDate)
VALUES	('Team building', 'Team building exercise', 150, DATE '2024-09-11', DATE '2024-09-17');


--ActivitiyIncludesTopics  Table

INSERT
INTO		ActivitiyIncludesTopics (topicName, activityName)
VALUES	('CPSC310', 'Midterm Practice');

INSERT
INTO		ActivitiyIncludesTopics (topicName, activityName)
VALUES	('CPSC320', 'Final Practice');


INSERT
INTO		ActivitiyIncludesTopics (topicName, activityName)
VALUES	('CPSC221', 'Mario Party');

INSERT
INTO		ActivitiyIncludesTopics (topicName, activityName)
VALUES	('CPSC210', 'Orientation');

INSERT
INTO		ActivitiyIncludesTopics (topicName, activityName)
VALUES	('CPSC110', 'Team building');


--Communities Table

INSERT
INTO 		Communities(communityName, description, communityGuidelines)
VALUES 	('Student Center', 'Student discussion group', 'Adhere to academic integrity');

INSERT
INTO 		Communities(communityName, description, communityGuidelines)
VALUES 	('BC Technicians', 'Technical discussion forum', 'Beware of confidential info');

INSERT
INTO 		Communities(communityName, description, communityGuidelines)
VALUES 	('Vancouver Hackathons', 'Hackathon activities in Vancouver', 'No cheating');

INSERT
INTO 		Communities(communityName, description, communityGuidelines)
VALUES 	('Random Posts', 'Just random stuff', 'Be friendly :)');

INSERT
INTO 		Communities(communityName, description, communityGuidelines)
VALUES 	('Formal announcements BC', 'Announcements to BC citizens', 'No violence');


--UserJoins Table

INSERT
INTO 		UserJoins(communityName, userId)
VALUES 	('Formal announcements BC', 1);

INSERT
INTO 		UserJoins(communityName, userId)
VALUES 	('Formal announcements BC', 2);

INSERT
INTO 		UserJoins(communityName, userId)
VALUES 	('Vancouver Hackathons', 1);

INSERT
INTO 		UserJoins(communityName, userId)
VALUES 	('Random Posts', 4);

INSERT
INTO 		UserJoins(communityName, userId)
VALUES 	('BC Technicians', 2);


--HeadOfficesCountries

INSERT
INTO		HeadOfficesCountries(headOffice, country)
VALUES 	('Company A Plaza, Vancouver', 'Canada');

INSERT
INTO		HeadOfficesCountries(headOffice, country)
VALUES 	('Company B Building, Toronto', 'Canada');

INSERT
INTO		HeadOfficesCountries(headOffice, country)
VALUES 	('Company C Office, Delhi', 'India');

INSERT
INTO		HeadOfficesCountries(headOffice, country)
VALUES 	('Company D District, Shanghai', 'China');

INSERT
INTO		HeadOfficesCountries(headOffice, country)
VALUES 	('Company E Factory, New York', 'USA');



--Sponsors

INSERT
INTO		Sponsors (companyName, businessDirections, contactInformation, headOffice)
VALUES 	('Company A', 'Electronics', '123-456-7890', 'Company A Plaza, Vancouver');

INSERT
INTO		Sponsors (companyName, businessDirections, contactInformation, headOffice)
VALUES 	('Company B', 'Biomechanics', '456-789-0123', 'Company B Building, Toronto');

INSERT
INTO		Sponsors (companyName, businessDirections, contactInformation, headOffice)
VALUES 	('Company C', 'IT', '135-790-2468', 'Company C Office, Delhi');

INSERT
INTO		Sponsors (companyName, businessDirections, contactInformation, headOffice)
VALUES 	('Company D', 'Communication', '123-456-78901', 'Company D District, Shanghai');

INSERT
INTO		Sponsors (companyName, businessDirections, contactInformation, headOffice)
VALUES 	('Company E', NULL, '246-801-3579', 'Company E Factory, New York');


--HoldActivities Table

INSERT
INTO		HoldActivities(communityName, companyName, activityName)
VALUES 	('Student Center', 'Company E', 'Mario Party');

INSERT
INTO		HoldActivities(communityName, companyName, activityName)
VALUES 	('BC Technicians', 'Company B', 'Orientation');

INSERT
INTO		HoldActivities(communityName, companyName, activityName)
VALUES 	('BC Technicians', 'Company C', 'Midterm Practice');

INSERT
INTO		HoldActivities(communityName, companyName, activityName)
VALUES 	('Student Center', 'Company A', 'Final Practice');

INSERT
INTO		HoldActivities(communityName, companyName, activityName)
VALUES 	('Student Center', 'Company A', 'Team building');


--Merchandise Table

INSERT
INTO		Merchandise (merchandiseId, name, description, price, shippedFrom, freeDelivery, offeredBy)
VALUES 	(1, 'Pen', 'Red pen', 15, 'Vancouver', 'Y', 'Company A');

INSERT
INTO		Merchandise (merchandiseId, name, description, price, shippedFrom, freeDelivery, offeredBy)
VALUES 	(2, 'Pencil', 'Charcoal pencil', 10, 'Richmond', 'N', 'Company A');

INSERT
INTO		Merchandise (merchandiseId, name, description, price, shippedFrom, freeDelivery, offeredBy)
VALUES 	(3, 'Notebook', 'For sketching', 20, 'Burnaby', 'N', 'Company B');

INSERT
INTO		Merchandise (merchandiseId, name, description, price, shippedFrom, freeDelivery, offeredBy)
VALUES 	(4, 'Eraser', NULL, 5, 'Victoria', 'Y', 'Company C');

INSERT
INTO		Merchandise (merchandiseId, name, description, price, shippedFrom, freeDelivery, offeredBy)
VALUES 	(5, 'Correction Tape', '50m * 10mm', 15, 'Richmond', 'N', 'Company D');


--Exchange Table

INSERT
INTO		Exchange(merchandiseId, buyerId, tradeDate, buyerAddress)
VALUES 	(1, 1, DATE '2024-07-21', '1234 AB Road, Vancouver BC');

INSERT
INTO		Exchange(merchandiseId, buyerId, tradeDate, buyerAddress)
VALUES 	(2, 3, DATE '2024-07-20', '5678 CD Road, Vancouver BC');

INSERT
INTO		Exchange(merchandiseId, buyerId, tradeDate, buyerAddress)
VALUES 	(3, 4, DATE '2024-07-19', '9012 EF Road, Richmond BC');

INSERT
INTO		Exchange(merchandiseId, buyerId, tradeDate, buyerAddress)
VALUES 	(4, 5, DATE '2024-07-18', '1415 PI Road, Toronto ON');

INSERT
INTO		Exchange(merchandiseId, buyerId, tradeDate, buyerAddress)
VALUES 	(5, 1, DATE '2024-07-17', '9999 GH Road, Burnaby BC');