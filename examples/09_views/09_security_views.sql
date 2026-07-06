/*
Title: Security Views
Difficulty: Intermediate

Learning objectives:
- Use views to expose safer column sets.
- Hide sensitive or unnecessary fields.
- Understand security_barrier as a defensive option.

Problem statement:
Analytics users need customer location and signup date, but not full customer
details.

SQL solution:
*/

DROP VIEW IF EXISTS analytics_customer_view;

CREATE VIEW analytics_customer_view
WITH (security_barrier = true) AS
SELECT
    id AS user_id,
    city,
    country,
    created_at
FROM users;

SELECT
    user_id,
    city,
    country,
    created_at
FROM analytics_customer_view
ORDER BY created_at ASC;

/*
Explanation:
The view exposes only selected customer columns. The security_barrier option can
help prevent certain query-planning behaviours from pushing user-supplied
conditions past the view boundary.

Expected results:
The query returns customer ids, locations, countries, and creation timestamps.

Real-world example:
Analytics teams often need customer geography without full customer contact
details.

Performance notes:
Security-oriented options can reduce planner flexibility. Use them where the
security boundary matters and test important queries.

Common mistakes:
- Treating a view as a complete permission model.
- Exposing email or personal data when only geography is needed.
- Forgetting to grant permissions on the view instead of the base table.

Challenge exercise:
Create a security-focused view exposing order id, status, and shipping country
without customer names or email addresses.

Challenge solution:
*/

DROP VIEW IF EXISTS analytics_order_view;

CREATE VIEW analytics_order_view
WITH (security_barrier = true) AS
SELECT
    id AS order_id,
    status,
    shipping_country,
    order_date
FROM orders;

SELECT
    order_id,
    status,
    shipping_country,
    order_date
FROM analytics_order_view
ORDER BY order_date ASC;

/*
Related examples:
- 02_simple_view.sql
- 04_join_view.sql
- ../01_basic_queries/02_select_columns.sql
*/
