-- lines count
SELECT COUNT(*) FROM {{source('raw', 'orders_item')}} ;
-- 112650 lines


-- Looking for order_item_id values
SELECT DISTINCT order_item_id
FROM {{ source('raw', 'orders_item') }} 
;
-- Numbers from 1 to 21

-- Looking for min and max shipping_limit_date
SELECT 
    MIN(shipping_limit_date) AS min_shipping_limit_date,
    MAX(shipping_limit_date) AS max_shipping_limit_date
FROM {{source('raw', 'orders_item')}}
;
-- Min shipping_limit_date: 19-09-2016  MAX shipping_limit_date: 09-04-2020

--Looking for price and freight_value values
SELECT 
    MIN(price) AS min_price, 
    MAX(price) AS max_price, 
    MIN(freight_value) AS min_freight_value, 
    MAX(freight_value) AS max_freight_value
FROM {{source('raw', 'orders_item')}}
;
-- min_price = 0.85, max_price = 6735, min_freight_value = 0, max_freight_value = 409.68
-- These values are not aberrant

-- Primary key research
SELECT
    COUNT (*) AS total_raw,
    COUNT(DISTINCT(order_id)) AS order_id_count, 
    COUNT(DISTINCT(order_item_id)) AS order_item_id_count,
    COUNT(DISTINCT(product_id)) AS product_id_count, 
    COUNT(DISTINCT STRUCT(order_id, order_item_id)) AS item_key, 
    COUNT(DISTINCT STRUCT(order_id, product_id)) AS product_key
FROM {{source('raw', 'orders_item')}}
;
-- Primary key: order_id, order_item_id

-- Duplicates search
SELECT 
    *,
    COUNT(*) AS count
FROM {{ source('raw', 'orders_item')}}
GROUP BY ALL
HAVING count > 1
;
-- 0 duplicates detected

-- Null values search
SELECT 
    COUNTIF(order_id IS NULL) AS order_id_null,
    COUNTIF(order_item_id IS NULL) AS order_id_item_null,
    COUNTIF(product_id IS NULL) AS product_id_null,
    COUNTIF(seller_id IS NULL) AS seller_id_null,
    COUNTIF(shipping_limit_date IS NULL) AS shipping_limit_date_null,
    COUNTIF(price IS NULL) AS price_null,
    COUNTIF(freight_value IS NULL) AS freight_value_null
FROM {{ source('raw', 'orders_item')}}
;
