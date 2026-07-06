# Learning Path

The examples are ordered so learners can build confidence step by step. Start with simple reads before moving into relationships, calculations, and PostgreSQL-specific features.

## Recommended Order

1. **Chapter 1: Basic Queries**
   Learn how to select columns, limit result sets, and read from a single table.

2. **Chapter 2: Filtering & Sorting**
   Learn how to find specific records, combine conditions, handle NULL values, and order results for reports or application screens.

3. **Chapter 3: Joins**
   Learn how related tables work together with inner joins, outer joins, self joins, multi-table joins, and reporting joins.

4. **Chapter 4: Aggregation**
   Learn how to answer reporting questions with `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `GROUP BY`, and `HAVING`.

5. **Chapter 5: Subqueries**
   Learn how to use scalar, multiple-row, correlated, and derived-table subqueries while keeping the intent readable.

6. **Chapter 6: Common Table Expressions**
   Learn how to break complex queries into readable steps with `WITH`, multiple CTEs, and recursive CTEs.

7. **Chapter 7: Window Functions**
   Learn how to rank rows, compare previous and next values, calculate running totals, build moving averages, and report across rows without losing row-level detail.

8. **Chapter 8: Transactions**
   Learn how `BEGIN`, `COMMIT`, `ROLLBACK`, savepoints, isolation levels, locks, and ACID properties keep multi-step business changes consistent.

9. **Chapter 9: Views**
   Learn how regular views, updatable views, security-focused views, and materialized views make repeated business queries easier to reuse.

10. **Chapter 10: Functions**
    Learn how SQL functions, PL/pgSQL functions, parameters, table-returning functions, volatility, and error handling package reusable database logic.

11. **Chapter 11: Triggers**
    Learn how trigger functions automate audit trails, validation, status tracking, and database-side consistency rules.

12. **Chapter 12: Indexes**
    Learn how B-tree, composite, partial, expression, covering, and GIN indexes support real query patterns.

13. **Chapter 13: Performance**
    Learn how to measure queries with `EXPLAIN`, avoid wasteful query shapes, and reason about production performance.

14. **Chapter 14: JSONB**
    Learn how to store, query, index, and report on flexible JSONB payloads without replacing relational design.

15. **Chapter 15: Full Text Search**
    Learn how to build PostgreSQL-native catalogue search with `tsvector`, `tsquery`, ranking, snippets, and GIN indexes.

16. **Chapter 16: PostgreSQL Administration**
    Learn safe health checks, size monitoring, activity inspection, permission checks, and maintenance basics.

17. **Chapter 17: Docker & PostgreSQL**
    Learn how to verify containerized PostgreSQL connections, initialization, persistence, health, and troubleshooting signals.

18. **Chapter 18: Django Integration**
    Learn how Django QuerySets map to joins, aggregates, transactions, indexes, and production PostgreSQL habits.

19. **Chapters 19-20: Applied PostgreSQL**
    Learn PostGIS and real-world project patterns.

## Suggested Practice Routine

- Read the example once without running it.
- Predict the result.
- Run the query in `psql`.
- Change one condition or column.
- Write down what changed and why.
- Complete the challenge exercise before moving on.
