{% macro calcul_sum_order_discount(price, quantity, discount) %}
    ({{ price }} * {{ quantity }} ) * discount 
{% endmacro%}