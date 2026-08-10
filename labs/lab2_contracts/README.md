# Lab 2: Contracts & Semantic Layer

**Duration:** 40 min (25 min hands-on, 15 min debrief)
**Tools:** Pen and paper or worksheet — `labs/lab2_contracts/`

## Background

A data quality standard ("orders should refresh daily") is a hope. A **data contract** is the same standard written from both sides — producer and consumer — with an enforcement mechanism attached. A **semantic layer definition** does the same thing for a metric: one formula, published once, so "revenue" doesn't mean five different numbers depending on who you ask.

Neither is real without enforcement:

> A contract without enforcement is just a Slack message with good intentions. "Please don't break my table" is not a contract. A failing CI check is.

> A definition that lives in five spreadsheets isn't a definition — it's a debate waiting to happen. "Trust me, that's how we calculate it" is not a semantic layer. A single governed metric is.

### Example: contract for `main.orders`

| Field | Value |
|-------|-------|
| Producer | Finance data engineering |
| Consumer | Analytics engineering (dbt models) |
| Guarantee | Schema-stable, refreshes within 24h |
| Enforcement | CI blocks merge on breaking schema change |

```yaml
contract for main.orders:
  producer: finance-data-eng
  consumer: analytics-eng
  freshness_sla: 24h
  on_breaking_change: block_merge
```

### Example: semantic layer definition for `revenue`

| Field | Value |
|-------|-------|
| Metric | Revenue |
| Definition | Bookings minus refunds, recognized monthly |
| Owner | Analytics Lead |
| Enforcement | All dashboards query the semantic layer — no ad-hoc SQL redefinitions |

```yaml
metric revenue:
  definition: bookings - refunds
  owner: analytics-lead
  grain: monthly
  consumers: [finance, sales, exec_bi]
```

## Your task

Use `contract_and_metric_worksheet.md`.

1. Pick a table you own or depend on daily — e.g. `main.orders` from Lab 1, or one from your own work
2. Fill in the four contract fields: Producer / Consumer / Guarantee / Enforcement
3. Pick one metric that table feeds (e.g. revenue) and write its semantic layer definition: Metric / Definition / Owner / Enforcement — not just a name for it
4. **Bonus:** where does that metric's definition live today — one semantic layer, or five spreadsheets?

**Note:** If you can't name the enforcement mechanism — for the contract or the metric — that's homework, not a placeholder. Write down what it would take to close that gap.

## Debrief questions

- Which was harder to pin down — the contract's Guarantee, or the metric's Definition?
- Is your consumer someone you've actually talked to, or an assumption?
- What breaks first if this contract — or that metric's definition — is never enforced?
