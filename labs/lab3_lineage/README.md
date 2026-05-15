# Lab 3: Lineage & Blast Radius

**Duration:** 35 min (20 min pairs, 15 min group share)
**Tools:** `blast_radius_worksheet.md` + optional: `dbt docs serve`

## Background

dbt's DAG shows the dependency chain from source to output. When a model breaks, everything downstream breaks with it — that's the blast radius. Knowing the blast radius before a change deploys is the difference between a controlled incident and a 3am scramble.

## Your task

Work in pairs using `blast_radius_worksheet.md`.

**Optional (bonus):** run the following from `dbt_project/` to see the live lineage graph:
```bash
dbt docs generate
dbt docs serve
```

## Debrief questions

- How many hops did the blast radius travel from the changed column to the broken dashboards?
- What's the difference between catching this with a dbt test vs. a Soda schema check?
- How would you communicate this breaking change to downstream teams before deploying?
