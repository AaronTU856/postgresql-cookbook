# Chapter 13: Performance

## Overview

PostgreSQL performance work starts with evidence. This chapter focuses on
reading query plans, reducing unnecessary work, avoiding common application
query patterns, and designing report queries that scale.

## Key Concepts

- `EXPLAIN` shows the planned query strategy.
- `EXPLAIN ANALYZE` executes the query and reports actual timing.
- Filtering early can reduce work.
- Selecting fewer columns can reduce I/O.
- Joins and aggregates need indexes and sensible query shape.
- Offset pagination can become expensive at large offsets.

## Learning Outcomes

- Read basic PostgreSQL query plans.
- Use `EXPLAIN ANALYZE` safely on read queries.
- Avoid unnecessary columns.
- Recognise N+1 query patterns.
- Compare offset and keyset pagination.
- Tune business reporting queries.

## When To Use The Feature

Use performance techniques when queries are slow, tables are growing, or
production workloads need predictable response times.

## When NOT To Use The Feature

Do not optimise guesses. Avoid complex rewrites before measuring the current
query.

## Syntax Overview

```sql
EXPLAIN
SELECT ...
```

```sql
EXPLAIN (ANALYZE, BUFFERS)
SELECT ...
```

## Best Practices

- Measure before changing.
- Start with the slowest important query.
- Check indexes and row estimates.
- Keep queries readable.
- Prefer set-based queries over row-by-row application loops.
- Test with realistic data volume before production rollout.

## Performance Considerations

`EXPLAIN ANALYZE` runs the query. Use it carefully with write queries or wrap
write tests in transactions that roll back.

## Common Mistakes

- Optimising tiny seed data and assuming production will behave the same.
- Adding indexes without checking plans.
- Selecting columns the application does not need.
- Using offset pagination for deep pages.
- Ignoring slow query frequency.

## Business Examples

- Support order lookups.
- Finance payment summaries.
- Customer order history.
- Fulfilment dashboards.
- Product catalogue pages.

## Interview Tips

A strong answer starts with measurement: slow query logs, `EXPLAIN`, table size,
indexes, cardinality, and business impact.

## Recommended Learning Order

1. [EXPLAIN basics](01_explain_basics.sql)
2. [EXPLAIN ANALYZE](02_explain_analyze.sql)
3. [Avoid SELECT star](03_avoid_select_star.sql)
4. [Avoid N+1 queries](04_avoid_n_plus_one.sql)
5. [Pagination performance](05_pagination_performance.sql)
6. [Chapter summary](chapter_summary.sql)
7. [Interview questions](interview_questions.md)

## Related Chapters

- [Chapter 12: Indexes](../12_indexes/README.md)
- [Chapter 4: Aggregation](../04_aggregates/README.md)
- [Chapter 7: Window Functions](../07_window_functions/README.md)

## Difficulty

Intermediate

## Estimated Completion Time

2-3 Hours

## Useful PostgreSQL Documentation References

- [Using EXPLAIN](https://www.postgresql.org/docs/current/using-explain.html)
- [Performance Tips](https://www.postgresql.org/docs/current/performance-tips.html)
- [Indexes](https://www.postgresql.org/docs/current/indexes.html)
