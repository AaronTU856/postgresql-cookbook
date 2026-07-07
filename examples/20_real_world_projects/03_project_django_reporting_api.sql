/*
Title: Project - Django Reporting API Response
Difficulty: Advanced

Learning Objectives:
- Shape relational data into an API-friendly JSON document.
- Use CTEs to keep endpoint SQL readable.
- Connect PostgreSQL query design to Django REST Framework responses.

Problem Statement:
Build the SQL behind an order summary endpoint for a customer account page.

Business Scenario:
A Django API needs to return a customer's recent orders with payment status and order totals.

SQL Solution:
*/

WITH selected_customer AS (
    SELECT id
    FROM users
    WHERE email = 'amelia.clark@example.com'
),
order_totals AS (
    SELECT
        o.id AS order_id,
        o.status AS order_status,
        o.order_date,
        p.status AS payment_status,
        COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS order_total
    FROM orders AS o
    INNER JOIN selected_customer AS sc
        ON sc.id = o.user_id
    LEFT JOIN order_items AS oi
        ON oi.order_id = o.id
    LEFT JOIN payments AS p
        ON p.order_id = o.id
    GROUP BY
        o.id,
        o.status,
        o.order_date,
        p.status
)
SELECT jsonb_build_object(
    'customer_email', 'amelia.clark@example.com',
    'orders', COALESCE(
        jsonb_agg(
            jsonb_build_object(
                'order_id', order_id,
                'order_status', order_status,
                'payment_status', payment_status,
                'order_total', order_total,
                'order_date', order_date
            )
            ORDER BY order_date DESC
        ),
        '[]'::jsonb
    )
) AS api_response
FROM order_totals;

/*
Explanation:
The SQL returns one JSON object that could be serialized by a backend endpoint. It avoids an N+1 pattern by loading orders, items, and payments in one query.

Expected Output:
One JSON document containing Amelia Clark's recent orders, payment statuses, totals, and dates.

Performance Notes:
Use indexes on `users.email`, `orders.user_id`, `order_items.order_id`, and `payments.order_id`. The sample schema already includes most relationship indexes.

Common Mistakes:
- Fetching orders first and then issuing one query per order for items.
- Returning raw internal rows when the endpoint needs a stable response contract.
- Forgetting `COALESCE` when JSON arrays may be empty.

Challenge Exercise:
Add `shipping_city` to each order object.

Challenge Solution:
Select `o.shipping_city`, add it to the `GROUP BY`, and include `'shipping_city', shipping_city` in `jsonb_build_object`.

Related Chapters:
- Chapter 6 - Common Table Expressions
- Chapter 14 - JSONB
- Chapter 18 - Django Integration
*/
