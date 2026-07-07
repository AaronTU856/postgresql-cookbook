/*
Title: SERIALIZABLE
Difficulty: Advanced

Learning Objectives:
- Use PostgreSQL's strongest isolation level.
- Understand why serializable transactions may need retries.
- Protect business rules that depend on current data.

Problem Statement:
Checkout needs the strongest isolation while checking stock for a product before
an order is accepted.

SQL Solution:
*/

BEGIN ISOLATION LEVEL SERIALIZABLE;

SELECT
    id AS product_id,
    name,
    stock_quantity
FROM products
WHERE id = 1
  AND stock_quantity > 0;

UPDATE products
SET stock_quantity = stock_quantity
WHERE id = 1
  AND stock_quantity > 0
RETURNING
    id AS product_id,
    stock_quantity;

COMMIT;

/*
Explanation:
SERIALIZABLE asks PostgreSQL to make concurrent transactions behave as if they
ran one at a time. The UPDATE is intentionally harmless, but it demonstrates the
place where checkout code would write after validating stock.

Expected Output:
The product is returned if it has stock. The committed UPDATE leaves the stock
quantity unchanged.

Business Scenario:
High-value checkout or booking systems may use SERIALIZABLE when overselling or
double booking would be costly.

Performance Notes:
Serializable transactions can fail with serialization errors under concurrency.
Applications must catch those errors and retry the whole transaction.

Common Mistakes:
- Using SERIALIZABLE without retry logic.
- Assuming stronger isolation removes the need for constraints.
- Running large reports at SERIALIZABLE without a clear reason.

Challenge Exercise:
Use SERIALIZABLE to safely check whether product 5 has at least one item in
stock.

Challenge Solution:
*/

BEGIN ISOLATION LEVEL SERIALIZABLE;

SELECT
    id AS product_id,
    name,
    stock_quantity
FROM products
WHERE id = 5
  AND stock_quantity >= 1;

COMMIT;

/*
Related Chapters:
- 04_transaction_isolation.sql
- 09_locking.sql
- 11_real_world_transaction.sql
*/
