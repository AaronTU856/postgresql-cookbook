/*
Title: Project - Online Store Analytics Dashboard
Difficulty: Advanced

Learning Objectives:
- Combine joins, aggregates, and CTEs for a dashboard query.
- Separate paid revenue from cancelled or pending orders.
- Produce business metrics that are easy to review.

Problem Statement:
Build a compact analytics report for revenue, orders, customers, and average order value.

Business Scenario:
A product manager wants a weekly snapshot of completed payment activity for the online store.

SQL Solution:
*/

WITH completed_orders AS (
    SELECT
        o.id AS order_id,
        o.user_id,
        o.order_date,
        p.amount
    FROM orders AS o
    INNER JOIN payments AS p
        ON p.order_id = o.id
    WHERE p.status = 'completed'
),
dashboard_metrics AS (
    SELECT
        COUNT(*) AS completed_order_count,
        COUNT(DISTINCT user_id) AS paying_customer_count,
        SUM(amount) AS total_revenue,
        AVG(amount) AS average_order_value,
        MIN(order_date) AS first_completed_order_at,
        MAX(order_date) AS latest_completed_order_at
    FROM completed_orders
)
SELECT
    completed_order_count,
    paying_customer_count,
    total_revenue,
    ROUND(average_order_value, 2) AS average_order_value,
    first_completed_order_at,
    latest_completed_order_at
FROM dashboard_metrics;

/*
Explanation:
The report starts with completed payments so refunded, pending, and failed payments do not inflate revenue. The final select exposes a clean dashboard-ready result.

Expected Output:
One row with completed order count, paying customer count, total completed revenue, average order value, and date range.

Performance Notes:
Production dashboards should index payment status and order date filters, then verify the final query with `EXPLAIN (ANALYZE, BUFFERS)`.

Common Mistakes:
- Counting all orders as revenue.
- Ignoring refunded or pending payments.
- Mixing customer count and order count.

Challenge Exercise:
Add revenue grouped by `payment_method`.

Challenge Solution:
Group `completed_orders` by `p.payment_method` after including it in the first CTE.

Related Chapters:
- Chapter 3 - Joins
- Chapter 4 - Aggregation
- Chapter 6 - Common Table Expressions
*/
