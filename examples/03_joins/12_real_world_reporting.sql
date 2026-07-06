/*
Title: Real-World Category Revenue Report
Difficulty: Intermediate

Learning objectives:
- Build a practical reporting query with several joins.
- Calculate revenue by product category.
- Filter report rows by payment status.

Problem statement:
The business team wants completed revenue by product category.

Business scenario:
Leadership needs a category-level revenue report that includes only completed
payments and uses the price captured on each order item.

SQL solution:
*/

SELECT
    c.name AS category_name,
    SUM(oi.quantity * oi.unit_price) AS completed_revenue,
    COUNT(DISTINCT o.id) AS order_count,
    SUM(oi.quantity) AS units_sold
FROM categories AS c
INNER JOIN products AS p
    ON p.category_id = c.id
INNER JOIN order_items AS oi
    ON oi.product_id = p.id
INNER JOIN orders AS o
    ON o.id = oi.order_id
INNER JOIN payments AS pay
    ON pay.order_id = o.id
WHERE pay.status = 'completed'
GROUP BY c.name
ORDER BY completed_revenue DESC;

/*
Explanation:
The query joins categories to products, products to order items, order items to
orders, and orders to payments. It filters to completed payments before grouping
revenue by category.

Expected output:
The query returns category-level completed revenue, order counts, and units
sold. Electronics is the highest revenue category in the sample data.

Performance notes:
Reports that join and aggregate several tables should be tested with realistic
data volumes. Indexes on join keys are important, and frequent reports may later
benefit from summary tables or materialized views.

Common mistakes:
- Calculating revenue from current product price instead of order item unit
  price.
- Counting orders without DISTINCT after joining order items.
- Including refunded or pending payments in completed revenue.

Challenge exercise:
Create a customer revenue report for completed payments.

Challenge solution:
*/

SELECT
    u.email AS customer_email,
    COUNT(DISTINCT o.id) AS completed_order_count,
    SUM(pay.amount) AS completed_payment_total
FROM users AS u
INNER JOIN orders AS o
    ON o.user_id = u.id
INNER JOIN payments AS pay
    ON pay.order_id = o.id
WHERE pay.status = 'completed'
GROUP BY u.email
ORDER BY completed_payment_total DESC;

/*
Related chapters:
- ../01_basic_queries/README.md
- ../02_filtering_sorting/README.md
- README.md
*/
