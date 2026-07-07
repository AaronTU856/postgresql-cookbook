/*
Title: Single-Row Subquery
Difficulty: Beginner

Learning Objectives:
- Use a subquery that returns one row.
- Filter orders for one known customer.
- Use a unique column to keep the subquery result safe.

Problem Statement:
Support wants all orders placed by Amelia Clark.

SQL Solution:
*/

SELECT
    id AS order_id,
    status,
    order_date,
    shipping_city
FROM orders
WHERE user_id = (
    SELECT
        id
    FROM users
    WHERE email = 'amelia.clark@example.com'
)
ORDER BY order_date DESC;

/*
Explanation:
The subquery finds one user ID from a unique email address. The outer query uses
that ID to return Amelia Clark's orders.

Expected Output:
The query returns two orders for Amelia Clark.

Business Scenario:
Customer support tools often look up activity for one customer based on a unique
identifier such as email.

Performance Notes:
Single-row subqueries are safest when the subquery filters on a unique column.
The users.email column is unique in this schema.

Common Mistakes:
- Using = with a subquery that can return multiple rows.
- Filtering by a non-unique value such as first_name.
- Selecting more than one column in a scalar comparison.

Challenge Exercise:
Find the payment for the latest order.

Challenge Solution:
*/

SELECT
    id AS payment_id,
    order_id,
    amount,
    status
FROM payments
WHERE order_id = (
    SELECT
        id
    FROM orders
    ORDER BY order_date DESC
    LIMIT 1
);

/*
Related Chapters:
- ../01_basic_queries/06_limit.sql
- ../03_joins/01_inner_join.sql
- 01_scalar_subquery.sql
*/
