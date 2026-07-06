/*
Title: EXPLAIN ANALYZE
Difficulty: Intermediate

Learning objectives:
- Use EXPLAIN ANALYZE on read queries.
- Compare estimated and actual rows.
- Understand that the query is executed.

Problem statement:
Finance wants to measure a completed payment summary query.

Business scenario:
Payment reports are business-critical, so teams need evidence before tuning.

SQL solution:
*/

EXPLAIN (ANALYZE, BUFFERS)
SELECT
    payment_method,
    COUNT(*) AS payment_count,
    SUM(amount) AS payment_total
FROM payments
WHERE status = 'completed'
GROUP BY payment_method
ORDER BY payment_total DESC;

/*
Explanation:
EXPLAIN ANALYZE executes the query and reports actual timing and row counts.
BUFFERS adds information about data page access.

Expected output:
PostgreSQL returns a measured execution plan for the payment summary.

Performance considerations:
EXPLAIN ANALYZE runs the query. Be careful with writes and expensive production
queries.

Common mistakes:
- Running EXPLAIN ANALYZE on write queries without a rollback plan.
- Focusing only on total time and ignoring row estimates.
- Benchmarking only tiny development data.

Challenge:
Measure a category revenue report with EXPLAIN ANALYZE.

Challenge solution:
*/

EXPLAIN (ANALYZE, BUFFERS)
SELECT
    categories.name AS category_name,
    SUM(order_items.quantity * order_items.unit_price) AS gross_revenue
FROM categories
INNER JOIN products
    ON products.category_id = categories.id
INNER JOIN order_items
    ON order_items.product_id = products.id
GROUP BY categories.name
ORDER BY gross_revenue DESC;

/*
Related chapters:
- ../04_aggregates/10_business_reports.sql
- ../12_indexes/chapter_summary.sql
- 01_explain_basics.sql
*/
