/*
Title: Activity Monitoring
Difficulty: Intermediate

Learning Objectives:
- Inspect current database sessions.
- Distinguish active and idle connections.
- Use pg_stat_activity safely.

Problem Statement:
The team needs to see current sessions connected to the cookbook database.

Business Scenario:
Connection pool issues and slow requests often start with understanding active
database sessions.

SQL Solution:
*/

SELECT
    pid,
    usename,
    datname,
    state,
    wait_event_type,
    query_start
FROM pg_stat_activity
WHERE datname = current_database()
ORDER BY query_start DESC NULLS LAST;

/*
Explanation:
pg_stat_activity shows connected sessions. The query is filtered to the current
database to keep output focused.

Expected Output:
The current psql session and any other sessions for this database are listed.

Performance Notes:
This is safe for incident triage. Avoid exposing full query text broadly because
queries may contain sensitive values.

Common Mistakes:
- Treating idle sessions as active work.
- Ignoring wait events during lock investigations.
- Sharing query text from production without redaction.

Challenge Exercise:
Count sessions by state for the current database.

Challenge Solution:
*/

SELECT
    state,
    COUNT(*) AS session_count
FROM pg_stat_activity
WHERE datname = current_database()
GROUP BY state
ORDER BY state ASC;

/*
Related Chapters:
- ../13_performance/02_explain_analyze.sql
- ../17_docker_postgresql/05_container_troubleshooting_queries.sql
- 01_database_health_checks.sql
*/
