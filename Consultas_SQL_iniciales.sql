-- Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.
select title
from film
where rating = 'R';

-- Encuentra los nombres de los actores con actor_id entre 30 y 40.
select concat(first_name, ' ', last_name) as nombre_actor
from actor
where actor_id between 30 and 40;

-- Obtén las películas cuyo idioma coincide con el idioma original.
select title
from film 
where language_id = original_language_id;

-- Ordena las películas por duración de forma ascendente.
select title 
from film 
order by length asc;

-- Encuentra el nombre y apellido de los actores con ‘Allen’ en su apellido.
select 
	first_name,
	last_name 
from actor 
where last_name like '%Allen%';

-- Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.
select 
	rating as clasificacion, 
	count(rating) as recuento
from film
group by rating;

-- Encuentra el título de todas las películas que son ‘PG13’ o tienen una duración mayor a 3 horas.
select title
from film 
where rating = 'PG-13' or length > 180;

-- Encuentra la variabilidad de lo que costaría reemplazar las películas.
select stddev(replacement_cost) as desv_est
from film;

-- Encuentra la mayor y menor duración de una película en la base de datos.
select 
	min(length) as menor_duracion,
	max(length) as mayor_duracion
from film;

-- Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select amount as costo_alquiler
from payment 
order by payment_date desc
limit 1 offset 2;

-- Encuentra el título de las películas que no sean ni ‘NC-17’ ni ‘G’ en cuanto a clasificación.
select title 
from film 
where rating not in ('NC-17', 'G');

-- Encuentra el promedio de duración de las películas para cada clasificación y muestra la clasificación junto con el promedio.
select 
	rating as clasificacion,
	avg(length) as promedio_duracion
from film
group by rating;

-- Encuentra el título de todas las películas con una duración mayor a 180 minutos.
select title 
from film 
where length > 180;

-- ¿Cuánto dinero ha generado en total la empresa?
select sum(amount) as dinero_total
from payment;

-- Muestra los 10 clientes con mayor valor de ID.
select concat(first_name, ' ', last_name) as nombre_clientes
from customer 
order by customer_id desc
limit 10;

-- Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.
select concat(a.first_name, ' ', a.last_name) as nombre_actores
from actor a
join film_actor f on a.actor_id = f.actor_id
join film f2 on f.film_id = f2.film_id
where f2.title = 'Egg Igby';


