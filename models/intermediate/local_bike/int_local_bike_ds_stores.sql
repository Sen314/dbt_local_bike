WITH customer_per_stores_state AS (
    SELECT
        stores.store_id,
        COUNT(customers.customer_id) AS nb_customer_state
    FROM
        {{ ref("stg_local_bike_ds_t_stores") }} AS stores
        INNER JOIN {{ ref("stg_local_bike_ds_t_customers") }} AS customers ON customers.state = stores.state
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
    customer_store.nb_customer_state
FROM
    {{ ref("stg_local_bike_ds_t_stores") }} AS stores
    LEFT JOIN customer_per_stores_state AS customer_store ON customer_store.store_id = stores.store_id