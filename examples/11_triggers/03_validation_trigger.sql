/*
Title: Validation Trigger
Difficulty: Intermediate

Learning Objectives:
- Reject invalid writes with a BEFORE trigger.
- Raise clear business exceptions.
- Protect inventory rules in the database.

Problem Statement:
The warehouse wants to block unusually large stock quantities that probably come
from data entry mistakes.

Business Scenario:
Operational tools sometimes receive bad input. A database trigger can provide a
last line of defence.

SQL Solution:
*/

DROP TRIGGER IF EXISTS trg_products_validate_stock_limit ON products;
DROP FUNCTION IF EXISTS cookbook_validate_stock_limit();

CREATE FUNCTION cookbook_validate_stock_limit()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.stock_quantity > 1000 THEN
        RAISE EXCEPTION 'Stock quantity % is above the allowed limit',
            NEW.stock_quantity;
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_products_validate_stock_limit
BEFORE INSERT OR UPDATE OF stock_quantity ON products
FOR EACH ROW
EXECUTE FUNCTION cookbook_validate_stock_limit();

BEGIN;

UPDATE products
SET stock_quantity = 100
WHERE id = 5
RETURNING id AS product_id, stock_quantity;

ROLLBACK;

/*
Explanation:
The trigger checks NEW.stock_quantity before the row is stored. The example uses
a valid value so the file executes successfully.

Expected Output:
The temporary update returns product 5 with stock_quantity 100, then rolls back.

Performance Notes:
Validation triggers should be fast and deterministic. Prefer CHECK constraints
for simple rules when they are expressive enough.

Common Mistakes:
- Using triggers instead of simple CHECK constraints.
- Raising vague errors.
- Performing slow queries inside validation triggers.

Challenge Exercise:
Explain what would happen if an update tried to set stock_quantity to 2000.

Challenge Solution:
*/

SELECT
    'The trigger would raise an exception before the row is updated.'
        AS challenge_answer;

/*
Related Chapters:
- ../08_transactions/10_acid_properties.sql
- ../10_functions/06_error_handling.sql
- 01_audit_trigger.sql
*/
