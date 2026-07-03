# PostgreSQL Cookbook

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

Prerequisites:

- Docker
- Docker Compose

Copy the example environment file:

```bash
cp .env.example .env
```

Start PostgreSQL:

```bash
docker compose up -d
```

Connect with `psql`:

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

## Repository Structure

```text
.
├── cheatsheets/              # Compact SQL reference material
├── database/                 # Database bootstrap, schema, and seed data
├── docs/                     # Learning guides and project roadmap
├── examples/                 # Topic-based SQL examples
├── .github/                  # GitHub templates and validation workflow
├── docker-compose.yml        # Local PostgreSQL service
└── README.md                 # Project overview
```

## Learning Path

Start with the docs, then work through examples in order:

1. Read [Getting Started](docs/getting-started.md)
2. Review the [Learning Path](docs/learning-path.md)
3. Work through the [Basic Queries chapter](examples/01_basic_queries/README.md)
4. Use the [SQL Style Guide](docs/sql-style-guide.md) when writing your own queries
5. Refer to the [PostgreSQL Cheatsheet](cheatsheets/postgresql-cheatsheet.md)

## Contribution Guide

Contributions should be practical, small, and educational. Each example should explain what the query does, where it is useful, and what learners should watch out for.

Before opening a pull request, read [CONTRIBUTING.md](CONTRIBUTING.md).

## Roadmap

This repository is intentionally starting small. Future work will add focused examples for each topic area, Django-specific notes, and performance walkthroughs.

See [Repository Roadmap](docs/repository-roadmap.md) for the planned sections.

## Licence

This project is released under the [MIT Licence](LICENSE).
