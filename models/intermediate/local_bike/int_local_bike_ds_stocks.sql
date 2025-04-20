SELECT
    stores.store_name,
    stocks.product_id,
    quantity
FROM
    {{ ref("stg_local_bike_ds_t_stocks") }} AS stocks
    INNER JOIN {{ ref("stg_local_bike_ds_t_stores") }} AS stores ON stores.store_id = stocks.store_id