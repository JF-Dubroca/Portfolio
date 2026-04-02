SELECT *
FROM {{ ref('stg_orders')}}
WHERE 
        order_approved_at IS NOT NULL AND order_approved_at > order_purchase_timestamp
        OR order_delivered_carrier_date IS NOT NULL AND order_delivered_carrier_date < order_purchase_timestamp
        OR order_delivered_customer_date IS NOT NULL AND order_delivered_customer_date < order_purchase_timestamp
        OR order_estimated_delivery_date IS NOT NULL AND order_estimated_delivery_date < order_purchase_timestamp
        OR order_estimated_delivery_date IS NOT NULL AND DATETIME_DIFF(order_estimated_delivery_date, order_purchase_timestamp, "day") > 60