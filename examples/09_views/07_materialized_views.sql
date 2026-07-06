/*
Title: Materialized Views
Difficulty: Intermediate

Learning objectives:
- Create a materialized view.
- Understand stored query results.
- Use materialized views for reusable summaries.

Problem statement:
Leadership wants a stored snapshot of category revenue for faster report reads.

SQL solution:
*/

DROP MATERIALIZED VIEW IF EXISTS category_revenue_snapshot;

CREATE MATERIALIZED VIEW category_revenue_snapshot AS
SELECT
    categories.name AS category_name,
    SUM(order_items.quantity * order_items.unit_price) AS gross_revenue
FROM categories
INNER JOIN products
    ON products.category_id = categories.id
INNER JOIN order_items
    ON order_items.product_id = products.id
GROUP BY categories.name;

SELECT
    category_name,
    gross_revenue
FROM category_revenue_snapshot
ORDER BY gross_revenue DESC;

/*
Explanation:
A materialized view stores the result of the query at creation time. It is useful
when the report is expensive enough that reading a stored snapshot is helpful.

Expected results:
The materialized view returns category revenue based on seeded order items.

Real-world example:
Executive dashboards often read from refreshed materialized views instead of
running expensive reports on every page load.

Performance notes:
Materialized views can speed up reads, but source data changes are not visible
until the materialized view is refreshed.

Common mistakes:
- Assuming materialized views update automatically.
- Forgetting to plan refresh timing.
- Using a materialized view where fresh data is required.

Challenge exercise:
Create a materialized view that stores completed payment totals by payment
method.

Challenge solution:
*/

DROP MATERIALIZED VIEW IF EXISTS payment_method_snapshot;

CREATE MATERIALIZED VIEW payment_method_snapshot AS
SELECT
    payment_method,
    COUNT(*) AS completed_payment_count,
    SUM(amount) AS completed_payment_total
FROM payments
WHERE status = 'completed'
GROUP BY payment_method;

SELECT
    payment_method,
    completed_payment_count,
    completed_payment_total
FROM payment_method_snapshot
ORDER BY payment_method ASC;

/*
Related examples:
- 05_aggregate_view.sql
- 08_refresh_materialized_view.sql
- ../04_aggregates/10_business_reports.sql
*/
