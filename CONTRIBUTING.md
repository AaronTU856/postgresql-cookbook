# Contributing

Thank you for considering a contribution to PostgreSQL Cookbook.

This repository is intended to stay practical, clear, and beginner-friendly. Contributions should help learners understand PostgreSQL through realistic examples rather than large abstract reference dumps.

## Contribution Principles

- Keep examples small and focused.
- Prefer realistic business scenarios over toy data.
- Explain why a query is useful, not only what it does.
- Avoid adding advanced examples before their section has a clear learning path.
- Use consistent formatting from the SQL style guide.

## Example Format

Each example should include:

- SQL query
- Explanation
- Real-world use case
- Common mistake
- Challenge exercise

## Local Validation

Start the database:

```bash
docker compose up -d
```

Connect to PostgreSQL:

```bash
docker compose exec postgres psql -U postgres -d postgresql_cookbook
```

Run any SQL you add against the sample database before opening a pull request.

## Pull Requests

Pull requests should be focused and easy to review. A good pull request usually adds one topic, one example format improvement, or one documentation improvement.

Before submitting:

- Confirm the database starts locally.
- Confirm any new SQL runs successfully.
- Update documentation when you add or change learning material.
- Keep unrelated changes out of the pull request.
