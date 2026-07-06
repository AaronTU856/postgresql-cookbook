/*
Title: Rank Search Results
Difficulty: Intermediate

Learning objectives:
- Rank full-text search matches.
- Weight product names above descriptions.
- Order search results by relevance.

Problem statement:
The product catalogue should show the most relevant search results first.

Business scenario:
If a search term appears in a product name, that result should usually outrank a
description-only match.

SQL solution:
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
    ts_rank(search_vector, plainto_tsquery('english', 'Django API')) AS rank
FROM searchable_products
WHERE search_vector @@ plainto_tsquery('english', 'Django API')
ORDER BY rank DESC, name ASC;

/*
Explanation:
setweight gives product names more influence than descriptions. ts_rank scores
each matching row.

Expected output:
Matching products are returned with a relevance rank.

Performance considerations:
Ranking adds CPU work. Limit result sets and index the search vector expression
for larger catalogues.

Common mistakes:
- Returning matches without relevance ordering.
- Forgetting deterministic tie-breakers.
- Over-tuning ranking before measuring user search behaviour.

Challenge:
Rank products for the search phrase mechanical keyboard.

Challenge solution:
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
    ts_rank(search_vector, plainto_tsquery('english', 'mechanical keyboard')) AS rank
FROM searchable_products
WHERE search_vector @@ plainto_tsquery('english', 'mechanical keyboard')
ORDER BY rank DESC, name ASC;

/*
Related chapters:
- ../07_window_functions/02_rank.sql
- ../13_performance/02_explain_analyze.sql
- 02_search_multiple_columns.sql
*/
