SELECT
    oitem_id,
    order_id,
    item_id,
    product_id,
    quantity,
    list_price,
    discount
FROM
    {{ref("stg_local_bike_ds_t_order_items")}}