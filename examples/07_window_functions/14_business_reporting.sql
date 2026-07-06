/*
Title: Business Reporting With Window Functions
Difficulty: Intermediate

Learning objectives:
- Combine joins, aggregation, and window functions.
- Rank customers by completed payment value.
- Add total report context to each row.

Problem statement:
Leadership wants customers ranked by completed payment value, with each
customer's share of completed payment value.

SQL solution:
*/

WITH customer_payments AS (
    SELECT
        users.email,
        SUM(payments.amount) AS completed_payment_total
    FROM users
    INNER JOIN orders
        ON orders.user_id = users.id
    INNER JOIN payments
        ON payments.order_id = orders.id
    WHERE payments.status = 'completed'
    GROUP BY users.email
)
SELECT
    email,
    completed_payment_total,
    RANK() OVER (
        ORDER BY completed_payment_total DESC
    ) AS customer_value_rank,
    ROUND(
        completed_payment_total
        / SUM(completed_payment_total) OVER ()
        * 100,
        2
    ) AS percentage_of_completed_payments
FROM customer_payments
ORDER BY customer_value_rank ASC, email ASC;

/*
Explanation:
The CTE calculates completed payment totals by customer. The outer query ranks
customers and uses SUM(...) OVER () to calculate the total across the report.

Expected results:
The query returns customers with completed payments, ranked by completed payment
total and showing their percentage of the report total.

Real-world example:
Leadership reports often rank customers, products, or categories while keeping
each row's contribution to the total visible.

Performance notes:
Window functions are applied after the customer totals are aggregated, which
keeps the window calculation smaller and clearer.

Common mistakes:
- Ranking raw payments instead of customer totals.
- Dividing by an integer total in other SQL systems without checking numeric
  behaviour.
- Forgetting that refunded or pending payments need separate business rules.

Challenge exercise:
Rank categories by completed revenue using order item prices.

Challenge solution:
*/

WITH category_revenue AS (
    SELECT
        categories.name AS category_name,
        SUM(order_items.quantity * order_items.unit_price) AS completed_revenue
    FROM categories
    INNER JOIN products
        ON products.category_id = categories.id
    INNER JOIN order_items
        ON order_items.product_id = products.id
    INNER JOIN orders
        ON orders.id = order_items.order_id
    INNER JOIN payments
        ON payments.order_id = orders.id
    WHERE payments.status = 'completed'
    GROUP BY categories.name
)
SELECT
    category_name,
    completed_revenue,
    DENSE_RANK() OVER (
        ORDER BY completed_revenue DESC
    ) AS revenue_rank
FROM category_revenue
ORDER BY revenue_rank ASC, category_name ASC;

/*
Related examples:
- ../03_joins/12_real_world_reporting.sql
- ../04_aggregates/10_business_reports.sql
- ../06_ctes/08_cte_for_reporting.sql
*/
