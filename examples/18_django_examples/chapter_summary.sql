/*
Title: Django Integration Chapter Summary
Difficulty: Intermediate

Learning Objectives:
- Review SQL behind common Django ORM patterns.
- Connect QuerySets to joins, aggregates, transactions, and indexes.
- Build production-minded Django/PostgreSQL habits.

Problem Statement:
Summarise the Django integration chapter with a customer order report query.

Business Scenario:
A Django API endpoint needs customer details, order counts, and completed payment
totals without N+1 queries.

SQL Solution:
*/

SELECT
    users.id AS user_id,
    users.email,
    COUNT(DISTINCT orders.id) AS order_count,
    COALESCE(
        SUM(payments.amount) FILTER (WHERE payments.status = 'completed'),
        0
    ) AS completed_payment_total
FROM users
LEFT JOIN orders
    ON orders.user_id = users.id
LEFT JOIN payments
    ON payments.order_id = orders.id
GROUP BY
    users.id,
    users.email
ORDER BY completed_payment_total DESC, users.email ASC;

/*
Explanation:
The summary query shows the SQL shape behind a Django list endpoint using joins
and annotations instead of row-by-row lookups.

Expected Output:
Each customer appears with order count and completed payment total.

Performance Notes:
Use Django debug tooling to inspect SQL and query counts, then use PostgreSQL
EXPLAIN for important queries.

Common Mistakes:
- Assuming ORM code is efficient because it is concise.
- Ignoring generated SQL in code review.
- Missing indexes for frequent API filters.

Challenge Exercise:
Write the SQL shape for a Django product catalogue filtered by active products.

Challenge Solution:
*/

SELECT
    id AS product_id,
    name,
    price
FROM products
WHERE is_active = TRUE
ORDER BY name ASC;

/*
Related Chapters:
- ../03_joins/07_join_multiple_tables.sql
- 06_indexes_for_django_filters.sql
- ../13_performance/04_avoid_n_plus_one.sql
*/
