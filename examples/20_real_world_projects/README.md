# Chapter 20 - Real World Projects

## Overview

This final chapter turns the cookbook into portfolio-ready PostgreSQL work. It shows how to combine SQL fundamentals, reporting, performance, JSON APIs, Docker habits, Django patterns, and PostGIS thinking into realistic backend project slices.

The goal is not to add a giant application. The goal is to show how production PostgreSQL skills fit together in small, reviewable examples that could sit behind real API endpoints, dashboards, operational checks, and map features.

## Key Concepts

- Business reporting should use explicit joins, clear filters, and stable totals.
- API queries should return only the fields the endpoint needs.
- Project SQL should be explainable to another engineer during review.
- Performance work starts with measurement, not guesses.
- Operational SQL should be safe, read-only where possible, and repeatable.
- Spatial project features need bounded queries, indexes, and API-friendly GeoJSON.

## Learning Outcomes

After completing this chapter, you should be able to:

- Design realistic reporting SQL for an online store.
- Shape PostgreSQL results for JSON and REST API responses.
- Connect performance, indexing, and query design to product requirements.
- Explain how a Django backend can avoid common database mistakes.
- Sketch a PostGIS-backed mapping API for store locator features.
- Present PostgreSQL project work clearly in interviews or portfolio reviews.

## When To Use These Patterns

Use these patterns when building backend features that need:

- Customer or order dashboards
- Revenue and payment reporting
- REST API response shaping
- Store locator or map endpoints
- Query review before production deployment
- Operational checks for a PostgreSQL-backed service

## When NOT To Use These Patterns

Do not force every query into a complex report or JSON response. Simple application reads should stay simple. Avoid database-side complexity when the business rule belongs clearly in application code or when the query becomes harder to test than the feature it supports.

## Syntax Overview

This chapter combines:

```sql
WITH report_data AS (
    SELECT ...
)
SELECT jsonb_build_object(...)
FROM report_data;
```

It also uses `EXPLAIN`, aggregate reports, transaction-safe thinking, JSON response shapes, and optional PostGIS-backed map API patterns.

## Best Practices

- Start with the business question before writing SQL.
- Keep report CTEs named after the step they perform.
- Use `WHERE` for row-level filters and `HAVING` for grouped filters.
- Return stable API contracts from SQL-backed endpoints.
- Review execution plans before adding indexes.
- Cap user-controlled limits and map query bounds.
- Keep operational checks readable enough for incident response.

## Performance Considerations

Production PostgreSQL work is a loop: observe, measure, change, and verify. Use `EXPLAIN (ANALYZE, BUFFERS)` for real query tuning, avoid N+1 application patterns, index the predicates your application actually uses, and keep API responses bounded.

## Common Mistakes

- Writing reports without clear payment or order status filters.
- Mixing presentation formatting with core business calculations.
- Adding indexes without checking the query plan.
- Returning too much data from API endpoints.
- Treating project SQL as one-off code instead of maintainable application logic.
- Skipping operational queries until something breaks.

## Business Examples

- Monthly revenue dashboard
- Customer lifetime value report
- Django REST order summary endpoint
- Store locator GeoJSON endpoint
- Query performance review before launch
- PostgreSQL operational runbook checks

## Interview Tips

When discussing projects, explain the business problem, the schema relationships, the query shape, the indexing strategy, and the validation approach. Interviewers usually care more about reasoning than memorised syntax.

## Recommended Learning Order

1. `01_project_online_store_analytics.sql`
2. `02_project_mapping_api.sql`
3. `03_project_django_reporting_api.sql`
4. `04_project_performance_review.sql`
5. `05_project_operational_runbook.sql`
6. `chapter_summary.sql`
7. `interview_questions.md`

## Related Chapters

- [Chapter 3 - Joins](../03_joins/README.md)
- [Chapter 4 - Aggregation](../04_aggregates/README.md)
- [Chapter 6 - Common Table Expressions](../06_ctes/README.md)
- [Chapter 13 - Performance](../13_performance/README.md)
- [Chapter 14 - JSONB](../14_jsonb/README.md)
- [Chapter 18 - Django Integration](../18_django_examples/README.md)
- [Chapter 19 - PostGIS](../19_postgis/README.md)

## Difficulty

Advanced

## Estimated Completion Time

4-5 hours

## Useful PostgreSQL Documentation References

- Query planning: https://www.postgresql.org/docs/current/using-explain.html
- JSON functions: https://www.postgresql.org/docs/current/functions-json.html
- Indexes: https://www.postgresql.org/docs/current/indexes.html
- Transactions: https://www.postgresql.org/docs/current/tutorial-transactions.html
- PostGIS manual: https://postgis.net/docs/
