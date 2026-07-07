/*
Title: Build JSON Responses
Difficulty: Intermediate

Learning Objectives:
- Build JSONB API-shaped responses.
- Combine relational rows into JSON objects.
- Aggregate child rows into JSON arrays.

Problem Statement:
The API needs an order response containing order details and line items.

Business Scenario:
Backend services often transform relational data into JSON responses for web or
mobile clients.

SQL Solution:
*/

SELECT
    jsonb_build_object(
        'order_id', orders.id,
        'status', orders.status,
        'customer_email', users.email,
        'items', jsonb_agg(
            jsonb_build_object(
                'product_name', products.name,
                'quantity', order_items.quantity,
                'unit_price', order_items.unit_price
            )
            ORDER BY products.name
        )
    ) AS order_response
FROM orders
INNER JOIN users
    ON users.id = orders.user_id
INNER JOIN order_items
    ON order_items.order_id = orders.id
INNER JOIN products
    ON products.id = order_items.product_id
WHERE orders.id = 1
GROUP BY
    orders.id,
    orders.status,
    users.email;

/*
Explanation:
jsonb_build_object creates structured JSONB objects, and jsonb_agg groups order
items into an array.

Expected Output:
The query returns one JSONB order response for order 1.

Performance Notes:
Building large JSON responses in SQL can be useful, but very large payloads may
be better streamed or paginated by the application.

Common Mistakes:
- Building deeply nested JSON before confirming the API needs it.
- Forgetting ORDER BY inside jsonb_agg when array order matters.
- Mixing API formatting with unrelated business logic.

Challenge Exercise:
Build a JSONB customer profile containing email, city, and order count.

Challenge Solution:
*/

SELECT
    jsonb_build_object(
        'email', users.email,
        'city', users.city,
        'order_count', COUNT(orders.id)
    ) AS customer_profile
FROM users
LEFT JOIN orders
    ON orders.user_id = users.id
WHERE users.id = 1
GROUP BY users.email, users.city;

/*
Related Chapters:
- ../03_joins/07_join_multiple_tables.sql
- ../04_aggregates/10_business_reports.sql
- 01_create_jsonb_data.sql
*/
