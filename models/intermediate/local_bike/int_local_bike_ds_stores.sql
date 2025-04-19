WITH customer_per_stores_state AS (
    SELECT
        stores.store_id,
        COUNT(customers.customer_id) AS nb_customer_state
    FROM
        {{ ref("stg_local_bike_ds_t_stores") }} AS stores
        INNER JOIN {{ ref("stg_local_bike_ds_t_customers") }} AS customers ON customers.state = stores.state
    GROUP BY
        stores.store_id
),

total_order_per_store AS (
    SELECT
        stores.store_id,
        COUNT(DISTINCT orders.order_id) AS nb_orders,
        SUM(orders.amount_with_discount) AS total_amount_store,
        SUM(orders.qty_per_order) AS total_qty_store
    FROM
        {{ ref("stg_local_bike_ds_t_stores") }} AS stores
        LEFT JOIN {{ ref("int_local_bike_ds_orders") }} AS orders ON orders.store_id = stores.store_id

    GROUP BY
        stores.store_id
)

SELECT
    stores.store_id,
    stores.store_name,
    stores.phone,
    stores.email,
    stores.street,
    stores.city,
    stores.state,
    stores.zip_code,
    customer_store.nb_customer_state,
    tot_ord_store.nb_orders,
    tot_ord_store.total_amount_store,
    tot_ord_store.total_qty_store

FROM
    {{ ref("stg_local_bike_ds_t_stores") }} AS stores
    LEFT JOIN customer_per_stores_state AS customer_store ON customer_store.store_id = stores.store_id
    LEFT JOIN total_order_per_store AS tot_ord_store ON tot_ord_store.store_id = stores.store_id