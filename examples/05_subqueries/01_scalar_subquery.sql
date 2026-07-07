/*
Title: Scalar Subquery
Difficulty: Beginner

Learning Objectives:
- Use a subquery that returns one value.
- Compare product prices with the overall average price.
- Understand where scalar subqueries fit in filtering logic.

Problem Statement:
The merchandising team wants products priced above the average product price.

SQL Solution:
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

Expected Output:
The query returns products priced above the overall average product price.

Business Scenario:
A merchandising dashboard may highlight premium products priced above the
catalogue average.

Performance Notes:
PostgreSQL can calculate a non-correlated scalar subquery once and reuse the
value. For larger datasets, indexes and summary tables may help recurring price
reports.

Common Mistakes:
- Writing a scalar subquery that accidentally returns more than one row.
- Forgetting parentheses around the subquery.
- Comparing incompatible data types.

Challenge Exercise:
Find payments larger than the average payment amount.

Challenge Solution:
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
Related Chapters:
- ../04_aggregates/03_avg.sql
- ../02_filtering_sorting/04_comparison_operators.sql
- 04_correlated_subquery.sql
*/
