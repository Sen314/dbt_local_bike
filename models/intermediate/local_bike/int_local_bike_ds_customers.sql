fav_product AS (
    SELECT
        orders.customer_id,
        oitem.product_id AS favorite_product_id
    FROM
        {{ ref('stg_local_bike_ds_t_orders') }} AS orders
        INNER JOIN {{ref('stg_local_bike_ds_t_order_items')}} AS oitem ON oitem.order_id = orders.order_id
    GROUP BY
        orders.customer_id,
        product_id QUALIFY ROW_NUMBER() OVER (
            PARTITION BY orders.customer_id
            ORDER BY
                SUM(oitem.quantity) DESC
        ) = 1
)

SELECT
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    customer.phone,
    customer.email,
    customer.street,
    customer.city,
    customer.state,
    customer.zip_code,
    fav_product.favorite_product_id
FROM
    {{ref("stg_local_bike_ds_t_customers")}} AS customer
    LEFT JOIN fav_product on fav_product.customer_id = customer.customer_id