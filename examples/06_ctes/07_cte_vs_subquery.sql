/*
Title: CTE vs Subquery
Difficulty: Intermediate

Learning Objectives:
- Compare a CTE with an equivalent subquery.
- Use a CTE when naming a step improves readability.
- Filter products by category using a named result.

Problem Statement:
The product team wants all products in the Books category.

SQL Solution:
*/

WITH book_category AS (
    SELECT
        id
    FROM categories
    WHERE name = 'Books'
)
SELECT
    products.name,
    products.price
FROM products
INNER JOIN book_category
    ON book_category.id = products.category_id
ORDER BY products.name ASC;

/*
Explanation:
The CTE names the category lookup step. The outer query joins products to that
named result. This is equivalent to a small subquery or a direct join.

Expected Output:
The query returns products in the Books category.

Business Scenario:
A query may start as a small subquery and become a CTE when the lookup logic
needs a clear name or is reused by later steps.

Performance Notes:
CTEs are not always faster than subqueries. Choose the structure for clarity,
then check performance when the dataset grows.

Common Mistakes:
- Rewriting every subquery as a CTE without improving readability.
- Assuming CTEs are always materialised or always faster.
- Naming the CTE after its implementation instead of its purpose.

Challenge Exercise:
Use a CTE to return orders for users in Manchester.

Challenge Solution:
*/

WITH manchester_users AS (
    SELECT
        id
    FROM users
    WHERE city = 'Manchester'
)
SELECT
    orders.id AS order_id,
    orders.status,
    orders.order_date
FROM orders
INNER JOIN manchester_users
    ON manchester_users.id = orders.user_id
ORDER BY orders.order_date DESC;

/*
Related Chapters:
- ../05_subqueries/10_subquery_vs_join.sql
- ../03_joins/10_join_best_practices.sql
- 01_basic_cte.sql
*/
