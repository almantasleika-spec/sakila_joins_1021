-- USE sakila;

-- 1. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:

/*SELECT
  staff.first_name FirstName,
  staff.last_name LastName,
  address.address Address,
  address.address2 Address2,
  address.district District,
  city.city City,
  address.postal_code PostalCode,
  country.country Country
FROM `tc-da-1.sakila_db.staff` staff
JOIN `tc-da-1.sakila_db.address` address
ON staff.address_id = address.address_id
JOIN `tc-da-1.sakila_db.city` city
ON address.city_id = city.city_id
JOIN `tc-da-1.sakila_db.country` country
ON city.country_id = country.country_id;*/

-- 2. Write a query to display for each store its store ID, city, and country. Use tables store, address, city and country.

/*SELECT
  store.store_id Store,
  city.city City,
  country.country Country
FROM `tc-da-1.sakila_db.store` store
JOIN `tc-da-1.sakila_db.address` address
ON store.address_id = address.address_id
JOIN `tc-da-1.sakila_db.city` city
ON address.city_id = city.city_id
JOIN `tc-da-1.sakila_db.country` country
ON city.country_id = country.country_id;*/

-- 3. Use JOIN to display the total payment amount by each staff member. Use tables staff and payment. Use SUM for amount.

/*SELECT
  CONCAT(staff.first_name, ' ', staff.last_name) StaffMember,
  SUM(payment.amount) TotalPayment
FROM `tc-da-1.sakila_db.staff` staff
JOIN `tc-da-1.sakila_db.payment` payment
ON staff.staff_id = payment.staff_id
GROUP BY StaffMember
ORDER BY StaffMember DESC;*/

-- 4. Use JOIN to display the total payment amount by each staff member in August of 2005. Use tables staff and payment. Use LIKE for payment_date.

/*SELECT
  CONCAT(staff.first_name, ' ', staff.last_name) StaffMember,
  SUM(payment.amount) PaymentAugust
FROM `tc-da-1.sakila_db.staff` staff
JOIN `tc-da-1.sakila_db.payment` payment
ON staff.staff_id = payment.staff_id
WHERE CAST(payment.payment_date AS STRING) LIKE '2005-08-%'
GROUP BY StaffMember
ORDER BY StaffMember DESC;*/

-- 5. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.

/*SELECT
 film.title FilmTitle,
 COUNT(filmactor.actor_id) NoActors
FROM `tc-da-1.sakila_db.film` film
JOIN `tc-da-1.sakila_db.film_actor` filmactor
ON film.film_id = filmactor.film_id
GROUP BY film.title
ORDER BY film.title;*/


-- 6. How many copies of the film Hunchback Impossible exist in the inventory system? Use tables film and inventory.

/*SELECT 
  film.title Title, 
  COUNT(inventory.inventory_id) NoCopies
FROM `tc-da-1.sakila_db.film` film
JOIN `tc-da-1.sakila_db.inventory` inventory
ON film.film_id = inventory.film_id
WHERE film.title = 'HUNCHBACK IMPOSSIBLE'
GROUP BY film.title;*/

-- 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:

/*SELECT
  customer.first_name FirstName, 
  customer.last_name LastName,
  SUM(payment.amount) TotalAmount
FROM `tc-da-1.sakila_db.customer` customer
JOIN `tc-da-1.sakila_db.payment` payment
ON customer.customer_id = payment.customer_id
GROUP BY 
  customer.last_name,
  customer.first_name
ORDER BY customer.last_name;*/

-- 8.a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
-- Use tables film and language

/*SELECT title FilmTitle, 
  (SELECT name
  FROM `tc-da-1.sakila_db.language`
  WHERE language_id = film.language_id) Language
FROM `tc-da-1.sakila_db.film` film
WHERE (film.title LIKE 'K%' OR film.title LIKE 'Q%')
  AND film.language_id IN (
    SELECT language_id
    FROM `tc-da-1.sakila_db.language`
    WHERE name = 'English'
  )
ORDER BY title;*/

-- 8.b Make the task above with join.   
	
/*SELECT
  film.title FilmTitle,
  lang.name Language
FROM `tc-da-1.sakila_db.film` film
JOIN `tc-da-1.sakila_db.language` lang
ON film.language_id = lang.language_id
WHERE (film.title LIKE 'K%' OR film.title LIKE 'Q%')
 AND lang.name = 'English'
GROUP BY film.title, lang.name
ORDER BY film.title;*/

-- 9. Use subqueries to display all actors who appear in the film Alone Trip. Use tables film, film_actor and film.

/*SELECT 
  first_name FirstName,
  last_name LastName
FROM `tc-da-1.sakila_db.actor` actor
WHERE actor_id IN (
  SELECT actor_id
  FROM `tc-da-1.sakila_db.film_actor`
  WHERE film_id IN (
    SELECT film_id
    FROM `tc-da-1.sakila_db.film`
    WHERE title = 'ALONE TRIP'
  )
)
ORDER BY last_name;*/

-- 11. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
-- Use tables customer, address, city and country.

/*SELECT
  customer.first_name FirstName,
  customer.last_name LastName,
  customer.email EmailAddress,
  country.country Country
FROM `tc-da-1.sakila_db.customer` customer
JOIN `tc-da-1.sakila_db.address` address
ON customer.address_id = address.address_id
JOIN `tc-da-1.sakila_db.city` city
ON address.city_id = city.city_id
JOIN `tc-da-1.sakila_db.country` country
ON city.country_id = country.country_id
WHERE country.country = 'Canada'
ORDER BY customer.last_name;*/

-- 12. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
-- Use tables film, film_category and category.

/*SELECT
  film.title FilmTitle,
  category.name FilmCategory
FROM `tc-da-1.sakila_db.film` film
JOIN `tc-da-1.sakila_db.film_category` filmcategory
ON film.film_id = filmcategory.film_id
JOIN `tc-da-1.sakila_db.category` category
ON filmcategory.category_id = category.category_id
WHERE category.name = 'Family'
ORDER BY film.title;*/


-- 13. Display the most frequently rented movies in descending order. Use tables film, inventory and rental.

/*SELECT
  film.title FilmTitle,
  COUNT(rental.rental_id) TimesRented
FROM `tc-da-1.sakila_db.film` film
JOIN `tc-da-1.sakila_db.inventory` inventory
ON film.film_id = inventory.film_id
JOIN `tc-da-1.sakila_db.rental` rental
ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY COUNT(rental.rental_id) DESC;*/

-- 14. Write a query to display for each store its store ID, city, and country. Use tables store, address, city and country;

/*SELECT
  store.store_id StoreID,
  city.city City,
  country.country Country
FROM `tc-da-1.sakila_db.store` store
JOIN `tc-da-1.sakila_db.address` address
ON store.address_id = address.address_id
JOIN `tc-da-1.sakila_db.city` city
ON address.city_id = city.city_id
JOIN `tc-da-1.sakila_db.country` country
ON city.country_id = country.country_id;*/