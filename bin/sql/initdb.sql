USE sql12193600; 

CREATE TABLE IF NOT EXISTS user_profile (
	id 			INT(11) NOT NULL AUTO_INCREMENT,
	usertype	VARCHAR(45) NOT NULL,
	username 	VARCHAR(45) DEFAULT NULL,
	password 	VARCHAR(45) DEFAULT NULL,
	firstname 	VARCHAR(45) DEFAULT NULL,
	lastname	VARCHAR(45) DEFAULT NULL,
	email 		VARCHAR(45) DEFAULT NULL,
	gender		VARCHAR(45) DEFAULT NULL,
	dob			VARCHAR(45) DEFAULT NULL,
	status		VARCHAR(45) DEFAULT NULL,
	imgpath		VARCHAR(45) DEFAULT NULL,
	PRIMARY KEY (id)
);

INSERT INTO user_profile (id, usertype, username, password, firstname, lastname, email, gender, dob, status, imgpath) 
VALUES (1, 'ADMIN', 'systemadmin', 'password', 'system', 'admin', null, 'MALE', '1997-01-01', 'CREATED', 'default.jpg');
INSERT INTO user_profile (id, usertype, username, password, firstname, lastname, email, gender, dob, status, imgpath) 
VALUES (2, 'USER', 'testuser1', 'testuser1', 'test1', 'user1', null, 'MALE', '1997-01-01', 'CREATED', 'default.jpg');
INSERT INTO user_profile (id, usertype, username, password, firstname, lastname, email, gender, dob, status, imgpath) 
VALUES (3, 'USER', 'testuser2', 'testuser2', 'test2', 'user2', null, 'MALE', '1997-01-01', 'CREATED', 'default.jpg');
INSERT INTO user_profile (id, usertype, username, password, firstname, lastname, email, gender, dob, status, imgpath) 
VALUES (4, 'USER', 'testuser3', 'testuser3', 'test3', 'user3', null, 'MALE', '1997-01-01', 'CREATED', 'default.jpg');

CREATE TABLE IF NOT EXISTS user_friend (
	userid1 	INT(11) NOT NULL,
	userid2 	INT(11) NOT NULL,
	FOREIGN KEY (userid1) REFERENCES user_profile(id),
	FOREIGN KEY (userid2) REFERENCES user_profile(id)

);

CREATE TABLE IF NOT EXISTS user_friend_request (
	from_user 	INT(11) NOT NULL,
	to_user 	INT(11) NOT NULL,
	status 		VARCHAR(45) NOT NULL,
	FOREIGN KEY (from_user) REFERENCES user_profile(id),
	FOREIGN KEY (to_user) REFERENCES user_profile(id)
);

CREATE TABLE IF NOT EXISTS user_post (
	id 			INT(11) NOT NULL AUTO_INCREMENT,
	user_id 	INT(11) NOT NULL,
	post 		VARCHAR(45) NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (user_id) REFERENCES user_profile(id)
);

CREATE TABLE IF NOT EXISTS user_like (
	user_id 	INT(11) NOT NULL,
	like_post 	INT(11) NOT NULL,
	FOREIGN KEY (user_id) REFERENCES user_profile(id)
);


