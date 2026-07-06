/*
Title: Common Subquery Mistakes
Difficulty: Intermediate

Learning objectives:
- Avoid using = with multi-row subqueries.
- Use EXISTS for relationship checks.
- Keep subquery output aligned with the outer query.

Problem statement:
The analytics team wants customers who have completed payments, without
overcomplicating the query.

SQL solution:
*/

SELECT
    users.id,
    users.email
FROM users
WHERE EXISTS (
    SELECT
        1
    FROM orders
    INNER JOIN payments
        ON payments.order_id = orders.id
    WHERE orders.user_id = users.id
        AND payments.status = 'completed'
)
ORDER BY users.email ASC;

/*
Explanation:
EXISTS is a clear way to ask whether a user has at least one completed payment.
The subquery returns 1 because the actual selected value does not matter.

Expected results:
The query returns users with at least one completed payment.

Real-world example:
Marketing teams may segment customers who have completed purchases.

Performance notes:
EXISTS can stop after finding the first matching related row. This is usually
better than counting all matching rows when only existence matters.

Common mistakes:
- Writing user_id = (SELECT user_id FROM orders), which fails if the subquery
  returns multiple rows.
- Returning several columns from a subquery used in a single-value comparison.
- Counting rows when EXISTS would express the business question better.

Challenge exercise:
Find products that have order items using EXISTS.

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
- 05_exists.sql
- 06_not_exists.sql
- 10_subquery_vs_join.sql
*/
