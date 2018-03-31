USE sakila;
-- 1a
SELECT first_name, last_name FROM actor;
-- 1b
SELECT CONCAT_WS(' ', first_name, last_name) AS `Actor Name` FROM actor;
-- 2a
SELECT actor_id, first_name, last_name FROM actor WHERE first_name="Joe";
-- 2b
SELECT * FROM actor WHERE last_name LIKE "%GEN%";
-- 2c
SELECT * FROM actor WHERE last_name LIKE "%LI%" ORDER BY last_name, first_name;
-- 2d
SELECT country_id, country FROM country WHERE country IN ("Afghanistan", "Bangladesh", "China");
-- 3a
ALTER TABLE actor ADD COLUMN middle_name VARCHAR(45) AFTER first_name;
-- 3b
ALTER TABLE actor CHANGE COLUMN middle_name middle_name BLOB AFTER first_name;
-- 3c
ALTER TABLE actor DROP COLUMN middle_name;
-- 4a
SELECT last_name, COUNT(last_name) FROM actor GROUP BY last_name;
-- 4b
SELECT last_name, COUNT(last_name) c FROM actor GROUP BY last_name HAVING c > 1;
-- 4c
UPDATE actor SET first_name="HARPO" WHERE last_name="WILLIAMS" AND first_name="GROUCHO";
-- 4d
UPDATE actor SET first_name=IF(first_name="HARPO", "GROUCHO", "MUCHO GROUCHO") WHERE last_name="WILLIAMS" AND first_name="HARPO";
-- 5a
SHOW CREATE TABLE address;
-- 6a
SELECT first_name, last_name, address FROM staff JOIN address ON staff.address_id = address.address_id;
-- 6b 
SELECT staff_id AS 'Staff ID', SUM(amount) AS 'Total Amount Aug 2005' FROM payment WHERE staff_id IN (SELECT staff_id FROM staff) AND payment_date LIKE '2005-08%' GROUP BY staff_id;
-- 6c
SELECT title, COUNT(actor_id) AS 'number of actors' FROM film INNER JOIN film_actor ON film_actor.film_id = film.film_id GROUP BY title;
-- 6d
SELECT COUNT(*) AS '# of Hunchback Impossible' FROM film INNER JOIN inventory ON film.film_id = inventory.film_id WHERE title='Hunchback Impossible';
-- 6e
SELECT first_name, last_name, SUM(amount) AS 'total_paid' FROM payment p JOIN customer c ON p.customer_id = c.customer_id GROUP BY last_name;
-- 7a
SELECT title FROM film WHERE (title LIKE 'K%' OR title LIKE 'Q%') AND language_id IN (SELECT language_id FROM language WHERE name='English');
-- 7b
SELECT first_name, last_name FROM actor WHERE actor_id IN (SELECT actor_id FROM film_actor WHERE film_id IN (SELECT film_id FROM film WHERE title='ALone Trip'));
-- 7c
SELECT first_name, last_name, email FROM customer c JOIN address a ON c.address_id = a.address_id JOIN city ON a.city_id = city.city_id JOIN country co ON city.country_id = co.country_id WHERE country='Canada';
#SELECT first_name, last_name, email FROM customer WHERE address_id IN (SELECT address_id FROM address WHERE city_id IN (SELECT city_id FROM city WHERE country_id IN (SELECT country_id FROM country WHERE country = "Canada")));
-- 7d
SELECT title FROM film WHERE film_id IN (SELECT film_id FROM film_category WHERE category_id IN (SELECT category_id FROM category WHERE name="Family"));
-- 7e
SELECT title, (SELECT COUNT(*) FROM inventory WHERE film.film_id = inventory.film_id) AS 'rental count' FROM film WHERE film_id IN (SELECT film_id FROM inventory WHERE inventory_id IN (SELECT inventory_id FROM rental)) ORDER BY `rental count` DESC;
-- 7f
SELECT staff_id AS 'Store', SUM(amount) AS '$ Brought In' FROM payment WHERE staff_id IN (SELECT manager_staff_id AS staff_id FROM store) GROUP BY staff_id;
-- 7g
SELECT store_id, city, country FROM country co JOIN city ON co.country_id = city.country_id JOIN address a ON city.city_id = a.city_id JOIN store s ON  a.address_id = s.address_id;
-- 7h
SELECT c.name, SUM(amount) AS 'gross_revenue' FROM category c JOIN film_category fc ON c.category_id = fc.category_id JOIN inventory i on fc.film_id = i.film_id JOIN rental r on i.inventory_id = r.inventory_id JOIN payment p on r.rental_id = p.rental_id GROUP BY name ORDER BY gross_revenue DESC LIMIT 5;
-- 8a
CREATE VIEW top_five_genres AS SELECT c.name, SUM(amount) AS 'gross_revenue' FROM category c JOIN film_category fc ON c.category_id = fc.category_id JOIN inventory i on fc.film_id = i.film_id JOIN rental r on i.inventory_id = r.inventory_id JOIN payment p on r.rental_id = p.rental_id GROUP BY name ORDER BY gross_revenue DESC LIMIT 5;
-- 8b
SELECT * FROM top_five_genres;
-- 8c
DROP VIEW top_five_genres;