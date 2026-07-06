/*
Title: Aggregate View
Difficulty: Intermediate

Learning objectives:
- Create a view with GROUP BY.
- Summarise payment totals by status.
- Understand why aggregate views are read-only by default.

Problem statement:
Finance wants a reusable summary of payment counts and totals by payment status.

SQL solution:
*/

DROP VIEW IF EXISTS payment_status_summary;

CREATE VIEW payment_status_summary AS
SELECT
    status AS payment_status,
    COUNT(*) AS payment_count,
    SUM(amount) AS total_amount,
    AVG(amount) AS average_amount
FROM payments
GROUP BY status;

SELECT
    payment_status,
    payment_count,
    total_amount,
    average_amount
FROM payment_status_summary
ORDER BY payment_status ASC;

/*
Explanation:
The view stores an aggregate query that groups payments by status. Readers can
query the summary without rewriting COUNT, SUM, AVG, or GROUP BY.

Expected results:
The query returns one row per payment status with count, total, and average
amount.

Real-world example:
Finance teams often use aggregate views for payment dashboards and monthly
report checks.

Performance notes:
Aggregate views calculate results when queried. For expensive summaries that can
be slightly stale, consider a materialized view.

Common mistakes:
- Expecting aggregate views to be updatable.
- Forgetting GROUP BY for non-aggregated columns.
- Hiding slow reports behind views without checking execution plans.

Challenge exercise:
Create an aggregate view showing product count and average price by category.

Challenge solution:
*/

DROP VIEW IF EXISTS category_product_summary;

CREATE VIEW category_product_summary AS
SELECT
    categories.name AS category_name,
    COUNT(products.id) AS product_count,
    AVG(products.price) AS average_price
FROM categories
LEFT JOIN products
    ON products.category_id = categories.id
GROUP BY categories.name;

SELECT
    category_name,
    product_count,
    average_price
FROM category_product_summary
ORDER BY category_name ASC;

/*
Related examples:
- 04_join_view.sql
- 07_materialized_views.sql
- ../04_aggregates/05_group_by.sql
*/
