/*
Title: Persistent Data Check
Difficulty: Intermediate

Learning objectives:
- Understand volume-backed persistence.
- Check database creation time signals.
- Inspect user table names after restart.

Problem statement:
A developer restarted the container and wants to confirm data persisted.

Business scenario:
Local development should preserve data across container restarts unless the
volume is intentionally removed.

SQL solution:
*/

SELECT
    current_database() AS database_name,
    pg_postmaster_start_time() AS server_started_at;

SELECT
    table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name ASC;

SELECT
    COUNT(*) AS products_count
FROM products;

/*
Explanation:
Container restart time and table presence help distinguish a restarted container
from a reset database volume.

Expected output:
The database name, server start time, public tables, and product count are
returned.

Performance considerations:
These checks are lightweight and safe after container restarts.

Common mistakes:
- Confusing `docker compose down` with volume removal.
- Forgetting `docker compose down -v` removes local database data.
- Expecting init scripts to run again while the volume still exists.

Challenge:
Check whether the payments table still has rows after restart.

Challenge solution:
*/

SELECT
    COUNT(*) AS payments_count
FROM payments;

/*
Related chapters:
- ../16_administration/02_size_monitoring.sql
- 03_init_verification.sql
- 05_container_troubleshooting_queries.sql
*/
