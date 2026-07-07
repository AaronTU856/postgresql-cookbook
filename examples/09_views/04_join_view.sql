/*
Title: Join View
Difficulty: Intermediate

Learning Objectives:
- Create a view that joins related tables.
- Simplify repeated order lookup queries.
- Use clear aliases in view definitions.

Problem Statement:
Support frequently needs orders with customer names and payment status in one
readable result.

SQL Solution:
*/

DROP VIEW IF EXISTS order_support_view;

CREATE VIEW order_support_view AS
SELECT
    orders.id AS order_id,
    orders.status AS order_status,
    orders.order_date,
    users.email AS customer_email,
    users.first_name || ' ' || users.last_name AS customer_name,
    payments.status AS payment_status,
    payments.amount AS payment_amount
FROM orders
INNER JOIN users
    ON users.id = orders.user_id
LEFT JOIN payments
    ON payments.order_id = orders.id;

SELECT
    order_id,
    customer_email,
    order_status,
    payment_status,
    payment_amount
FROM order_support_view
ORDER BY order_date ASC;

/*
Explanation:
The view hides the join details behind a business-friendly name. Support users
can query one view instead of joining orders, users, and payments each time.

Expected Output:
The query returns each order with customer email, order status, payment status,
and payment amount.

Business Scenario:
Support dashboards often use joined views to keep ticket investigation queries
short and consistent.

Performance Notes:
The view still runs the joins at query time. Foreign-key indexes on the base
tables help the joined query perform well.

Common Mistakes:
- Using SELECT * in view definitions.
- Reusing ambiguous column names such as status without aliases.
- Assuming joins inside a view are automatically cached.

Challenge Exercise:
Create a view showing order item lines with product names and unit prices.

Challenge Solution:
*/

DROP VIEW IF EXISTS order_item_product_view;

CREATE VIEW order_item_product_view AS
SELECT
    order_items.order_id,
    products.name AS product_name,
    order_items.quantity,
    order_items.unit_price,
    order_items.quantity * order_items.unit_price AS line_total
FROM order_items
INNER JOIN products
    ON products.id = order_items.product_id;

SELECT
    order_id,
    product_name,
    quantity,
    unit_price,
    line_total
FROM order_item_product_view
ORDER BY order_id ASC, product_name ASC;

/*
Related Chapters:
- 05_aggregate_view.sql
- ../03_joins/07_join_multiple_tables.sql
- ../08_transactions/11_real_world_transaction.sql
*/
