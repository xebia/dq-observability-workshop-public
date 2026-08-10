# Lab 3: Soda Checks

**Duration:** 65 min (50 min hands-on, 15 min debrief)
**Tools:** Soda Core, your terminal

## Background

dbt tests run at build time. Soda checks run on a schedule — watching live tables continuously for freshness, volume drift, and distribution anomalies. They're complementary, not substitutes.

| Pillar (from Module 1) | Soda check type |
|------------------------|----------------|
| Volume | `row_count` |
| Freshness | `freshness(column)` |
| Distribution | `values in (column) between x and y` |
| Uniqueness | `duplicate_count(column)` |
| Schema | `schema` checks (advanced) |

## Your task

1. Open `labs/lab3_soda/checks_template.yml` and fill in the blanks
2. Make sure the dbt project is built first:
   ```bash
   uv run dbt seed && uv run dbt run
   ```
3. Run your checks from the repo root:
   ```bash
   uv run soda scan -d workshop -c labs/lab3_soda/configuration.yml labs/lab3_soda/checks_template.yml
   ```
4. Once checks run, **deliberately break one**:
   - Delete 3 rows from `seeds/raw_orders.csv`
   - Run `uv run dbt seed && uv run dbt run` again
   - Run `uv run soda scan` again — which check breaks?

**Note:** The table name in Soda for DuckDB is `main.orders` (DuckDB's default schema is `main`).

## Debrief questions

- Which pillars do your Soda checks cover that Lab 1's dbt tests did not?
- Look at your Module 1 pillar reflection grid — how many ❌s are now ✅?
- What would a schema change check look like? Why is it harder than the others?
