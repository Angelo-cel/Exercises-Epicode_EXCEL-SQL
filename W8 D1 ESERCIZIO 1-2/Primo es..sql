-- Effettuate un’esplorazione preliminare del database. 
-- 1- Di cosa si tratta?
-- 2- Quante e quali tabelle contiene?

/* 1 - Il database in questione è progettato per gestire un negozio di noleggio di film. 
Esso contiene un insieme di tabelle che registrano informazioni su film, attori,
 clienti, transazioni di noleggio, inventario, pagamento e altro ancora*/
 
 -- 2
SELECT COUNT(*)
FROM information_schema.tables
WHERE table_schema = 'sakila';

SHOW TABLES;


-- Scoprite quanti clienti si sono registrati nel 2006
SELECT COUNT(*)
FROM customer
WHERE YEAR(create_date) = 2006;

-- Trovate il numero totale di noleggi effettuati il giorno 1/1/2006.

SELECT COUNT(*)
FROM rental
WHERE DATE(rental_date) = '2006-01-01';


-- Elencate tutti i film noleggiati nell’ultima settimana e tutte le informazioni legate al cliente che li ha noleggiati.
SELECT f.title AS film_title, f.description AS film_description, c.first_name AS customer_first_name, c.last_name AS customer_last_name, c.email AS customer_email
FROM rental AS r
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film AS f ON i.film_id = f.film_id
JOIN customer AS c ON r.customer_id = c.customer_id
WHERE r.rental_date >= (SELECT MAX(rental_date) FROM rental) - INTERVAL 1 WEEK;


-- Calcolate la durata media del noleggio per ogni categoria di film.

SELECT c.name AS category_name, AVG(f.rental_duration) AS average_rental_duration
FROM film_category AS fc
JOIN film AS f ON fc.film_id = f.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name;


-- trovate la durata del noleggio più lungo
SELECT MAX(rental_duration) AS longest_rental_duration
FROM film;


