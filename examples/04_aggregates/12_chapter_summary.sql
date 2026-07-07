/*
Title: Aggregation Chapter Summary
Difficulty: Intermediate

Learning Objectives:
- Combine COUNT, SUM, AVG, MIN, and MAX in one report.
- Summarise payment activity by status.
- Review the main aggregation patterns from this chapter.

Problem Statement:
Finance wants a compact summary of payment activity by payment status.

SQL Solution:
*/

SELECT
    status,
    COUNT(*) AS payment_count,
    SUM(amount) AS total_amount,
    ROUND(AVG(amount), 2) AS average_amount,
    MIN(amount) AS smallest_payment,
    MAX(amount) AS largest_payment
FROM payments
GROUP BY status
ORDER BY status ASC;

/*
Explanation:
This query groups payments by status and calculates several aggregate values for
each group. It combines the core aggregate functions from the chapter.

Expected Output:
The query returns one row per payment status with count, total, average, minimum,
and maximum amount values.

Business Scenario:
A finance dashboard may show payment status summaries to monitor completed,
pending, refunded, or failed payments.

Performance Notes:
Multi-aggregate reports are common. PostgreSQL can calculate several aggregate
values in one grouped pass over the matching rows.

Common Mistakes:
- Forgetting GROUP BY when selecting status with aggregate functions.
- Using aggregate aliases in HAVING instead of repeating the aggregate
  expression when needed.
- Comparing payment statuses without understanding the business workflow.

Challenge Exercise:
Create a product stock summary by active status.

Challenge Solution:
*/

SELECT
    is_active,
    COUNT(*) AS product_count,
    SUM(stock_quantity) AS total_stock,
    ROUND(AVG(price), 2) AS average_price,
    MIN(price) AS lowest_price,
    MAX(price) AS highest_price
FROM products
GROUP BY is_active
ORDER BY is_active DESC;

/*
Related Chapters:
- 01_count.sql
- 05_group_by.sql
- 10_business_reports.sql
*/
