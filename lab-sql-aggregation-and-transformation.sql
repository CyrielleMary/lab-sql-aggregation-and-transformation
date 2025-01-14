USE sakila;

# You need to use SQL built-in functions to gain insights relating to the duration of movies:

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration FROM sakila.film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.

SELECT ROUND(AVG(length),0) FROM sakila.film;
SELECT sec_to_time(ROUND(AVG(length),0)*60) from sakila.film;

# You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT DATEDIFF(max(rental_date), min(rental_date)) from sakila.rental;
SELECT max(CONVERT(rental_date, DATE)) FROM sakila.rental;
SELECT min(CONVERT(rental_date, DATE)) FROM sakila.rental;

#DATE_FORMAT(CONVERT(column, DATE, '%d-%M-%Y')

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *, monthname(rental_date) AS month, dayname(rental_date) AS weekday FROM sakila.rental
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.
-- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT * FROM sakila.rental
CASE
WHEN dayname(rental_date) in ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday') THEN 'workday'
ELSE 'weekend'
END AS 'Day_type';

-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.
-- Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.

-- Challenge 2
-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT COUNT(title) FROM sakila.film;

-- 1.2 The number of films for each rating.
SELECT COUNT(*) AS NB_PER_RATING, rating FROM sakila.film
GROUP BY RATING;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
SELECT COUNT(*) AS NB_PER_RATING, rating FROM sakila.film
GROUP BY RATING
ORDER BY rating DESC;

-- This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
-- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. 
-- This will help identify popular movie lengths for each category.
SELECT COUNT(*) AS NB_PER_RATING, rating, round(avg(length),2) as average_duration FROM sakila.film
GROUP BY RATING
ORDER BY rating DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT COUNT(*) AS NB_PER_RATING, rating, round(avg(length),2) as average_duration FROM sakila.film
GROUP BY RATING
HAVING round(avg(length),2)>120
ORDER BY rating DESC;

-- Bonus: determine which last names are not repeated in the table actor.
SELECT DISTINCT(last_name) FROM sakila.actor;