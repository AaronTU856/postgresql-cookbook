/*
Title: Match Text With LIKE
Difficulty: Beginner

Learning objectives:
- Use LIKE-style matching for text columns.
- Use ILIKE for case-insensitive matching in PostgreSQL.
- Understand wildcard placement.

Problem statement:
The store team wants to find products whose names contain the word guide.

SQL solution:
*/

SELECT
    name,
    description,
    price
FROM products
WHERE name ILIKE '%guide%'
ORDER BY name;

/*
Expected result description:
The query returns PostgreSQL Pocket Guide because its product name contains the
word guide, regardless of case.

Explanation:
ILIKE is PostgreSQL's case-insensitive version of LIKE. The % wildcard means
"any number of characters", so '%guide%' matches text containing guide anywhere.

Real-world example:
A basic search box might use text matching to find products by partial name.

Performance considerations:
Patterns that start with %, such as '%guide%', usually cannot use a normal
B-tree index efficiently. Larger search features often need trigram indexes or
full-text search.

Common mistakes:
- Forgetting wildcards and writing ILIKE 'guide', which only matches the exact
  word guide.
- Using LIKE when case-insensitive matching is required.

Challenge exercise:
Find users whose email address ends with example.com.

Challenge solution:
*/

SELECT
    first_name,
    last_name,
    email
FROM users
WHERE email LIKE '%@example.com'
ORDER BY email;

/*
Related examples:
- 04_where_clause.sql
- 10_in.sql
*/
