# Chapter 17: Docker & PostgreSQL

## Overview

Docker makes PostgreSQL easier to run consistently for local development,
learning, and CI validation. This chapter focuses on practical checks and
database-side verification for containerized PostgreSQL.

## Key Concepts

- Containers are disposable; volumes preserve data.
- Init scripts run only when the data directory is first created.
- Health checks prove service readiness.
- Environment variables configure initial database setup.
- `docker compose exec` is commonly used to run `psql`.

## Learning Outcomes

- Verify a Docker PostgreSQL connection from SQL.
- Confirm schema initialization.
- Check seed data loaded correctly.
- Understand persistent volume behaviour.
- Run troubleshooting queries inside a container.
- Explain Docker/PostgreSQL tradeoffs in interviews.

## When To Use The Feature

Use Docker for local development, repeatable onboarding, CI validation, and
isolated learning environments.

## When NOT To Use The Feature

Do not assume a local Docker setup is the same as production. Production needs
backup, monitoring, security, resource, and upgrade planning.

## Syntax Overview

```bash
docker compose up -d
docker compose exec postgres psql -U postgres -d postgresql_cookbook
docker compose down
```

## Best Practices

- Use named volumes for persistent local data.
- Keep init scripts deterministic.
- Add health checks.
- Store secrets outside committed files.
- Reset volumes deliberately when testing initialization.
- Validate schema and seed data after startup.

## Performance Considerations

Docker Desktop file sharing and resource limits can affect database performance.
Use Docker for repeatability, not as a production performance benchmark.

## Common Mistakes

- Expecting init scripts to rerun without removing the volume.
- Committing real passwords.
- Confusing container lifecycle with volume lifecycle.
- Debugging before checking the container health status.
- Testing production performance on a small Docker setup.

## Business Examples

- Onboard a new developer.
- Run cookbook SQL examples locally.
- Validate migrations in CI.
- Reset a local database safely.
- Reproduce support issues in isolation.

## Interview Tips

Be ready to explain the difference between the PostgreSQL container and the
PostgreSQL data volume. That distinction matters constantly in real projects.

## Recommended Learning Order

1. [Connection check](01_connection_check.sql)
2. [Healthcheck query](02_healthcheck_query.sql)
3. [Initialization verification](03_init_verification.sql)
4. [Persistent data checks](04_persistent_data_check.sql)
5. [Container troubleshooting queries](05_container_troubleshooting_queries.sql)
6. [Chapter summary](chapter_summary.sql)
7. [Interview questions](interview_questions.md)

## Related Chapters

- [Chapter 16: PostgreSQL Administration](../16_administration/README.md)
- [Chapter 13: Performance](../13_performance/README.md)
- [Chapter 18: Django Integration](../18_django_examples/README.md)

## Difficulty

Beginner to Intermediate

## Estimated Completion Time

2 Hours

## Useful PostgreSQL Documentation References

- [PostgreSQL Docker Official Image](https://hub.docker.com/_/postgres)
- [PostgreSQL Client Applications](https://www.postgresql.org/docs/current/reference-client.html)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
