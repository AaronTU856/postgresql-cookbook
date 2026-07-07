/*
Title: Project - Performance Review Before Launch
Difficulty: Advanced

Learning Objectives:
- Review a production-style reporting query.
- Create indexes that match common access patterns.
- Use `EXPLAIN` as part of a release review.

Problem Statement:
Before launching an admin dashboard, inspect the query shape and supporting indexes.

Business Scenario:
The support team filters orders by status and date. The backend team wants a safe review query before shipping the dashboard.

SQL Solution:
*/

CREATE INDEX IF NOT EXISTS idx_orders_status_order_date
    ON orders (status, order_date DESC);

EXPLAIN
SELECT
    o.id AS order_id,
    o.status,
    o.order_date,
    u.email,
    p.status AS payment_status,
    p.amount
FROM orders AS o
INNER JOIN users AS u
    ON u.id = o.user_id
LEFT JOIN payments AS p
    ON p.order_id = o.id
WHERE o.status IN ('paid', 'shipped', 'delivered')
ORDER BY o.order_date DESC
LIMIT 20;

/*
Explanation:
The index matches the dashboard filter and sort pattern. `EXPLAIN` shows the planned execution without running the query, which is a useful first review step.

Expected Output:
A PostgreSQL query plan describing how the dashboard query will be executed.

Performance Notes:
On real data, use `EXPLAIN (ANALYZE, BUFFERS)` in a safe environment to compare estimates with actual runtime and buffer reads.

Common Mistakes:
- Adding indexes before identifying real filters and sort orders.
- Reviewing performance only on tiny development data.
- Ignoring the `ORDER BY` when designing dashboard indexes.

Challenge Exercise:
Change the query to inspect only pending orders and decide whether the same index still helps.

Challenge Solution:
Change the `WHERE` clause to `o.status = 'pending'` and compare the plan on realistic data.

Related Chapters:
- Chapter 12 - Indexes
- Chapter 13 - Performance
- Chapter 16 - PostgreSQL Administration
*/
