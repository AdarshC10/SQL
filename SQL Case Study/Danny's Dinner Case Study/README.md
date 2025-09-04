# 🍜 Case Study #1: Danny's Dinner

Danny wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much money they’ve spent and also which menu items are their favourite.

📚 **Table of Contents**
- [Business Task](#business-task)
- [Entity Relationship Diagram](#entity-relationship-diagram)
- [Question and Solution](#question-and-solution)

---

## Business Task  
Please note that all the information regarding the case study has been sourced from the following link: [8 Week SQL Challenge](https://8weeksqlchallenge.com/case-study-1/).

---

## Entity Relationship Diagram  
![ERD](https://user-images.githubusercontent.com/81607668/127727503-9d9e7a25-93cb-4f95-8bd0-20b87cb4b459.png)

---

## Question and Solution

### 1. What is the total amount each customer spent at the restaurant?

```sql
SELECT 
    customer_id, SUM(price) AS total_amount
FROM sales s
JOIN menu m USING (product_id)
GROUP BY customer_id;
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

Answer:
customer_id	product_name
A	curry
A	sushi
B	curry
C	ramen

### 4. What is the most purchased item on the menu and how many times was it purchased?

```sql
  SELECT product_name, COUNT(*) AS most_purchased
FROM sales s
JOIN menu m USING (product_id)
GROUP BY product_name
ORDER BY most_purchased DESC
LIMIT 1;
