WITH total_order_per_store AS (
    SELECT
        orders.store_id,
        COUNT(DISTINCT orders.order_id) AS nb_orders,
        SUM(orders.amount_with_discount) AS total_amount_store,
        SUM(orders.qty_per_order) AS total_qty_store
    FROM
        {{ ref("int_local_bike_ds_orders") }} AS orders
    GROUP BY
        orders.store_id
),

pivot_orders_store_yearly AS(
    SELECT
        order_store_id,
        {{
            dbt_utils.pivot(
                "reporting_date",
                dbt_utils.get_column_values(ref("int_local_bike_ds_orders_store_yearly"), "reporting_date"),
                then_value="total_amount_store",
            )
        }}
    FROM
        {{ ref("int_local_bike_ds_orders_store_yearly") }} AS stores
    GROUP BY
        order_store_id
    )

SELECT
    stores.store_id,
    stores.store_name,
    stores.phone,
    stores.email,
    stores.street,
    stores.city,
    stores.state,
    stores.zip_code,
    stores.nb_customer_state,
    tot_ord_store.nb_orders,
    tot_ord_store.total_qty_store,
    ROUND(tot_ord_store.total_amount_store, 2) AS total_amount_store,
    sales_yearly.*
FROM
    {{ ref("int_local_bike_ds_stores") }} AS stores
    LEFT JOIN total_order_per_store AS tot_ord_store ON tot_ord_store.store_id = stores.store_id
    LEFT JOIN pivot_orders_store_yearly AS sales_yearly ON sales_yearly.order_store_id = stores.store_id


