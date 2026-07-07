/*
Title: Function Volatility
Difficulty: Intermediate

Learning Objectives:
- Understand IMMUTABLE, STABLE, and VOLATILE.
- Mark functions according to their behaviour.
- Explain volatility in interview settings.

Problem Statement:
The team wants to classify functions correctly so PostgreSQL can plan queries
safely.

Business Scenario:
Pricing calculations, database lookups, and report timestamps change at
different rates and should not all use the same volatility category.

SQL Solution:
*/

DROP FUNCTION IF EXISTS cookbook_price_with_markup(NUMERIC, NUMERIC);

CREATE FUNCTION cookbook_price_with_markup(
    p_price NUMERIC,
    p_markup_percent NUMERIC
)
RETURNS NUMERIC
LANGUAGE SQL
IMMUTABLE
STRICT
AS $$
    SELECT ROUND(p_price * (1 + (p_markup_percent / 100)), 2);
$$;

DROP FUNCTION IF EXISTS cookbook_user_order_count(BIGINT);

CREATE FUNCTION cookbook_user_order_count(
    p_user_id BIGINT
)
RETURNS BIGINT
LANGUAGE SQL
STABLE
AS $$
    SELECT COUNT(*)
    FROM orders
    WHERE orders.user_id = p_user_id;
$$;

DROP FUNCTION IF EXISTS cookbook_report_generated_at();

CREATE FUNCTION cookbook_report_generated_at()
RETURNS TIMESTAMPTZ
LANGUAGE SQL
VOLATILE
AS $$
    SELECT CLOCK_TIMESTAMP();
$$;

SELECT
    users.id AS user_id,
    users.email,
    cookbook_user_order_count(users.id) AS order_count,
    cookbook_report_generated_at() AS report_generated_at
FROM users
ORDER BY users.id ASC;

/*
Explanation:
The markup calculation is IMMUTABLE because it depends only on inputs. The order
count is STABLE because it reads database tables. The timestamp function is
VOLATILE because it can change every time it is called.

Expected Output:
Each user appears with an order count and a report timestamp.

Performance Notes:
Incorrect volatility can produce wrong assumptions for the planner. Be honest
about whether a function reads tables or changes between calls.

Common Mistakes:
- Marking table-reading functions as IMMUTABLE.
- Using VOLATILE for everything and reducing planner options.
- Ignoring volatility because the function appears to work in small tests.

Challenge Exercise:
Create a STABLE function that counts completed payments for a user.

Challenge Solution:
*/

DROP FUNCTION IF EXISTS cookbook_user_completed_payment_count(BIGINT);

CREATE FUNCTION cookbook_user_completed_payment_count(
    p_user_id BIGINT
)
RETURNS BIGINT
LANGUAGE SQL
STABLE
AS $$
    SELECT COUNT(*)
    FROM orders
    INNER JOIN payments
        ON payments.order_id = orders.id
    WHERE orders.user_id = p_user_id
      AND payments.status = 'completed';
$$;

SELECT
    users.email,
    cookbook_user_completed_payment_count(users.id) AS completed_payment_count
FROM users
ORDER BY users.email ASC;

/*
Related Chapters:
- ../04_aggregates/01_count.sql
- ../07_window_functions/14_business_reporting.sql
- 01_create_function.sql
*/
