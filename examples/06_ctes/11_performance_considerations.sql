/*
Title: CTE Performance Considerations
Difficulty: Intermediate

Learning Objectives:
- Use CTEs for readability without assuming speed.
- Filter data before aggregation.
- Understand when to inspect query plans.

Problem Statement:
Finance wants completed payment totals by payment method, with the completed
payment set clearly defined first.

SQL Solution:
*/

WITH completed_payments AS (
    SELECT
        payment_method,
        amount
    FROM payments
    WHERE status = 'completed'
)
SELECT
    payment_method,
    COUNT(*) AS payment_count,
    SUM(amount) AS payment_total
FROM completed_payments
GROUP BY payment_method
ORDER BY payment_total DESC;

/*
Explanation:
The CTE filters to completed payments. The outer query groups that smaller,
business-defined set by payment method.

Expected Output:
The query returns completed payment count and total by payment method.

Business Scenario:
Finance reporting commonly filters to valid business events before aggregating
them.

Performance Notes:
CTEs are not performance hints by default. Use them to clarify the query, then
use EXPLAIN if the report becomes slow.

Common Mistakes:
- Assuming CTEs always materialise or always inline.
- Using CTEs to hide inefficient filters.
- Forgetting indexes on columns used for filtering and joining.

Challenge Exercise:
Filter active products in a CTE, then calculate average price by category_id.

Challenge Solution:
*/

WITH active_products AS (
    SELECT
        category_id,
        price
    FROM products
    WHERE is_active = TRUE
)
SELECT
    category_id,
    ROUND(AVG(price), 2) AS average_price
FROM active_products
GROUP BY category_id
ORDER BY category_id ASC;

/*
Related Chapters:
- ../04_aggregates/06_group_by_multiple_columns.sql
- 04_cte_with_aggregation.sql
- 09_cte_best_practices.sql
*/
