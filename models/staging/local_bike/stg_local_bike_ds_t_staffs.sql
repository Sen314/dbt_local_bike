SELECT
    staff_id,
    first_name,
    last_name,
    email,
    phone,
    active,
    store_id,
    CASE 
        WHEN manager_id != 'NULL'
            THEN CAST(manager_id AS int)
            ELSE 0
    END AS manager_id
FROM
    {{source("local_bike_ds", "t_staffs")}}