/*
Title: Subquery in SELECT
Difficulty: Intermediate

Learning Objectives:
- Use a correlated subquery in the SELECT list.
- Add per-user summary values to user rows.
- Understand when SELECT subqueries are readable.

Problem Statement:
Customer success wants a user list with each user's order count.

SQL Solution:
*/

SELECT
    users.id,
    users.email,
    (
        SELECT
            COUNT(*)
        FROM orders
        WHERE orders.user_id = users.id
    ) AS order_count
FROM users
ORDER BY users.email ASC;

/*
Explanation:
The subquery runs in relation to each user row and counts orders for that user.
The result appears as a calculated column named order_count.

Expected Output:
The query returns six users with their order counts. Amelia Clark has two
orders, while the other users have one.

Business Scenario:
Admin customer lists often include small per-row summary values such as order
count or latest activity date.

Performance Notes:
Correlated subqueries in SELECT can become expensive for large result sets.
Consider a join with aggregation when calculating summaries for many rows.

Common Mistakes:
- Returning more than one column from a SELECT-list subquery.
- Using this pattern for large reports without checking performance.
- Forgetting clear aliases for calculated columns.

Challenge Exercise:
Show each product with the number of times it appears in order_items.

Challenge Solution:
*/

SELECT
    products.id,
    products.name,
    (
        SELECT
            COUNT(*)
        FROM order_items
        WHERE order_items.product_id = products.id
    ) AS order_item_count
FROM products
ORDER BY products.name ASC;

/*
Related Chapters:
- ../04_aggregates/01_count.sql
- 04_correlated_subquery.sql
- 09_subquery_in_from.sql
*/
