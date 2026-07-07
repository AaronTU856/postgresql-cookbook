/*
Title: REPEATABLE READ
Difficulty: Intermediate

Learning Objectives:
- Start a REPEATABLE READ transaction.
- Understand transaction-level snapshots.
- Use stable reads for reporting-style checks.

Problem Statement:
Finance wants a stable snapshot while checking completed payments and matching
orders.

SQL Solution:
*/

BEGIN ISOLATION LEVEL REPEATABLE READ;

SELECT
    COUNT(*) AS completed_payment_count,
    SUM(amount) AS completed_payment_total
FROM payments
WHERE status = 'completed';

SELECT
    orders.id AS order_id,
    orders.status AS order_status,
    payments.status AS payment_status,
    payments.amount
FROM orders
INNER JOIN payments
    ON payments.order_id = orders.id
WHERE payments.status = 'completed'
ORDER BY orders.id ASC;

COMMIT;

/*
Explanation:
REPEATABLE READ keeps a stable snapshot for the transaction. Re-running the same
SELECT statements in this transaction would see the same committed snapshot.

Expected Output:
The transaction returns completed payment totals and the orders attached to
completed payments.

Business Scenario:
Month-end reporting can use a stable snapshot while calculating related totals.

Performance Notes:
REPEATABLE READ can be useful for consistency, but long-running transactions can
delay database cleanup.

Common Mistakes:
- Holding repeatable-read transactions open for too long.
- Assuming it prevents all write conflicts.
- Forgetting that application retry logic may still be needed.

Challenge Exercise:
Use REPEATABLE READ to list paid or delivered orders with their payments.

Challenge Solution:
*/

BEGIN ISOLATION LEVEL REPEATABLE READ;

SELECT
    orders.id AS order_id,
    orders.status AS order_status,
    payments.amount,
    payments.status AS payment_status
FROM orders
INNER JOIN payments
    ON payments.order_id = orders.id
WHERE orders.status IN ('paid', 'delivered')
ORDER BY orders.id ASC;

COMMIT;

/*
Related Chapters:
- 04_transaction_isolation.sql
- 05_read_committed.sql
- ../03_joins/07_join_multiple_tables.sql
*/
