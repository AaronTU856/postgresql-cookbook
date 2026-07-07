/*
Title: Basic Index
Difficulty: Beginner

Learning Objectives:
- Create a B-tree index.
- Match an index to a common filter.
- Use EXPLAIN to inspect a query plan.

Problem Statement:
Support frequently looks up orders by status.

Business Scenario:
Dashboards often filter orders by pending, paid, shipped, delivered, or
cancelled status.

SQL Solution:
*/

CREATE INDEX IF NOT EXISTS idx_cookbook_orders_status
    ON orders (status);

EXPLAIN
SELECT
    id AS order_id,
    status,
    order_date
FROM orders
WHERE status = 'paid'
ORDER BY order_date DESC;

/*
Explanation:
The index supports queries that filter by status. On tiny seed data PostgreSQL
may still choose a sequential scan, which is normal.

Expected Output:
EXPLAIN returns a query plan for finding paid orders.

Performance Notes:
Indexes help most when tables are large enough and the filter is selective
enough. Small tables may scan faster than using an index.

Common Mistakes:
- Assuming EXPLAIN must always show an index scan.
- Indexing a column before checking whether the query is frequent.
- Forgetting indexes add write overhead.

Challenge Exercise:
Create an index for payment status lookups.

Challenge Solution:
*/

CREATE INDEX IF NOT EXISTS idx_cookbook_payments_status
    ON payments (status);

EXPLAIN
SELECT
    id AS payment_id,
    amount,
    status
FROM payments
WHERE status = 'completed';

/*
Related Chapters:
- ../02_filtering_sorting/04_comparison_operators.sql
- ../09_views/10_business_reporting_view.sql
- ../13_performance/01_explain_basics.sql
*/
