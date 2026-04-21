{{ config(materialized = 'table')}}

SELECT 
    o.customer_id,
    COUNT(DISTINCT(o.order_id)) AS order_number,
    COALESCE(SUM(oi.price), 0) AS total_spent,
    MIN(o.order_purchase_timestamp) AS first_order,
    MAX(o.order_purchase_timestamp) AS last_order
FROM {{ ref('stg_orders') }} AS o
LEFT JOIN {{ ref('stg_orders_item') }} AS oi 
    ON o.order_id = oi.order_id 
GROUP BY o.customer_id