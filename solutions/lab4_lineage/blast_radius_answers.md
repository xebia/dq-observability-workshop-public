# Lab 4 Solution — Blast Radius Answers

## Scenario: `customer_id` renamed to `client_id` in `raw_customers`

---

## Task 1: Which models break?

| Model | Breaks? | Reason |
|-------|---------|--------|
| `stg_customers` | **YES** | Directly selects `id as customer_id` from `raw_customers` — the source column is gone |
| `stg_orders` | NO | Only reads from `raw_orders`, which is unaffected |
| `int_order_summary` | NO | Only reads from `stg_orders` |
| `customers` (mart) | **YES** | Selects from `stg_customers`, which is broken |
| `orders` (mart) | NO | Selects from `stg_orders` only |
| `customer_lifetime_value` (mart) | **YES** | Joins on `c.customer_id` from `stg_customers`, which is broken |

**Blast radius: 3 models** — stg_customers, customers, customer_lifetime_value

---

## Task 2: Which outputs are affected?

| Downstream output | Affected? | Why? |
|-------------------|-----------|----|
| Customer Overview dashboard | **YES** | Depends on `customers` mart |
| Revenue by Customer report | **YES** | Depends on `customer_lifetime_value` |
| Operations dashboard | **NO** | Depends on `orders` mart only — unaffected |

---

## Task 3: Check that would have caught this

**Option A — dbt test (catches at build time if the column disappears):**
```yaml
models:
  - name: stg_customers
    columns:
      - name: customer_id
        tests:
          - not_null
```
This would fail immediately when the upstream column rename makes `customer_id` null or missing.

**Option B — Soda schema check (more explicit about required columns):**
```yaml
checks for main.stg_customers:
  - schema:
      fail:
        when required column missing: [customer_id, name, email]
```

**Which is more effective?**
The Soda schema check is more precise — it explicitly asserts that `customer_id` must exist as a column, which is exactly what the rename breaks. The `not_null` dbt test would also fail, but for a less obvious reason (the column doesn't exist, not that values are null). In practice, use both: the dbt test in CI, the Soda check in production monitoring.

---

## Blast radius summary

```
raw_customers (renamed column)
    └──► stg_customers        BROKEN — hop 1
             └──► customers   BROKEN — hop 2 → Customer Overview dashboard DOWN
             └──► customer_lifetime_value  BROKEN — hop 2 → Revenue by Customer DOWN

raw_orders (unaffected)
    └──► stg_orders           OK
             └──► orders      OK → Operations dashboard fine
             └──► int_order_summary  OK
                      └──► customer_lifetime_value  BROKEN (via stg_customers join)
```

**Key lesson:** The Operations dashboard is fine. Blast radius analysis is about precision — not everything downstream of the change breaks, only the path that depends on the changed column.
