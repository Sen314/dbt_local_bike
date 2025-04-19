WITH orders_per_customer AS (
SELECT 
    orders.customer_id,
    SUM(orders.amount_without_discount - discount_amount) AS total_amount_spent,
    SUM(orders.qty_per_order) as total_items,
    SUM(orders.nb_distinct_product) as total_distinct_items,
    COUNT(DISTINCT order_id) AS total_orders
FROM {{ref('int_local_bike_ds_orders')}} AS orders
GROUP BY
    orders.customer_id
),

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
    fav_product.favorite_product_id,
    orders_customer.total_amount_spent,
    orders_customer.total_items,
    orders_customer.total_distinct_items,
    orders_customer.total_orders
FROM
    {{ref("stg_local_bike_ds_t_customers")}} AS customer
    LEFT JOIN fav_product on fav_product.customer_id = customer.customer_id
    LEFT JOIN orders_per_customer AS orders_customer ON orders_customer.customer_id = customer.customer_id