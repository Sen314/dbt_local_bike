WITH total_per_orders AS (
    SELECT
        oitem.order_id,
        SUM(oitem.quantity) AS qty_per_order,
        COUNT(oitem.product_id) AS nb_distinct_product,
        SUM(oitem.list_price * oitem.quantity) AS amount_without_discount,
        SUM((oitem.list_price * oitem.quantity) * oitem.discount ) AS discount_amount
    FROM {{ref("stg_local_bike_ds_t_order_items")}} AS oitem
    GROUP BY
        oitem.order_id
)

SELECT
    orders.order_id,
    orders.customer_id,
    orders.order_status,
    orders.order_date,
    orders.required_date,
    orders.shipped_date,
    orders.store_id,
    orders.staff_id,
    total.nb_distinct_product,
    total.amount_without_discount,
    total.discount_amount,
    total.qty_per_order,
    (total.amount_without_discount - total.discount_amount) AS amount_with_discount
FROM
    {{ref("stg_local_bike_ds_t_orders")}} AS orders
    INNER JOIN total_per_orders AS total ON total.order_id = orders.order_id