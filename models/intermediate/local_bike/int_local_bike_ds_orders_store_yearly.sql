SELECT
    orders.store_id AS order_store_id,
    DATE_TRUNC(orders.order_date, YEAR) AS reporting_date,
    ROUND(
        SUM(
            (oitem.list_price * oitem.quantity) 
            - 
            {{ calcul_sum_order_discount('oitem.list_price', 'oitem.quantity', 'oitem.discount') }}
        )
    ,2) AS total_amount_store,
FROM
    {{ ref("stg_local_bike_ds_t_orders") }} AS orders
    INNER JOIN {{ref("stg_local_bike_ds_t_order_items")}} AS oitem ON oitem.order_id = orders.order_id
GROUP BY
    order_store_id,
    reporting_date