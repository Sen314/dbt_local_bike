select
    order_id,
    amount_with_discount
from {{ ref('int_local_bike_ds_orders') }}
WHERE amount_with_discount < 0