
  
    

    create or replace table `olist-e-commerce-analytics-jfd`.`staging`.`stg_orders`
      
    
    

    
    OPTIONS()
    as (
      

WITH raw_orders AS(
    SELECT *
    FROM `olist-e-commerce-analytics-jfd`.`raw`.`orders_dataset`
), 
cleaned_orders AS(
    SELECT 
        CAST(TRIM(order_id) AS STRING) AS order_id, 
        CAST(TRIM(customer_id) AS STRING) AS customer_id, 
        CAST(TRIM(order_status) AS STRING) AS order_status, 
        CAST(order_purchase_timestamp AS TIMESTAMP) AS order_purchase_timestamp, 
        CAST(order_approved_at AS TIMESTAMP) AS order_approved_at, 
        CAST(order_delivered_carrier_date AS TIMESTAMP) AS order_delivered_carrier_date, 
        CAST(order_delivered_customer_date AS TIMESTAMP) AS order_delivered_customer_date, 
        CAST(order_estimated_delivery_date AS TIMESTAMP) AS order_estimated_delivery_date
    FROM raw_orders
    )

SELECT * FROM cleaned_orders
    );
  