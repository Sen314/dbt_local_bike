SELECT
    category_id,
    category_name
FROM
    {{source('local_bike_ds','t_categories')}}