/*
Title: Business Calculation Function
Difficulty: Intermediate

Learning Objectives:
- Encapsulate an order-total calculation.
- Handle missing rows safely.
- Use a function in practical reporting queries.

Problem Statement:
Reports repeatedly need the total value of an order based on its order items.

Business Scenario:
Finance, support, and fulfilment teams all need the same definition of order
value.

SQL Solution:
*/

DROP FUNCTION IF EXISTS cookbook_calculate_order_total(BIGINT);

CREATE FUNCTION cookbook_calculate_order_total(
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

SELECT
    orders.id AS order_id,
    orders.status,
    cookbook_calculate_order_total(orders.id) AS order_total
FROM orders
ORDER BY orders.id ASC;

/*
Explanation:
The function centralises the order-total calculation and returns zero when an
order has no items.

Expected Output:
Each order appears with its calculated order total.

Performance Notes:
This is readable for small reports. For large reports, prefer one grouped query
over calling a table-reading function once per order.

Common Mistakes:
- Returning NULL for orders with no items when the business expects zero.
- Calculating order totals differently in different reports.
- Hiding a repeated aggregate inside row-by-row function calls at scale.

Challenge Exercise:
Create a function that calculates completed payment total for a customer.

Challenge Solution:
*/

DROP FUNCTION IF EXISTS cookbook_customer_completed_payment_total(BIGINT);

CREATE FUNCTION cookbook_customer_completed_payment_total(
    p_user_id BIGINT
)
RETURNS NUMERIC
LANGUAGE SQL
STABLE
AS $$
    SELECT COALESCE(
        SUM(payments.amount),
        0
    )
    FROM orders
    INNER JOIN payments
        ON payments.order_id = orders.id
    WHERE orders.user_id = p_user_id
      AND payments.status = 'completed';
$$;

SELECT
    users.email,
    cookbook_customer_completed_payment_total(users.id) AS completed_payment_total
FROM users
ORDER BY completed_payment_total DESC, users.email ASC;

/*
Related Chapters:
- ../04_aggregates/10_business_reports.sql
- ../09_views/10_business_reporting_view.sql
- 08_reporting_function.sql
*/
