/*
Title: SELF JOIN Customers in the Same Country
Difficulty: Intermediate

Learning objectives:
- Join a table to itself using aliases.
- Compare rows within the same table.
- Avoid duplicate mirrored pairs.

Problem statement:
Marketing wants to identify pairs of customers in the same country for regional
campaign analysis.

Business scenario:
Self joins are useful when records in one table need to be compared with other
records in that same table, such as customers in the same region.

SQL solution:
*/

SELECT
    first_user.email AS first_customer_email,
    second_user.email AS second_customer_email,
    first_user.country
FROM users AS first_user
INNER JOIN users AS second_user
    ON second_user.country = first_user.country
    AND second_user.id > first_user.id
ORDER BY first_user.email ASC, second_user.email ASC;

/*
Explanation:
The users table appears twice with different aliases. The country condition
matches customers in the same country. The id comparison prevents a customer
from matching themselves and avoids duplicate mirrored pairs.

Expected output:
Because all sample users are in the United Kingdom, the query returns every
unique pair of users.

Performance notes:
Self joins can grow quickly because each row may be compared with many other
rows. Add selective conditions when possible.

Common mistakes:
- Forgetting aliases when joining a table to itself.
- Matching each row to itself.
- Returning duplicate mirrored pairs such as A-B and B-A.

Challenge exercise:
Find pairs of products in the same category.

Challenge solution:
*/

SELECT
    first_product.name AS first_product_name,
    second_product.name AS second_product_name,
    first_product.category_id
FROM products AS first_product
INNER JOIN products AS second_product
    ON second_product.category_id = first_product.category_id
    AND second_product.id > first_product.id
ORDER BY first_product.category_id ASC, first_product.name ASC;

/*
Related chapters:
- ../01_basic_queries/README.md
- ../02_filtering_sorting/README.md
- README.md
*/
