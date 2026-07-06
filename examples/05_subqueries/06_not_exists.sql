/*
Title: NOT EXISTS Subquery
Difficulty: Intermediate

Learning objectives:
- Use NOT EXISTS to find missing related records.
- Exclude users with a specific type of related activity.
- Understand anti-join style logic.

Problem statement:
Customer success wants users who do not have any pending payments.

SQL solution:
*/

SELECT
    users.id,
    users.email,
    users.city
FROM users
WHERE NOT EXISTS (
    SELECT
        1
    FROM orders
    INNER JOIN payments
        ON payments.order_id = orders.id
    WHERE orders.user_id = users.id
        AND payments.status = 'pending'
)
ORDER BY users.email ASC;

/*
Explanation:
NOT EXISTS returns true when the subquery returns no rows. This query keeps
users only when no pending payment can be found for their orders.

Expected results:
The query returns users who do not have a pending payment. Liam Wilson is
excluded because his order has a pending bank transfer.

Real-world example:
Customer success teams may look for customers without payment issues before
sending follow-up offers.

Performance notes:
NOT EXISTS is often safer than NOT IN when the subquery could contain NULL
values. Indexes on join and filter columns help larger anti-join queries.

Common mistakes:
- Using NOT IN with nullable subquery results.
- Forgetting the correlation condition back to the outer query.
- Treating missing related rows as an error when they may be meaningful.

Challenge exercise:
Find categories that do not contain any products priced above 80.00.

Challenge solution:
*/

SELECT
    categories.id,
    categories.name
FROM categories
WHERE NOT EXISTS (
    SELECT
        1
    FROM products
    WHERE products.category_id = categories.id
        AND products.price > 80.00
)
ORDER BY categories.name ASC;

/*
Related examples:
- 05_exists.sql
- ../02_filtering_sorting/08_null_handling.sql
- ../03_joins/04_full_outer_join.sql
*/
