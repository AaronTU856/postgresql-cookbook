# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project follows semantic versioning where practical.

## [Unreleased]

### Added

- Chapter 2: Filtering & Sorting, with examples for `AND`, `OR`, `NOT`, comparison operators, `LIKE`, `ILIKE`, `BETWEEN`, `IN`, `NOT IN`, `NULL` handling, multi-column sorting, `NULLS FIRST`, `NULLS LAST`, `LIMIT`, `OFFSET`, and simple pagination.
- Chapter 3: Joins, with examples for `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL OUTER JOIN`, `CROSS JOIN`, self joins, multi-table joins, joins with aggregation, join filtering, join best practices, common join mistakes, and real-world reporting.
- Chapter 4: Aggregation, with examples for `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `GROUP BY`, `HAVING`, distinct aggregates, joins with aggregates, and business reporting queries.

### Changed

- Updated README, learning path, roadmap, and validation workflow for Chapters 2, 3, and 4.

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
