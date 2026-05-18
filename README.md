# Data Quality & Observability — Workshop Lab Materials

Module 2: Practitioner (4 hours). Companion to the Xebia Foundation Data Quality & Observability training.

## Prerequisites

- [uv](https://docs.astral.sh/uv/getting-started/installation/) — `curl -LsSf https://astral.sh/uv/install.sh | sh`
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
uv run dbt deps --project-dir dbt_project --profiles-dir dbt_project
```

### 3. Load the sample data and run the models

```bash
uv run dbt seed --project-dir dbt_project --profiles-dir dbt_project
uv run dbt run --project-dir dbt_project --profiles-dir dbt_project
```

### 4. Verify setup

```bash
uv run dbt test --project-dir dbt_project --profiles-dir dbt_project
```

Most tests will **fail** before Lab 1 — that's expected. The sample data has deliberate quality problems.

## Labs

| Lab | Topic | Duration | Folder |
|-----|-------|----------|--------|
| Lab 1 | dbt Tests | 65 min | `labs/lab1_dbt_tests/` |
| Lab 2 | Soda Checks | 65 min | `labs/lab2_soda/` |
| Lab 3 | Lineage & Blast Radius | 35 min | `labs/lab3_lineage/` |
| Lab 4 | Implementation Planning | 35 min | `labs/lab4_implementation/` |

Solutions are in `solutions/`. Try not to peek until you've given it a go.

## The DAG

```
raw_customers ──► stg_customers ──► customers (mart)
                               └──► customer_lifetime_value (mart)

raw_orders ──► stg_orders ──► int_order_summary ──► customer_lifetime_value
                         └──► orders (mart)
```
