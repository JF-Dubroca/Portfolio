{{ config (materialized = 'table')}}

-- Calculation of total price, number of items, total freight value and total seller per order
WITH order_aggregate AS(
    SELECT 
        order_id,
        SUM(price) AS total_price, 
        COUNT(order_item_id) AS nb_item, 
        SUM(freight_value) AS total_freight_value, 
        COUNT(DISTINCT(seller_id)) AS total_seller
    FROM {{ ref('stg_orders_item')}}
    GROUP BY order_id
)


-- Creation of the intermediate order table enriched
SELECT 
    o.order_id,
    o.order_status,
    o.order_purchase_timestamp, 
    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    o.customer_id, 
    oa.total_price,
    oa.nb_item,
    oa.total_freight_value,
    oa.total_seller,
    r.review_score
FROM {{ ref('stg_orders') }} AS o
LEFT JOIN order_aggregate AS oa
    ON o.order_id = oa.order_id
LEFT JOIN  {{ ref('stg_reviews') }} AS r
    ON o.order_id = r.order_id