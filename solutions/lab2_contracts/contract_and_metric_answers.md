# Lab 2 Solution — Contract & Semantic Layer

Worked example using this repo's own models. Yours doesn't need to match — it needs a named consumer and a real enforcement mechanism.

---

## Part 1: Data Contract

**Table:** `main.orders`

| Field | Answer |
|-------|--------|
| Producer | Finance data engineering (owns `raw_orders` and the `orders` mart) |
| Consumer | Analytics engineering — `customer_lifetime_value` and any downstream dashboard reads it |
| Guarantee | Schema-stable (`order_id`, `customer_id`, `status`, `amount`, `created_at` never change type or disappear); refreshes within 24h of source arrival |
| Enforcement | CI runs `dbt test --select orders` on every PR touching `models/marts/orders.sql`; a Soda freshness check (`freshness(created_at) < 24h`) runs on a schedule against the live table |

```yaml
contract for main.orders:
  producer: finance-data-eng
  consumer: analytics-eng
  freshness_sla: 24h
  on_breaking_change: block_merge
```

---

## Part 2: Semantic Layer Definition

**Metric:** `lifetime_value` (as computed in `customer_lifetime_value`)

| Field | Answer |
|-------|--------|
| Definition | Sum of `amount` across all of a customer's orders in `stg_orders` — `sum(amount)` grouped by `customer_id`, joined onto `customers` |
| Owner | Analytics lead |
| Grain | Per-customer, all-time (not monthly — it's a running total, which is itself worth flagging) |
| Consumers | Customer Overview dashboard, Revenue by Customer report |
| Enforcement | Any dashboard reporting "lifetime value" must query `customer_lifetime_value` directly — no dashboard-layer SQL that re-sums `amount` from a different table or with different filters |

```yaml
metric lifetime_value:
  definition: sum(amount) from stg_orders, grouped by customer_id
  owner: analytics-lead
  grain: per_customer_all_time
  consumers: [customer_overview_dashboard, revenue_by_customer_report]
```

**Gap worth naming out loud:** in this repo, nothing currently stops a dashboard from recomputing `lifetime_value` with a different filter (e.g. excluding returned orders) and calling it the same name. There's no dbt Semantic Layer / MetricFlow definition wired up yet — the enforcement line above is aspirational, not real, until that's built. That gap is exactly what the debrief question "what breaks first if this is never enforced?" is pointing at.

---

## Reflection (sample answers)

**Is your consumer someone you've actually talked to, or an assumption?**
In this example, "analytics engineering" is a role, not a person — that's the honest answer most people land on. The real next step is naming who on that team actually owns the dashboards, not assuming the team knows they depend on this table.

**What breaks first if this contract — or this metric's definition — is never enforced?**
The contract: a schema change ships silently and the `customer_lifetime_value` join breaks (see Lab 4's blast radius trace for exactly this failure mode). The metric: two dashboards quietly report different "lifetime value" numbers, and nobody notices until a QBR.
