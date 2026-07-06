/*
Title: EXPLAIN Basics
Difficulty: Beginner

Learning objectives:
- Use EXPLAIN before changing a query.
- Read a basic query plan.
- Connect filters to access paths.

Problem statement:
Support wants to understand how PostgreSQL plans a paid-order lookup.

Business scenario:
Paid-order lookups are common in fulfilment dashboards.

SQL solution:
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

Expected output:
PostgreSQL returns a query plan showing how it expects to find and sort paid
orders.

Performance considerations:
Read plans with data size in mind. Small tables often scan quickly even when an
index exists.

Common mistakes:
- Treating every sequential scan as bad.
- Adding indexes before understanding the query plan.
- Forgetting that estimates depend on statistics.

Challenge:
Run EXPLAIN for completed payments ordered by paid_at.

Challenge solution:
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
Related chapters:
- ../12_indexes/01_basic_index.sql
- ../02_filtering_sorting/05_order_by.sql
- 02_explain_analyze.sql
*/
