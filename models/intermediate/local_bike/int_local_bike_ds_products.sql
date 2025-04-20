WITH product_stocks AS (
    SELECT
        stocks.product_id,
        SUM(stocks.quantity) AS nb_product_stocked
    FROM
        {{ ref("stg_local_bike_ds_t_stocks") }} AS stocks
    GROUP BY
        stocks.product_id
)

SELECT
    pdt.product_id,
    pdt.brand_id,
    pdt.product_name,
    pdt.category_id,
    pdt.model_year,
    pdt.list_price,
    pdt.partition_date,
    paps.nb_product_stocked
FROM
    {{ ref("stg_local_bike_ds_t_products") }} AS pdt
    LEFT JOIN product_stocks AS paps ON paps.product_id = pdt.product_id