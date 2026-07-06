# Chapter 13 Interview Questions: Performance

## 1. Where do you start with a slow query?

**Model answer:** Measure it with logs and `EXPLAIN`, confirm business impact,
then inspect plan, row counts, indexes, and query shape.

**Practical tip:** Do not start by adding random indexes.

**Common follow-up:** What does `EXPLAIN ANALYZE` add?

## 2. What is the difference between EXPLAIN and EXPLAIN ANALYZE?

**Model answer:** `EXPLAIN` shows the planned query. `EXPLAIN ANALYZE` executes
the query and shows actual timing and row counts.

**Practical tip:** Be careful using `EXPLAIN ANALYZE` with writes.

**Common follow-up:** Why can estimates differ from actual rows?

## 3. Is a sequential scan always bad?

**Model answer:** No. It can be best for small tables or queries returning a
large percentage of rows.

**Practical tip:** Interpret plans in context.

**Common follow-up:** When is an index scan better?

## 4. What is an N+1 query problem?

**Model answer:** Fetching a list of rows, then running one query per row for
related data.

**Practical tip:** Replace it with joins, batching, or preloading.

**Common follow-up:** How would you detect it in an API?

## 5. Why avoid SELECT star?

**Model answer:** It returns unnecessary data, can expose sensitive columns, and
makes clients depend on implicit table shape.

**Practical tip:** Select only needed columns.

**Common follow-up:** Can selecting fewer columns improve performance?

## 6. Why can offset pagination be slow?

**Model answer:** PostgreSQL still has to walk past skipped rows before returning
the requested page.

**Practical tip:** Consider keyset pagination for deep scrolling.

**Common follow-up:** What makes keyset pagination stable?

## 7. What is query selectivity?

**Model answer:** How much a filter narrows the result set.

**Practical tip:** Highly selective filters are more likely to benefit from
indexes.

**Common follow-up:** Is an index on a boolean column useful?

## 8. What production signals indicate a database performance issue?

**Model answer:** Slow queries, high CPU, high I/O, lock waits, connection pool
pressure, timeout errors, and degraded endpoint latency.

**Practical tip:** Connect database metrics to user impact.

**Common follow-up:** What would you inspect first?

## 9. What is the risk of premature optimisation?

**Model answer:** It adds complexity without solving measured problems and can
make future maintenance harder.

**Practical tip:** Optimise important bottlenecks.

**Common follow-up:** How do you decide whether a query is important?

## 10. How do indexes and query plans relate?

**Model answer:** Indexes give the planner more access paths, but the planner
chooses based on estimated cost.

**Practical tip:** An index can exist and still not be used.

**Common follow-up:** What affects planner estimates?
