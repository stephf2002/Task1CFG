/* Creative Scenario: Escape Room Booking System
 * This database is for an escape room business to manage their customers, escape rooms and bookings information.
 * Staff can also store booking information, search for customer bookings and analyse booking data.
 */

-- Create Database
CREATE DATABASE Escape_Room_Booking;
-- Use Database
USE Escape_Room_Booking;

-- Create Customers Table
CREATE TABLE Customers (
customer_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(100) UNIQUE,
phone VARCHAR(20),
AGE INT CHECK (age >=16)
);

-- Create EscapeRooms Table
CREATE TABLE EscapeRooms (
room_id INT AUTO_INCREMENT PRIMARY KEY,
room_name VARCHAR(100) NOT NULL,
difficulty VARCHAR(20) NOT NULL,
max_players INT NOT NULL,
price DECIMAL(5,2) NOT NULL,
theme VARCHAR(50) NOT NULL
);

-- Create Bookings Table
CREATE TABLE Bookings (
booking_id INT AUTO_INCREMENT PRIMARY KEY,
customer_id INT NOT NULL,
room_id INT NOT NULL,
booking_date DATE NOT NULL,
booking_time TIME NOT NULL,
number_of_players INT NOT NULL,
total_price DECIMAL(6,2) NOT NULL,

FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
FOREIGN KEY (room_id) REFERENCES EscapeRooms(room_id)
);

-- Insert Customer Data
INSERT INTO Customers (first_name, last_name, email, phone, age)
VALUES
('Susan', 'May', 'susan.may@gmail.com', '07463847643', 30),
('James', 'Johnson', 'james.johnson@gmail.com', '07442391028', 44),
('Emily', 'Williams', 'emily.williams@gmail.com', '03287594039', 22),
('Taylor', 'Smith', 'taylor.smith@gmail.com', '07123947850', 28),
('Wilson', 'Cherry', 'wilson.cherry@gmail.com', '07348594856', 60);

-- Display Customer Info
SELECT * FROM Customers;

-- Insert EscapeRooms Info
INSERT INTO EscapeRooms (room_name, difficulty, max_players, price, theme)
VALUES
('Haunted Circus', 'Hard', 6, 24.99, 'Circus'),
('Zombie Warehouse', 'Medium', 4, 15.99, 'Zombies'),
('Scary Doll House', 'Hard', 8, 18.99, 'Scary Dolls'),
('Vampire Diaries', 'Easy', 5, 14.99, 'Vampires'),
('The Possession', 'Extreme', 6, 29.99, 'Paranormal');

-- Display EscapeRoom Info
SELECT * FROM EscapeRooms;

-- Insert Booking Data
INSERT INTO Bookings (customer_id, room_id, booking_date, booking_time, number_of_players, total_price)
VALUES
(1, 1, '2026-09-01', '14:00:00', 6, 149.94),
(2, 3, '2026-09-02', '16:30:00', 4, 63.96),
(3, 2, '2026-09-03', '13:00:00', 2, 31.98),
(4, 4, '2026-09-04', '18:00:00', 5, 74.95),
(5, 5, '2026-09-05', '20:00:00', 6, 179.94);

-- Display Booking Info
SELECT * FROM Bookings;

-- More Customer Data
INSERT INTO Customers (first_name, last_name, email, phone, age)
VALUES
('Olivia', 'Tea', 'olivia.tea@gmail.com', '072123428372', 32),
('Daniel', 'Tay', 'daniel.tay@gmail.com', '07998374394', 25),
('Sophie', 'Evans', 'sophie.evans@gmail.com', '07228677445', 27);


SELECT * FROM Customers

-- More EscapeRoom Info
INSERT INTO EscapeRooms (room_name, difficulty, max_players, price, theme)
VALUES
('Pirate Ship', 'Medium', 6, 21.99, 'Pirates'),
('Alien House', 'Hard', 8, 26.99, 'Sci-Fi'),
('Fairy Tale', 'Easy', 4, 16.99, 'Adventure');

-- More Booking Data
INSERT INTO Bookings (customer_id, room_id, booking_date, booking_time, number_of_players, total_price)
VALUES
(6, 6, '2026-09-06', '15:30:00', 4, 67.96),
(7, 7, '2026-09-07', '17:00:00', 8, 215.92),
(8, 8, '2026-09-08', '11:00:00', 3, 53.97);

SELECT * FROM EscapeRooms
SELECT * FROM Bookings

-- DEMO QUERIES

-- QUERY 1: WHERE 

-- Display all hard difficulty EscapeRooms
SELECT * FROM EscapeRooms
WHERE difficulty = 'Hard';

-- Display customers older than 25
SELECT * FROM Customers
WHERE age > 25;

-- QUERY 2/3: SELECT & ORDER BY

-- Display bookings after 3rd September 2026
SELECT * FROM Bookings
WHERE booking_date > '2026-09-03';


-- Display room names and prices
SELECT room_name, price
FROM EscapeRooms;

-- Display customers in alphabetical order by surname
SELECT * FROM Customers
ORDER BY last_name ASC;

-- Display escape rooms by price (highest to lowest)
SELECT * FROM EscapeRooms
ORDER BY price DESC;

-- Display bookings from earliest date to latest booking date 
SELECT * FROM Bookings
ORDER BY booking_date ASC;

-- Display escape rooms from maximum to least players
SELECT * FROM EscapeRooms
ORDER BY max_players DESC;

-- QUERY 4: Aggregate Functions

-- Count the total number of bookings
SELECT COUNT(*) AS Total_Bookings
FROM Bookings;

-- Calculate the average escape room price
SELECT AVG(price) AS Average_Price
FROM EscapeRooms;

-- QUERY 5: Built-In Functions

-- Display customers full names
SELECT CONCAT(first_name, ' ', last_name) AS Full_Name
FROM Customers;

-- Display room names in uppercase
SELECT UPPER(room_name) AS Room_Name
FROM EscapeRooms;

-- QUERY 6: JOINS

-- Display each booking with the customer's name
SELECT b.booking_id, c.first_name, c.last_name, b.booking_date, b.booking_time
FROM Bookings AS b
JOIN Customers AS c
ON b.customer_id = c.customer_id;

-- Display all bookings with customer and escape room detials
SELECT b.booking_id, c.first_name, c.last_name, e.room_name, b.booking_date, b.booking_time
FROM Bookings AS b
JOIN Customers AS c
ON b.customer_id = c.customer_id
JOIN EscapeRooms AS e
ON b.room_id = e.room_id;

-- QUERY 7:  Update & Delete 

-- Update the number of players for booking 1
UPDATE Bookings
SET number_of_players = 5
WHERE booking_id = 1;

-- Checking the update
SELECT * FROM Bookings
WHERE booking_id =1;

-- Delete booking 8
DELETE FROM Bookings
WHERE booking_id = 8;

-- Checking that it has been deleted
SELECT * FROM Bookings;

-- QUERY 8: Stored Procedure: Show bookings for a selected customer

DELIMITER //

CREATE PROCEDURE GetCustomerBookings (IN custID INT)
BEGIN
	SELECT *
	FROM Bookings
	WHERE customer_id = custID;
END //

DELIMITER ; 

CALL GetCustomerBookings(1);





