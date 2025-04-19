SELECT
    brand.brand_id,
    brand.brand_name
FROM 
    {{ ref("stg_local_bike_ds_t_brand")}} AS brand