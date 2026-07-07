/*
Title: INNER JOIN Orders to Users
Difficulty: Beginner

Learning Objectives:
- Use INNER JOIN to combine matching rows from two tables.
- Join orders to the users who placed them.
- Select qualified columns from related tables.

Problem Statement:
Customer support needs a list of orders with the customer name and email for
each order.

Business Scenario:
Support agents should not see only order IDs. They need customer context so they
can contact the right person about each order.

SQL Solution:
*/

SELECT
    orders.id AS order_id,
    orders.status,
    orders.order_date,
    users.first_name,
    users.last_name,
    users.email
FROM orders
INNER JOIN users
    ON users.id = orders.user_id
ORDER BY orders.order_date DESC;

/*
Explanation:
INNER JOIN returns only rows where the join condition matches. Here, each order
has a user_id that matches users.id, so the query returns order rows with their
customer details.

Expected Output:
The query returns seven orders, each with the matching customer's name and email.

Performance Notes:
The schema indexes orders.user_id, which helps PostgreSQL join orders back to
users efficiently as the table grows.

Common Mistakes:
- Joining users.id to orders.id instead of orders.user_id.
- Using SELECT * and getting duplicate id column names.
- Forgetting the ON clause.

Challenge Exercise:
List payments with their order status and order date.

Challenge Solution:
*/

SELECT
    payments.id AS payment_id,
    payments.amount,
    payments.status AS payment_status,
    orders.status AS order_status,
    orders.order_date
FROM payments
INNER JOIN orders
    ON orders.id = payments.order_id
ORDER BY orders.order_date DESC;

/*
Related Chapters:
- ../01_basic_queries/README.md
- ../02_filtering_sorting/README.md
- README.md
*/
