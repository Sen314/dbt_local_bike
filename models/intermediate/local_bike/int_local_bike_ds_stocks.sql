SELECT
    stores.store_name,
    pdt.product_name,
    quantity
FROM
    {{source("local_bike_ds", "t_stocks")}} AS stocks
    INNER JOIN {{source("local_bike_ds", "t_products")}} AS pdt ON pdt.product_id = stocks.product_id
    INNER JOIN {{source("local_bike_ds", "t_stores")}} AS stores ON stores.store_id = stocks.store_id