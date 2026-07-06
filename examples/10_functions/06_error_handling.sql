/*
Title: Error Handling
Difficulty: Advanced

Learning objectives:
- Raise useful exceptions in PL/pgSQL.
- Validate business rules inside a function.
- Avoid silent failures in checkout logic.

Problem statement:
Checkout needs a reusable stock availability check before accepting an order.

Business scenario:
An e-commerce system should fail clearly when a customer tries to buy more stock
than is available.

SQL solution:
*/

DROP FUNCTION IF EXISTS cookbook_require_available_stock(BIGINT, INTEGER);

CREATE FUNCTION cookbook_require_available_stock(
    p_product_id BIGINT,
    p_quantity INTEGER
)
RETURNS BOOLEAN
LANGUAGE plpgsql
STABLE
AS $$
DECLARE
    v_stock_quantity INTEGER;
BEGIN
    IF p_quantity <= 0 THEN
        RAISE EXCEPTION 'Quantity must be greater than zero';
    END IF;

    SELECT products.stock_quantity
    INTO v_stock_quantity
    FROM products
    WHERE products.id = p_product_id
      AND products.is_active = TRUE;

    IF v_stock_quantity IS NULL THEN
        RAISE EXCEPTION 'Active product % was not found', p_product_id;
    END IF;

    IF v_stock_quantity < p_quantity THEN
        RAISE EXCEPTION 'Product % has only % units available',
            p_product_id,
            v_stock_quantity;
    END IF;

    RETURN TRUE;
END;
$$;

SELECT
    id AS product_id,
    name,
    stock_quantity,
    cookbook_require_available_stock(id, 2) AS has_required_stock
FROM products
WHERE id = 3;

/*
Explanation:
The function validates quantity, checks the product exists, and raises clear
exceptions for invalid checkout conditions. The example calls it with available
stock so validation succeeds.

Expected output:
Product 3 is returned with has_required_stock set to true.

Performance considerations:
Error handling improves correctness, but exceptions should represent exceptional
cases rather than normal control flow in high-volume queries.

Common mistakes:
- Returning false without explaining why checkout failed.
- Raising vague exceptions that are hard to debug.
- Calling exception-heavy functions across large reports.

Challenge:
Use the function to validate one unit of product 7.

Challenge solution:
*/

SELECT
    id AS product_id,
    name,
    stock_quantity,
    cookbook_require_available_stock(id, 1) AS has_required_stock
FROM products
WHERE id = 7;

/*
Related chapters:
- ../08_transactions/09_locking.sql
- ../08_transactions/11_real_world_transaction.sql
- 04_sql_vs_plpgsql.sql
*/
