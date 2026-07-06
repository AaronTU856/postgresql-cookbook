/*
Title: Subqueries Chapter Summary
Difficulty: Intermediate

Learning objectives:
- Combine derived tables with joins.
- Summarise customer order and payment activity.
- Review practical subquery patterns from this chapter.

Problem statement:
Customer success wants a customer summary with order count and completed payment
total.

SQL solution:
*/

SELECT
    users.email,
    COALESCE(order_summary.order_count, 0) AS order_count,
    COALESCE(payment_summary.completed_payment_total, 0) AS completed_payment_total
FROM users
LEFT JOIN (
    SELECT
        user_id,
        COUNT(*) AS order_count
    FROM orders
    GROUP BY user_id
) AS order_summary
    ON order_summary.user_id = users.id
LEFT JOIN (
    SELECT
        orders.user_id,
        SUM(payments.amount) AS completed_payment_total
    FROM orders
    INNER JOIN payments
        ON payments.order_id = orders.id
    WHERE payments.status = 'completed'
    GROUP BY orders.user_id
) AS payment_summary
    ON payment_summary.user_id = users.id
ORDER BY completed_payment_total DESC, users.email ASC;

/*
Explanation:
The query uses two subqueries in FROM. One summarises order counts by user. The
other summarises completed payment totals by user. The outer query joins both
summaries back to users.

Expected results:
The query returns every user with an order count and completed payment total.

Real-world example:
Customer dashboards often combine account details with calculated summary
metrics.

Performance notes:
Pre-aggregating in derived tables can make reports easier to reason about and
can avoid row multiplication. Check query plans for larger datasets.

Common mistakes:
- Joining raw orders and payments directly to users and accidentally multiplying
  totals.
- Forgetting COALESCE when a left-joined summary may be missing.
- Grouping by the wrong key inside the summary subquery.

Challenge exercise:
Build a product summary with total quantity sold using a subquery in FROM.

Challenge solution:
*/

SELECT
    products.name,
    COALESCE(product_summary.total_quantity_sold, 0) AS total_quantity_sold
FROM products
LEFT JOIN (
    SELECT
        product_id,
        SUM(quantity) AS total_quantity_sold
    FROM order_items
    GROUP BY product_id
) AS product_summary
    ON product_summary.product_id = products.id
ORDER BY total_quantity_sold DESC, products.name ASC;

/*
Related examples:
- 08_subquery_in_select.sql
- 09_subquery_in_from.sql
- ../04_aggregates/10_business_reports.sql
*/
