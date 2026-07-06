/*
Title: Annotate And Aggregate
Difficulty: Intermediate

Learning objectives:
- Map Django annotate to GROUP BY SQL.
- Calculate customer value.
- Use filtered aggregates.

Problem statement:
The customer admin page needs completed payment totals per customer.

Business scenario:
Django admin and reporting pages often use annotate to display counts and totals
beside model rows.

SQL solution:
*/

SELECT
    users.id AS user_id,
    users.email,
    COUNT(DISTINCT orders.id) AS order_count,
    COALESCE(
        SUM(payments.amount) FILTER (WHERE payments.status = 'completed'),
        0
    ) AS completed_payment_total
FROM users
LEFT JOIN orders
    ON orders.user_id = users.id
LEFT JOIN payments
    ON payments.order_id = orders.id
GROUP BY
    users.id,
    users.email
ORDER BY completed_payment_total DESC, users.email ASC;

/*
Explanation:
This mirrors a Django annotate query that adds order_count and completed payment
total to each user row.

Expected output:
Each customer appears with order count and completed payment total.

Performance considerations:
Annotated QuerySets can generate complex SQL. Inspect generated SQL and indexes
for admin pages that grow slow.

Common mistakes:
- Counting duplicate rows after joins.
- Forgetting COALESCE for customers without payments.
- Adding annotations to every admin page without checking cost.

Challenge:
Annotate categories with active product count.

Challenge solution:
*/

SELECT
    categories.name AS category_name,
    COUNT(products.id) FILTER (WHERE products.is_active = TRUE) AS active_product_count
FROM categories
LEFT JOIN products
    ON products.category_id = categories.id
GROUP BY categories.name
ORDER BY category_name ASC;

/*
Related chapters:
- ../04_aggregates/10_business_reports.sql
- ../09_views/10_business_reporting_view.sql
- 03_avoid_n_plus_one_django.sql
*/
