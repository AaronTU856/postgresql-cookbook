/*
Title: Initialization Verification
Difficulty: Beginner

Learning Objectives:
- Verify schema objects exist.
- Check seed data counts.
- Confirm Docker init scripts ran.

Problem Statement:
After `docker compose up`, the developer needs to know whether the cookbook
schema and seed data loaded successfully.

Business Scenario:
Reliable local setup depends on deterministic database initialization.

SQL Solution:
*/

SELECT
    table_name
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name IN ('users', 'categories', 'products', 'orders', 'order_items', 'payments')
ORDER BY table_name ASC;

SELECT
    (SELECT COUNT(*) FROM users) AS users_count,
    (SELECT COUNT(*) FROM products) AS products_count,
    (SELECT COUNT(*) FROM orders) AS orders_count,
    (SELECT COUNT(*) FROM payments) AS payments_count;

/*
Explanation:
The first query confirms required tables exist. The second query confirms seed
data counts are present.

Expected Output:
The required table names and non-zero seed counts are returned.

Performance Notes:
These checks are safe for local startup and CI validation.

Common Mistakes:
- Forgetting init scripts only run on an empty data directory.
- Resetting containers without resetting volumes.
- Assuming schema loaded because the container is healthy.

Challenge Exercise:
Check that order_items has seed rows.

Challenge Solution:
*/

SELECT
    COUNT(*) AS order_items_count
FROM order_items;

/*
Related Chapters:
- ../01_basic_queries/01_select_all.sql
- ../16_administration/02_size_monitoring.sql
- 04_persistent_data_check.sql
*/
