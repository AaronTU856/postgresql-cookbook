/*
Title: Indexes Chapter Summary
Difficulty: Intermediate

Learning objectives:
- Review practical index patterns.
- Match indexes to production queries.
- Inspect indexes created for the cookbook schema.

Problem statement:
Summarise index design by listing cookbook indexes and explaining which business
queries they support.

Business scenario:
Before adding more indexes, engineers should inspect what already exists.

SQL solution:
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

Expected output:
The query returns primary key indexes, schema indexes, and any cookbook indexes
created by this chapter.

Performance considerations:
Too many indexes can slow writes and increase storage. Keep indexes tied to
measured query needs.

Common mistakes:
- Adding indexes without checking existing ones.
- Keeping duplicate or unused indexes.
- Forgetting that indexes need maintenance.

Challenge:
Find indexes on the payments table.

Challenge solution:
*/

SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
  AND tablename = 'payments'
ORDER BY indexname ASC;

/*
Related chapters:
- ../13_performance/README.md
- ../02_filtering_sorting/05_order_by.sql
- ../03_joins/10_join_best_practices.sql
*/
