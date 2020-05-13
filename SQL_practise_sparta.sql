CREATE DATABASE stefan_db;

USE stefan_db;

CREATE TABLE film_table1 (
    film_id INT IDENTITY(1,1),
    film_name VARCHAR(50),
    film_type VARCHAR(6),
    release_date DATE,
    director VARCHAR(50),
    writer VARCHAR(50),
    star VARCHAR(50),
    plot VARCHAR (MAX),
    film_language VARCHAR(50),
    website VARCHAR(150)
    
    PRIMARY KEY (film_id)
);


CREATE TABLE ticket_sales1 
(
    ticket_id INT IDENTITY(1,1),
    quantity_sold INT,
    film_id INT
    
    PRIMARY KEY (ticket_id), 
    FOREIGN KEY (film_id) REFERENCES film_table1(film_id) ON DELETE CASCADE
);

INSERT INTO film_table1
(film_name, film_type, director)
VALUES 
('Avengers', 'Action', 'Russo Bros'),
('Star Wars', 'Sci-fi','George Lucas');


INSERT INTO film_table1
(film_name, film_type)
VALUES
('Napolean Dynamite', 'Comedy')

INSERT INTO ticket_sales1
(quantity_sold)
VALUES
(10000000),
(5000000),
(369121),
(124564),
(857839)


SELECT film_id, film_name, film_type, director FROM film_table;
SELECT * FROM ticket_sales;

ALTER TABLE film_table1 
    DROP COLUMN film_language

ALTER TABLE film_table1
   DROP COLUMN release_date







SP_HELP film_table;