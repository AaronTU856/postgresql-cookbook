/*
Title: Common Window Function Mistakes
Difficulty: Intermediate

Learning Objectives:
- Avoid LAST_VALUE() default-frame surprises.
- Separate window ordering from final result ordering.
- Use explicit frames when needed.

Problem Statement:
The merchandising team wants each product shown with the lowest price in its
category.

SQL Solution:
*/

SELECT
    category_id,
    name,
    price,
    LAST_VALUE(price) OVER (
        PARTITION BY category_id
        ORDER BY price DESC, id ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS lowest_price_in_category
FROM products
ORDER BY category_id ASC, price DESC;

/*
Explanation:
LAST_VALUE() needs an explicit frame when the intended last row is the last row
in the whole partition. Without the frame, PostgreSQL's default frame ends at
the current row.

Expected Output:
Each product row shows the lowest price in its category.

Business Scenario:
Merchandising reports often compare each product with the lowest or highest
price in its category.

Performance Notes:
Explicit frames make behaviour clear. They may require PostgreSQL to consider
the full partition for each row.

Common Mistakes:
- Using LAST_VALUE() without an explicit frame.
- Assuming final ORDER BY controls window calculations.
- Using window functions when GROUP BY would be simpler.

Challenge Exercise:
Show each payment with the latest paid_at value for its payment method.

Challenge Solution:
*/

SELECT
    payment_method,
    id AS payment_id,
    paid_at,
    LAST_VALUE(paid_at) OVER (
        PARTITION BY payment_method
        ORDER BY paid_at ASC NULLS LAST, id ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS latest_paid_at_for_method
FROM payments
ORDER BY payment_method ASC, paid_at ASC NULLS LAST;

/*
Related Chapters:
- 08_last_value.sql
- 12_window_best_practices.sql
- ../02_filtering_sorting/10_nulls_first_last.sql
*/
