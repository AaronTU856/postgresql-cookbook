/*
Title: FULL OUTER JOIN Orders and Payments
Difficulty: Intermediate

Learning Objectives:
- Use FULL OUTER JOIN to preserve rows from both tables.
- Identify matched and unmatched records.
- Understand why full joins are useful for reconciliation.

Problem Statement:
Finance wants to reconcile orders and payments so unmatched records would be
visible on either side.

Business Scenario:
Payment reconciliation needs to find orders without payments and payments that
do not map cleanly to orders. The current sample data is clean, but the query
shows the auditing pattern.

SQL Solution:
*/

SELECT
    orders.id AS order_id,
    orders.status AS order_status,
    payments.id AS payment_id,
    payments.status AS payment_status,
    payments.amount
FROM orders
FULL OUTER JOIN payments
    ON payments.order_id = orders.id
ORDER BY orders.id NULLS LAST, payments.id NULLS LAST;

/*
Explanation:
FULL OUTER JOIN returns matched rows plus unmatched rows from both tables. If an
order had no payment, payment columns would be NULL. If a payment had no order,
order columns would be NULL.

Expected Output:
The sample data returns seven matched order-payment rows because every order has
one payment.

Performance Notes:
FULL OUTER JOIN can be more expensive than INNER JOIN or LEFT JOIN. Use it when
the business question genuinely needs unmatched rows from both sides.

Common Mistakes:
- Using FULL OUTER JOIN when INNER JOIN is enough.
- Forgetting to check for NULLs to find unmatched records.
- Sorting nullable join outputs without specifying NULL placement.

Challenge Exercise:
Use FULL OUTER JOIN to compare categories and products.

Challenge Solution:
*/

SELECT
    categories.id AS category_id,
    categories.name AS category_name,
    products.id AS product_id,
    products.name AS product_name
FROM categories
FULL OUTER JOIN products
    ON products.category_id = categories.id
ORDER BY categories.id NULLS LAST, products.id NULLS LAST;

/*
Related Chapters:
- ../01_basic_queries/README.md
- ../02_filtering_sorting/README.md
- README.md
*/
