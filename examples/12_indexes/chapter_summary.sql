/*
Title: Indexes Chapter Summary
Difficulty: Intermediate

Learning Objectives:
- Review practical index patterns.
- Match indexes to production queries.
- Inspect indexes created for the cookbook schema.

Problem Statement:
Summarise index design by listing cookbook indexes and explaining which business
queries they support.

Business Scenario:
Before adding more indexes, engineers should inspect what already exists.

SQL Solution:
*/

SELECT
    schemaname,
    tablename,
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename ASC, indexname ASC;

/*
Explanation:
pg_indexes lists index definitions. Reviewing existing indexes helps prevent
duplicates and encourages query-driven index design.

Expected Output:
The query returns primary key indexes, schema indexes, and any cookbook indexes
created by this chapter.

Performance Notes:
Too many indexes can slow writes and increase storage. Keep indexes tied to
measured query needs.

Common Mistakes:
- Adding indexes without checking existing ones.
- Keeping duplicate or unused indexes.
- Forgetting that indexes need maintenance.

Challenge Exercise:
Find indexes on the payments table.

Challenge Solution:
*/

SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
  AND tablename = 'payments'
ORDER BY indexname ASC;

/*
Related Chapters:
- ../13_performance/README.md
- ../02_filtering_sorting/05_order_by.sql
- ../03_joins/10_join_best_practices.sql
*/
