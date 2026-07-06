/*
Title: Pagination Performance
Difficulty: Intermediate

Learning objectives:
- Understand offset pagination.
- Use keyset-style pagination for stable scrolling.
- Order by deterministic columns.

Problem statement:
The order history page needs stable pagination.

Business scenario:
Offset pagination is simple, but deep pages become expensive as tables grow.

SQL solution:
*/

SELECT
    id AS order_id,
    status,
    order_date
FROM orders
ORDER BY order_date DESC, id DESC
LIMIT 3;

SELECT
    id AS order_id,
    status,
    order_date
FROM orders
WHERE (order_date, id) < ('2026-02-15 18:20:00+00'::TIMESTAMPTZ, 4)
ORDER BY order_date DESC, id DESC
LIMIT 3;

/*
Explanation:
The first query fetches the first page. The second query uses the last seen
order_date and id as a cursor for the next page.

Expected output:
Both queries return small, stable pages of orders.

Performance considerations:
Keyset pagination avoids skipping large numbers of rows, but it requires stable
ordering and cursor values.

Common mistakes:
- Ordering by a non-unique column only.
- Using high OFFSET values for deep pages.
- Returning unstable pages when rows share the same timestamp.

Challenge:
Build a keyset-style page for completed payments ordered by paid_at and id.

Challenge solution:
*/

SELECT
    id AS payment_id,
    amount,
    paid_at
FROM payments
WHERE status = 'completed'
  AND (paid_at, id) < ('2026-02-20 08:44:00+00'::TIMESTAMPTZ, 6)
ORDER BY paid_at DESC, id DESC
LIMIT 3;

/*
Related chapters:
- ../02_filtering_sorting/12_simple_pagination.sql
- ../12_indexes/05_covering_index.sql
- 01_explain_basics.sql
*/
