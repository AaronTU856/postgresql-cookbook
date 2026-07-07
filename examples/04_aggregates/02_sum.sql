/*
Title: Calculate Totals With SUM
Difficulty: Beginner

Learning Objectives:
- Use SUM() to add numeric values.
- Calculate total payment amount.
- Filter rows before aggregating.

Problem Statement:
Finance wants the total value of completed payments.

SQL Solution:
*/

SELECT
    SUM(amount) AS completed_payment_total
FROM payments
WHERE status = 'completed';

/*
Explanation:
SUM(amount) adds the amount values from rows that pass the WHERE filter. This
query only includes completed payments.

Expected Output:
The query returns one row with the total completed payment amount.

Business Scenario:
A finance report may use this pattern to summarise completed revenue for a
period.

Performance Notes:
Filtering before SUM reduces the rows PostgreSQL needs to aggregate. Indexes on
common filter columns can help larger reporting tables.

Common Mistakes:
- Summing all payments without checking payment status.
- Forgetting that SUM returns NULL when no rows match.
- Summing formatted text instead of numeric columns.

Challenge Exercise:
Calculate the total number of items sold across all order items.

Challenge Solution:
*/

SELECT
    SUM(quantity) AS total_items_sold
FROM order_items;

/*
Related Chapters:
- ../02_filtering_sorting/04_comparison_operators.sql
- ../03_joins/12_real_world_reporting.sql
- 09_aggregate_with_join.sql
*/
