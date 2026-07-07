/*
Title: Subquery in FROM
Difficulty: Intermediate

Learning Objectives:
- Use a subquery as a derived table.
- Aggregate order item totals before joining.
- Keep reporting logic in clear steps.

Problem Statement:
Operations wants order totals calculated from order items, shown with order
status and date.

SQL Solution:
*/

SELECT
    orders.id AS order_id,
    orders.status,
    orders.order_date,
    order_totals.order_total
FROM orders
INNER JOIN (
    SELECT
        order_id,
        SUM(quantity * unit_price) AS order_total
    FROM order_items
    GROUP BY order_id
) AS order_totals
    ON order_totals.order_id = orders.id
ORDER BY orders.order_date DESC;

/*
Explanation:
The subquery in FROM calculates one row per order_id. The outer query joins
those derived totals back to orders.

Expected Output:
The query returns each order with a calculated order_total.

Business Scenario:
Reporting queries often aggregate line items first, then join the summary back
to orders or customers.

Performance Notes:
Derived tables are useful for readability. PostgreSQL may inline or optimise
them depending on the query, but large reports should still be checked with
EXPLAIN.

Common Mistakes:
- Forgetting to alias the derived table.
- Selecting columns from the subquery that were not produced by it.
- Aggregating at the wrong level of detail.

Challenge Exercise:
Create a derived table of total quantity sold per product and join it to
products.

Challenge Solution:
*/

SELECT
    products.id,
    products.name,
    product_totals.total_quantity_sold
FROM products
INNER JOIN (
    SELECT
        product_id,
        SUM(quantity) AS total_quantity_sold
    FROM order_items
    GROUP BY product_id
) AS product_totals
    ON product_totals.product_id = products.id
ORDER BY product_totals.total_quantity_sold DESC, products.name ASC;

/*
Related Chapters:
- ../04_aggregates/09_aggregate_with_join.sql
- ../03_joins/08_join_with_aggregation.sql
- 08_subquery_in_select.sql
*/
