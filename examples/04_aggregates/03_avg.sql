/*
Title: Calculate Averages With AVG
Difficulty: Beginner

Learning Objectives:
- Use AVG() to calculate mean values.
- Round numeric output for readable reports.
- Apply averages to product and payment data.

Problem Statement:
The merchandising team wants to know the average active product price.

SQL Solution:
*/

SELECT
    ROUND(AVG(price), 2) AS average_active_product_price
FROM products
WHERE is_active = TRUE;

/*
Explanation:
AVG(price) calculates the mean price for active products. ROUND(..., 2) formats
the result to two decimal places.

Expected Output:
The query returns one row with the average active product price.

Business Scenario:
Merchandising teams may track average product price to understand catalogue
positioning.

Performance Notes:
AVG must read the matching numeric values. On large tables, useful filters and
summary tables may help recurring reports.

Common Mistakes:
- Averaging values without applying the needed business filter.
- Forgetting that AVG ignores NULL values.
- Rounding too early before further calculations.

Challenge Exercise:
Calculate the average completed payment amount.

Challenge Solution:
*/

SELECT
    ROUND(AVG(amount), 2) AS average_completed_payment
FROM payments
WHERE status = 'completed';

/*
Related Chapters:
- ../02_filtering_sorting/04_comparison_operators.sql
- 02_sum.sql
- 05_group_by.sql
*/
