/*
Title: Return Table
Difficulty: Intermediate

Learning objectives:
- Create a table-returning function.
- Return a reusable customer order history.
- Use RETURNS TABLE with clear output columns.

Problem statement:
Support needs a reusable way to fetch one customer's order history.

Business scenario:
Customer support screens often show order id, status, date, and payment amount
for the customer currently being reviewed.

SQL solution:
*/

DROP FUNCTION IF EXISTS cookbook_customer_order_history(BIGINT);

CREATE FUNCTION cookbook_customer_order_history(
    p_user_id BIGINT
)
RETURNS TABLE (
    order_id BIGINT,
    order_status VARCHAR,
    order_date TIMESTAMPTZ,
    payment_status VARCHAR,
    payment_amount NUMERIC
)
LANGUAGE SQL
STABLE
AS $$
    SELECT
        orders.id AS order_id,
        orders.status AS order_status,
        orders.order_date,
        payments.status AS payment_status,
        payments.amount AS payment_amount
    FROM orders
    LEFT JOIN payments
        ON payments.order_id = orders.id
    WHERE orders.user_id = p_user_id
    ORDER BY orders.order_date DESC;
$$;

SELECT
    order_id,
    order_status,
    order_date,
    payment_status,
    payment_amount
FROM cookbook_customer_order_history(1);

/*
Explanation:
RETURNS TABLE defines the columns returned by the function. STABLE is appropriate
because the function reads database tables but does not modify data.

Expected output:
The query returns the seeded order history for user 1.

Performance considerations:
Table-returning functions can hide joins. Make sure the underlying columns used
for filtering and joining are indexed in larger systems.

Common mistakes:
- Returning unclear column names.
- Forgetting to filter by the function parameter.
- Using a table-returning function when a simple view would be clearer.

Challenge:
Create a table-returning function that lists order items for a given order id.

Challenge solution:
*/

DROP FUNCTION IF EXISTS cookbook_order_items_for_order(BIGINT);

CREATE FUNCTION cookbook_order_items_for_order(
    p_order_id BIGINT
)
RETURNS TABLE (
    product_name VARCHAR,
    quantity INTEGER,
    unit_price NUMERIC,
    line_total NUMERIC
)
LANGUAGE SQL
STABLE
AS $$
    SELECT
        products.name AS product_name,
        order_items.quantity,
        order_items.unit_price,
        order_items.quantity * order_items.unit_price AS line_total
    FROM order_items
    INNER JOIN products
        ON products.id = order_items.product_id
    WHERE order_items.order_id = p_order_id
    ORDER BY products.name ASC;
$$;

SELECT
    product_name,
    quantity,
    unit_price,
    line_total
FROM cookbook_order_items_for_order(1);

/*
Related chapters:
- ../03_joins/04_full_outer_join.sql
- ../09_views/04_join_view.sql
- 08_reporting_function.sql
*/
