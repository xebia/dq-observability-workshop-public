# Data Quality & Observability — Workshop Lab Materials

Module 2: Practitioner (4 hours). Companion to the Xebia Foundation Data Quality & Observability training.

## Prerequisites

- [uv](https://docs.astral.sh/uv/getting-started/installation/)
- Git

`uv` manages Python automatically — no separate Python installation needed.

## Setup (do this before the session)

### 1. Clone this repo

```bash
git clone <repo-url>
cd dq-observability-workshop
```

### 2. Install dependencies

```bash
uv sync
```

### 3. Install dbt packages and build the project

```bash
uv run dbt deps
uv run dbt seed
uv run dbt run
```

You should see `PASS=6` — all 6 models built. The repo includes `profiles.yml`, so no dbt profile setup is needed.

### 4. Verify setup

```bash
uv run soda scan -d workshop -c labs/lab3_soda/configuration.yml labs/setup_check.yml
```

You should see `1/1 checks PASSED`. You're ready.

**Note:** the sample data contains deliberate quality problems — that's the point of the labs. Don't fix them.

## Labs

| Lab | Topic | Duration | Folder |
|-----|-------|----------|--------|
| Lab 1 | dbt Tests | 65 min | `labs/lab1_dbt_tests/` |
| Lab 2 | Contracts & Semantic Layer | 40 min | `labs/lab2_contracts/` |
| Lab 3 | Soda Checks | 65 min | `labs/lab3_soda/` |
| Lab 4 | Lineage & Blast Radius | 35 min | `labs/lab4_lineage/` |
| — | Implementation Planning | 20 min | `labs/implementation_planning/` |

Solutions are in `solutions/`. Try not to peek until you've given it a go.

## The DAG

```
raw_customers ──► stg_customers ──► customers (mart)
                               └──► customer_lifetime_value (mart)

raw_orders ──► stg_orders ──► int_order_summary ──► customer_lifetime_value
                         └──► orders (mart)
```
