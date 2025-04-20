select
    stocks.product_id,
    pdt.brand_id,
    pdt.product_name,
    pdt.category_id,
    pdt.model_year,
    pdt.list_price,
    pdt.nb_product_stocked,
    {{
        dbt_utils.pivot(
            "store_name",
            dbt_utils.get_column_values(ref("int_local_bike_ds_stocks"), "store_name"),
            then_value="quantity",
        )
    }}
from {{ ref("int_local_bike_ds_stocks") }} AS stocks
INNER JOIN {{ ref("int_local_bike_ds_products")}} AS pdt ON pdt.product_id = stocks.product_id
group by 
    stocks.product_id,
    pdt.brand_id,
    pdt.product_name,
    pdt.category_id,
    pdt.model_year,
    pdt.list_price,
    pdt.nb_product_stocked

