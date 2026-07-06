/*
Title: Locking
Difficulty: Intermediate

Learning objectives:
- Lock rows with FOR UPDATE.
- Protect stock checks before updates.
- Keep locked transactions short.

Problem statement:
Checkout wants to reserve stock for a product only after locking the product row.

SQL solution:
*/

BEGIN;

SELECT
    id AS product_id,
    name,
    stock_quantity
FROM products
WHERE id = 3
FOR UPDATE;

UPDATE products
SET stock_quantity = stock_quantity - 1
WHERE id = 3
  AND stock_quantity >= 1
RETURNING
    id AS product_id,
    stock_quantity AS remaining_stock;

ROLLBACK;

/*
Explanation:
FOR UPDATE locks the selected product row until the transaction ends. The UPDATE
then reduces stock only if enough stock exists. ROLLBACK keeps the seed data
unchanged.

Expected results:
The product row is selected, the stock reduction is shown, and the final rollback
undoes the change.

Real-world example:
Order placement often locks inventory rows before reducing available stock.

Performance notes:
Indexes on lookup columns help PostgreSQL find and lock only the rows needed.
Avoid locking more rows than the workflow requires.

Common mistakes:
- Locking an entire table when a row lock is enough.
- Updating stock without checking available quantity.
- Keeping locks open during payment provider calls.

Challenge exercise:
Lock product 7 and temporarily reduce stock by two units if enough stock exists.

Challenge solution:
*/

BEGIN;

SELECT
    id AS product_id,
    name,
    stock_quantity
FROM products
WHERE id = 7
FOR UPDATE;

UPDATE products
SET stock_quantity = stock_quantity - 2
WHERE id = 7
  AND stock_quantity >= 2
RETURNING
    id AS product_id,
    stock_quantity AS remaining_stock;

ROLLBACK;

/*
Related examples:
- 07_serializable.sql
- 08_deadlock_example.sql
- 11_real_world_transaction.sql
*/
