/*
Title: Basic Text Search
Difficulty: Beginner

Learning objectives:
- Use to_tsvector and plainto_tsquery.
- Search product descriptions.
- Understand the @@ match operator.

Problem statement:
Customers need to search product descriptions for PostgreSQL learning material.

Business scenario:
Product catalogue search should find relevant products from natural-language
search terms.

SQL solution:
*/

SELECT
    id AS product_id,
    name,
    description
FROM products
WHERE to_tsvector('english', description) @@ plainto_tsquery('english', 'PostgreSQL guide')
ORDER BY name ASC;

/*
Explanation:
to_tsvector tokenizes the product description. plainto_tsquery safely converts
the search phrase into a query. The @@ operator checks for a match.

Expected output:
Products with descriptions matching PostgreSQL guide terms are returned.

Performance considerations:
This expression can scan products without an index. Add a GIN index for
production catalogue search.

Common mistakes:
- Treating full-text search as exact substring search.
- Building raw tsquery strings from user input.
- Searching only one column when users expect name and description search.

Challenge:
Search product descriptions for office work terms.

Challenge solution:
*/

SELECT
    id AS product_id,
    name,
    description
FROM products
WHERE to_tsvector('english', description) @@ plainto_tsquery('english', 'office work')
ORDER BY name ASC;

/*
Related chapters:
- ../02_filtering_sorting/08_like.sql
- ../12_indexes/04_expression_index.sql
- 05_full_text_search_index.sql
*/
