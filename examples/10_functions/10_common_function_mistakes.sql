/*
Title: Common Function Mistakes
Difficulty: Intermediate

Learning Objectives:
- Avoid ambiguous parameters and columns.
- Handle missing data deliberately.
- Keep functions predictable for callers.

Problem Statement:
The team wants a safe function for displaying payment status without returning
NULL surprises.

Business Scenario:
Support screens should show a clear payment status for known payments and a
clear fallback when a payment id is not found.

SQL Solution:
*/

DROP FUNCTION IF EXISTS cookbook_safe_payment_status(BIGINT);

CREATE FUNCTION cookbook_safe_payment_status(
    p_payment_id BIGINT
)
RETURNS TEXT
LANGUAGE SQL
STABLE
AS $$
    SELECT COALESCE(
        (
            SELECT payments.status::TEXT
            FROM payments
            WHERE payments.id = p_payment_id
        ),
        'payment_not_found'
    );
$$;

SELECT
    id AS payment_id,
    cookbook_safe_payment_status(id) AS safe_payment_status
FROM payments
ORDER BY id ASC;

/*
Explanation:
The function uses a clear parameter name, qualifies the table column, and returns
a predictable fallback if no payment exists.

Expected Output:
Each seeded payment appears with its status.

Performance Notes:
This function performs a lookup. Avoid calling lookup functions row by row over
large datasets when a join would be clearer and faster.

Common Mistakes:
- Naming a parameter the same as a column and creating ambiguity.
- Returning NULL when callers expect a status label.
- Hiding data access in a function without checking performance.
- Marking lookup functions as IMMUTABLE.

Challenge Exercise:
Create a safe customer name function that returns customer_not_found when the
user id does not exist.

Challenge Solution:
*/

DROP FUNCTION IF EXISTS cookbook_safe_customer_name(BIGINT);

CREATE FUNCTION cookbook_safe_customer_name(
    p_user_id BIGINT
)
RETURNS TEXT
LANGUAGE SQL
STABLE
AS $$
    SELECT COALESCE(
        (
            SELECT users.first_name || ' ' || users.last_name
            FROM users
            WHERE users.id = p_user_id
        ),
        'customer_not_found'
    );
$$;

SELECT
    id AS user_id,
    cookbook_safe_customer_name(id) AS customer_name
FROM users
ORDER BY id ASC;

/*
Related Chapters:
- ../01_basic_queries/11_null_values.sql
- ../03_joins/11_common_join_mistakes.sql
- 09_function_best_practices.sql
*/
