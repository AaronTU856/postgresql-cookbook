/*
Title: SQL vs PL/pgSQL Functions
Difficulty: Intermediate

Learning objectives:
- Compare SQL and PL/pgSQL functions.
- Use SQL functions for direct queries.
- Use PL/pgSQL for branching logic.

Problem statement:
The team wants reusable order totals and readable payment status labels.

Business scenario:
Reports need numeric order totals, while support screens need friendly payment
status labels.

SQL solution:
*/

DROP FUNCTION IF EXISTS cookbook_order_total(BIGINT);

CREATE FUNCTION cookbook_order_total(
    p_order_id BIGINT
)
RETURNS NUMERIC
LANGUAGE SQL
STABLE
AS $$
    SELECT COALESCE(
        SUM(order_items.quantity * order_items.unit_price),
        0
    )
    FROM order_items
    WHERE order_items.order_id = p_order_id;
$$;

DROP FUNCTION IF EXISTS cookbook_payment_status_label(VARCHAR);

CREATE FUNCTION cookbook_payment_status_label(
    p_status VARCHAR
)
RETURNS TEXT
LANGUAGE plpgsql
IMMUTABLE
STRICT
AS $$
BEGIN
    IF p_status = 'completed' THEN
        RETURN 'Payment completed';
    ELSIF p_status = 'pending' THEN
        RETURN 'Payment pending';
    ELSIF p_status = 'refunded' THEN
        RETURN 'Payment refunded';
    ELSIF p_status = 'failed' THEN
        RETURN 'Payment failed';
    END IF;

    RETURN 'Unknown payment status';
END;
$$;

SELECT
    orders.id AS order_id,
    cookbook_order_total(orders.id) AS order_total,
    cookbook_payment_status_label(payments.status) AS payment_status_label
FROM orders
LEFT JOIN payments
    ON payments.order_id = orders.id
ORDER BY orders.id ASC;

/*
Explanation:
The SQL function is a good fit for one query that calculates an order total.
The PL/pgSQL function is a better fit for procedural branching with IF and ELSIF.

Expected output:
Each order appears with an order total and readable payment status label.

Performance considerations:
Calling a table-reading function once per row can be expensive on large result
sets. For large reports, a join with GROUP BY may be faster.

Common mistakes:
- Using PL/pgSQL for simple expressions that SQL handles clearly.
- Hiding expensive per-row lookups inside functions.
- Forgetting to handle unexpected input values.

Challenge:
Create a PL/pgSQL function that labels order status values for support users.

Challenge solution:
*/

DROP FUNCTION IF EXISTS cookbook_order_status_label(VARCHAR);

CREATE FUNCTION cookbook_order_status_label(
    p_status VARCHAR
)
RETURNS TEXT
LANGUAGE plpgsql
IMMUTABLE
STRICT
AS $$
BEGIN
    IF p_status = 'paid' THEN
        RETURN 'Ready for fulfilment';
    ELSIF p_status = 'shipped' THEN
        RETURN 'On the way';
    ELSIF p_status = 'delivered' THEN
        RETURN 'Delivered to customer';
    ELSIF p_status = 'cancelled' THEN
        RETURN 'Cancelled order';
    ELSIF p_status = 'pending' THEN
        RETURN 'Awaiting payment';
    END IF;

    RETURN 'Unknown order status';
END;
$$;

SELECT
    id AS order_id,
    status,
    cookbook_order_status_label(status) AS status_label
FROM orders
ORDER BY id ASC;

/*
Related chapters:
- ../04_aggregates/09_aggregate_with_join.sql
- ../08_transactions/11_real_world_transaction.sql
- 03_return_table.sql
*/
