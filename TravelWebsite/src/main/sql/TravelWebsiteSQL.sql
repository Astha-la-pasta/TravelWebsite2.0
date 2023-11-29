CREATE DATABASE IF NOT EXISTS `TravelWebsite`;
USE `TravelWebsite`;

CREATE TABLE users(
`username` varchar(30) 	NOT NULL,
`password` varchar(50) 	NOT NULL,
primary key(`username`));

INSERT INTO `users` VALUES ('Nihar' , '123abc'),('Astha' , 'testabc'),('Kelvin' , '123456'),('Gabe' , 'pass');