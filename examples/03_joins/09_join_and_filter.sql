/*
Title: Join and Filter Rows
Difficulty: Intermediate

Learning Objectives:
- Combine joins with WHERE filters.
- Filter joined reports by payment and order status.
- Keep filtering logic clear and close to the business question.

Problem Statement:
The fulfilment team wants paid orders with completed payments.

Business Scenario:
Warehouses often need a queue of orders that are financially complete and ready
for fulfilment.

SQL Solution:
*/

SELECT
    orders.id AS order_id,
    users.email AS customer_email,
    orders.status AS order_status,
    payments.status AS payment_status,
    payments.amount
FROM orders
INNER JOIN users
    ON users.id = orders.user_id
INNER JOIN payments
    ON payments.order_id = orders.id
WHERE orders.status IN ('paid', 'shipped', 'delivered')
    AND payments.status = 'completed'
ORDER BY orders.order_date ASC;

/*
Explanation:
The joins add customer and payment context to each order. The WHERE clause keeps
orders in workable statuses and only completed payments.

Expected Output:
The query returns paid, shipped, and delivered orders whose payment status is
completed.

Performance Notes:
Filtering before returning results reduces unnecessary rows. Indexes on join and
filter columns can help as data grows.

Common Mistakes:
- Filtering the wrong status column. orders.status and payments.status mean
  different things.
- Putting filters in the wrong place when using outer joins.
- Forgetting that refunded payments may need separate business handling.

Challenge Exercise:
Find completed card payments with customer email and order date.

Challenge Solution:
*/

SELECT
    payments.id AS payment_id,
    users.email AS customer_email,
    orders.order_date,
    payments.amount
FROM payments
INNER JOIN orders
    ON orders.id = payments.order_id
INNER JOIN users
    ON users.id = orders.user_id
WHERE payments.status = 'completed'
    AND payments.payment_method = 'card'
ORDER BY orders.order_date ASC;

/*
Related Chapters:
- ../01_basic_queries/README.md
- ../02_filtering_sorting/README.md
- README.md
*/
