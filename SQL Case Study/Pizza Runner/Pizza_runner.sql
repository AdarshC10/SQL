CREATE database pizza_runner;
use pizza_runner;
SET search_path = pizza_runner;

DROP TABLE IF EXISTS runners;
CREATE TABLE runners (
  runner_id INT,
  registration_date DATE
);

INSERT INTO runners
  (runner_id, registration_date)
VALUES
  (1, '2021-01-01'),
  (2, '2021-01-03'),
  (3, '2021-01-08'),
  (4, '2021-01-15');


DROP TABLE IF EXISTS customer_orders;
CREATE TABLE customer_orders (
  order_id INTEGER,
  customer_id INTEGER,
  pizza_id INTEGER,
  exclusions VARCHAR(4),
  extras VARCHAR(4),
  order_time TIMESTAMP
);

-- Customer Orders
DROP TABLE IF EXISTS customer_orders;
CREATE TABLE customer_orders (
  order_id INT,
  customer_id INT,
  pizza_id INT,
  exclusions VARCHAR(50),
  extras VARCHAR(50),
  order_time DATETIME
);

INSERT INTO customer_orders
  (order_id, customer_id, pizza_id, exclusions, extras, order_time)
VALUES
  (1, 101, 1, '', '', '2020-01-01 18:05:02'),
  (2, 101, 1, '', '', '2020-01-01 19:00:52'),
  (3, 102, 1, '', '', '2020-01-02 23:51:23'),
  (3, 102, 2, '', NULL, '2020-01-02 23:51:23'),
  (4, 103, 1, '4', '', '2020-01-04 13:23:46'),
  (4, 103, 1, '4', '', '2020-01-04 13:23:46'),
  (4, 103, 2, '4', '', '2020-01-04 13:23:46'),
  (5, 104, 1, 'null', '1', '2020-01-08 21:00:29'),
  (6, 101, 2, 'null', 'null', '2020-01-08 21:03:13'),
  (7, 105, 2, 'null', '1', '2020-01-08 21:20:29'),
  (8, 102, 1, 'null', 'null', '2020-01-09 23:54:33'),
  (9, 103, 1, '4', '1, 5', '2020-01-10 11:22:59'),
  (10, 104, 1, 'null', 'null', '2020-01-11 18:34:49'),
  (10, 104, 1, '2, 6', '1, 4', '2020-01-11 18:34:49');


-- Runner Orders
DROP TABLE IF EXISTS runner_orders;
CREATE TABLE runner_orders (
  order_id INT,
  runner_id INT,
  pickup_time VARCHAR(50),
  distance VARCHAR(50),
  duration VARCHAR(50),
  cancellation VARCHAR(50)
);

INSERT INTO runner_orders
  (order_id, runner_id, pickup_time, distance, duration, cancellation)
VALUES
  (1, 1, '2020-01-01 18:15:34', '20km', '32 minutes', ''),
  (2, 1, '2020-01-01 19:10:54', '20km', '27 minutes', ''),
  (3, 1, '2020-01-03 00:12:37', '13.4km', '20 mins', NULL),
  (4, 2, '2020-01-04 13:53:03', '23.4', '40', NULL),
  (5, 3, '2020-01-08 21:10:57', '10', '15', NULL),
  (6, 3, 'null', 'null', 'null', 'Restaurant Cancellation'),
  (7, 2, '2020-01-08 21:30:45', '25km', '25mins', 'null'),
  (8, 2, '2020-01-10 00:15:02', '23.4 km', '15 minute', 'null'),
  (9, 2, 'null', 'null', 'null', 'Customer Cancellation'),
  (10, 1, '2020-01-11 18:50:20', '10km', '10minutes', 'null');


-- Pizza Names
DROP TABLE IF EXISTS pizza_names;
CREATE TABLE pizza_names (
  pizza_id INT,
  pizza_name VARCHAR(50)
);

INSERT INTO pizza_names
  (pizza_id, pizza_name)
VALUES
  (1, 'Meatlovers'),
  (2, 'Vegetarian');


-- Pizza Recipes
DROP TABLE IF EXISTS pizza_recipes;
CREATE TABLE pizza_recipes (
  pizza_id INT,
  toppings VARCHAR(100)
);

INSERT INTO pizza_recipes
  (pizza_id, toppings)
VALUES
  (1, '1, 2, 3, 4, 5, 6, 8, 10'),
  (2, '4, 6, 7, 9, 11, 12');


-- Pizza Toppings
DROP TABLE IF EXISTS pizza_toppings;
CREATE TABLE pizza_toppings (
  topping_id INT,
  topping_name VARCHAR(50)
);

INSERT INTO pizza_toppings
  (topping_id, topping_name)
VALUES
  (1, 'Bacon'),
  (2, 'BBQ Sauce'),
  (3, 'Beef'),
  (4, 'Cheese'),
  (5, 'Chicken'),
  (6, 'Mushrooms'),
  (7, 'Onions'),
  (8, 'Pepperoni'),
  (9, 'Peppers'),
  (10, 'Salami'),
  (11, 'Tomatoes'),
  (12, 'Tomato Sauce');
  
  
