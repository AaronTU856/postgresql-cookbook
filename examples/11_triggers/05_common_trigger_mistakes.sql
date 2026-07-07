/*
Title: Common Trigger Mistakes
Difficulty: Intermediate

Learning Objectives:
- Recognise hidden trigger side effects.
- Avoid recursive updates.
- Keep trigger behaviour easy to review.

Problem Statement:
The team wants to review safe trigger design before using triggers in production.

Business Scenario:
Triggers can protect data, but they can also surprise developers if they hide
important behaviour.

SQL Solution:
*/

SELECT
    trigger_name,
    event_manipulation,
    event_object_table,
    action_timing
FROM information_schema.triggers
WHERE trigger_schema = 'public'
ORDER BY event_object_table ASC, trigger_name ASC;

/*
Explanation:
Inspecting existing triggers helps developers understand what automatic database
logic may run during writes.

Expected Output:
The query lists public triggers created by this chapter if previous trigger
examples have been executed.

Performance Notes:
Trigger visibility is an operational concern. Production teams should document
triggers and monitor write latency.

Common Mistakes:
- Creating recursive trigger updates accidentally.
- Hiding major workflows in triggers.
- Forgetting that bulk updates fire row triggers for every changed row.
- Failing to inspect existing triggers during debugging.

Challenge Exercise:
Find triggers attached to the products table.

Challenge Solution:
*/

SELECT
    trigger_name,
    action_timing,
    event_manipulation
FROM information_schema.triggers
WHERE event_object_table = 'products'
ORDER BY trigger_name ASC;

/*
Related Chapters:
- ../10_functions/10_common_function_mistakes.sql
- ../13_performance/README.md
- 03_validation_trigger.sql
*/
