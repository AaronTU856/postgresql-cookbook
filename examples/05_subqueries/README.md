# Chapter 5: Subqueries

## Overview

Subqueries let one SQL query use the result of another query. They are useful when a question depends on a calculated value, a filtered list, or an existence check.

This chapter uses the online store database to answer practical questions about users, orders, products, categories, and payments.

## Key Concepts

- A subquery is a query nested inside another SQL statement.
- A scalar subquery returns one value.
- A single-row subquery returns one row.
- A multiple-row subquery returns more than one row.
- A correlated subquery refers to columns from the outer query.
- `EXISTS` checks whether a subquery returns at least one row.
- `ANY` and `ALL` compare a value against a set of values.
- A subquery in `FROM` creates a derived table.

## Learning Outcomes

After completing this chapter, you should be able to:

- Use subqueries in `WHERE`, `SELECT`, and `FROM`.
- Choose between scalar, single-row, and multiple-row subqueries.
- Write correlated subqueries that depend on the outer query.
- Use `EXISTS` and `NOT EXISTS` for relationship checks.
- Compare subqueries with joins.
- Avoid common subquery mistakes that cause errors or slow reports.

## Types of Subqueries

- **Scalar subquery:** returns one value, such as the average product price.
- **Single-row subquery:** returns one row, often used with `=`, `<`, or `>`.
- **Multiple-row subquery:** returns many rows, often used with `IN`, `ANY`, or `ALL`.
- **Correlated subquery:** runs in relation to each row from the outer query.
- **Derived table:** a subquery in `FROM` that can be joined or filtered like a table.

## Correlated vs Non-Correlated Subqueries

A non-correlated subquery can run independently. For example, a query that finds the average product price does not need the outer query.

A correlated subquery depends on the current row from the outer query. For example, finding products priced above their own category average requires the subquery to reference the product's category.

## EXISTS vs IN

Use `IN` when you need to compare a value against a list returned by a subquery. Use `EXISTS` when you only need to know whether a related row exists.

`EXISTS` often reads naturally for relationship checks, such as customers who have orders or products that have order items.

## ANY and ALL

`ANY` compares a value with at least one value returned by a subquery. `ALL` compares a value with every value returned by a subquery.

These operators are useful, but they require careful reading. In many application queries, `MIN`, `MAX`, or a join can be clearer.

## Performance Considerations

- Check whether a join would be clearer or faster.
- Use indexes on columns referenced by correlated subqueries.
- Avoid subqueries that return more rows than needed.
- Use `EXISTS` for existence checks rather than counting rows.
- Inspect query plans with `EXPLAIN` when subqueries become slow.

## Common Mistakes

- Using `=` with a subquery that returns multiple rows.
- Forgetting that correlated subqueries can run once per outer row.
- Returning unnecessary columns inside `EXISTS`.
- Using `NOT IN` with nullable results.
- Hiding complex business logic inside deeply nested subqueries.

## Recommended Learning Order

1. [Scalar subquery](01_scalar_subquery.sql)
2. [Single-row subquery](02_single_row_subquery.sql)
3. [Multiple-row subquery](03_multiple_row_subquery.sql)
4. [Correlated subquery](04_correlated_subquery.sql)
5. [EXISTS](05_exists.sql)
6. [NOT EXISTS](06_not_exists.sql)
7. [ANY and ALL](07_any_all.sql)
8. [Subquery in SELECT](08_subquery_in_select.sql)
9. [Subquery in FROM](09_subquery_in_from.sql)
10. [Subquery vs join](10_subquery_vs_join.sql)
11. [Common subquery mistakes](11_common_subquery_mistakes.sql)
12. [Chapter summary](12_chapter_summary.sql)

## Related Chapters

- [Chapter 2: Filtering & Sorting](../02_filtering_sorting/README.md)
- [Chapter 3: Joins](../03_joins/README.md)
- [Chapter 4: Aggregation](../04_aggregates/README.md)

## Difficulty

Intermediate

## Estimated Completion Time

2-3 Hours
