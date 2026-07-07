# Chapter 7: Window Functions

## Overview

## What Are Window Functions?

Window functions calculate values across a set of related rows while keeping each original row visible. They are useful when you need row-level detail and summary-style context in the same result.

Unlike `GROUP BY`, a window function does not collapse rows into groups. It adds calculations beside the rows.

## Why Use Window Functions?

Use window functions when you need rankings, running totals, comparisons with previous or next rows, moving averages, or values from the first or last row in a group.

Window functions are especially useful for reporting because they avoid extra self joins or nested queries for many analytical tasks.

## OVER() Explained

Every window function uses `OVER()` to define the set of rows it can see.

```sql
ROW_NUMBER() OVER (
    ORDER BY order_date
)
```

The `OVER()` clause may include `PARTITION BY`, `ORDER BY`, and a frame definition.

## PARTITION BY Explained

`PARTITION BY` splits rows into groups for the window calculation while keeping every row in the output.

For example, ranking products with `PARTITION BY category_id` ranks products inside each category rather than across the whole table.

## ORDER BY Inside OVER()

`ORDER BY` inside `OVER()` controls the row order used by the window function. It is separate from the final query `ORDER BY`.

Use stable tie-breakers such as `id` when the order needs to be deterministic.

## Ranking Functions

- `ROW_NUMBER()` assigns a unique sequence number.
- `RANK()` assigns the same rank to ties and leaves gaps.
- `DENSE_RANK()` assigns the same rank to ties without gaps.
- `NTILE()` divides ordered rows into buckets.

## Navigation Functions

- `LAG()` reads a value from a previous row.
- `LEAD()` reads a value from a following row.
- `FIRST_VALUE()` reads the first value in a window frame.
- `LAST_VALUE()` reads the last value in a window frame.

## Aggregate Window Functions

Aggregate functions such as `SUM()`, `AVG()`, `COUNT()`, `MIN()`, and `MAX()` can be used as window functions with `OVER()`.

This makes running totals, moving averages, and per-partition summaries possible without losing row-level detail.

## Business Reporting Examples

- Rank products by price.
- Rank products inside each category.
- Compare an order with the previous or next order.
- Calculate running completed payment totals.
- Calculate moving average payment values.
- Rank customers by completed payment value.

## Performance Considerations

- Window functions often require sorting.
- Indexes can help when they match filtering and ordering patterns.
- Large partitions can be expensive to process.
- Use only the window calculations the report actually needs.
- Check query plans for frequent analytical reports.

## Best Practices

- Use explicit `ORDER BY` inside `OVER()`.
- Add deterministic tie-breakers such as primary keys.
- Use `PARTITION BY` when calculations should restart per group.
- Be explicit with window frames for `LAST_VALUE()` and running totals.
- Keep final result ordering separate from window ordering.

## Common Mistakes

- Confusing window functions with `GROUP BY`.
- Forgetting `OVER()`.
- Expecting `ORDER BY` inside `OVER()` to control final output order.
- Using `LAST_VALUE()` without an explicit frame.
- Omitting tie-breakers when ranks or row numbers must be stable.

## Learning Outcomes

After completing this chapter, you should be able to:

- Use ranking functions for ordered business lists.
- Compare current rows with previous or next rows.
- Use `PARTITION BY` to reset calculations per group.
- Build running totals and moving averages.
- Use `FIRST_VALUE()` and `LAST_VALUE()` safely.
- Apply window functions to practical reporting queries.

## Recommended Learning Order

1. [ROW_NUMBER](01_row_number.sql)
2. [RANK](02_rank.sql)
3. [DENSE_RANK](03_dense_rank.sql)
4. [NTILE](04_ntile.sql)
5. [LAG](05_lag.sql)
6. [LEAD](06_lead.sql)
7. [FIRST_VALUE](07_first_value.sql)
8. [LAST_VALUE](08_last_value.sql)
9. [Running totals](09_running_totals.sql)
10. [Moving averages](10_moving_average.sql)
11. [PARTITION BY](11_partition_by.sql)
12. [Window best practices](12_window_best_practices.sql)
13. [Common window mistakes](13_common_window_mistakes.sql)
14. [Business reporting](14_business_reporting.sql)
15. [Chapter summary](15_chapter_summary.sql)

## Related Chapters

- [Chapter 3: Joins](../03_joins/README.md)
- [Chapter 4: Aggregation](../04_aggregates/README.md)
- [Chapter 6: Common Table Expressions](../06_ctes/README.md)

## Difficulty

Intermediate

## Estimated Completion Time

3-4 Hours
