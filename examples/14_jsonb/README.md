# Chapter 14: JSONB

## Overview

`jsonb` stores semi-structured JSON data in a binary format PostgreSQL can query
and index. It is useful for event payloads, flexible metadata, API snapshots,
and attributes that do not justify new relational columns yet.

## Key Concepts

- `jsonb` stores parsed JSON.
- `->` returns JSON values.
- `->>` returns text values.
- `@>` checks containment.
- `jsonb_build_object` builds JSON from relational data.
- GIN indexes can support JSONB containment queries.

## Learning Outcomes

- Create JSONB data.
- Query nested JSON values.
- Filter using containment.
- Build JSON responses from relational rows.
- Aggregate rows into JSON arrays.
- Index JSONB payloads.

## When To Use The Feature

Use JSONB for flexible metadata, event logs, external API payloads, and optional
attributes that vary by record.

## When NOT To Use The Feature

Avoid JSONB for core relational data that needs strong constraints, joins, and
frequent filtering. Product price, order status, and payment amount should remain
typed columns.

## Syntax Overview

```sql
payload -> 'customer'
payload ->> 'event_type'
payload @> '{"event_type": "payment_completed"}'
```

## Best Practices

- Keep core business fields relational.
- Use JSONB for flexible or external data.
- Add indexes only for real query patterns.
- Validate important JSON shape in application code or constraints.
- Avoid deeply nested payloads for frequent reporting.

## Performance Considerations

JSONB is powerful but not free. Complex JSON paths, large payloads, and broad GIN
indexes can become expensive.

## Common Mistakes

- Replacing relational design with one JSONB column.
- Forgetting `->>` returns text.
- Indexing JSONB without a query pattern.
- Storing inconsistent keys across rows.
- Filtering numeric values as text accidentally.

## Business Examples

- Store order event payloads.
- Query payment event metadata.
- Build JSON API responses.
- Aggregate order lines into JSON arrays.
- Index event payload containment checks.

## Interview Tips

Good answers explain JSONB as a complement to relational design, not a
replacement for it.

## Recommended Learning Order

1. [Create JSONB data](01_create_jsonb_data.sql)
2. [Query JSONB fields](02_query_jsonb_fields.sql)
3. [JSONB containment](03_jsonb_containment.sql)
4. [Build JSON responses](04_build_json_response.sql)
5. [JSONB indexing](05_jsonb_indexing.sql)
6. [Chapter summary](chapter_summary.sql)
7. [Interview questions](interview_questions.md)

## Related Chapters

- [Chapter 3: Joins](../03_joins/README.md)
- [Chapter 12: Indexes](../12_indexes/README.md)
- [Chapter 13: Performance](../13_performance/README.md)

## Difficulty

Intermediate

## Estimated Completion Time

2-3 Hours

## Useful PostgreSQL Documentation References

- [JSON Types](https://www.postgresql.org/docs/current/datatype-json.html)
- [JSON Functions and Operators](https://www.postgresql.org/docs/current/functions-json.html)
- [GIN Indexes](https://www.postgresql.org/docs/current/gin.html)
