/*
Title: READ COMMITTED
Difficulty: Intermediate

Learning Objectives:
- Use PostgreSQL's default isolation level.
- Understand statement-level snapshots.
- Read current committed data inside a transaction.

Problem Statement:
Support wants the latest committed order statuses while reviewing active orders.

SQL Solution:
*/

BEGIN ISOLATION LEVEL READ COMMITTED;

SELECT
    id AS order_id,
    status,
    order_date
FROM orders
WHERE status IN ('pending', 'paid', 'shipped')
ORDER BY order_date ASC;

COMMIT;

/*
Explanation:
READ COMMITTED is PostgreSQL's default isolation level. Each statement sees data
that was committed before that statement began.

Expected Output:
The query returns pending, paid, and shipped orders from the committed seed data.

Business Scenario:
Support dashboards often want the latest committed state rather than a frozen
snapshot of data.

Performance Notes:
READ COMMITTED is usually a good default for transactional applications, but it
does not guarantee repeated SELECT statements see identical results.

Common Mistakes:
- Expecting repeated reads to be stable inside READ COMMITTED.
- Assuming uncommitted changes from other sessions are visible.
- Using READ COMMITTED for workflows that require serial business decisions.

Challenge Exercise:
In a READ COMMITTED transaction, count completed payments by payment method.

Challenge Solution:
*/

BEGIN ISOLATION LEVEL READ COMMITTED;

SELECT
    payment_method,
    COUNT(*) AS completed_payment_count
FROM payments
WHERE status = 'completed'
GROUP BY payment_method
ORDER BY payment_method ASC;

COMMIT;

/*
Related Chapters:
- 04_transaction_isolation.sql
- 06_repeatable_read.sql
- ../04_aggregates/05_group_by.sql
*/
