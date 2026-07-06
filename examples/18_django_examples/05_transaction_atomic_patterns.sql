/*
Title: Transaction Atomic Patterns
Difficulty: Advanced

Learning objectives:
- Connect Django transaction.atomic to PostgreSQL transactions.
- Use row locks for checkout-style updates.
- Roll back practice writes safely.

Problem statement:
A Django checkout flow needs to reduce stock and create payment-related data as
one unit of work.

Business scenario:
In Django, transaction.atomic() should wrap multi-step writes that must succeed
or fail together.

SQL solution:
*/

BEGIN;

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

ROLLBACK;

/*
Explanation:
This is the database behaviour behind a Django transaction.atomic block that
locks a product and updates stock safely.

Expected output:
The product row is locked, stock is temporarily reduced, and rollback restores
the seed data.

Performance considerations:
Keep atomic blocks short. Do not hold database locks while waiting for slow
external services.

Common mistakes:
- Updating stock without a transaction.
- Holding transaction.atomic open during payment provider calls.
- Forgetting to handle retryable transaction errors.

Challenge:
Lock product 5 and temporarily reduce stock by one.

Challenge solution:
*/

BEGIN;

SELECT
    id AS product_id,
    name,
    stock_quantity
FROM products
WHERE id = 5
FOR UPDATE;

UPDATE products
SET stock_quantity = stock_quantity - 1
WHERE id = 5
  AND stock_quantity >= 1
RETURNING
    id AS product_id,
    stock_quantity AS remaining_stock;

ROLLBACK;

/*
Related chapters:
- ../08_transactions/09_locking.sql
- ../08_transactions/11_real_world_transaction.sql
- ../16_administration/03_activity_monitoring.sql
*/
