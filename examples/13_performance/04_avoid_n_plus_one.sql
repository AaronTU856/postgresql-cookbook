/*
Title: Avoid N+1 Queries
Difficulty: Intermediate

Learning Objectives:
- Recognise row-by-row lookup patterns.
- Replace repeated queries with one join.
- Build efficient customer order summaries.

Problem Statement:
The application needs customer emails beside each order.

Business Scenario:
A backend endpoint should not fetch orders first and then run one customer query
per order.

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
One join returns all required order and customer data. This avoids repeated
application queries for each order row.

Expected Output:
Each order appears with its customer email.

Performance Notes:
Set-based joins usually scale better than N+1 application query loops. Indexes
on foreign keys support join performance.

Common Mistakes:
- Fetching related rows one at a time in application code.
- Blaming PostgreSQL before checking application query counts.
- Returning too much joined data.

Challenge Exercise:
Return payment details with order status in one query.

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
- ../03_joins/07_join_multiple_tables.sql
- ../12_indexes/02_composite_index.sql
- 03_avoid_select_star.sql
*/
