# 🍜 Case Study #1: Danny's Dinner

Danny wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much money they’ve spent and also which menu items are their favourite.

📚 **Table of Contents**
- [Business Task](#business-task)
- [Entity Relationship Diagram](#entity-relationship-diagram)
- [Question and Solution](#question-and-solution)

---

## Business Task  
Danny wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much money they’ve spent and also which menu items are their favourite.

Please note that all the information regarding the case study has been sourced from the following link: [8 Week SQL Challenge](https://8weeksqlchallenge.com/case-study-1/).

---

## Entity Relationship Diagram  
![ERD](https://user-images.githubusercontent.com/81607668/127271130-dca9aedd-4ca9-4ed8-b6ec-1e1920dca4a8.png)

---

## Question and Solution

### 1. What is the total amount each customer spent at the restaurant?

```sql
SELECT 
    customer_id, SUM(price) AS total_amount
FROM sales s
JOIN menu m USING (product_id)
GROUP BY customer_id;
```
Answer:

| customer_id | total_sales |
|-------------|-------------|
| A           | 76          |
| B           | 74          |
| C           | 36          |

- Customer A spent **$76**  
- Customer B spent **$74**  
- Customer C spent **$36**

### 2. How many days has each customer visited the restaurant?

  ```sql
  SELECT 
    customer_id, COUNT(DISTINCT order_date) AS No_of_Visited
FROM sales s
JOIN menu m USING (product_id)
GROUP BY customer_id;
```
**Answer:**

| customer_id | visit_count |
|-------------|-------------|
| A           | 4           |
| B           | 6           |
| C           | 2           |

- Customer A visited **4 times**  
- Customer B visited **6 times**  
- Customer C visited **2 times**

### 3. What was the first item from the menu purchased by each customer?

```sql
select customer_id,product_name from (
select *,rank() over(partition by customer_id order by order_date asc) as rn
from sales s inner join menu m using(product_id)) as t
where rn = 1 group by customer_id,product_name;
```
**Answer:**

| customer_id | product_name |
|-------------|--------------|
| A           | curry        |
| A           | sushi        |
| B           | curry        |
| C           | ramen        |


### 4. What is the most purchased item on the menu and how many times was it purchased?

```sql
  SELECT product_name, COUNT(*) AS most_purchased
FROM sales s
JOIN menu m USING (product_id)
GROUP BY product_name
ORDER BY most_purchased DESC
LIMIT 1;
```
**Answer:**

| most_purchased | product_name |
|----------------|--------------|
| 8              | ramen        |

### 5. Which item was the most popular for each customer?

```sql
select customer_id,product_name,No_of_Purchased from (
select customer_id,product_name,count(*) as No_of_Purchased,
dense_rank() over(partition by customer_id order by count(*) desc) as drnk
 from sales s inner join menu m 
using(product_id) group by customer_id,product_name) as t where drnk = 1;
```
**Answer:**

| customer_id | product_name | order_count |
|-------------|--------------|-------------|
| A           | ramen        | 3           |
| B           | sushi        | 2           |
| B           | curry        | 2           |
| B           | ramen        | 2           |
| C           | ramen        | 3           |

### 6. Which item was purchased first by the customer after they became a member?

```sql
select customer_id,product_name from (
select *,dense_rank() over(partition by customer_id order by order_date asc) as drnk
from sales as s inner join menu as m using(product_id)
inner join members mb using(customer_id) where s.order_date>mb.join_date)
as t where drnk = 1;
```
**Answer:**

| customer_id | product_name |
|-------------|--------------|
| A           | ramen        |
| B           | sushi        |

### 7. Which item was purchased just before the customer became a member?

```sql
select customer_id,product_name from (
select *,row_number() over(partition by customer_id order by order_date desc) as rn
 from sales s inner join menu m using(product_id)
inner join members mb using(customer_id) where s.order_date<mb.join_date) as t
where rn = 1;
```

**Answer:**

| customer_id | product_name |
|-------------|--------------|
| A           | Curry        |
| B           | sushi        |


### 8. What is the total items and amount spent for each member before they became a member?

```sql
SELECT 
    customer_id,
    COUNT(*) AS Total_Items,
    SUM(price) AS Total_Amount_Spent
FROM
    sales s
        INNER JOIN
    menu m USING (product_id)
        INNER JOIN
    members mb USING (customer_id)
WHERE
    order_date < join_date
GROUP BY customer_id;
```
**Answer:**

| customer_id | total_items | total_sales |
|-------------|-------------|-------------|
| A           | 2           | 25          |
| B           | 3           | 40          |

### 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier — how many points would each customer have?

```sql
SELECT 
    customer_id,
    SUM(CASE
        WHEN product_name = 'Sushi' THEN price * 20
        ELSE Price * 10
    END) AS Total_Points
FROM
    sales s
        INNER JOIN
    menu m USING (product_id)
GROUP BY customer_id;
```
**Answer:**

| customer_id | total_points |
|-------------|--------------|
| A           | 860          |
| B           | 940          |
| C           | 360          |

### 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi — how many points do customer A and B have at the end of January?

```sql
SELECT 
    customer_id,
    SUM(CASE
        WHEN join_date BETWEEN join_date AND DATE_ADD(join_date, INTERVAL 7 DAY) THEN price * 20
        WHEN product_name = 'sushi' THEN price * 20
        ELSE price * 10
    END) AS total_points
FROM
    sales s
        INNER JOIN
    menu m USING (product_id)
        INNER JOIN
    members mb USING (customer_id)
WHERE
    MONTH(order_date) = '01'
GROUP BY customer_id;
```
**Answer:**

| customer_id | total_points |
|-------------|--------------|
| A           | 1520         |
| B           | 1240         |


