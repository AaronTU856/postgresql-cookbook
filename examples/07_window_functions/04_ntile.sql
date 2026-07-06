/*
Title: NTILE
Difficulty: Intermediate

Learning objectives:
- Use NTILE() to divide ordered rows into buckets.
- Segment products by price.
- Understand bucket-based reporting.

Problem statement:
The merchandising team wants products divided into four price bands.

SQL solution:
*/

SELECT
    name,
    price,
    NTILE(4) OVER (
        ORDER BY price DESC, id ASC
    ) AS price_quartile
FROM products
ORDER BY price_quartile ASC, price DESC;

/*
Explanation:
NTILE(4) divides the ordered product rows into four buckets. Bucket 1 contains
the highest-priced products because the window orders by price descending.

Expected results:
The query returns products assigned to four price quartiles.

Real-world example:
Product teams can use buckets to analyse premium, mid-range, and lower-priced
items.

Performance notes:
NTILE() requires a sorted window. The cost grows with the number of rows being
bucketed.

Common mistakes:
- Thinking NTILE values are exact business categories.
- Forgetting that bucket sizes may differ when rows do not divide evenly.
- Omitting a stable tie-breaker.

Challenge exercise:
Divide payments into three buckets by amount from highest to lowest.

Challenge solution:
*/

SELECT
    id AS payment_id,
    amount,
    NTILE(3) OVER (
        ORDER BY amount DESC, id ASC
    ) AS amount_bucket
FROM payments
ORDER BY amount_bucket ASC, amount DESC;

/*
Related examples:
- 01_row_number.sql
- 02_rank.sql
- ../04_aggregates/03_avg.sql
*/
