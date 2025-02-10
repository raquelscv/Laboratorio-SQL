-- Selecciona todos los nombres únicos de películas.
select distinct(title) as nombres_unicos 
from film;

-- Encuentra las películas que son comedias y tienen una duración mayor a 180 minutos.
select f.title 
from film f
join film_category fc on f.film_id = fc.film_id 
join category c on fc.category_id = c.category_id 
where c.name = 'Comedy' and f.length > 180;

-- Encuentra las categorías de películas con un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio.
select 
	c.name as categoria,
	avg(f.length) as promedio_duracion
from category c 
join film_category fc on c.category_id = fc.category_id 
join film f on fc.film_id = f.film_id
group by categoria
having avg(f.length) > 110;

-- ¿Cuál es la media de duración del alquiler de las películas?
select avg(rental_duration) as media_duracion
from film;

-- Crea una columna con el nombre completo (nombre y apellidos) de los actores y actrices.
select concat(first_name, ' ', last_name) as nombre_completo
from actor;

-- Muestra los números de alquileres por día, ordenados de forma descendente.
select 
	count(*) as numero_alquileres,
	rental_date
from rental 
group by rental_date
order by numero_alquileres desc;

-- Encuentra las películas con una duración superior al promedio.
select title 
from film f where length > (select avg(length) from film);

-- Averigua el número de alquileres registrados por mes.


-- Encuentra el promedio, la desviación estándar y la varianza del total pagado.
select 
	avg(amount) as promedio_total_pagado,
	variance(amount) as var_total_pagado,
	stddev(amount) as desv_total_pagado
from payment;

-- ¿Qué películas se alquilan por encima del precio medio?


-- Muestra el ID de los actores que hayan participado en más de 40 películas.
select 
	a.actor_id,
	count(f.*) as recuento
from actor a
join film_actor fa on a.actor_id = fa.actor_id
join film f on fa.film_id = f.film_id 
group by a.actor_id
having count(f.*) > 40;

-- Obtén todas las películas y, si están disponibles en el inventario, muestra la cantidad disponible.


-- Obtén los actores y el número de películas en las que han actuado.
select 
	concat(a.first_name, ' ', a.last_name) as nombre_actor,
	count(f.film_id) as num_peliculas
from actor a
join film_actor fa on a.actor_id = fa.actor_id
join film f on fa.film_id = f.film_id
group by nombre_actor;

-- Obtén todas las películas con sus actores asociados, incluso si algunas no tienen actores.
select 
	f.title,
	concat(a.first_name, ' ', a.last_name) as nombre_actor
from film f
left join film_actor fa on f.film_id = fa.film_id 
left join actor a on fa.actor_id = a.actor_id;

-- Encuentra los 5 clientes que más dinero han gastado.
select 
	concat(c.first_name, ' ', c.last_name) as nombre_cliente,
	sum(p.amount) as dinero_gastado
from customer c 
join payment p on c.customer_id = p.customer_id
group by nombre_cliente
order by dinero_gastado desc
limit 5;
