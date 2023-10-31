use sakila;
-- Task 1 - Display the full names of all actors --
select*from actor;
select concat(first_name, ' ' ,last_name) as full_name from actor;

-- Task 2 --
-- i. Display the number of times each first name appears in the database. --
select first_name, count(first_name) as count_of_firstname
from actor
group by first_name
order by count_of_firstname desc ; 

-- ii. What is the count of actors that have unique first names in the database? Display the first names of all these actors.--
select first_name, count(first_name) as count_of_firstname
from actor
group by first_name
HAVING COUNT(*) = 1;

-- Task 3 --
-- i. Display the number of times each last name appears in the database. --
 select last_name, count(last_name) as count_of_lastname
 from actor
 group by last_name
 order by count_of_lastname desc ;
 
 -- ii. Display all unique last names in the database. --
select last_name, count(last_name) as count_of_lastname
from actor
group by last_name
HAVING COUNT(*) = 1;

-- Task 4 --
-- i. Display the list of records for the movies with the rating "R". (The movies with the rating "R" are not suitable for audience under 17 years of age).--
select *from film 
where rating = 'R';

-- ii. Display the list of records for the movies that are not rated "R". --
select *from film 
where rating != 'R';

-- iii. Display the list of records for the movies that are suitable for audience below 13 years of age.--
select *from film 
where rating = 'PG-13' or rating = 'G';

-- Task 5 --
-- i. Display the list of records for the movies where the replacement cost is up to $11. --
select * from film
where replacement_cost <=11 ;

-- ii. Display the list of records for the movies where the replacement cost is between $11 and $20. --
select * from film
where replacement_cost between 11 and 20 ;

-- iii. Display the list of records for the all movies in descending order of their replacement costs.--
select * from film
order by replacement_cost desc;

-- Task 6 - Display the names of the top 3 movies with the greatest number of actors.--

select f.title ,count(a.actor_id) as actor_count 
from film as f
join film_actor as fa on f.film_id = fa.film_id
join actor as a on fa.actor_id = a.actor_id
group by f.title
order by actor_count desc
limit 3;

-- Task 7: 'Music of Queen' and 'Kris Kristofferson' have seen an unlikely resurgence. As an unintended consequence, films starting with the letters 'K' and 'Q' have also soared in popularity. Display the titles of the movies starting with the letters 'K' and 'Q.--
select title from film
where title LIKE 'K%' or title LIKE 'Q%'
ORDER BY title;

-- Task 8: The film 'Agent Truman' has been a great success. Display the names of all actors who appeared in this film.--
select first_name,last_name from actor
inner join film_actor using (actor_id)
inner join film using (film_id)
where title = 'AGENT TRUMAN';
 
 -- Task 9: Sales have been lagging among young families, so the management wants to promote family movies. Identify all the movies categorized as family films --
select title from film 
inner join film_category using (film_id)
inner join category using (category_id)
where name = 'family'

-- Task 10 --
-- i.Display the maximum, minimum, and average rental rates of movies based on their ratings. The output must be sorted in descending order of the average rental rates.--
Select rating,
   Max(rental_rate) as max_rental_rate,
   Min(rental_rate) as min_rental_rate,
   AVG(rental_rate) as avg_rental_rate
from film
group by rating 
order by avg_rental_rate desc;

-- ii. Display the movies in descending order of their rental frequencies, so the management can maintain more copies of those movies --
select title,rental_duration 
from film
order by rental_duration desc;

-- Task 11: In how many film categories, the difference between the average film replacement cost ((disc - DVD/Blue Ray) and the average film rental rate is greater than $15? -- 
SELECT name, 
AVG(replacement_cost - rental_rate) AS cost_rate_difference
FROM category
inner join film_category using (category_id)
inner join film using (film_id)
GROUP BY name
HAVING cost_rate_difference > 15;


-- Task 12: Display the film categories in which the number of movies is greater than 70.--
SELECT name, COUNT(*) AS movie_count
FROM category
inner join film_category using (category_id)
inner join film using (film_id)
GROUP BY name
HAVING movie_count > 70;




