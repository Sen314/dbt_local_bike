{% docs mrt_local_bike_ds_customer_orders %}

This model provides a list of customer with their favorite product, the total amount spent, how many items they bought, the number of different item they bought and the total order 
- **favorite_product_id**: The customer favorite product.
- **Total_Amount_Spent**: The amount spent across all stores.
- **total_items**: The quantity of items bought across all stores.
- **total_distinct_items**: The distinct products bought.
- **total_orders**: The nuber of order made by this customer.

{% enddocs %}

{% docs mrt_local_bike_ds_order_monthly_report %}

This model provides a report of order per month by seller and stores

{% enddocs %}

{% docs mrt_local_bike_ds_product_stores %}

This model provides a list of products, the global quantity stored across all stores and for each stores
the column after **nb_product_stocked** are the stores name which will update automatically if more store are added in t_stores

{% enddocs %}

{% docs mrt_local_bike_ds_stores_orders %}

This model provides a report of stores and their sales figures per year
- **nb_orders**: The total number of order for a specific store.
- **total_qty_store**: The quantity of items sold by a specific store.
- **total_amount_store**: The Sales revenue across all years for a store.
- the columns following those are the sales revenu per years

{% enddocs %}