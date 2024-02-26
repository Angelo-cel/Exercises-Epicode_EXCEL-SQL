-- Identificate tutti i clienti che non hanno effettuato nessun noleggio a gennaio 2006.
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
AND MONTH(r.rental_date) = 1
AND YEAR(r.rental_date) = 2006
WHERE r.rental_id IS NULL;


-- Elencate tutti i film che sono stati noleggiati più di 10 volte nell’ultimo quarto del 2005

SELECT f.film_id, f.title, COUNT(r.rental_id) AS num_rentals
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE YEAR(r.rental_date) = 2005
AND QUARTER(r.rental_date) = 4
GROUP BY f.film_id, f.title
HAVING COUNT(r.rental_id) > 10;

-- Trovate il numero totale di noleggi effettuati il giorno 1/1/2006.

SELECT COUNT(rental_id) AS total_rentals
FROM rental
WHERE DATE(rental_date) = '2006-01-01';


-- Calcolate la somma degli incassi generati nei weekend (sabato e domenica).
SELECT SUM(amount) AS total_weekend_revenue
FROM payment
WHERE DAYOFWEEK(payment_date) IN (1, 7);


-- Individuate il cliente che ha speso di più in noleggi.

SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 1;


-- elencate i 5 film con la maggior durata media di noleggio

SELECT 
    f.film_id,
    f.title,
    AVG(TIMESTAMPDIFF(DAY, r.rental_date, r.return_date)) AS avg_rental_duration
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    f.film_id, f.title
ORDER BY 
    avg_rental_duration DESC
LIMIT 5;

-- Calcolate il tempo medio tra due noleggi consecutivi da parte di un cliente.
SELECT 
    c.first_name, c.last_name,
    AVG(TIMESTAMPDIFF(DAY, r1.return_date, r2.rental_date)) AS avg_time_between_rentals
FROM 
    rental r1
JOIN 
    rental r2 ON r1.customer_id = r2.customer_id
    AND r1.rental_date < r2.rental_date
JOIN
    customer c ON r1.customer_id = c.customer_id
GROUP BY 
    r1.customer_id;

-- Individuate il numero di noleggi per ogni mese del 2005.

SELECT 
    MONTH(rental_date) AS month,
    COUNT(*) AS rental_count
FROM 
    rental
WHERE 
    YEAR(rental_date) = 2005
GROUP BY 
    MONTH(rental_date);
    
    -- Trovate i film che sono stati noleggiati almeno due volte lo stesso giorno
    
  SELECT 
    r.rental_date,
    f.title AS film_title,
    COUNT(*) AS rental_count
FROM 
    rental r
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    film f ON i.film_id = f.film_id
GROUP BY 
    r.rental_date, f.title
HAVING 
    rental_count >= 2;
    
    
    -- Calcolate il tempo medio di noleggio.
    
    SELECT AVG(DATEDIFF(return_date, rental_date)) AS avg_rental_duration
FROM rental
WHERE return_date IS NOT NULL;
