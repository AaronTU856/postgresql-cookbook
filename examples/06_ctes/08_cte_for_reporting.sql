/*
Title: CTE for Reporting
Difficulty: Intermediate

Learning objectives:
- Build a report from staged CTEs.
- Filter completed payments before aggregating revenue.
- Produce category-level reporting output.

Problem statement:
Leadership wants completed revenue and units sold by category.

SQL solution:
*/

WITH completed_order_items AS (
    SELECT
        order_items.product_id,
        order_items.quantity,
        order_items.unit_price
    FROM order_items
    INNER JOIN orders
        ON orders.id = order_items.order_id
    INNER JOIN payments
        ON payments.order_id = orders.id
    WHERE payments.status = 'completed'
),
category_revenue AS (
    SELECT
        products.category_id,
        SUM(completed_order_items.quantity * completed_order_items.unit_price) AS revenue,
        SUM(completed_order_items.quantity) AS units_sold
    FROM completed_order_items
    INNER JOIN products
        ON products.id = completed_order_items.product_id
    GROUP BY products.category_id
)
SELECT
    categories.name AS category_name,
    category_revenue.revenue,
    category_revenue.units_sold
FROM category_revenue
INNER JOIN categories
    ON categories.id = category_revenue.category_id
ORDER BY category_revenue.revenue DESC;

/*
Explanation:
The first CTE defines completed order items. The second CTE aggregates revenue
by category_id. The final query joins category names for readable reporting.

Expected results:
The query returns completed revenue and units sold by category.

Real-world example:
Business reporting queries often become easier to review when each stage has a
clear name.

Performance notes:
Reporting CTEs can improve readability. For frequent reports over large data,
consider query plans, indexes, and whether a summary table is appropriate.

Common mistakes:
- Including pending or refunded payments in completed revenue.
- Aggregating current product prices instead of order item unit prices.
- Creating too many CTEs with unclear boundaries.

Challenge exercise:
Create a customer payment report with completed payment totals by user.

Challenge solution:
*/

WITH completed_payments AS (
    SELECT
        orders.user_id,
        payments.amount
    FROM payments
    INNER JOIN orders
        ON orders.id = payments.order_id
    WHERE payments.status = 'completed'
),
customer_totals AS (
    SELECT
        user_id,
        SUM(amount) AS completed_payment_total
    FROM completed_payments
    GROUP BY user_id
)
SELECT
    users.email,
    customer_totals.completed_payment_total
FROM customer_totals
INNER JOIN users
    ON users.id = customer_totals.user_id
ORDER BY customer_totals.completed_payment_total DESC;

/*
Related examples:
- ../04_aggregates/10_business_reports.sql
- ../03_joins/12_real_world_reporting.sql
- 04_cte_with_aggregation.sql
*/
