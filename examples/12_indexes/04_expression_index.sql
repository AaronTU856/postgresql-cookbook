/*
Title: Expression Index
Difficulty: Intermediate

Learning objectives:
- Index a calculated expression.
- Support case-insensitive email lookup.
- Match query expression to index expression.

Problem statement:
Customer support searches for customers by email without caring about case.

Business scenario:
Emails typed by users or support agents may use mixed case, but lookups should
still be fast and reliable.

SQL solution:
*/

CREATE INDEX IF NOT EXISTS idx_cookbook_users_lower_email
    ON users (LOWER(email));

EXPLAIN
SELECT
    id AS user_id,
    email
FROM users
WHERE LOWER(email) = LOWER('AMELIA.CLARK@EXAMPLE.COM');

/*
Explanation:
The index stores LOWER(email). The query uses the same expression, allowing
PostgreSQL to consider the expression index.

Expected output:
EXPLAIN returns a plan for a case-insensitive email lookup.

Performance considerations:
Expression indexes add maintenance cost and should match real lookup patterns.

Common mistakes:
- Creating an expression index but querying the raw column.
- Using different expressions in the index and query.
- Forgetting uniqueness requirements for case-insensitive identifiers.

Challenge:
Create an expression index for lowercase product names.

Challenge solution:
*/

CREATE INDEX IF NOT EXISTS idx_cookbook_products_lower_name
    ON products (LOWER(name));

EXPLAIN
SELECT
    id AS product_id,
    name
FROM products
WHERE LOWER(name) = LOWER('USB-C Dock');

/*
Related chapters:
- ../02_filtering_sorting/05_like_and_ilike.sql
- ../14_jsonb/README.md
- 01_basic_index.sql
*/
