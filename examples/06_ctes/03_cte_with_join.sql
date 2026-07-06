/*
Title: CTE With Join
Difficulty: Intermediate

Learning objectives:
- Use a CTE to define a filtered row set.
- Join the CTE to another table.
- Keep join queries readable.

Problem statement:
Support wants completed payments with customer email and order date.

SQL solution:
*/

WITH completed_payments AS (
    SELECT
        id,
        order_id,
        amount,
        payment_method
    FROM payments
    WHERE status = 'completed'
)
SELECT
    completed_payments.id AS payment_id,
    users.email AS customer_email,
    orders.order_date,
    completed_payments.amount,
    completed_payments.payment_method
FROM completed_payments
INNER JOIN orders
    ON orders.id = completed_payments.order_id
INNER JOIN users
    ON users.id = orders.user_id
ORDER BY orders.order_date DESC;

/*
Explanation:
The CTE defines completed payments first. The outer query joins those payments
to orders and users for customer context.

Expected results:
The query returns completed payments with the related customer email and order
date.

Real-world example:
Support and finance teams often need payment records enriched with customer
details.

Performance notes:
Filtering to completed payments first can make the business intent clear. Check
query plans on larger datasets to confirm the best execution shape.

Common mistakes:
- Joining the CTE on the wrong key.
- Selecting unqualified id columns in joined output.
- Putting unrelated filtering logic in the outer query when it belongs in the
  CTE.

Challenge exercise:
Create a CTE for active products and join it to categories.

Challenge solution:
*/

WITH active_products AS (
    SELECT
        id,
        category_id,
        name,
        price
    FROM products
    WHERE is_active = TRUE
)
SELECT
    active_products.id AS product_id,
    active_products.name AS product_name,
    categories.name AS category_name,
    active_products.price
FROM active_products
INNER JOIN categories
    ON categories.id = active_products.category_id
ORDER BY categories.name ASC, active_products.name ASC;

/*
Related examples:
- ../03_joins/01_inner_join.sql
- ../05_subqueries/09_subquery_in_from.sql
- 04_cte_with_aggregation.sql
*/
