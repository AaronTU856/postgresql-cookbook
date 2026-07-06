/*
Title: Container Troubleshooting Queries
Difficulty: Intermediate

Learning objectives:
- Inspect active sessions.
- Check relevant server settings.
- Gather safe troubleshooting evidence.

Problem statement:
The API cannot connect reliably, and the team wants database-side evidence from
inside the PostgreSQL container.

Business scenario:
Docker issues can come from connection limits, wrong database names, startup
timing, or application connection pool behaviour.

SQL solution:
*/

SELECT
    COUNT(*) AS sessions_for_current_database
FROM pg_stat_activity
WHERE datname = current_database();

SELECT
    name,
    setting,
    unit
FROM pg_settings
WHERE name IN ('max_connections', 'listen_addresses', 'port')
ORDER BY name ASC;

/*
Explanation:
The first query counts sessions to the current database. The second query shows
connection-related settings visible from SQL.

Expected output:
Session count and selected connection settings are returned.

Performance considerations:
These diagnostics are safe, but avoid exposing full query text from production
without redaction.

Common mistakes:
- Debugging application code before checking database readiness.
- Ignoring connection pool size versus max_connections.
- Forgetting Docker port mapping can differ from PostgreSQL's internal port.

Challenge:
List session states for the current database.

Challenge solution:
*/

SELECT
    state,
    COUNT(*) AS session_count
FROM pg_stat_activity
WHERE datname = current_database()
GROUP BY state
ORDER BY state ASC;

/*
Related chapters:
- ../16_administration/03_activity_monitoring.sql
- ../13_performance/02_explain_analyze.sql
- 02_healthcheck_query.sql
*/
