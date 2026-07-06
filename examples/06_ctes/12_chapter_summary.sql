/*
Title: CTE Chapter Summary
Difficulty: Intermediate

Learning objectives:
- Combine multiple CTE patterns in one report.
- Build a readable customer summary.
- Review filtering, joining, and aggregation with CTEs.

Problem statement:
Customer success wants a summary of each customer's orders and completed payment
value.

SQL solution:
*/

WITH customer_orders AS (
    SELECT
        users.id AS user_id,
        users.email,
        orders.id AS order_id
    FROM users
    LEFT JOIN orders
        ON orders.user_id = users.id
),
completed_payments AS (
    SELECT
        orders.user_id,
        SUM(payments.amount) AS completed_payment_total
    FROM orders
    INNER JOIN payments
        ON payments.order_id = orders.id
    WHERE payments.status = 'completed'
    GROUP BY orders.user_id
),
customer_summary AS (
    SELECT
        customer_orders.user_id,
        customer_orders.email,
        COUNT(customer_orders.order_id) AS order_count,
        COALESCE(completed_payments.completed_payment_total, 0) AS completed_payment_total
    FROM customer_orders
    LEFT JOIN completed_payments
        ON completed_payments.user_id = customer_orders.user_id
    GROUP BY
        customer_orders.user_id,
        customer_orders.email,
        completed_payments.completed_payment_total
)
SELECT
    email,
    order_count,
    completed_payment_total
FROM customer_summary
ORDER BY completed_payment_total DESC, email ASC;

/*
Explanation:
The query uses three CTEs. The first creates customer-order rows, the second
summarises completed payments by user, and the third creates the final customer
summary.

Expected results:
The query returns one row per customer with order count and completed payment
total.

Real-world example:
Customer success dashboards often combine account, order, and payment metrics in
one readable report.

Performance notes:
Pre-aggregating completed payments by user avoids multiplying payment totals
when a customer has multiple orders.

Common mistakes:
- Assuming readable CTEs automatically prevent row multiplication.
- Forgetting COALESCE for customers with no completed payments.
- Grouping at the wrong level of detail.

Challenge exercise:
Build a product summary using CTEs for product order quantities.

Challenge solution:
*/

WITH product_order_totals AS (
    SELECT
        product_id,
        SUM(quantity) AS total_quantity_sold
    FROM order_items
    GROUP BY product_id
)
SELECT
    products.name,
    COALESCE(product_order_totals.total_quantity_sold, 0) AS total_quantity_sold
FROM products
LEFT JOIN product_order_totals
    ON product_order_totals.product_id = products.id
ORDER BY total_quantity_sold DESC, products.name ASC;

/*
Related examples:
- 02_multiple_ctes.sql
- 08_cte_for_reporting.sql
- ../05_subqueries/12_chapter_summary.sql
*/
