SELECT
    CONCAT(order_id, '_', item_id, '_', product_id) AS oitem_id,
    order_id,
    item_id,
    product_id,
    quantity,
    list_price,
    discount
FROM
    {{source("local_bike_ds","t_order_items")}}