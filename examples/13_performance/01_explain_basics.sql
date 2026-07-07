/*
Title: EXPLAIN Basics
Difficulty: Beginner

Learning Objectives:
- Use EXPLAIN before changing a query.
- Read a basic query plan.
- Connect filters to access paths.

Problem Statement:
Support wants to understand how PostgreSQL plans a paid-order lookup.

Business Scenario:
Paid-order lookups are common in fulfilment dashboards.

SQL Solution:
*/

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
EXPLAIN shows the plan without running the query. On small seed data, sequential
scans are common and acceptable.

Expected Output:
PostgreSQL returns a query plan showing how it expects to find and sort paid
orders.

Performance Notes:
Read plans with data size in mind. Small tables often scan quickly even when an
index exists.

Common Mistakes:
- Treating every sequential scan as bad.
- Adding indexes before understanding the query plan.
- Forgetting that estimates depend on statistics.

Challenge Exercise:
Run EXPLAIN for completed payments ordered by paid_at.

Challenge Solution:
*/

EXPLAIN
SELECT
    id AS payment_id,
    amount,
    paid_at
FROM payments
WHERE status = 'completed'
ORDER BY paid_at DESC;

/*
Related Chapters:
- ../12_indexes/01_basic_index.sql
- ../02_filtering_sorting/05_order_by.sql
- 02_explain_analyze.sql
*/
