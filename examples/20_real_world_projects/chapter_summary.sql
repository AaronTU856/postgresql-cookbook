/*
Title: Real World Projects Chapter Summary
Difficulty: Advanced

Learning Objectives:
- Combine reporting, JSON, and API design in one production-style query.
- Build a portfolio-ready SQL example.
- Review how multiple cookbook chapters support real backend features.

Problem Statement:
Create an executive API response that summarizes revenue, top categories, and recent orders.

Business Scenario:
A backend service powers an admin dashboard landing page with high-level store health metrics.

SQL Solution:
*/

WITH completed_payments AS (
    SELECT
        o.id AS order_id,
        o.order_date,
        u.email,
        p.amount
    FROM payments AS p
    INNER JOIN orders AS o
        ON o.id = p.order_id
    INNER JOIN users AS u
        ON u.id = o.user_id
    WHERE p.status = 'completed'
),
revenue_summary AS (
    SELECT
        COUNT(*) AS completed_orders,
        COUNT(DISTINCT email) AS paying_customers,
        SUM(amount) AS total_revenue,
        ROUND(AVG(amount), 2) AS average_order_value
    FROM completed_payments
),
category_revenue AS (
    SELECT
        c.name AS category_name,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM order_items AS oi
    INNER JOIN products AS p
        ON p.id = oi.product_id
    INNER JOIN categories AS c
        ON c.id = p.category_id
    INNER JOIN orders AS o
        ON o.id = oi.order_id
    INNER JOIN payments AS pay
        ON pay.order_id = o.id
    WHERE pay.status = 'completed'
    GROUP BY c.name
    ORDER BY revenue DESC
    LIMIT 3
),
recent_orders AS (
    SELECT
        order_id,
        email,
        order_date,
        amount
    FROM completed_payments
    ORDER BY order_date DESC
    LIMIT 5
)
SELECT jsonb_build_object(
    'summary', (
        SELECT to_jsonb(revenue_summary)
        FROM revenue_summary
    ),
    'top_categories', (
        SELECT jsonb_agg(
            jsonb_build_object(
                'category', category_name,
                'revenue', revenue
            )
            ORDER BY revenue DESC
        )
        FROM category_revenue
    ),
    'recent_orders', (
        SELECT jsonb_agg(
            jsonb_build_object(
                'order_id', order_id,
                'customer_email', email,
                'order_date', order_date,
                'amount', amount
            )
            ORDER BY order_date DESC
        )
        FROM recent_orders
    )
) AS admin_dashboard_response;

/*
Explanation:
The summary query ties together joins, aggregates, CTEs, JSONB response shaping, ordering, and payment-aware revenue filtering.

Expected Output:
One JSONB document with summary metrics, top categories, and recent completed orders.

Performance Notes:
For production dashboards, materialize expensive summaries, index filter columns, and avoid recalculating large historical reports on every page load.

Common Mistakes:
- Treating refunded payments as revenue.
- Returning many rows when the dashboard only needs a summary.
- Hiding complex business logic in application loops instead of reviewing it as SQL.

Challenge Exercise:
Add a `generated_at` timestamp to the JSON response.

Challenge Solution:
Add `'generated_at', NOW()` as another key-value pair inside the top-level `jsonb_build_object`.

Related Chapters:
- Chapter 4 - Aggregation
- Chapter 6 - Common Table Expressions
- Chapter 13 - Performance
- Chapter 14 - JSONB
*/
