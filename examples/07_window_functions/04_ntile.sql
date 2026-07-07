/*
Title: NTILE
Difficulty: Intermediate

Learning Objectives:
- Use NTILE() to divide ordered rows into buckets.
- Segment products by price.
- Understand bucket-based reporting.

Problem Statement:
The merchandising team wants products divided into four price bands.

SQL Solution:
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

Expected Output:
The query returns products assigned to four price quartiles.

Business Scenario:
Product teams can use buckets to analyse premium, mid-range, and lower-priced
items.

Performance Notes:
NTILE() requires a sorted window. The cost grows with the number of rows being
bucketed.

Common Mistakes:
- Thinking NTILE values are exact business categories.
- Forgetting that bucket sizes may differ when rows do not divide evenly.
- Omitting a stable tie-breaker.

Challenge Exercise:
Divide payments into three buckets by amount from highest to lowest.

Challenge Solution:
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
Related Chapters:
- 01_row_number.sql
- 02_rank.sql
- ../04_aggregates/03_avg.sql
*/
