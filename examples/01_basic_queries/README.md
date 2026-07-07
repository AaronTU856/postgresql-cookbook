# Basic Queries

## Overview

This chapter introduces the core SQL patterns used to read data from a PostgreSQL database. The examples use the online store schema from `database/schema.sql` and the sample data from `database/seed.sql`.

The goal is to build confidence with simple, realistic queries before moving on to joins, aggregates, transactions, and performance topics.

## Prerequisites

- PostgreSQL is running locally with the sample database loaded.
- You can connect with `psql`.
- You have read `docs/getting-started.md`.
- You understand that these examples only read data and do not modify tables.

## Learning Outcomes

After completing this chapter, you should be able to:

- Read all columns from a table.
- Select only the columns an application or report needs.
- Remove duplicate values with `DISTINCT`.
- Filter rows with `WHERE`, `LIKE`, `BETWEEN`, `IN`, and `IS NULL`.
- Sort rows with `ORDER BY`.
- Limit the number of rows returned.
- Use aliases to make query output easier to read.

## Difficulty

Beginner

## Recommended Learning Order

1. [Select all columns](01_select_all.sql)
2. [Select specific columns](02_select_columns.sql)
3. [Select distinct values](03_select_distinct.sql)
4. [Filter with WHERE](04_where_clause.sql)
5. [Sort with ORDER BY](05_order_by.sql)
6. [Limit rows](06_limit.sql)
7. [Use aliases](07_aliases.sql)
8. [Match text with LIKE](08_like.sql)
9. [Filter ranges with BETWEEN](09_between.sql)
10. [Filter lists with IN](10_in.sql)
11. [Work with NULL values](11_null_values.sql)

## Estimated Completion Time

Allow 60 to 90 minutes if you read each explanation, run each query, and complete each challenge exercise.

## Related Chapters

- [Filtering and Sorting](../02_filtering_sorting/)
- [Joins](../03_joins/)
- [Aggregates](../04_aggregates/)
- [SQL Style Guide](../../docs/sql-style-guide.md)
- [PostgreSQL Cheatsheet](../../cheatsheets/postgresql-cheatsheet.md)
