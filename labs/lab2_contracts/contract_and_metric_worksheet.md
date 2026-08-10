# Lab 2: Contract & Semantic Layer Worksheet

Work individually. Pick a table you own or depend on daily — `main.orders` from Lab 1 is a fine default if nothing from your own work comes to mind.

---

## Part 1: Data Contract

**Table:** ____________________

| Field | Your answer |
|-------|-------------|
| Producer (who owns/ships this table?) | |
| Consumer (who reads it — a team or system, named) | |
| Guarantee (schema stability? freshness SLA? both?) | |
| Enforcement (the actual mechanism — a CI check, a test, an alert) | |

Write it as YAML, in the same shape as the `main.orders` example:

```yaml
contract for <table>:
  producer:
  consumer:
  freshness_sla:
  on_breaking_change:
```

---

## Part 2: Semantic Layer Definition

Pick one metric that the table above feeds — e.g. revenue, active users, churn rate.

**Metric:** ____________________

| Field | Your answer |
|-------|-------------|
| Definition (the actual formula, not a description of it) | |
| Owner (a named person) | |
| Grain (daily / monthly / per-order / …) | |
| Consumers (who queries this metric today) | |
| Enforcement (what stops someone from redefining it in a dashboard) | |

```yaml
metric <name>:
  definition:
  owner:
  grain:
  consumers: []
```

---

## Bonus

Where does this metric's definition live **today** — one governed semantic layer, or scattered across dashboards and spreadsheets? If it's scattered, how many different versions of the formula have you actually seen?

> Your answer:

---

## Reflection

**Is your consumer someone you've actually talked to, or an assumption?**

> Your answer:

**If you can't name the enforcement mechanism for the contract or the metric, what would it take to build one?**

> Your answer:

**What breaks first if this contract — or this metric's definition — is never enforced?**

> Your answer:
