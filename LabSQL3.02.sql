
-- Lab | SQL Subqueries 3.03 --

USE sakila;

-- 1. How many copies of the film Hunchback Impossible exist in the inventory system?
-- -- 6 Copies of the film Hunchback Impossible exist in the inventory
select count(film_id) from sakila.inventory
where film_id = 439;



-- 2. List all films whose length is longer than the average of all the films.
select film_id, title, length from sakila.film
where length > (select avg(length)
from sakila.film)
order by length;



-- 3. Use subqueries to display all actors who appear in the film Alone Trip.
select * from film;

select * from sakila.film
where title = "Alone Trip";

select count(distinct actor_id), film_id from sakila.film_actor
where film_id =17
group by film_id;


select actor_id, first_name, last_name from sakila.actor
where actor_id in
	(select film_actor.actor_id
    from sakila.film_actor
    where film_id = 17);




-- 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
select * from sakila.category
where category_id = 8;

select * from sakila.film_category;
select * from sakila.category;
select * from sakila.film;

select film_id as ID, title as Title, description as Description from sakila.film
where film_id in
	(select sakila.film_category.film_id
    from sakila.film_category
    where category_id = 8);

-- Also possible to obtain the results using joins
SELECT f.film_id, f.title, fc.category_id, c.name FROM sakila.film AS f
JOIN sakila.film_category AS fc
ON f.film_id = fc.film_id
LEFT JOIN sakila.category AS c
ON fc.category_id = c.category_id
WHERE c.category_id = 8;




-- 5. Get name and email from customers from Canada using subqueries.
-- Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
select * from sakila.customer;
select * from sakila.country;
select * from sakila.city;
select * from sakila.address;

select * from sakila.country
where country = "Canada";

-- country/city --> country_id
-- city/address --> city_id group by -> address_id
-- address/customer --> address_id group by --> customer_id
-- Canada country ID is 20
-- Cities within Canada: 179(Gatineau), 196(Halifax), 300(Lethbridge), 313(London), 383(Oshawa), 430(Richmond Hill), 564(Vancouver)
USE sakila;

-- WITH SUBQUERIES --
select customer.customer_id as ID, concat(customer.first_name, " ", customer.last_name) as Full_name, customer.email as Email from sakila.customer
where address_id in(select address_id from address
where city_id in(select city_id from city
where country_id = 20));

-- WITH JOINS --
select c.customer_id, c.first_name, c.last_name, c.email from sakila.customer as c
join sakila.address as a
on c.address_id = a.address_id
left join sakila.city as ci
on a.city_id = ci.city_id
where ci.country_id = 20;


-- 6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films.
-- First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.



