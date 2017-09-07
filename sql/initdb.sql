USE webappdb; 

DROP TABLE IF EXISTS user_profile;
CREATE TABLE IF NOT EXISTS user_profile (
	id 			INT(11) NOT NULL AUTO_INCREMENT,
	usertype	VARCHAR(45) NOT NULL,
	username 	VARCHAR(45) DEFAULT NULL,
	password 	VARCHAR(45) DEFAULT NULL,
	firstname 	VARCHAR(45) DEFAULT NULL,
	lastname	VARCHAR(45) DEFAULT NULL,
	email 		VARCHAR(45) DEFAULT NULL,
	gender		VARCHAR(45) DEFAULT NULL,
	status		VARCHAR(45) DEFAULT NULL,
	PRIMARY KEY (id)
);

INSERT INTO user_profile (id, usertype, username, password, firstname, lastname, email, gender, status) 
VALUES (1, 'ADMIN', 'systemadmin', 'admin', 'system', 'admin', null, null, null, 'CREATED');
INSERT INTO user_profile (id, usertype, username, password, firstname, lastname, email, gender, creditcard, status) 
VALUES (2, 'USER', 'testuser1', 'testuser1', 'test1', 'user1', null, null, null, 'CREATED');
INSERT INTO user_profile (id, usertype, username, password, firstname, lastname, email, gender, creditcard, status) 
VALUES (3, 'USER', 'testuser2', 'testuser2', 'test2', 'user2', null, null, null, 'CREATED');
INSERT INTO user_profile (id, usertype, username, password, firstname, lastname, email, gender, creditcard, status) 
VALUES (4, 'USER', 'testuser3', 'testuser3', 'test3', 'user3', null, null, null, 'CREATED');

DROP TABLE IF EXISTS user_friend;
CREATE TABLE IF NOT EXISTS user_friend (
	userid1 	INT(11) NOT NULL,
	userid2 	INT(11) NOT NULL,
	FOREIGN KEY (userid1) REFERENCES user_profile(id),
	FOREIGN KEY (userid2) REFERENCES user_profile(id)

);

DROP TABLE IF EXISTS user_friend_request;
CREATE TABLE IF NOT EXISTS user_friend_request (
	from_user 	INT(11) NOT NULL,
	to_user 	INT(11) NOT NULL
	FOREIGN KEY (from_user) REFERENCES user_profile(id),
	FOREIGN KEY (to_user) REFERENCES user_profile(id)
);
