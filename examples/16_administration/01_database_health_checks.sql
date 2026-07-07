/*
Title: Database Health Checks
Difficulty: Beginner

Learning Objectives:
- Check the current database and user.
- Confirm server version and uptime.
- Read safe operational settings.

Problem Statement:
Before debugging application issues, the team needs to confirm PostgreSQL is
reachable and identify the connected database.

Business Scenario:
Backend engineers often start incident triage by proving which database,
environment, and user the application is using.

SQL Solution:
*/

SELECT
    current_database() AS database_name,
    current_user AS connected_user,
    version() AS postgres_version,
    pg_postmaster_start_time() AS server_started_at;

SELECT
    name,
    setting,
    unit
FROM pg_settings
WHERE name IN ('max_connections', 'shared_buffers', 'work_mem')
ORDER BY name ASC;

/*
Explanation:
These queries confirm the database connection and show basic server settings
without changing anything.

Expected Output:
The first query returns connection and version details. The second query returns
selected configuration settings.

Performance Notes:
These checks are lightweight and safe for normal troubleshooting.

Common Mistakes:
- Debugging the wrong database environment.
- Assuming the connected user has the same permissions as production.
- Treating configuration values as good or bad without workload context.

Challenge Exercise:
Return the current schema search path.

Challenge Solution:
*/

SELECT
    current_setting('search_path') AS search_path;

/*
Related Chapters:
- ../17_docker_postgresql/01_connection_check.sql
- ../13_performance/01_explain_basics.sql
- 03_activity_monitoring.sql
*/
