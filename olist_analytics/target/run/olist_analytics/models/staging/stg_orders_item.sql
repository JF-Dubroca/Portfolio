
  
    

    create or replace table `olist-e-commerce-analytics-jfd`.`staging`.`stg_orders_item`
      
    
    

    
    OPTIONS()
    as (
      

-- read raw tabel
WITH raw_orders_item AS (
    SELECT * 
    FROM `olist-e-commerce-analytics-jfd`.`raw`.`orders_item`
), 
-- cleaned table creation with cleaning
cleaned_orders_item AS (
    SELECT 
        CAST(order_id AS STRING) AS order_id, 
        CAST(order_item_id AS INT64) AS order_item_id, 
        CAST(product_id AS STRING) AS product_id, 
        CAST(seller_id AS STRING) AS seller_id, 
        CAST(shipping_limit_date AS TIMESTAMP) AS shipping_limit_date, 
        CAST(price AS FLOAT64) AS price,
        CAST(freight_value AS FLOAT64) AS freight_value
    FROM raw_orders_item
    WHERE price > 0                 -- Positive price
        AND freight_value >= 0      -- Positive freight value
)

SELECT * FROM cleaned_orders_item
    );
  