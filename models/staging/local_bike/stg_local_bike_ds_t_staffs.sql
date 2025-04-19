SELECT
    staff_id,
    first_name,
    last_name,
    email,
    phone,
    active,
    store_id,
    manager_id
FROM
    {{source("local_bike_ds", "t_staffs")}}