# Lab 3: Blast Radius Worksheet

Work in pairs. Use this worksheet — or open `dbt docs serve` for the live version.

---

## The DAG

```
raw_customers ──► stg_customers ──► customers (mart) ──────────────► [Customer Overview dashboard]
                               └──► customer_lifetime_value (mart) ──► [Revenue by Customer report]

raw_orders ──► stg_orders ──► int_order_summary ──► customer_lifetime_value
                         └──► orders (mart) ──────────────────────────► [Operations dashboard]
```

---

## Scenario

The upstream data engineering team renamed the column `customer_id` to `client_id` in `raw_customers`. They did not notify anyone. The change deployed at 2am.

---

## Task 1: Which models break?

Circle the affected models in the DAG above, then fill in the table:

| Model | Breaks? (yes/no) | Reason |
|-------|-----------------|--------|
| `stg_customers` | | |
| `stg_orders` | | |
| `int_order_summary` | | |
| `customers` (mart) | | |
| `orders` (mart) | | |
| `customer_lifetime_value` (mart) | | |

---

## Task 2: Which outputs are affected?

| Downstream output | Affected? (yes/no) | Why? |
|-------------------|--------------------|------|
| Customer Overview dashboard | | |
| Revenue by Customer report | | |
| Operations dashboard | | |

---

## Task 3: Write a check that would have caught this

Write one dbt test OR one Soda check that would have detected this schema change **before it reached production**:

```yaml
# Your check here:




```

Which approach (dbt test vs. Soda schema check) would have been more effective, and why?

> Your answer:

---

## Task 4 (bonus): Verify with the live DAG

From the repo root, run:
```bash
uv run dbt docs generate --project-dir dbt_project --profiles-dir dbt_project
uv run dbt docs serve --project-dir dbt_project
```

Navigate to the lineage graph for `stg_customers`. Does the live graph match your manual trace? What does it show that your hand-drawn version missed?

---

## Reflection

- If this rename happened at 2am on a Sunday, how would your team have found out?
- Who should have been notified before this change was deployed?
- What process or check would prevent this from happening silently next time?
