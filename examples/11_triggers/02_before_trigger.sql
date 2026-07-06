/*
Title: BEFORE Trigger
Difficulty: Intermediate

Learning objectives:
- Use a BEFORE trigger to adjust NEW values.
- Maintain updated timestamps.
- Practise trigger logic on a temporary table.

Problem statement:
Merchandising wants a product review table that updates its timestamp whenever a
review note changes.

Business scenario:
Operational tables often need updated_at maintained consistently no matter which
application edits the row.

SQL solution:
*/

CREATE TEMP TABLE cookbook_product_reviews (
    product_id BIGINT PRIMARY KEY,
    review_note TEXT NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

DROP FUNCTION IF EXISTS cookbook_set_review_updated_at();

CREATE FUNCTION cookbook_set_review_updated_at()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_reviews_set_updated_at
BEFORE UPDATE ON cookbook_product_reviews
FOR EACH ROW
EXECUTE FUNCTION cookbook_set_review_updated_at();

INSERT INTO cookbook_product_reviews (product_id, review_note)
VALUES (1, 'Initial product review');

UPDATE cookbook_product_reviews
SET review_note = 'Updated product review'
WHERE product_id = 1;

SELECT
    product_id,
    review_note,
    updated_at
FROM cookbook_product_reviews;

/*
Explanation:
The BEFORE trigger modifies NEW.updated_at before PostgreSQL stores the updated
row.

Expected output:
The product review row shows the updated review note and a maintained timestamp.

Performance considerations:
Simple timestamp triggers are usually cheap, but they still run once per updated
row.

Common mistakes:
- Forgetting to return NEW from a BEFORE UPDATE trigger.
- Updating timestamps in application code inconsistently.
- Using a trigger when a generated column would be clearer.

Challenge:
Add a BEFORE INSERT trigger pattern that sets a default review note when one is
missing.

Challenge solution:
*/

SELECT
    'Use NEW.review_note := COALESCE(NEW.review_note, ''Needs review'') in a BEFORE INSERT trigger.'
        AS suggested_solution;

/*
Related chapters:
- ../10_functions/04_sql_vs_plpgsql.sql
- 01_audit_trigger.sql
- 05_common_trigger_mistakes.sql
*/
