/*
Title: Transactions Chapter Summary
Difficulty: Intermediate

Learning Objectives:
- Review transaction control commands.
- Combine locking, updates, and rollback.
- Recognise the safest pattern for practice queries.

Problem Statement:
Summarise the chapter by simulating a small stock reservation and payment review
inside one rollback-safe transaction.

SQL Solution:
*/

BEGIN ISOLATION LEVEL READ COMMITTED;

SELECT
    id AS product_id,
    name,
    stock_quantity
FROM products
WHERE id = 1
FOR UPDATE;

UPDATE products
SET stock_quantity = stock_quantity - 1
WHERE id = 1
  AND stock_quantity >= 1
RETURNING
    id AS product_id,
    stock_quantity AS remaining_stock;

SELECT
    payments.id AS payment_id,
    payments.status,
    payments.amount
FROM payments
INNER JOIN orders
    ON orders.id = payments.order_id
WHERE orders.user_id = 1
ORDER BY payments.id ASC;

ROLLBACK;

/*
Explanation:
The transaction sets an isolation level, locks a product row, performs a guarded
stock update, reads related payment information, and rolls everything back. It
pulls together transaction control, isolation, locking, and safe practice habits.

Expected Output:
The product stock appears reduced inside the transaction, customer payment rows
are returned, and ROLLBACK restores the original stock quantity.

Business Scenario:
Checkout and support workflows often combine row locks, guarded updates, and
related reads inside a single transaction.

Performance Notes:
Short transactions with targeted locks scale better than broad transactions that
touch more rows than needed.

Common Mistakes:
- Forgetting which statements are inside the transaction.
- Assuming reads and writes have the same locking behaviour.
- Omitting business-rule filters from UPDATE statements.

Challenge Exercise:
Write a rollback-safe transaction that locks product 5, checks completed
payments, and rolls back.

Challenge Solution:
*/

BEGIN;

SELECT
    id AS product_id,
    name,
    stock_quantity
FROM products
WHERE id = 5
FOR UPDATE;

SELECT
    COUNT(*) AS completed_payment_count,
    SUM(amount) AS completed_payment_total
FROM payments
WHERE status = 'completed';

ROLLBACK;

/*
Related Chapters:
- 04_transaction_isolation.sql
- 09_locking.sql
- 11_real_world_transaction.sql
*/
