/*
Title: Limit Result Rows
Difficulty: Beginner

Learning objectives:
- Use LIMIT to return a smaller result set.
- Combine LIMIT with ORDER BY.
- Understand why LIMIT without ORDER BY can be unpredictable.

Problem statement:
The admin dashboard needs to show the three most recent orders.

SQL solution:
*/

SELECT
    id,
    status,
    order_date
FROM orders
ORDER BY order_date DESC
LIMIT 3;

/*
Expected result description:
The query returns the three newest orders by order_date.

Explanation:
LIMIT restricts how many rows PostgreSQL returns. ORDER BY decides which rows
come first, then LIMIT keeps only the requested number.

Real-world example:
A dashboard might show only a small preview of recent activity, with a separate
page for the full list.

Performance considerations:
LIMIT can reduce the amount of data returned to the application. It is most
useful with a selective WHERE clause or an ORDER BY that can use an index.

Common mistakes:
- Using LIMIT without ORDER BY and expecting the same rows every time.
- Treating LIMIT as a security control. It only reduces output size.

Challenge exercise:
Return the two cheapest products.

Challenge solution:
*/

SELECT
    name,
    price
FROM products
ORDER BY price ASC
LIMIT 2;

/*
Related examples:
- 05_order_by.sql
- 04_where_clause.sql
*/
