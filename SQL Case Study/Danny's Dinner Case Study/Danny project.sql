drop database if exists dannys_dinner;
create database dannys_dinner;
use dannys_dinner;

select * from members;

select * from menu;
select * from sales;

#join 3 table
#condition in case

select s.customer_id, sum(price) as total_amount,count(*) as no_of_orders,sum(case when   s.order_date >= mb.join_date then price*20 else price*20 end  ) as bonus,
group_concat(distinct product_name) as Products from sales s
 left join menu m using(product_id) left join members mb on mb.customer_id = s.customer_id group by s.customer_id;


select * from sales s join menu m using(product_id) join members mb on mb.customer_id = s.customer_id ;
#1. What is the total amount each customer spent at the restaurant?	

select customer_id,sum(price) as total_spent from sales s inner join menu m on s.product_id = m.product_id group by customer_id;

#2. How many days has each customer visited the restaurant?						

select customer_id,count(*) as customer_visited from sales group by customer_id;

#3. What was the first item from the menu purchased by each customer?							

select * from menu;
select * from sales;

select customer_id,product_name from(
select *,row_number() over(partition by customer_id) as rw from sales s inner join menu m using(product_id) )as t where rw=1;


#4. What is the most purchased item on the menu and how many times was it purchased by all customers?								
-- join 2 table 
-- how many times
select product_name,count(*) as count_of_product from( 
select * from sales s inner join menu m using(product_id)) as t group by product_name  order by count_of_product desc limit 1;

#5. Which item was the most popular for each customer?	
select * from (
select customer_id,product_name,count(*) as popular,dense_rank() over(partition by customer_id  order by count(*) desc) as drnk from sales s inner join menu m using(product_id)
 group by customer_id,product_name) as t where drnk=1;
 
 
#6. Which item was purchased first by the customer after they became a member?							

-- join 3 table
-- condition
select * from (
select s.customer_id,m.product_name,dense_rank() over(partition by s.customer_id order by count(*)) as drnk from sales s inner join menu m using(product_id) 
inner join members mb on s.customer_id = mb.customer_id where order_date>=join_date group by s.customer_id,m.product_name) as t where drnk =1;

#7. Which item was purchased just before the customer became a member?	
select * from(					
select s.customer_id,m.product_name, dense_rank() over(partition by s.customer_id order by count(*) desc) drnk  from sales s inner join menu m using(product_id)
 inner join members mb on s.customer_id = mb.customer_id where s.order_date< mb.join_date group by s.customer_id,m.product_name) as t where drnk=1;			

#8. What is the total items and amount spent for each member before they became a member?								
-- join 3 table
-- total items
-- sum
-- condition

select s.customer_id,count(*) as Total_item,sum(m.price) as sum from sales s inner join menu m using(product_id)
inner join members mb on s.customer_id = mb.customer_id where order_date<join_date group by s.customer_id;

#9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?								
-- $1 - 10 point
select s.customer_id,count(*) count_of_item, sum(case when product_name="suchi" then price*20 else price*10 end) as total_points from sales s inner join menu m using(product_id)
group by s.customer_id;


# 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi
-- - how many points do customer A and B have at the end of January?*/		

SELECT 
  s.customer_id, 
  SUM(
    CASE 
      WHEN s.order_date BETWEEN mb.join_date AND DATE_ADD(mb.join_date, INTERVAL 6 DAY) THEN m.price * 20
      WHEN m.product_name = 'Sushi' THEN m.price * 20
      ELSE m.price * 10
    END
  ) AS total_point
FROM sales s
JOIN menu m USING (product_id)
JOIN members mb ON s.customer_id = mb.customer_id
WHERE s.order_date <= '2021-01-31'
GROUP BY s.customer_id;
								

 
