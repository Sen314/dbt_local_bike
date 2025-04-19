WITH product_category AS (
    SELECT
        products.category_id,
        COUNT(DISTINCT products.product_id) AS nb_product,
        SUM(stocks.quantity) AS qty_stocked
    FROM {{ref('stg_local_bike_ds_t_products')}} AS products
    LEFT JOIN {{ref('stg_local_bike_ds_t_stocks')}} AS stocks ON stocks.product_id = products.product_id
    GROUP BY
        products.category_id
)

SELECT
    category.category_id,
    category.category_name,
    product_category.nb_product,
    product_category.qty_stocked
FROM
    {{ref("stg_local_bike_ds_t_categories")}} AS category
    LEFT JOIN product_category ON product_category.category_id = category.category_id