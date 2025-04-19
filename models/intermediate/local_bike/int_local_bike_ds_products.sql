WITH product_availability_per_store AS (
    SELECT
        pdt.product_id,
        stocks.store_id,
        SUM(stocks.quantity) AS product_availability_per_store
    FROM
        {{ ref("stg_local_bike_ds_t_products") }} AS pdt
        INNER JOIN {{ ref("stg_local_bike_ds_t_stocks") }} AS stocks on stocks.product_id = pdt.product_id
    GROUP BY
        pdt.product_id,
        stocks.store_id
)

SELECT
    pdt.product_id,
    pdt.brand_id,
    paps.store_id,
    paps.product_availability_per_store
FROM
    {{ ref("stg_local_bike_ds_t_products") }} AS pdt
    LEFT JOIN product_availability_per_store AS paps ON paps.product_id = pdt.product_id