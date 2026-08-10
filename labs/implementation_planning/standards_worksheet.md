# Implementation Planning Worksheet

Take 2 standards from your Module 1 draft and convert them into runnable checks.

---

## Standard 1 → dbt Test

| Field | Your answer |
|-------|-------------|
| Standard statement | e.g. "No primary key may have nulls in production" |
| Table / model name | |
| Column being tested | |
| Test tier (built-in / dbt-expectations / singular) | |
| Owner (named person, not a team) | |
| Biggest blocker | |

Write the YAML:

```yaml
# Copy to: models/marts/schema.yml
models:
  - name:
    columns:
      - name:
        tests:
          -
```

---

## Standard 2 → Soda Check

| Field | Your answer |
|-------|-------------|
| Standard statement | e.g. "Reporting tables refresh within 24h of source" |
| Table name | |
| Pillar covered | freshness / volume / distribution / uniqueness / schema |
| Owner (named person, not a team) | |
| Biggest blocker | |

Write the SodaCL:

```yaml
# Run with: uv run soda scan -d workshop -c labs/lab3_soda/configuration.yml this_file.yml
checks for main.<table_name>:
  -
```

---

## Reflection

**Is each standard measurable?**
Could someone look at this tomorrow and verify it's being met?

> Standard 1:
> Standard 2:

**Is the owner a named person?**
Not "the data team" — who specifically gets paged when this breaks at 3am?

> Standard 1 owner:
> Standard 2 owner:

**What one conversation do you need to have this week?**

> (be specific: who, what you need to agree on, by when)
