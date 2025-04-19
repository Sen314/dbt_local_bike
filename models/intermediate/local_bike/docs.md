{% docs int_local_bike_ds_brands %}

Act as an interface to staging modles for mart models

{% enddocs %}

{% docs int_local_bike_ds_categories %}

This model contains a detailed view of categories with number of product per category and the total stocked across all stores:
- **nb_product**: The distinct number of product per category.
- **qty_stocked**: The quantity of product from a specific category stored across all stores.

{% enddocs %}

{% docs int_local_bike_ds_customers %}

This model contains a aggregated view of customer with their favorite ordered product, the total amount spent / total items ordered / total orders across all stores and the distinct number of product ordered
- **favorite_product_id**: The product most frequently purchased by the customer, based on the quantity of items ordered.
- **total_amount_spent**: The total amount spent by the customer.
- **total_items**: The total quantity of items purchased by the customer across all orders.
- **total_distinct_items**:  The count of distinct product purchased by the customer.
- **total_orders**: The total number of order place by the customer.

{% enddocs %}

{% docs int_local_bike_ds_order_items %}

Act as an interface to staging models for mart models

{% enddocs %}

{% docs int_local_bike_ds_orders %}

This model provides an aggregated view of orders :
- **nb_distinct_product**: The count of distinct product per order.
- **amount_without_discount**: The order total amount before discount.
- **discount_amount**: The discount amount on the order.
- **qty_per_order**: The Quantity of item ordered on a specific order.
- **amount_with_discount**: The order total after applying the discount.

{% enddocs %}

{% docs int_local_bike_ds_products %}

This model provides a view of product with their quantity stocked:
- **nb_product_stocked**: The number of product stocked across all stores.

{% enddocs %}

{% docs int_local_bike_ds_staffs %}

This model provides a view of employee across all stores:
- **nb_orders**: The number of orders processed by the employee.
- **flag_manager**: Boolean value indicating whether the employee is a manager.

{% enddocs %}

{% docs int_local_bike_ds_stores %}

This model provides a view of employee across all stores:
- **nb_customer_state**: The number of known customer in the same state as the stores.
- **nb_orders**: The number of orders for a specific store.
- **total_amount_store**: The total amount of order after discount for a specific store.
- **total_qty_store**: The number of product sold per store.

{% enddocs %}
