/*
Title: Avoid N+1 Queries In Django
Difficulty: Intermediate

Learning objectives:
- Recognise N+1 query patterns.
- Use set-based SQL for related collections.
- Understand why prefetch_related exists.

Problem statement:
A product detail page needs product data and order item counts without running a
query per product.

Business scenario:
Django pages often loop over objects. Without prefetching or aggregation, each
loop iteration may trigger another query.

SQL solution:
*/

SELECT
    products.id AS product_id,
    products.name,
    COUNT(order_items.id) AS order_item_count
FROM products
LEFT JOIN order_items
    ON order_items.product_id = products.id
GROUP BY
    products.id,
    products.name
ORDER BY products.name ASC;

/*
Explanation:
One grouped query returns product rows and related order item counts. In Django,
similar problems are solved with annotate, prefetch_related, or explicit
querysets.

Expected output:
Each product appears with the number of order item rows referencing it.

Performance considerations:
Avoiding N+1 queries can dramatically reduce database round trips for list
views.

Common mistakes:
- Accessing related objects inside templates without prefetching.
- Fixing N+1 with too many joins that duplicate rows.
- Ignoring query counts during API testing.

Challenge:
Return each customer with their order count in one query.

Challenge solution:
*/

SELECT
    users.email,
    COUNT(orders.id) AS order_count
FROM users
LEFT JOIN orders
    ON orders.user_id = users.id
GROUP BY users.email
ORDER BY order_count DESC, users.email ASC;

/*
Related chapters:
- ../04_aggregates/09_aggregate_with_join.sql
- ../13_performance/04_avoid_n_plus_one.sql
- 04_annotate_aggregate.sql
*/
