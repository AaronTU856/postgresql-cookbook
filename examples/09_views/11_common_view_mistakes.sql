/*
Title: Common View Mistakes
Difficulty: Intermediate

Learning Objectives:
- Avoid hiding unclear logic inside views.
- Use stable aliases and explicit columns.
- Choose regular or materialized views deliberately.

Problem Statement:
The team wants a safe order summary view that avoids ambiguous column names and
unnecessary nested logic.

SQL Solution:
*/

DROP VIEW IF EXISTS clear_order_summary;

CREATE VIEW clear_order_summary AS
SELECT
    orders.id AS order_id,
    orders.status AS order_status,
    orders.order_date,
    users.email AS customer_email,
    payments.status AS payment_status,
    payments.amount AS payment_amount
FROM orders
INNER JOIN users
    ON users.id = orders.user_id
LEFT JOIN payments
    ON payments.order_id = orders.id;

SELECT
    order_id,
    order_status,
    customer_email,
    payment_status,
    payment_amount
FROM clear_order_summary
ORDER BY order_date ASC;

/*
Explanation:
The view avoids SELECT *, ambiguous status columns, and unnecessary nested views.
Clear aliases make the result easier to use from reports and application code.

Expected Output:
The query returns order summaries with separate order and payment status columns.

Business Scenario:
Clean reporting views reduce confusion when several tables contain similarly
named columns.

Performance Notes:
Simple, direct views are easier for PostgreSQL to plan. Deeply nested views can
make slow queries harder to diagnose.

Common Mistakes:
- Using SELECT * in a view that application code depends on.
- Returning duplicate column names.
- Nesting views until the real query is hard to understand.
- Choosing a materialized view without a refresh plan.

Challenge Exercise:
Create a clear payment review view with explicit payment and order aliases.

Challenge Solution:
*/

DROP VIEW IF EXISTS clear_payment_review;

CREATE VIEW clear_payment_review AS
SELECT
    payments.id AS payment_id,
    payments.status AS payment_status,
    payments.amount AS payment_amount,
    orders.id AS order_id,
    orders.status AS order_status
FROM payments
INNER JOIN orders
    ON orders.id = payments.order_id;

SELECT
    payment_id,
    payment_status,
    payment_amount,
    order_id,
    order_status
FROM clear_payment_review
ORDER BY payment_id ASC;

/*
Related Chapters:
- 04_join_view.sql
- 09_security_views.sql
- ../03_joins/11_common_join_mistakes.sql
*/
