# Chapter 4: Aggregation

## Overview

Aggregate functions summarise many rows into useful business answers. They help you count records, calculate revenue, find averages, identify ranges, and build reports from transactional data.

This chapter uses the online store database to answer practical questions about users, orders, products, categories, and payments.

## Key Concepts

- `COUNT()` counts rows or non-NULL values.
- `SUM()` adds numeric values.
- `AVG()` calculates the mean value.
- `MIN()` finds the smallest value.
- `MAX()` finds the largest value.
- `GROUP BY` creates one result row per group.
- `HAVING` filters grouped results after aggregation.
- `DISTINCT` can be used inside aggregate functions to count unique values.

## Learning Outcomes

After completing this chapter, you should be able to:

- Use core aggregate functions to summarise table data.
- Group rows by one or more columns.
- Filter grouped results with `HAVING`.
- Combine joins and aggregates for business reports.
- Avoid common mistakes with grouping and row multiplication.
- Build simple reporting queries from realistic ecommerce data.

## When to Use Aggregate Functions

Use aggregate functions when the business question asks for a summary rather than individual rows. Common examples include total revenue, average payment amount, product counts by category, and order counts by status.

## GROUP BY Explained

`GROUP BY` tells PostgreSQL how to divide rows before calculating aggregate values. Without `GROUP BY`, an aggregate query usually returns one summary row. With `GROUP BY`, it returns one summary row per group.

For example, grouping orders by `status` lets PostgreSQL count how many orders exist in each status.

## HAVING Explained

`WHERE` filters rows before grouping. `HAVING` filters groups after aggregate values have been calculated.

Use `HAVING` when the condition depends on an aggregate result, such as categories with more than one product or customers with more than one order.

## Business Reporting Examples

- Count orders by status.
- Calculate total completed payment value.
- Find average product price by category.
- Report revenue by category.
- Identify customers with multiple orders.
- Summarise product sales from order items.

## Common Mistakes

- Selecting non-aggregated columns that are not in `GROUP BY`.
- Using `WHERE` instead of `HAVING` for aggregate filters.
- Counting nullable columns when `COUNT(*)` is intended.
- Forgetting that joins can multiply rows before aggregation.
- Summing current product prices instead of historical order item prices.
- Treating refunded, pending, and completed payments as the same business value.

## Recommended Learning Order

1. [COUNT](01_count.sql)
2. [SUM](02_sum.sql)
3. [AVG](03_avg.sql)
4. [MIN and MAX](04_min_max.sql)
5. [GROUP BY](05_group_by.sql)
6. [GROUP BY multiple columns](06_group_by_multiple_columns.sql)
7. [HAVING](07_having.sql)
8. [Distinct aggregates](08_distinct_aggregates.sql)
9. [Aggregate with join](09_aggregate_with_join.sql)
10. [Business reports](10_business_reports.sql)
11. [Common aggregate mistakes](11_common_aggregate_mistakes.sql)
12. [Chapter summary](12_chapter_summary.sql)

## Related Chapters

- [Chapter 2: Filtering & Sorting](../02_filtering_sorting/README.md)
- [Chapter 3: Joins](../03_joins/README.md)
- [Chapter 5: Subqueries](../05_subqueries/README.md)

## Difficulty

Beginner to Intermediate

## Estimated Completion Time

2-3 Hours
