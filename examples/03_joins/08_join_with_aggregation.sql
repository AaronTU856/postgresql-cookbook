/*
Title: Join With Aggregation
Difficulty: Intermediate

Learning Objectives:
- Aggregate values after joining tables.
- Calculate customer order counts and payment totals.
- Group by selected customer columns.

Problem Statement:
The business team wants a customer summary showing order count and total payment
amount.

Business Scenario:
Customer value reports often combine customer records, orders, and payments to
understand activity and revenue.

SQL Solution:
*/

SELECT
    users.id AS user_id,
    users.email,
    COUNT(orders.id) AS order_count,
    SUM(payments.amount) AS total_payment_amount
FROM users
INNER JOIN orders
    ON orders.user_id = users.id
INNER JOIN payments
    ON payments.order_id = orders.id
GROUP BY
    users.id,
    users.email
ORDER BY total_payment_amount DESC;

/*
Explanation:
The joins connect users to orders and payments. GROUP BY returns one row per
customer, while COUNT and SUM calculate summary values for each customer.

Expected Output:
The query returns six customers. Amelia Clark has two orders; other customers
have one order each.

Performance Notes:
Aggregation after joins can be expensive on large datasets. Index join columns
and check whether the report should filter rows before grouping.

Common Mistakes:
- Forgetting GROUP BY for non-aggregated selected columns.
- Summing after joining extra one-to-many tables and accidentally multiplying
  totals.
- Treating refunded payments as completed revenue without a business rule.

Challenge Exercise:
Calculate total quantity sold per product.

Challenge Solution:
*/

SELECT
    products.id AS product_id,
    products.name AS product_name,
    SUM(order_items.quantity) AS total_quantity_sold
FROM products
INNER JOIN order_items
    ON order_items.product_id = products.id
GROUP BY
    products.id,
    products.name
ORDER BY total_quantity_sold DESC, product_name ASC;

/*
Related Chapters:
- ../01_basic_queries/README.md
- ../02_filtering_sorting/README.md
- README.md
*/
