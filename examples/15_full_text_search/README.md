# Chapter 15: Full Text Search

## Overview

Full Text Search lets PostgreSQL search natural-language text using tokens,
ranking, dictionaries, and indexes. It is useful for product catalogues, help
centres, article search, and internal admin tools.

## Key Concepts

- `to_tsvector` converts text into searchable tokens.
- `plainto_tsquery` converts user text into a safe query.
- `websearch_to_tsquery` supports familiar search syntax.
- `@@` checks whether a vector matches a query.
- `ts_rank` scores search results.
- GIN indexes support efficient full-text search.

## Learning Outcomes

- Build searchable text vectors.
- Search product names and descriptions.
- Rank search results.
- Generate highlighted snippets.
- Create full-text search indexes.
- Avoid unsafe or unrealistic search patterns.

## When To Use The Feature

Use Full Text Search when users need word-based search inside PostgreSQL and the
requirements do not yet justify a separate search engine.

## When NOT To Use The Feature

Avoid it for fuzzy typo-heavy search, autocomplete-heavy UX, very advanced
relevance tuning, or cross-system search where a dedicated search platform may
fit better.

## Syntax Overview

```sql
to_tsvector('english', text_column) @@ plainto_tsquery('english', 'search text')
```

## Best Practices

- Use `plainto_tsquery` or `websearch_to_tsquery` for user input.
- Combine relevant columns into one vector.
- Weight important fields higher.
- Add GIN indexes for production search.
- Keep search result ordering deterministic.

## Performance Considerations

Full-text search can scan heavily without indexes. Use GIN indexes for frequent
search queries and test with realistic catalogue size.

## Common Mistakes

- Using `LIKE '%term%'` for production search at scale.
- Building unsafe raw `tsquery` strings from user input.
- Forgetting ranking and deterministic tie-breakers.
- Expecting full-text search to solve typo tolerance automatically.

## Business Examples

- Product catalogue search.
- Technical book search.
- Admin product lookup.
- Highlighted search snippets.
- Ranked help-centre style results.

## Interview Tips

Explain that Full Text Search is token-based, not simple substring matching.
Mention `tsvector`, `tsquery`, ranking, and GIN indexes.

## Recommended Learning Order

1. [Basic text search](01_basic_text_search.sql)
2. [Search multiple columns](02_search_multiple_columns.sql)
3. [Rank search results](03_rank_search_results.sql)
4. [Search headlines](04_search_headlines.sql)
5. [Full text search index](05_full_text_search_index.sql)
6. [Chapter summary](chapter_summary.sql)
7. [Interview questions](interview_questions.md)

## Related Chapters

- [Chapter 12: Indexes](../12_indexes/README.md)
- [Chapter 13: Performance](../13_performance/README.md)
- [Chapter 14: JSONB](../14_jsonb/README.md)

## Difficulty

Intermediate

## Estimated Completion Time

2-3 Hours

## Useful PostgreSQL Documentation References

- [Full Text Search](https://www.postgresql.org/docs/current/textsearch.html)
- [Text Search Functions](https://www.postgresql.org/docs/current/functions-textsearch.html)
- [GIN Indexes](https://www.postgresql.org/docs/current/gin.html)
