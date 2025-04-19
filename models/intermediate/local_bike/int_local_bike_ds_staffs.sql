WITH order_per_staff AS (
    SELECT 
        orders.staff_id,
        COUNT(orders.order_id) AS nb_orders
    FROM 
        {{ref("stg_local_bike_ds_t_orders")}} AS orders
    GROUP BY
        orders.staff_id
)

SELECT
    staff.staff_id,
    staff.first_name,
    staff.last_name,
    staff.email,
    staff.phone,
    staff.active,
    staff.store_id,
    staff.manager_id,
    ord_staff.nb_orders,
    manager.flag_manager
FROM
    {{ref("stg_local_bike_ds_t_staffs")}} AS staff
    LEFT JOIN order_per_staff AS ord_staff ON ord_staff.staff_id = staff.staff_id
    LEFT JOIN (SELECT 
                    1 as flag_manager, 
                    sub_manager.manager_id 
                FROM 
                    {{ref("stg_local_bike_ds_t_staffs")}} AS sub_manager
                GROUP BY
                    sub_manager.manager_id) 
                AS manager ON manager.manager_id = staff.staff_id