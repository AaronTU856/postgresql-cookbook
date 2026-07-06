/*
Title: Recursive Hierarchy
Difficulty: Intermediate

Learning objectives:
- Model hierarchy traversal with a recursive CTE.
- Build readable category paths.
- Understand parent-child recursion.

Problem statement:
The merchandising team wants a category navigation tree for store reporting.

SQL solution:
*/

WITH RECURSIVE category_tree AS (
    SELECT
        category_nodes.id,
        category_nodes.parent_id,
        category_nodes.name,
        category_nodes.name AS category_path,
        1 AS depth
    FROM (
        VALUES
            (1, NULL::integer, 'Store'),
            (2, 1, 'Books'),
            (3, 1, 'Stationery'),
            (4, 1, 'Electronics'),
            (5, 1, 'Home Office')
    ) AS category_nodes(id, parent_id, name)
    WHERE category_nodes.parent_id IS NULL
    UNION ALL
    SELECT
        child_nodes.id,
        child_nodes.parent_id,
        child_nodes.name,
        category_tree.category_path || ' > ' || child_nodes.name AS category_path,
        category_tree.depth + 1 AS depth
    FROM (
        VALUES
            (1, NULL::integer, 'Store'),
            (2, 1, 'Books'),
            (3, 1, 'Stationery'),
            (4, 1, 'Electronics'),
            (5, 1, 'Home Office')
    ) AS child_nodes(id, parent_id, name)
    INNER JOIN category_tree
        ON category_tree.id = child_nodes.parent_id
)
SELECT
    id,
    name,
    category_path,
    depth
FROM category_tree
ORDER BY category_path ASC;

/*
Explanation:
The anchor query starts at the root Store node. The recursive query finds child
nodes and appends their names to the category path.

Expected results:
The query returns a small category hierarchy with Store as the root and the
sample product categories underneath it.

Real-world example:
Recursive CTEs are commonly used for category trees, menu structures, reporting
rollups, and organisation charts.

Performance notes:
Recursive hierarchy queries need indexes on parent identifiers in real tables.
This example uses inline values to demonstrate the pattern without changing the
sample schema.

Common mistakes:
- Forgetting to define the root rows.
- Recursing without a parent-child join.
- Building paths without a stable ordering rule.

Challenge exercise:
Create a simple order workflow hierarchy from Order Lifecycle to Paid and
Delivered statuses.

Challenge solution:
*/

WITH RECURSIVE workflow_tree AS (
    SELECT
        workflow_nodes.id,
        workflow_nodes.parent_id,
        workflow_nodes.name,
        workflow_nodes.name AS workflow_path,
        1 AS depth
    FROM (
        VALUES
            (1, NULL::integer, 'Order Lifecycle'),
            (2, 1, 'Paid'),
            (3, 2, 'Shipped'),
            (4, 3, 'Delivered')
    ) AS workflow_nodes(id, parent_id, name)
    WHERE workflow_nodes.parent_id IS NULL
    UNION ALL
    SELECT
        child_nodes.id,
        child_nodes.parent_id,
        child_nodes.name,
        workflow_tree.workflow_path || ' > ' || child_nodes.name AS workflow_path,
        workflow_tree.depth + 1 AS depth
    FROM (
        VALUES
            (1, NULL::integer, 'Order Lifecycle'),
            (2, 1, 'Paid'),
            (3, 2, 'Shipped'),
            (4, 3, 'Delivered')
    ) AS child_nodes(id, parent_id, name)
    INNER JOIN workflow_tree
        ON workflow_tree.id = child_nodes.parent_id
)
SELECT
    id,
    name,
    workflow_path,
    depth
FROM workflow_tree
ORDER BY depth ASC;

/*
Related examples:
- 05_recursive_cte.sql
- ../03_joins/06_self_join.sql
- 10_common_cte_mistakes.sql
*/
