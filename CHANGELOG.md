# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project follows semantic versioning where practical.

## [Unreleased]

### Added

- Chapter 2: Filtering & Sorting, with examples for `AND`, `OR`, `NOT`, comparison operators, `LIKE`, `ILIKE`, `BETWEEN`, `IN`, `NOT IN`, `NULL` handling, multi-column sorting, `NULLS FIRST`, `NULLS LAST`, `LIMIT`, `OFFSET`, and simple pagination.
- Chapter 3: Joins, with examples for `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL OUTER JOIN`, `CROSS JOIN`, self joins, multi-table joins, joins with aggregation, join filtering, join best practices, common join mistakes, and real-world reporting.
- Chapter 4: Aggregation, with examples for `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `GROUP BY`, `HAVING`, distinct aggregates, joins with aggregates, and business reporting queries.
- Chapter 5: Subqueries, with examples for scalar subqueries, single-row and multiple-row subqueries, correlated subqueries, `EXISTS`, `NOT EXISTS`, `ANY`, `ALL`, subqueries in `SELECT`, subqueries in `FROM`, and subquery versus join tradeoffs.
- Chapter 6: Common Table Expressions, with examples for basic `WITH` clauses, multiple CTEs, joins, aggregation, recursive CTEs, hierarchy traversal, reporting queries, best practices, and CTE performance considerations.
- Chapter 7: Window Functions, with examples for `ROW_NUMBER`, `RANK`, `DENSE_RANK`, `NTILE`, `LAG`, `LEAD`, `FIRST_VALUE`, `LAST_VALUE`, running totals, moving averages, partitioned calculations, best practices, and business reporting.
- Chapter 8: Transactions & ACID, with examples for `BEGIN`, `COMMIT`, `ROLLBACK`, savepoints, isolation levels, row locks, deadlock avoidance, ACID properties, and e-commerce transaction workflows.
- Chapter 9: Views, with examples for simple views, complex views, join views, aggregate views, updatable views, materialized views, refresh workflows, security-focused views, reporting views, and common view mistakes.
- Chapter 10: Functions, with examples for SQL functions, PL/pgSQL functions, parameters, table-returning functions, volatility, error handling, business calculations, reporting functions, best practices, common mistakes, and interview preparation.
- Chapter 11: Triggers, with examples for audit triggers, `BEFORE` triggers, validation triggers, status auditing, common trigger mistakes, and interview preparation.
- Chapter 12: Indexes, with examples for B-tree indexes, composite indexes, partial indexes, expression indexes, covering indexes, index inspection, and interview preparation.
- Chapter 13: Performance, with examples for `EXPLAIN`, `EXPLAIN ANALYZE`, avoiding `SELECT *`, avoiding N+1 queries, keyset pagination, report measurement, and interview preparation.
- Chapter 14: JSONB, with examples for JSONB payloads, field extraction, containment queries, JSON response building, GIN indexing, and interview preparation.
- Chapter 15: Full Text Search, with examples for `tsvector`, `tsquery`, ranking, headlines, GIN indexes, catalogue search, and interview preparation.
- Chapter 16: PostgreSQL Administration, with examples for health checks, size monitoring, activity monitoring, permission checks, safe maintenance, and interview preparation.
- Chapter 17: Docker & PostgreSQL, with examples for connection verification, health checks, initialization checks, persistence checks, troubleshooting queries, and interview preparation.
- Chapter 18: Django Integration, with examples for QuerySet SQL shapes, `select_related`, avoiding N+1 queries, annotations, transaction patterns, indexes for Django filters, and interview preparation.

### Changed

- Updated README, learning path, roadmap, and validation workflow for Chapters 2, 3, 4, 5, 6, 7, and 8.
- Updated README, learning path, roadmap, and validation workflow for Chapter 9.
- Updated README, learning path, and roadmap for Chapter 10.
- Updated README, learning path, roadmap, and validation workflow for Chapters 10, 11, 12, 13, 14, and 15.
- Updated README, learning path, roadmap, and validation workflow for Chapters 16, 17, and 18.
- Normalised chapter folder numbering to one folder per planned chapter and aligned future placeholder folders with the roadmap.

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
