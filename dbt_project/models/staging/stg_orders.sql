select
    order_id,
    customer_id,
    status,
    amount,
    created_at
from {{ ref('raw_orders') }}