select * from runners;
select * from  customer_orders;

#Here i need to Clean customer_orders exclusions
update  customer_orders set exclusions = NULL where exclusions is null or exclusions in ('','null');
#Here i need to Clean customer_orders extras
update customer_orders set extras = NULL where extras is null or extras in ('','null');

select * from runner_orders;
describe runner_orders;

# going to clean the table column cancellation there  null value 
update runner_orders set cancellation = NULL where cancellation is null or cancellation in ('','null');

# going to clean the table column distance there  null value
update runner_orders set distance = NULL where distance = 'null';


# going to clean the table column distance there  null value
update runner_orders set duration = NULL where duration ='null';

ALTER TABLE runner_orders
ADD distance_km DECIMAL(5,2);

#First REPLACE(distance, 'km', '')
#Removes the letters "km" from the string.

#Second REPLACE(..., ' ', '')
#Removes spaces " ".

#CAST(... AS DECIMAL)
#Converts the cleaned string into a number type

update runner_orders set distance = cast(replace(replace(distance,'km',''),' ','') as DECIMAL) where distance is not null;
alter table runner_orders drop column distance_km;

UPDATE runner_orders
SET duration = CAST(REGEXP_REPLACE(duration, '[^0-9]', '') AS UNSIGNED)
WHERE duration IS NOT NULL;

select * from runner_orders;
# pickup_time column null valuto NULL proper way
update runner_orders set pickup_time =NULL where pickup_time = 'null';


select * from pizza_names;
select * from pizza_recipes;
select * from pizza_toppings;

# A. Pizza Metrics

# How many pizzas were ordered?
select * from  customer_orders;
select count(*) as cust_orders from customer_orders;

# How many unique customer orders were made?
select count(distinct order_id) as unique_cust_id from customer_orders;

# How many successful orders were delivered by each runner?
select count(distinct order_id) as successfull_order from runner_orders
 where cancellation is null group by runner_id;
select * from runner_orders;

# How many of each type of pizza was delivered?
select  p.pizza_name, count(*) as count from customer_orders c join  runner_orders r on c.order_id = r.order_id 
join pizza_names p on c.pizza_id = p.pizza_id where cancellation is null group by p.pizza_name;

# How many Vegetarian and Meatlovers were ordered by each customer?
select pizza_name,count(*) as count from pizza_names p join customer_orders c on  p.pizza_id = c.pizza_id group by pizza_name;

# What was the maximum number of pizzas delivered in a single order?


select c.order_id, count(*) as deliverd from customer_orders c join runner_orders r on c.order_id =  r.order_id
 group by c.order_id order by deliverd desc limit 1;



# For each customer, how many delivered pizzas had at least 1 change and how many had no changes?


# How many pizzas were delivered that had both exclusions and extras?
select count(*) as pizza_with_both from customer_orders c  join runner_orders r on c.order_id = r.order_id
where c.exclusions is not null and c.extras is not null and cancellation is not null;



# What was the total volume of pizzas ordered for each hour of the day?
select hour(order_time) as order_hour,count(*) as toatal_pizzas from customer_orders group by hour(order_time) order by order_hour;
# What was the volume of orders for each day of the week?
select dayname(order_time) as order_week,count(*) as total_pizza from customer_orders group by dayname(order_time) 
 order by order_week desc;
 
			#B. Runner and Customer Experience
            
#  How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
select *,floor(datediff(registration_date," 2021-01-01")/7) from runners;

# What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
select runner_id, round(avg(timestampdiff(minute,co.order_time,ro.pickup_time)),2) as time_took_runner from runner_orders ro join customer_orders co using(order_id)  group by runner_id;

# Is there any relationship between the number of pizzas and how long the order takes to prepare?
#(Count pizzas per order vs. time from order to pickup)
select order_id,ro.pickup_time,count(*) pizza_orders, timestampdiff(minute,min(co.order_time),ro.pickup_time) as time_to_prepare  from customer_orders co join runner_orders ro using(order_id)
where  ro.pickup_time is not null  group by order_id,ro.pickup_time;



select * from  runner_orders;
select * from  customer_orders;
# What was the average distance travelled for each customer?
select customer_id,round(avg(distance),2) avg_distance from runner_orders ro join customer_orders co using(order_id) group by customer_id ;
# What was the difference between the longest and shortest delivery times for all orders?
select max(duration) as max_duration, min(duration) as min_duration from runner_orders;
# What was the average speed for each runner for each delivery and do you notice any trend for these values?
select order_id,round((distance/(duration/60)),2) as avg_speed from runner_orders where distance is not null and duration is not null;

# What is the successful delivery percentage for each runner?

