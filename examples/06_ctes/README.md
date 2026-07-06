# Chapter 6: Common Table Expressions (CTEs)

## What Is a CTE?

A Common Table Expression, or CTE, is a named temporary result set defined with `WITH` and used by the query that follows it.

CTEs help break larger SQL queries into readable steps. They are especially useful for reporting queries, staged calculations, and recursive problems.

## Why Use a CTE?

Use a CTE when a query becomes easier to understand as named steps. Instead of nesting several subqueries, you can name each intermediate result and then select from it.

CTEs are not only about shortening SQL. Their main value is clarity.

## Basic Syntax

```sql
WITH cte_name AS (
    SELECT
        column_name
    FROM table_name
)
SELECT
    column_name
FROM cte_name;
```

Multiple CTEs are separated with commas:

```sql
WITH first_step AS (
    SELECT ...
),
second_step AS (
    SELECT ...
)
SELECT ...
FROM second_step;
```

## Recursive CTEs Explained

Recursive CTEs allow a query to refer to itself. They are useful for hierarchies, sequences, trees, and graph-like data.

A recursive CTE has two parts:

- An anchor query that returns the starting rows.
- A recursive query that repeatedly adds more rows.

PostgreSQL requires `WITH RECURSIVE` for recursive CTEs.

## CTEs vs Subqueries

Subqueries are useful for compact nested logic. CTEs are often easier to read when a query has several stages or when an intermediate result is reused.

Use a CTE when naming the step makes the query clearer. Use a subquery when the logic is small and local.

## Performance Considerations

- CTEs improve readability, but they are not automatically faster.
- PostgreSQL may inline simple CTEs in modern versions.
- Large CTEs can still read and process many rows.
- Filter early when the business question allows it.
- Use `EXPLAIN` when a CTE-based report becomes slow.
- Recursive CTEs need clear stop conditions.

## Best Practices

- Give CTEs names that describe the business step.
- Keep each CTE focused on one purpose.
- Select only the columns needed by later steps.
- Order final results in the outer query.
- Use recursive CTEs carefully and include a termination condition.

## Common Mistakes

- Treating CTEs as permanent tables.
- Adding many CTEs when one simple query would be clearer.
- Forgetting commas between multiple CTEs.
- Using `ORDER BY` inside a CTE when the final result order matters.
- Writing recursive CTEs without a stop condition.
- Assuming a CTE always improves performance.

## Learning Outcomes

After completing this chapter, you should be able to:

- Write basic `WITH` clauses.
- Chain multiple CTEs together.
- Use CTEs with joins and aggregates.
- Build reporting queries in readable stages.
- Write simple recursive CTEs.
- Compare CTEs with equivalent subqueries.
- Recognise common CTE mistakes.

## Recommended Learning Order

1. [Basic CTE](01_basic_cte.sql)
2. [Multiple CTEs](02_multiple_ctes.sql)
3. [CTE with join](03_cte_with_join.sql)
4. [CTE with aggregation](04_cte_with_aggregation.sql)
5. [Recursive CTE](05_recursive_cte.sql)
6. [Recursive hierarchy](06_recursive_hierarchy.sql)
7. [CTE vs subquery](07_cte_vs_subquery.sql)
8. [CTE for reporting](08_cte_for_reporting.sql)
9. [CTE best practices](09_cte_best_practices.sql)
10. [Common CTE mistakes](10_common_cte_mistakes.sql)
11. [Performance considerations](11_performance_considerations.sql)
12. [Chapter summary](12_chapter_summary.sql)

## Related Chapters

- [Chapter 3: Joins](../03_joins/README.md)
- [Chapter 4: Aggregation](../04_aggregates/README.md)
- [Chapter 5: Subqueries](../05_subqueries/README.md)

## Difficulty

Intermediate

## Estimated Completion Time

2-3 Hours
