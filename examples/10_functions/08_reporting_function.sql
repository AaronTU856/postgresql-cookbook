/*
Title: Reporting Function
Difficulty: Advanced

Learning Objectives:
- Return report-shaped data from a function.
- Use parameters to filter reporting results.
- Combine joins and aggregation inside RETURNS TABLE.

Problem Statement:
Leadership wants a reusable category revenue report with a minimum revenue
filter.

Business Scenario:
Dashboards often need the same report with different thresholds for summary and
detailed views.

SQL Solution:
*/

DROP FUNCTION IF EXISTS cookbook_category_revenue_report(NUMERIC);

CREATE FUNCTION cookbook_category_revenue_report(
    p_min_revenue NUMERIC DEFAULT 0
)
RETURNS TABLE (
    category_name VARCHAR,
    order_count BIGINT,
    gross_revenue NUMERIC
)
LANGUAGE SQL
STABLE
AS $$
    SELECT
        categories.name AS category_name,
        COUNT(DISTINCT orders.id) AS order_count,
        SUM(order_items.quantity * order_items.unit_price) AS gross_revenue
    FROM categories
    INNER JOIN products
        ON products.category_id = categories.id
    INNER JOIN order_items
        ON order_items.product_id = products.id
    INNER JOIN orders
        ON orders.id = order_items.order_id
    GROUP BY categories.name
    HAVING SUM(order_items.quantity * order_items.unit_price) >= p_min_revenue
    ORDER BY gross_revenue DESC;
$$;

SELECT
    category_name,
    order_count,
    gross_revenue
FROM cookbook_category_revenue_report(40);

/*
Explanation:
The function returns a report table and lets callers provide a minimum revenue
threshold. The default value allows callers to omit the filter when needed.

Expected Output:
Categories with gross revenue of at least 40 are returned with order count and
gross revenue.

Performance Notes:
Reporting functions can hide expensive joins and aggregates. For frequent heavy
reports, compare this with a view or materialized view.

Common Mistakes:
- Returning report columns without stable aliases.
- Forgetting that default parameters should still produce useful results.
- Using reporting functions where permissions or freshness require a view.

Challenge Exercise:
Create a reporting function that returns completed payments by payment method
above a minimum total.

Challenge Solution:
*/

DROP FUNCTION IF EXISTS cookbook_payment_method_report(NUMERIC);

CREATE FUNCTION cookbook_payment_method_report(
    p_min_total NUMERIC DEFAULT 0
)
RETURNS TABLE (
    payment_method VARCHAR,
    completed_payment_count BIGINT,
    completed_payment_total NUMERIC
)
LANGUAGE SQL
STABLE
AS $$
    SELECT
        payments.payment_method,
        COUNT(*) AS completed_payment_count,
        SUM(payments.amount) AS completed_payment_total
    FROM payments
    WHERE payments.status = 'completed'
    GROUP BY payments.payment_method
    HAVING SUM(payments.amount) >= p_min_total
    ORDER BY completed_payment_total DESC;
$$;

SELECT
    payment_method,
    completed_payment_count,
    completed_payment_total
FROM cookbook_payment_method_report(40);

/*
Related Chapters:
- ../04_aggregates/07_having.sql
- ../09_views/10_business_reporting_view.sql
- 03_return_table.sql
*/
