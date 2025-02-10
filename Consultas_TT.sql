-- Calcula el número total de alquileres realizados por cada cliente.
select 
	concat (c.first_name, ' ', c.last_name) as nombre_cliente,
	coalesce(count(r.rental_id), 0) as numero_alquileres
from customer c 
left join rental r on c.customer_id = r.customer_id
group by c.customer_id;

-- Calcula la duración total de las películas en la categoría Action.
select 
	sum(f.length) as duracion_total
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where c.name = 'Action';

-- Encuentra los clientes que alquilaron al menos 7 películas distintas.
select
    count(distinct(f.film_id)) as cantidad_peliculas,
    concat (c.first_name, ' ', c.last_name) as nombre_cliente
from film f 
join inventory i ON f.film_id = i.film_id 
join rental r ON i.inventory_id = r.inventory_id
join customer c on r.customer_id = c.customer_id
group by c.customer_id
having count(distinct(f.film_id)) > 6;

-- Encuentra la cantidad total de películas alquiladas por categoría.
-- Lo he hecho con la cantidad total de peliculas DISTINTAS alquiladas por categoría
select 
	count(distinct(f.film_id)) as cantidad_peliculas,
	c.name as categoria
from film f 
join inventory i on f.film_id = i.film_id 
join rental r on i.inventory_id = r.inventory_id
join film_category fc on f.film_id = fc.film_id 
join category c on fc.category_id = c.category_id
group by c.category_id;

-- Renombra las columnas first_name como Nombre y last_name como Apellido.
-- Lo he hecho de la tabla de clientes
select 
	first_name as "Nombre",
	last_name as "Apellido"
from customer;

-- Crea una tabla temporal llamada cliente_rentas_temporal para almacenar el total de alquileres por cliente.
create temporary table cliente_rentas_temporal (
nombre_cliente varchar(200),
total_alquileres int
);

insert into cliente_rentas_temporal 
select 
	concat(c.first_name, ' ', c.last_name) as nombre_cliente,
	count(r.rental_id) as total_alquileres
from customer c 
join rental r on c.customer_id = r.customer_id 
group by c.customer_id;

select * from cliente_rentas_temporal;

-- Crea otra tabla temporal llamada peliculas_alquiladas para almacenar películas alquiladas al menos 10 veces.
create temporary table peliculas_alquiladas (
nombre_pelicula varchar(200),
num_veces_alquilada int
);

insert into peliculas_alquiladas
select 
	f.title as nombre_pelicula,
	count(r.rental_id) as num_veces_alquilada
from film f 
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
group by f.film_id
having count(r.rental_id) > 9;

select * from peliculas_alquiladas;

-- Encuentra los nombres de los clientes que más gastaron y sus películas asociadas.
-- Lo que he hecho es sacar el total gastado por cada cliente y que aparezcan todas las peliculas asociadas al gasto en una misma linea separadas por / 
select 
	concat(c.first_name, ' ', c.last_name) as nombre_cliente,
	sum(p.amount) as gasto,
	string_agg(f.title, ' /') as peliculas
from customer c
join payment p on c.customer_id = p.customer_id
join rental r on p.rental_id = r.rental_id
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
group by c.customer_id
order by 2 desc;

-- Encuentra los actores que actuaron en películas de la categoría Sci-Fi.
select 
	concat(a.first_name, ' ', a.last_name) as nombre_actor
from actor a
join film_actor fa on a.actor_id = fa.actor_id
join film_category fc on fa.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where c.name = 'Sci-Fi';