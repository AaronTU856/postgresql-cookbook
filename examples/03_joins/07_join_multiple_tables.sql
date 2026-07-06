/*
Title: Join Multiple Tables for Order Details
Difficulty: Intermediate

Learning objectives:
- Join more than two tables in one query.
- Follow relationships from orders to users, order items, products, and
  categories.
- Produce readable order line item output.

Problem statement:
The operations team needs detailed order lines with customer, product, category,
quantity, and price information.

Business scenario:
Order detail pages and fulfilment exports usually need data from several
related tables, not just the orders table.

SQL solution:
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

Expected output:
The query returns twelve order line rows, one for each row in order_items, with
customer and product context added.

Performance notes:
Multi-table joins depend heavily on indexes on foreign-key columns. This schema
includes indexes on the main join columns used here.

Common mistakes:
- Joining tables in a way that skips the relationship table, such as orders
  directly to products.
- Selecting ambiguous id columns without aliases.
- Forgetting that one order can have multiple order items.

Challenge exercise:
Add payment status to the order detail report.

Challenge solution:
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
Related chapters:
- ../01_basic_queries/README.md
- ../02_filtering_sorting/README.md
- README.md
*/
