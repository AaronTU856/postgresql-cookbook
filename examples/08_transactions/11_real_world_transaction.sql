/*
Title: Real-World Transaction
Difficulty: Advanced

Learning Objectives:
- Combine order, order item, payment, and stock changes.
- Use a transaction for an e-commerce checkout workflow.
- Roll back a full workflow safely during practice.

Problem Statement:
Build a checkout transaction that creates an order, adds an item, records a
payment, and reduces stock as one unit of work.

SQL Solution:
*/

BEGIN;

WITH locked_product AS (
    SELECT
        id,
        price
    FROM products
    WHERE id = 3
      AND stock_quantity >= 2
    FOR UPDATE
),
new_order AS (
    INSERT INTO orders (
        user_id,
        status,
        order_date,
        shipping_city,
        shipping_country
    )
    SELECT
        1,
        'paid',
        NOW(),
        'Manchester',
        'United Kingdom'
    FROM locked_product
    RETURNING id
),
new_order_item AS (
    INSERT INTO order_items (
        order_id,
        product_id,
        quantity,
        unit_price
    )
    SELECT
        new_order.id,
        locked_product.id,
        2,
        locked_product.price
    FROM new_order
    CROSS JOIN locked_product
    RETURNING order_id, quantity, unit_price
),
stock_update AS (
    UPDATE products
    SET stock_quantity = stock_quantity - 2
    WHERE id = 3
    RETURNING id, stock_quantity
),
new_payment AS (
    INSERT INTO payments (
        order_id,
        amount,
        payment_method,
        status,
        paid_at
    )
    SELECT
        new_order_item.order_id,
        new_order_item.quantity * new_order_item.unit_price,
        'card',
        'completed',
        NOW()
    FROM new_order_item
    RETURNING order_id, amount, status
)
SELECT
    new_payment.order_id,
    new_payment.amount,
    new_payment.status AS payment_status,
    stock_update.stock_quantity AS remaining_stock
FROM new_payment
CROSS JOIN stock_update;

ROLLBACK;

/*
Explanation:
The transaction locks the product, creates the order, creates the order item,
reduces stock, and records payment. If any step fails, the transaction can be
rolled back so no partial order remains.

Expected Output:
The query returns a new order id, payment amount, completed status, and remaining
stock inside the transaction. ROLLBACK removes the practice checkout.

Business Scenario:
E-commerce checkout must keep order, payment, and inventory data consistent.

Performance Notes:
Keep payment provider calls outside long database transactions where possible.
Lock inventory only for the shortest safe period.

Common Mistakes:
- Creating the payment but not the order item.
- Reducing stock before checking availability.
- Leaving a transaction open while waiting on an external payment service.

Challenge Exercise:
Create a rollback-safe checkout transaction for user 2 buying one unit of
product 7.

Challenge Solution:
*/

BEGIN;

WITH locked_product AS (
    SELECT
        id,
        price
    FROM products
    WHERE id = 7
      AND stock_quantity >= 1
    FOR UPDATE
),
new_order AS (
    INSERT INTO orders (
        user_id,
        status,
        order_date,
        shipping_city,
        shipping_country
    )
    SELECT
        2,
        'paid',
        NOW(),
        'Birmingham',
        'United Kingdom'
    FROM locked_product
    RETURNING id
),
new_order_item AS (
    INSERT INTO order_items (order_id, product_id, quantity, unit_price)
    SELECT
        new_order.id,
        locked_product.id,
        1,
        locked_product.price
    FROM new_order
    CROSS JOIN locked_product
    RETURNING order_id, quantity, unit_price
),
stock_update AS (
    UPDATE products
    SET stock_quantity = stock_quantity - 1
    WHERE id = 7
    RETURNING id, stock_quantity
)
SELECT
    new_order_item.order_id,
    new_order_item.quantity * new_order_item.unit_price AS order_total,
    stock_update.stock_quantity AS remaining_stock
FROM new_order_item
CROSS JOIN stock_update;

ROLLBACK;

/*
Related Chapters:
- 03_savepoints.sql
- 09_locking.sql
- ../06_ctes/08_cte_for_reporting.sql
*/
