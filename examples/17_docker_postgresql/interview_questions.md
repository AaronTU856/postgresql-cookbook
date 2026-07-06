# Chapter 17 Interview Questions: Docker & PostgreSQL

## 1. Why use Docker for PostgreSQL in development?

**Model answer:** Docker gives repeatable local setup, predictable versions, and
easy onboarding.

**Practical tip:** Mention that production needs additional planning.

**Common follow-up:** What does Docker not solve?

## 2. What is the difference between a container and a volume?

**Model answer:** The container is the running process. The volume stores data
outside the container lifecycle.

**Practical tip:** Data usually survives container restart because of the volume.

**Common follow-up:** What does `docker compose down -v` do?

## 3. When do PostgreSQL Docker init scripts run?

**Model answer:** They run only when the data directory is empty on first
initialization.

**Practical tip:** Remove the volume to rerun init scripts locally.

**Common follow-up:** Why did my schema change not apply after restart?

## 4. What should a PostgreSQL healthcheck do?

**Model answer:** It should cheaply verify PostgreSQL is ready to accept
connections.

**Practical tip:** Keep healthchecks lightweight.

**Common follow-up:** Why is a heavy report a bad healthcheck?

## 5. How do you connect to PostgreSQL inside Docker Compose?

**Model answer:** Use `docker compose exec postgres psql -U user -d database` or
connect from the host through the mapped port.

**Practical tip:** Know the service name and database name.

**Common follow-up:** Why might localhost behave differently inside containers?

## 6. What are common Docker/PostgreSQL troubleshooting steps?

**Model answer:** Check container status, health, logs, port mapping, environment
variables, volumes, and database readiness.

**Practical tip:** Verify with SQL once connected.

**Common follow-up:** What would you inspect in logs?

## 7. Should Docker Compose secrets be committed?

**Model answer:** Real secrets should not be committed. Use example env files and
local secret management.

**Practical tip:** `.env.example` is safe; real `.env` should usually be ignored.

**Common follow-up:** How would this change in production?

## 8. Why can Docker Desktop performance differ from production?

**Model answer:** Resource limits, filesystem sharing, virtualization, and local
hardware differ from production infrastructure.

**Practical tip:** Do not benchmark production decisions on tiny local Docker
data.

**Common follow-up:** Where should performance testing happen?

## 9. What should CI validate for a database project?

**Model answer:** Schema creation, seed data, migrations, and executable SQL
examples or tests.

**Practical tip:** Use a fresh database for CI.

**Common follow-up:** Why avoid relying on local state?

## 10. What is a safe local reset workflow?

**Model answer:** Stop containers, remove the named volume intentionally, restart
the stack, and verify schema and seed data.

**Practical tip:** Warn developers that volume removal deletes local data.

**Common follow-up:** How would you preserve useful local data first?
