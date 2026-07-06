# Chapter 12: Indexes

## Overview

Indexes help PostgreSQL find rows without scanning an entire table. They are one
of the most important production PostgreSQL tools, but every index has a write
and maintenance cost.

This chapter uses realistic online-store queries to show when indexes help, when
they do not, and how to design them carefully.

## Key Concepts

- B-tree indexes support equality, range, and ordering queries.
- Composite indexes support multi-column access patterns.
- Partial indexes index only rows matching a predicate.
- Expression indexes index calculated values.
- Covering indexes can include extra columns for read-heavy queries.
- Indexes speed reads but slow writes.

## Learning Outcomes

- Create useful B-tree indexes.
- Design composite indexes for real query patterns.
- Use partial indexes for targeted subsets.
- Use expression indexes for transformed values.
- Read basic `EXPLAIN` output.
- Avoid over-indexing.

## When To Use The Feature

Use indexes for frequent filters, joins, ordering, uniqueness checks, and
production queries that scan too many rows.

## When NOT To Use The Feature

Do not add indexes blindly. Avoid indexes for tiny tables, rarely used filters,
or columns with poor selectivity unless a real query plan justifies them.

## Syntax Overview

```sql
CREATE INDEX index_name
    ON table_name (column_name);
```

Composite and partial indexes:

```sql
CREATE INDEX index_name
    ON table_name (status, order_date)
    WHERE status = 'paid';
```

## Best Practices

- Start from real queries.
- Use `EXPLAIN` before and after indexing.
- Name indexes consistently.
- Remove unused indexes.
- Avoid duplicate indexes.
- Remember indexes affect write performance.

## Performance Considerations

Indexes are not free. Inserts, updates, and deletes must maintain indexes. Large
indexes also consume disk and cache memory.

## Common Mistakes

- Adding one index per column without query evidence.
- Ignoring column order in composite indexes.
- Expecting indexes to help every query.
- Creating duplicate indexes.
- Forgetting partial index predicates must match the query.

## Business Examples

- Find recent orders quickly.
- Speed customer order lookups.
- Find active products in a category.
- Search customers by lowercase email.
- Support dashboard payment queries.

## Interview Tips

Be ready to explain tradeoffs. A strong junior answer says indexes improve reads
for matching access patterns but add write, storage, and maintenance cost.

## Recommended Learning Order

1. [Basic index](01_basic_index.sql)
2. [Composite index](02_composite_index.sql)
3. [Partial index](03_partial_index.sql)
4. [Expression index](04_expression_index.sql)
5. [Covering index](05_covering_index.sql)
6. [Chapter summary](chapter_summary.sql)
7. [Interview questions](interview_questions.md)

## Related Chapters

- [Chapter 2: Filtering & Sorting](../02_filtering_sorting/README.md)
- [Chapter 3: Joins](../03_joins/README.md)
- [Chapter 13: Performance](../13_performance/README.md)

## Difficulty

Intermediate

## Estimated Completion Time

2-3 Hours

## Useful PostgreSQL Documentation References

- [Indexes](https://www.postgresql.org/docs/current/indexes.html)
- [CREATE INDEX](https://www.postgresql.org/docs/current/sql-createindex.html)
- [Partial Indexes](https://www.postgresql.org/docs/current/indexes-partial.html)
- [Indexes on Expressions](https://www.postgresql.org/docs/current/indexes-expressional.html)
