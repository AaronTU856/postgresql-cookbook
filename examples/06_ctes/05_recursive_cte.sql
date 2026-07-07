/*
Title: Basic Recursive CTE
Difficulty: Intermediate

Learning Objectives:
- Write a simple recursive CTE.
- Understand anchor and recursive query parts.
- Generate a small sequence for reporting.

Problem Statement:
The reporting team wants a simple list of page numbers for a paginated products
report.

SQL Solution:
*/

WITH RECURSIVE page_numbers AS (
    SELECT
        1 AS page_number
    UNION ALL
    SELECT
        page_number + 1
    FROM page_numbers
    WHERE page_number < 4
)
SELECT
    page_number
FROM page_numbers
ORDER BY page_number ASC;

/*
Explanation:
The anchor query starts with page_number 1. The recursive query adds one until
the stop condition page_number < 4 is no longer true.

Expected Output:
The query returns page numbers 1 through 4.

Business Scenario:
Recursive CTEs can generate small reporting sequences, calendars, or hierarchy
levels without creating a permanent helper table.

Performance Notes:
Recursive CTEs must have a clear stop condition. Without one, a query may run
far longer than intended.

Common Mistakes:
- Forgetting WITH RECURSIVE.
- Omitting the stop condition.
- Using UNION when UNION ALL is intended.

Challenge Exercise:
Generate the numbers 1 through 6 for a six-step order review checklist.

Challenge Solution:
*/

WITH RECURSIVE checklist_steps AS (
    SELECT
        1 AS step_number
    UNION ALL
    SELECT
        step_number + 1
    FROM checklist_steps
    WHERE step_number < 6
)
SELECT
    step_number
FROM checklist_steps
ORDER BY step_number ASC;

/*
Related Chapters:
- ../02_filtering_sorting/12_simple_pagination.sql
- 06_recursive_hierarchy.sql
- 10_common_cte_mistakes.sql
*/
