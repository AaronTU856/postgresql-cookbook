/*
Title: Calculate Averages With AVG
Difficulty: Beginner

Learning objectives:
- Use AVG() to calculate mean values.
- Round numeric output for readable reports.
- Apply averages to product and payment data.

Problem statement:
The merchandising team wants to know the average active product price.

SQL solution:
*/

SELECT
    ROUND(AVG(price), 2) AS average_active_product_price
FROM products
WHERE is_active = TRUE;

/*
Explanation:
AVG(price) calculates the mean price for active products. ROUND(..., 2) formats
the result to two decimal places.

Expected results:
The query returns one row with the average active product price.

Real-world example:
Merchandising teams may track average product price to understand catalogue
positioning.

Performance notes:
AVG must read the matching numeric values. On large tables, useful filters and
summary tables may help recurring reports.

Common mistakes:
- Averaging values without applying the needed business filter.
- Forgetting that AVG ignores NULL values.
- Rounding too early before further calculations.

Challenge exercise:
Calculate the average completed payment amount.

Challenge solution:
*/

SELECT
    ROUND(AVG(amount), 2) AS average_completed_payment
FROM payments
WHERE status = 'completed';

/*
Related examples:
- ../02_filtering_sorting/04_comparison_operators.sql
- 02_sum.sql
- 05_group_by.sql
*/
