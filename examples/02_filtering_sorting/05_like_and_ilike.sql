/*
Title: Match Text With LIKE and ILIKE
Difficulty: Beginner

Concepts:
- LIKE
- ILIKE
- Wildcards

Learning objectives:
- Use LIKE for case-sensitive text matching.
- Use ILIKE for case-insensitive text matching in PostgreSQL.
- Place wildcards deliberately.

Problem statement:
The product team wants to find products related to guides or Django.

SQL solution:
*/

SELECT
    name,
    description,
    price
FROM products
WHERE name ILIKE '%guide%'
    OR description LIKE '%Django%'
ORDER BY name;

/*
Explanation:
ILIKE matches text without caring about letter case. LIKE is case-sensitive.
The % wildcard matches any number of characters before or after the search text.

Expected results:
The query returns Django APIs Handbook and PostgreSQL Pocket Guide.

Real-world example:
A simple admin search field may start with LIKE or ILIKE before the project
needs full-text search.

Performance notes:
Patterns that start with %, such as '%guide%', usually cannot use a normal
B-tree index efficiently. Larger search features often need full-text search or
trigram indexes.

Common mistakes:
- Forgetting the % wildcard.
- Expecting LIKE to be case-insensitive.
- Using text search patterns for large production search features without
  checking query performance.

Challenge exercise:
Find customers whose email address ends with example.com.

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
- ../01_basic_queries/08_like.sql
- 01_where_and.sql
- 12_simple_pagination.sql
*/
