# Chapter 9: Views

## What Are Views?

A view is a saved SQL query that can be read like a table. It does not store
data by default; PostgreSQL runs the underlying query when the view is queried.

Views help turn repeated joins, filters, and reporting queries into named,
reusable database objects.

## Why Use Views?

Use views when a query is important enough to give it a clear name. They are
useful for application read models, reporting layers, security boundaries, and
simplifying complex joins for less experienced SQL users.

## Simple vs Materialized Views

A regular view stores the query definition. A materialized view stores the query
result and must be refreshed when source data changes.

Regular views are best when data must always be current. Materialized views are
best when a costly report can tolerate refreshed snapshots.

## Updatable Views

Some simple views can be updated directly. PostgreSQL can route inserts, updates,
and deletes through a view when it maps clearly to one base table and avoids
features such as grouping, joins, and aggregates.

## Security Considerations

Views can expose only selected columns or rows. This helps avoid sharing
sensitive fields with reporting users or application features that do not need
full table access.

Views are not a complete security model on their own. Permissions, ownership,
row-level security, and application access rules still matter.

## Business Reporting

Views are practical for reports such as active products, customer orders,
payment summaries, category revenue, and fulfilment dashboards.

## Performance

Regular views do not automatically make queries faster. PostgreSQL still runs
the underlying query. Materialized views can improve read performance by storing
results, but they introduce refresh and freshness tradeoffs.

## Best Practices

- Name views for the business question they answer.
- Keep view definitions readable.
- Avoid hiding too much complexity behind nested views.
- Document refresh expectations for materialized views.
- Use explicit column lists and stable aliases.
- Validate whether a view is updatable before relying on it for writes.

## Common Mistakes

- Assuming regular views store data.
- Expecting a view to improve performance automatically.
- Forgetting to refresh materialized views.
- Building deeply nested views that are hard to debug.
- Exposing more columns than the reader needs.

## Learning Outcomes

After completing this chapter, you should be able to:

- Create simple and complex views.
- Use views to simplify joins and reports.
- Explain when a materialized view is useful.
- Refresh materialized views safely.
- Recognise which views are updatable.
- Use views to expose safer reporting datasets.

## Recommended Learning Order

1. [Create view](01_create_view.sql)
2. [Simple view](02_simple_view.sql)
3. [Complex view](03_complex_view.sql)
4. [Join view](04_join_view.sql)
5. [Aggregate view](05_aggregate_view.sql)
6. [Updatable views](06_updatable_views.sql)
7. [Materialized views](07_materialized_views.sql)
8. [Refresh materialized view](08_refresh_materialized_view.sql)
9. [Security views](09_security_views.sql)
10. [Business reporting view](10_business_reporting_view.sql)
11. [Common view mistakes](11_common_view_mistakes.sql)
12. [Chapter summary](12_chapter_summary.sql)

## Related Chapters

- [Chapter 3: Joins](../03_joins/README.md)
- [Chapter 4: Aggregation](../04_aggregates/README.md)
- [Chapter 8: Transactions & ACID](../08_transactions/README.md)

## Difficulty

Intermediate

## Estimated Completion Time

2-3 Hours
