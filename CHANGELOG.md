# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project follows semantic versioning where practical.

## [Unreleased]

No unreleased changes.

## [1.0.0] - 2026-07-07

### Release Notes

`v1.0.0` completes the core PostgreSQL Cookbook roadmap from beginner SQL through advanced backend, PostGIS, and real-world project examples.

### Added

- Twenty completed chapter folders with runnable SQL examples, chapter README files, challenge exercises, and interview preparation where appropriate.
- Chapters 2-18 covering filtering, joins, aggregation, subqueries, CTEs, window functions, transactions, views, functions, triggers, indexes, performance, JSONB, full text search, administration, Docker workflows, and Django integration.
- Flagship PostGIS chapter covering spatial modelling, nearest-neighbour search, spatial indexing, GeoJSON, Leaflet, Django GIS, and REST API patterns.
- Real World Projects chapter covering analytics dashboards, mapping APIs, Django reporting APIs, performance review, operational runbooks, and portfolio-ready JSON responses.
- v1.0.0 release notes.

### Changed

- Updated root README, learning path, roadmap, and GitHub Actions validation for the completed chapter set.
- Normalised chapter folder numbering to one folder per planned chapter and aligned chapter navigation with the roadmap.

## [0.2.0] - 2026-07-03

### Release Notes

`v0.2 Basic Queries` turns the initial scaffold into a usable beginner chapter. The release focuses on fundamental read queries and repository polish before moving into more advanced SQL topics.

### Added

- Stage 2 basic query chapter with examples for `SELECT`, specific columns, `DISTINCT`, `WHERE`, `ORDER BY`, `LIMIT`, aliases, `LIKE`, `BETWEEN`, `IN`, and `NULL` checks.
- Basic Queries chapter README with prerequisites, learning outcomes, recommended order, and related links.
- Docker guide with startup, reset, `psql`, DBeaver, and troubleshooting notes.
- Project philosophy documentation for learning goals and repository standards.
- Release checklist for public release preparation.

### Changed

- Updated the original starter user query to match the full chapter example format.
- Polished README navigation, Docker instructions, roadmap, contribution guidance, issue templates, pull request template, and validation workflow.

## [0.1.0] - 2026-07-02

### Added

- Initial repository scaffold.
- Docker Compose setup for local PostgreSQL.
- Online store sample schema and seed data.
- Documentation for getting started, learning path, roadmap, and SQL style.
- First basic query example.
