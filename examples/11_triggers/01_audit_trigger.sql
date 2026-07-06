/*
Title: Audit Trigger
Difficulty: Beginner

Learning objectives:
- Create an AFTER UPDATE trigger.
- Store audit rows for important changes.
- Use OLD and NEW values in a trigger function.

Problem statement:
The warehouse team needs an audit trail when product stock changes.

Business scenario:
Stock changes affect fulfilment and customer promises, so support teams need to
see previous and new values.

SQL solution:
*/

CREATE TABLE IF NOT EXISTS cookbook_product_stock_audit (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id BIGINT NOT NULL,
    old_stock_quantity INTEGER NOT NULL,
    new_stock_quantity INTEGER NOT NULL,
    changed_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

DROP TRIGGER IF EXISTS trg_products_stock_audit ON products;
DROP FUNCTION IF EXISTS cookbook_audit_product_stock();

CREATE FUNCTION cookbook_audit_product_stock()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF OLD.stock_quantity IS DISTINCT FROM NEW.stock_quantity THEN
        INSERT INTO cookbook_product_stock_audit (
            product_id,
            old_stock_quantity,
            new_stock_quantity
        )
        VALUES (
            NEW.id,
            OLD.stock_quantity,
            NEW.stock_quantity
        );
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_products_stock_audit
AFTER UPDATE OF stock_quantity ON products
FOR EACH ROW
EXECUTE FUNCTION cookbook_audit_product_stock();

BEGIN;

UPDATE products
SET stock_quantity = stock_quantity - 1
WHERE id = 1
RETURNING id AS product_id, stock_quantity;

SELECT
    product_id,
    old_stock_quantity,
    new_stock_quantity
FROM cookbook_product_stock_audit
ORDER BY id DESC
LIMIT 1;

ROLLBACK;

/*
Explanation:
The trigger fires after stock_quantity changes. OLD contains the previous row,
and NEW contains the updated row.

Expected output:
The UPDATE returns product 1 with temporary stock, and the audit query shows the
old and new stock values before the rollback.

Performance considerations:
Audit triggers add write overhead. Keep audit rows narrow and index them only
for real lookup patterns.

Common mistakes:
- Auditing every update even when the tracked value did not change.
- Forgetting trigger changes roll back with the transaction.
- Putting expensive reporting logic inside an audit trigger.

Challenge:
Audit price changes for products using OLD.price and NEW.price.

Challenge solution:
*/

CREATE TABLE IF NOT EXISTS cookbook_product_price_audit (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id BIGINT NOT NULL,
    old_price NUMERIC(10, 2) NOT NULL,
    new_price NUMERIC(10, 2) NOT NULL,
    changed_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

/*
Related chapters:
- ../08_transactions/02_rollback.sql
- ../10_functions/04_sql_vs_plpgsql.sql
- 04_order_status_audit.sql
*/
