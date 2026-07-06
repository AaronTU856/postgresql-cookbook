/*
Title: Updatable Views
Difficulty: Intermediate

Learning objectives:
- Recognise a simple updatable view.
- Update a base table through a view.
- Use ROLLBACK while practising view updates.

Problem statement:
Merchandising wants to update active product prices through a focused view rather
than exposing every product column.

SQL solution:
*/

DROP VIEW IF EXISTS editable_active_products;

CREATE VIEW editable_active_products AS
SELECT
    id,
    name,
    price,
    stock_quantity
FROM products
WHERE is_active = TRUE;

BEGIN;

UPDATE editable_active_products
SET price = price + 1.00
WHERE id = 1
RETURNING
    id AS product_id,
    name,
    price;

ROLLBACK;

/*
Explanation:
This simple view maps directly to one base table, so PostgreSQL can update the
products table through it. ROLLBACK keeps the sample price unchanged.

Expected results:
The update returns product 1 with a temporarily increased price, then discards
the change.

Real-world example:
Internal admin tools sometimes use focused updatable views for safe editing
screens.

Performance notes:
Updatable views still update the base table. Base-table indexes and constraints
continue to control performance and validity.

Common mistakes:
- Expecting joined or aggregate views to be automatically updatable.
- Updating through a view without understanding which base table changes.
- Forgetting to use transactions while testing updates.

Challenge exercise:
Temporarily update the stock quantity for product 3 through the view, then roll
it back.

Challenge solution:
*/

BEGIN;

UPDATE editable_active_products
SET stock_quantity = stock_quantity + 5
WHERE id = 3
RETURNING
    id AS product_id,
    name,
    stock_quantity;

ROLLBACK;

/*
Related examples:
- 01_create_view.sql
- 11_common_view_mistakes.sql
- ../08_transactions/02_rollback.sql
*/
