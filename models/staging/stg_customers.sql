select
    id as customer_id,
    name,
    email
from {{ ref('raw_customers') }}
