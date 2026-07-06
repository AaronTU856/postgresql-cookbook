/*
Title: Deadlock Example
Difficulty: Advanced

Learning objectives:
- Understand how deadlocks happen.
- Avoid deadlocks with consistent lock ordering.
- Practise the safe version of a deadlock-prone workflow.

Problem statement:
Two checkout workers need to update product stock. The team wants to understand
why locking products in different orders can deadlock.

SQL solution:
*/

BEGIN;

SELECT
    id AS product_id,
    name,
    stock_quantity
FROM products
WHERE id IN (1, 2)
ORDER BY id ASC
FOR UPDATE;

ROLLBACK;

/*
Explanation:
This file shows the safe pattern: lock rows in a consistent order. A deadlock can
happen if session A locks product 1 then waits for product 2, while session B
locks product 2 then waits for product 1. PostgreSQL detects that cycle and
cancels one transaction.

Expected results:
The query locks products 1 and 2 in a stable order, returns their stock values,
and then rolls back.

Real-world example:
Checkout workers that reserve multiple products should lock product rows in the
same order every time.

Performance notes:
Deadlocks waste work because one transaction must be cancelled and retried.
Consistent lock ordering is cheaper than relying on deadlock recovery.

Common mistakes:
- Locking the same set of rows in different orders.
- Holding locks while waiting for external services.
- Treating deadlock errors as unrecoverable instead of retryable.

Challenge exercise:
Lock products 5 and 6 in a consistent order for a multi-item order, then roll
back.

Challenge solution:
*/

BEGIN;

SELECT
    id AS product_id,
    name,
    stock_quantity
FROM products
WHERE id IN (5, 6)
ORDER BY id ASC
FOR UPDATE;

ROLLBACK;

/*
Related examples:
- 07_serializable.sql
- 09_locking.sql
- 12_common_transaction_mistakes.sql
*/
