/*
Title: Multiple CTEs
Difficulty: Intermediate

Learning Objectives:
- Define more than one CTE in a query.
- Use one CTE as input to another CTE.
- Build a report in readable steps.

Problem Statement:
Finance wants completed payments above the average completed payment amount.

SQL Solution:
*/

WITH completed_payments AS (
    SELECT
        id,
        order_id,
        amount
    FROM payments
    WHERE status = 'completed'
),
average_completed_payment AS (
    SELECT
        AVG(amount) AS average_amount
    FROM completed_payments
)
SELECT
    completed_payments.id,
    completed_payments.order_id,
    completed_payments.amount
FROM completed_payments
CROSS JOIN average_completed_payment
WHERE completed_payments.amount > average_completed_payment.average_amount
ORDER BY completed_payments.amount DESC;

/*
Explanation:
The first CTE filters completed payments. The second CTE calculates their
average amount. The final query returns completed payments above that average.

Expected Output:
The query returns completed payments whose amount is higher than the completed
payment average.

Business Scenario:
Finance reports often define a clean payment set first, then calculate summary
thresholds from that set.

Performance Notes:
Multiple CTEs can make a report clearer, but each step should have a purpose.
Avoid long chains of CTEs that hide simple logic.

Common Mistakes:
- Forgetting the comma between CTE definitions.
- Referencing a CTE before it is defined.
- Selecting columns that were not exposed by the CTE.

Challenge Exercise:
Find active products priced above the average active product price.

Challenge Solution:
*/

WITH active_products AS (
    SELECT
        id,
        name,
        price
    FROM products
    WHERE is_active = TRUE
),
average_active_price AS (
    SELECT
        AVG(price) AS average_price
    FROM active_products
)
SELECT
    active_products.id,
    active_products.name,
    active_products.price
FROM active_products
CROSS JOIN average_active_price
WHERE active_products.price > average_active_price.average_price
ORDER BY active_products.price DESC;

/*
Related Chapters:
- ../04_aggregates/03_avg.sql
- ../05_subqueries/01_scalar_subquery.sql
- 01_basic_cte.sql
*/
