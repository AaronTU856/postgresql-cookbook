/*
Title: Join Best Practices
Difficulty: Beginner

Learning objectives:
- Use explicit JOIN syntax.
- Use readable table aliases.
- Qualify selected columns in joined queries.

Problem statement:
The product team wants a clear product list with category names.

Business scenario:
Product APIs and admin exports often need category labels, but the products
table stores only category_id.

SQL solution:
*/

SELECT
    p.id AS product_id,
    p.name AS product_name,
    c.name AS category_name,
    p.price,
    p.stock_quantity
FROM products AS p
INNER JOIN categories AS c
    ON c.id = p.category_id
ORDER BY c.name ASC, p.name ASC;

/*
Explanation:
This query uses explicit INNER JOIN syntax, short aliases, qualified columns,
and clear output aliases. That keeps the relationship easy to review.

Expected output:
The query returns all eight products with their category names.

Performance notes:
Clear SQL is easier to tune. PostgreSQL can use the products.category_id index
for joins as the table grows.

Common mistakes:
- Using old comma join syntax.
- Using aliases that are too short to understand in larger queries.
- Selecting unqualified id or name columns after joining tables.

Challenge exercise:
Write a best-practice join that lists order IDs with customer email.

Challenge solution:
*/

SELECT
    o.id AS order_id,
    u.email AS customer_email,
    o.status,
    o.order_date
FROM orders AS o
INNER JOIN users AS u
    ON u.id = o.user_id
ORDER BY o.order_date DESC;

/*
Related chapters:
- ../01_basic_queries/README.md
- ../02_filtering_sorting/README.md
- README.md
*/
