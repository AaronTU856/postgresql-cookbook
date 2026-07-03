# Project Philosophy

PostgreSQL Cookbook is a practical learning repository for developers who want to understand PostgreSQL through realistic, runnable examples.

## Goals

- Teach PostgreSQL fundamentals in a clear sequence.
- Use examples that resemble backend application work.
- Keep setup simple enough for local practice.
- Provide a reference that is useful for junior developers, graduate developers, Django developers, and backend engineers.
- Maintain a professional open-source structure suitable for portfolio review.

## Target Audience

This project is written for learners who know basic programming concepts and want stronger database skills. It is especially useful for developers working with backend APIs, Django applications, reporting queries, or relational data models.

## Learning Style

Examples should be small, concrete, and repeatable. Each file should explain:

- the problem being solved
- the SQL solution
- what result to expect
- where the pattern appears in real projects
- common mistakes
- a short challenge with a solution

The repository should avoid large abstract SQL dumps. A learner should be able to open one file, run it, understand it, and modify it.

## Repository Standards

- SQL must run against the supplied schema and seed data.
- SQL keywords use uppercase.
- Files should use consistent headings and comments.
- Documentation should link to related chapters where useful.
- New material should be added in small, reviewable increments.
- Beginner chapters should avoid advanced concepts unless they are explicitly introduced.

## How Examples Are Organised

Examples are grouped by chapter under `examples/`. Each chapter focuses on one learning area and should include a chapter README before it grows beyond a few files.

The sample database represents a small online store. This keeps examples realistic while giving learners familiar concepts: users, products, categories, orders, order items, and payments.
