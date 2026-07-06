/*
Title: Search Multiple Columns
Difficulty: Intermediate

Learning objectives:
- Combine product name and description.
- Use COALESCE for nullable text.
- Improve catalogue search coverage.

Problem statement:
Customers expect searches to match both product names and descriptions.

Business scenario:
Searching for "Django" should find a product even if the term appears in the
name more prominently than the description.

SQL solution:
*/

SELECT
    id AS product_id,
    name,
    description
FROM products
WHERE to_tsvector(
    'english',
    name || ' ' || COALESCE(description, '')
) @@ plainto_tsquery('english', 'Django APIs')
ORDER BY name ASC;

/*
Explanation:
The query combines name and description into one searchable document. COALESCE
protects the expression from NULL descriptions.

Expected output:
Products matching Django APIs across name or description are returned.

Performance considerations:
Expression-based search should be indexed when used frequently.

Common mistakes:
- Forgetting COALESCE and losing rows when a nullable text column is NULL.
- Searching only descriptions when names matter more.
- Ignoring which fields users expect search to cover.

Challenge:
Search name and description for laptop accessories.

Challenge solution:
*/

SELECT
    id AS product_id,
    name,
    description
FROM products
WHERE to_tsvector(
    'english',
    name || ' ' || COALESCE(description, '')
) @@ plainto_tsquery('english', 'laptop accessories')
ORDER BY name ASC;

/*
Related chapters:
- ../01_basic_queries/11_null_values.sql
- ../14_jsonb/04_build_json_response.sql
- 03_rank_search_results.sql
*/
