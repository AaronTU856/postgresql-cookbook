/*
Title: Build JSON Responses
Difficulty: Intermediate

Learning objectives:
- Build JSONB API-shaped responses.
- Combine relational rows into JSON objects.
- Aggregate child rows into JSON arrays.

Problem statement:
The API needs an order response containing order details and line items.

Business scenario:
Backend services often transform relational data into JSON responses for web or
mobile clients.

SQL solution:
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

Expected output:
The query returns one JSONB order response for order 1.

Performance considerations:
Building large JSON responses in SQL can be useful, but very large payloads may
be better streamed or paginated by the application.

Common mistakes:
- Building deeply nested JSON before confirming the API needs it.
- Forgetting ORDER BY inside jsonb_agg when array order matters.
- Mixing API formatting with unrelated business logic.

Challenge:
Build a JSONB customer profile containing email, city, and order count.

Challenge solution:
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
Related chapters:
- ../03_joins/07_join_multiple_tables.sql
- ../04_aggregates/10_business_reports.sql
- 01_create_jsonb_data.sql
*/
