/*
Title: Django Model Query Shape
Difficulty: Beginner

Learning Objectives:
- Map a simple QuerySet to SQL.
- Understand filtering and ordering.
- Select only fields needed by an API.

Problem Statement:
A Django API endpoint lists paid orders ordered newest first.

Business Scenario:
Order list endpoints should return only fields the client needs and use indexes
that match common filters.

SQL Solution:
*/

SELECT
    id AS order_id,
    status,
    order_date,
    shipping_city
FROM orders
WHERE status = 'paid'
ORDER BY order_date DESC;

/*
Explanation:
This is the SQL shape behind a Django QuerySet such as
Order.objects.filter(status="paid").order_by("-order_date").

Expected Output:
Paid orders are returned newest first with selected API fields.

Performance Notes:
Frequent filters such as status and ordering by order_date may need a composite
index as the table grows.

Common Mistakes:
- Returning every model field by default.
- Forgetting ordering is part of the query cost.
- Assuming the ORM removes the need to understand SQL.

Challenge Exercise:
Write the SQL shape for active products ordered by name.

Challenge Solution:
*/

SELECT
    id AS product_id,
    name,
    price
FROM products
WHERE is_active = TRUE
ORDER BY name ASC;

/*
Related Chapters:
- ../02_filtering_sorting/05_order_by.sql
- ../12_indexes/02_composite_index.sql
- 06_indexes_for_django_filters.sql
*/
