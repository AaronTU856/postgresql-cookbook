# Docker Guide

This guide explains how to run the PostgreSQL Cookbook database with Docker.

## Installation

Install one of the following:

- Docker Desktop for macOS, Windows, or Linux
- Docker Engine with Docker Compose on Linux

Confirm Docker is available:

```bash
docker --version
docker compose version
```

## Starting PostgreSQL

From the repository root:

```bash
cp .env.example .env
docker compose up -d
```

Check the service status:

```bash
docker compose ps
```

The `postgres` service should show as running and healthy. The first startup creates the database, runs `database/init.sql`, loads the schema, and inserts seed data.

## Stopping PostgreSQL

Stop the container while keeping the database volume:

```bash
docker compose down
```

Start it again later with:

```bash
docker compose up -d
```

## Resetting the Database

Use this when you want to reload the sample schema and seed data from scratch:

```bash
docker compose down -v
docker compose up -d
```

The `-v` flag removes the persistent PostgreSQL volume. Any local changes inside the database will be lost.

## Connecting With psql

Connect from inside the container:

```bash
docker compose exec postgres psql -U postgres -d postgresql_cookbook
```

Useful `psql` commands:

```sql
\dt
\d users
\q
```

## Connecting With DBeaver

Create a new PostgreSQL connection with these settings:

- Host: `localhost`
- Port: `5432`
- Database: `postgresql_cookbook`
- Username: `postgres`
- Password: `postgres`

If you changed `.env`, use your local values instead.

## Common Docker Problems

### Docker daemon is not running

Start Docker Desktop or the Docker service, then run:

```bash
docker compose ps
```

### Port 5432 is already in use

Change `POSTGRES_PORT` in `.env`:

```text
POSTGRES_PORT=5433
```

Then restart:

```bash
docker compose down
docker compose up -d
```

### Database changes are not reset

The database uses a persistent volume. To force a clean rebuild:

```bash
docker compose down -v
docker compose up -d
```

### init.sql does not seem to run

PostgreSQL only runs files in `/docker-entrypoint-initdb.d/` when the data volume is empty. Remove the volume with `docker compose down -v` and start again.
