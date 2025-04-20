SELECT 
    DATE_TRUNC(order_date, MONTH) AS reporting_date,
    CONCAT(staff.last_name, ' ', staff.first_name) AS seller_name,
    stores.store_name,
    COUNT(DISTINCT orders.order_id) AS total_orders,
    AVG(orders.amount_with_discount) AS average_total_order_amount
FROM {{ ref('int_local_bike_ds_orders') }} AS orders
INNER JOIN {{ ref('int_local_bike_ds_staffs')}} AS staff ON staff.staff_id = orders.staff_id
INNER JOIN {{ ref('int_local_bike_ds_stores')}} AS stores ON stores.store_id = orders.store_id
GROUP BY 
    reporting_date,
    seller_name,
    store_name
ORDER BY
    reporting_date