/*
Title: Views Chapter Summary
Difficulty: Intermediate

Learning objectives:
- Review regular views, joins, and aggregates.
- Understand when materialized views are useful.
- Build a complete reporting view from the sample schema.

Problem statement:
Summarise the chapter by creating a reusable order fulfilment report for support
and operations.

SQL solution:
*/

DROP VIEW IF EXISTS order_fulfilment_report;

CREATE VIEW order_fulfilment_report AS
SELECT
    orders.id AS order_id,
    orders.status AS order_status,
    orders.order_date,
    users.email AS customer_email,
    payments.status AS payment_status,
    payments.amount AS payment_amount,
    COUNT(order_items.id) AS item_line_count,
    SUM(order_items.quantity) AS total_items
FROM orders
INNER JOIN users
    ON users.id = orders.user_id
LEFT JOIN payments
    ON payments.order_id = orders.id
LEFT JOIN order_items
    ON order_items.order_id = orders.id
GROUP BY
    orders.id,
    orders.status,
    orders.order_date,
    users.email,
    payments.status,
    payments.amount;

SELECT
    order_id,
    order_status,
    customer_email,
    payment_status,
    payment_amount,
    item_line_count,
    total_items
FROM order_fulfilment_report
ORDER BY order_date ASC;

/*
Explanation:
The summary view combines joined data and aggregate values into a clear
fulfilment report. It demonstrates how views can make repeated business queries
easier to read.

Expected results:
The query returns one row per order with customer email, payment details, and
item counts.

Real-world example:
Operations teams often use fulfilment views to monitor order status, payment
state, and item volume in one place.

Performance notes:
This regular view recalculates joins and aggregates when queried. If the report
becomes expensive and can tolerate stale data, a materialized view may be a
better fit.

Common mistakes:
- Treating a summary view as stored data.
- Forgetting to group by all non-aggregated columns.
- Building reports without clear business definitions.

Challenge exercise:
Create a materialized snapshot of the same fulfilment report for faster repeated
reads.

Challenge solution:
*/

DROP MATERIALIZED VIEW IF EXISTS order_fulfilment_snapshot;

CREATE MATERIALIZED VIEW order_fulfilment_snapshot AS
SELECT
    orders.id AS order_id,
    orders.status AS order_status,
    users.email AS customer_email,
    payments.status AS payment_status,
    COUNT(order_items.id) AS item_line_count,
    SUM(order_items.quantity) AS total_items
FROM orders
INNER JOIN users
    ON users.id = orders.user_id
LEFT JOIN payments
    ON payments.order_id = orders.id
LEFT JOIN order_items
    ON order_items.order_id = orders.id
GROUP BY
    orders.id,
    orders.status,
    users.email,
    payments.status;

SELECT
    order_id,
    order_status,
    customer_email,
    payment_status,
    item_line_count,
    total_items
FROM order_fulfilment_snapshot
ORDER BY order_id ASC;

/*
Related examples:
- 04_join_view.sql
- 05_aggregate_view.sql
- 07_materialized_views.sql
*/
