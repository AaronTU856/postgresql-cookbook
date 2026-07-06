/*
Title: Scalar Subquery
Difficulty: Beginner

Learning objectives:
- Use a subquery that returns one value.
- Compare product prices with the overall average price.
- Understand where scalar subqueries fit in filtering logic.

Problem statement:
The merchandising team wants products priced above the average product price.

SQL solution:
*/

SELECT
    name,
    price
FROM products
WHERE price > (
    SELECT
        AVG(price)
    FROM products
)
ORDER BY price DESC;

/*
Explanation:
The subquery calculates one value: the average product price. The outer query
then returns products whose price is greater than that value.

Expected results:
The query returns products priced above the overall average product price.

Real-world example:
A merchandising dashboard may highlight premium products priced above the
catalogue average.

Performance notes:
PostgreSQL can calculate a non-correlated scalar subquery once and reuse the
value. For larger datasets, indexes and summary tables may help recurring price
reports.

Common mistakes:
- Writing a scalar subquery that accidentally returns more than one row.
- Forgetting parentheses around the subquery.
- Comparing incompatible data types.

Challenge exercise:
Find payments larger than the average payment amount.

Challenge solution:
*/

SELECT
    id,
    order_id,
    amount,
    status
FROM payments
WHERE amount > (
    SELECT
        AVG(amount)
    FROM payments
)
ORDER BY amount DESC;

/*
Related examples:
- ../04_aggregates/03_avg.sql
- ../02_filtering_sorting/04_comparison_operators.sql
- 04_correlated_subquery.sql
*/
