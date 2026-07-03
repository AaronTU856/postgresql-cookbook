# Release Checklist

Use this checklist before tagging a public release.

## Repository Review

- [ ] Repository reviewed for unrelated or accidental changes.
- [ ] `README.md` updated.
- [ ] `CHANGELOG.md` updated with release notes.
- [ ] `docs/repository-roadmap.md` updated.
- [ ] New documentation links checked.

## SQL and Database

- [ ] Database schema loads successfully.
- [ ] Seed data loads successfully.
- [ ] Examples tested against the supplied schema and seed data.
- [ ] SQL formatting follows `docs/sql-style-guide.md`.

## Docker

- [ ] Docker startup tested with `docker compose up -d`.
- [ ] Healthcheck reaches a healthy state.
- [ ] `psql` connection tested.
- [ ] Reset flow tested with `docker compose down -v`.

## Open Source Readiness

- [ ] Issue templates reviewed.
- [ ] Pull request template reviewed.
- [ ] Contributing guide reviewed.
- [ ] Code of conduct reviewed.

## Release

- [ ] Working tree is clean.
- [ ] Release commit pushed.
- [ ] Release tagged.
- [ ] Tag pushed to GitHub.
