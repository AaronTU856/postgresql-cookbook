/*
Title: Build Business Reports With Aggregates
Difficulty: Intermediate

Learning objectives:
- Build a practical revenue report.
- Combine joins, filters, and grouped aggregates.
- Use order item prices for historical revenue.

Problem statement:
Leadership wants completed revenue, units sold, and order count by category.

SQL solution:
*/

SELECT
    categories.name AS category_name,
    SUM(order_items.quantity * order_items.unit_price) AS completed_revenue,
    SUM(order_items.quantity) AS units_sold,
    COUNT(DISTINCT orders.id) AS order_count
FROM categories
INNER JOIN products
    ON products.category_id = categories.id
INNER JOIN order_items
    ON order_items.product_id = products.id
INNER JOIN orders
    ON orders.id = order_items.order_id
INNER JOIN payments
    ON payments.order_id = orders.id
WHERE payments.status = 'completed'
GROUP BY categories.name
ORDER BY completed_revenue DESC;

/*
Explanation:
The query joins categories through products and order items to orders and
payments. It filters to completed payments, then groups revenue by category.

Expected results:
The query returns category-level completed revenue, units sold, and order count.

Real-world example:
This is the shape of a small revenue report for an ecommerce dashboard.

Performance notes:
Reports with multiple joins and aggregations should be tested with realistic
data volumes. Frequent reports may later use summary tables or materialized
views.

Common mistakes:
- Using current products.price instead of historical order_items.unit_price.
- Counting orders without DISTINCT after joining order items.
- Including pending or refunded payments in completed revenue.

Challenge exercise:
Build a completed payment report by payment method.

Challenge solution:
*/

SELECT
    payment_method,
    COUNT(*) AS completed_payment_count,
    SUM(amount) AS completed_payment_total
FROM payments
WHERE status = 'completed'
GROUP BY payment_method
ORDER BY completed_payment_total DESC;

/*
Related examples:
- ../03_joins/12_real_world_reporting.sql
- 09_aggregate_with_join.sql
- 11_common_aggregate_mistakes.sql
*/
