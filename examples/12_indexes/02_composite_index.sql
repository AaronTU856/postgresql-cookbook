/*
Title: Composite Index
Difficulty: Intermediate

Learning objectives:
- Create a multi-column index.
- Understand column order.
- Support filtering and sorting together.

Problem statement:
Operations often filters orders by status and sorts them by order date.

Business scenario:
Fulfilment dashboards show recent paid or shipped orders first.

SQL solution:
*/

CREATE INDEX IF NOT EXISTS idx_cookbook_orders_status_date
    ON orders (status, order_date DESC);

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
The first index column matches the equality filter. The second column matches
the desired order for rows with that status.

Expected output:
EXPLAIN returns a plan for filtering paid orders and ordering by newest first.

Performance considerations:
Column order matters. An index on (order_date, status) would support different
query patterns.

Common mistakes:
- Creating composite indexes without considering column order.
- Creating separate indexes when one composite index fits the query better.
- Expecting one composite index to support every filter combination.

Challenge:
Create a composite index for payments by status and paid_at date.

Challenge solution:
*/

CREATE INDEX IF NOT EXISTS idx_cookbook_payments_status_paid_at
    ON payments (status, paid_at DESC);

EXPLAIN
SELECT
    id AS payment_id,
    status,
    paid_at
FROM payments
WHERE status = 'completed'
ORDER BY paid_at DESC;

/*
Related chapters:
- ../02_filtering_sorting/09_order_by_multiple_columns.sql
- ../08_transactions/05_read_committed.sql
- 01_basic_index.sql
*/
