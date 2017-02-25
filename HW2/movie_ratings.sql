/*
  DATA_607_HW_02.sql
  The SQL Script will create three tables namely REVIEWERS, MOVIE_NAMES AND REVIEW_MOVIE_RATINGS
*/

-- STEP 1: WE ARE CREATING REVIEWER TABLE, HAS TWO COLUMNS NAMELY ID AND REVIEW NAMES
SET foreign_key_checks = 0;
DROP TABLE IF EXISTS reviewer;
DROP TABLE IF EXISTS movie_names;
DROP TABLE IF EXISTS review_movie_rating;
SET foreign_key_checks = 1;

CREATE TABLE reviewer 
(
  reviewer_id int PRIMARY KEY NOT NULL UNIQUE,
  reviewer varchar(100) NOT NULL  
);

INSERT INTO reviewer(reviewer_id,reviewer) VALUES(1, "KYLE");
INSERT INTO reviewer(reviewer_id,reviewer) VALUES(2, "DUUBAR");
INSERT INTO reviewer(reviewer_id,reviewer) VALUES(3, "JAI");
INSERT INTO reviewer(reviewer_id,reviewer) VALUES(4, "JAAN");
INSERT INTO reviewer(reviewer_id,reviewer) VALUES(5, "KELLY");
INSERT INTO reviewer(reviewer_id,reviewer) VALUES(6, "GEORGIA");

commit;

-- STEP 2: WE ARE CREATING MOVIE_NAMES TABLE, HAS TWO COLUMNS NAMELY ID AND MOVIE NAMES

CREATE TABLE movie_names 
(
  movie_id int PRIMARY KEY NOT NULL UNIQUE,
  movie_names varchar(100) NOT NULL  
);


INSERT INTO movie_names(movie_id,movie_names) VALUES(1, "The Shawshank Redemption");
INSERT INTO movie_names(movie_id,movie_names) VALUES(2, "Harry Potter");
INSERT INTO movie_names(movie_id,movie_names) VALUES(3, "The Matrix");
INSERT INTO movie_names(movie_id,movie_names) VALUES(4, "Home Alone");
INSERT INTO movie_names(movie_id,movie_names) VALUES(5, "The Godfather");
INSERT INTO movie_names(movie_id,movie_names) VALUES(6, "Titanic");

commit;

-- STEP 3: WE ARE CREATING CROSS TABLE BETWEEN REVIEWER_X_MOVIE_NAMES_X_RATINGS TABLE, 
-- HAS THREE COLUMNS NAMELY REVIEWER ID AND MOVIE ID AND RATINGS.


CREATE TABLE review_movie_rating 
(
  reviewer_id int NOT NULL,
  movie_id int NOT NULL,
  ratings int NOT NULL,
  FOREIGN KEY (reviewer_id) REFERENCES reviewer (reviewer_id) 
		ON UPDATE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movie_names (movie_id) 
		ON UPDATE CASCADE
);


-- LOADING THE CSV FILE FROM LOCAL DIRECTORY.

LOAD DATA LOCAL INFILE '/Users/darshana/downloads/movie_ratings.csv' 
INTO TABLE review_movie_rating
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(reviewer_id, movie_id, ratings)
;

SELECT * FROM reviewer;
SELECT * FROM movie_names;
SELECT * FROM review_movie_rating;

commit;