/*
Title: Full Text Search Index
Difficulty: Advanced

Learning Objectives:
- Create a GIN index for full-text search.
- Use EXPLAIN to inspect indexed search queries.
- Understand expression indexes for search vectors.

Problem Statement:
The catalogue search query needs an index before the products table grows.

Business Scenario:
As product count grows, full table scans for every search request become too
expensive.

SQL Solution:
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

Expected Output:
EXPLAIN returns the plan for the full-text product search.

Performance Notes:
GIN indexes speed matching but add storage and write overhead. They are most
useful on larger searchable tables.

Common Mistakes:
- Creating an index expression that does not match the query expression.
- Expecting the index to be chosen on tiny tables.
- Forgetting write overhead for frequently updated text columns.

Challenge Exercise:
Explain why PostgreSQL may still scan the tiny seed products table.

Challenge Solution:
*/

SELECT
    'The table is tiny, so a sequential scan may cost less than using the GIN index.'
        AS challenge_answer;

/*
Related Chapters:
- ../12_indexes/04_expression_index.sql
- ../13_performance/01_explain_basics.sql
- 03_rank_search_results.sql
*/
