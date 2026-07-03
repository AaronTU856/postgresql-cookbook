# Getting Started

This guide helps you run the sample PostgreSQL database locally and execute your first query.

## Requirements

- Docker
- Docker Compose
- A terminal

For detailed Docker setup and troubleshooting, see [Docker Guide](docker-guide.md).

## Start PostgreSQL

From the repository root:

```bash
cp .env.example .env
docker compose up -d
```

The database is created automatically the first time the container starts. The schema and seed data are loaded from the `database/` directory.

## Connect to the Database

```bash
docker compose exec postgres psql -U postgres -d postgresql_cookbook
```

You should see a `psql` prompt.

## Try a Query

```sql
SELECT
    id,
    first_name,
    last_name,
    email
FROM users
ORDER BY created_at DESC;
```

## Reset the Database

If you want to reload the schema and seed data from scratch:

```bash
docker compose down -v
docker compose up -d
```

The `-v` flag removes the local database volume. Use it only when you want a clean reset.
