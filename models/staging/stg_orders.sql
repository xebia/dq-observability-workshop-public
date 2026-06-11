-- The seed CSV has fixed dates. To keep the freshness exercise in Lab 2
-- working no matter when the workshop runs, we shift all dates forward
-- so the newest order is always 2 days old. Relative spacing is preserved.

with date_shift as (
    select (current_date - 2 - max(created_at))::integer as days
    from {{ ref('raw_orders') }}
)

select
    order_id,
    customer_id,
    status,
    amount,
    created_at + (select days from date_shift) as created_at
from {{ ref('raw_orders') }}
