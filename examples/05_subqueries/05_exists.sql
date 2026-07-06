/*
Title: EXISTS Subquery
Difficulty: Intermediate

Learning objectives:
- Use EXISTS to test whether related rows exist.
- Find customers with at least one order.
- Prefer existence checks over unnecessary counting.

Problem statement:
Customer success wants users who have placed at least one order.

SQL solution:
*/

SELECT
    users.id,
    users.email,
    users.city
FROM users
WHERE EXISTS (
    SELECT
        1
    FROM orders
    WHERE orders.user_id = users.id
)
ORDER BY users.email ASC;

/*
Explanation:
EXISTS returns true when the subquery returns at least one row. The subquery is
correlated because it checks orders for the current user from the outer query.

Expected results:
The query returns all six sample users because every sample user has at least
one order.

Real-world example:
Marketing teams may segment registered users into customers with purchase
activity and users without purchase activity.

Performance notes:
EXISTS can stop checking after it finds the first matching row. It is usually a
good fit for relationship existence checks.

Common mistakes:
- Using COUNT(*) when EXISTS would express the question more directly.
- Selecting unnecessary columns inside the EXISTS subquery.
- Forgetting the correlation condition.

Challenge exercise:
Find products that have appeared in at least one order item.

Challenge solution:
*/

SELECT
    products.id,
    products.name
FROM products
WHERE EXISTS (
    SELECT
        1
    FROM order_items
    WHERE order_items.product_id = products.id
)
ORDER BY products.name ASC;

/*
Related examples:
- ../03_joins/02_left_join.sql
- 06_not_exists.sql
- 11_common_subquery_mistakes.sql
*/
