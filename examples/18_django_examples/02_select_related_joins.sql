/*
Title: select_related Joins
Difficulty: Intermediate

Learning Objectives:
- Map select_related to SQL joins.
- Fetch foreign-key data in one query.
- Avoid extra customer lookups for orders.

Problem Statement:
The orders API needs order fields and customer email.

Business Scenario:
Django views often need related user data beside orders. `select_related`
fetches single-valued relationships with joins.

SQL Solution:
*/

SELECT
    orders.id AS order_id,
    orders.status,
    orders.order_date,
    users.email AS customer_email
FROM orders
INNER JOIN users
    ON users.id = orders.user_id
ORDER BY orders.order_date DESC;

/*
Explanation:
This is the SQL shape of Order.objects.select_related("user"). The join returns
order and customer data in one query.

Expected Output:
Each order appears with customer email.

Performance Notes:
select_related is useful for foreign keys and one-to-one relationships. It is
not the right tool for many-row collections.

Common Mistakes:
- Not using select_related and causing one customer query per order.
- Using select_related for reverse or many-to-many relationships.
- Selecting more related columns than the endpoint needs.

Challenge Exercise:
Write the SQL shape for payments with their order status.

Challenge Solution:
*/

SELECT
    payments.id AS payment_id,
    payments.amount,
    payments.status AS payment_status,
    orders.status AS order_status
FROM payments
INNER JOIN orders
    ON orders.id = payments.order_id
ORDER BY payments.id ASC;

/*
Related Chapters:
- ../03_joins/01_inner_join.sql
- ../13_performance/04_avoid_n_plus_one.sql
- 03_avoid_n_plus_one_django.sql
*/
