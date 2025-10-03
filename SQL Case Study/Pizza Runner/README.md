# 🍕 Case Study #1: Pizza Runner

📚 **Table of Contents**

* [Business Task](#business-task)
* [Entity Relationship Diagram](#entity-relationship-diagram)
* [Questions and Solutions](#questions-and-solutions)

---

## Business Task

Danny started Pizza Runner — a pizza delivery company. The goal is to analyze customer orders, runner performance, ingredient optimization, and overall business metrics.

---

## Entity Relationship Diagram

*(ERD image from 8 Week SQL Challenge)*

---

## Questions and Solutions

### A. Pizza Metrics

#### 1. How many pizzas were ordered?

```sql
SELECT COUNT(*) AS cust_orders
FROM customer_orders;
```

**Answer:**

| cust_orders |
| ----------- |
| 14          |

**Explanation:** 14 pizzas were ordered in total, including multiple pizzas per order.

---

#### 2. How many unique customer orders were made?

```sql
SELECT COUNT(DISTINCT order_id) AS unique_cust_id
FROM customer_orders;
```

**Answer:**

| unique_cust_id |
| -------------- |
| 10             |

---

#### 3. How many successful orders were delivered by each runner?

```sql
SELECT runner_id,
       COUNT(DISTINCT order_id) AS successful_orders
FROM runner_orders
WHERE cancellation IS NULL
GROUP BY runner_id;
```

**Answer:**

| runner_id | successful_orders |
| --------- | ----------------- |
| 1         | 4                 |
| 2         | 3                 |
| 3         | 1                 |

**Explanation:** Orders without cancellations are counted. Runner 1 delivered the most successful orders.

---

#### 4. How many of each type of pizza was delivered?

```sql
SELECT pizza_id,
       COUNT(pizza_id) AS delivered_count
FROM customer_orders
WHERE order_id IN (
  SELECT order_id FROM runner_orders WHERE cancellation IS NULL
)
GROUP BY pizza_id;
```

**Answer:**

| pizza_id | delivered_count |
| -------- | --------------- |
| 1        | 9               |
| 2        | 3               |

**Explanation:** Only successful orders are included — 9 Meatlovers and 3 Vegetarian pizzas were delivered.

---

#### 5. How many Vegetarian and Meatlovers pizzas were ordered by each customer?

```sql
SELECT customer_id,
       pizza_id,
       COUNT(pizza_id) AS pizzas_ordered
FROM customer_orders
GROUP BY customer_id, pizza_id
ORDER BY customer_id;
```

**Answer:**

| customer_id | pizza_id | pizzas_ordered |
| ----------- | -------- | -------------- |
| 101         | 1        | 2              |
| 101         | 2        | 1              |
| 102         | 1        | 2              |
| 102         | 2        | 1              |
| 103         | 1        | 3              |
| 103         | 2        | 1              |
| 104         | 2        | 1              |
| 105         | 1        | 1              |

**Explanation:** This shows individual customer preferences.

---

#### 6. What was the maximum number of pizzas delivered in a single order?

```sql
SELECT order_id, COUNT(pizza_id) AS pizza_count
FROM customer_orders
WHERE order_id IN (
  SELECT order_id FROM runner_orders WHERE cancellation IS NULL
)
GROUP BY order_id
ORDER BY pizza_count DESC
LIMIT 1;
```

**Answer:**

| order_id | pizza_count |
| -------- | ----------- |
| 4        | 3           |

**Explanation:** The largest order contained 3 pizzas.

---

#### 7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

```sql
SELECT customer_id,
       SUM(CASE WHEN exclusions IS NOT NULL OR extras IS NOT NULL THEN 1 ELSE 0 END) AS with_change,
       SUM(CASE WHEN exclusions IS NULL AND extras IS NULL THEN 1 ELSE 0 END) AS no_change
FROM cus
```

