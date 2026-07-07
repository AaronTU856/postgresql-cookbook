/*
Title: Function Best Practices
Difficulty: Intermediate

Learning Objectives:
- Write small and focused functions.
- Use accurate volatility and parameter names.
- Keep reporting functions side-effect free.

Problem Statement:
The team wants a safe customer payment total function suitable for reports.

Business Scenario:
Customer success needs a repeatable customer value calculation without modifying
data or hiding broad workflow logic.

SQL Solution:
*/

DROP FUNCTION IF EXISTS cookbook_completed_payment_total_for_user(BIGINT);

CREATE FUNCTION cookbook_completed_payment_total_for_user(
    p_user_id BIGINT
)
RETURNS NUMERIC
LANGUAGE SQL
STABLE
AS $$
    SELECT COALESCE(
        SUM(payments.amount),
        0
    )
    FROM orders
    INNER JOIN payments
        ON payments.order_id = orders.id
    WHERE orders.user_id = p_user_id
      AND payments.status = 'completed';
$$;

SELECT
    users.id AS user_id,
    users.email,
    cookbook_completed_payment_total_for_user(users.id) AS completed_payment_total
FROM users
ORDER BY completed_payment_total DESC, users.email ASC;

/*
Explanation:
The function has one clear purpose, uses a descriptive name, has explicit
parameters, and is marked STABLE because it reads database tables.

Expected Output:
Each customer appears with their completed payment total.

Performance Notes:
This pattern is readable. For large customer lists, a grouped join may be more
efficient than calling the function once per user.

Common Mistakes:
- Combining unrelated business rules into one function.
- Using unclear names such as get_total.
- Writing functions with side effects and then using them in reports.

Challenge Exercise:
Create a focused function that returns active product count for a category.

Challenge Solution:
*/

DROP FUNCTION IF EXISTS cookbook_active_product_count_for_category(BIGINT);

CREATE FUNCTION cookbook_active_product_count_for_category(
    p_category_id BIGINT
)
RETURNS BIGINT
LANGUAGE SQL
STABLE
AS $$
    SELECT COUNT(*)
    FROM products
    WHERE products.category_id = p_category_id
      AND products.is_active = TRUE;
$$;

SELECT
    categories.name AS category_name,
    cookbook_active_product_count_for_category(categories.id) AS active_product_count
FROM categories
ORDER BY categories.name ASC;

/*
Related Chapters:
- ../04_aggregates/01_count.sql
- ../09_views/05_aggregate_view.sql
- 05_function_volatility.sql
*/
