/*
Title: ACID Properties
Difficulty: Intermediate

Learning Objectives:
- Connect transaction behaviour to ACID.
- See atomicity and consistency in a practical update.
- Use constraints as part of transaction safety.

Problem Statement:
The warehouse team wants to understand how PostgreSQL protects stock from
invalid values during an order update.

SQL Solution:
*/

BEGIN;

UPDATE products
SET stock_quantity = stock_quantity - 1
WHERE id = 1
  AND stock_quantity >= 1
RETURNING
    id AS product_id,
    stock_quantity AS remaining_stock;

SELECT
    id AS product_id,
    stock_quantity
FROM products
WHERE id = 1;

ROLLBACK;

/*
Explanation:
Atomicity means the update is part of one unit of work. Consistency is supported
by the CHECK constraint that prevents negative stock. Isolation protects the
uncommitted change from unsafe concurrent access. Durability would apply if the
transaction committed.

Expected Output:
The product stock appears reduced inside the transaction, then ROLLBACK restores
the original seed value.

Business Scenario:
Inventory systems rely on transactions and constraints to prevent invalid stock
states.

Performance Notes:
Constraints are valuable safety nets, but they do not replace good transaction
design and targeted row locking.

Common Mistakes:
- Explaining ACID as theory without linking it to real business rules.
- Depending only on application code for consistency.
- Forgetting that durability starts after COMMIT.

Challenge Exercise:
Use a transaction to inspect how a payment refund status change would be rolled
back safely.

Challenge Solution:
*/

BEGIN;

UPDATE payments
SET status = 'refunded'
WHERE id = 1
RETURNING
    id AS payment_id,
    status;

ROLLBACK;

/*
Related Chapters:
- 01_begin_commit.sql
- 02_rollback.sql
- 09_locking.sql
*/
