-- Encuentra el ID del actor más bajo y más alto.
select 
	min(actor_id) as id_mas_bajo,
	max(actor_id) as id_mas_alto
from actor;

-- Cuenta cuántos actores hay en la tabla actor.
select count(actor_id) as recuento_actores
from actor;

-- Selecciona todos los actores y ordénalos por apellido en orden ascendente.
select concat(first_name, ' ', last_name) as nombre_actor
from actor
order by last_name desc;

-- Selecciona las primeras 5 películas de la tabla film.
select title 
from film
limit 5;

-- Agrupa los actores por nombre y cuenta cuántos tienen el mismo nombre.
select 
	first_name as nombre,
	count(first_name) as recuento
from actor
group by nombre;

-- Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select 
	r.rental_id,
	concat(c.first_name, ' ', c.last_name) as nombre_cliente
from rental r
join customer c on r.customer_id = c.customer_id;

-- Muestra todos los clientes y sus alquileres, incluyendo los que no tienen.
select 
	concat(c.first_name, ' ', c.last_name) as nombre_cliente,
	r.rental_id
from customer c 
left join rental r on c.customer_id = r.customer_id;

-- Realiza un CROSS JOIN entre las tablas film y category. Analiza su valor.

-- Encuentra los actores que han participado en películas de la categoría ‘Action’.
select concat(a.first_name, ' ', a.last_name) as nombre_actor
from actor a 
join film_actor fa on a.actor_id = fa.actor_id 
join film_category fc on fa.film_id = fc.film_id 
join category c on fc.category_id = c.category_id 
where c.name = 'Action';

-- Encuentra todos los actores que no han participado en películas.
select concat(a.first_name, ' ', a.last_name) as nombre_actor
from actor a 
left join film_actor fa on a.actor_id = fa.actor_id
where fa.film_id is null;

-- Crea una vista llamada actor_num_peliculas que muestre los nombres de los actores y el número de películas en las que han actuado.