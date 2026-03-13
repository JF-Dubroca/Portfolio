-- lines count
SELECT COUNT(*) FROM {{source('raw', 'orders_item')}}
-- 112650 lines


-- Looking for order_item_id values
SELECT DISTINCT(order_item_id)
FROM {{ source('raw', 'orders_item') }}
-- Numbers from 1 to 21

-- Looking for min and max shipping_limit_date
SELECT 
    MIN(shipping_limit_date) AS min_shipping_limit_date,
    MAX(shipping_limit_date) AS max_shipping_limit_date
FROM {{source('raw', 'orders_item')}}
-- Min shipping_limit_date: 19-09-2026  MAX shipping_limit_date: 09-04-2020

--Looking for price and freight_value values
SELECT 
    MIN(price) AS min_price, 
    MAX(price) AS max_price, 
    MIN(freight_value) AS min_freight_value, 
    MAX(freight_value) AS max_freight_value
FROM {{source('raw', 'orders_item')}}
-- min_price = 0.85, max_price = 6735, min_freight_value = 0, max_freight_value = 409.68

-- Primary key research
SELECT
    COUNT (*),
    COUNT(DISTINCT(order_id)) AS order_id_count, 
    COUNT(DISTINCT(order_item_id)) AS order_item_id_count,
    COUNT(DISTINCT(product_id)) AS product_id_count, 
    COUNT(DISTINCT(order_id, order_item_id)) AS item_key, 
    COUNT(DISTINCT(order_id, product_id)) AS product_key
FROM {{source('raw', 'orders_item_id')}}
-- Primary key: order_id, order_item_id

-- Duplicates search
SElECT 
    MIN(shipping_limit_date) AS min, 
    MAX(shipping_limit_date) AS max
FROM {{source('raw', 'orders_item')}}
-- 0 duplicates detected