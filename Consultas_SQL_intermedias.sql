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
group by c.category_id
having avg(f.length) > 110;

-- ¿Cuál es la media de duración del alquiler de las películas?
select avg(return_date - rental_date) as media_duracion
from rental;

-- Crea una columna con el nombre completo (nombre y apellidos) de los actores y actrices.
select concat(first_name, ' ', last_name) as nombre_completo
from actor;

-- Muestra los números de alquileres por día, ordenados de forma descendente.
-- Uso la funcion date para poder quedarme unicamente con la fecha (el dia) sin importar las horas ya que sino puede aparecer el mismo dia en varios registros diferentes por disponer de distintas horas
select 
	count(date(rental_date)) as numero_alquileres,
	date(rental_date) as dia_alquiler
from rental 
group by 2 
order by 1 desc;

-- Encuentra las películas con una duración superior al promedio.
select title 
from film f 
where length > (select avg(length) from film);

-- Averigua el número de alquileres registrados por mes.
-- Utilizo la funcion date_trunc para poder contar y agrupar únicamente por mes
select 
	count(date_trunc('month', rental_date)) as numero_alquileres,
	date_trunc('month', rental_date) as mes_alquiler
from rental 
group by 2;

-- Encuentra el promedio, la desviación estándar y la varianza del total pagado.
select 
	avg(amount) as promedio_total_pagado,
	variance(amount) as var_total_pagado,
	stddev(amount) as desv_total_pagado
from payment;

-- ¿Qué películas se alquilan por encima del precio medio?
select f.title
from film f 
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
join payment p on r.rental_id = p.rental_id
where p.amount > (select avg(amount) from payment);

-- Muestra el ID de los actores que hayan participado en más de 40 películas.
select 
	a.actor_id,
	count(f.film_id) as recuento
from actor a
join film_actor fa on a.actor_id = fa.actor_id
join film f on fa.film_id = f.film_id 
group by a.actor_id
having count(f.film_id) > 40;

-- Obtén todas las películas y, si están disponibles en el inventario, muestra la cantidad disponible.
select 
	f.title as titulo,
	count(i.inventory_id) as cantidad_disponible
from film f
join inventory i on f.film_id = i.film_id
group by f.title;

-- Obtén los actores y el número de películas en las que han actuado.
select 
	concat(a.first_name, ' ', a.last_name) as nombre_actor,
	count(fa.film_id) as num_peliculas
from actor a
join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id;

-- Obtén todas las películas con sus actores asociados, incluso si algunas no tienen actores.
select 
	f.title as titulo,
	concat(a.first_name, ' ', a.last_name) as nombre_actor
from film f
left join film_actor fa on f.film_id = fa.film_id 
left join actor a on fa.actor_id = a.actor_id;

-- Encuentra los 5 clientes que más dinero han gastado.
-- En algunas consultas escribo el order by/ group by con los numeros indicando la posicion de los campos en la select y en otros directamente con los campos calculados o el alias
select 
	concat(c.first_name, ' ', c.last_name) as nombre_cliente,
	sum(p.amount) as dinero_gastado
from customer c 
join payment p on c.customer_id = p.customer_id
group by c.customer_id
order by 2 desc
limit 5;
