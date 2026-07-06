# Chapter 16: PostgreSQL Administration

## Overview

PostgreSQL administration is the operational side of database work: checking
health, monitoring activity, understanding storage, reviewing permissions, and
running safe maintenance. Backend engineers do not need to be full-time DBAs to
benefit from these skills.

## Key Concepts

- System catalogues describe database objects.
- `pg_stat_activity` shows current sessions.
- Size functions help track storage growth.
- Privilege checks help debug access problems.
- `ANALYZE` refreshes planner statistics.
- Operational queries should be safe, repeatable, and low risk.

## Learning Outcomes

- Check basic PostgreSQL health.
- Inspect database and table sizes.
- Review active sessions.
- Check table privileges.
- Run safe statistics maintenance.
- Explain common administration tasks in interviews.

## When To Use The Feature

Use administration queries when deploying, debugging connection issues, checking
growth, investigating slow systems, or preparing production readiness reviews.

## When NOT To Use The Feature

Do not run destructive maintenance, permission changes, or configuration changes
without a tested rollback plan and production approval.

## Syntax Overview

```sql
SELECT *
FROM pg_stat_activity
WHERE datname = current_database();
```

## Best Practices

- Prefer read-only diagnostic queries first.
- Know which commands require elevated privileges.
- Record before-and-after evidence for production changes.
- Use `ANALYZE` after significant data changes.
- Monitor database size trends, not just one snapshot.

## Performance Considerations

Administrative queries can still affect production if they scan large catalogues
or run too frequently. Keep dashboards focused and avoid expensive polling.

## Common Mistakes

- Guessing instead of checking system views.
- Ignoring table growth until disk is low.
- Confusing connection count with active workload.
- Running maintenance commands without understanding locks.
- Granting broad permissions to fix narrow access issues.

## Business Examples

- Check whether the database is reachable.
- Review table size growth before a release.
- Inspect active app connections.
- Confirm read permissions for reporting users.
- Refresh statistics after a data import.

## Interview Tips

Strong junior answers show operational judgement: start with safe diagnostics,
understand privileges, and escalate risky actions instead of improvising.

## Recommended Learning Order

1. [Database health checks](01_database_health_checks.sql)
2. [Size monitoring](02_size_monitoring.sql)
3. [Activity monitoring](03_activity_monitoring.sql)
4. [Role and permission checks](04_role_permission_checks.sql)
5. [Safe maintenance](05_safe_maintenance.sql)
6. [Chapter summary](chapter_summary.sql)
7. [Interview questions](interview_questions.md)

## Related Chapters

- [Chapter 12: Indexes](../12_indexes/README.md)
- [Chapter 13: Performance](../13_performance/README.md)
- [Chapter 17: Docker & PostgreSQL](../17_docker_postgresql/README.md)

## Difficulty

Intermediate

## Estimated Completion Time

2-3 Hours

## Useful PostgreSQL Documentation References

- [Monitoring Database Activity](https://www.postgresql.org/docs/current/monitoring-stats.html)
- [System Catalogs](https://www.postgresql.org/docs/current/catalogs.html)
- [Database Object Size Functions](https://www.postgresql.org/docs/current/functions-admin.html)
- [ANALYZE](https://www.postgresql.org/docs/current/sql-analyze.html)
