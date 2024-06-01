USE sakila;
SHOW TABLES;
-- 1.  Escribe una consulta para mostrar para cada tienda su ID de tienda, ciudad y país.
SELECT * FROM store;
SELECT * FROM address;
SELECT * FROM city;
SELECT * FROM country;
SELECT * FROM rental;
SELECT * FROM payment;
-- address |  city 'city_id'
-- country |  city 'country_id'
-- address  | store 'address_id'
SELECT T1.store_id, T3.city, T4.country
FROM store AS T1

LEFT JOIN
address AS T2
	ON T1.address_id = T2.address_id

LEFT JOIN
city AS T3
	ON T2.city_id = T3.city_id

LEFT JOIN
country AS T4
	ON T3.country_id = T4.country_id
;

-- 2.  Escribe una consulta para mostrar cuánto negocio, en dólares, trajo cada tienda.
-- store | inventory 'store_id'
-- inventory | rental 'inventory_id'
-- rental | payment 'rental_id' 
SELECT T1.store_id, SUM(T4.amount) AS 'REVENUE'
FROM store as T1
LEFT JOIN
inventory AS T2
	ON T1.store_id = T2.store_id
    
LEFT JOIN
rental AS T3
	ON T2.inventory_id = T3.inventory_id
    
LEFT JOIN
payment AS T4
	ON T3.rental_id = T4.rental_id

GROUP BY T1.store_id
;

-- 3.  ¿Cuál es el tiempo de ejecución promedio de las películas por categoría?
SELECT * FROM film;
SELECT * FROM category;
-- film | film category 'film_id'
-- film category | category  'category_id'
SELECT T3.name, AVG(T1.length)
FROM film AS T1
LEFT JOIN
film_category AS T2
	ON T1.film_id = T2.film_id
LEFT JOIN
category AS T3
	ON T2.category_id = T3.category_id

GROUP BY T3.name
ORDER BY T3.name ASC
;

-- 4.  ¿Qué pelicula es más larga de cada categoria?
SELECT T3.name, MAX(T1.length)
FROM film AS T1
LEFT JOIN
film_category AS T2
	ON T1.film_id = T2.film_id
LEFT JOIN
category AS T3
	ON T2.category_id = T3.category_id

GROUP BY T3.name
;

 -- 5.  Muestra las películas más alquiladas en orden descendente
 SELECT * FROM inventory;
 -- film | inventory 'film_id' 
 --  inventory | rental 'rental_id'
 SELECT T1.title, COUNT(T3.rental_id) AS 'rental count'
 FROM FILM AS T1
 LEFT JOIN
 inventory AS T2
	ON T1.film_id = T2.film_id
    
LEFT JOIN
rental AS T3
	ON T2.inventory_id = T3.inventory_id
 
 GROUP BY T1.title
 ORDER BY COUNT(T3.rental_id) DESC, T1.title ASC
 ;
 
 -- 6. Enumera los cinco principales géneros en ingresos brutos en orden descendente
 -- inventory | film   'film_id'
 -- inventory | rental  'inventory_id'
 -- rental | payment 'rental_id' 
 
 -- film | film_category  'film_id'
 -- film category | category  'category_id'
 SELECT T4.name, SUM(T6.amount) AS REVENUE
 FROM film AS T1
 LEFT JOIN
 film_category AS T2
	ON T1.film_id = T2.film_id
 
 LEFT JOIN
 inventory AS T3
    ON T1.film_id = T3.film_id  
    
LEFT JOIN
category AS T4
	ON T2.category_id = T4. category_id

LEFT JOIN
rental AS T5
	ON T3.inventory_id = T5.inventory_id

LEFT JOIN
payment AS T6
	ON T5.rental_id = T6.rental_id
    
GROUP BY T4.name
ORDER BY REVENUE DESC
LIMIT 5
 ;
 
-- 7.  ¿Está "Academy Dinosaur" disponible para alquilar en la Tienda 1?
-- film |  inventory 'film_id'
-- inventory | store 'store_id'

SELECT T1.title, T3.store_id
FROM film AS T1
LEFT JOIN
inventory AS T2
	ON T1.film_id = T2.film_id

LEFT JOIN
store AS T3
	ON T2.store_id = T3.store_id

WHERE T1.title = 'Academy Dinosaur' AND T3.store_id = '1'
;