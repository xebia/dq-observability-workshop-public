# Data Quality & Observability — Workshop Lab Materials

Module 2: Practitioner (4 hours). Companion to the Xebia Foundation Data Quality & Observability training.

## Prerequisites

- Python 3.9+
- Git

## Setup (do this before the session)

### 1. Clone this repo and enter the dbt project

```bash
git clone <repo-url>
cd dq-observability-workshop/dbt_project
```

### 2. Install dependencies

```bash
pip install dbt-core dbt-duckdb soda-core soda-duckdb
dbt deps
```

### 3. Load the sample data and run the models

```bash
dbt seed
dbt run
```

### 4. Verify setup

```bash
dbt test
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
