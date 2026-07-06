# PostgreSQL Cookbook

[![Validate](https://github.com/AaronTU856/postgresql-cookbook/actions/workflows/validate.yml/badge.svg)](https://github.com/AaronTU856/postgresql-cookbook/actions/workflows/validate.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-336791)
![Docker](https://img.shields.io/badge/Docker-Compose-2496ED)

A practical PostgreSQL learning and reference repository for developers who want clear, runnable examples without unnecessary complexity.

This project is designed as a professional starter cookbook for learning SQL with PostgreSQL. It uses a small online store database so examples feel realistic while staying approachable.

## Who This Is For

- Junior developers building confidence with SQL
- Graduate developers preparing for backend roles
- Django developers who want stronger database fundamentals
- Backend engineers who want a compact PostgreSQL reference
- Developers preparing for technical interviews or portfolio reviews

## Topics Covered

- Basic `SELECT` queries
- Filtering and sorting
- Joins across related tables
- Aggregates and grouping
- Common table expressions
- Window functions
- Transactions
- Indexes
- Views
- SQL functions
- Triggers
- JSONB
- Query performance basics
- Django-oriented SQL examples

## Quick Start With Docker

Prerequisites: Docker Desktop or Docker Engine with Docker Compose.

Copy the example environment file:

```bash
cp .env.example .env
```

Start PostgreSQL:

```bash
docker compose up -d
```

Check the container is healthy:

```bash
docker compose ps
```

Connect with `psql` inside the container:

```bash
docker compose exec postgres psql -U postgres -d postgresql_cookbook
```

Run a quick query:

```sql
SELECT first_name, last_name, email
FROM users
ORDER BY created_at DESC;
```

Stop the database:

```bash
docker compose down
```

Reset the database and remove local data:

```bash
docker compose down -v
docker compose up -d
```

For DBeaver setup, reset instructions, and common Docker fixes, read the [Docker Guide](docs/docker-guide.md).

## Local PostgreSQL Setup

Docker is the recommended path because it loads the sample database automatically. If you prefer a local PostgreSQL installation, create a database and run the SQL files in order:

```bash
createdb postgresql_cookbook
psql -d postgresql_cookbook -v ON_ERROR_STOP=1 -f database/schema.sql
psql -d postgresql_cookbook -v ON_ERROR_STOP=1 -f database/seed.sql
```

## Repository Structure

```text
.
├── cheatsheets/              # Compact SQL reference material
├── database/                 # Database bootstrap, schema, and seed data
├── docs/                     # Setup, philosophy, roadmap, and release notes
├── examples/                 # Chapter-based SQL examples
├── .github/                  # GitHub templates and validation workflow
├── docker-compose.yml        # Local PostgreSQL service
└── README.md                 # Project overview
```

## Learning Roadmap

Start with the docs, then work through examples in order:

1. Read [Getting Started](docs/getting-started.md)
2. Set up PostgreSQL with the [Docker Guide](docs/docker-guide.md)
3. Review the [Learning Path](docs/learning-path.md)
4. Work through [Chapter 1: Basic Queries](examples/01_basic_queries/README.md)
5. Continue with [Chapter 2: Filtering & Sorting](examples/02_filtering_sorting/README.md)
6. Learn relationship queries in [Chapter 3: Joins](examples/03_joins/README.md)
7. Build summary reports in [Chapter 4: Aggregation](examples/04_aggregates/README.md)
8. Use the [SQL Style Guide](docs/sql-style-guide.md) when writing your own queries
9. Read the [Project Philosophy](docs/project-philosophy.md) if you plan to contribute
10. Refer to the [PostgreSQL Cheatsheet](cheatsheets/postgresql-cheatsheet.md)

The full planned book-style roadmap is tracked in [Repository Roadmap](docs/repository-roadmap.md).

## Screenshots

Screenshots and terminal captures will be added as the cookbook grows. Planned assets include:

- Docker startup and healthcheck output
- `psql` query examples
- DBeaver connection setup
- Example result sets for completed chapters

## Contribution Guide

Contributions should be practical, small, and educational. Each example should explain what the query does, where it is useful, what can go wrong, and how learners can practise the concept.

Before opening a pull request:

- Read [CONTRIBUTING.md](CONTRIBUTING.md)
- Review the [Project Philosophy](docs/project-philosophy.md)
- Follow the [SQL Style Guide](docs/sql-style-guide.md)
- Run new SQL against the sample database
- Keep changes focused on one chapter or one documentation improvement

## Roadmap

This repository is intentionally starting small. Future work will add focused examples for each topic area, Django-specific notes, and performance walkthroughs.

See [Repository Roadmap](docs/repository-roadmap.md) for the planned sections.

## License

This project is released under the [MIT License](LICENSE).
