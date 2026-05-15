select
    c.customer_id,
    c.name,
    coalesce(o.order_count, 0) as order_count,
    coalesce(o.total_spend, 0) as lifetime_value
from {{ ref('stg_customers') }} c
left join {{ ref('int_order_summary') }} o
    on c.customer_id = o.customer_id
