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

- Title
- Difficulty
- Learning Objectives
- Problem Statement
- Business Scenario
- SQL Solution
- Expected Output
- Explanation
- Performance Notes
- Common Mistakes
- Challenge Exercise
- Challenge Solution
- Related Chapters

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

If Docker is unavailable, you may use a local PostgreSQL database:

```bash
createdb postgresql_cookbook
psql -d postgresql_cookbook -v ON_ERROR_STOP=1 -f database/schema.sql
psql -d postgresql_cookbook -v ON_ERROR_STOP=1 -f database/seed.sql
```

## Pull Requests

Pull requests should be focused and easy to review. A good pull request usually adds one topic, one example format improvement, or one documentation improvement.

Before submitting:

- Confirm the database starts locally.
- Confirm any new SQL runs successfully.
- Update documentation when you add or change learning material.
- Keep unrelated changes out of the pull request.
- Link related examples when adding or renaming chapter files.
- Check Markdown links when you add or rename documentation.