# C. Ingredient Optimisation
#Count how many times each topping was used
# join 2 columns pizza_recipes and pizaa_toppings
#count the 
select * from  pizza_recipes;
 select * from pizza_toppings;

select pt.topping_name, count(*) as pizza_recipes from pizza_recipes pr 
join pizza_toppings pt on find_in_set(pt.topping_id,pr.toppings) group by pt.topping_name;

#Which ingredients are most commonly excluded or added?


select pt.topping_name,count(*) as exclusion_count from customer_orders co join pizza_toppings pt
 on find_in_set(pt.topping_id,co.exclusions) group by pt.topping_name;

 					#C. Ingredient Optimisation
# What are the standard ingredients for each pizza?
select pizza_id, extras as std_count from customer_orders where extras is not null;

# What was the most commonly added extra?
select  pt.topping_name,count(*) as common_used from customer_orders co join  pizza_toppings pt on find_in_set(co.extras,pt.topping_id) where extras is not null  group by pt.topping_name;
# What was the most common exclusion?
# Generate an order item for each record in the customers_orders table in the format of one of the following:
# Meat Lovers

select * from customer_orders co join  pizza_names pn using(pizza_id)where pizza_name = 'Meatlovers' and exclusions is not null and extras is not null ;
# Meat Lovers - Exclude Beef
select * from customer_orders co join pizza_names pn using(pizza_id)
where pizza_name = 'Meatlovers' and extras <> 3;
# Meat Lovers - Extra Bacon
select * from customer_orders co join pizza_names pn using(pizza_id) where pizza_name ='Meatlovers' and  extras = 1  ;
# Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers
select * from customer_orders co join pizza_names pn using(pizza_id) where pizza_name ='Meatlovers' and  extras in (1,4) and extras not in (6,9);



# Generate an alphabetically ordered comma separated ingredient list for each pizza order
# from the customer_orders table and add a 2x in front of any relevant ingredients
# For example: "Meat Lovers: 2xBacon, Beef, ... , Salami"



# What is the total quantity of each ingredient used in
# all delivered pizzas sorted by most frequent first?

select pt.topping_name, count(*) as total_quntity from customer_orders co join runner_orders ro on co.order_id = ro.order_id
join pizza_recipes pr on co.pizza_id = pr.pizza_id  
join pizza_toppings pt on find_in_set(pt.topping_id,pr.toppings) group by pt.topping_name;



# If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were
# no charges for changes - how much money has Pizza Runner made so far 
#if there are no delivery fees?
select sum(case when pizza_name ='Meatlovers' then 12 else 10 end) as price from pizza_names pn
 join customer_orders co on pn.pizza_id = co.pizza_id 
 join runner_orders rn on co.order_id = rn.order_id where  cancellation IS NULL;

# What if there was an additional $1 charge for any pizza extras?
# Add cheese is $1 extra
select  sum(case when pizza_name = 'Meatlovers' then 12 else 10 end) price from pizza_names pn join  customer_orders co on pn.pizza_id = co.pizza_id
join runner_orders ro on co.order_id = ro.order_id where cancellation IS NULL ;
# The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, how would you design an additional table for this new dataset 
#- generate a schema for this new table and insert your own data for ratings 
#for each successful customer order between 1 to 5.

create table runner_ratings (
rating_id int auto_increment primary key,
order_id int,
runner_id int,
rating int check (rating between 1 and 5),
rating_date datetime default current_timestamp,
comments varchar(200)

);
drop table runner_ratings;

insert into runner_ratings (order_id, runner_id, rating, comments) values
(1, 1, 5, 'Very fast and friendly'),
(2, 1, 4, 'Good delivery but a little late'),
(3, 2, 5, 'Perfect timing!'),
(4, 3, 3, 'Average experience'),
(5, 2, 4, 'Quick but forgot to call on arrival'),
(6, 3, 2, 'Late delivery, pizza was cold'),
(7, 1, 5, 'Excellent service!'),
(8, 2, 4, 'Good speed, polite runner'),
(9, 3, 5, 'Best delivery so far!'),
(10, 1, 5, 'Super quick and professional');

create table dummy2 as(
select order_id, rating from runner_ratings);

# Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries?
# customer_id
# order_id
# runner_id
# rating
# order_time
# pickup_time
# Time between order and pickup
# Delivery duration
# Average speed
# Total number of pizzas
select customer_id,order_id,runner_id,rating,order_time,pickup_time, timediff(pickup_time,order_time) as time_between_order_pickup,duration,avg_speed,count(*) as Total_no_of_pizza 
from customer_orders join runner_orders using(order_id) join dummy d  using(order_id) join dummy2 using(order_id)
 group by order_id,runner_id,customer_id,order_time,pickup_time,duration,avg_speed,rating;
 
create table dummy as(
select order_id,round((distance/(duration/60)),2) as avg_speed from runner_orders where distance is not null and duration is not null) ;

# If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid $0.30 per kilometre traveled -
# how much money does Pizza Runner have left over after these deliveries?


