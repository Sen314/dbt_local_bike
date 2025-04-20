WITH orders_per_customer AS (
SELECT 
    orders.customer_id,
    SUM(orders.amount_without_discount - discount_amount) AS total_amount_spent,
    SUM(orders.qty_per_order) as total_items,
    SUM(orders.nb_distinct_product) as total_distinct_items,
    COUNT(DISTINCT order_id) AS total_orders
FROM {{ref('int_local_bike_ds_orders')}} AS orders
GROUP BY
    orders.customer_id
)

SELECT
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    customer.phone,
    customer.email,
    customer.street,
    customer.city,
    customer.state,
    customer.zip_code,
    customer.favorite_product_id,
    ROUND(orders_customer.total_amount_spent,2) AS Total_Amount_Spent,
    orders_customer.total_items,
    orders_customer.total_distinct_items,
    orders_customer.total_orders
FROM
    {{ref("int_local_bike_ds_customers")}} AS customer
    LEFT JOIN orders_per_customer AS orders_customer ON orders_customer.customer_id = customer.customer_id