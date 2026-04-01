create database amazon_business_dataset;
use amazon_business_dataset;

CREATE TABLE subscribers (
  customer_id INT,
  subscription_date DATE,
  plan_value INT
);

INSERT INTO subscribers VALUES
(1, '2023-03-02', 799),
(1, '2023-04-01', 599),
(1, '2023-05-01', 499),
(2, '2023-04-02', 799),
(2, '2023-07-01', 599),
(2, '2023-09-01', 499),
(3, '2023-01-01', 499),
(3, '2023-04-01', 599),
(3, '2023-07-02', 799),
(4, '2023-04-01', 499),
(4, '2023-09-01', 599),
(4, '2023-10-02', 499),
(4, '2023-11-02', 799),
(5, '2023-10-02', 799),
(5, '2023-11-02', 799),
(6, '2023-03-01', 499);

select * from subscribers;


# Q1. Write an SQL Query to find the Number of Unique Customers
select count(distinct(customer_id)) as count from subscribers;



#Q2. For Each customer, Calculate the min and max spend.

select * from subscribers;
select customer_id,min(plan_value)as  min_value,max(plan_value) as max_value from subscribers group by customer_id;



# Q3. Write a query to find customers who have 
# (i) Upgraded at least once in their lifetime.
# (ii) Downgraded at least once in their lifetime.

select * from subscribers;
with cte as(
select *,lag(plan_value,1) over(partition by customer_id order by subscription_date) as prev_value from subscribers)

select customer_id, case when max(case when plan_value > prev_value then 1 else 0 end) =1 then "Yes" else "No" end as Upgraded,
case when max(case when plan_value < prev_value then 1 else 0 end) =1 then "Yes" else "No" end as Downgraded from cte group by customer_id



















