/*
Title: LEFT JOIN Users to Orders
Difficulty: Beginner

Learning objectives:
- Use LEFT JOIN to keep all rows from the left table.
- Show customer records even when related rows may be missing.
- Understand how unmatched right-side rows appear as NULL.

Problem statement:
The customer success team wants a customer list with any orders attached.

Business scenario:
In a real store, some customers may register before placing an order. A LEFT
JOIN keeps those customers visible in onboarding or follow-up reports.

SQL solution:
*/

SELECT
    users.id AS user_id,
    users.first_name,
    users.last_name,
    orders.id AS order_id,
    orders.status,
    orders.order_date
FROM users
LEFT JOIN orders
    ON orders.user_id = users.id
ORDER BY users.id ASC, orders.order_date DESC;

/*
Explanation:
LEFT JOIN returns every row from users. When a matching order exists, order
columns are filled in. If no order exists, the order columns would be NULL.

Expected output:
The sample data returns every user. Amelia Clark appears twice because she has
two orders; other users appear once.

Performance notes:
LEFT JOIN is useful for completeness reports, but it can multiply rows when the
right table has many matches per left row.

Common mistakes:
- Expecting one row per user when users may have multiple orders.
- Adding WHERE orders.status = 'paid' and accidentally removing users without
  matching paid orders.
- Forgetting that unmatched right-side columns become NULL.

Challenge exercise:
List all categories with any products attached.

Challenge solution:
*/

SELECT
    categories.id AS category_id,
    categories.name AS category_name,
    products.id AS product_id,
    products.name AS product_name
FROM categories
LEFT JOIN products
    ON products.category_id = categories.id
ORDER BY categories.name ASC, products.name ASC;

/*
Related chapters:
- ../01_basic_queries/README.md
- ../02_filtering_sorting/README.md
- README.md
*/
