/*
Title: Correlated Subquery
Difficulty: Intermediate

Learning objectives:
- Write a subquery that references the outer query.
- Compare products with their category average price.
- Understand row-by-row subquery logic.

Problem statement:
The merchandising team wants products priced above the average price in their
own category.

SQL solution:
*/

SELECT
    products.name,
    products.category_id,
    products.price
FROM products
WHERE products.price > (
    SELECT
        AVG(category_products.price)
    FROM products AS category_products
    WHERE category_products.category_id = products.category_id
)
ORDER BY products.category_id ASC, products.price DESC;

/*
Explanation:
The subquery refers to products.category_id from the outer query. For each
product, PostgreSQL calculates the average price of products in the same
category and compares the current product price with that average.

Expected results:
The query returns the higher-priced product from each category.

Real-world example:
Merchandising teams may use this pattern to find premium products within each
category rather than across the whole catalogue.

Performance notes:
Correlated subqueries can be expensive because they depend on each outer row.
Indexes on referenced columns can help, and a join with aggregation may be
clearer for larger reports.

Common mistakes:
- Forgetting to alias the inner table.
- Accidentally comparing each product to the overall average instead of its
  category average.
- Writing correlated logic that is better expressed as a join.

Challenge exercise:
Find payments above the average payment amount for their payment method.

Challenge solution:
*/

SELECT
    payments.id,
    payments.payment_method,
    payments.amount
FROM payments
WHERE payments.amount > (
    SELECT
        AVG(method_payments.amount)
    FROM payments AS method_payments
    WHERE method_payments.payment_method = payments.payment_method
)
ORDER BY payments.payment_method ASC, payments.amount DESC;

/*
Related examples:
- ../04_aggregates/09_aggregate_with_join.sql
- 01_scalar_subquery.sql
- 10_subquery_vs_join.sql
*/
