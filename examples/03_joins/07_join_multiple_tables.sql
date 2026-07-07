/*
Title: Join Multiple Tables for Order Details
Difficulty: Intermediate

Learning Objectives:
- Join more than two tables in one query.
- Follow relationships from orders to users, order items, products, and
  categories.
- Produce readable order line item output.

Problem Statement:
The operations team needs detailed order lines with customer, product, category,
quantity, and price information.

Business Scenario:
Order detail pages and fulfilment exports usually need data from several
related tables, not just the orders table.

SQL Solution:
*/

SELECT
    orders.id AS order_id,
    users.email AS customer_email,
    categories.name AS category_name,
    products.name AS product_name,
    order_items.quantity,
    order_items.unit_price
FROM orders
INNER JOIN users
    ON users.id = orders.user_id
INNER JOIN order_items
    ON order_items.order_id = orders.id
INNER JOIN products
    ON products.id = order_items.product_id
INNER JOIN categories
    ON categories.id = products.category_id
ORDER BY orders.id ASC, products.name ASC;

/*
Explanation:
Each join follows a foreign-key relationship. The query starts with orders,
joins the customer, then joins line items, products, and product categories.

Expected Output:
The query returns twelve order line rows, one for each row in order_items, with
customer and product context added.

Performance Notes:
Multi-table joins depend heavily on indexes on foreign-key columns. This schema
includes indexes on the main join columns used here.

Common Mistakes:
- Joining tables in a way that skips the relationship table, such as orders
  directly to products.
- Selecting ambiguous id columns without aliases.
- Forgetting that one order can have multiple order items.

Challenge Exercise:
Add payment status to the order detail report.

Challenge Solution:
*/

SELECT
    orders.id AS order_id,
    users.email AS customer_email,
    payments.status AS payment_status,
    products.name AS product_name,
    order_items.quantity,
    order_items.unit_price
FROM orders
INNER JOIN users
    ON users.id = orders.user_id
INNER JOIN payments
    ON payments.order_id = orders.id
INNER JOIN order_items
    ON order_items.order_id = orders.id
INNER JOIN products
    ON products.id = order_items.product_id
ORDER BY orders.id ASC, products.name ASC;

/*
Related Chapters:
- ../01_basic_queries/README.md
- ../02_filtering_sorting/README.md
- README.md
*/
