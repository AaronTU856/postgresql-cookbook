# Chapter 2: Filtering & Sorting

## Overview

Filtering and sorting are the everyday tools of SQL. Most backend features need to find a subset of rows, order them predictably, and return only the records a user or service actually needs.

This chapter builds on Chapter 1 by combining `WHERE`, comparison operators, text matching, `NULL` handling, `ORDER BY`, `LIMIT`, `OFFSET`, and simple pagination patterns.

## Learning Outcomes

After completing this chapter, you should be able to:

- Combine filters with `AND`, `OR`, and `NOT`.
- Use comparison operators for prices, stock levels, dates, and payment amounts.
- Search text with `LIKE` and PostgreSQL `ILIKE`.
- Filter ranges with `BETWEEN`.
- Match or exclude known values with `IN` and `NOT IN`.
- Handle `NULL` values correctly with `IS NULL` and `IS NOT NULL`.
- Sort by more than one column.
- Control `NULL` sort position with `NULLS FIRST` and `NULLS LAST`.
- Use `LIMIT` and `OFFSET` for small result windows.
- Understand the basic tradeoffs of offset-based pagination.

## Prerequisites

- Complete [Chapter 1: Basic Queries](../01_basic_queries/README.md).
- Start the sample database from the repository root.
- Be comfortable running SQL files with `psql`.
- Review the [SQL Style Guide](../../docs/sql-style-guide.md).

## Recommended Reading

- [Getting Started](../../docs/getting-started.md)
- [Docker Guide](../../docs/docker-guide.md)
- [Learning Path](../../docs/learning-path.md)
- [PostgreSQL Cheatsheet](../../cheatsheets/postgresql-cheatsheet.md)

## Estimated Completion Time

Allow 90 to 120 minutes if you run every example, read the explanations, and complete the challenge exercises.

## Difficulty

Beginner

## Topics Covered

1. [WHERE with AND](01_where_and.sql)
2. [WHERE with OR](02_where_or.sql)
3. [WHERE with NOT](03_where_not.sql)
4. [Comparison operators](04_comparison_operators.sql)
5. [LIKE and ILIKE](05_like_and_ilike.sql)
6. [BETWEEN](06_between.sql)
7. [IN and NOT IN](07_in_and_not_in.sql)
8. [NULL handling](08_null_handling.sql)
9. [ORDER BY multiple columns](09_order_by_multiple_columns.sql)
10. [NULLS FIRST and NULLS LAST](10_nulls_first_last.sql)
11. [LIMIT and OFFSET](11_limit_offset.sql)
12. [Simple pagination](12_simple_pagination.sql)

## Common Mistakes Beginners Make

- Using `= NULL` instead of `IS NULL`.
- Forgetting parentheses when mixing `AND` and `OR`.
- Assuming rows are returned in a stable order without `ORDER BY`.
- Using `LIMIT` without a deterministic sort.
- Treating `LIKE` and `ILIKE` as identical.
- Forgetting that `BETWEEN` includes both boundary values.
- Using large `OFFSET` values without understanding the performance cost.

## Where This Chapter Fits Within the Learning Path

Chapter 2 turns basic reads into practical application queries. These patterns are used constantly in list views, admin filters, search screens, reporting pages, and API endpoints.

After this chapter, move to Chapter 3: Joins, where filters and sorting are applied across related tables.

## Related Chapters

- [Chapter 1: Basic Queries](../01_basic_queries/README.md)
- [Chapter 3: Joins](../03_joins/README.md)
- [Chapter 4: Aggregation](../04_aggregates/README.md)
