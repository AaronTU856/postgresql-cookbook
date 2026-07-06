/*
Title: Search Headlines
Difficulty: Intermediate

Learning objectives:
- Generate highlighted search snippets.
- Use ts_headline for search result previews.
- Keep search results user friendly.

Problem statement:
The catalogue search page needs a preview explaining why each product matched.

Business scenario:
Users trust search results more when the matching words are visible in context.

SQL solution:
*/

SELECT
    id AS product_id,
    name,
    ts_headline(
        'english',
        description,
        plainto_tsquery('english', 'PostgreSQL guide')
    ) AS highlighted_description
FROM products
WHERE to_tsvector('english', description) @@ plainto_tsquery('english', 'PostgreSQL guide')
ORDER BY name ASC;

/*
Explanation:
ts_headline returns a text snippet with matching search terms highlighted using
default markers.

Expected output:
Matching products are returned with highlighted description snippets.

Performance considerations:
Generate snippets for a limited result set. Highlighting many rows can be
expensive.

Common mistakes:
- Generating headlines before limiting results.
- Highlighting fields that were not part of the search.
- Assuming headline formatting is final UI formatting.

Challenge:
Generate highlighted snippets for office search results.

Challenge solution:
*/

SELECT
    id AS product_id,
    name,
    ts_headline(
        'english',
        description,
        plainto_tsquery('english', 'office')
    ) AS highlighted_description
FROM products
WHERE to_tsvector('english', description) @@ plainto_tsquery('english', 'office')
ORDER BY name ASC;

/*
Related chapters:
- ../14_jsonb/04_build_json_response.sql
- ../13_performance/03_avoid_select_star.sql
- 03_rank_search_results.sql
*/
