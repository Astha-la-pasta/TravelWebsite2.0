CREATE DATABASE IF NOT EXISTS `TravelWebsiteSQL`;
-- USE `TravelWebsiteSQL`;

-- CREATE TABLE users(
-- `username` varchar(30) 	NOT NULL,
-- `password` varchar(50) 	NOT NULL,
-- primary key(`username`));

-- INSERT INTO `users` VALUES ('Nihar' , '123abc'),('Astha' , 'testabc'),('Kelvin' , '123456'),('Gabe' , 'pass');
 USE `TravelWebsiteSQL`;

CREATE TABLE `admin` (
	`admin_username` varchar(50),
    `admin_password` varchar(50)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `users` (
  `firstname` varchar(50),
  `lastname` varchar(50),
  `username` varchar(50),
  `password` varchar(50),
  `cid`int,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `airlinecompany` (
  `airlineid` varchar(2),
  `name` varchar(50),
PRIMARY KEY (`airlineid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `aircraft` (
`aircraftid` varchar(10),
`airlineid` varchar(2),
PRIMARY KEY (`aircraftid`),
FOREIGN KEY(`airlineid`) REFERENCES `airlinecompany` (`airlineid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `airport` (
  `airportid` varchar(3),
  `airportname` varchar(50),
  PRIMARY KEY (`airportid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `employee` (
  `eid` int,
  `firstname` varchar(50),
  `lastname` varchar(50),
  `ssn` int,
  `emp_username` varchar(50),
  `emp_password` varchar(50),
  PRIMARY KEY (`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- CREATE TABLE `flight` (
--   `flightNum` int NOT NULL auto_increment,
--   `departuredate` date,
--   `destinationdate` date,
--   `departureairport` varchar(3),
--   `destinationairport` varchar(3),
--   `isinternational` boolean,
--   `isdomestic` boolean,
--   `price` float,
--   `stops` int,
--   `aircraftid` varchar(10),
--   `airlineid` varchar(2),
-- PRIMARY KEY (`flightNum`),
-- FOREIGN KEY (`airlineid`) REFERENCES airlinecompany (`airlineid`),
-- FOREIGN KEY (`aircraftid`) REFERENCES aircraft (`aircraftid` ),
-- FOREIGN KEY (`departureairport`) REFERENCES airport(`airportid`),
-- FOREIGN KEY (`destinationairport`) REFERENCES airport(`airportid`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `flight` (
  `flightNum` int NOT NULL auto_increment,
  `departuredate` date,
  `destinationdate` date,
  `departureairport` varchar(3),
  `destinationairport` varchar(3),
  `isinternational` boolean,
  `isdomestic` boolean,
  `price` float,
  `stops` int,
  `aircraftid` varchar(10),
  `airlineid` varchar(2),
  `capacity` int,
  `passengers_booked` int DEFAULT 0, -- Add the passengers_booked column
  PRIMARY KEY (`flightNum`),
  FOREIGN KEY (`airlineid`) REFERENCES airlinecompany (`airlineid`),
  FOREIGN KEY (`aircraftid`) REFERENCES aircraft (`aircraftid` ),
  FOREIGN KEY (`departureairport`) REFERENCES airport(`airportid`),
  FOREIGN KEY (`destinationairport`) REFERENCES airport(`airportid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `ticket` (
  `cid` int,
  `flightNum` int,
  `ticketNum` int NOT NULL AUTO_INCREMENT,
  `isflexible` boolean,
  `bookingcost` int DEFAULT 25,
  `cancelfee` int,
  `seatnum` int, 
  `fare` float,
  `datebought` date,
  `priorityNum` int,
  `is_oneway` boolean,
  `waitlist` boolean,
  `is_roundtrip` boolean,
  `classtype` varchar(50),
  `is_cancelled` boolean default false,
PRIMARY KEY (`ticketNum`),
FOREIGN KEY (`flightNum`) REFERENCES flight (`flightNum`),
FOREIGN KEY (`cid`) REFERENCES users (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- -----------------------------------------
-- Inserting sample data into the 'users' table
-- INSERT INTO users (firstname, lastname, username, password, cid) 
-- VALUES 
--   ('John', 'Doe', 'john_doe', 'password123', 1),
--   ('Jane', 'Smith', 'jane_smith', 'pass456', 2),
--   ('Alice', 'Johnson', 'alice_j', 'qwerty', 3),
--   ('Bob', 'Williams', 'bob_w', 'pass789', 4),
--   ('Emily', 'Davis', 'emily_d', 'secret123', 5);

-- -- Inserting sample data into the 'airlinecompany' table
-- INSERT INTO airlinecompany (airlineid, name)
-- VALUES 
--   ('AA', 'American Airlines'),
--   ('UA', 'United Airlines'),
--   ('DL', 'Delta Air Lines');

-- -- Inserting sample data into the 'aircraft' table
-- INSERT INTO aircraft (aircraftid, airlineid)
-- VALUES 
--   ('B777', 'AA'),
--   ('A320', 'UA'),
--   ('B737', 'DL');

-- -- Inserting sample data into the 'airport' table
-- INSERT INTO airport (airportid, airportname)
-- VALUES 
--   ('JFK', 'John F. Kennedy International Airport'),
--   ('LAX', 'Los Angeles International Airport'),
--   ('ORD', 'O\'Hare International Airport');

-- -- Inserting sample data into the 'employee' table
-- INSERT INTO employee (eid, firstname, lastname, ssn, emp_username, emp_password)
-- VALUES 
--   (1, 'Robert', 'Johnson', 123456789, 'rob_j', 'pass789'),
--   (2, 'Emily', 'Williams', 987654321, 'emily_w', 'secret123'),
--   (3, 'Michael', 'Brown', 555555555, 'mike_b', 'securepwd');

-- -- Inserting sample data into the 'flight' table
-- INSERT INTO flight (flightNum, departuredate, destinationdate, departureairport, destinationairport, isinternational, isdomestic, price, stops, aircraftid, airlineid)
-- VALUES 
--   (1, '2023-05-15', '2023-05-20', 'JFK', 'LAX', true, false, 500.00, 1, 'B777', 'AA'),
--   (2, '2023-06-01', '2023-06-10', 'LAX', 'ORD', false, true, 350.00, 0, 'A320', 'UA'),
--   (3, '2023-07-01', '2023-07-15', 'ORD', 'JFK', true, false, 450.00, 1, 'B737', 'DL');

-- -- Inserting sample data into the 'ticket' table
-- INSERT INTO ticket (cid, flightNum, ticketNum, isflexible, bookingcost, cancelfee, seatnum, fare, datebought, is_oneway, waitlist, is_roundtrip, classtype)
-- VALUES 
--   (1, 1, 101, true, 25, 10, 1, 500.00, '2023-04-01', true, false, true, 'Business'),
--   (2, 2, 102, false, 25, 15, 2, 350.00, '2023-04-02', false, false, true, 'Economy'),
--   (3, 3, 103, true, 25, 10, 1, 450.00, '2023-04-03', true, true, false, 'First Class'),
--   (4, 1, 104, false, 25, 10, 1, 500.00, '2023-04-04', true, false, true, 'Business'),
--   (5, 2, 105, true, 25, 15, 2, 350.00, '2023-04-05', false, false, true, 'Economy'),
--   (1, 3, 106, true, 25, 10, 1, 450.00, '2023-04-06', true, true, false, 'First Class');

-- -- -------------

-- Insert additional data into the 'users' table
INSERT INTO users (firstname, lastname, username, password, cid) 
VALUES 
  ('Alice', 'Johnson', 'alice_johnson', 'pass123', 6),
  ('Bob', 'Miller', 'bob_miller', 'password456', 7),
  ('Charlie', 'Smith', 'charlie_s', 'securepwd789', 8);
  -- Add more users as needed;

-- Insert additional data into the 'airlinecompany' table
INSERT INTO airlinecompany (airlineid, name)
VALUES 
  ('SW', 'Southwest Airlines'),
  ('FR', 'Ryanair'),
  ('EK', 'Emirates');
  -- Add more airlines as needed;

-- Insert additional data into the 'aircraft' table
INSERT INTO aircraft (aircraftid, airlineid)
VALUES 
  ('A330', 'SW'),
  ('B737', 'FR'),
  ('B777X', 'EK');
  -- Add more aircraft as needed;

-- Insert additional data into the 'airport' table
INSERT INTO airport (airportid, airportname)
VALUES 
  ('SFO', 'San Francisco International Airport'),
  ('ATL', 'Hartsfield-Jackson Atlanta International Airport'),
  ('LHR', 'Heathrow Airport');
  -- Add more airports as needed;

-- Insert additional data into the 'employee' table
INSERT INTO employee (eid, firstname, lastname, ssn, emp_username, emp_password)
VALUES 
  (4, 'David', 'Clark', 888888888, 'david_c', 'pass789'),
  (5, 'Eva', 'Jones', 777777777, 'eva_j', 'securepwd456'),
  (6, 'Frank', 'Anderson', 666666666, 'frank_a', 'password321');
  -- Add more employees as needed;

-- Insert additional data into the 'flight' table
INSERT INTO flight (flightNum, departuredate, destinationdate, departureairport, destinationairport, isinternational, isdomestic, price, stops, aircraftid, airlineid, capacity, passengers_booked)
VALUES 
  (4, '2023-08-01', '2023-08-10', 'SFO', 'ATL', false, true, 420.00, 1, 'A330', 'SW', 200, 120),
  (5, '2023-09-01', '2023-09-15', 'ATL', 'LHR', true, false, 600.00, 0, 'B737', 'FR', 150, 80),
  (6, '2023-10-01', '2023-10-20', 'LHR', 'SFO', true, false, 800.00, 1, 'B777X', 'EK', 250, 180);
  -- Add more flights as needed;

-- Insert additional data into the 'ticket' table
INSERT INTO ticket (cid, flightNum, ticketNum, isflexible, bookingcost, cancelfee, seatnum, fare, datebought, is_oneway, waitlist, is_roundtrip, classtype)
VALUES 
  (6, 4, 201, true, 25, 15, 1, 420.00, '2023-07-01', false, false, true, 'Economy'),
  (7, 5, 202, false, 25, 20, 2, 600.00, '2023-07-02', true, false, true, 'Business'),
  (8, 6, 203, true, 25, 15, 1, 800.00, '2023-07-03', false, true, false, 'First Class');
  -- Add more tickets as needed;


-- Add user questions table
CREATE TABLE `user_questions` (
  `question_id` int AUTO_INCREMENT,
  `cid` int,
  `question_text` varchar(255),
  `asked_date` date,
  PRIMARY KEY (`question_id`),
  FOREIGN KEY (`cid`) REFERENCES `users` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Add employee responses table
CREATE TABLE `employee_responses` (
  `response_id` int AUTO_INCREMENT,
  `question_id` int,
  `eid` int,
  `response_text` varchar(255),
  `response_date` date,
  PRIMARY KEY (`response_id`),
  FOREIGN KEY (`question_id`) REFERENCES `user_questions` (`question_id`),
  FOREIGN KEY (`eid`) REFERENCES `employee` (`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Add predefined questions table
CREATE TABLE `predefined_questions` (
  `question_id` int AUTO_INCREMENT,
  `question_text` varchar(255),
  PRIMARY KEY (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Add predefined responses table
CREATE TABLE `predefined_responses` (
  `response_id` int AUTO_INCREMENT,
  `question_id` int,
  `response_text` varchar(255),
  PRIMARY KEY (`response_id`),
  FOREIGN KEY (`question_id`) REFERENCES `predefined_questions` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Inserting sample predefined questions
INSERT INTO `predefined_questions` (`question_text`)
VALUES
  ('What is the baggage policy?'),
  ('How much does a ticket cost?'),
  ('What amenities are provided on flights?');

-- Inserting sample predefined responses
INSERT INTO `predefined_responses` (`question_id`, `response_text`)
VALUES
  (1, 'The baggage policy allows each passenger to carry one carry-on and one checked bag.'),
  (2, 'Ticket prices vary based on the destination and class of service.'),
  (3, 'Amenities on flights include complimentary snacks, beverages, and in-flight entertainment.');

-- Inserting a user question
INSERT INTO `user_questions` (`cid`, `question_text`, `asked_date`)
VALUES
  (6, 'How can I change my flight date?', '2023-01-10');

-- Inserting an employee response to the user question
INSERT INTO `employee_responses` (`question_id`, `eid`, `response_text`, `response_date`)
VALUES
  (1, 4, 'To change your flight date, please contact our customer support at support@example.com or call our hotline.', '2023-01-11');


-- Inserting a sample admin into the 'admin' table
INSERT INTO admin (admin_username, admin_password)
VALUES 
  ('admin', 'admin');

