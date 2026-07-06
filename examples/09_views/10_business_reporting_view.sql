/*
Title: Business Reporting View
Difficulty: Intermediate

Learning objectives:
- Build a reusable reporting view.
- Combine joins and aggregates in a business query.
- Present customer order value clearly.

Problem statement:
Leadership wants a reusable customer value report showing order count,
completed payment total, and most recent order date.

SQL solution:
*/

DROP VIEW IF EXISTS customer_value_report;

CREATE VIEW customer_value_report AS
SELECT
    users.id AS user_id,
    users.email,
    users.first_name || ' ' || users.last_name AS customer_name,
    COUNT(DISTINCT orders.id) AS order_count,
    COALESCE(
        SUM(payments.amount) FILTER (WHERE payments.status = 'completed'),
        0
    ) AS completed_payment_total,
    MAX(orders.order_date) AS latest_order_date
FROM users
LEFT JOIN orders
    ON orders.user_id = users.id
LEFT JOIN payments
    ON payments.order_id = orders.id
GROUP BY
    users.id,
    users.email,
    users.first_name,
    users.last_name;

SELECT
    customer_name,
    email,
    order_count,
    completed_payment_total,
    latest_order_date
FROM customer_value_report
ORDER BY completed_payment_total DESC, customer_name ASC;

/*
Explanation:
The view combines users, orders, and payments into a reusable business report.
COALESCE returns zero for customers without completed payments.

Expected results:
The query returns one row per customer with order count, completed payment total,
and latest order date.

Real-world example:
Customer success teams use value reports to prioritise outreach and account
review work.

Performance notes:
Reporting views with joins and aggregates can be expensive on large datasets.
Consider indexes, materialized views, or summary tables for frequent reports.

Common mistakes:
- Counting duplicate orders after joining to payment or item tables.
- Forgetting COALESCE when outer joins may return NULL totals.
- Mixing business definitions of paid, refunded, and pending values.

Challenge exercise:
Create a reporting view that shows revenue by product category.

Challenge solution:
*/

DROP VIEW IF EXISTS category_revenue_report;

CREATE VIEW category_revenue_report AS
SELECT
    categories.name AS category_name,
    COUNT(DISTINCT orders.id) AS order_count,
    SUM(order_items.quantity * order_items.unit_price) AS gross_revenue
FROM categories
INNER JOIN products
    ON products.category_id = categories.id
INNER JOIN order_items
    ON order_items.product_id = products.id
INNER JOIN orders
    ON orders.id = order_items.order_id
GROUP BY categories.name;

SELECT
    category_name,
    order_count,
    gross_revenue
FROM category_revenue_report
ORDER BY gross_revenue DESC;

/*
Related examples:
- 04_join_view.sql
- 05_aggregate_view.sql
- ../07_window_functions/14_business_reporting.sql
*/
