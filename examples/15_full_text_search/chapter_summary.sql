/*
Title: Full Text Search Chapter Summary
Difficulty: Intermediate

Learning Objectives:
- Review search vectors, queries, ranking, and indexes.
- Build a practical catalogue search query.
- Keep search results useful and deterministic.

Problem Statement:
Summarise the chapter with a ranked product catalogue search.

Business Scenario:
Customers search for technical products and expect relevant results first.

SQL Solution:
*/

WITH searchable_products AS (
    SELECT
        id,
        name,
        description,
        setweight(to_tsvector('english', name), 'A')
        || setweight(to_tsvector('english', COALESCE(description, '')), 'B')
            AS search_vector
    FROM products
)
SELECT
    id AS product_id,
    name,
    ts_rank(search_vector, websearch_to_tsquery('english', 'PostgreSQL guide')) AS rank,
    ts_headline(
        'english',
        COALESCE(description, ''),
        websearch_to_tsquery('english', 'PostgreSQL guide')
    ) AS highlighted_description
FROM searchable_products
WHERE search_vector @@ websearch_to_tsquery('english', 'PostgreSQL guide')
ORDER BY rank DESC, name ASC;

/*
Explanation:
The summary combines weighted search vectors, web-style user input, ranking, and
highlighted result snippets.

Expected Output:
Matching products are returned with rank and highlighted descriptions.

Performance Notes:
For production, pair this pattern with a matching GIN index and realistic search
testing.

Common Mistakes:
- Using raw user strings as tsquery syntax.
- Forgetting ranking.
- Highlighting too many rows before pagination.

Challenge Exercise:
Run the same pattern for office equipment.

Challenge Solution:
*/

WITH searchable_products AS (
    SELECT
        id,
        name,
        description,
        setweight(to_tsvector('english', name), 'A')
        || setweight(to_tsvector('english', COALESCE(description, '')), 'B')
            AS search_vector
    FROM products
)
SELECT
    id AS product_id,
    name,
    ts_rank(search_vector, websearch_to_tsquery('english', 'office equipment')) AS rank
FROM searchable_products
WHERE search_vector @@ websearch_to_tsquery('english', 'office equipment')
ORDER BY rank DESC, name ASC;

/*
Related Chapters:
- ../12_indexes/05_covering_index.sql
- ../13_performance/05_pagination_performance.sql
- ../14_jsonb/04_build_json_response.sql
*/
