/*
Title: Full Text Search Index
Difficulty: Advanced

Learning objectives:
- Create a GIN index for full-text search.
- Use EXPLAIN to inspect indexed search queries.
- Understand expression indexes for search vectors.

Problem statement:
The catalogue search query needs an index before the products table grows.

Business scenario:
As product count grows, full table scans for every search request become too
expensive.

SQL solution:
*/

CREATE INDEX IF NOT EXISTS idx_cookbook_products_search_vector
    ON products
    USING GIN (
        (
            setweight(to_tsvector('english', name), 'A')
            || setweight(to_tsvector('english', COALESCE(description, '')), 'B')
        )
    );

EXPLAIN
SELECT
    id AS product_id,
    name
FROM products
WHERE (
    setweight(to_tsvector('english', name), 'A')
    || setweight(to_tsvector('english', COALESCE(description, '')), 'B')
) @@ plainto_tsquery('english', 'Django API')
ORDER BY name ASC;

/*
Explanation:
The GIN expression index stores a weighted search vector for product name and
description. The query uses the same expression.

Expected output:
EXPLAIN returns the plan for the full-text product search.

Performance considerations:
GIN indexes speed matching but add storage and write overhead. They are most
useful on larger searchable tables.

Common mistakes:
- Creating an index expression that does not match the query expression.
- Expecting the index to be chosen on tiny tables.
- Forgetting write overhead for frequently updated text columns.

Challenge:
Explain why PostgreSQL may still scan the tiny seed products table.

Challenge solution:
*/

SELECT
    'The table is tiny, so a sequential scan may cost less than using the GIN index.'
        AS challenge_answer;

/*
Related chapters:
- ../12_indexes/04_expression_index.sql
- ../13_performance/01_explain_basics.sql
- 03_rank_search_results.sql
*/
