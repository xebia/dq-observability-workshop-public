# Lab 1: dbt Tests

**Duration:** 50 min (35 min hands-on, 15 min debrief)
**Tools:** dbt, your terminal

## Background

The sample project has 4 deliberate quality problems seeded into `raw_orders`. Your job is to write dbt tests that catch all 4.

There are three tiers of dbt tests:

| Tier | What it covers | Examples |
|------|---------------|---------|
| Built-in | Nulls, uniqueness, accepted values, foreign keys | `not_null`, `unique`, `accepted_values`, `relationships` |
| dbt-expectations | Richer checks: value ranges, regex, row counts | `expect_column_values_to_be_between` |
| Singular tests | Custom SQL — any business rule returning failing rows | any `.sql` file in `tests/` |

## Your task

1. Open `labs/lab1_dbt_tests/schema_template.yml` and fill in the blanks
2. Copy the completed file to `models/marts/schema.yml`
3. From the repo root, run:
   ```bash
   uv run dbt test --select orders
   ```
4. All 4 tests should **fail** on first run — that means your tests are finding real problems
5. Do not fix the data. The goal is tests that accurately report what's broken.

**Hint:** Read `seeds/raw_orders.csv` carefully. The 4 issues are visible if you look.

## Debrief questions

- Which of the 6 quality dimensions from Module 1 did your tests cover?
- Which tier did you use for each test?
- Was there a problem in the data you couldn't express as a dbt test? Why?
