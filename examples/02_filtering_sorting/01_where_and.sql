/*
Title: Filter With WHERE and AND
Difficulty: Beginner

Concepts:
- WHERE
- AND
- Boolean and numeric filters

Learning Objectives:
- Combine multiple conditions with AND.
- Filter active products by stock level.
- Return rows only when every condition is true.

Problem Statement:
The operations team wants to find active products that have fewer than 20 items
left in stock.

SQL Solution:
*/

SELECT
    name,
    price,
    stock_quantity
FROM products
WHERE is_active = TRUE
    AND stock_quantity < 20
ORDER BY stock_quantity ASC;

/*
Explanation:
AND requires both conditions to be true. This query keeps only active products
where stock_quantity is below 20.

Expected Output:
The query returns Mechanical Keyboard, USB-C Dock, and Desk Lamp ordered from
lowest stock to highest stock.

Business Scenario:
An ecommerce dashboard might use this query to show products that need
restocking soon.

Performance Notes:
AND filters can benefit from indexes when tables become large. For this small
learning dataset, clear filtering logic is more important than adding indexes.

Common Mistakes:
- Using AND when OR is needed.
- Forgetting that every AND condition must match.
- Writing boolean checks as strings, such as is_active = 'true'.

Challenge Exercise:
Find paid orders shipping to Manchester.

Challenge Solution:
*/

SELECT
    id,
    status,
    order_date,
    shipping_city
FROM orders
WHERE status = 'paid'
    AND shipping_city = 'Manchester'
ORDER BY order_date DESC;

/*
Related Chapters:
- ../01_basic_queries/04_where_clause.sql
- 02_where_or.sql
- 04_comparison_operators.sql
*/
